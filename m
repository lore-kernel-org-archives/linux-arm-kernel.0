From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Oct 2017 09:18:09 +0200
Subject: [PATCH 0/2] Add a regmap to Allwinner R40 CCU to export GMAC
 register
In-Reply-To: <20171006063333.12345-1-icenowy@aosc.io>
References: <20171006063333.12345-1-icenowy@aosc.io>
Message-ID: <20171009071809.jte47cd2mt4iv6y7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 06:33:31AM +0000, Icenowy Zheng wrote:
> In the CCU of the Allwinner R40 SoC, there's a GMAC configuration register,
> which is intended to be accessed by the dwmac-sun8i driver. On SoCs already
> supported by the driver the register is placed in the syscon rather than
> the CCU.
> 
> As CCU is a critical part of the SoC, so write to it should be strictly
> limited. A regmap with restricted write permission is created by the R40
> CCU driver, and can be get with dev_get_regmap. In order to tie the regmap
> to the CCU device, the R40 CCU is now a platform driver, so a platform
> device is created for it (and then tied with the regmap).
> 
> The first patch does the conversion of the driver to a platform driver,
> and the second patch adds the regmap.

I'd like to see first what you want to do with it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/9c2ae819/attachment-0001.sig>
