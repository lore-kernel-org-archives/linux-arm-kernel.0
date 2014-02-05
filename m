From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Feb 2014 11:14:00 -0200
Subject: [PATCH 1/3] Phytec phyFLEX-i.MX6 : Added USB_HOST Support
In-Reply-To: <1391488493-30662-1-git-send-email-ashutosh.s@phytec.in>
References: <1391488493-30662-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <CAOMZO5DKx1uWT568t9TAy48Uf6ufpa1sSznaifDG_=+hLh8mqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 2:34 AM, Ashutosh singh <ashutosh.s@phytec.in> wrote:

> +
> +       reg_usb_h1_vbus: regulator at 1 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_h1_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio1 0 0>;
> +               enable-active-low;

You should remove this 'enable-active-low' as this is not a valid property.

By default the gpio is active low according to
Documentation/devicetree/bindings/regulator/gpio-regulator.txt

Regards,

Fabio Estevam
