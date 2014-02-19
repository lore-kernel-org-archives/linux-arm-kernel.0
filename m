From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 14:59:53 +0800
Subject: [PATCH v3 1/4] Phytec phyFLEX-i.MX6 : Added USB_OTG Support
In-Reply-To: <53045225.50509@phytec.in>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
 <20140219022307.GL15716@S2101-09.ap.freescale.net>
 <20140219055824.GB3010@S2101-09.ap.freescale.net>
 <53045225.50509@phytec.in>
Message-ID: <20140219065949.GD3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not send email in html.

On Wed, Feb 19, 2014 at 12:11:41PM +0530, Ashutosh wrote:
> By seeing the discussion would the below changes is appropriate
> 
> regulators {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 reg_usb_otg_vbus: regulator at 0 {
>                                compatible = "regulator-fixed";
>                                 reg = <0>;
>                                 regulator-name = "usb_otg_vbus";
>                                 regulator-min-microvolt = <5000000>;
>                                 regulator-max-microvolt = <5000000>;
>                                 gpio = <&gpio4 15 0>;
>                 };
> 
> But as Mark [1] suggested not to use simple bus. Which one is more appropriate
> ?

Since it's already been used so widely and provided us a nice way to use
the generic node name, I believe Mark is giving up his position.

Shawn

> 
> [1] http://www.spinics.net/lists/linux-usb/msg101477.html
