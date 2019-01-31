Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8E020B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mjEOYlxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8E020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5FkBFkdJ3mT1j/ovgBYZLDUvtSYGLCD/59Z1OHaQXGs=; b=mjEOYlxjfPoWCodmL/5i9wp5c
	ks3lVMv4yj288eu9sueJw0wisA0tOGr3b8NpIAsGvLVbQ8XJPRe1uVtWiMZs8/jYgWuLJc0qUcKUI
	L0kEXFRp561+lezkmpVFZ/mk7cfEFNg6iNp+pbLUxph+3Y2URkRO6PFhhncHqjAfk6Rs8U06n5mVK
	J1PGcfnK3FfUy96wsyFrYIgC8NNaAZ0Di2wQ3xvOlrhrhhcsdlmYKaq1PYJ5NtZ7Z3i7BJfHgAbML
	c3Tdkouv7AxZHLt7Y6L4NNxmaqQYG5CRtmJo7VjgQy5NFGB3L20UYEvuiD2JdkTqWth0kNfp6wC6G
	VB68/KUHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp99L-0008B8-LM; Thu, 31 Jan 2019 10:00:47 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp999-00086X-PU
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 10:00:46 +0000
Received: by mail-pl1-f195.google.com with SMTP id g9so1262538plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 02:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Zk8fCKGcwFOlbi8/VCnTqjOfz4OolTD3RCIWtnuFFU=;
 b=D6Z7MsMLuwESWZA3lN37vxJL3dzLj1JBN+N2hYCQvjCZ9gIgxzUHpTxJjWvGn0fFZP
 RFmeBTpE16xEGVDE6WayBOEdbRtYBt9jxKY/S7d1q5CSQzvcT6PTR8wj35JY0b6ilnPu
 ZmAQST3uboyusjXalOOMZ96ERJPi/7gr3Eo9vyKkvIsOjtPWL7my7mPfDK7nd8vNo+MG
 wZExvbWy/NlfRAn+JbhZIOwo01L1hMVZjlVku9t0fwq8FqYeYMA2C6N5ShJUw4gl074x
 gLVJo8GwQJ4Hi178DCKEXnsJdHrdpVhcZR4fKKow34hOTlVyVOSgYOoWycwsaz26Rll4
 AlWA==
X-Gm-Message-State: AJcUukfFVZqYFrG+9jxM0KOkjF09gJrz+m5Bo7L4869xg6XT/adK3tFt
 tEwtdkieLmTmpLchjCwqDd2H+A==
X-Google-Smtp-Source: ALg8bN73b/p+OPpHiGsM3LcDnday12vhOx5p+EGw3jFvKX7KM8MV7hdmLV38kQ0gk9rjxD9PIFx5DA==
X-Received: by 2002:a17:902:690c:: with SMTP id
 j12mr33813336plk.206.1548928832355; 
 Thu, 31 Jan 2019 02:00:32 -0800 (PST)
Received: from localhost.localdomain ([122.177.95.151])
 by smtp.gmail.com with ESMTPSA id v184sm6022797pfb.182.2019.01.31.02.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 02:00:30 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Dave Young <dyoung@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <fea7823d-60ab-2765-031f-6e8c312d7672@redhat.com>
Date: Thu, 31 Jan 2019 15:30:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_020035_833035_26895AA4 
X-CRM114-Status: GOOD (  31.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 lijiang@redhat.com, bhe@redhat.com, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 anderson@redhat.com, bhupesh.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/31/2019 07:18 AM, Dave Young wrote:
> + more people
> On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
>> supports these extensions can support upto 52-bit virtual and 52-bit
>> physical addresses respectively.
>>
>> Since at the moment we enable the support of these extensions via CONFIG
>> flags, e.g.
>>   - LPA via CONFIG_ARM64_PA_BITS_52
>>
>> there are no clear mechanisms in user-space right now to
>> deteremine these CONFIG flag values and also determine the PARange and
>> VARange address values.
>>
>> User-space tools like 'makedumpfile' and 'crash-utility' can instead
>> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
>> the maximum virtual address and physical address (respectively)
>> supported by underlying kernel.
>>
>> A reference 'makedumpfile' implementation which uses this approach to
>> determining the maximum physical address is available in [0].
>>
>> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
> 
> I'm not objecting the patch, just want to make sure to make clear about
> things and make sure these issues are aware by people, and leave arm
> people to review the arm bits.
> 
> 1. MAX_PHYSMEM_BITS
> As we previously found, back to 2014 makedumpfile took a patch to read the
> value from vmcore but the kernel patch was not accepted.
> So we should first make clear if this is really needed, why other arches
> do not need this in makedumpfile.

I explained this a bit in my reply to Suzuki's and James's review 
comments yesterday, but let me summarize the same again for better clarity:

Let's take the example of x86. We have CONFIG_X86_5LEVEL config flag to 
indicate 5 level page-table support. We export the same in vmcoreinfo 
for x86_64 using:

void arch_crash_save_vmcoreinfo(void)
{
     <.. snip..>
     vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
             pgtable_l5_enabled());
}

Also a simple grep in makedumpfile and crash for the same indicates that 
the user-space code determines the MAX_PHYSMEM_BITS value using the 
'pgtable_l5_enabled' value available in vmcoreinfo:

Example from makedumpfile:
-------------------------
int
get_versiondep_info_x86_64(void)
{
	/*
	 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
	 */
	if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
	else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
	else if(check_5level_paging())
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
	else
		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;

	...
}

As we can see above, we use several if-else cases to determine the 
'MAX_PHYSMEM_BITS', one of which is setting it to 52-bit, if the 
'pgtable_l5_enabled' value is available and TRUE in vmcoreinfo.

So, we determine 'MAX_PHYSMEM_BITS' value in makedumpfile via a 
vmcoreinfo export'ed variable (rather than using  named 
'MAX_PHYSMEM_BITS' its 'pgtable_l5_enabled' that is being used).

Since for arm64, we don't have a single CONFIG flag for 52-bit addresses 
spaces (kernel VA, user-space VA and PA), so its better to export the 
respective CONFIG flags in the vmcoreinfo directly.

> If we really need it then should it be arm64 only?

See above, since archs like x86 use a single flag: CONFIG_X86_5LEVEL, 
whereas arm64 can use the combination of following flags to indicate 
combinations of various address spaces:

- 48-bit kernel VA + 48-bit user-space VA + 52-bit PA
- 48-bit kernel VA + 52-bit user-space VA + 52-bit PA
- 52-bit kernel VA + 52-bit user-space VA + 52-bit PA


CONFIG_ARM64_64K_PAGES
CONFIG_ARM64_USER_VA_BITS_52
CONFIG_ARM64_VA_BITS
CONFIG_ARM64_PA_BITS_52
CONFIG_ARM64_PA_BITS
CONFIG_EXPERT, and
CONFIG_ARM64_FORCE_52BIT

so probably its not correct to compare the two cases one-to-one (its 
more like an apple and an orange comparison).

> If it is arm64 only then the makedumpfile code should read this number
> only for arm64.
> 
> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> tree,  need to make sure to document this as well.

Sure, I will send a separate patch to fix the same, once this gets in.

> 
> 2. MAX_USER_VA_BITS
> Does makedumpfile care about userspace VA bits? 

Yes. Consider the case 48-bit kernel VA and 52-bit user-space VA, which 
is a perfectly valid case on arm64. In such cases VA_BITS is set to 48, 
whereas  MAX_USER_VA_BITS is set to 52, which allows user-space 
applications which use 52-bit virtual address to pass a hint to 'mmap' 
to get high addresses.

  I do not see other code
> doing this,  Kazu and Dave A should be able to comment.

I talked to Dave A. yesterday off-list, I think he mentioned that these 
changes are useful for crash-utility as well and he was hoping it gets 
accepted soon so that kernel-debugging tools can handle increased 
address spaces on arm64.

But it will be great to have reviews/ACKs from Dave A and others as well.

Thanks,
Bhupesh

> 
> I tend to doubt about this.
> 
>>
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   arch/arm64/kernel/crash_core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
>> index ca4c3e12d8c5..ad231be5c0d8 100644
>> --- a/arch/arm64/kernel/crash_core.c
>> +++ b/arch/arm64/kernel/crash_core.c
>> @@ -10,6 +10,8 @@
>>   void arch_crash_save_vmcoreinfo(void)
>>   {
>>   	VMCOREINFO_NUMBER(VA_BITS);
>> +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
>> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>   	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>>   	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>>   						kimage_voffset);
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> Thanks
> Dave
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
