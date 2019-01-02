Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7039218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOlHKoms";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioFq7XpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7039218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1fJH1uyVX0r+WL34JXTM5nv9QXaV0r1Y3pKYQ04Jw7E=; b=jOlHKomsZ/sDRd
	ckdF9DVaR21cVU0yHDMUxwaB4O5xb2gePjAjYh1QidAFeXDtEMxIbeLQMS2odWVIsRmfnqvgC/AsA
	lD9UyTSt5WIIsN3x5rdJs3+vEOy0Vpu0zVWN+p9HyUACfHpfKfhJPMDax3koECLgjk1gfhOu3jV4D
	O/Z/bp6DXk1p33jIWrnWtUTE4BrDzurUf2gjpSJN4SkdTwBTArKhhHVZ5a7XVHmytrJ2ebZ4EbVrb
	bcxg2KA/E0UAhAMRMvwG10DgtDX9PvcxS3Jm3b27zeI/VPBAGBhi8SFCBieezvl+mf0K21DxmQaj1
	Xxq/4BOmNt6YgcbDhXgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gedxW-0001wb-Po; Wed, 02 Jan 2019 10:41:10 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gedxP-0001vJ-NN
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 10:41:05 +0000
Received: by mail-pf1-x443.google.com with SMTP id c123so15039193pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MM9OXlN6ze64wzQujvrfuLnJyUYzHqOmtBsApT1Aa84=;
 b=ioFq7XpB3rGml5C2EbnlJyko/9bnl6qq6E0t/farydxdFLO1pp9mg7ro+Kc+GNn6Vp
 u919AT9Oh2irB72EgpfE/sEW41YeiDHgLBdn8rsnaGfbfsYJ7dbBxqRSN62zlx3pzXHe
 q4Wo2+9kxh+IuW73f4RZLu1ctH6E+2yfhTWCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MM9OXlN6ze64wzQujvrfuLnJyUYzHqOmtBsApT1Aa84=;
 b=RpOxFt7OMwf9cdI5AKgDI5imhfao904Dk1nj9OeNHtagQ3VCBH6ymNF5w3V7sRookT
 CjdwjqW891Ehsr8iErp6iInD8cSwzcVCZl0P835Bka3pGORvYfcEEbiBh04uRWXFjEjN
 Vwha/RzG9zrQlV3eCjWF7VRSkuwVSm1qkr20a41/iQXJURnYFGfb75zF3fbekp/sJC5M
 /V1jGsBea9dF6LcyTV6wrkukG9YxVAuYmJDNeyPwnlDm4ja6aYiDtdN4gFMlhZeEn9sX
 HWyDottB0xiWOsHR+hwLepV+zaWw28+yqjKOEjVtKAPsQCDA/P6N7IydTLPIzmSOChM6
 r8Qw==
X-Gm-Message-State: AA+aEWaNhPSW0CmAuuUeNuQRRrBcITJcuXWPuMv0ujQREYEYDVWvfLQ1
 ZjCP59ZjvUQpTXhinmQBQdx34g==
X-Google-Smtp-Source: ALg8bN4CTgZUBpIA0YPipuz+BWu82Oua9bAwWCxRuewilTwQ9GTXWsNa3ckmDIF3Y8FqkZCJLYMxNA==
X-Received: by 2002:a62:3603:: with SMTP id d3mr45366985pfa.146.1546425660218; 
 Wed, 02 Jan 2019 02:41:00 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id c4sm106081145pfm.151.2019.01.02.02.40.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 02:40:59 -0800 (PST)
Date: Wed, 2 Jan 2019 16:10:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v4 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Message-ID: <20190102104057.hbgoobe77ftqsq5p@vireshk-i7>
References: <20181226153342.17796-1-gregory.clement@bootlin.com>
 <20181226153342.17796-3-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181226153342.17796-3-gregory.clement@bootlin.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_024103_831789_5DCEBF46 
X-CRM114-Status: GOOD (  19.91  )
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

On 26-12-18, 16:33, Gregory CLEMENT wrote:
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
> +
> +struct freq_table {
> +	struct device *cpu_dev;
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
> +		struct device *cpu_dev;
> +		struct clk *clk;
> +
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev) {
> +			pr_warn("Failed to get cpu%d device\n", cpu);
> +			continue;
> +		}
> +
> +		clk = clk_get(cpu_dev, 0);
> +		if (IS_ERR(clk))
> +			pr_warn("Cannot get clock for CPU %d\n", cpu);
> +		else if (clk_is_match(clk, cur_clk))
> +			cpumask_set_cpu(cpu, cpumask);
> +
> +		if (!IS_ERR(clk))
> +			clk_put(clk);

You can write this as:

		clk = clk_get(cpu_dev, 0);
		if (IS_ERR(clk)) {
			pr_warn("Cannot get clock for CPU %d\n", cpu);
		} else {
                        if (clk_is_match(clk, cur_clk))
        			cpumask_set_cpu(cpu, cpumask);

			clk_put(clk);
                }

> +	}
> +}
> +
> +static int __init armada_8k_add_opp(struct clk *clk, struct device *cpu_dev,
> +				    struct freq_table *freq_tables,
> +				    int opps_index)
> +{
> +	unsigned int cur_frequency;
> +	unsigned int freq;
> +	int i, ret;
> +
> +	/* Get nominal (current) CPU frequency. */
> +	cur_frequency = clk_get_rate(clk);
> +	if (!cur_frequency) {
> +		dev_err(cpu_dev, "Failed to get clock rate for this CPU\n");
> +		return -EINVAL;
> +	}
> +
> +	freq_tables[opps_index].cpu_dev = cpu_dev;
> +
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
> +static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
> +{
> +	int opps_index, nb_cpus = num_possible_cpus();
> +
> +	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
> +		int i;
> +
> +		/* If cpu_dev is NULL then we reached the end of the array */
> +		if (!freq_tables[opps_index].cpu_dev)
> +			break;
> +
> +		for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
> +			/*
> +			 * A 0Hz frequency is not valid, this meant
> +			 * that it was not yet initialized so there is
> +			 * no more opp to free
> +			 */
> +			if (freq_tables[opps_index].freq[i] == 0)
> +				break;
> +
> +			dev_pm_opp_remove(freq_tables[opps_index].cpu_dev,
> +					  freq_tables[opps_index].freq[i]);
> +		}
> +	}
> +
> +	kfree(freq_tables);
> +}
> +
> +static int __init armada_8k_cpufreq_init(void)
> +{
> +	int ret = 0, opps_index = 0, cpu, nb_cpus;
> +	struct freq_table *freq_tables;
> +	struct device_node *node;
> +	struct cpumask cpus;
> +
> +	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
> +	if (!node || !of_device_is_available(node))
> +		return -ENODEV;
> +
> +	nb_cpus = num_possible_cpus();
> +	freq_tables = kcalloc(nb_cpus, sizeof(*freq_tables), GFP_KERNEL);
> +	cpumask_copy(&cpus, cpu_possible_mask);
> +
> +	/*
> +	 * For each CPU, this loop registers the operating points
> +	 * supported (which are the nominal CPU frequency and full integer
> +	 * divisions of it).
> +	 */
> +	for_each_cpu(cpu, &cpus) {
> +		struct cpumask shared_cpus;
> +		struct device *cpu_dev;
> +		struct clk *clk;
> +
> +		cpu_dev = get_cpu_device(cpu);
> +
> +		if (!cpu_dev) {
> +			pr_err("Cannot get CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		clk = clk_get(cpu_dev, 0);
> +
> +		if (IS_ERR(clk)) {
> +			pr_err("Cannot get clock for CPU %d\n", cpu);
> +			ret = PTR_ERR(clk);
> +			goto remove_opp;
> +		}
> +
> +		ret = armada_8k_add_opp(clk, cpu_dev, freq_tables, opps_index);
> +		if (ret) {
> +			clk_put(clk);
> +			goto remove_opp;
> +		}
> +
> +		opps_index++;
> +		cpumask_clear(&shared_cpus);
> +		armada_8k_get_sharing_cpus(clk, &shared_cpus);
> +		dev_pm_opp_set_sharing_cpus(cpu_dev, &shared_cpus);
> +		cpumask_andnot(&cpus, &cpus, &shared_cpus);
> +		clk_put(clk);
> +	}
> +
> +	armada_8k_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							 NULL, 0);
> +	ret = PTR_ERR_OR_ZERO(armada_8k_pdev);
> +	if (ret)
> +		goto remove_opp;
> +
> +	platform_set_drvdata(armada_8k_pdev, freq_tables);
> +
> +	return 0;
> +
> +remove_opp:
> +	armada_8k_cpufreq_free_table(freq_tables);
> +	return ret;
> +}
> +module_init(armada_8k_cpufreq_init);
> +
> +static void __exit armada_8k_cpufreq_exit(void)
> +{
> +	struct freq_table *freq_tables = platform_get_drvdata(armada_8k_pdev);
> +
> +	armada_8k_cpufreq_free_table(freq_tables);
> +	platform_device_unregister(armada_8k_pdev);

The sequence should be exact opposite, unregister first and then free tables.

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
