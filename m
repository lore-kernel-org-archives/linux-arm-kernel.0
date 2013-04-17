From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Apr 2013 11:15:15 +0800
Subject: iMX28 DTS GPIO IRQ Definition
In-Reply-To: <CAGUvELcRFK9vjx3t69ccEfjLanPSnpZmSo83fxQN0yWvbjTX7w@mail.gmail.com>
References: <CAGUvELcRFK9vjx3t69ccEfjLanPSnpZmSo83fxQN0yWvbjTX7w@mail.gmail.com>
Message-ID: <20130417031512.GA3338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 11:47:57AM -0500, Ryan Bryngelson wrote:
> I don't see how I should define a node in the imx28-evk.dts that
> defines a GPIO that is an IRQ.  The "interrupts" in the dtsi file, 127
> in the example above, refer to the IRQ source in the ICOLL.  Where are
> the definitions of the interrupt-cells and gpio-cells at that are
> described in the gpio-mxs.txt documentation?

There is an example in arch/arm/boot/dts/imx28-cfa10049.dts.

pca9555: pca9555 at 20 {
	compatible = "nxp,pca9555";
	interrupt-parent = <&gpio2>;
	interrupts = <19 0x2>;
};

In this example, the device pca9555 uses GPIO2_19 as the IRQ line which
is high-to-low edge triggered.

Shawn
