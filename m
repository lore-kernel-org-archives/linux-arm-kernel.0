From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Jan 2013 08:55:14 -0800
Subject: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
In-Reply-To: <510103F9.4080601@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
 <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com>
 <50FD5993.5010008@ti.com> <20130121180113.GA22517@atomide.com>
 <50FE909B.1020001@ti.com> <20130122183942.GO15361@atomide.com>
 <510103F9.4080601@ti.com>
Message-ID: <20130125165513.GX22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130124 01:54]:
> On Wednesday 23 January 2013 12:09 AM, Tony Lindgren wrote:
> >It seems that we should have the iospace available in the driver
> >at that point. And it should be also available to the runtime PM
> >code in hwmod in the device somewhere?
> 
> I couldn't find anything as part of the device. Definitely not the
> ioremaped address. There's a device_private->driver_data which the
> drivers can use to populate the ioremaped address but I am sure thats
> not whats its meant for.

I guess we could have runtime PM init function to pass the driver
region to the low level bus code if needed. Anybody got better ideas?

Regards,

Tony
