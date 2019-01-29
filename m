Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482A7C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AD420857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BB4T2ug+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AD420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51bWaQ/VkM1MGU7y3E6wQ7iBVbsaWvHQtwaBSuRCK8E=; b=BB4T2ug+dG8h+0
	asySSXDyFv/0sfeeWk8MOAZ0ui0A3C84EZvTI9LBnMvMWiOOwiHuRVvl8R1Af4RZ5ik/QZKGwgSgj
	YMBwQ081cbJwxjLEWzjBs7whw0WoypXPEZ8f6EFB4gv/GwvTJRNZWAOLgxLr14o32Bx329NLdgC6O
	oceozD4sJFAPjgqbIPV3VlAesOXH8sLdAiylLV0MsN93PkZzbQ4/IQYWNArq7M32iqND09mPeuM3r
	xCvicwO0VhsUqtGvZHqjhIjEt8WVxiRs4AefbUiCkbXzr4FnrY90uldDJbTSzTqn1UFMiF4oe12Pm
	N4EBB2bph6fhcnxAbkuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPUr-000066-9I; Tue, 29 Jan 2019 09:15:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPUn-00005P-VM
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:15:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D4A780D;
 Tue, 29 Jan 2019 01:15:53 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D093F7A6;
 Tue, 29 Jan 2019 01:15:50 -0800 (PST)
Date: Tue, 29 Jan 2019 09:15:49 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
User-Agent: NeoMutt/20171215
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_011554_010260_4238C358 
X-CRM114-Status: GOOD (  13.96  )
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

On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > I think this patch will result in error messages at registration on
> > platforms that use the cpufreq-dt driver and don't specify
> > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > a problem as long as the cpufreq initialization succeeds regardless,
> > it could be seen as a not-so-gentle nudge to add the values.
> 
> That wouldn't be acceptable.

Fair enough. What I can propose in this case is to have in PM_OPP a
helper called 'dev_pm_opp_of_register_em()' or something like this. This
function will check all prerequisites are present (we have the right
values in DT, and so on) and then call (or not) em_register_perf_domain().
Then we can make the CPUFreq drivers use that instead of calling
em_register_perf_domain() directly.

That would also make it easy to implement Matthias' suggestion to not
call em_register_perf_domain() if an EM is already present.

Would that work ?

Thanks,
Quentin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
