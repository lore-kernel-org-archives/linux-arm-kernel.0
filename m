Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E8C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:07:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C120520856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUn4k2cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C120520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jC/Lf1njQs0iPUC6fPhl30+qBlnLX/ba3BLZW6qE/Ho=; b=ZUn4k2cNW09UdL
	8olgwStPrxfyStOD6PlXUAvQrPEpv33zv/I7mX+hQm7s9GTUdUOIbaWB6YZrJgnQ20BzwWsLZfhX1
	ip5UXaJ3BhP1DDFBRwvxlVtmhukE7HYeNz3GPzlNNgNXrKyNWItmjEuWoWghSd7GOndSWqPtBMItd
	yd6swwEHoOQ0mUTmvmjIFdjHGDvLQIPQpq++rzU4sTxa7mkUHKnbenutjJZ0zECMKnST+nknBsNxH
	n+hxZluPfkaRaW1NrZNm4R4ozV1x1UCHJXHbTIbDbiyC+Wm7CTsnj68kj40kVJvVJpF11V+ad/3kD
	2AeA2WeH8jwIjOdHkAXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1Od-0001q2-Di; Tue, 22 Jan 2019 19:07:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1Oa-0001pi-J5
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:07:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB56EBD;
 Tue, 22 Jan 2019 11:07:34 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 824AA3F5C1; Tue, 22 Jan 2019 11:07:33 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
To: Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
 <20190111135842.GB3547@e103592.cambridge.arm.com>
 <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
 <20190116151254.GA3578@e103592.cambridge.arm.com>
 <20190119232128.GB26876@brain-police>
Message-ID: <1444d1a8-d6d6-e987-b3d2-6955bd607d64@arm.com>
Date: Tue, 22 Jan 2019 19:07:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119232128.GB26876@brain-police>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_110736_628745_1E55A398 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Amit Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/01/2019 23:21, Will Deacon wrote:
> On Wed, Jan 16, 2019 at 03:13:03PM +0000, Dave Martin wrote:
>> On Tue, Jan 15, 2019 at 07:32:30PM +0000, Kristina Martsenko wrote:
>>> We don't currently have any other separate nested structs in the arm64
>>> ptrace userspace interface. Other architectures also seem to only have a
>>> few rare instances of this.
>>>
>>> It seems odd to complicate the userspace interface because of a kernel
>>> implementation detail, but if you think it's better I could change the
>>> structs to:
>>>
>>> struct user_pac_key {
>>> 	__u64		lo;
>>> 	__u64		hi;
>>> };
>>>
>>> struct user_pac_address_keys {
>>> 	struct user_pac_key	apiakey;
>>> 	struct user_pac_key	apibkey;
>>> 	struct user_pac_key	apdakey;
>>> 	struct user_pac_key	apdbkey;
>>> };
>>>
>>> struct user_pac_generic_keys {
>>> 	struct user_pac_key	apgakey;
>>> };
>>
>> I don't have a strong opinion really.
>>
>> There's another option that occurred to me just now, and that's simply
>> to represent each key as a single __uint128_t in the user regset view
>> (with the _hi half strictly in the high 64 bits).
>>
>> This avoids questions about how to represent the halves of the key,
>> and prevents userspace from accessing half-keys.  How the half-keys
>> map to system registers is an architectural quirk that userspace perhaps
>> need not care about.
>>
>> If you like that approach, you could keep the kernel code as-is for now
>> and just do the conversion explicitly in the ptrace accessors (as in
>> your original patch).
> 
> I think that would be worth persuing. We already have __uint128_t types in
> our uapi/ headers, so we're not introducing anything new by using them here.

Ok, I'll send v3 with __uint128_t keys.

Thanks,
Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
