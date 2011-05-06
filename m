From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 May 2011 13:48:44 +0900
Subject: [PATCH] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <1304003329-15116-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1304003329-15116-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <00f901cc0ba8$e2c45270$a84cf750$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> At least some newer S3C6410 silicon supports operation up to 800MHz rather
> than just 667MHz. Unfortunately I don't have access to any of
documentation
> of this other than some running systems, add a new cpufreq table entry for
> this based on the behaviour of those systems.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/cpufreq.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-
> s3c64xx/cpufreq.c
> index 4375b97..db722a5 100644
> --- a/arch/arm/mach-s3c64xx/cpufreq.c
> +++ b/arch/arm/mach-s3c64xx/cpufreq.c
> @@ -32,6 +32,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
>  	[1] = { 1050000, 1150000 },
>  	[2] = { 1100000, 1150000 },
>  	[3] = { 1200000, 1350000 },
> +	[4] = { 1300000, 1350000 },
>  };
> 
>  static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
> @@ -44,6 +45,7 @@ static struct cpufreq_frequency_table
s3c64xx_freq_table[]
> = {
>  	{ 2, 532000 },
>  	{ 2, 533000 },
>  	{ 3, 667000 },
> +	{ 4, 800000 },
>  	{ 0, CPUFREQ_TABLE_END },
>  };
>  #endif
> --

Hi Mark,

Yes, some newer S3C6410 can support 800Mhz(ARM clock) and you can
distinguish it from its marking on top of silicon. According to a design
guide, its typical VDD ARM is 1.3V :)

Will apply and thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
