From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Nov 2012 10:28:58 +0100
Subject: [PATCH 3/4] imx27-dt: configure i2c1 gpio on armadeus apf27
In-Reply-To: <1353874625-14754-4-git-send-email-tremyfr@yahoo.fr>
References: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
 <1353874625-14754-4-git-send-email-tremyfr@yahoo.fr>
Message-ID: <20121126102858.4ba818b0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Philippe Reynes,

On Sun, 25 Nov 2012 21:17:04 +0100, Philippe Reynes wrote:

>  static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
> @@ -48,6 +49,10 @@ int apf27_lan8700_wakeup(struct phy_device *phydev)
>  static void __init apf27_init(void)
>  {
>  	phy_register_fixup_for_id("imx27-fec.0-1:1f", apf27_lan8700_wakeup);
> +
> +	/* configure i2c1 gpio */
> +	mxc_gpio_mode((GPIO_PORTD | GPIO_OUT | GPIO_PF | 17));
> +	mxc_gpio_mode((GPIO_PORTD | GPIO_OUT | GPIO_PF | 18));
>  }

I haven't followed i.MX 27 support lately, but this surely should be
done using a pinctrl driver. I see that there is a general pinctrl
driver for i.MX, but a drivers/pinctrl/pinctrl-imx27.c might be
missing. It would probably be a better idea to implement the missing
pinctrl driver, if not already available?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
