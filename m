From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Apr 2015 19:29:56 +0200
Subject: [PATCH] ARM: mvebu: Fix the main PLL frequency on Armada 375,
 38x and 39x SoCs
In-Reply-To: <1429538373-31064-1-git-send-email-gregory.clement@free-electrons.com>
References: <1429538373-31064-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150420172956.GZ15807@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 20, 2015 at 03:59:33PM +0200, Gregory CLEMENT wrote:
> Whereas for Armada 370 and XP the main PLL frequency was 2GHz for the
> Armada 375, 38x and 39x, the frequency is 1GHz. When writting support
                                                       ^ writing

> for these last SoCs, there was no offical value for the PLL. Now that
> we have it, this patch fixes it in the device tree.
> 
> This value is currently only used by the NAND driver for the setting
> the NAND timing. Fortunately it is not acutally used: all the mainline
                                         ^ actually

> board with a NAND flash comes with a NAND device tree node using the

  ^ boards                ^ come 

> "marvell,nand-keep-config" property. With this property the timings
> are not modified in the kernel driver and are kept from the botloader.
                                                              ^ bootloader

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150420/ebb59058/attachment.sig>
