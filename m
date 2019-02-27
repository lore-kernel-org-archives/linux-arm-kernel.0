Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88133C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:54:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570FE218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijOBapWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570FE218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H7v6vp6yHqzscZuI8OdgK9PtYr64ent/CfIiJKe+86o=; b=ijOBapWjuXZG+jsqBE7T39PQX
	MvRQhSclFkFf0R3dINehB872F36RiFVhNKa35WoQ91B+9UwZT6iUuP0LdMqxtkm6jrY31wb2oEgLE
	CWVt9PVKVivAtfWTnFWlFkhmdpJZNQ3IxMqNyxoowIjR7uBmdxNAA+tNt+QEt1T/U48T4cKf++2V8
	9FPjPVhO+SM8lDBqrLdfIwS/M7gLSdpjOedkeUS1mT0FENnzVIrE/QZ+OwrU1TUdJKt8bAFSK5/b8
	8u278wtAIdUy5TetrVLi+db18cKXMS0+WQ47oywHf5H9AAC7ycTx23qr1GWvF7V3uCXd9pcV71IRx
	cgFpuMLcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynUP-00017M-UP; Wed, 27 Feb 2019 00:54:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynUM-00016v-Bk
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:54:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADAF480D;
 Tue, 26 Feb 2019 16:54:20 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828B83F5C1;
 Tue, 26 Feb 2019 16:54:19 -0800 (PST)
Subject: Re: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
To: Rob Herring <robh@kernel.org>
References: <20190226181716.14556-1-robh@kernel.org>
 <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
 <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0bcd215e-e013-6891-ecd4-da4c91bb4eb9@arm.com>
Date: Wed, 27 Feb 2019 00:54:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ857qSQTQ9WFCrPQxNsZ=6uB-PPwCY7cXmkcsP2NA=YQ@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_165422_409927_0C487934 
X-CRM114-Status: GOOD (  17.91  )
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
Cc: Joerg Roedel <joro@8bytes.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Will Deacon <will.deacon@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-26 8:05 pm, Rob Herring wrote:
> On Tue, Feb 26, 2019 at 1:25 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Hi Rob,
>>
>> On 26/02/2019 18:17, Rob Herring wrote:
>>> ARM Mali midgard GPUs have a few differences from standard 64-bit
>>> stage 1 page tables.
>>>
>>> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
>>>
>>> The access flags are not read-only and unprivileged, but read and write.
>>> This is similar to stage 2 entries, but the memory attributes field matches
>>> stage 1 being an index.
>>>
>>> The nG bit is also not set by the vendor driver, but that one doesn't
>>> seem to matter.
>>>
>>> Add a quirk to handle all of these differences.
>>
>>   From the look of these changes, this isn't a quirk but a distinct
>> format. AFAICS from the mali_kbase driver, this must be "LPAE mode"
>> rather than "AArch64 mode", so it seems unlikely that it really supports
>> the full VMSAv8 gamut of granules, address sizes, and page sizes that
>> this patch will happily let through.
> 
> Right, but the page size bitmap and the in and out address sizes in
> the config struct should be enough to restrict those.
> 
> What do you propose? Add another init function which hardcodes all
> those or add some checks of allowed settings?

Or rather somewhere in between, i.e. add a new io_pgtable_fmt with an 
init function which sanity checks/constrains the request appropriately 
(like the existing ones do), and which could at least help make 
arm_lpae_pte_to_prot() less of a mess.

We don't treat v7 LPAE as a quirk of v8 AArch64, even though we 
implement it as a strict subset, and neither do we treat stage 2 as a 
quirk of stage 1 (or vice versa). This Midgard "LPAE" format appears 
more different from any of the VMSA long-descriptor formats than they 
are from each other - it certainly doesn't seem like a case of someone 
aiming to implement AArch64 stage 1 but getting one or two details 
slightly wrong.

(I know I implemented Mediatek's Frankein-short-descriptor as a set of 
quirks rather than introducing multiple v7s formats, but that's largely 
because it's the only real user of that code, and most of them are 
generic enough that they could well be common to other formats in future)

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
