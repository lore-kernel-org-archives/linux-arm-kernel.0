From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 22 Apr 2010 14:11:28 +0300
Subject: [PATCH] PL061 GPIO: Bug fix - setting gpio for HIGH_LEVEL
	interrupt is not working.
In-Reply-To: <1271843074-4158-1-git-send-email-viresh.kumar@st.com>
References: <1271843074-4158-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100422111115.GA14819@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Wed, Apr 21, 2010 at 03:14:34PM +0530, Viresh KUMAR wrote:
> In current implementation of PL061, setting type of irq to HIGH_LEVEL is not
> working. This patch fixes this bug.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/gpio/pl061.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
> index 4f172ab..d30c8a6 100644
> --- a/drivers/gpio/pl061.c
> +++ b/drivers/gpio/pl061.c
> @@ -188,7 +188,7 @@ static int pl061_irq_type(unsigned irq, unsigned trigger)
>  		gpioibe &= ~(1 << offset);
>  		if (trigger & IRQ_TYPE_EDGE_RISING)
>  			gpioiev |= 1 << offset;
> -		else
> +		else if (trigger & IRQ_TYPE_EDGE_FALLING)
>  			gpioiev &= ~(1 << offset);
>  	}
>  	writeb(gpioibe, chip->base + GPIOIBE);
> -- 

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
