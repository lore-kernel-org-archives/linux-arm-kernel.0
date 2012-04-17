From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 17 Apr 2012 23:57:41 +0300
Subject: [PATCH v2 1/8] ohci-nxp: Driver cleanup
In-Reply-To: <1334682507-15055-2-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-2-git-send-email-stigge@antcom.de>
Message-ID: <20120417205740.GI6498@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 07:08:20PM +0200, Roland Stigge wrote:
> @@ -435,6 +436,7 @@ static int __devinit usb_hcd_nxp_probe(s
>  	}
>  
>  	__raw_writel(__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN, USB_CTRL);
> +	__raw_writel(__raw_readl(USB_CTRL) & ~USB_DEV_NEED_CLK_EN, USB_CTRL);
>  
>  	/* Set to enable all needed USB clocks */
>  	__raw_writel(USB_CLOCK_MASK, USB_OTG_CLK_CTRL);

What does this chunk do?  Is this part of the "* Fixed controller
initialization (bits)" bullet point?  How does it affect the user?
Should it be included in the 3.4 kernel?

Generally bug fixes, cleanups, and new features should go into
different patches.  If you use "git citool" then you can highlight
and right click on the lines you want to go into the patch.

regards,
dan carpenter
