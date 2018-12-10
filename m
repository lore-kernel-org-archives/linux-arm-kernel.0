Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6AEC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:13:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E732082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OkxjzpDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E732082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r8LUVwI2dMbPagCu+oLnLRAQSGa7UZ8zQk4VlCG2guE=; b=OkxjzpDUgQC8ew
	N7FMf4Hvq8PJAQDMSpiGaSIGUx9u0XpTFG7Y6TstHNYXwnelTija3zDkhXhmr3dLXA+5eI7yGnBp3
	dGwKrtWoo/OUBUnnMGhdPCldciQ/INzZRM84Z1elNZqPWaZdtjG9zOHtcDBaSLcFEXmOuuLj52hDr
	8YZap93Vk9xOMVreBVHmoe1ZPLVL6Kx/afo9fdJsdvlV29Ew5Ruwn9xgOw1vbWlrNn5lgd31iO4qa
	btZ7jW/7wOtKjdKxSnY0sHIWSLmjzRaG+zE1o7shYN7uVe0x5B12Oa/O48DNM6mBloC5hAK9LnK8f
	S8XIWmcOIK7saSi90e9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRvf-0000xM-Ih; Mon, 10 Dec 2018 20:13:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRvc-0000vF-4Q
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:13:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C72EBD;
 Mon, 10 Dec 2018 12:13:08 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2D1CA3F59C; Mon, 10 Dec 2018 12:12:56 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To: Richard Henderson <richard.henderson@linaro.org>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com>
 <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
From: Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
Date: Mon, 10 Dec 2018 20:12:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_121320_229585_55293487 
X-CRM114-Status: GOOD (  17.09  )
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
 linux-kernel@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09/12/2018 14:53, Richard Henderson wrote:
> On 12/7/18 12:39 PM, Kristina Martsenko wrote:
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> In subsequent patches we're going to expose ptrauth to the host kernel
>> and userspace, but things are a bit trickier for guest kernels. For the
>> time being, let's hide ptrauth from KVM guests.
>>
>> Regardless of how well-behaved the guest kernel is, guest userspace
>> could attempt to use ptrauth instructions, triggering a trap to EL2,
>> resulting in noise from kvm_handle_unknown_ec(). So let's write up a
>> handler for the PAC trap, which silently injects an UNDEF into the
>> guest, as if the feature were really missing.
> 
> Reviewing the long thread that accompanied v5, I thought we were *not* going to
> trap PAuth instructions from the guest.
> 
> In particular, the OS distribution may legitimately be built to include
> hint-space nops.  This includes XPACLRI, which is used by the C++ exception
> unwinder and not controlled by SCTLR_EL1.EnI{A,B}.

The plan was to disable trapping, yes. However, after that thread there
was a retrospective change applied to the architecture, such that the
XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
HCR_EL2.API. (The public documentation on this has not been updated
yet.) This means that no HINT-space instructions should trap anymore.
(The guest is expected to not set SCTLR_EL1.EnI{A,B} since
ID_AA64ISAR1_EL1.{APA,API} read as 0.)

> It seems like the header comment here, and
Sorry, which header comment?

>> +/*
>> + * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
>> + * a NOP).
>> + */
>> +static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
>> +
> 
> here, need updating.

Changed it to "a trapped ptrauth instruction".

Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
