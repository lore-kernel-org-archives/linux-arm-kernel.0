Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:39:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA2D2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FyWvQB2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA2D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TzxIj5pJXszM7nP8JQEeb6OG01vKJnszgJemy0r5qUc=; b=FyWvQB2PUyn/afCcuMe+bg9hO
	x6hK0T8iHh6fWdBDdPr0a5NHyZXuwr/ANkuMdIkTzx4ic10EuamZO3eUBQXLN99WPICLJkSfxLcjC
	2fg+U5GlyFflPqO9BeU8ptB0TevZL7GeANyPGrzp9PoUDO/81gvrKezeZStFAVHrDrG3TAtgchOA8
	VsjZRwCq+X5avLC+fhd+HcARctBIokjMceQpKHRa3I95BBnfGMDEMIqVWFjJ9ohgbGrdiBoTStcoS
	CZTQnLK6fiPMNaKbz0uSOGQU7DFVpDbJrAXgZYLL9z7/8dGmzMJ/87Yk3y3YLU3KzKx8jaaQMA16/
	1pK6etuSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxa4-0005MW-Sb; Wed, 30 Jan 2019 21:39:36 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxZz-0005L0-PG
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:39:34 +0000
Received: by mail-pg1-f194.google.com with SMTP id z10so395204pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UT1/CPe4a+VQZZIdyQrfYVvXt1xFlpKFQPpVpy3Vadw=;
 b=QSQOqEbV+VTGSCumyWAjG6BXIKFiT1DAofRqNj0cNJ8y/kx2iiu2ys7qAJPyZBU+Cj
 tqW104axXIJoTefZg96tFCoDWYnN7E07azw/lC7K27aZJAKftqXZb6mfIOCQmdjRsJjf
 fuBC4s7ogtfD1/5ettcQYAj9esZOGD7oMNlAgOOR34kIeRhcHIgj2/O9HpgCh6oqhpsx
 rPqXS8ITcYvmWBCq/iY9OP/1VIAYGSO6zrmhWzEY+ajRTY7z/wxDivOzW4jPb0KYtZ8U
 UtNjmuwLYqCkbskrWbb+WJcF85O10yT6oOcra4SyRJJuj/Y77Z5NH9xzxJJpO1u+Mbl0
 NlcQ==
X-Gm-Message-State: AJcUukfoRIeOKVKGUl0oMjJwJxJ2nTA32HQWcm+QqLQ8h45bXgG7W5KD
 mfYfOnW68Kzl9e8r3YTRLqi25Q==
X-Google-Smtp-Source: ALg8bN7EDNkc35oA5eozhZn9IKSNl6w5iqCILzorx+7n/1sx+I+JUxjw2qqZnclWNLT45ywKVk6RZQ==
X-Received: by 2002:a63:f717:: with SMTP id x23mr29433693pgh.317.1548884370527; 
 Wed, 30 Jan 2019 13:39:30 -0800 (PST)
Received: from localhost.localdomain ([122.177.95.151])
 by smtp.gmail.com with ESMTPSA id r76sm4012939pfb.69.2019.01.30.13.39.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 13:39:29 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: James Morse <james.morse@arm.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
Date: Thu, 31 Jan 2019 03:09:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_133931_851236_7F392B96 
X-CRM114-Status: GOOD (  22.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

Thanks for review.
Please see my comments inline.


On 01/30/2019 08:51 PM, James Morse wrote:
> Hi Bhupesh,
> 
> On 01/30/2019 12:23 PM, Bhupesh Sharma wrote:
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
>> User-space tools like 'makedumpfile' and 'crash-utility' can instead
>> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
>> the maximum virtual address and physical address (respectively)
>> supported by underlying kernel.
>>
>> A reference 'makedumpfile' implementation which uses this approach to
>> determining the maximum physical address is available in [0].
> 
> Why does it need to know?
> 
> (Suzuki asked the same question on your earlier version)
> https://lore.kernel.org/linux-arm-kernel/cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com/ 

I have shared some details (after discussion with our test teams) in 
reply to the review comments from Suzuki here:
http://lists.infradead.org/pipermail/kexec/2019-January/022389.html, and
http://lists.infradead.org/pipermail/kexec/2019-January/022390.html

Just to summarize, I mentioned in my replies to the review comments tha 
the makedumpfile implementation (for decoding the PTE) was just as an 
example, however there can be other user-space applications, for e.g a 
user-space application running with 48-bit kernel VA and 52-bit user 
space VA and requesting allocation in 'high' address via a 'hint' to mmap.

>  From your github link it looks like you use this to re-assemble the two 
> bits of the PFN from the pte. Can't you always do this for 64K pages? 
> CPUs with the feature always do this too, its not something the kernel 
> turns on.

Ok, let me try to give some perspective of a common makedumpfile 
use-case before I jump into the details:

(a) makedumpfile tool can be used to generate a vmcore and analyze it 
later. So for example we can create vmcore for a system running with 
page-size = 64K and analyze it later on a different system using 
page-size = 4K.

Since several makedumpfile code legs (for page-table walk) are common in 
both the paths (creating a vmcore and analyzing a vmcore), we cannot 
hardcode the PTE calculation masks for either 48-bit or 52-bit address 
spaces (or 4K/64K page sizes). The example invocations for the two cases 
is given below:

Create a vmcore dump on a 64K machine:
# makedumpfile -l --message-level 1 -d 31 /proc/vmcore vmcore

Analyze the vmcore dump on a 4K machine:
# makedumpfile -d 31 -x vmlinux vmcore dumpfile

Also hardcoding the PTE calculation to use the high address bit mask 
always will break the backward compatibility with older kernels (which 
don't support 52-bit address space extensions).

(b). Also x86_64 already has a vmcoreinfo export for 'pgtable_l5_enabled':

void arch_crash_save_vmcoreinfo(void)
{
	<.. snip..>
	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
			pgtable_l5_enabled());
}

And the makedumpfile code uses the same to determine support for 5-level 
page tables in x86_64, see 
<https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/x86_64.c#L36> 
for example.

Thanks,
Bhupesh

> 
>> diff --git a/arch/arm64/kernel/crash_core.c 
>> b/arch/arm64/kernel/crash_core.c
>> index ca4c3e12d8c5..ad231be5c0d8 100644
>> --- a/arch/arm64/kernel/crash_core.c
>> +++ b/arch/arm64/kernel/crash_core.c
>> @@ -10,6 +10,8 @@
>>   void arch_crash_save_vmcoreinfo(void)
>>   {
>>       VMCOREINFO_NUMBER(VA_BITS);
>> +    VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
>> +    VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>       /* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>>       vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>>                           kimage_voffset);
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
