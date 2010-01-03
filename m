From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jan 2010 16:44:14 +0000
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<20100103160313.GA21156@n2100.arm.linux.org.uk>
	<daef60381001030830u176c0cfavbb31358a2b42ed60@mail.gmail.com>
Message-ID: <20100103164414.GB21156@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 12:30:20AM +0800, Hui Zhu wrote:
> This S2C: message just for program s2c.
> s2c can convert it to a core file.  Then gdb can do a clear analyse
> with this file.
> Then you can get more message than current we can get.

I understand that.  What I'm saying is that all the additional noise
you're causing the kernel to create is just a pure duplication of
what we already dump.

Oops dumps are already noisy enough - especially if they cause a panic
at the end (where you end up with two backtraces.)  We do not need even
more noise caused by needless duplication.

You can get everything you need already from the kernel.  On ARM, we
already dump out all the registers and the _full_ stack.  There is no
need for you to implement your own register dumping code and full stack
dump on top of that again.

So, I'm not going to accept your patch for the ARM kernel.  Please use
what's already provided - it's more than adequate.  By doing so, you
don't penalise those of us who want to read the raw oopses.

Talking about noisy oopses, I'm getting one with 2.6.33-rc2 on 'poweroff'
shutdown.  No idea what it is because most of it's scrolled off the top of
the screen and I can't scroll back.  Not bothered about it at the moment.
What it does illustrate though is why making things too noisy when problems
occur makes it _more_ difficult to find out what went wrong.
