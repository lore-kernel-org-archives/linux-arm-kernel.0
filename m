Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5355AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22066205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h9f6Wp7P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQKx2Wmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22066205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZAswV4hErkS/xc7tXX9avPU12YC4TpkTaDTTMbRA/Qg=; b=h9f6Wp7P9/nZPL
	XT29FERSLyTJB9U/TDFlitXGC7X9SEDvdvx2IGcgXQRCaMRB9blFT50GDgyjOdxq+azvzJCgZMNbr
	cUAErYG4H3Bj4Up6eAR9lFnxmWean4ENGIXGohGDxhAo65MG13DKhDebRLokztJwDLc+/h5JTC/ZR
	M+QWeM59JIfcvos2b8RirWeZn2KqaV+gBpnSsXh37ykVv9S0X4QnBqkNHhQen7CKHU8D4kvwkACVo
	ldioTwqbRPSgw1sve7QNnCb+WSVv67hsO4WDMIQ/zrWRe/VBayXI7ukT5ROiLxBspKoSth7Z7ZVEb
	pcnEeqqVBQUXaujB2qNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8h2-0002Lx-Ma; Thu, 17 Jan 2019 14:30:52 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8gx-0002LX-Ek
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:30:50 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so4504678pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vPE0iJH00uw3g29XdpOWj4FUNR/fWr5PSPg5JASa3T4=;
 b=RQKx2Wmr1EIzy8KrI0FcG/Cj+y3OidW4W4o6VJDIh4MH3P5s3f7H2BrcxxdU71m2uN
 z1e7uPNp+vlTCi2Ds53R8uJj0NdqB0Ioa0qr21OKkhBQJiV3LYVarWpNj+goSl7NHjjE
 jhKJNcdGwWluHmoipQ9PJK/uCO7JxyMz2qcTcMdssSOXF3nT4DN6sxk0g0zXip6YbFGQ
 M5YBdYZxcDUJFkH5IUyOEtSnS4NhJp7jfSiYCwgZmW9DG7VKciHODyme/+BJi9jRcEUi
 G8LgwstwY6qw42ll9SVmtVNHg2HfY2NE75F6O+DtOeQWr/vc3ld5isaFuz6BKRCLUN4h
 Psxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=vPE0iJH00uw3g29XdpOWj4FUNR/fWr5PSPg5JASa3T4=;
 b=dVRnWrFcWciqZffo7rEwrgsmQ6IhpvPOySq/C/LX4ecFDdgMaRy6Uy06ltUZZVG1s5
 Yve17xMDdlA3NeydT6b1/9Ml0KSmqLSEFe4GUdXIQwRkp/ci/AMWOu75VgMajBy46a8p
 drCncQslWTHMPOykmWxaTTfcDgudR8rZCFhW68CjsKXf9DJYUqSs42FGN3Au3nczX8Zc
 SbVPxuq+d24dhWAt/AS+xzcL6dmodP33FR/VaKW3Sf6FiP/E5uz0o2uhpKm0pvALHOHA
 csSANCIP/SrPdSBI5rL7Z3/1w8IUaEYWJkK0shtUa0KxwKrl2NbUE1Wx0MRanar/WK+F
 RHlw==
X-Gm-Message-State: AJcUukdYdKnGgxaW6OHxcZ/xDu9dYUMmsxsOn3+DyAS6VoeaU0CjemdD
 tSJIdFGr96wMu+hDSGV7SCY=
X-Google-Smtp-Source: ALg8bN7scCulcV6ZI4hjZ5rcT2zWWnBwK7E7cCHqYdj6Yvq2Ge+p1DbVb0QknU4Q+XJwjw+usKpjag==
X-Received: by 2002:a62:1289:: with SMTP id 9mr15352393pfs.102.1547735446408; 
 Thu, 17 Jan 2019 06:30:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s130sm2363225pgc.60.2019.01.17.06.30.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 06:30:45 -0800 (PST)
Date: Thu, 17 Jan 2019 06:30:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117143044.GA30757@roeck-us.net>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
 <20190117112730.GA25198@basecamp>
 <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_063047_500482_9F4ACD47 
X-CRM114-Status: GOOD (  25.14  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 06:30:41PM +0530, Sai Prakash Ranjan wrote:
> On 1/17/2019 4:57 PM, Brian Masney wrote:
> >
> >That attribute suppresses a warning from the compiler if the function is
> >unused when PM_SLEEP is disabled.  I don't consider it hackish since the
> >function name no longer appears outside the #ifdef. For example:
> >
> >	#ifdef CONFIG_PM_SLEEP
> >	static int qcom_wdt_suspend(struct device *dev)
> >	{
> >		...
> >	}
> >	#endif /* CONFIG_PM_SLEEP */
> >
> >	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> >
> >SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
> >for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.
> >
> >Now here's the code with __maybe_unused:
> >
> >	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> >	{
> >		...
> >	}
> >
> >	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> >
> >This will still be a NOOP when power management is disabled, but have
> >the benefit of increased compile-time test coverage in that situation.
> >The symbols won't be included in the final executable. I personally
> >think the code a is cleaner with __maybe_unused.
> >
> >This pattern is already in use across various subsystems in the kernel
> >for suspend and resume functions:
> >
> >$ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
> >767
> >
> 
> Thanks for the explanation Brian.
> 
> But I did see the maybe_unused attribute usage in other suspend and resume
> functions before posting and decided to go with ifdef because
> I think this attribute wastes CPU time by building and later discarding if
> the function is unused (it may be negligible).
> 
Your argument is that the increased build time test coverage, the improved
code readability, and the reduced risk of dependency errors are not worth
the additional compile time. You might want to take that up with the upstream
kernel community.

> I did not understand the increased compile-time test coverage
> you mentioned when PM_SLEEP=n because why would we need to compile
> when the config is disabled? We could just discard it. We would just

It is beneficial to know that a future change in the conditional code,
or an infrastructure change affecting it, doesn't cause a build error,
even if the person submitting the change didn't bother compiling with
PM_SLEEP=y.

> increase the build time with this attribute (although for this case it would
> be negligible but say we compile with PM_SLEEP disabled for all those
> suspend/resume functions with maybe_unused attribute).
> 
> Looking at previous discussions in LKML[1] as to why the pm suspend/resume
> functions used __maybe_unused seemes to be because of
> wrong ifdef usage. For ex: Using #ifdef CONFIG_PM instead of
> #ifdef CONFIG_PM_SLEEP would result in a warning when
> CONFIG_PM_SLEEP=n but CONFIG_PM=y.
> 

Do you realize that you are proving a point here, and that it isn't
your point ?

I personally very much prefer __maybe_unused over #ifdef, for the reasons
stated above. Other maintainers may think differently.

Guenter

> Anyways, *I am OK with either of them*, after some more review on the
> patch I can make the change in next version of the patch.
> 
> [1] https://lore.kernel.org/patchwork/patch/732981/
> 
> - Sai
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
