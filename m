From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 00:06:51 +0200
Subject: [PATCH 1/4] ARM: cfa10036: Add USB0 OTG port
In-Reply-To: <1371131025-12200-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371131025-12200-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <24013808.T2v7Fa5NMK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013 15:43:42 Maxime Ripard wrote:
> +
> +       ahb at 80080000 {
> +               usb0: usb at 80080000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&usb0_otg_cfa10036>;
> +                       status = "okay";
>                 };
>         };
> 

The patches all look good, just one trivial comment about the fragment above:

There is already a "usb0" label in the imx28.dtsi file for the same
node. When you refer to the node from a board.dts file, either leave
out the redundant label, or use it to simplify the statements above
to the brief version:

	&usb0 {
		pinctrl-names = "default";
		pinctrl-0 = <&usb0_otg_cfa10036>;
		status = "okay";
	};


	Arnd
