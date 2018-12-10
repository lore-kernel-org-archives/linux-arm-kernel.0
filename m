Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:04:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E31A20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rMyAU1qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7WK9axCTj/SIdD9vIFmplfiSkMYeCJNQMfaMiQSJoBk=; b=rMyAU1qPNntcfd
	a8UOOj+H9VhWsPn8O9YqVge+m29Ec7hF/lz87+PNDrmQMHaUmmAsFvNKzNU2lMwXorAqAnKPAGq0e
	vNCVt6RnvhpEH9Kp3JuzXabDPwVZmvhXN3YgcGYXOm8sUx/llSe8aOLUIcNyuUSAZC0M7ELiUnngx
	+civ5ZrMPiT76LRZGLlC33ds0tJocvRocwcznL00RyQvuRx5ke1LWqPVU7jFf2I3aGGBYGlxnqGG6
	Jn6PjBOtlYR1rtEvw06teTvtsMv+v+uW7hr7g19nH+29Pmk5OTdjVytr+WlucdzNTpKco54+aVD9B
	rHbyB29y2Bz+7HDknvZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKHy-0005n9-P4; Mon, 10 Dec 2018 12:03:54 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKHv-0005mk-7Q
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:03:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC19715AB;
 Mon, 10 Dec 2018 04:03:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 71F693F6A8; Mon, 10 Dec 2018 04:03:33 -0800 (PST)
Date: Mon, 10 Dec 2018 12:03:30 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
Message-ID: <20181210120330.GB4048@arrakis.emea.arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_040351_281150_4F223514 
X-CRM114-Status: GOOD (  26.08  )
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
 Steve Capper <Steve.Capper@arm.com>, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
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

On Sun, Dec 09, 2018 at 09:41:31AM -0600, Richard Henderson wrote:
> On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> > When pointer authentication is in use, data/instruction pointers have a
> > number of PAC bits inserted into them. The number and position of these
> > bits depends on the configured TCR_ELx.TxSZ and whether tagging is
> > enabled. ARMv8.3 allows tagging to differ for instruction and data
> > pointers.
> 
> At this point I think it's worth starting a discussion about pointer tagging,
> and how we can make it controllable and not mandatory.
> 
> With this patch set, we are enabling 7 authentication bits: [54:48].
> 
> However, it won't be too long before someone implements support for
> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
> will only have 3 authentication bits: [54:52].  This seems useless and easily
> brute-force-able.

Such support is already here (about to be queued):

https://lore.kernel.org/linux-arm-kernel/20181206225042.11548-1-steve.capper@arm.com/

> I assume that pointer tagging is primarily used by Android, since I'm not aware
> of anything else that uses it at all.

I would expect it to be enabled more widely (Linux distros), though only
the support for instructions currently in the NOP space.

> Unfortunately, there is no obvious path to making this optional that does not
> break compatibility with Documentation/arm64/tagged-pointers.txt.

There is also the ARMv8.5 MTE (memory tagging) which relies on tagged
pointers.

> I've been thinking that there ought to be some sort of global setting, akin to
> /proc/sys/kernel/randomize_va_space, as well as a prctl which an application
> could use to selectively enable TBI/TBID for an application that actually uses
> tagging.

An alternative would be to allow the opt-in to 52-bit VA, leaving it at
48-bit by default. However, it has the problem of changing the PAC size
and not being able to return.

> The global /proc setting allows the default to remain 1, which would let any
> application using tagging to continue working.  If there are none, the sysadmin
> can set the default to 0.  Going forward, applications could be updated to use
> the prctl, allowing more systems to set the default to 0.
> 
> FWIW, pointer authentication continues to work when enabling TBI, but not the
> other way around.  Thus the prctl could be used to enable TBI at any point, but
> if libc is built with PAuth, there's no way to turn it back off again.

This may work but, as you said, TBI is user ABI at this point, we can't
take it away now (at the time we didn't forsee the pauth).

Talking briefly with Will/Kristina/Mark, I think the best option is to
make 52-bit VA default off in the kernel config. Whoever needs it
enabled (enterprise systems) should be aware of the reduced PAC bits. I
don't really think we have a better solution.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
