From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Oct 2010 18:53:43 -0400 (EDT)
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286800232.19739.96.camel@e102109-lin.cambridge.arm.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
	<1286796187.19739.52.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinHZ-w6=0RvVp39MnvpRC7RW1CYNSbzi2f1OvaQ@mail.gmail.com>
	<1286800232.19739.96.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1010111842130.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Oct 2010, Catalin Marinas wrote:

> It may be just theoretical but architecture licensees implement the
> hardware according to the ARM ARM. If it says "unpredictable", they
> don't need to care much about this scenario as it is not allowed in
> software and the hardware can be further optimised (well, I think
> "unpredictable" doesn't allow hardware deadlocking or security
> implications, so the memory corruption cannot be that random, possibly
> just restricted to that memory range). It is probably ok on current
> hardware but I cannot guarantee, you would have to check on a
> case-by-case basis (CPU implementation).

I've seen real designs where "security implications" was interpreted 
rather liberally by the hardware people, and not exactly in the same way 
as software people do.


Nicolas
