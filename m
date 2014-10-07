From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 13:49:02 +0200
Subject: [PATCH v3 4/4] arch: arm: boot: dts: Added correct vendor-prefix
 with device name to compatible property
In-Reply-To: <1412682308-8784-5-git-send-email-darshanapadmadas@gmail.com>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
 <1412682308-8784-5-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <11076749.g7xZQflTCQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 17:15:08 Darshana Padmadas wrote:
>                 /* ALS and Proximity sensor */
>                 isl29028 at 44 {
> -                       compatible = "isil,isl29028";
> +                       compatible = "isl,isl29028";
>                         reg = <0x44>;
>                         interrupt-parent = <&gpio>;
>                         interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
> 

Does this intentionally list only the new string?

If we want compatibility between new dts files and old kernels, this would
need to be 

	compatible = "isl,isl29028", compatible = "isil,isl29028";

I don't know if we want to go that far though, given that this is
only a staging driver.

	Arnd
