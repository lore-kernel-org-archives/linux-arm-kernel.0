From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 13:45:22 +0200
Subject: [PATCH v7 15/22] mfd: omap-usb-host: Manage HSIC clocks for HSIC
 mode
In-Reply-To: <1358422231-24736-16-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-16-git-send-email-rogerq@ti.com>
Message-ID: <20130117114522.GF18978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 01:30:24PM +0200, Roger Quadros wrote:
> @@ -598,6 +639,24 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  				clkname, PTR_ERR(pclk));
>  		else
>  			omap->utmi_clk[i] = pclk;
> +
> +		snprintf(clkname, sizeof(clkname),
> +				"usb_host_hs_hsic480m_p%d_clk", i + 1);

do we really need to know the exact clock node name ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/921dd41d/attachment.sig>
