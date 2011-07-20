From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Jul 2011 14:14:43 +0300
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <1311160106-4898-6-git-send-email-tony.lin@freescale.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
Message-ID: <20110720111442.GN764@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 20, 2011 at 07:08:24PM +0800, Tony Lin wrote:
> @@ -165,14 +187,15 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	}
>  
>  	/* enable clocks */
> -	priv->usbclk = clk_get(dev, "usb");
> -	if (IS_ERR(priv->usbclk)) {
> -		ret = PTR_ERR(priv->usbclk);
> -		goto err_clk;
> +	if (!cpu_is_mx28()) {

this should not be used in drivers, IMHO.

> +		priv->usbclk = clk_get(dev, "usb");

drivers should not have to care about clock names, are you sure your
clkdev support is correct ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/9f05a300/attachment.sig>
