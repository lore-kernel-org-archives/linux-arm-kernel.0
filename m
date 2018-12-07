Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8852420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdT9Sv0T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PzSkCAaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8852420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pohaaoJ0GiJW0idzAt7UlQtAwkAP21DxR00eVdmdLGw=; b=TdT9Sv0TG+DmF/
	Mk7Qjv3fdStjQCGoOjyeYKqzJJh5QYJURRssVeo/XFLEoWAOndftZPYVIqpEujNU9s8U6Uk5ryQrL
	xGhd2v2w2BzR4K2cs4MOEXqEifGtac51wt2HB3CKOmdZbleeiw181PDJtnZ1qOGu8UwrDgidWIvNn
	gmxS/EenpKwOOk6tG530onZhQ0S/L6dXgmR6/iNVIVE11GfchJrMncP2JLI1TnilcnN57S2o9+BMl
	2TCMGEcVRjttOQVHm55Fk3P2VlutXaoKdRxkVy1LnV3GAx+SENmDtXKvIlC8Bx0zQb8o3jIegismK
	+h9V6euYGYxJCIdnucIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKtM-0005ev-8k; Fri, 07 Dec 2018 18:30:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKt0-00043c-Fa
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 18:30:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AujGriTb9C3kbnvelZAt2DHbPIU9ZYviDMpGFgEUmN0=; b=PzSkCAaFtRVHcfzt8RXAs2kmFb
 7kFBrrUeInJsSGXIT4T1Mtq/Dn6fur3ApG0yWqJfo1i5B8iFRRt35Zd/z1zL+XQwN8AVncJ6uW6P4
 7wB8WP5yIIrIVod2YtWmRpJAJfo6LBa1PzcJCWE0KOxInJlTIW0uw1lAKv2EPfAvyY1cT82zqLv1U
 XejMoEv2ZETdg7EMzMmdVnMMGi/RZypMADBys7z2gRTf9y2/6UEVkdwnm8qyzJMv/L/uon/leZriR
 PHsS4e4z5Dek9672+6mJ4Vb3o67Z6motZ1EFVarVihCI7USQ5wC4CoHqBC/CM4s7iu4rI43fodKSN
 uQsH89CA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKJM-00044i-FN
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:53:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB68A165C;
 Fri,  7 Dec 2018 09:53:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B9BE3F5AF;
 Fri,  7 Dec 2018 09:53:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 21FFC1AE0BA4; Fri,  7 Dec 2018 17:53:31 +0000 (GMT)
Date: Fri, 7 Dec 2018 17:53:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Alexander Van Brunt <avanbrunt@nvidia.com>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181207175330.GC11430@edgewater-inn.cambridge.arm.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
 <20181206191850.GC20796@arm.com>
 <BYAPR12MB271239AAF4A0B79D756850C6CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
 <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_175312_659849_2A2BD123 
X-CRM114-Status: GOOD (  25.58  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sachin Nikam <Snikam@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Ashish Mhetre <amhetre@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 08:42:03PM +0000, Alexander Van Brunt wrote:
> > > >=A0If we roll a TLB invalidation routine without the trailing DSB, w=
hat sort of
> > > >=A0performance does that get you?
> > > =

> > > It is not as good. In some cases, it is really bad. Skipping the inva=
lidate was
> > > the most consistent and fast implementation.
> =

> > My problem with that is it's not really much different to just skipping=
 the
> > page table update entirely. Skipping the DSB is closer to what is done =
on
> > x86, where we bound the stale entry time to the next context-switch.
> =

> Which of the three implementations is the "that" and "it" in the first se=
ntence?

that =3D it =3D skipping the whole invalidation + the DSB

> > Given that I already queued the version without the DSB, we have the ch=
oice
> > to either continue with that or to revert it and go back to the previous
> >=A0behaviour. Which would you prefer?
> =

> To me, skipping the DSB is a win over doing the invalidate and the DSB be=
cause
> it is faster on average.
> =

> DSBs have a big impact on the performance of other CPUs in the inner shar=
eable
> domain because of the ordering requirements. For example, we have observed
> Cortex A57s stalling all CPUs in the cluster until Device accesses comple=
te.
> =

> Would you be open to a patch on top of the DSB skipping patch that skips =
the
> whole invalidate?

I don't think so; we don't have an upper bound on how long we'll have a
stale TLB if remove the invalidation completely.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
