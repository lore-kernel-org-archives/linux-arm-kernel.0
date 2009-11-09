From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 9 Nov 2009 19:08:52 +0000
Subject: [PATCH] Use definition for cmpxchg swi
In-Reply-To: <20091109173040.GA24358@n2100.arm.linux.org.uk>
References: <20091108200459.GA32760@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911082033580.16711@xanadu.home>
	<20091109085137.GA14453@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911090953010.16711@xanadu.home>
	<20091109173040.GA24358@n2100.arm.linux.org.uk>
Message-ID: <20091109190852.GD3808@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> I'll add a comment then.
> 
> Note, however, that the original code was buggy - it resulted in
> the '0xfff0' syscall being called instead of '0xffff0' - note the
> extra 4 bits there.

Meaning that nobody has ever actually used the original code? :-)

I notice that it loads the syscall number register for EABI
compatibility, but that instruction could be trivially omitted with
OABI-compatible kernels, couldn't it?

By the way, did you change it to LDR to make it faster?  (I.e. does
that make it faster?)

-- Jamie
