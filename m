From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 16 May 2015 15:54:17 +0200
Subject: [PATCH 1/7] arm: imx: power-off: change to syscon to access
 register
In-Reply-To: <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150516135417.GK3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/05/2015 at 21:36:24 +0800, Frank.Li at freescale.com wrote :
>  static int imx_poweroff_probe(struct platform_device *pdev)
>  {
> -	snvs_base = of_iomap(pdev->dev.of_node, 0);
> -	if (!snvs_base) {
> +	struct device_node *nd;
> +
> +	nd = of_get_parent(pdev->dev.of_node);
> +	if (!nd)
> +		return -ENODEV;
> +	snvs = syscon_node_to_regmap (nd);
You should remove that space ---^


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
