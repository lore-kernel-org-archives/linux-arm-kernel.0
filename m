From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 10 Feb 2014 17:00:46 +0100
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <20140210151821.GY26684@n2100.arm.linux.org.uk>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
 <1392045139.6687.31.camel@pizza.hi.pengutronix.de>
 <20140210151821.GY26684@n2100.arm.linux.org.uk>
Message-ID: <20140210170046.03f3c498@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Feb 2014 15:18:21 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Now, mind explaining what "v4l2 style device tree bindings" means?  I've
> no idea since I'm relatively new to DT.

Documentation/devicetree/bindings/media/video-interfaces.txt

For the Cubox, I have:

	tda998x: hdmi-encoder {
		compatible = "nxp,tda998x";
		...
		port {
			tda998x_0: endpoint at 0 {
				remote-endpoint = <&lcd0_0>;
			};
		};
	};

&lcd0 {
	status = "okay";
	...
	port {
		lcd0_0: endpoint at 0 {
			remote-endpoint = <&tda998x_0>;
		};
	};
};


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
