From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 6 May 2010 02:22:08 +0100
Subject: [PATCH] arch/arm: Use constants instead of magic numbers in
	do_gettimeofday.
In-Reply-To: <1273108792-8097-1-git-send-email-MostAwesomeDude@gmail.com>
References: <1273108792-8097-1-git-send-email-MostAwesomeDude@gmail.com>
Message-ID: <20100506012208.GY6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 06:19:52PM -0700, Corbin Simpson wrote:
> Part of the Didj patch.

how about a better description here please.
 
> Signed-off-by: Corbin Simpson <MostAwesomeDude@gmail.com>
> ---
>  arch/arm/kernel/time.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 2875380..5cb4ff9 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -104,12 +104,12 @@ void do_gettimeofday(struct timeval *tv)
>  		seq = read_seqbegin_irqsave(&xtime_lock, flags);
>  		usec = system_timer->offset();
>  		sec = xtime.tv_sec;
> -		usec += xtime.tv_nsec / 1000;
> +		usec += xtime.tv_nsec / NSEC_PER_USEC;
>  	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
>  
>  	/* usec may have gone up a lot: be safe */
> -	while (usec >= 1000000) {
> -		usec -= 1000000;
> +	while (usec >=  USEC_PER_SEC) {
> +		usec -= USEC_PER_SEC;
>  		sec++;
>  	}
>  
> -- 
> 1.6.6.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
