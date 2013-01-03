From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 3 Jan 2013 12:58:50 -0600
Subject: [PATCH 1/2] ARM: OMAP4: clock data: ABE DPLL need to be locked
 on all revisions
In-Reply-To: <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
 <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <50E5D4EA.5030001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 01/03/2013 07:46 AM, Peter Ujfalusi wrote:
> We need to lock ABE DPPL on al OMAP4 revisions, not only for OMAP446x
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/cclock44xx_data.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index 5789a5e..79c32ce 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -2023,17 +2023,15 @@ int __init omap4xxx_clk_init(void)
>  				     ARRAY_SIZE(enable_init_clks));
>  
>  	/*
> -	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
> +	 * On OMAP4 the ABE DPLL fails to turn on if in idle low-power
>  	 * state when turning the ABE clock domain. Workaround this by
>  	 * locking the ABE DPLL on boot.

I am not sure that this change to the comment is completely accurate. On
OMAP4430 I did not see any issues with the DPLL failing to turn on if
the DPLL was not locked. I only saw this particular problem on the 4460.
Therefore, it may be better to leave the comment as-is and add an
additional sentence to state that the DPLL should be locked for all
OMAP4 devices for audio to work correctly.

Cheers
Jon
