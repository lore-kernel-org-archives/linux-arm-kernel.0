Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50416C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC2B20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DGW1ZTCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC2B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qrnqzrdIAe9MY1kCdinRywVA5T2ZA8gCeaeGVY0vLVY=; b=DGW1ZTCjAtlDX5
	s/jkRLbZdXTo/TntYp1ARtu39SOx41jm51oeIhCyvYunV8ZzG+ZyuT/2aSlDtDz2KTqeDpZw9ysuI
	Z0jw20QfEfUNW47cv9pqqgtTfxS8ZOtbrXy4qxzbUpQAfDFk8J6BR7dIHfW+5yBrTR2d5u214jzvL
	eu6Z/MZS7khAho6Z+6oGOl24Nu96xLGVwVThllVm+cS9Q0LWdNa+OGoVh/eVTYxkIyPkobuVk7XSy
	wdqb/1y2DKgKXlh4zV3ijsg2UvgVROKnt4O4kIuAPDhVVTf711xj1r9nfyiQ8zUfFkryhfQlzXb/8
	bi6dqfTvbd2yalDMAK5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSCa-00013X-Fk; Mon, 10 Dec 2018 20:30:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSCX-00012S-49
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:30:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DEDEBD;
 Mon, 10 Dec 2018 12:30:37 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B7D433F59C; Mon, 10 Dec 2018 12:30:34 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To: Richard Henderson <richard.henderson@linaro.org>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com>
 <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
 <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
 <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
From: Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <60a6ca4b-cfe9-1ed3-dce6-9f58575240ba@arm.com>
Date: Mon, 10 Dec 2018 20:30:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_123049_172973_47BD3E05 
X-CRM114-Status: GOOD (  13.86  )
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

On 10/12/2018 20:22, Richard Henderson wrote:
> On 12/10/18 2:12 PM, Kristina Martsenko wrote:
>> The plan was to disable trapping, yes. However, after that thread there
>> was a retrospective change applied to the architecture, such that the
>> XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
>> HCR_EL2.API. (The public documentation on this has not been updated
>> yet.) This means that no HINT-space instructions should trap anymore.
> 
> Ah, thanks for the update.  I'll update my QEMU patch set.
> 
>>> It seems like the header comment here, and
>> Sorry, which header comment?
> 
> Sorry, the patch commit message.

Ah ok. Still seems correct.

Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
