From: david@lechnology.com (David Lechner)
Date: Tue, 20 Mar 2018 11:57:48 -0500
Subject: [PATCH v8 18/42] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
In-Reply-To: <152156485535.183971.1627687499726447092@swboyd.mtv.corp.google.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-19-git-send-email-david@lechnology.com>
 <152156485535.183971.1627687499726447092@swboyd.mtv.corp.google.com>
Message-ID: <b4ea5efb-3fa0-b2f3-cd5f-75343e841153@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2018 11:54 AM, Stephen Boyd wrote:
> Quoting David Lechner (2018-03-15 19:52:34)
>> +
>> +typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);
> 
> Should be struct regmap *regmap?

Yes. It looks like this was copied and pasted from one of the other drivers.

Thank you for fixing it.

> 
> I've squashed this in.
> 
> diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
> index 858d3786b27b..c971111d2601 100644
> --- a/drivers/clk/davinci/da8xx-cfgchip.c
> +++ b/drivers/clk/davinci/da8xx-cfgchip.c
> @@ -736,7 +736,7 @@ static const struct platform_device_id da8xx_cfgchip_id_table[] = {
>   	{ }
>   };
>   
> -typedef int (*da8xx_cfgchip_init)(struct device *dev, void __iomem *base);
> +typedef int (*da8xx_cfgchip_init)(struct device *dev, struct regmap *regmap);
>   
>   static int da8xx_cfgchip_probe(struct platform_device *pdev)
>   {
> 
