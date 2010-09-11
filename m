From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 11 Sep 2010 18:08:40 +0400
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <AANLkTikT5Jg5dqfjMrNTxb57BaGmcuAqsqiC9e7_d0TW@mail.gmail.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>	<AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>	<20100911113236.GA25922@n2100.arm.linux.org.uk>
	<AANLkTikT5Jg5dqfjMrNTxb57BaGmcuAqsqiC9e7_d0TW@mail.gmail.com>
Message-ID: <4C8B8D68.103@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@stericsson.com>
> Date: Sat, 11 Sep 2010 13:36:20 +0200
> Subject: [PATCH] MMCI: use _cansleep GPIO functions

> Currently the kernel is screaming about slowpath at me for the
> wp/cd callbacks. Swicth to the _cansleep variants so as to silence
> this.

> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/mmc/host/mmci.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f0c7313..c5fbf19 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
[...]
>  static int mmci_get_cd(struct mmc_host *mmc)
> @@ -629,7 +629,8 @@ static int mmci_get_cd(struct mmc_host *mmc)
> 
>  		status = plat->status(mmc_dev(host->mmc));
>  	} else
> -		status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
> +		status = !!gpio_get_value_cansleep(host->gpio_cd)
> +			^ plat->cd_invert;

    Should be no space between ^ and operand, no?

WBR, Sergei
