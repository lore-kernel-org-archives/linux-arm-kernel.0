Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC00C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF2420855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PIzGJjrA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXTQ10Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF2420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wCGm/M4Mepojfu8UgQcSOFhIWAyCZcExc9mghQb0/8k=; b=PIzGJjrAAIzeBV
	1QH9HMg1hOvSO/LVl3uF4GH1FDyF2SB8wt9ENdejN0zxaSPtBaw5L5ch6WL0BgIC9T2VBA0ho1rNt
	if53lf9XwrxDXZFkVjSrjTB62Bj9LnE7tVFEKcnGt/gxrREighzHkpMP+hGGVM7yRPM3BzmesYyDh
	kYC1YB8w8t3p6XXQpVaO0EQtO0zqeO7A2ONFCmVAlRJ2oV5m6BgQwt2b3QNBol6YRhhYoI9mMFMrY
	Yf/RLXBk2T+dCn3Ihc6rKr8Z8sLgKc98D2HFyCnIXAH6aOYfzHEjv6IXODQqWJ7QWTcEH5jczAfRz
	pAdXBTHsaS1WwK0pJOuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4at-0006uN-52; Thu, 17 Jan 2019 10:08:15 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4ap-0006u2-JL
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:08:13 +0000
Received: by mail-pg1-x542.google.com with SMTP id w7so4218885pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+HjIxHy2YTkkHug9kwKKVx+R4/lzJQ2zziaHnfwNtT0=;
 b=gXTQ10XnlhXUwSxfQybKblMRmC9bRikmPdTT7rRHBFXGAyRW9/ly/WqIiLeziMB9UH
 N+JNiE0z4eITRZIaIFp+hRVpGVi4mrgjQBRwgPGLxrOqU4iDNE0762Ba/nI1nGgwd2RG
 OZFVQTJzmUO1x4Z8F8AIsErji3dEtamnF2Jnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+HjIxHy2YTkkHug9kwKKVx+R4/lzJQ2zziaHnfwNtT0=;
 b=J3NjgiJKV6otgkr5m4hBLHZteH8J7Y2vIPQqUb1AWSp1LluJQAFfBgJ/sJhPUcCTlz
 5QSe2GOV8Euf/Qbw+EUOvOQaVJvEFElHY+NqbaoEtojQG0u77yCj2dE9oqnI+baed6Vi
 u55dp1+r0ucvTFS66ne1Qd09hk+2xquWsLq1LatsnspCpp7tQGCgX/DpOmo0d30wewa6
 hLUvo/rc+AUYu/keH1XB7NJor1r6J0YrmDlVZyhzn3WiU/IWkYKl97MHoOmqsHvVjLff
 zVTVGtkXWDoeC5L4kV3TCrTq9v3eJBQQ9JXx8mACWNIQ/5nvpt89KPI2PYu2/VUD/pwM
 wBPg==
X-Gm-Message-State: AJcUukf5YwcBgXsUxAteHoZ2suBPMRYraUmqy3HDjjxnaOJ4Gt0xtlST
 o3fFSOeEb7oqG/cEc7OoKKCTUQ==
X-Google-Smtp-Source: ALg8bN5vOOzlmwPiCQJiExLQG1QkeO2rcKXMrjtF1L3GCzHIDBhN9sVTDkpwnm2Z2MIRxvddiFJlLA==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr14268347pfc.38.1547719690261; 
 Thu, 17 Jan 2019 02:08:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id y89sm3127863pfa.136.2019.01.17.02.08.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 02:08:09 -0800 (PST)
Date: Thu, 17 Jan 2019 15:38:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Message-ID: <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_020811_689287_D8B220FB 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
 david.brown@linaro.org, linux-clk@vger.kernel.org, jassisinghbrar@gmail.com,
 jagan@amarulasolutions.com, andy.gross@linaro.org, sibis@codeaurora.org,
 devicetree@vger.kernel.org, arnd@arndb.de, niklas.cassel@linaro.org,
 robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17-01-19, 09:38, Jorge Ramirez wrote:
> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
> to disable the clocks that were enabled by the firwmare and not by the
> drivers.
> 
> the cpufreq driver does not enable the cpu clock.
> 
> so when clk_change_rate is called, the enable_count counter is not
> incremented and therefore it just remains null since this was enabled by
> the firmware.
> 
> I tried doing:
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb..5a9f83e 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -124,6 +124,10 @@ static int resources_available(void)
>                 return ret;
>         }
> 
> + ret = clk_prepare_enable(cpu_clk);
> + if (ret)
> +         return ret;
> +
>         clk_put(cpu_clk);
> 
>         name = find_supply_name(cpu_dev);
> 
> 
> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
> the system wide consequences of that change to cpufreq.

If the cpufreq driver enables it then it should disable it on exit as
well, right ? And in that case if you unload your driver's module, you
will hang the system as the clock will get disabled :)

Every other platform must either be marking it with CLK_IGNORE_UNUSED
or they must be doing clk_enable from somewhere, maybe the CPU online
path, not sure though.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
