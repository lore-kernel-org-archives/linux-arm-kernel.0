From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Dec 2013 10:17:07 -0500
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <20131210044728.GB28252@saruman.home>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
 <20131210044728.GB28252@saruman.home>
Message-ID: <52A73073.5020505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 11:47 PM, Felipe Balbi wrote:
> Hi again,
> 
> On Mon, Dec 09, 2013 at 05:17:04PM -0500, WingMan Kwok wrote:
>> +static int keystone_usbphy_init(struct usb_phy *phy)
>> +{
>> +	struct keystone_usbphy *k_phy = dev_get_drvdata(phy->dev);
>> +	u32 val;
>> +
>> +	val  = keystone_usbphy_readl(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK);
>> +	keystone_usbphy_writel(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK,
>> +				val | PHY_REF_SSP_EN);
> 
> you need to enable this device's clock to access its registers right ?
> 
Nope.. This clock is always running for CFG block where the phy control
is residing.

>> +	udelay(20);
> 
> why the magic 20 usecs ? Where does that come from ? Empirically found
> or is there a documentation reference ? At least add a comment there.
> 
Above probably isn't needed either but good to check why was this added.
In refreshed patch, this can be either removed or a comment can be
added accordingly.

Thanks for spotting that.

Regards,
Santosh
