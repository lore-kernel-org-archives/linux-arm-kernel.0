From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Dec 2013 20:54:05 -0600
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <1386627424-373-3-git-send-email-w-kwok2@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
Message-ID: <20131210025405.GB20090@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 09, 2013 at 05:17:04PM -0500, WingMan Kwok wrote:
> +	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
> +	if (ret)
> +		return ret;
> +	k_phy->usb_phy_gen.phy.init = keystone_usbphy_init;
> +	k_phy->usb_phy_gen.phy.shutdown = keystone_usbphy_shutdown;

this *must* be initialized before adding the PHY to the subsystem. So
these two lines must be moved before usb_add_phy_dev().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/ba92a459/attachment.sig>
