From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Dec 2015 07:44:56 -0800
Subject: [PATCH 5/6] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
In-Reply-To: <1450868319-20513-6-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-6-git-send-email-contact@paulk.fr>
Message-ID: <20151223154455.GL2793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Kocialkowski <contact@paulk.fr> [151223 03:00]:
> The LG Optimus Black (P970) codename sniper is a smartphone that was designed
> and manufactured by LG Electronics (LGE) and released back in 2011.
> It is using an OMAP3630 SoC, GP version.
> 
> This adds devicetree support for the device, with only a few basic features
> supported, such as debug uart, i2c, internal emmc and external mmc.

Cool :)

> +&gpio1 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio2 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio3 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio4 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio5 {
> +	ti,no-reset-on-init;
> +};
> +
> +&gpio6 {
> +	ti,no-reset-on-init;
> +};

Care to try to narrow down exactly which GPIO(s) need to be preserved?
Chances are this will unnecessarily block deeper idle states in hardware
otherwise.

My guess is that the GPIO pins that need to be preserved if any are in
the GPIO bank 1 as that's always powered..

Regards,

Tony
