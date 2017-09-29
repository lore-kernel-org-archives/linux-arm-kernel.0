From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Sep 2017 10:33:37 +0200
Subject: [PATCH 2/7] regulator: axp20x: Add support for AXP813 regulators
In-Reply-To: <20170929032514.31727-3-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
 <20170929032514.31727-3-wens@csie.org>
Message-ID: <20170929083337.fv7ed5utnofqgsi4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 03:25:09AM +0000, Chen-Yu Tsai wrote:
> The AXP813 PMIC has 7 DC-DC buck regulators, 16 LDOs (including the
> fixed RTC LDO and 2 GPIO LDOs), and 1 switchable. The drive-vbus
> feature is also supported. All the hardware details are very similar
> to the AXP803, with the following exceptions:
> 
>   - Extra DCDC7 buck regulator, with the same range as DCDC6
> 
>   - SWitch now has a separate supply pin, instead of being chained
>     internaly from DCDC1
> 
>   - RTC LDO output voltage is now 1.8V
> 
>   - FLDO3 is an LDO with switchable supplies, but unconfigurable output
>     voltage. The voltage is always half that of its supply.
> 
> Support for FLDO3 is currently unimplemented, as it requires runtime
> switching of its supplies, something the regulator subsystem does not
> support. It is not used in either the reference designs nor actually
> produced boards available.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/64b124a8/attachment.sig>
