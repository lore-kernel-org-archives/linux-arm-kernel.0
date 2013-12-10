From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Dec 2013 22:47:28 -0600
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386627424-373-3-git-send-email-w-kwok2@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
Message-ID: <20131210044728.GB28252@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Mon, Dec 09, 2013 at 05:17:04PM -0500, WingMan Kwok wrote:
> +static int keystone_usbphy_init(struct usb_phy *phy)
> +{
> +	struct keystone_usbphy *k_phy = dev_get_drvdata(phy->dev);
> +	u32 val;
> +
> +	val  = keystone_usbphy_readl(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK);
> +	keystone_usbphy_writel(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK,
> +				val | PHY_REF_SSP_EN);

you need to enable this device's clock to access its registers right ?

> +	udelay(20);

why the magic 20 usecs ? Where does that come from ? Empirically found
or is there a documentation reference ? At least add a comment there.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/7850247a/attachment-0001.sig>
