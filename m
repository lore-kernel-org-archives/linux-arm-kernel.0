From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 09:21:32 -0400
Subject: [PATCH 7/9] ARM: dove: add PCIe controllers to SoC DT
In-Reply-To: <520A1871.4000501@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130812200452.GW25111@titan.lakedaemon.net>
 <520A1871.4000501@gmail.com>
Message-ID: <20130813132132.GY25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 01:28:49PM +0200, Sebastian Hesselbarth wrote:
> On 08/12/13 22:04, Jason Cooper wrote:
> >On Mon, Aug 12, 2013 at 08:46:53PM +0200, Sebastian Hesselbarth wrote:
> >>This adds a node for the pcie controllers found on Dove SoCs to the
> >>SoC DT include.
> >>
> >>Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>---
> >>Cc: Russell King <linux@arm.linux.org.uk>
> >>Cc: Jason Cooper <jason@lakedaemon.net>
> >>Cc: Andrew Lunn <andrew@lunn.ch>
> >>Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >>Cc: linux-kernel at vger.kernel.org
> >>Cc: linux-arm-kernel at lists.infradead.org
> >>---
> >>  arch/arm/boot/dts/dove.dtsi |   54 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 54 insertions(+)
> >
> >patches 7-9 applied to mvebu/dove_mbus since the dependencies are
> >cleaner that way.
> 
> Jason,
> 
> I will have to slightly modify the reset-gpio property names and that
> requires a fixup patch for patch 8. Can you still squash it or do you
> need a proper patch?

I can squash it, no problem.

thx,

Jason.

> diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/dove-d3plug.dts
> index ead90eb..f5f59bb 100644
> --- a/arch/arm/boot/dts/dove-d3plug.dts
> +++ b/arch/arm/boot/dts/dove-d3plug.dts
> @@ -91,7 +91,7 @@
>  	pcie-port at 0 {
>  		status = "okay";
>  		reset-gpios = <&gpio0 26 1>;
> -		reset-delay-ms = <20>;
> +		reset-delay-us = <20000>;
>  		pinctrl-0 = <&pmx_camera_gpio>;
>  		pinctrl-names = "default";
>  	};
