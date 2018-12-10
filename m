Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1642C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B93D20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nxpLMCud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B93D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nk9jA5c3RTUZmfqojUwgY71EUkDqHrcNyc3CrBTEFjI=; b=nxpLMCudgsGPlM
	mQ2XAkxap7NSSIBPcA1nLz6aulSotNg9jY2Q4SZZ1GmMMd7zGLo/iU4LXe4iof6UoL0rk4s51aKLL
	eggef7mjgwfGm5NRCpGi8k/Ez9zYIaMbySylUWMFe98KQJJKXqpKKnN/aoWo6Dh9sFHZxgN1fkoff
	OXfF5ZQRbE92pb9DdhAXdz67fqphlNvLnxDU3aldc9kfKtCjjf5wOC2CFPOHvIAgEukqI80WsiFgy
	KInIPXP7HWYSjbj/Cf4/tR9PqfHIjzk5BiANiMZhWPOKAgP/miqtxNTuOseIYPl7sblfj+0SakyWB
	TfiosspGU1E9gntbU0EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWO82-0003ZW-DQ; Mon, 10 Dec 2018 16:09:54 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWO7z-0003Y6-KE
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:09:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6941596;
 Mon, 10 Dec 2018 08:09:41 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C67C63F6A8; Mon, 10 Dec 2018 08:09:37 -0800 (PST)
Date: Mon, 10 Dec 2018 16:09:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
Message-ID: <20181210160934.GF4048@arrakis.emea.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
 <20181210120330.GB4048@arrakis.emea.arm.com>
 <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
 <20181210142944.GA13100@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210142944.GA13100@edgewater-inn.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_080951_664954_62B65915 
X-CRM114-Status: GOOD (  19.25  )
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
 Jacob Bramley <jacob.bramley@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Adam Wallis <awallis@codeaurora.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Cyrill Gorcunov <gorcunov@gmail.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 02:29:45PM +0000, Will Deacon wrote:
> On Mon, Dec 10, 2018 at 08:22:06AM -0600, Richard Henderson wrote:
> > On 12/10/18 6:03 AM, Catalin Marinas wrote:
> > >> However, it won't be too long before someone implements support for
> > >> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
> > >> will only have 3 authentication bits: [54:52].  This seems useless and easily
> > >> brute-force-able.
[...]
> > Perhaps the opt-in should be at exec time, with ELF flags (or equivalent) on
> > the application.  Because, as you say, changing the shape of the PAC in the
> > middle of execution is in general not possible.
> 
> I think we'd still have a potential performance problem with that approach,
> since we'd end up having to context-switch TCR.T0SZ, which is permitted to
> be cached in a TLB and would therefore force us to introduce TLB
> invalidation when context-switching between tasks using 52-bit VAs and tasks
> using 48-bit VAs.
> 
> There's a chance we could get the architecture tightened here, but it's
> not something we've pushed for so far and it depends on what's already been
> built.

Just a quick summary of our internal discussion:

ARMv8.3 also comes with a new bit, TCR_EL1.TBIDx, which practically
disables TBI for code pointers. This bit allows us to use 11 bits for
code PtrAuth with 52-bit VA.

Now, the problem is that TBI for code pointers is user ABI, so we can't
simply disable it. We may be able to do this with memory tagging since
that's an opt-in feature (prctl) where the user is aware that the top
byte of a pointer is no longer ignored. However, that's probably for a
future discussion.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
