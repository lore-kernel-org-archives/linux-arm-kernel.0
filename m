Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:49:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC7B20854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o6HUvZpq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTr8ggFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC7B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vRVsGn84Vy93LzG0ETeNBsBicmZjM404Z+R8+Xp9wKE=; b=o6HUvZpqDpOXI5
	0vsou1m+2xym5GOYqh6gkJXclfByzIskAz4sQrNX7niw1hzX6EvHt8lVTMRYwy+NCXFU6yyHHgpct
	PP5IQoC/ZWKxJjtT+vBhj1i1r1LwEgbaJ+Q7ivtYaU9CPwCLuQm3/tK+0G62XB4OQpH3bVIUZ+sVe
	wvZNJBWI+wk/eKQWhxZxIeo7pgTrD+R/riWIbNtwokEKmos5hP6bZ3JKjaHlj2XYErqF5JK1SF4iz
	3WJgGnH5XSa/whYUaybJ40XZcD4Uc5XEdu6bCG6Ta8yFH95W8asj1HQ5z5SzJo8JKlEpGNd3fnKBj
	JSbDd3m9GOE2tkynb4CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk0YO-0001VM-LE; Thu, 17 Jan 2019 05:49:24 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk0YK-0001UB-Gy
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 05:49:22 +0000
Received: by mail-pg1-x544.google.com with SMTP id t13so3915829pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pV6w5zBcNIn0CdpE5qe/bD/3UXSmkBbu0VG7ZuQvYuY=;
 b=fTr8ggFXr8imKvwEeXvT3sJLlPZ855lkgIwHk5uMrrxvzmzvKA6WBHYOzHUhSqhXdO
 DCQzPxryyf+rD2m1m3CjBrkcjgcBcNLyyJS7LtwWWrfilhqU2dSPeWeyDu8XRVCMN1vO
 gRt0X6TVnVRcK7nGWceg/nsfIJzu4lTsPcug0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pV6w5zBcNIn0CdpE5qe/bD/3UXSmkBbu0VG7ZuQvYuY=;
 b=tKX+TRT4kX36pa1vOeZqII2ooXM8u4y3zzVyBLBQKHg8JFuNL1VsQMPm86qayjQxe0
 PUGXAnyxqZwSlCg2HjwlhE+ykVxvEynIEJ2ahUcuHEvOaUsgG5c9FsQbHHq4DGWlMn2h
 Vf8IUbNkHCbqchHsWwoKggRHsblFbcP/jbtr5BrJOZVfamiPF71j4RqpF1o3oo5eh1JG
 oRXdEt/wshrerCMMzJHHlPhLu9zX30Xhr3NUDm07odDfPp/Wg0tn+B60f8AiaxuiwXnb
 3sKGb/FXi7o6t5/2IYAOArHtk4E0fa9v9mrd0boUjUuSXWObg1rNWzbhMgKLZXkktVyb
 Yvbg==
X-Gm-Message-State: AJcUukfu0XHk5kRJxGD/B7KPeNIbOCD99ejiArEGi8evlwhS++2IqTRa
 FCnVLz4QZNcduieNCdAZZANk7Q==
X-Google-Smtp-Source: ALg8bN66gAIX4K4TNYh79R+zB3Fqideh9PQeveVNZqZiwUrZThY1JOWpHygd5CFfSW9Pwh9Ka27M2g==
X-Received: by 2002:a63:e445:: with SMTP id i5mr12234356pgk.307.1547704159184; 
 Wed, 16 Jan 2019 21:49:19 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id a17sm643310pgm.26.2019.01.16.21.49.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 21:49:18 -0800 (PST)
Date: Thu, 17 Jan 2019 11:19:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117054916.dqduckt7larn32av@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_214920_604924_E79ED644 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, linux-kernel@vger.kernel.org, edubezval@gmail.com,
 mka@chromium.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 swboyd@chromium.org, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-01-19, 22:04, Amit Kucheria wrote:
> Add a flag to be used by cpufreq drivers to tell cpufreq core to
> auto-register themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others. 
> 
> Things needing fixing:
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.

is_bL_switching_enabled() lets you know if IKS is enabled or not.
Set/clear flag conditionally before the cpufreq-driver is registered,
based on the output of is_bL_switching_enabled().

>  - The other pending issue is to fix allmodconfig that leaves us with
>    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
>    references for functions defined in cpu_cooling.c

Okay, that's a terrible thing and the solution looks to be rather
difficult.

For others who may not be aware of the issue here, currently the
cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
which uses helpers of the thermal core (CONFIG_THERMAL).
CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
in Kconfigs.

The cpufreq drivers using the cpu_cooling.c file have this in their
Kconfig entry:

# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
#       depends on !CPU_THERMAL || THERMAL


This series now places the cpufreq core in place of the cpufreq driver
and it messes up everything. It is not just about allmodconfig, but
any configuration which makes the compilation fail.

What are the solutions we have now ?

1. Have following for CONFIG_CPU_FREQ
       depends on !CPU_THERMAL || THERMAL

   The platforms which don't need CPU_THERMAL (like x86) should not
   enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.

   @amit: If this gets accepted, please update the Kconfig entries for
   all those drivers to not have above lines anymore.

- Change CONFIG_THERMAL to bool instead of tristate ?

- Anything else ?

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
