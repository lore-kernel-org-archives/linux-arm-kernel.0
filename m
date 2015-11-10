From: javi.merino@arm.com (Javi Merino)
Date: Tue, 10 Nov 2015 11:20:18 +0000
Subject: [PATCH v3 1/2] thermal: mediatek: Add cpu power cooling model.
In-Reply-To: <20151106032433.GL3773@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-2-git-send-email-dawei.chien@mediatek.com>
 <20151104193958.GC14127@localhost.localdomain>
 <1446721837.4016.57.camel@mtksdaap41>
 <20151106032433.GL3773@ubuntu>
Message-ID: <20151110112017.GA3551@e104805>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 08:54:33AM +0530, Viresh Kumar wrote:
> Cc'ing Javi (which you should have as he wrote the power-thing for
> cpu-cooling).
> 
> On 05-11-15, 19:10, dawei chien wrote:
> > This is because our platform currently only support mt8173_cpufreq.c, so
> > that I only add static power model for our owner IC.
> 
> Bindings are (normally) supposed to be general than a platform
> specific.
> 
> > Please understanding that I wouldn't give a DT binding document since I
> > will remove static power table on next version, but I can try to explain
> > it.
> 
> Then just don't add things in the first place.
> 
> > As far as I know, static power is somewhat leakage of CPU clusters, so
> > that we hardly to find a formula, which can suitable all kinds of CPUs
> > since leakage is different. In ARM IPA framework, static power only need
> > to be defined by who register cpufreq_power_cooling_register. The
> > voltage/power table is just one way to present leakage power of CPUs.
> 
> The bindings don't fix the values for static power, but just provides
> a field for platforms to use. Everyone can then send its own power
> figures. Why do you thing it can't be generalized?

The way they are described here is useful only for this platform, but
it's not generic.  It only takes into account voltage as (I assume)
it's the only variable that affects it in this implementation.  A
generalized version of the static power should take into account the
temperature and the idle state.

> > Actually, static power is optional since dynamic power is much more than
> > static power.
> 
> Maybe, we should still capture it.
> 
> @Javi ?

It really depends on the platform.  If dawei says that for their
platform static power is negligible then it is ok to not capture it.

Cheers,
Javi
