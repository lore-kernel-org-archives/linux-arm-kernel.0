From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 10 Jun 2013 11:25:17 +0000
Subject: [PATCH 2/2] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <87a9nb2gjh.fsf@linaro.org>
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-3-git-send-email-gururaja.hebbar@ti.com>
 <87a9nb2gjh.fsf@linaro.org>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC2E907@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 23:11:22, Kevin Hilman wrote:
> Hebbar Gururaja <gururaja.hebbar@ti.com> writes:
> 
> > On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> > is available to enable Wakeup feature for Alarm Events.
> >
> > Since new platforms/Boards are now added through DT only, this feature
> > is supported via DT property only.
> 
> > Platforms using such IP should add the property "ti,has_irq_wake_enb"
> > in rtc DT node.
> 
> This is a property of the IP, not the board.  Can't you detect this
> based on the revision of the IP?

Here is what I found out till now.

1. rtc-omap driver is used by Davinci, OMAP-1/2 & AM33xx SoC.

2. Only AM33xx soc rtc ip has revision register (& populated). Older OMAP
   Or davinci doesn't have this register.

3. AFAIK, this was the reason why Afzal used platform_device_id & 
   of_device_id->data method to detect new versions (commit
   9e0344dcc225fe1a0e8b8af9ff7df44ec4613580)


So now either 
a. I can follow the same method and add new member to omap_rtc_devtype & add a new compatible in 
 omap_rtc_of_match in rtc-omap.c

or

b. use dt property to indicate existence of above property.


Kindly let me know your opinion about the same.

> 
> Kevin
> 


Regards, 
Gururaja
