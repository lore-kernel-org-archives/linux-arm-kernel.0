From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Sep 2014 11:12:23 +0200
Subject: [PATCH 3/5] arm: MTK: Add basic support for mt8135
In-Reply-To: <1409874660-8710-4-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1409874660-8710-4-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <20140908091223.GC15722@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 07:50:58AM +0800, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		timer: timer at 10008000 {
> +			compatible = "mediatek,mt6577-timer";

This should also have a mediatek,mt8135-timer compatible. Just in case
there are incompatibilities in the timer you are not aware of now you'll
still have the possibility later to distinguish between the mt6577 timer
and the mt8135 timer in the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
