Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0608C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB99A222DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8WFluRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB99A222DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZZ6Ah57gUqvIfXYMmsWD5pWy4BD7IhZIwt7C5vBgDnY=; b=d8WFluRRoY6AdR
	aZYhtuuoW1zUoPCAu72wRVFtxFi8G8L2O/hYSRhHMY7pS9F3noU7wjCXoK/CwKs59anocoy8NWSCh
	xLmX7nqD58LHhPp++DewdKzS6rfCy8pF6WVXZ+48z2iFkLmtTcLxVWBMc5f3MYxz6bB2vFnDGzkeh
	lxA6CWRPnz35ThYdnCEUBzlTBBolHI6Jt0ic2VVzKy1ibUuvUXSq5oQjilmRLJSQ6LdmoRJBFVByS
	g8YC8w1yGOKmYx6HovTJ8vItyUVvbOCqW02dpQ7BFi/eZ6qcvkiQ3OpXaLqI20gr091UrkYbrzKkP
	hUZuOtFv4vhxWQy5QBZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJoH-0006ck-2K; Thu, 14 Feb 2019 16:24:25 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJoB-0006MY-6Q
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:24:23 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2019 08:22:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; d="scan'208";a="299759511"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146])
 ([10.122.105.146])
 by orsmga005.jf.intel.com with ESMTP; 14 Feb 2019 08:22:16 -0800
Subject: Re: [PATCHv3 1/6] mfd: altera-sysmgr: Add SOCFPGA System Manager
To: lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 peppe.cavallaro@st.com, alexandre.torgue@st.com, joabreu@synopsys.com
References: <1548713655-25940-1-git-send-email-thor.thayer@linux.intel.com>
 <1548713655-25940-2-git-send-email-thor.thayer@linux.intel.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <e03c7b43-64d1-fd84-e2b1-e8e01569a479@linux.intel.com>
Date: Thu, 14 Feb 2019 10:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548713655-25940-2-git-send-email-thor.thayer@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_082419_289049_1C82DD2C 
X-CRM114-Status: GOOD (  32.30  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: thor.thayer@linux.intel.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, olof@lixom.net,
 mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/28/19 4:14 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The SOCFPGA System Manager register block aggregates different
> peripheral functions into one area.
> On 32 bit ARM parts, handle in the same way as syscon.
> On 64 bit ARM parts, the System Manager can only be accessed by
> EL3 secure mode. Since a SMC call to EL3 is required, this new
> driver uses regmaps similar to syscon to handle the SMC call.
> 
> Since regmaps abstract out the underlying register access, the
> changes to drivers accessing the System Manager are minimal.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 Implement Arnd's changes.
>     1. Change socfpga_is_s10() to check compatible string.
>        Add new compatible string for Stratix10 in bindings
>        and add proper detection method.
>     2. Replace base cast with resource_size_t member.
>     3. Change s10_sysmgr_regmap_cfg to altr_sysmgr_regmap_cfg to
>        be generic.
>     4. Always use 4 byte width.
>     5. Initialize the .reg_read and .reg_write in S10 case only.
>     6. Remove call to syscon in 32bit ARM case and handle both
>        ARM32 and ARM64 in of_sysmgr_register().
>     7. Replace IS_ERR_OR_NULL() with IS_ERR().
>     8. Remove compatible check functions except phandle function.
> v3 Implement 2nd set of Arnd's changes.
>     1. Use probe to register and create the regmap.
>     2. Remove global pointer and use traditional probe() method
>        of saving altr_sysmgr in private device data.
>     3. Lookup function using phandle finds altr_sysmgr and
>        returns its regmap.
>     4. Fix copyright dates.
>     5. Remove socfpga_is_s10() function since only used 1 time.
>     6. Remove unused function prototypes from header file.
>     7. Remove the SMC defines from header file and use the
>        defines from the recently accepted Intel Service Layer
>        header (stratix10-smc.h).
> ---
>   MAINTAINERS                       |   6 ++
>   drivers/mfd/Kconfig               |  10 ++
>   drivers/mfd/Makefile              |   1 +
>   drivers/mfd/altera-sysmgr.c       | 210 ++++++++++++++++++++++++++++++++++++++
>   include/linux/mfd/altera-sysmgr.h |  29 ++++++
>   5 files changed, 256 insertions(+)
>   create mode 100644 drivers/mfd/altera-sysmgr.c
>   create mode 100644 include/linux/mfd/altera-sysmgr.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d04cebb4a71..0d2ccb710213 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -708,6 +708,12 @@ L:	linux-gpio@vger.kernel.org
>   S:	Maintained
>   F:	drivers/gpio/gpio-altera.c
>   
> +ALTERA SYSTEM MANAGER DRIVER
> +M:	Thor Thayer <thor.thayer@linux.intel.com>
> +S:	Maintained
> +F:	drivers/mfd/altera-sysmgr.c
> +F:	include/linux/mfd/altera-sysgmr.h
> +
>   ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
>   M:	Thor Thayer <thor.thayer@linux.intel.com>
>   S:	Maintained
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..8629cf13520e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -29,6 +29,16 @@ config MFD_ALTERA_A10SR
>   	  accessing the external gpio extender (LEDs & buttons) and
>   	  power supply alarms (hwmon).
>   
> +config MFD_ALTERA_SYSMGR
> +	bool "Altera SOCFPGA System Manager"
> +	depends on (ARCH_SOCFPGA || ARCH_STRATIX10) && OF
> +	select MFD_SYSCON
> +	help
> +	  Select this to get System Manager support for all Altera branded
> +	  SOCFPGAs. The SOCFPGA System Manager handles all SOCFPGAs by
> +	  using regmap_mmio accesses for ARM32 parts and SMC calls to
> +	  EL3 for ARM64 parts.
> +
>   config MFD_ACT8945A
>   	tristate "Active-semi ACT8945A"
>   	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..c649f6efed5f 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -233,6 +233,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
>   obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>   
>   obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> +obj-$(CONFIG_MFD_ALTERA_SYSMGR) += altera-sysmgr.o
>   obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
>   
>   obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
> diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
> new file mode 100644
> index 000000000000..ddc02241e265
> --- /dev/null
> +++ b/drivers/mfd/altera-sysmgr.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2018-2019, Intel Corporation.
> + *  Copyright (C) 2012 Freescale Semiconductor, Inc.
> + *  Copyright (C) 2012 Linaro Ltd.
> + *
> + *  Based on syscon driver.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mfd/altera-sysmgr.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/**
> + * struct altr_sysmgr - Altera SOCFPGA System Manager
> + * @regmap: the regmap used for System Manager accesses.
> + * @base  : the base address for the System Manager
> + */
> +struct altr_sysmgr {
> +	struct regmap   *regmap;
> +	resource_size_t *base;
> +};
> +
> +static struct platform_driver altr_sysmgr_driver;
> +
> +/**
> + * s10_protected_reg_write
> + * Write to a protected SMC register.
> + * @base: Base address of System Manager
> + * @reg:  Address offset of register
> + * @val:  Value to write
> + * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
> + *	   INTEL_SIP_SMC_REG_ERROR on error
> + *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
> + */
> +static int s10_protected_reg_write(void *base,
> +				   unsigned int reg, unsigned int val)
> +{
> +	struct arm_smccc_res result;
> +	unsigned long sysmgr_base = (unsigned long)base;
> +
> +	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE, sysmgr_base + reg,
> +		      val, 0, 0, 0, 0, 0, &result);
> +
> +	return (int)result.a0;
> +}
> +
> +/**
> + * s10_protected_reg_read
> + * Read the status of a protected SMC register
> + * @base: Base address of System Manager.
> + * @reg:  Address of register
> + * @val:  Value read.
> + * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
> + *	   INTEL_SIP_SMC_REG_ERROR on error
> + *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
> + */
> +static int s10_protected_reg_read(void *base,
> +				  unsigned int reg, unsigned int *val)
> +{
> +	struct arm_smccc_res result;
> +	unsigned long sysmgr_base = (unsigned long)base;
> +
> +	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sysmgr_base + reg,
> +		      0, 0, 0, 0, 0, 0, &result);
> +
> +	*val = (unsigned int)result.a1;
> +
> +	return (int)result.a0;
> +}
> +
> +static struct regmap_config altr_sysmgr_regmap_cfg = {
> +	.name = "altr_sysmgr",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
> +/**
> + * sysmgr_match_phandle
> + * Matching function used by driver_find_device().
> + * Return: True if match is found, otherwise false.
> + */
> +static int sysmgr_match_phandle(struct device *dev, void *data)
> +{
> +	return dev->of_node == (struct device_node *)data;
> +}
> +
> +/**
> + * altr_sysmgr_regmap_lookup_by_phandle
> + * Find the sysmgr previous configured in probe() and return regmap property.
> + * Return: regmap if found or error if not found.
> + */
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +						    const char *property)
> +{
> +	struct device *dev;
> +	struct altr_sysmgr *sysmgr;
> +	struct device_node *sysmgr_np;
> +
> +	if (property)
> +		sysmgr_np = of_parse_phandle(np, property, 0);
> +	else
> +		sysmgr_np = np;
> +
> +	if (!sysmgr_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	dev = driver_find_device(&altr_sysmgr_driver.driver, NULL,
> +				 (void *)sysmgr_np, sysmgr_match_phandle);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);

I just realized that I need a of_put(sysmgr_np) here since 
of_parse_phandle() increments the refcount. I'll fix this and resubmit.

> +
> +	sysmgr = dev_get_drvdata(dev);
> +
> +	return sysmgr->regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
> +
> +static int sysmgr_probe(struct platform_device *pdev)
> +{
> +	struct altr_sysmgr *sysmgr;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	struct regmap_config sysmgr_config = altr_sysmgr_regmap_cfg;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	sysmgr = devm_kzalloc(dev, sizeof(*sysmgr), GFP_KERNEL);
> +	if (!sysmgr)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
> +	sysmgr_config.max_register = resource_size(res) -
> +				     sysmgr_config.reg_stride;
> +	if (of_device_is_compatible(np, "altr,sys-mgr-s10")) {
> +		/* Need physical address for SMCC call */
> +		sysmgr->base = (resource_size_t *)res->start;
> +		sysmgr_config.reg_read = s10_protected_reg_read;
> +		sysmgr_config.reg_write = s10_protected_reg_write;
> +
> +		regmap = devm_regmap_init(dev, NULL, sysmgr->base,
> +					  &sysmgr_config);
> +	} else {
> +		sysmgr->base = devm_ioremap(dev, res->start,
> +					    resource_size(res));
> +		if (!sysmgr->base)
> +			return -ENOMEM;
> +
> +		sysmgr_config.max_register = res->end - res->start - 3;
> +		regmap = devm_regmap_init_mmio(dev, sysmgr->base,
> +					       &sysmgr_config);
> +	}
> +
> +	if (IS_ERR(regmap)) {
> +		pr_err("regmap init failed\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	sysmgr->regmap = regmap;
> +
> +	platform_set_drvdata(pdev, sysmgr);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id altr_sysmgr_of_match[] = {
> +	{ .compatible = "altr,sys-mgr" },
> +	{ .compatible = "altr,sys-mgr-s10" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, altr_sysmgr_of_match);
> +
> +static struct platform_driver altr_sysmgr_driver = {
> +	.probe =  sysmgr_probe,
> +	.driver = {
> +		.name = "altr,system_manager",
> +		.of_match_table = altr_sysmgr_of_match,
> +	},
> +};
> +
> +static int __init altr_sysmgr_init(void)
> +{
> +	return platform_driver_register(&altr_sysmgr_driver);
> +}
> +core_initcall(altr_sysmgr_init);
> +
> +static void __exit altr_sysmgr_exit(void)
> +{
> +	platform_driver_unregister(&altr_sysmgr_driver);
> +}
> +module_exit(altr_sysmgr_exit);
> +
> +MODULE_AUTHOR("Thor Thayer <>");
> +MODULE_DESCRIPTION("SOCFPGA System Manager driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/altera-sysmgr.h b/include/linux/mfd/altera-sysmgr.h
> new file mode 100644
> index 000000000000..b1ef11a83872
> --- /dev/null
> +++ b/include/linux/mfd/altera-sysmgr.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018-2019 Intel Corporation
> + * Copyright (C) 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2012 Linaro Ltd.
> + */
> +
> +#ifndef __LINUX_MFD_ALTERA_SYSMGR_H__
> +#define __LINUX_MFD_ALTERA_SYSMGR_H__
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/firmware/intel/stratix10-smc.h>
> +
> +struct device_node;
> +
> +#ifdef CONFIG_MFD_ALTERA_SYSMGR
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +						    const char *property);
> +#else
> +static inline struct regmap *
> +altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +				     const char *property)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +#endif
> +
> +#endif /* __LINUX_MFD_ALTERA_SYSMGR_H__ */
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
