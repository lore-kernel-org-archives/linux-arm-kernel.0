From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 10:04:57 -0700
Subject: [PATCH] ARM: OMAP2+: omap-usb-host: Fix memory leaks
In-Reply-To: <51A84E7A.106@ti.com>
References: <1369400818-31625-1-git-send-email-rogerq@ti.com>
 <20130530210025.GE6467@atomide.com> <51A84E7A.106@ti.com>
Message-ID: <20130612170457.GJ8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130531 00:23]:
> Hi Tony,
> 
> On 05/31/2013 12:00 AM, Tony Lindgren wrote:
> > Hi Roger,
> > 
> > * Roger Quadros <rogerq@ti.com> [130524 06:12]:
> >> Fix memory leaks in the error path.
> >> Also, use platform_device_register_full() to allocate
> >> the platform devices and set platform data.
> > 
> > If you need this for the v3.10-rc, you should describe why this patch
> > is needed and ideally have some oops or regression causing commit
> > listed. Care to update the description for that?
> 
> There is no oops or regression happening. Just that there will be a
> small memory leak if any of the memory allocations fail or if the
> platform device is destroyed.
> 
> If it doesn't look that serious to you then it can wait.
> But if we move to device tree only boot then this patch and the file
> "usb-host.c" might not be required at all.

OK, applying into omap-for-v3.11/fixes-non-critical as we cannot
remove it yet.

Regards,

Tony
