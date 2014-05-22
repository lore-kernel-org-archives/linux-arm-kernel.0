From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 May 2014 13:55:16 -0400 (EDT)
Subject: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
In-Reply-To: <537DE530.3050205@linaro.org>
References: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
 <537DE530.3050205@linaro.org>
Message-ID: <alpine.LFD.2.11.1405221353030.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Daniel Lezcano wrote:

> On 05/22/2014 09:57 AM, Leela Krishna Amudala wrote:
> > This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
> > vexpress: Use wfi macro in platform_do_lowpower.")
> >
> > Current Exynos CPU hotplug code includes a hardcoded WFI
> > instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> > mode, this is invalid and causes the machine to hang hard when a CPU
> > is offlined.
> >
> > Use wfi macro instead of the hardcoded WFI instruction.
> 
> Is it possible to change it for cpu_do_idle() ?

Please let's not encourage every wfi() to be turned into cpu_do_idle().  
They are not always equivalent.  And semantically they are not.


Nicolas
