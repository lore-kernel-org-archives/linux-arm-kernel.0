From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 10:34:54 +0100
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911083806.GM9650@linux>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
 <20150911083806.GM9650@linux>
Message-ID: <20150911093454.GK21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 02:08:06PM +0530, Viresh Kumar wrote:
> On 11-09-15, 10:36, Arnd Bergmann wrote:
> > I don't consider that a bug: a module with just an init function and
> > no exit function can be loaded once and never unloaded, which is not
> > nice for debugging, but is otherwise fully functional.
> 
> For me, there are two essential things that a module has to support:
> - hotplug, which is just fine.
> - hot-unplug, which will pass as well, but without freeing resources..

Well, that's got nothing to do with not having a module_exit().

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
