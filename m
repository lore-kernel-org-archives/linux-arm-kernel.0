From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Oct 2011 16:14:18 +0900
Subject: [PATCH] ARM: S3C2443: Remove redundant s3c_register_clocks call
	for init_clocks
In-Reply-To: <1313463881.16359.2.camel@phoenix>
References: <1313463881.16359.2.camel@phoenix>
Message-ID: <086001cc8a40$e3940350$aabc09f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin wrote:
> 
> Since commit af337f3e633a198034a99450416257ddf2307497
> "ARM: S3C2443: Move parts of the clock code to common clock file",
> the init_clocks array is moved to arch/arm/plat-s3c24xx/s3c2443-clock.c.
> Now we call s3c_register_clocks for init_clocks in s3c2443_common_init_clocks.
> 
> Thus we can remove the empty init_clocks array here and remove the
> redundant s3c_register_clocks call for init_clocks in s3c2443_init_clocks.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  arch/arm/mach-s3c2443/clock.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
> index a1a7176..4018dbe 100644
> --- a/arch/arm/mach-s3c2443/clock.c
> +++ b/arch/arm/mach-s3c2443/clock.c
> @@ -305,9 +305,6 @@ static struct clk init_clocks_off[] = {
>  	}
>  };
> 
> -static struct clk init_clocks[] = {
> -};
> -
>  /* clocks to add straight away */
> 
>  static struct clksrc_clk *clksrcs[] __initdata = {
> @@ -345,10 +342,6 @@ void __init s3c2443_init_clocks(int xtal)
>  	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
>  		s3c_register_clksrc(clksrcs[ptr], 1);
> 
> -	/* register clocks from clock array */
> -
> -	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
> -
>  	/* We must be careful disabling the clocks we are not intending to
>  	 * be using at boot time, as subsystems such as the LCD which do
>  	 * their own DMA requests to the bus can cause the system to lockup
> --
> 1.7.4.1

Looks ok, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
