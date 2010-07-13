From: d.cristiani@idem-tech.it (Dylan Cristiani)
Date: Tue, 13 Jul 2010 12:44:14 +0200
Subject: linux 2.6.34 bug
In-Reply-To: <AANLkTimhjwiBzJ5kIe3doYawlhw_XZgmE6ys2Yg-Ucl9@mail.gmail.com>
References: <20100708173621.00003527@unknown>
	<201007081842.16347.marek.vasut@gmail.com>
	<AANLkTimhjwiBzJ5kIe3doYawlhw_XZgmE6ys2Yg-Ucl9@mail.gmail.com>
Message-ID: <20100713124414.00001de9@unknown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010 09:50:56 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:


> 
> It was my bad. Fixed updated as below. Dylan, please help review:
> 
>     [ARM] pxa: fix incorrect order of AC97 reset pin configs
> 
>     Reported-by: Dylan Cristiani <d.cristiani@idem-tech.it>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> 
> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
> index 0af3617..c059dac 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -41,10 +41,10 @@ void pxa27x_clear_otgph(void)
>  EXPORT_SYMBOL(pxa27x_clear_otgph);
> 
>  static unsigned long ac97_reset_config[] = {
> -	GPIO95_AC97_nRESET,
> -	GPIO95_GPIO,
> -	GPIO113_AC97_nRESET,
>  	GPIO113_GPIO,
> +	GPIO113_AC97_nRESET,
> +	GPIO95_GPIO,
> +	GPIO95_AC97_nRESET,
>  };
> 
>  void pxa27x_assert_ac97reset(int reset_gpio, int on)

for me is ok: ACK!
