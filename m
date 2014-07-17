From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Jul 2014 01:16:05 -0700
Subject: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume
 callbacks for clkevent device
In-Reply-To: <53C6DDC6.9060705@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
 <20140714111536.GC20068@atomide.com> <53C3EB1F.2010109@ti.com>
 <53C4166F.1050003@ti.com> <20140715064807.GJ20068@atomide.com>
 <53C6DDC6.9060705@ti.com>
Message-ID: <20140717081605.GI18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140716 13:19]:
> On 07/15/2014 01:48 AM, Tony Lindgren wrote:
> > 
> > It's best to register these kind of functions as platform_data
> > in pdata-quirks.c auxdata. That way when this moves to live
> > in drivers/clocksource the driver does not need to know anything
> > about the interconnect specific registers.
> 
> Perhaps I spoke too soon on this, I can't use pdata-quirks right now to pass the
> idle/unidle functions. The clockevent source is special and reads the dt node
> itself and then marks it as disabled so nothing else can touch it. No device is
> created and no auxdata matched. I will gladly fix it up once the driver is ready
> to move but right now I can't use any existing functionality to do it.

OK. So maybe just initialize the function pointers during init and
use appropriate naming so the function pointers will stay usable
later on too once it's a driver.

Regards,

Tony
