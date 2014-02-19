From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 19 Feb 2014 15:14:09 +0400
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggdjIgMS8yXSBtZmQ6IHN5c2NvbjogU3VwcG9ydCBl?=
 =?UTF-8?B?YXJseSBpbml0aWFsaXphdGlvbg==?=
In-Reply-To: <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
References: <cover.1392807832.git.michal.simek@xilinx.com>
 <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
Message-ID: <1392808449.306481065@f243.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 19 ??????? 2014, 12:04 +01:00 ?? Michal Simek <michal.simek@xilinx.com>:
> Some platforms need to get system controller
> ready as soon as possible.
> The patch provides early_syscon_initialization
> which create early mapping for all syscon compatible
> devices in early_syscon_probe.
> Regmap is get via syscon_early_regmap_lookup_by_phandle()
> 
> Regular device probes attach device to regmap
> via regmap_attach_dev().
> 
> For early syscon initialization is necessary to extend
> struct syscon and provide remove function
> which unmap all early init structures.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
...

> +static struct of_device_id of_syscon_ids[] = {
> +	{ .compatible = "syscon" },
> +	{},
>  };

You should move syscon_ids out of #ifdef CONFIG_OF

---
