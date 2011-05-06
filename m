From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 13:58:21 +0900
Subject: [PATCH] ARM: S3C6410: Add some lower frequencies for 800MHz base
	clock operation
In-Reply-To: <1304004383-16133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1304004383-16133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <00fa01cc0baa$3af45a20$b0dd0e60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> By extension from the 667MHz based clocks currently supported add 100MHz
> and 200MHz operating points. Due to a lack of documentation these have not
> been confirmed as supported but by extension from the existing frequencies
> they should be OK and there is less risk than with the previuus patch for
> 800MHz operation.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> In spite of the commit log this is based on top of the previous patch.
> 
>  arch/arm/mach-s3c64xx/cpufreq.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-
> s3c64xx/cpufreq.c
> index db722a5..1e7df30 100644
> --- a/arch/arm/mach-s3c64xx/cpufreq.c
> +++ b/arch/arm/mach-s3c64xx/cpufreq.c
> @@ -37,7 +37,9 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
> 
>  static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
>  	{ 0,  66000 },
> +	{ 0, 100000 },
>  	{ 0, 133000 },
> +	{ 1, 200000 },
>  	{ 1, 222000 },
>  	{ 1, 266000 },
>  	{ 2, 333000 },
> --

Hmm, I'm not sure this should be OK...because guided(or tested?) dvfs level
is following for 800Mhz.
L3: 133, L2: 266, L1: 400 and L0: 800.

And I couldn't find about supporting of 100Mhz or 200Mhz in its hw design
guide. Of course, it doesn't mean this is wrong but at least need to check
again.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
