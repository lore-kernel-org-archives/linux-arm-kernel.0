From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 10:58:20 +0100
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911094003.GN9650@linux>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
 <20150911083806.GM9650@linux>
 <20150911093454.GK21084@n2100.arm.linux.org.uk>
 <20150911094003.GN9650@linux>
Message-ID: <20150911095820.GM21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:10:03PM +0530, Viresh Kumar wrote:
> On 11-09-15, 10:34, Russell King - ARM Linux wrote:
> > Well, that's got nothing to do with not having a module_exit().
> 
> Yeah, so we don't necessarily need a module_exit(), but the module
> should have freed the resources with module unplug. And that was
> missing with Arnd's patch..

Not module "unplug" (I've never heard it called that before).  A module
with a module_init() but no module_exit() can only be added to a running
kernel, and never removed.  That's intentional behaviour.

However, if you're talking about hot-unplug, presumably you're talking
about _CPU_ hot-unplug, and that's something the code should definitely
handle irrespective of whether it's built-in or a module.

The two issues are entirely separate.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
