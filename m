From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Feb 2013 11:20:43 +0000
Subject: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic
 implementation if !od
In-Reply-To: <1360840554-26901-1-git-send-email-balbi@ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
Message-ID: <20130214112043.GQ17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 01:15:52PM +0200, Felipe Balbi wrote:
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct omap_device *od = to_omap_device(pdev);
>  	int ret;
>  
>  	ret = pm_generic_runtime_suspend(dev);
>  
> +	if (!od)
> +		goto out;
> +
>  	if (!ret)

What's wrong with the single line change per function of:

-	if (!ret)
+	if (!ret && to_omap_device(pdev))

?

>  		omap_device_idle(pdev);
>  
> +out:
>  	return ret;
>  }
