Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A685C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA2021738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="onU32m8a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuNWNOiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA2021738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kurAvGLITIk4qfDTWuWFPPI9ZvxKaZnuM6e+34Dxv5U=; b=onU32m8arS77rR
	uQdjlVT2VpfWkuqifxSE4G6dy1igC5I7tw10rON1WLIXcbDMQwFTTFLhkv0Tdw+Ms3cRzg2LColjR
	fWc52Gpfxcpgcc7HhAjg/wf1aB5ZK5VbO3oAfpe2k+SdHPMv/RUoe4yagLH6Z9bmVoOnTuYuJJ7iT
	/BUyeqVf642U3sdTg79K4BhuwWoCSx635HT1KKQYgNWYBb+D2JxZfqyyN3rpAWJh0yglg43Z0HRiN
	fg+ZYNVVkk2SoNyAWeb8fwG7m0UYgWo9IbnoB+91Xd9YC/TucqwHCDJeXKiWCnVrRA0bld4PK/v9+
	Xx217SvsMn17lAvTnYtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCBO-0003Nr-LC; Mon, 28 Jan 2019 19:02:58 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCBK-0003NT-Je
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:02:56 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so8424872pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0UeBKRmlOKYymh/cEL0B20ZM7YaatafhkCzpbkFAoFQ=;
 b=iuNWNOiKGFnZUjv1xiem14aYA7nKWnY93Ou1LFrVt4MTk/kdWOoIVqcDPm8U52wvzN
 lRif1wWZswl3O0PdY25yY9RIV3E2HJkbTHiH5DxhrOVu5KFj8IEVTjn67gmz+SrpZltq
 iG/3LTh7CFVpJojBl7YjPP+BnfFQvL00mgBGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0UeBKRmlOKYymh/cEL0B20ZM7YaatafhkCzpbkFAoFQ=;
 b=SfSz82xHnBoGQB5zVfW+T2toAAsUQ6UT9c+NqDHjR7umgJ3KejbVcpghiNz2HLNCV+
 GY35XR1PSS2j8wc4cNXCLcbavvYfRLeG6BsZdRgMtWt+9PgszvlGE0bzj5bkwQUGvDbx
 eSjZcEuzpZ6A3VzlY9Rq5X5tRSwOpQ/JrPvCxmC8aFCezWMIZ+v49AWxpQpnYyKm6oE9
 6u0rsT7A8mQbB5VcUy9VV0Nte37H1fV6ZQ2x+wgL7VZS9z2t6bSV+CggAcn/A5/Vd7b4
 4fnuGJmUemQSETFDFteGO2fb4o/su4Fj+NLNQYd/py2n86idZyg66MD5ZR51UM6KDMU7
 S12Q==
X-Gm-Message-State: AJcUukfkZ97qoarRo7XXI5EMZpZrfzZAKC6a63ubSqg7xMi1n1YmoF3x
 Uw6XOgHRaKnsI3Ua0SYnmyF7ww==
X-Google-Smtp-Source: ALg8bN7v9iOVPw+QC2CG2f/8uJmADLIoAiqORJU5jr/Wi2SXuCAuj01Y5sUUNjdX7MQW6Ap0LVDZmA==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr20800227pgf.33.1548702173594; 
 Mon, 28 Jan 2019 11:02:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id o1sm61659860pgn.63.2019.01.28.11.02.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 11:02:52 -0800 (PST)
Date: Mon, 28 Jan 2019 11:02:51 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Message-ID: <20190128190251.GH81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-2-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_110254_645978_A96A6441 
X-CRM114-Status: GOOD (  29.93  )
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
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, nm@ti.com,
 lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, liviu.dudau@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

rHi Quentin,

On Mon, Jan 28, 2019 at 04:55:16PM +0000, Quentin Perret wrote:
> The Energy Model (EM) framework provides an API to let drivers register
> the active power of CPUs. The drivers are expected to provide a callback
> method which estimates the power consumed by a CPU at each available
> performance levels. How exactly this should be implemented, however,
> depends on the platform.
> 
> On some systems, PM_OPP knows the voltage and frequency at which CPUs
> can run. When coupled with the CPU 'capacitance' (as provided by the
> 'dynamic-power-coefficient' devicetree binding), it is possible to
> estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
> C its capacitance and V and f respectively the voltage and frequency of
> the OPP. The Intelligent Power Allocator (IPA) thermal governor already
> implements that estimation method, in the thermal framework.
> 
> However, this power estimation method can be applied to any platform
> where all the parameters are known (C, V and f), and not only those
> suffering thermal issues. As such, the code implementing this feature
> can be re-used to also populate the EM framework now used by EAS.
> 
> As a first step, introduce in PM_OPP a helper function which CPUFreq
> drivers can use to register into the EM framework. This duplicates the
> power estimation done in IPA until it can be migrated to using the EM
> framework. This will be done later, once the EM framework has support
> for at least all platforms currently supported by IPA.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/opp/of.c       | 60 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  5 ++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..7572a2eb2fd4 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1047,3 +1047,63 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return of_node_get(opp->np);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/**
> + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> + * @mW:		pointer to the power estimate in milli-watts
> + * @KHz:	pointer to the OPP's frequency, in kilo-hertz

nit: should be kHz

> + * @cpu:	CPU for which power needs to be estimated
> + *
> + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> + * and updates @KHz and @mW accordingly.
> + *
> + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> + * respectively the voltage and frequency of the OPP.
> + *
> + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> + * calculation failed because of missing parameters, 0 otherwise.
> + */
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)

I think it is more common to put the input parameters first, then the
output ones, i.e. cpu, kHz, mW.

> +{
> +	unsigned long mV, Hz, MHz;
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	u32 cap;
> +	u64 tmp;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret)
> +		return -EINVAL;
> +
> +	Hz = *KHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	MHz = Hz / 1000000;
> +	tmp = (u64)cap * mV * mV * MHz;
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*KHz = Hz / 1000;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0a2a88e5a383..fedde14f5187 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  
>  #endif		/* __LINUX_OPP_H__ */

Besides the nits above:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
