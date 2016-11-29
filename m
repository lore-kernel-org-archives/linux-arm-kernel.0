From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Nov 2016 21:33 +0200
Subject: [PATCH v7 4/8] drm/sunxi: Add DT bindings documentation of
 Allwinner HDMI
In-Reply-To: <20161129202751.e94f72a1b9e2c2fb064e9933@free.fr>
References: <cover.1480414715.git.moinejf@free.fr> <5996605.Gh0PjPIAcn@avalon>
 <20161129202751.e94f72a1b9e2c2fb064e9933@free.fr>
Message-ID: <6356753.Ekaj7GdA0W@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

On Tuesday 29 Nov 2016 20:27:51 Jean-Francois Moine wrote:
> On Tue, 29 Nov 2016 20:46:22 +0200 Laurent Pinchart wrote:
> [snip]
> 
> >> +Example:
> >> +
> >> +	hdmi: hdmi at 01ee0000 {
> >> +		compatible = "allwinner,sun8i-a83t-hdmi";
> >> +		reg = <0x01ee0000 0x20000>;
> >> +		clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI>,
> >> +			 <&ccu CLK_HDMI_DDC>;
> >> +		clock-names = "bus", "clock", "ddc-clock";
> >> +		resets = <&ccu RST_HDMI0>, <&ccu RST_HDMI1>;
> >> +		reset-names = "hdmi0", "hdmi1";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&hdmi_pins_a>;
> >> +		status = "disabled";
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		port at 0 {			/* video */
> >> +			reg = <0>;
> >> +			hdmi_tcon1: endpoint {
> >> +				remote-endpoint = <&tcon1_hdmi>;
> >> +			};
> >> +		};
> >> +		port at 1 {			/* audio */
> >> +			reg = <1>;
> >> +			hdmi_i2s2: endpoint {
> >> +				remote-endpoint = <&i2s2_hdmi>;
> >> +			};
> >> +		};
> > 
> > You need a third port for the HDMI encoder output, connected to an HDMI
> > connector DT node.
> 
> I don't see what you mean. The HDMI device is both the encoder
> and connector (as the TDA998x):

The driver might create both an encoder and a connector, but I very much doubt 
that the "allwinner,sun8i-a83t-hdmi" hardware contains a connector, unless the 
SoC package has an HDMI connector coming out of it :-)

> plane -> DE2 mixer ---> TCON -----> HDMI -----> display device
> ----- plane ------    - CRTC -   - encoder  \
>                                    connector -- (HDMI cable)
>          audio-controller -   - audio-codec /
> 
> > > +	};

-- 
Regards,

Laurent Pinchart
