From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 16 Aug 2013 11:07:27 +0200
Subject: [PATCH v2 6/8] usb: phy: omap: get rid of omap_get_control_dev()
In-Reply-To: <520DEA2B.5030608@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
 <1376572512-9561-7-git-send-email-rogerq@ti.com>
 <20130815165152.GB10982@linutronix.de> <520DEA2B.5030608@ti.com>
Message-ID: <520DEBCF.4@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 11:00 AM, Roger Quadros wrote:
>> I don't like that part where you can call this function even before the
>> driver probed the device. This shouldn't happen since you have hard module
>> dependency and the proper compatible string in your device. But this
>> kind of thing won't happen in the am335x reset driver.
> 
> I don't like that part either, but omap_control_usb_set_mode is being called
> from outside this driver (e.g. musb) and we are not making any changes to that behaviour
> in this patch.
> 
> I think the issue you mentioned is being fixed by Kishon's extcon migration series.

Okay then.

> 
> cheers,
> -roger
> 

Sebastian
