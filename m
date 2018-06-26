From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Jun 2018 23:16:04 -0700
Subject: v4.18-rc1 on droid 4: very bad CPU performance
In-Reply-To: <20180625094949.GA17001@amd>
References: <20180621121542.GA4836@amd> <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com> <20180625094949.GA17001@amd>
Message-ID: <20180626061604.GK112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180625 09:52]:
> Hi!
> 
> > > > V4.18 is slower than it should be.
> > > > 
> > > > user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > > | wc -c
> > > > 10044291
> > > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > > user at devuan:~$ uname -a
> > > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > > > 
> > > > That bzip should take 12 seconds, not minute.
> > > > 
> > > > Any ideas? Do you see it, too?
> > > 
> > > I've noticed firefox is super slow.. Git bisect time?
> > 
> > Hmm not happening for me at least on duovero and droid4,
> > I'm getting about 20s for v4.17 and v4.18-rc1.
> 
> Something weird is going on here. My notes say it should be 12
> seconds.
> 
> It is indeed 20 seconds for v4.17, but it is 12 seconds in v4.14.
> 
> v4.14 is:
> # CONFIG_CPU_FREQ is not set
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_ARM_CPUIDLE is not set
> 
> In v4.18, I have:
> 
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> 
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y

I gave it a quick try here with v4.14 and it was 21 seconds
on 4430 duovero. But this was with omap2plus_defconfig.

Regards,

Tony
