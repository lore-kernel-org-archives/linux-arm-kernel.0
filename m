From: rabryn@c2development.com (Ryan Bryngelson)
Date: Tue, 16 Apr 2013 22:41:40 -0500
Subject: iMX28 DTS GPIO IRQ Definition
In-Reply-To: <20130417031512.GA3338@S2101-09.ap.freescale.net>
References: <CAGUvELcRFK9vjx3t69ccEfjLanPSnpZmSo83fxQN0yWvbjTX7w@mail.gmail.com>
 <20130417031512.GA3338@S2101-09.ap.freescale.net>
Message-ID: <CAGUvELcukT8Ei13HnrE2rxxkaV3+TW7W+ovP0sd=kGcBOtKgvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> There is an example in arch/arm/boot/dts/imx28-cfa10049.dts.
>
> pca9555: pca9555 at 20 {
>         compatible = "nxp,pca9555";
>         interrupt-parent = <&gpio2>;
>         interrupts = <19 0x2>;
> };
>
> In this example, the device pca9555 uses GPIO2_19 as the IRQ line which
> is high-to-low edge triggered.
>
> Shawn
>
Thanks for the information!  I see what you're referring to.  In the
latest imx28-cfa10049.dts I see the definition looks like this...

pca9555: pca9555 at 20 {
    compatible = "nxp,pca9555";
    interrupt-parent = <&gpio2>;
    interrupts = <19 0x2>;
    gpio-controller;
    #gpio-cells = <2>;
    interrupt-controller;
    #interrupt-cells = <2>;
    reg = <0x20>;
};

I'm learning about the device tree.  Is it correct to say "interrupts"
corresponds to "#interrupt-cells" and "gpios" corresponds to
"gpio-cells"?  If so, why is "gpios" missing from this definition?  I
see that GPIO2_19 is configured to have it's internal pull up enabled
in the hog_pins_cfa10049_pullup node.  What are "hog_pins"?

Thanks again for taking the time to respond.  I've been stuck with
these questions for a couple days now.  I can't seem to find any
resources online to learn about the device tree.

Ryan
