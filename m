From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 8 Nov 2013 16:38:33 +0800
Subject: [PATCH 1/2] ARM: dts: imx53-mba53: create a container for fixed
 regulators
In-Reply-To: <527B546A.8050209@tqsc.de>
References: <1383724993-3731-1-git-send-email-shawn.guo@linaro.org>
 <527B546A.8050209@tqsc.de>
Message-ID: <20131108083829.GA10955@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 09:50:50AM +0100, Markus Niebel wrote:
> > @@ -43,12 +35,24 @@
> >  		status = "disabled";
> >  	};
> >  
> > -	reg_3p2v: 3p2v {
> > -		compatible = "regulator-fixed";
> > -		regulator-name = "3P2V";
> > -		regulator-min-microvolt = <3200000>;
> > -		regulator-max-microvolt = <3200000>;
> > -		regulator-always-on;
> > +	regulators {
> > +		compatible = "simple-bus";
> 
> No need for additional 
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> here as done in ARM: dts: imx: use generic node name for fixed regulator?

It's been done in the patch you mentioned.

Shawn
