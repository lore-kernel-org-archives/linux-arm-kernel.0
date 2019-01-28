Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C22C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:47:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FA0217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRwAqYBO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcoVniot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FA0217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4wMEzQMHqpSHminRzvFOS5MPg/lVAsII6TEMj5Xuiww=; b=aRwAqYBOeb6Vn6
	1dr949FMlzandl/4xVizF0SaXQ8St2FF/Wjs74SenoASFO9AjMDZ50Ic+scdNw9qsP++ad/gqTghh
	POkedjCI9/iriOEO+TwrzEe8k2FNG9AkR8k1SiNTIbTjb+QG6rY1jDKY1+uSScfhbPuokH70uQVoq
	FBam4H0efPYfudOJmV0zNLjB67qp/FbU9xra8lq632ArlG2MYTwpIBU9I7WGlMTJHI091vVSox0WN
	Gu9m/ZzBHOx7aQinZpsy4/5erH8cquSsgtKLHqCJWYo+Aw3VUBXLXFD7K8k3ugHA61z8cLI/94hsG
	MViqg7974ukJfboenm1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0hV-00086L-17; Mon, 28 Jan 2019 06:47:21 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0hG-0007va-9C
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:47:14 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so6812626pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 22:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WdOG/w3P4xjPkdGVh+Q+rKQqSzzNarUNy0xmDXfHpuo=;
 b=BcoVniotemf9eSeL4a1+Rp342oPn8DLhzCvfu9nxJdTfchiqpwxcPqTvHHg7MI54kY
 3hAEoOLAbUJg40K8lEz/Vbplhj0X+QpJmy3zPF44Qc0gemSkR0/z6BCCW+3ONATawu1A
 DYaUXLKJrNlmIJQkRTPF9P9izkjd8r81jRS9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WdOG/w3P4xjPkdGVh+Q+rKQqSzzNarUNy0xmDXfHpuo=;
 b=qhDQU06L+XU9GP4oLr8AdeM0+Tk+EeDuHeNHejQ6VvSsLHDUENlTF1MLVTC7aNUd31
 jBgkNueHvMkbHNg/64Ie+p5G7hAvWhWcrBXpxiZZNOO0D0HvlWXnpnlHeabvlsdIssyc
 mEmbPtqacLG22q3+CtqRIIdGAfj5kd3hj2x3TWa3lxFl0/LznKxGaHokgq3L2ZIy1qkf
 nqc9h1b0thLrsBRrg6D35fsSXh9frppAbgH/SjXhw3/P7+NCUN56ZSZTHcWnnvzJT45a
 t4xtEghA54nul8kVW0AEQ3WYH4DWBBW9kWD1ST5zvUDWaoQuYKZDWZYcpeiakR9JWhDb
 QFNA==
X-Gm-Message-State: AJcUukcxrp7uTiA818G8gqSqdSfq2jAi+rgiyRNJIfRMmbwxn33ftxcW
 p8dG5PEwrsg6o7Vr9bCNphsRGQ==
X-Google-Smtp-Source: ALg8bN5yYo4VGXt8OEN/cZnih/mHBIoypyl6/+N/aaNPSw43V6sSZxZQoOL7FQ/tGPcPwWzLWODdzw==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr20985490pfi.172.1548658024889; 
 Sun, 27 Jan 2019 22:47:04 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id h8sm35618916pgv.27.2019.01.27.22.47.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 27 Jan 2019 22:47:04 -0800 (PST)
Date: Mon, 28 Jan 2019 12:17:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v4 0/9] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190128064701.r25ffs5ixzkcd5r6@vireshk-i7>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_224706_805358_7B7D323E 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org,
 linux-kernel@vger.kernel.org, edubezval@gmail.com, mka@chromium.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, swboyd@chromium.org,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28-01-19, 12:11, Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Chnages since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
