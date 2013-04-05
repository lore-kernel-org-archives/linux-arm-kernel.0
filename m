From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Apr 2013 20:33:39 +0400
Subject: [PATCH 7/8] ARM: shmobile: Marzen: pass platform data to USB
 PHY device
In-Reply-To: <20130405004445.GQ29203@verge.net.au>
References: <201304050310.39289.sergei.shtylyov@cogentembedded.com>
 <20130405004445.GQ29203@verge.net.au>
Message-ID: <515EFCE3.4060805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-04-2013 4:44, Simon Horman wrote:

>> Since we're now going to setup the USBPCTRL0 register using the USB PHY device's
>> platform data, we now need a way to pass those platform data from the board file
>> to the device which is situated in setup-r8a7779.c -- and what I'm suggesting is
>> r8a7779_add_usb_phy_device() that will register USB PHY platform device with the
>> passed platform data using platform_device_register_resndata() call; creating
>> this function involves deletion of 'usb_phy_device' from r8a7779_devices_dt[],
>> so that it will no longer be registered for the generic R8A7779 machine (where
>> we can't provide the platform data anyway), hence EHCI/OHCI drivers will fail
>> to load as well.

>> For the Marzen board, this new function will be called from marzen_init() to
>> register the USB PHY device early enough.

> As per my comment regarding patch 1, I wonder if this could
> be split into an SoC patch and a board patch.

    No, that'll break bisection as it will cause the PHY driver to not be 
registered after the SoC patch, and hence EHCI/OHCI drivers won't load too.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei
