From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:26:27 -0600
Subject: [PATCH v6 06/15] usb: phy-mxs: Add anatop regmap
In-Reply-To: <1386897825-6130-7-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-7-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213042627.GF867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 13, 2013 at 09:23:36AM +0800, Peter Chen wrote:
> @@ -226,6 +235,16 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mxs_phy);
>  
> +	if (mxs_phy->data->flags & MXS_PHY_HAS_ANATOP) {

instead of the flag, you can check if that binding exist and use the
binding itself as a flag.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/788e3751/attachment-0001.sig>
