Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB1EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:29:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FACC2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KvfMfDZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FACC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tg19rBm4eyhqrpf5r5kr9c4p9+NRDvaDimRMJ4LWmRc=; b=KvfMfDZIp0gDcY
	RZvBJRTM6fFbZNDt1RoVKk0R1V4QJmzV7OBAdaanHDpSFM/91sO1XeEfLx4+o2/PLqh8GWhQNUsuG
	3Y2Q2wxIfQOHAIRtqIqhtU7hVoa5eYvTsSaWwKUx/WvnDtRgLVzXt31RXO+YEo4LYxHExN7Qhho1f
	pTvZ6Z/acLR5Lk9ylgehlFLtpPrfsO5bRQbKtUG1AG69ybCZ978vvy8d4V2GZZ2LagBQ2kno7p9uf
	y3ZBs7fMHTCVGxwMZalU50SYm6Ygh31UlF649Z4FRBw8bKVp4B9gzZYOSxCmtfZp8M8RN/lQnIETw
	Vp8DhDm7kZhxUF1MpZlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMYy-0007bd-22; Mon, 10 Dec 2018 14:29:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMYv-0007aq-FF
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:29:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDEDA1596;
 Mon, 10 Dec 2018 06:29:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CC053F575;
 Mon, 10 Dec 2018 06:29:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 319921AE0CFD; Mon, 10 Dec 2018 14:29:45 +0000 (GMT)
Date: Mon, 10 Dec 2018 14:29:45 +0000
From: Will Deacon <will.deacon@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
Message-ID: <20181210142944.GA13100@edgewater-inn.cambridge.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
 <20181210120330.GB4048@arrakis.emea.arm.com>
 <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_062933_518494_2EB86711 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Steve Capper <Steve.Capper@arm.com>, linux-kernel@vger.kernel.org,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave P Martin <dave.martin@arm.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 08:22:06AM -0600, Richard Henderson wrote:
> On 12/10/18 6:03 AM, Catalin Marinas wrote:
> >> However, it won't be too long before someone implements support for
> >> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
> >> will only have 3 authentication bits: [54:52].  This seems useless and easily
> >> brute-force-able.
> > 
> > Such support is already here (about to be queued):
> > 
> > https://lore.kernel.org/linux-arm-kernel/20181206225042.11548-1-steve.capper@arm.com/
> 
> Thanks for the pointer.
> 
> >> Unfortunately, there is no obvious path to making this optional that does not
> >> break compatibility with Documentation/arm64/tagged-pointers.txt.
> > 
> > There is also the ARMv8.5 MTE (memory tagging) which relies on tagged
> > pointers.
> 
> So it does.  I hadn't read through that extension completely before.
> 
> > An alternative would be to allow the opt-in to 52-bit VA, leaving it at
> > 48-bit by default. However, it has the problem of changing the PAC size
> > and not being able to return.
> 
> Perhaps the opt-in should be at exec time, with ELF flags (or equivalent) on
> the application.  Because, as you say, changing the shape of the PAC in the
> middle of execution is in general not possible.

I think we'd still have a potential performance problem with that approach,
since we'd end up having to context-switch TCR.T0SZ, which is permitted to
be cached in a TLB and would therefore force us to introduce TLB
invalidation when context-switching between tasks using 52-bit VAs and tasks
using 48-bit VAs.

There's a chance we could get the architecture tightened here, but it's
not something we've pushed for so far and it depends on what's already been
built.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
