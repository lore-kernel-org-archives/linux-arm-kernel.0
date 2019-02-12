Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39D52190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WamMavn9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dv6wCjcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39D52190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tFyN8jDSBdmqoeS/pYeuIBo2X/HDOy5nNkspvZgfi7E=; b=WamMavn9yqcwbW
	RaR5dpbTA8cA6Ny7wdn6MjASNGshQNoklSqsWhV/BileIO5ACUN2oGBUbSgiExc2VwSW1tHEZ26+M
	63Ov4K5YGHmEJpzc6d/TB0axpboxLpafPjjn3XYN2j63fAZ5LF0nEsHUtKgUGsT3t4bsL1P8q4LL5
	g7cr/NGmbIFisliAWjQjty0AQ4/LrrF/IS9gG+Cn++TBrMCjosMJpB4gA+ljeJ611CVIedUfeJm0O
	Eo6bZp8BS3zCKczeSv9j5RTxjxNdg/0xyr8bIsCFe5tXXQpFUPcWhm9cswTGxWsLfvQlhJs/OSGnk
	41C5gKh2bJPIgEozeaFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtcWi-0007XB-6T; Tue, 12 Feb 2019 18:11:24 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtcW4-0007RL-56
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 18:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AF3hX2T2p0FMHJW1lapUfgJyNBUYHRm45Iah0jYbWTU=; b=dv6wCjcXxwNtGMQlDkANA3MqD
 d25KSHCFrpglmNWcsCiki1yU4weonw3Us+3owJLqoFJQTmDndIDhtwbAkrlPji0pWmW6OjGg8ITyu
 GF4yUC2jnoULNHXafams4Xv02A+qzzfWYvdI7UdiBXr7+kvu8aK0o8WnYvwlkoXf1yM7qT/YNI9BN
 sb+7MAiyRkf4UI9LrPKcX4neLPoqOpeDirCfJAHIXn80X/PzZboR2+gmL4m8bt09NT7eviZy6jmN3
 1ZhRRJfHAtFv+5Bxv1pzCdIsT2r22mFslGsQrtojrUW8QHXd+Ty9pXQm38CsprjOyDASlptWTrJtw
 lZFljhm1Q==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtbje-0007rd-JV
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:20:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE54AA78;
 Tue, 12 Feb 2019 09:20:39 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 77E823F675; Tue, 12 Feb 2019 09:20:38 -0800 (PST)
Date: Tue, 12 Feb 2019 17:20:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/4] arm64: SMCCC conduit cleanup
Message-ID: <20190212172035.GC199333@arrakis.emea.arm.com>
References: <20180503170330.5591-1-mark.rutland@arm.com>
 <20190212152444.GE6302@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212152444.GE6302@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_122042_729361_0D36F793 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com,
 suzuki.poulose@arm.com, marc.zyngier@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 03:24:44PM +0000, Will Deacon wrote:
> On Thu, May 03, 2018 at 06:03:26PM +0100, Mark Rutland wrote:
> > Currently, the cpu errata code goes digging into PSCI internals to
> > discover the SMCCC conduit, using the (arguably misnamed) PSCI_CONDUIT_*
> > definitions. This lack of abstraction is somewhat unfortunate.
> > 
> > Further, the SDEI code has an almost identical set of CONDUIT_*
> > definitions, and the duplication is rather unfortunate.
> > 
> > Let's unify things behind a common set of SMCCC_CONDUIT_* definitions,
> > and expose the SMCCCv1.1 conduit via a new helper that hides the PSCI
> > driver internals.
> 
> I just noticed that this didn't get merged, for some reason. I acked it at
> the time, so what's left to do?

Apparently I queued it briefly and then dropped it:

https://lore.kernel.org/linux-arm-kernel/20180601143747.3axhy5a2kmxecfcs@armageddon.cambridge.arm.com/

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
