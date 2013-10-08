From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 14:16:47 -0400
Subject: [PATCH v2 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <525448DE.5030004@gmail.com>
References: <20131008194232.7d74b9e6@armhf>
 <525448DE.5030004@gmail.com>
Message-ID: <20131008181647.GW5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 08:03:10PM +0200, Sebastian Hesselbarth wrote:
> On 10/08/2013 07:42 PM, Jean-Francois Moine wrote:
> >This patch activates the audio device of the Cubox.
> >
> >The audio flow (pin mpp_audio1) is output on both I2S and S/PDIF.
> >
> >The third si5351 clock (#2, pin mpp13) is used as the external clock.
> >
> >Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> >---
> >  arch/arm/boot/dts/dove-cubox.dts | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
> >index 022646e..bb38a24 100644
> >--- a/arch/arm/boot/dts/dove-cubox.dts
> >+++ b/arch/arm/boot/dts/dove-cubox.dts
> >@@ -132,3 +132,23 @@
> >  		reg = <0>;
> >  	};
> >  };
> >+
> >+&pinctrl {
> >+	pmx_gpio_13_audio1: pmx-gpio-13-audio1 {
> 
> Jean-Francois,
> 
> please name the node "pmx_audio1_extclk: pmx-audio1-extclk"
> and move both to the corresponding section in dove.dtsi.
> We can reuse them on other Dove boards for sure.
> 
> >+		marvell,pins = "mpp13";
> >+		marvell,function = "audio1";
> >+	};
> >+
> >+	pmx_audio1_i2s1_spdifo: pmx-audio1-i2s1-spdifo {
> >+		marvell,pins = "mpp_audio1";
> >+		marvell,function = "i2s1/spdifo";
> >+	};
> >+};
> >+
> >+&audio1 {
> >+	status = "okay";
> >+	clocks = <&gate_clk 13>, <&si5351 2>;
> >+	clock-names = "internal", "extclk";
> >+	pinctrl-0 = <&pmx_audio1_i2s1_spdifo &pmx_gpio_13_audio1>;
> 
> The above needs updated phandles then.
> 
> Otherwise,
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Once you make the above changes, just send a v3 in-reply-to this patch
and I'll pick it up with the other two.

thx,

Jason.

> 
> >+	pinctrl-names = "default";
> >+};
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
