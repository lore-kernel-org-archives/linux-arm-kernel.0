From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Aug 2014 18:11:53 +0200
Subject: [PATCH v4 2/5] ARM: tegra: Add legacy interrupt controller nodes
In-Reply-To: <1409239879-12376-2-git-send-email-thierry.reding@gmail.com>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <1409239879-12376-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <4707330.BNuO2MquVF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 17:31:16 Thierry Reding wrote:
> +       interrupt-controller at 60004000 {
> +               compatible = "nvidia,tegra114-ictlr", "nvidia,tegra30-ictlr";
> +               reg = <0x60004000 0x40>, /* primary controller */
> +                     <0x60004100 0x40>, /* secondary controller */
> +                     <0x60004200 0x40>, /* tertiary controller */
> +                     <0x60004300 0x40>, /* quaternary controller */
> +                     <0x60004400 0x40>; /* quinary controller */
> +       };
> +
>         timer at 60005000 {
>                 compatible = "nvidia,tegra114-timer", "nvidia,tegra20-timer";
> 

Don't you need an interrupt-parent and interrupts property here to point to
the GIC interrupts? I would assume this is a nested irqchip.

	Arnd
