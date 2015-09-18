From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 18 Sep 2015 19:35:49 +0200
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <1442593745-16725-3-git-send-email-tony@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
Message-ID: <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

[snip]

>
> +       vmmcsdio_fixed: fixedregulator-mmcsdio {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vmmcsdio_fixed";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               gpio = <&gpio5 12 GPIO_ACTIVE_HIGH>;    /* gpio140 WLAN_EN */

I know that other OMAP boards use a fake fixed regulator to toggle the
WiFi enable pin but now the MMC subsystem has proper support for power
sequence providers so that should be used instead. For simple uses
like this, Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
should be enough.

Best regards,
Javier
