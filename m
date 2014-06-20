From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 21:06:29 +0800
Subject: [PATCH] arm, imx6, dts: add aristainetos board support
In-Reply-To: <53A2C8DD.7000601@denx.de>
References: <1402468548-17539-1-git-send-email-hs@denx.de>
 <20140618132915.GK8860@dragon> <53A2C8DD.7000601@denx.de>
Message-ID: <20140620130628.GK28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 01:26:21PM +0200, Heiko Schocher wrote:
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 =<&pinctrl_hog&pinctrl_backlight&pinctrl_gpio>;
> >
> >pinctrl_backlight and pinctrl_gpio shouldn't be in there.
> 
> removed &pinctrl_backlight, removed device specific gpios to
> device nodes ... but there are some gpios only used with GPIO API ...
> 
> Where to move this pinctrls ?

For GPIO that do not have a clear client device owing, it's fine to have
it in hog group.

Shawn
