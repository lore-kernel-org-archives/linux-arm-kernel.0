From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 May 2014 08:12:46 +0100
Subject: [PATCH v2 3/7] mfd: add support for sun6i PRCM
 (Power/Reset/Clock Management) unit
In-Reply-To: <536BE366.8080907@free-electrons.com>
References: <1399483554-8824-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399483554-8824-4-git-send-email-boris.brezillon@free-electrons.com>
 <20140508110205.GB5767@lee--X1>
 <536BE366.8080907@free-electrons.com>
Message-ID: <20140509071246.GE5767@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static struct platform_driver sun6i_prcm_driver = {
> >> +	.driver = {
> >> +		.name = "sun6i-prcm",
> >> +		.owner = THIS_MODULE,
> >> +		.of_match_table = sun6i_prcm_dt_ids,
> >> +	},
> >> +	.probe = sun6i_prcm_probe,
> > You need a .remove() call-back.
> 
> This driver cannot be compiled as module (see the Kconfig definition)
> and the devices are not hotpluggable, as a result a probed device will
> never be removed.
> 
> Do you still want me to implement the remove function ?

.remove() also be run on shut down.  It's best practice to have one.

> >> +module_platform_driver(sun6i_prcm_driver);
> >> +
> >> +MODULE_AUTHOR("Boris BREZILLON <boris.brezillon@free-electrons.com>");
> >> +MODULE_DESCRIPTION("Allwinner sun6i PRCM driver");
> >> +MODULE_LICENSE("GPL v2");
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
