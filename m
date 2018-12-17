Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4A02145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsvxPu5V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1EirWLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bxBRfCM9azcPG/wxuUGGYGuFcyQnJHBZuZFGzythMMU=; b=KsvxPu5VwxVxW6
	GnfS2Rf5/0aM/Sy+be0LbaxXKFKuBmVm4MMRYw9skg/kpisgeoooGpnIxhCtCbbWDZMo2QvtVSZQu
	rYd6p7AIISFCvIgYKqv+tQgIJWc4BTbWIC0opYLh/Ultqv8/bdbyvqwE7UCxf98jIWLAzpTlfAYNk
	/XEVHrsZjg2Rk5ghpn43KAvHPz7mzW671Apu6oFcMaYn5LzTBiwsH9Zs0hz+76Je25ys1DP04fvmo
	a3CPIzZp3jtfZRpDGLZF94Wk1WvLYuM7AP1SiikJjcpL66ENk21jyyrG3fgTW0we0wQ2w9TYKkLdp
	ISnGRynlUME890CwzlTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqnQ-00072B-H6; Mon, 17 Dec 2018 11:10:48 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqnI-0006vP-RP
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:10:46 +0000
Received: by mail-pf1-x441.google.com with SMTP id w73so6195553pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 03:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FDBTTX+EG7DPqif7kU3jwvroKVLBpofqmwsA+RkIyl8=;
 b=F1EirWLpPP5v6q1epnGnoUd4D8dr7heYHMPH4FLKE7Li1mAT9k3YVDndOxQcLsinTy
 BnP8NkybMohf0oyyAv0S/Vp0342st5DAhqlyD6jttLnzYFjGAplZgqUHNnjm7zhxqjrE
 O34oDMb12V+owUqh7WLEDxBKzNoJwVjfpG+7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FDBTTX+EG7DPqif7kU3jwvroKVLBpofqmwsA+RkIyl8=;
 b=enw1TujeYKS4lMs7l/hn9ER1Lr2Lpv8TnabbAj148Xq89+pRgMyeFaJp74ErXa4N5v
 iXwmmml4nXDUK2s76tsHC8DOhww7V7vqni9PlhaZcLKTspu9b6q3H/XitB1UohC6ePU5
 4R1RrGwQymju5J6MzmXiMITG4I3E4nACcRAY5ASwue2/bYLUmWAkEvXvresUsHUO98Uj
 y3Do9kBbWs7qBsMjhvgfJIhC48U5B6w2Lhgnk/dn6QegpmpwUZAVeH5r6FQjmJMZ0/qN
 4Jqe+s1f2bF6eYbdYHUS0ZbQBiRKb/5vx/UCTbU1AW9o8RfJlmWVfiO7vlpZb6Sens9e
 t2Rw==
X-Gm-Message-State: AA+aEWYcyZ63Tbim/V5luFzGSQ/EqerfKkBNzmCA8VJeBtVQnYFSPlDj
 T0R7A+H7HaIQ7MQ9JCngEpZ7dw==
X-Google-Smtp-Source: AFSGD/VRlKMoR7ceqwngp3Kuo0wcqduuXC24KyDcQmx7tAzSftnXh5c9Iu0Gzd2W6qRb/j9+laa7DA==
X-Received: by 2002:a63:334a:: with SMTP id z71mr11971178pgz.400.1545045029917; 
 Mon, 17 Dec 2018 03:10:29 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id 85sm17576728pfw.17.2018.12.17.03.10.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 03:10:29 -0800 (PST)
Date: Mon, 17 Dec 2018 16:40:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Message-ID: <20181217111026.7b3tds2yz4g7opdt@vireshk-i7>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
 <20181211164249.26985-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211164249.26985-3-gregory.clement@bootlin.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_031041_014196_B954BFE9 
X-CRM114-Status: GOOD (  27.38  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11-12-18, 17:42, Gregory CLEMENT wrote:
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4e1131ef85ae..7e32a241760d 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -25,6 +25,17 @@ config ARM_ARMADA_37XX_CPUFREQ
>  	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
>  	  The Armada 37xx PMU supports 4 frequency and VDD levels.
>  
> +config ARM_ARMADA_8K_CPUFREQ
> +	tristate "Armada 8K CPUFreq driver"
> +	depends on ARCH_MVEBU && CPUFREQ_DT
> +	help
> +	  This enables the CPUFreq driver support for Marvell
> +	  Armada8k SOCs.
> +	  Armada8K device has the AP806 which supports scaling
> +	  to any full integer divider.
> +
> +	  If in doubt, say N.
> +
>  # big LITTLE core layer and glue drivers
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index d5ee4562ed06..db1564b610ac 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
>  obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
>  
>  obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
> +obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
>  obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
>  obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
>  obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
> diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
> new file mode 100644
> index 000000000000..1db1953fb43e
> --- /dev/null
> +++ b/drivers/cpufreq/armada-8k-cpufreq.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * CPUFreq support for Armada 8K
> + *
> + * Copyright (C) 2018 Marvell
> + *
> + * Omri Itach <omrii@marvell.com>
> + * Gregory Clement <gregory.clement@bootlin.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +/*
> + * Setup the opps list with the divider for the max frequency, that
> + * will be filled at runtime.
> + */
> +static const int opps_div[] __initconst = {1, 2, 3, 4};
> +
> +static struct platform_device *armada_8k_pdev;
> +static struct freq_table *freq_tables;
> +static int opps_index;
> +
> +struct freq_table {
> +	struct device *cpu_dev;
> +	struct clk *clk;
> +	unsigned int freq[ARRAY_SIZE(opps_div)];
> +};
> +
> +/* If the CPUs share the same clock, then they are in the same cluster. */
> +static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
> +					      struct cpumask *cpumask)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev = get_cpu_device(cpu);

What if this fails ?

> +		struct clk *clk = clk_get(cpu_dev, 0);
> +
> +		if (IS_ERR(clk))
> +			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +		else if (clk_is_match(clk, cur_clk))
> +			cpumask_set_cpu(cpu, cpumask);
> +
> +		clk_put(clk);

So you will do clk_put() even if clk_get() failed, that will trigger a WARN() if
I am not wrong.

> +	}
> +}
> +
> +static int armada_8k_add_opp(struct clk *clk, struct device *cpu_dev,
> +			     struct freq_table *freq_tables, int opps_index)
> +{
> +	unsigned int cur_frequency;
> +	unsigned int freq;
> +	int i, ret;
> +
> +	/* Get nominal (current) CPU frequency. */
> +	cur_frequency = clk_get_rate(clk);
> +
> +	if (!cur_frequency) {
> +		dev_err(cpu_dev,
> +			"Failed to get clock rate for this CPU\n");
> +		return -EINVAL;
> +	}
> +
> +	freq_tables[opps_index].cpu_dev = cpu_dev;
> +	for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
> +		freq = cur_frequency / opps_div[i];
> +
> +		ret = dev_pm_opp_add(cpu_dev, freq, 0);
> +		if (ret)
> +			return ret;
> +
> +		freq_tables[opps_index].freq[i] = freq;
> +	}
> +
> +	return 0;
> +}
> +
> +static void armada_8k_cpufreq_free_table(void)
> +{
> +	opps_index--;
> +	for (; opps_index >= 0; opps_index--) {
> +		int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(opps_div); i++)
> +			dev_pm_opp_remove(freq_tables[opps_index].cpu_dev,
> +					  freq_tables[opps_index].freq[i]);
> +	}
> +
> +	kfree(freq_tables);
> +}
> +
> +static int __init armada_8k_cpufreq_init(void)
> +{
> +	int ret = 0, cpu, nb_cpus;
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> +	if (!node || !of_device_is_available(node))
> +		return -ENODEV;
> +
> +	nb_cpus = num_possible_cpus();
> +	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);

Add a blank line here.

> +	/*
> +	 * For each CPU, this loop registers the operating points
> +	 * supported (which are the nominal CPU frequency and full integer
> +	 * divisions of it).
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct device *cpu_dev;
> +		struct cpumask cpus;
> +		struct clk *clk;
> +		int i, skip;
> +
> +		skip = 0;
> +		cpu_dev = get_cpu_device(cpu);
> +
> +		if (!cpu_dev) {
> +			dev_err(cpu_dev, "Cannot get CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		clk = devm_clk_get(cpu_dev, 0);

I don't think you should call devm_*() helpers on the cpu_dev pointer, this is
not like the platform device structure. The problem is that no driver gets
attached/detached from cpu_dev and so the resources may never get free.

> +
> +		if (IS_ERR(clk)) {
> +			dev_err(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
> +			ret = PTR_ERR(clk);
> +			goto remove_opp;
> +		}
> +
> +		for (i = 0; i < nb_cpus; i++) {
> +			if (clk_is_match(clk, freq_tables[i].clk)) {
> +				skip = 1;

Why not do devm_clk_put() from right here and "continue" after that. That way
you can avoid "skip" variable as well.

Also why are you doing this clk-match at all ? This looks similar to what
armada_8k_get_sharing_cpus() is doing. You can optimize this stuff better I
believe.

I will do this:

Create a cpumask variable and assign possible_cpus mask to it. And then after
each iteration of this loop, I clear "cpus" (returned from
armada_8k_get_sharing_cpus()) from the CPUs from that cpumask. That way the loop
will never try the second CPU from the same cpumask again.

> +				break;
> +			}
> +		}
> +		if (skip) {
> +			devm_clk_put(cpu_dev, clk);
> +			continue;
> +		}
> +
> +		freq_tables[opps_index].clk = clk;
> +
> +		ret = armada_8k_add_opp(clk, cpu_dev, freq_tables, opps_index);

And this opps_index thing is not very clean. Having a global variable this way
makes things very messy, which is being updated from several routines.

So if armada_8k_add_opp() fails after adding few OPPs, we will now call
armada_8k_cpufreq_free_table() which will first do opps_index-- and so you may
miss freeing the OPPs added during the last call to armada_8k_add_opp().

This is very messy and requires serious cleanup to be honest. Also it will be
more preferred if armada_8k_add_opp() cleans up all the allocations it has done
on a call if it fails in the middle of it, rather than a bigger routine freeing
both successful and failed ones.

> +		if (ret)
> +			goto remove_opp;
> +
> +		opps_index++;
> +		cpumask_clear(&cpus);
> +		armada_8k_get_sharing_cpus(clk, &cpus);
> +		dev_pm_opp_set_sharing_cpus(cpu_dev, &cpus);
> +	}
> +
> +	armada_8k_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							 NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(armada_8k_pdev);
> +	if (ret)
> +		goto remove_opp;
> +	return 0;
> +
> +remove_opp:
> +	armada_8k_cpufreq_free_table();
> +	return ret;
> +}
> +module_init(armada_8k_cpufreq_init);
> +
> +static void __exit armada_8k_cpufreq_exit(void)
> +{
> +	armada_8k_cpufreq_free_table();
> +	platform_device_unregister(armada_8k_pdev);
> +}
> +module_exit(armada_8k_cpufreq_exit);
> +
> +MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
> +MODULE_DESCRIPTION("Armada 8K cpufreq driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.19.2

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
