Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E61C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE262085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tm9H/Hzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE262085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wAPlaC3tai11X1NRqIevxvdL34TvW37PMr9Ku0IaQPU=; b=tm9H/HzrQFthq4
	s1xUlS5i78BEgLVi4FNBZXk+Z8ysne+gYCZSbeUbFiOEygciHeGTY7m3bmi+hBndgezisy8pc2rF8
	9cMUxWkGU1gG+goFD0ID5t5Yq+k3QUNlGh6gg+FbZC2ZYc/EKa3/IL9e1VCX1J9XcRwnvsDayJfDZ
	wy0PZNZAGUMCVlxtrwb863O5T3zpVJYHt6+XYFm+8v3PBofdUvJSRLU61zaT/Zntc2FP+M0LUWXK8
	zOPM+yHHd6p+28S5usT5LD/inl3wGOUpQDgt49l36ZHhHh22vbX86VcWedYx6GrVjncNQrXsV9Wgp
	sTgtJctkjZQH40aiwmcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF76-0002Th-Ls; Thu, 31 Jan 2019 16:22:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF42-0006c0-Iy
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:20:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C3A80D;
 Thu, 31 Jan 2019 08:19:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759CB3F557;
 Thu, 31 Jan 2019 08:19:37 -0800 (PST)
Subject: Re: [PATCH v4 3/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To: Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-4-git-send-email-amit.kachhap@arm.com>
 <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
 <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <3936d9fd-1e3f-0437-e866-edf2d9cbf797@arm.com>
Date: Thu, 31 Jan 2019 16:19:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081943_258581_4DFF614C 
X-CRM114-Status: GOOD (  15.45  )
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
 kvmarm@lists.cs.columbia.edu, LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 09/01/2019 10:13, Amit Daniel Kachhap wrote:
> On Sat, Jan 5, 2019 at 12:05 AM James Morse <james.morse@arm.com> wrote:
>> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
>>> This feature will allow the KVM guest to allow the handling of
>>> pointer authentication instructions or to treat them as undefined
>>> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
>>> supply this parameter instead of creating a new API.
>>>
>>> A new register is not created to pass this parameter via
>>> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
>>> supplied is enough to select this feature.
>>
>> What is the motivation for doing this? Doesn't ptrauth 'just' need turning on?
>> It doesn't need additional setup to be useable, or rely on some qemu support to
>> work properly. There isn't any hidden state that can't be migrated in the usual way.
>> Is it just because we don't want to commit to the ABI?

> This allows migration of guest to non pointer authenticated supported
> systems and hides the extra ptrauth registers.

The MIDR already has to match, so the hardware must be the same. I guess this
lets us hide the new feature so old-guests can migrate to a new-kernel without a
write to the id registers failing.


> Basically this suggestion was given by Christoffer
> (https://lore.kernel.org/lkml/20180206123847.GY21802@cbox/).

Ah, Christoffer asked for it, that's reason enough!


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
