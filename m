From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 May 2017 11:55:35 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170516095027.GZ22219@n2100.armlinux.org.uk>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
 <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
 <20170516095027.GZ22219@n2100.armlinux.org.uk>
Message-ID: <20170516115535.2faf86ec@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 May 2017 10:50:27 +0100, Russell King - ARM Linux wrote:

> I can't see how you can say that when the branch contains support for
> SDHCI and ethernet.  It obviously will collide, since it conflicts with
> the changes I have.

Correct, but Marcin has submitted patches, and you haven't.

> > The board is starting to get really popular and a lot has been happening
> > around it recently - missing bits like 'chosen' node or the interfaces
> > is pretty annoying.  
> 
> Given that features like SDHCI and basic ethernet support have only just
> been merged during the merge window, how about giving those who are
> supporting the platform some time to organise their trees and get patches
> out there, rather than cutting across those who have put considerable
> effort into the platform already, or working with those who have.

I believe if you say that, it's because you don't know how much work
Marcin is doing behind the scenes on supporting Marvell platforms, and
not only at the Linux kernel level.

And it's difficult to buy your argument here, because Marcin is
*precisely* supporting the platform by sending useful patches.

> The whole Armada 8k support is all very new, and there's still lots of
> fundamental bits that are missing - pinmux and gpio are the two biggest
> ones.
> 
> I've already put effort into cleaning up the mvebu pinmux code (already
> merged) so that we can cleanly merge the pinmux support, but both of
> these are a sticking point with free-electrons - they have a view on
> how it should be represented in DT which does not fit with the current
> orion-gpio usage, nor with the "system controller" being in drivers/clk.

Gr?gory Clement has been working on this, and he has a patch series
almost ready to submission.

> The code which I have in my tree is correct for the Armada 8k hardware
> (which has some weirdness about which gpios on each CP110 appear to the
> external world - some are used for inter-CP110 communication and must
> not be exposed) so any additional work should be based on the code in
> my tree.

No, there is no rule like this in the kernel community. Whatever is in
your private tree does not matter. Until it gets submitted, it doesn't
exist, and nobody is forced to base its work on top of your
unknown/private trees.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
