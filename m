Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C354C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A640222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0par4x/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A640222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F5bly93yst0ft0YAt7llFxfwL6XJpt3USPWv+4J/Zpk=; b=C0par4x/Rpk90QZEjdznRY/2W
	5fz1ymKBV5Gzl2Ie4E5WPl7y1J+VMD/j0cXUbb14x6PcgnKJMOGzQMVp1hS9EomAMQgNRSKZ1ehuq
	lktqo8aawUT/e0qhOjsn+TBwSkpFDaq8MT0yzn6zcu4D9F1EBnbaNk+r2ssBF3fr+4iWs7MFdHoxx
	GebtpwBSEOEwvBpNsj+DJvJaBBspfx6BC2DhX1S9L4GobSJrsBaIvNCLP1j9ePKHP4BHCrCM111I4
	N8bQRzo5yZGI/X+K99AVckUFdxvLR9XxzH1oYl6fuLaAOodMEyp745E4GjcU6HH+xPs4s7oJXQ0b1
	XZwYY1+qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEeZ-0000eR-7R; Thu, 14 Feb 2019 10:54:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEeV-0000dl-Nd
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:54:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82601EBD;
 Thu, 14 Feb 2019 02:53:58 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3423F575;
 Thu, 14 Feb 2019 02:53:55 -0800 (PST)
Subject: Re: [PATCH v5 1/5] arm64: Add utilities to save restore pointer
 authentication keys
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 James Morse <james.morse@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
 <88ccd568-f027-6cdf-b4f1-6709d76102c1@arm.com>
 <adbeb25c-fa88-41fd-7819-5f412a762b64@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <41ab78a2-b2c0-61e9-e582-f2174d4203b5@arm.com>
Date: Thu, 14 Feb 2019 16:23:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <adbeb25c-fa88-41fd-7819-5f412a762b64@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_025359_774178_36B60A28 
X-CRM114-Status: GOOD (  19.53  )
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
 linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/13/19 11:02 PM, Kristina Martsenko wrote:
> On 31/01/2019 16:20, James Morse wrote:
>> Hi Amit,
>>
>> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>>> The keys can be switched either inside an assembly or such
>>> functions which do not have pointer authentication checks, so a GCC
>>> attribute is added to enable it.
>>>
>>> A function ptrauth_keys_store is added which is similar to existing
>>> function ptrauth_keys_switch but saves the key values in memory.
>>> This may be useful for save/restore scenarios when CPU changes
>>> privilege levels, suspend/resume etc.
>>
>>
>>> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
>>> index 15d4951..98441ce 100644
>>> --- a/arch/arm64/include/asm/pointer_auth.h
>>> +++ b/arch/arm64/include/asm/pointer_auth.h
>>> @@ -11,6 +11,13 @@
>>>   
>>>   #ifdef CONFIG_ARM64_PTR_AUTH
>>>   /*
>>> + * Compile the function without pointer authentication instructions. This
>>> + * allows pointer authentication to be enabled/disabled within the function
>>> + * (but leaves the function unprotected by pointer authentication).
>>> + */
>>> +#define __no_ptrauth	__attribute__((target("sign-return-address=none")))
>>
>> The documentation[0] for this says 'none' is the default. Will this only
>> take-effect once the kernel supports pointer-auth for the host? (Is this just
>> documentation until then?)
> 
> Yes, I don't think this should be in this series, since we're not
> building the kernel with pointer auth yet.
I added it to stress on some functions which should be pointer 
authentication safe. Yes this can be dropped and a small comment may 
also do.

//Amit D
> 
>>
>> ('noptrauth' would fit with 'notrace' slightly better)
> 
> (But worse with e.g. __noreturn, __notrace_funcgraph, __init,
> __always_inline, __exception. Not sure what the pattern is. Would
> __noptrauth be better?)
> 
> Thanks,
> Kristina
> 
>>
>> [0]
>> https://gcc.gnu.org/onlinedocs/gcc/AArch64-Function-Attributes.html#AArch64-Function-Attributes
>>
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
