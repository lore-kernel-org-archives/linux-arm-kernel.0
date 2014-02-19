From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 18:01:18 +0100
Subject: [PATCH v4 13/13] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
In-Reply-To: <5304E14F.3020303@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-14-git-send-email-gregory.clement@free-electrons.com>
 <20140219174634.17123478@skate>
 <5304E14F.3020303@free-electrons.com>
Message-ID: <20140219180118.4915a6db@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 19 Feb 2014 17:52:31 +0100, Gregory CLEMENT wrote:

> > What about putting this in pmsu.c, in an arch_initcall() (or some other
> > initcall level) ? The cpuidle feature is really tied to the PMSU, so I
> > believe it makes sense to have the cpuidle-armada-370-xp
> > platform_device declared and registered in pmsu.c. As an added bonus,
> > you don't need to expose
> > armada_370_xp_pmsu_enable_l2_powerdown_onidle() and
> > armada_370_xp_cpu_pm_init() in a header: they can remain static
> > functions private to pmsu.c.
> 
> It sounds like a good idea, the tricky part will be to find the accurate
> initcall level: not too early and not too late.

Make it an arch_initcall(). This is the point where ->init_machine() is
called in armada-370-xp.c.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
