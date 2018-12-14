Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81758208C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6uh8xcw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnt1VyrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81758208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iLg/BRfUapmNl0upjOyKvuc2jORnR80UebncODXepvo=; b=u6uh8xcwnzPhF5
	CrXaZPluDPpbjKqqWHrESrjmGIE4DUzIF7tcJ3M0v3MUOSDjWA+CTDwVHNj6Xw3amI8HmuCltpZl+
	7dFWCCt6Rx1ZZL4ImUJzng3tRPW8vFlsr+NJiK0smYBBAD2v8GmYLrrVITm3b53gqByMyz9LR3bg+
	vrtkFRbmiP2Lfjk9jki5LAae86dr3Cxkjq8Vq+ek4hNGEaHj/khb/ggUZ9C2ThDJSy6vNL5GeZ++M
	zFWzwlvXNHlVBf8bIFtdRwEtzv5Y71WUx4p6lZqzWz//lk4Hgj9MSYrumEiTpB5Dh1GHkXlvAccCV
	XF+pLbbLr3fY5kUh3/pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvzS-0003dS-Uu; Fri, 14 Dec 2018 22:31:26 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvzQ-0003cW-2X
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:31:25 +0000
Received: by mail-vk1-xa44.google.com with SMTP id o130so1640882vke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=1aXsQu9yk6+RQb278EvNnMC6crwN3ixF95JlXBTg5B4=;
 b=qnt1VyrTUsBFFg8bMZs/8P84bIl8kifun+vi2QRIHyJ9zsy5k6eZvEyCTdyZ0SBcYy
 48v9MAfy4O4ZsfYud6FW9903I7DdM0xP+VfKXBKZfhMB/qHasiWxSptAd9BuicJ38RqC
 ptzYKOOGXHsDUf3RnBF8Qxao4q15TbBqA5oIR39KOV+koXhG/amQeDtcM405ga66nDo9
 hqZd7aj+R+Yz9AtBkp4jfD5XQRiwOkYrrcq+Gi9XcuWNcUj74vGolu5aQI857c3fgi+2
 x3Kh+6tOynPja1fUc1a7NXA321txMws9mGQJbuaDc3iwRRgo0utlV9deigkPu6vJUxkW
 nncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=1aXsQu9yk6+RQb278EvNnMC6crwN3ixF95JlXBTg5B4=;
 b=T9fw53+HHVJiW+0MdaXnaCBJiBN+4Com9oCwfk3Z9MoLwkwCOC82ifRSNDdXH+lTAc
 GqVzgGRZlUNaDE5NYFhWpXMGnvGIAFtHV4ZY9F4MKDXmomoI0yujtX97VeyTjHPHcCS4
 P8UB1fujlPDvfQ9+1rjgJk84ge+iqJ+2Wm+7nvT2jrxnvRBpgG30SZL68bJexfAWigJ0
 w3MrUngCoXERQz0yeqDESLmAWr8zRWpBp8/kYvZi0MsCNReq0uG/gXNhB5jyzKQChpPp
 7jhcBSePwd5AWLE0mlk1Hr2blvN3fASUEaeFq5oym99PcyoEZGqVxcBChFvCkTEdmn6X
 o7lw==
X-Gm-Message-State: AA+aEWap4cSxpB+08N76ku+qDUTKQIA1g9XpRflvEW68Vb6LRAn7Eu5H
 bsXGAxdYKPF98RFvecokbUPK75Md41k7wkda2Ew=
X-Google-Smtp-Source: AFSGD/Xu8zz10yAibznyL7tmWADFlIsar+MPEhx6wi8b+C3ypFNldBkJFmbp6ZZSzdCaV+VS7VMxpK9Pab6sBK/Zw4Y=
X-Received: by 2002:a1f:f8cf:: with SMTP id w198mr2149238vkh.82.1544826672105; 
 Fri, 14 Dec 2018 14:31:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:4401:0:0:0:0:0 with HTTP; Fri, 14 Dec 2018 14:31:11
 -0800 (PST)
In-Reply-To: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
 <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
From: gengdongjiu <gengdj.1984@gmail.com>
Date: Sat, 15 Dec 2018 06:31:11 +0800
Message-ID: <CAMj-D2D_fsOS1La3HGV2=bys5KjeQ0=fskrAL1V9FEkUTHFo1w@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_143124_121336_733DA9CC 
X-CRM114-Status: GOOD (  20.85  )
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
Cc: peter.maydell@linaro.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com,
 rkrcmar@redhat.com, will.deacon@arm.com, christoffer.dall@arm.com,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI James,

      Thanks for the mail and comments, I will reply to you in the next mail.

2018-12-14 21:55 GMT+08:00, James Morse <james.morse@arm.com>:
> Hi Dongjiu Geng,
>
> On 14/12/2018 10:15, Dongjiu Geng wrote:
>> When user space do memory recovery, it will check whether KVM and
>> guest support the error recovery, only when both of them support,
>> user space will do the error recovery. This patch exports this
>> capability of KVM to user space.
>
> I can understand user-space only wanting to do the work if host and guest
> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
> kernel feature.
>
> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying
> to
> map a page at stage2 that the kernel-mm code refuses this because its
> poisoned.
> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>
> This is exactly the same as happens to a normal user-space process.
>
> I think you really want to know if the host kernel was built with
> CONFIG_MEMORY_FAILURE. The not-at-all-portable way to tell this from
> user-space
> is the presence of /proc/sys/vm/memory_failure_* files.
> (It looks like the prctl():PR_MCE_KILL/PR_MCE_KILL_GET options silently
> update
> an ignored policy if the kernel isn't built with CONFIG_MEMORY_FAILURE, so
> they
> aren't helpful)
>
>
>> diff --git a/Documentation/virtual/kvm/api.txt
>> b/Documentation/virtual/kvm/api.txt
>> index cd209f7..241e2e2 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4895,3 +4895,12 @@ Architectures: x86
>>  This capability indicates that KVM supports paravirtualized Hyper-V IPI
>> send
>>  hypercalls:
>>  HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
>> +
>> +8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
>> +
>> +Architectures: arm, arm64
>> +
>> +This capability indicates that guest memory error can be detected by the
>> KVM which
>> +supports the error recovery.
>
> KVM doesn't detect these errors.
> The hardware detects them and notifies the OS via one of a number of
> mechanisms.
> This gets plumbed into memory_failure(), which sets a flag that the mm code
> uses
> to prevent the page being used again.
>
> KVM is only involved when it tries to map a page at stage2 and the mm code
> rejects it with -EHWPOISON. This is the same as the architectures
> do_page_fault() checking for (fault & VM_FAULT_HWPOISON) out of
> handle_mm_fault(). We don't have a KVM cap for this, nor do we need one.
>
>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index b72a3dd..90d1d9a 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm,
>> long ext)
>>  		r = kvm_arm_support_pmu_v3();
>>  		break;
>>  	case KVM_CAP_ARM_INJECT_SERROR_ESR:
>> +	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
>>  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>>  		break;
>
> The CPU RAS Extensions are not at all relevant here. It is perfectly
> possible to
> support memory-failure without them, AMD-Seattle and APM-X-Gene do this.
> These
> systems would report not-supported here, but the kernel does support this
> stuff.
> Just because the CPU supports this, doesn't mean the kernel was built with
> CONFIG_MEMORY_FAILURE. The CPU reports may be ignored, or upgraded to
> SIGKILL.
>
>
>
> Thanks,
>
> James
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
