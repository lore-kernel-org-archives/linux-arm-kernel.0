Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6AC20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AG49LnWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6AC20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3zhsduKJAWW8fadqDfo5ioh93k7g6C5vGHX/GXRGQdA=; b=AG49LnWvpsJbQz
	h6b1Renhsu5c7EKh+xCLEAxnDaZqSAOH0kMsPL7hofBwif/sSThqNxAdwlDtNv6WSGqhwjRfH2Ocm
	qdPK/vAa9rSNwb7vF9aWctbOboFzPBJJ3RwM/NnVuEDEmI4O9Hj/1lsXhInxEwS2p4fAMHicPnw4L
	nbVzUHRVHD/6I81bZvSYc8VSkSwT+BOS9oR32iydc8Rqn3m+GWWAkWESuKlBhhRM92mDy8t+jupMZ
	yuWS2S6bMM9cd5vl+i8IBZBhXiGM11x+3PC0qt9v4ST94J4nHBDkkcuP+vmRHhPiST4dc5pJxZeZD
	n/XqY+ksAiNGF8+ltGLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRdk-0001fD-A7; Mon, 10 Dec 2018 19:54:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRdg-0001Tr-9t
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:54:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D20EBD;
 Mon, 10 Dec 2018 11:54:35 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 AEC033F59C; Mon, 10 Dec 2018 11:54:28 -0800 (PST)
Subject: Re: [PATCH v6 02/13] arm64: add pointer authentication register bits
To: Richard Henderson <richard.henderson@linaro.org>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-3-kristina.martsenko@arm.com>
 <ef051a9b-d58f-07af-a446-4b7326ff9311@linaro.org>
From: Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <1e72484b-f89f-eacd-1976-14fdf6f23e26@arm.com>
Date: Mon, 10 Dec 2018 19:54:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ef051a9b-d58f-07af-a446-4b7326ff9311@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_115448_349382_027380BE 
X-CRM114-Status: GOOD (  10.22  )
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

On 09/12/2018 14:24, Richard Henderson wrote:
> On 12/7/18 12:39 PM, Kristina Martsenko wrote:
>>  #define SCTLR_ELx_DSSBS	(1UL << 44)
>> +#define SCTLR_ELx_ENIA	(1 << 31)
> 
> 1U or 1UL lest you produce signed -0x80000000.

Thanks, this was setting all SCTLR bits above 31 as well... Now fixed.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for all the review!

Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
