From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 17 Jun 2014 12:13:45 +0530
Subject: [PATCH v4 06/11] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <53973C0B.2000903@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
 <1399704998-13321-7-git-send-email-pankaj.dubey@samsung.com>
 <53973C0B.2000903@samsung.com>
Message-ID: <000401cf89f7$7db93190$792b94b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

> Hi,
> 
> On 10.05.2014 08:56, Pankaj Dubey wrote:
> > From: Young-Gun Jang <yg1004.jang@samsung.com>
> >
> > Add support for mapping Samsung Power Management Unit (PMU) base
> > address from device tree. This patch also adds helper function as
> > "get_exynos_pmuregmap". This function can be used by other machine
> > files such as "pm.c", "hotplug.c" for accessing PMU regmap handle.
> >
> 
> I don't think there is a need to use regmap to provide access to PMU to
such low
> level code such as pm.c or hotplug.c. Moreover, I believe that it might be
undesirable
> in some cases, e.g. very low level code running at early resume or late
suspend.
> 
> IMHO, based on what we now have for SYSRAM, you could simply map PMU from
> device tree one time, before SMP init, and keep the address in some
globally
> accessible variable, like those for SYSRAM we have right now
(sysram_base_addr,
> sysram_ns_base_addr -> pmu_base_addr).
> 

Thanks for review. 

Well I adopted same approach in V1 of this patch series. 

V1: https://lkml.org/lkml/2014/4/2/48

So, if we do not have issues with that approach, I think we can map PMU
address
one time and use it for all machine files including pmu.c. 
Also I can see that early_syscon patch [1] is not progressing anymore,
so in next version of this series better I remove dependency of early syscon
and usage
of regmap.

1: https://lkml.org/lkml/2014/4/8/239

Tomasz, It will be good if you can review remaining patches under this
series, specially patch [2].
So that, I can update this series after addressing all comments.

2: https://lkml.org/lkml/2014/5/10/26


> Then, registration of the normal syscon would happen through standard
platform
> driver mechanisms and no special early handling would be necessary.
> 
> Best regards,
> Tomasz

Thanks,
Pankaj Dubey
