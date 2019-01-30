Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8508B20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTwdZNNU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbkQr0Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8508B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bxWz31aqgTZlg9L7VxK6CEUWFkHUFTUf/lA2QjCn0WY=; b=fTwdZNNU+mAWuM
	XXSXLQ3qi85y70BJ5hLgznRxbJ7Qj5sQU9MQ+6hA3GSxGg1GTwNhrDoxoB7ezCVqlyDxlsu9mM/yl
	c4Fj4jSXRW7iM/zilXqBgQ4cj7OkofgBLY3r1hyjDc47TLAd94Dt90614omiBPCiiam352eAbLoXi
	x8YxjDnnwgLEEEvv1Vf0+evnF0e1DzlZADlYP0iOqD4sNt/my8PpPEH4/FHOIPCdcbFSQo7ViDgzm
	ZsMSKR/z6gu4axZp0LgfjsKzqucR3xl8JjMhFyNDAbZMfJ3E7QdLmilIcacrOWlhezSMNFuo/cLGM
	8FdGUQJSL4LKcECPch2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomvr-0000YC-RV; Wed, 30 Jan 2019 10:17:23 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomvp-0000Xm-9U
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:17:22 +0000
Received: by mail-pl1-x641.google.com with SMTP id t13so10834213ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qtqFBfcBpvpDSs7hW0mzxMLq7yUG6Ahbo+VkJvD38cc=;
 b=WbkQr0KpBVamQsPJnuV4Q60cgeFnnSFMWEpBLNO4BdSer+fvP3I58cLUHT3yV0kthv
 G0LrXs8LUMdPbR6SSt83G4rsQcnQh4ayWNMZXqSVDbQRNOYq8JmvqWxwqz4cX054YNJq
 Ku8KZdtOueYzAbykjyvkFsVFsCadn8WIayL0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qtqFBfcBpvpDSs7hW0mzxMLq7yUG6Ahbo+VkJvD38cc=;
 b=QbDki79Y31j7TQsRONGM5Rx8F/8VQuXC7/rlK+dDC9lfySkMarDvALaJDyFGZuQVBt
 f+9OxQktf3YldyVd4FEhEqJmAot3QKsltWX0kHpfmOc+kBpZ/vk96v93NnOo8jKlR6Ic
 MtWuzTMCS9BuGtZUBca2ItfixH7RyvKONjJJ5faF5cxjX5cBc9bIz2UbeNZs5e/3nTW4
 TBGX3fvj7WRgmIyWXXIoTDhxTBT1yeoAk8ay1MVNwwgzMJ9g1TJL+b+H6mMpjuYXcZCQ
 dlwJEImqJzXjYODkqAx/RBN0HV9KfFlciQimFbxt6vqv1XlZ+b/aW2T8oMc3Ncq3vlyA
 On0Q==
X-Gm-Message-State: AJcUukf0wd7AIesoYTEqDJ3kS0p2lufTDYt+Vh4Xur8FiIogQA3n8E6L
 0MLxAS3X0ZetWVE3VUJjJWZDtg==
X-Google-Smtp-Source: ALg8bN5ZP+pqxSK3+axrtFel8s0idJS1nrrba4mwyQA9QsMSf7ul+5tOWzvQUh00Y2lV4S3+QJfVvA==
X-Received: by 2002:a17:902:780a:: with SMTP id
 p10mr30442782pll.54.1548843440166; 
 Wed, 30 Jan 2019 02:17:20 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id x28sm2871896pge.66.2019.01.30.02.17.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 02:17:18 -0800 (PST)
Date: Wed, 30 Jan 2019 15:47:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
 <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021721_335782_9E59C2D6 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: mark.rutland@arm.com, nm@ti.com, lorenzo.pieralisi@arm.com,
 devicetree@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30-01-19, 09:12, Quentin Perret wrote:
> What I had in mind is something as simple as:
> 
> 	void of_dev_pm_opp_register_em(struct cpumask *cpus)
> 	{
> 		/* Bail out if an EM is there */
> 		if (em_cpu_get(cpumask_first(cpus)))
> 			return;
> 
> 		/* Check prerequisites: dpc coeff in DT, ... */
> 		...
> 
> 		em_register_perf_domain(...);
> 	}
> 
> IIUC, Matthias' point was that if the EM is already registered, there is
> no good reason to call em_register_perf_domain() again. Now, that should
> in fact be harmless because em_register_perf_domain() already does that
> check. It's just cleaner and easier to understand from a conceptual
> standpoint to not call that function several times for no reason I
> assume.

If there is no good reason to call em_register_perf_domain() several
times, then the same applies to of_dev_pm_opp_register_em() as well,
isn't it ?

This is init code anyway isn't going to run a lot, so I wouldn't
suggest adding any such (duplicate) checks in
of_dev_pm_opp_register_em().

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
