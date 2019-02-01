Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E22C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B20E218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tqa4H9oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B20E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=obs1VNfMAmQkt1gYEmOCWtseDndyMTso6KWMoeK+CoM=; b=Tqa4H9oA59VHbT
	7B0SFOxbQL9L8t2JRDSut9vw78bjGBHMijoM1Fock0LQTYEOXMKgStDJ4hsYCNCFvH/mT8hFJkfLd
	DSmgQTbuq3iEEPjB43Jg07ZgS+Ak/m1Eq+gy0lmTIWV288TY1U41dE9w+Ef/bZJm+oLWzLJYPBNuY
	HgkN0l6euuzHVafv6GztjSpdxh0tK89OsAhRhIHPlBIl5KwjKaorTeTe1BI8dY5lSNXyh/HliNPjb
	50f6Xo+YJtaHoHuLnADFoRYK39Frd0WPMlx1F1eSH4cvs2MXJapX2NvFsgSR52+go1KdWt/l3a5i7
	pk+7T7G4Njf6r5hyE9gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXWT-00050n-41; Fri, 01 Feb 2019 12:02:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXWQ-00050U-8R
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:02:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9555380D;
 Fri,  1 Feb 2019 04:02:11 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519A83F59C;
 Fri,  1 Feb 2019 04:02:10 -0800 (PST)
Subject: Re: [PATCH v2 3/4] arm64: hyp-stub: Forbid kprobing of the hyp-stub
To: Christoffer Dall <christoffer.dall@arm.com>
References: <20190124163257.233929-1-james.morse@arm.com>
 <20190124163257.233929-4-james.morse@arm.com>
 <20190131080421.GJ13482@e113682-lin.lund.arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <195916cb-03ac-6d83-03a8-e09fec90b247@arm.com>
Date: Fri, 1 Feb 2019 12:02:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131080421.GJ13482@e113682-lin.lund.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_040214_306267_0D8A5913 
X-CRM114-Status: GOOD (  19.73  )
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
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Christoffer,

On 31/01/2019 08:04, Christoffer Dall wrote:
> On Thu, Jan 24, 2019 at 04:32:56PM +0000, James Morse wrote:
>> The hyp-stub is loaded by the kernel's early startup code at EL2
>> during boot, before KVM takes ownership later. The hyp-stub's
>> text is part of the regular kernel text, meaning it can be kprobed.
>>
>> A breakpoint in the hyp-stub causes the CPU to spin in el2_sync_invalid.
>>
>> Add it to the __hyp_text.

>> This has been a problem since kprobes was merged, it should
>> probably have been covered in 888b3c8720e0.
>>
>> I'm not sure __hyp_text is the right place. Its not idmaped,
>> and as it contains a set of vectors, adding it to the host/hyp
>> idmap sections could grow them beyond a page... but it does
>> run with the MMU off, so does need to be cleaned to PoC when
>> anything wacky, like hibernate happens. With this patch,
>> hibernate should clean the __hyp_text to PoC too.
> 
> How did this code get cleaned before?

It didn't need to be cleaned as KVM executes it with the MMU on.
KVM's MMU-off code lives in the hyp_idmap, which is cleaned. (as is the kernel's
idmap).

The hibernate-cache-cleaning was trying to do the absolute minimum, but the
hyp-stub got forgotten.


> Is there a problem you can identify with putting it in __hyp_text?

> Seems to me we should just stick it there if it has no negative
> side-effects and otherwise we have to make up a separate section with a
> specialized meaning.

Yup, there is no problem with the extra cache-maintenance.
The hyp-stub is the odd one out, its runtime code that runs with the MMU off,
but isn't idmaped. I wasn't sure if we wanted to create some special
section.(having to name it is a good enough reason not to!)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
