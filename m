Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC3220882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oD2ycSXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC3220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bSTLdxO8ErF/n7/tmjN2cmnjAq6rA1YbEUNbbq9jF7A=; b=oD2ycSXx2ErviXtx05cY1kxnq
	MhkrSqr0nzzdVeyCeZ0drdKq1uvbEfa/PPt+uMR+y2hAY1h/7+WDMZde5x9LeAWJ6XZhhvjWFO4j1
	DQdsNVAMjdnJ6YFj2AIEJeTCwdeYAFWFYBb26huePBKyV2IPV9ogJX1wJUmV7U8zq+q0rRvMe148Q
	dzgadf6i9mdMcKWDoDN6vgdKR9b8/nHozBrcq5ijQ87hqN1ne3Ptp8mkhW3FRDI1cxfj8SjDmeb7e
	em6K0E/8dmJkaXKC/EfFJ+sqOao6atNsoM9QRoo7v5ygR0Zpn3S4cJYZ8cIXo9TqNHEOWzIwZetIq
	wBXH9YaWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorIS-0002Sz-R3; Wed, 30 Jan 2019 14:57:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorIP-0002SH-1i
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 14:56:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53B5EBD;
 Wed, 30 Jan 2019 06:56:55 -0800 (PST)
Received: from [10.37.9.196] (unknown [10.37.9.196])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B3C3F589;
 Wed, 30 Jan 2019 06:56:53 -0800 (PST)
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
To: Catalin Marinas <catalin.marinas@arm.com>,
 "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <20190129181032.GC224095@arrakis.emea.arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <57c09d48-2c09-f1e1-0f70-c8249bc8329f@arm.com>
Date: Wed, 30 Jan 2019 14:56:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190129181032.GC224095@arrakis.emea.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_065657_090601_6B14C3E2 
X-CRM114-Status: GOOD (  20.37  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

On 01/29/2019 06:10 PM, Catalin Marinas wrote:
> Could you please copy the whole description from the cover letter to the
> actual patch and only send one email (full description as in here
> together with the patch)? If we commit this to the kernel, it would be
> useful to have the information in the log for reference later on.
> 
> More comments below:
> 
> On Tue, Jan 29, 2019 at 12:29:58PM +0000, Zhang, Lei wrote:
>> On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
>> memory accesses may cause undefined fault (Data abort, DFSC=0b111111).
>> This problem will be fixed by next version of Fujitsu-A64FX.
>>
>> This fault occurs under a specific hardware condition
>> when a load/store instruction perform an address translation using:
>>    case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
>>    case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
>>    case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
>>    case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
>> And this fault occurs completely spurious.
> 
> So this looks like new information on the hardware behaviour since the
> v2 of the patch. Can this fault occur for any type of instruction
> accessing the memory or only for SVE instructions?
> 
>> Since TCR_ELx.NFD1 is set to '1' at the kernel in versions
>> past 4.17, the case-3 or case-4 may happen.
>>
>> This fault can be taken only at stage-1,
>> so this fault is taken from EL0 to EL1/EL2, from EL1 to EL1,
>> or from EL2 to EL2.
>>
>> I would like to post a workaround to avoid this problem on
>> existing Fujitsu-A64FX version.
> 
> How likely is it to trigger this erratum? In other words, aren't we
> better off with a spurious fault that we ignore rather than toggling the
> TCR_ELx.NFD1 bit?

It sounds like the spurious fault can occur as a result of load/store. 
('there is no load/store instruction between'...).

If this can happen in kernel_enter it will overwrite the exception 
registers, and we lose the original ELR.

If load/store trigger it, I don't think we can ignore it.

Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
