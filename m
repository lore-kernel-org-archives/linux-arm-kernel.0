Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FA9222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8PcBWm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FA9222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xSLnEbfiMsG3ueYl1TJH4HPNh1xpkcLXhPNMYpgHY9w=; b=b8PcBWm4mKjg1F
	tVpNl+T6A6ZzoMwuhxNMprRYP0TN0ebWTCsEp4MpNGJ9xfvqgANhHrtMTEMtYo81VPewbeC8ySDDI
	bw8r9PhFO4h+yi7Hl5TMYlbwBoLxBSbN4Rr7QH2Gq3QMfVlgaI0TnSNq33g+NB4axSFJWT1HLg9eI
	EVphTO2VmutukO2j2wh3l2Tu/4lwd+Bu6HB1AoWhDfvKRK6RIQLvINPNbC8fV1oUygE8VpxgI8sy4
	PhC0yQN54zpSzcRfnSG+uWklUfXAVev9cLuFn5RAbvYUs+TGpM7YYUo8+zx8/l0IQlldkMzNTT8OG
	A3bx/xSjGRmZx1bq+gcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guflE-00057Q-9O; Fri, 15 Feb 2019 15:50:44 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufl1-0004t6-Gs
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:50:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9069CEBD;
 Fri, 15 Feb 2019 07:50:28 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 29B563F557; Fri, 15 Feb 2019 07:50:26 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v5 2/5] arm64/kvm: preserve host HCR_EL2/MDCR_EL2 value
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-3-git-send-email-amit.kachhap@arm.com>
 <8de32a89-4aa1-bffb-78dd-45feddc9216e@arm.com>
 <1a2534b9-6d3b-caac-ff05-7795b7a2d725@arm.com>
Message-ID: <7ec2f950-7587-5ecd-6caa-c2fd091ad22c@arm.com>
Date: Fri, 15 Feb 2019 15:50:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1a2534b9-6d3b-caac-ff05-7795b7a2d725@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075031_976220_8DCF2D5B 
X-CRM114-Status: GOOD (  19.59  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 11:03, Amit Daniel Kachhap wrote:
> Hi,
> 
> On 2/13/19 11:04 PM, Kristina Martsenko wrote:
>> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>>> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
>>> is a constant value. This works today, as the host HCR_EL2 value is
>>> always the same, but this will get in the way of supporting extensions
>>> that require HCR_EL2 bits to be set conditionally for the host.
>>>
>>> To allow such features to work without KVM having to explicitly handle
>>> every possible host feature combination, this patch has KVM save/restore
>>> the host HCR when switching to/from a guest HCR. The saving of the
>>> register is done once during cpu hypervisor initialization state and is
>>> just restored after switch from guest.
>>
>> Why is this patch needed? I couldn't find anything in this series that
>> sets HCR_EL2 conditionally for the host. It seems like the kernel still
>> always sets it to HCR_HOST_VHE_FLAGS/HCR_HOST_NVHE_FLAGS.
> 
> This patch is not directly related to pointer authentication but just a
> helper to optimize save/restore. In this way save may be avoided for
> each switch and only restore is done. Patch 3 does sets HCR_EL2 in VHE_RUN.

Patch 3 sets the HCR_EL2.{API,APK} bits for the *guest*, not the host.
This patch here adds saving/restoring for the *host* HCR_EL2. As far as
I can tell, the value of the host HCR_EL2 never changes.

Regarding save/restore, currently the kernel never saves the host
HCR_EL2, because it always restores HCR_EL2 to HCR_HOST_{,N}VHE_FLAGS (a
constant value!) when returning to the host. With this patch, we
effectively just save HCR_HOST_{,N}VHE_FLAGS into kvm_host_cpu_state,
and restore it from there when returning to the host.

Unless we actually change the host HCR_EL2 value to something other than
HCR_HOST_{,N}VHE_FLAGS somewhere in this series, this patch is unnecessary.

>>
>> Looking back at v2 of the userspace pointer auth series, it seems that
>> the API/APK bits were set conditionally [1], so this patch would have
>> been needed to preserve HCR_EL2. But as of v3 of that series, the bits
>> have been set unconditionally through HCR_HOST_NVHE_FLAGS [2].
>>
>> Is there something else I've missed?
> Now HCR_EL2 is modified during switch time and NHVE doesnt support
> ptrauth so [2] doesn't makes sense.

In case of NVHE, we do support pointer auth in the *host* userspace, so
the patch [2] is necessary. In case of NVHE we do not support pointer
auth for KVM *guests*.

Thanks,
Kristina

>> [1] https://lore.kernel.org/linux-arm-kernel/20171127163806.31435-6-mark.rutland@arm.com/
>> [2] https://lore.kernel.org/linux-arm-kernel/20180417183735.56985-5-mark.rutland@arm.com/


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
