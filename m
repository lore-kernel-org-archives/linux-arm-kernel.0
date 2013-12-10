From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Dec 2013 10:14:44 -0500
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <20131210025405.GB20090@saruman.home>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
 <20131210025405.GB20090@saruman.home>
Message-ID: <52A72FE4.4020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 09:54 PM, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Dec 09, 2013 at 05:17:04PM -0500, WingMan Kwok wrote:
>> +	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
>> +	if (ret)
>> +		return ret;
>> +	k_phy->usb_phy_gen.phy.init = keystone_usbphy_init;
>> +	k_phy->usb_phy_gen.phy.shutdown = keystone_usbphy_shutdown;
> 
> this *must* be initialized before adding the PHY to the subsystem. So
> these two lines must be moved before usb_add_phy_dev().
> 
Make sense. Probably its good idea to repost the $subject patch with
above as well as other delay related comment.

Regards,
Santosh
