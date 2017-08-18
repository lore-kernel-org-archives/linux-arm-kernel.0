From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Aug 2017 08:26:00 -0700
Subject: [PATCH 3/3] ARM: OMAP5: Enable CPU off idle states
In-Reply-To: <c31a90c4-8dbe-926a-831c-5fac92ebae80@ti.com>
References: <20170817230122.30655-1-tony@atomide.com>
 <20170817230122.30655-4-tony@atomide.com>
 <c31a90c4-8dbe-926a-831c-5fac92ebae80@ti.com>
Message-ID: <20170818152600.GE6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [170817 18:30]:
> On 08/17/2017 06:01 PM, Tony Lindgren wrote:
> > With the idle code in place needed for supporting off mode for cpus,
> > let's enable it. This seems to save about 0.2W of power compared to
> > CPU retention states based on quick measurement on omap5-uevm.
> 
> That makes sense since the Silicon you probably have is pre-production
> silicon.

It seems to be es2.0, the measurement was just based on a glance
of the power supply after rmmod of ehci-omap and ohci-platform
modules.

> unfortunately, you have been looking at some preproduction code which was
> being developed prior to the silicon going into production (also the reason
> why I have'nt upstreamed those changes).

Oh I did not know that, I was just looking at the old
ti-linux-3-8-y-kernel that the igepv5 kernel tree is
based on.

> unfortunately, I have to NAK this patch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f5dc91b691cf296c49aedf0a671fd659a70f737
> as per Technical Reference Manual SWPU282AF?May 2012?Revised August 2016,
> PM_MPU_PWRSTCTRL can only support: ON INA, RET. (CSWR only).
> 
> Same applies to CPUs as well. which was the reason in the first place for me
> to send the patch upstream.

OK, is there some hardware errata issued on that?

I also noticed these patches won't work when booted with LPAE
enabled kernel for some reason.

Regards,

Tony
