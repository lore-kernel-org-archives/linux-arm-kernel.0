Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3EEC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:18:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4740F21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1fW16dI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK7iarqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740F21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wAcJHKp8E4RFG9zZIwbdPaaUFpTDZvjLZlTbyi4wobI=; b=o1fW16dIwD8s79
	QdQwaKP/lssnaYM70wOfjo8712xuthvz/LT/FkoniukmdTs2yIyffa7ADjDh6muQV3P9EPK/L79P5
	vonVUuD+L6bnMlThu2pJc8w2frEX/SWmT0s/i81gLL3F73lXus42am+gSnlFyCmVUQSwxbCvXoejI
	ECDqPUlvD+WBp2udT/iD2m8KOqEwxFDQh0DpkqHIb1+OiW0IuNwbXZFQ6mPaTHTD5YFsUwFhFm+k5
	MpFCJSYhkFEf7oUfkZawhFl1It0EVNG8iBQxA2gVq6tUrUIuBJx4So6GMzPXkqo7cZnVQHl30oF+P
	nOEZ7MPacKCkdtPiD3Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goiGO-0004sz-J8; Wed, 30 Jan 2019 05:18:16 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goiGK-0004sS-6w
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 05:18:13 +0000
Received: by mail-pf1-x441.google.com with SMTP id c73so10846277pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r90Ei89M9VCYw+F9gfVdb+3hF3vLe++X0fdeOzuBcy4=;
 b=EK7iarqz3qTWQcKrL8cW6cnL3P3Kn2/CLUpaFNpZG8LN4rD8OfUjjGlvf7+hkfNWYr
 n1os1kh0paJ0J9fKb4JdU7FeNJVclYT55FWhCYZ9vpBT/gPzNUhApyB9q3EEPfgWt6gl
 ZWLI4E6Y74v1SvorOd9d1E3yHsQeG+kiL4MME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r90Ei89M9VCYw+F9gfVdb+3hF3vLe++X0fdeOzuBcy4=;
 b=Gb28KhYFujli6Z/LrUJ51eeX5CbMSMYUdTN/XdJHu3bI6YKwoEANFnaSWUaRkdIatn
 LUeZeAR7PVUtisKnxrYy+QwCuoeDV/i7AN98ixY9kYO57zJBZH9p57xnkaaDSlWTblZY
 4LTm2ql5/R65/F3Br7XDBlLs/7FE5jse967cjNds1XnHV0EXlCnE43ErvoO0AZw3N41e
 hCzzi15PyN0/KYhhbp3WvxyL5WSbCXvpTCSU66/TvkrrsSBzdJlT2wxCJJqpMBu0GOZi
 FqnwvkNxxHW5yX1Zbd2Spm3fK8UtDyuW1nfIVmNMdx/mnEef7alWHs/WFfxCLkoIPmCu
 eGAg==
X-Gm-Message-State: AJcUukcNgEZfeV0leo3oIo2auppYy01Ap+H3EgAR94qcX6tRNJ8DUEDu
 kmTrEcXCm2xbzgavcvcEyb5aIg==
X-Google-Smtp-Source: ALg8bN55EWmGYlADnjBHJFR98WUCk2laXakjNm1DLjDRFm1IXKZcAT8MUJ8Qn3yehiFvVZB2gQ7+TA==
X-Received: by 2002:a65:4683:: with SMTP id h3mr25211736pgr.225.1548825490876; 
 Tue, 29 Jan 2019 21:18:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id h64sm632868pfc.142.2019.01.29.21.18.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 21:18:09 -0800 (PST)
Date: Wed, 30 Jan 2019 10:48:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_211812_256915_CD8D4EE1 
X-CRM114-Status: GOOD (  16.25  )
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

On 29-01-19, 09:15, Quentin Perret wrote:
> On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> > On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > > I think this patch will result in error messages at registration on
> > > platforms that use the cpufreq-dt driver and don't specify
> > > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > > a problem as long as the cpufreq initialization succeeds regardless,
> > > it could be seen as a not-so-gentle nudge to add the values.
> > 
> > That wouldn't be acceptable.
> 
> Fair enough. What I can propose in this case is to have in PM_OPP a
> helper called 'dev_pm_opp_of_register_em()' or something like this. This
> function will check all prerequisites are present (we have the right
> values in DT, and so on) and then call (or not) em_register_perf_domain().
> Then we can make the CPUFreq drivers use that instead of calling
> em_register_perf_domain() directly.

That should be fine.

> That would also make it easy to implement Matthias' suggestion to not
> call em_register_perf_domain() if an EM is already present.

So you will track registration state within the OPP core for that ?
Sorry but that doesn't sound right. What's wrong with having an
unregister helper in energy-model to keep proper code flow everywhere
?

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
