From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 22 Sep 2015 14:07:20 +0100
Subject: [PATCH 3/3] regulator: vexpress: Fix module autoload for OF
 platform driver
In-Reply-To: <20150918170951.GA28327@goodgumbo.baconseed.org>
References: <20150918170951.GA28327@goodgumbo.baconseed.org>
Message-ID: <20150922130720.GA31314@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 06:09:51PM +0100, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks,
Liviu

> ---
>  drivers/regulator/vexpress.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/vexpress.c b/drivers/regulator/vexpress.c
> index bed9d3e..c810cbb 100644
> --- a/drivers/regulator/vexpress.c
> +++ b/drivers/regulator/vexpress.c
> @@ -103,6 +103,7 @@ static const struct of_device_id vexpress_regulator_of_match[] = {
>  	{ .compatible = "arm,vexpress-volt", },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, vexpress_regulator_of_match);
>  
>  static struct platform_driver vexpress_regulator_driver = {
>  	.probe = vexpress_regulator_probe,
> -- 
> 2.4.6
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
