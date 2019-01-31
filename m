Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C244C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A284218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nl6sI3Sw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZzaThyi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A284218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RbWGhIjSsMS+HHyWqsGQ0kFWYMn32a6IOA3I9E+tDxw=; b=Nl6sI3SwaqYeCy
	3LpmKmv89b14AewGShics+9b4GUTgqzHZez0WBx7I4k8xXuMyjD7Ga9kk5cP2POUq5AYCzwMlP83+
	bll2z/tuf031RcuX3rtWRfGDnZYm543pP8Uu71gaGieZJzaV8mDD8l3zEd+IMTjh8FXxYp+aUWWRR
	BGlwBOkw5tCy8kflZAKCNEygI1akBFwc5TdkOAijs0VvC6v3lkFDcyTaoqUbc+t1qT6Z2XMIqv+ah
	vDLkkE36WdR48T8iI3A7iCmt9Y2MhQyxEqg5V/0fIUoBGgUS72tJ5w8vhrYBYpQHJ51lQQagkrxso
	+7DB5lLUfG3gcgIWxmkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFGB-00081O-Jb; Thu, 31 Jan 2019 16:32:15 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFFm-0007Pv-Q0
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 16:31:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T14LJx3kp5JGwWFIj4IvEL+Ozu2KiHASAjdNpGeRUjI=; b=ZzaThyi2dhISk11duYYVFqjowR
 iWSjiTINPLB37kK75jCBdVeNlkDwf9rMdFwX9A7GoTwaGRWxkrd7plBGvGza0xukLGeRZJvcb5SvJ
 aUcfb3eXRhhL/0eDMUoBimpfB12KFq4iVOK7SDCT8nMHHp686COmBwk6vEbVvCi4OR8Y8wEO3o08K
 4ZErJ4Q9XiqBMol0bE8FR3iNxdanXpCHxqaXGxxvvYbpIszvOcr1k7QSyCg/Q4X9OhtT7T1CG7UKs
 Hd8Nsa+HurYPDGixGImPP5TNcP9U1iusAqwr6qnwQzIsqsBxyzzCwAbhuPr5NalWHqc7qoSMmQ3Ra
 h0G1A8Ow==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF4T-0002qG-9t
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:20:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54929EBD;
 Thu, 31 Jan 2019 08:20:07 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2943F557;
 Thu, 31 Jan 2019 08:20:05 -0800 (PST)
Subject: Re: [PATCH v5 1/5] arm64: Add utilities to save restore pointer
 authentication keys
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <88ccd568-f027-6cdf-b4f1-6709d76102c1@arm.com>
Date: Thu, 31 Jan 2019 16:20:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_162009_500660_797E6504 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> The keys can be switched either inside an assembly or such
> functions which do not have pointer authentication checks, so a GCC
> attribute is added to enable it.
> 
> A function ptrauth_keys_store is added which is similar to existing
> function ptrauth_keys_switch but saves the key values in memory.
> This may be useful for save/restore scenarios when CPU changes
> privilege levels, suspend/resume etc.


> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index 15d4951..98441ce 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -11,6 +11,13 @@
>  
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  /*
> + * Compile the function without pointer authentication instructions. This
> + * allows pointer authentication to be enabled/disabled within the function
> + * (but leaves the function unprotected by pointer authentication).
> + */
> +#define __no_ptrauth	__attribute__((target("sign-return-address=none")))

The documentation[0] for this says 'none' is the default. Will this only
take-effect once the kernel supports pointer-auth for the host? (Is this just
documentation until then?)

('noptrauth' would fit with 'notrace' slightly better)


Thanks,

James

[0]
https://gcc.gnu.org/onlinedocs/gcc/AArch64-Function-Attributes.html#AArch64-Function-Attributes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
