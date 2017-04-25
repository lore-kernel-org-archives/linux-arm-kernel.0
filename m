From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Apr 2017 00:11:32 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1493156063-8446-2-git-send-email-yamada.masahiro@socionext.com>
References: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
 <1493156063-8446-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <59735505.eYpuzA7ihW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 26. April 2017, 06:34:22 CEST schrieb Masahiro Yamada:
> of_device_id::data is an opaque pointer.  No explicit cast is needed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 7813599..da1a38f 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -2769,25 +2769,25 @@ static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
> 
>  static const struct of_device_id rockchip_pinctrl_dt_match[] = {
>  	{ .compatible = "rockchip,rk1108-pinctrl",
> -		.data = (void *)&rk1108_pin_ctrl },
> +		.data = &rk1108_pin_ctrl },

You should base your pinctrl-patches on top of Linus' branch, especially
as the rk1108->rv1108 is in there:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/drivers/pinctrl/pinctrl-rockchip.c?h=for-next&id=b9c6dcab265e93c47bdcd99ab7c6acda90ed669b

With the above fixed:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
