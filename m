From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 14:05:51 +0200
Subject: [PATCH v2 1/4] phy: phy-stih407-usb: Add usb picoPHY driver found
 on stih407 SoC family
In-Reply-To: <1706244.K6iQdujHby@amdc1032>
References: <1410253218-18318-1-git-send-email-peter.griffin@linaro.org>
 <1410253218-18318-2-git-send-email-peter.griffin@linaro.org>
 <1706244.K6iQdujHby@amdc1032>
Message-ID: <2931258.khlMVogpQg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 13:52:54 Bartlomiej Zolnierkiewicz wrote:
> I believe that this should use
> 
>         select GENERIC_PHY
> 
> instead (just like all other PHY drivers except PHY_MIPHY365X which
> also should be fixed to use select).

Right. It would also be good to change 'depends on ARCH_STI'
into 'depends on ARCH_STI || COMPILE_TEST', but only if it
actually compiles on x86.

Note that currently both providers and users of the PHY API
use 'select GENERIC_PHY', which probably not what we want:
only providers (like this one) should 'select' it, while
drivers using this interface could either 'depends on
GENERIC_PHY' or leave out the Kconfig dependency entirely.

Adding 'depends on' for drivers using the interface might
be cleaner, but can result in dependency loops.

	Arnd
