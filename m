From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Nov 2018 14:12:41 -0800
Subject: Regression in next with spi return from transfer_one()
In-Reply-To: <20181115211451.GH53235@atomide.com>
References: <20181115211451.GH53235@atomide.com>
Message-ID: <20181115221241.GQ2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 01:14:51PM -0800, Tony Lindgren wrote:

> Commit 810923f3bf06 ("spi: Deal with slaves that return from
> transfer_one() unfinished") causes a regression at least on
> droid 4 with SPI PMIC and regulators on the PMIC. During boot
> the device just hangs there waiting for rootfs to appear on
> MMC. Reverting 810923f3bf06 makes things work again.

> Any ideas why this might be?

Wow, that's not obvious...  as far as I can tell the code in the !slave
case is identical so unless the controller is somehow getting mistakenly
flagged as a slave it looks like it should be something to do with it
being pushed into a function.  Could you try logging what the timeout
ends up getting set to?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/dbd71646/attachment.sig>
