From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Oct 2015 16:08:02 +0200
Subject: [PATCH] PM / AVS: rockchip-io: Fix module autoload for OF
 platform driver
In-Reply-To: <20150918165258.GA27398@goodgumbo.baconseed.org>
References: <20150918165258.GA27398@goodgumbo.baconseed.org>
Message-ID: <1959860.KNdhvIZiRr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. September 2015, 18:52:58 schrieb Luis de Bethencourt:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

looks obviously correct.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


depending on how Kevin wants to handle that single patch, you might want to 
resent it with Rafael Wysocki in the to-list though


Heiko

> ---
> 
> Hello,
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
> 
> Thanks,
> Luis
> 
>  drivers/power/avs/rockchip-io-domain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/avs/rockchip-io-domain.c
> b/drivers/power/avs/rockchip-io-domain.c index 2e30002..8099456 100644
> --- a/drivers/power/avs/rockchip-io-domain.c
> +++ b/drivers/power/avs/rockchip-io-domain.c
> @@ -271,6 +271,7 @@ static const struct of_device_id
> rockchip_iodomain_match[] = { },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
> 
>  static int rockchip_iodomain_probe(struct platform_device *pdev)
>  {
