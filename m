From: robherring2@gmail.com (Rob Herring)
Date: Fri, 04 Jan 2013 16:08:08 -0600
Subject: [PATCH 2/2] ARM: disable errata work-arounds which access secure
 registers
In-Reply-To: <CAOMZO5DP8kvfqG+uTbiRKeVe2aOKNs6DnGOBhK-WhGi9_7hV7Q@mail.gmail.com>
References: <1355351150-15942-2-git-send-email-robherring2@gmail.com>
 <CAOMZO5BpB7-9=S76VgNh5txZ=G3Q0UOaX6Px4OcMa+cVUi-_gg@mail.gmail.com>
 <CAOMZO5DXVcSi9ZD_2EpPTcv9OP=Jb2ZzWk9roJ02Jc_HSfmhFQ@mail.gmail.com>
 <CAOMZO5DP8kvfqG+uTbiRKeVe2aOKNs6DnGOBhK-WhGi9_7hV7Q@mail.gmail.com>
Message-ID: <50E752C8.20608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 03:45 PM, Fabio Estevam wrote:
> On Fri, Jan 4, 2013 at 7:39 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Should we do like this?
> 
> Looks like this would be better (same as it was done for vexpress):
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 1ad0d76..3e628fd 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -841,8 +841,6 @@ config SOC_IMX6Q
>         select ARCH_HAS_CPUFREQ
>         select ARCH_HAS_OPP
>         select ARM_CPU_SUSPEND if PM
> -       select ARM_ERRATA_743622
> -       select ARM_ERRATA_751472
>         select ARM_ERRATA_754322
>         select ARM_ERRATA_764369 if SMP
>         select ARM_ERRATA_775420
> 
> Rob, is this the correct approach?

Yes, that's the correct approach (along with updating the bootloader to
enable these work-arounds). I had this fix on my todo (the git
autobuilder caught it yesterday), but haven't gotten to it. So if you
could send it out that would be great.

Rob
