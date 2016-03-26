From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 26 Mar 2016 17:10:35 +0300
Subject: [PATCH] phy: da8xx-usb: new driver for DA8xx SoC USB PHY
In-Reply-To: <1458871024-21478-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-10-git-send-email-david@lechnology.com>
 <1458871024-21478-1-git-send-email-david@lechnology.com>
Message-ID: <56F6985B.2020902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/25/2016 4:57 AM, David Lechner wrote:

> This is a new phy driver for the SoC USB controllers on the TI DA8xx
> family of microcontrollers. The USB 1.1 PHY is just a simple on/off.
> The USB 2.0 PHY also allows overriding the VBUS and ID pins.
>
> Signed-off-by: David Lechner <david@lechnology.com>
[...]

    Just some nit-picking.

> diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> new file mode 100644
> index 0000000..ecfd607
> --- /dev/null
> +++ b/drivers/phy/phy-da8xx-usb.c
> @@ -0,0 +1,249 @@
[...]
> +static int da8xx_usbphy_probe(struct platform_device *pdev)
[...]
> +	if (node) {
> +		d_phy->phy_provider = devm_of_phy_provider_register(dev,
> +							da8xx_usbphy_of_xlate);
> +		if (IS_ERR(d_phy->phy_provider)) {
> +			dev_err(dev, "Failed to create phy provider.\n");
> +			return PTR_ERR(d_phy->phy_provider);
> +		}
> +	} else {
> +		int ret;
> +
> +		ret = phy_create_lookup(d_phy->usb11_phy, "usbphy", "ohci.0");
> +		if (ret)
> +			dev_warn(dev, "Failed to create usb11 phy lookup .\n");

    Space before period? I'd omit the periods altogether...

> +		ret = phy_create_lookup(d_phy->usb20_phy, "usbphy", "musb-da8xx");
> +		if (ret)
> +			dev_warn(dev, "Failed to create usb20 phy lookup .\n");

     Likewise.

[...]

MBR, Sergei
