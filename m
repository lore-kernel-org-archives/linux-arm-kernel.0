From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Dec 2010 15:12:15 +0000
Subject: [PATCH v3 4/5] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <-1357135968697415881@unknownmsgid>
References: <1292203221-2609-1-git-send-email-y>
	<-1357135968697415881@unknownmsgid>
Message-ID: <AANLkTimkUpgPD5BdjL-3aV=miJwbT0OOWAJJ+V7LUhbP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2010 01:20,  <ykaoua@qualcomm.com> wrote:
> --- /dev/null
> +++ b/arch/arm/mach-msm/hotplug.c
[...]
> +static inline void platform_do_lowpower(unsigned int cpu)
> +{
> + ? ? ? /* Just enter wfe for now. */
> + ? ? ? for (;;) {
> + ? ? ? ? ? ? ? asm("wfe");
> + ? ? ? ? ? ? ? if (pen_release == cpu) {
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* OK, proper wakeup, we're done
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? smp_rmb();

Do you need some barrier after wfe?

-- 
Catalin
