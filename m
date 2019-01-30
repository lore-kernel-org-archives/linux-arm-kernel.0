Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB48C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2C8218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BlsN0OhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2C8218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/IJA1eUgPJp7W+Fva4suHmhpMEsImZoasegMgsKX9Hk=; b=BlsN0OhL1ckUDVkyUSS7x6xhV
	MLeVbGs8OsmyQWckmN4z6NRRqnEcTZHoTGm/fPf4CE0rSgc53a9lN+Mr0HJwLIFKOILPUXyjdOntk
	OpDymBK+4+bkHEjEIExOr/a70JbWrAuMcoLPTNvHfHArGd1Q0uug8Xg9J2jIDVZIMeWJc67LAfEEX
	epbbWu7CNP4loopBKRjiXlU0uYNG0r4A/va8Fx2vKk0UiBJQaq0AUaizmvyE2Up3zMYKLyi61LL9q
	RIKmcjtMMoJQ3aqq6ymO9UvGyH9OPdlt9907eZHYnT9ILe5ltndf9PjhxXy15Qyzin+TR/Moxi5Af
	Fu2QFmEsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorfy-0008CN-Az; Wed, 30 Jan 2019 15:21:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorft-0008BP-Sv; Wed, 30 Jan 2019 15:21:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33704EBD;
 Wed, 30 Jan 2019 07:21:13 -0800 (PST)
Received: from [10.37.9.196] (unknown [10.37.9.196])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CF773F557;
 Wed, 30 Jan 2019 07:21:10 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: Bhupesh Sharma <bhsharma@redhat.com>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
Date: Wed, 30 Jan 2019 15:21:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_072113_941381_03C6457D 
X-CRM114-Status: GOOD (  17.33  )
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

Hi Bhupesh,

On 01/30/2019 12:23 PM, Bhupesh Sharma wrote:
> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> supports these extensions can support upto 52-bit virtual and 52-bit
> physical addresses respectively.
> 
> Since at the moment we enable the support of these extensions via CONFIG
> flags, e.g.
>   - LPA via CONFIG_ARM64_PA_BITS_52
> 
> there are no clear mechanisms in user-space right now to
> deteremine these CONFIG flag values and also determine the PARange and
> VARange address values.
> User-space tools like 'makedumpfile' and 'crash-utility' can instead
> use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> the maximum virtual address and physical address (respectively)
> supported by underlying kernel.
> 
> A reference 'makedumpfile' implementation which uses this approach to
> determining the maximum physical address is available in [0].

Why does it need to know?

(Suzuki asked the same question on your earlier version)
https://lore.kernel.org/linux-arm-kernel/cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com/


 From your github link it looks like you use this to re-assemble the two 
bits of the PFN from the pte. Can't you always do this for 64K pages? 
CPUs with the feature always do this too, its not something the kernel 
turns on.


Thanks,

James


> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index ca4c3e12d8c5..ad231be5c0d8 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -10,6 +10,8 @@
>   void arch_crash_save_vmcoreinfo(void)
>   {
>   	VMCOREINFO_NUMBER(VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>   	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
>   	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>   						kimage_voffset);
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
