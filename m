From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 14 Jan 2015 15:52:45 +0530
Subject: [PATCH] arch: arm: mach-davinci: cdce949.c: Remove unused function
In-Reply-To: <1417906928-5728-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1417906928-5728-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <54B64375.3070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rickard,

On Sunday 07 December 2014 04:32 AM, Rickard Strandqvist wrote:
> Remove the function cdce_set_rate() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  arch/arm/mach-davinci/cdce949.c              |   37 --------------------------
>  arch/arm/mach-davinci/include/mach/cdce949.h |    2 --
>  2 files changed, 39 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
> index abafb92..bccac4a 100644
> --- a/arch/arm/mach-davinci/cdce949.c
> +++ b/arch/arm/mach-davinci/cdce949.c
> @@ -212,43 +212,6 @@ static struct cdce_output output_list[] = {
>  	[5]	= { cdce_y5_freqs, ARRAY_SIZE(cdce_y5_freqs) },
>  };
>  
> -int cdce_set_rate(struct clk *clk, unsigned long rate)

Without this function, this driver is of no use. I can see that CDCE949
support has remained unused for long time. I would rather see the entire
support including cdce949.c and cdce949.h and their references removed.

Thanks,
Sekhar
