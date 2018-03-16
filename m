From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 16 Mar 2018 17:07:28 +0000
Subject: [linux-sunxi] [PATCH v4 4/9] pinctrl: sunxi: add support for the
 Allwinner H6 main pin controller
In-Reply-To: <20180316140215.28663-5-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-5-icenowy@aosc.io>
Message-ID: <a74d898f-7047-eebf-027e-106c40be2b9d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/03/18 14:02, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).
> 
> This commit introduces support for the main pin controller on H6.
> 
> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format. The GPIO functions are dropped, as they're impossible to use --
> except a GPIO&IRQ only pin (PB20) which might be the IRQ of ATE.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>

As mentioned before, I checked every single pin against the manual and
this looks correct to me.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre.
