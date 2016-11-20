From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 20 Nov 2016 21:30:37 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479586147.10840.0@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch>
 <1479586147.10840.0@smtp.gmail.com>
Message-ID: <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomas,

On Sat, Nov 19, 2016 at 09:09:07PM +0100, tomas.hlavacek at nic.cz wrote:
> On Mon, Nov 14, 2016 at 9:28 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Interrupts don't seem to work very well with the nxp,pca9538. Which
> > is probably why it is disabled by default.
> 
> I was thinking about this issue and I can remember that there was an earlier
> prototype that had a shared interrupt line from PHY (88E1514) and from the
> PCA9538. In this case we needed to specifically disable the interrupt of the
> PHY to release the interrupt line (which needed a hack into PHY driver
> code). The IRQ from PHY is connected as an ordinary input to PCA9538 in
> later board prototype. And the same holds for the production version.

That would explain why I see an "irq but nobody cared" message when
booting the original system.

This isn't the problem I meant though. When adding interrupt-parent =
<&pcawan>; interrupts = <7 IRQ_TYPE_LEVEL_LOW>; to the phy node I get an
error saying that there is no irq domain associated with this device.
 
> Do you have CZ11NIC13 or older board revision?

CZ11NIC12 is indicated on my board.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161120/6ded9bfe/attachment.sig>
