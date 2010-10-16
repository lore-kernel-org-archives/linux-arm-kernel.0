From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 16 Oct 2010 13:39:49 +1100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009000046.GA30616@kroah.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
Message-ID: <1287196789.2370.3.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-10-08 at 17:00 -0700, Greg KH wrote:
> 
> But you can't expect that you make this change, and not fix up the
> drivers, and people would be happy, right?  The rule for API changes
> like this, or anything, is that the person making the change fixes the
> other drivers, and that seems to be the issue here.
> 
> Any pointers to patches where people have fixed up the drivers?

Greg, this is true for normal API changes. In this case, this is silent
data corruption, I think Russell is absolutely right. That exact same
issues have been giving me nightmares on powerpc, mostly due to
(fortunately extremely rare) broken chipsets doing non coherent DMA on
processors that do not allow you architecturally to double map memory
with different attributes.

Cheers,
Ben.
