From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 02 Jan 2018 16:36:19 +0100
Subject: [PATCH 05/12] pinctrl: armada-37xx: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-6-git-send-email-Julia.Lawall@lip6.fr> (Julia
 Lawall's message of "Tue, 2 Jan 2018 14:28:01 +0100")
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <87y3lgb7d8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,
 
 On mar., janv. 02 2018, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
>
> Done using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


PS: actually the intent was not to do a const-discarding cast it was
just a useless cast! :)


>
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -u -p a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -1006,11 +1006,11 @@ static int armada_37xx_pinctrl_register(
>  static const struct of_device_id armada_37xx_pinctrl_of_match[] = {
>  	{
>  		.compatible = "marvell,armada3710-sb-pinctrl",
> -		.data = (void *)&armada_37xx_pin_sb,
> +		.data = &armada_37xx_pin_sb,
>  	},
>  	{
>  		.compatible = "marvell,armada3710-nb-pinctrl",
> -		.data = (void *)&armada_37xx_pin_nb,
> +		.data = &armada_37xx_pin_nb,
>  	},
>  	{ },
>  };
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
