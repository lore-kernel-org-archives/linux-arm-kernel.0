From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 12 Jul 2010 12:34:59 -0700
Subject: ARM defconfig files
In-Reply-To: <alpine.LFD.2.00.1007121510260.10598@xanadu.home>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
Message-ID: <AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>>
>> ? ?Put another way: I realize that fairly late in the -rc series is
>> actually a really good time to do this, rather than during the merge
>> window itself when things are in flux. However, while it would be a
>> good time to pull this for that reason, it's also a _horrible_ time to
>> pull if it then regresses the defconfig uses, or if it causes horrible
>> problems for linux-next merging etc.
>
> This cannot be any worse than wholesale removal of those files as you
> were contemplating at some point. ?Furthermore, on ARM we have someone
> providing automatic rebuild of all defconfigs already, so any serious
> issue should be noticed right away.

You aren't really answering the question. The thing is, the wholesale
removal wouldn't happen during the late -rc anyway, and it wouldn't
cause any merge issues (merge conflicts where the file is just to be
removed are trivial to take care of).

So I'm really asking about the issue of "how does this work during the
late -rc phase". Where the _timing_ is the important thing.

Because I could as easily pull after 2.6.35 is out. That has it's own
downsides (with all the merging going on), but at the same time, it's
clearly the right time for a large change.

So when I ask about timing and "how does this work in late -rc", it's
really about how safe it is to do now. Because if it isn't very
obviously safe, I can't pull it.

One part of the "obviously safe" thing is verification for each
defconfig file that the end result is identical with the reduced
version. Uwe implied that it was, and that was clearly the intention,
but was there some explicit verification that yes, the
before-and-after configurations are 100% the same?

Also, I assume that while it's _mostly_ a transparent change to users,
it does require that people do "make oldconfig" with the reduced
defconfig file first, in order to avoid having to answer with the
defaults. No? And the reduced defconfig files obviously do depend on
the default in the Kconfig files themselves, so it does have that kind
of fairly subtle semantic change that may not be entirely obvious or
easy to notice.

So from a timing standpoint, I just want to be convinced that "late
-rc" really is the right thing. I'm not entirely sure it is, even
though I do see advantages.

> I think Uwe could provide his script and add it to the kernel tree.
> Then all architectures could benefit from it. ?Having the defconfig
> files contain only those options which are different from the defaults
> is certainly more readable, even on x86.

Quite possible. But maintainers would need to be on the lookout of
people actually using the script, and refusing to apply patches that
re-introduce the whole big thing.

I also haven't actually seen the script - I don't think Uwe ever
posted it - so maybe it's some very fragile thing. Hard to judge on no
real information ;^p

               Linus
