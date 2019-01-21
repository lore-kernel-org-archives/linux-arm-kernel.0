Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5BC2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF0C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I5kdPvWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF0C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n6dhC+oHYlBW+vr4XEI5R3XffuF07PjediTGguHR154=; b=I5kdPvWWB68TpC+hwZjzioPbN
	xsFmiMV/EbZ6b2vRkNdGHAU5tBGJiWzTtHx+Ar0tX9T4mZMGfD4bJ+foUQg0UHfjGLxp6Gfp8H15h
	jV+BQZpi33S5lchKzcaSdodDbohl02JSwk1Dvu8AzByCqxCRo2TKdKBwEHsJ0//frfE8MiK2sO7JU
	un3QrbEkM4yAzq1rLjQzN5++GwigFcEDAYkOVlBnA+I2CWNSLTYspf+lcvpKwEaYIy+Eva5X7LF5Q
	XpnY+xWxWuxAODdFo9Ngon3ub5LgnBDYVYQ5DKBR3x9sXnXch0q2EiKB+g7U0Yb3b+FZgxWj0VbiH
	at66ubA1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZaP-00085u-OD; Mon, 21 Jan 2019 13:25:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZaL-000859-Pf
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:25:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 563B980D;
 Mon, 21 Jan 2019 05:25:53 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D03E73F614;
 Mon, 21 Jan 2019 05:25:50 -0800 (PST)
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
Date: Mon, 21 Jan 2019 13:25:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_052553_839814_3070D7E1 
X-CRM114-Status: GOOD (  19.71  )
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
Cc: pdaly@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 pratikp@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21/01/2019 10:50, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>
>> Hi,
>>
>>
>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>
>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>>>>
>>>> Qualcomm SoCs have an additional level of cache called as
>>>> System cache, aka. Last level cache (LLC). This cache sits right
>>>> before the DDR, and is tightly coupled with the memory controller.
>>>> The clients using this cache request their slices from this
>>>> system cache, make it active, and can then start using it.
>>>> For these clients with smmu, to start using the system cache for
>>>> buffers and, related page tables [1], memory attributes need to be
>>>> set accordingly. This series add the required support.
>>>>
>>>
>>> Does this actually improve performance on reads from a device? The
>>> non-cache coherent DMA routines perform an unconditional D-cache
>>> invalidate by VA to the PoC before reading from the buffers filled by
>>> the device, and I would expect the PoC to be defined as lying beyond
>>> the LLC to still guarantee the architected behavior.
>>
>> We have seen performance improvements when running Manhattan
>> GFXBench benchmarks.
>>
> 
> Ah ok, that makes sense, since in that case, the data flow is mostly
> to the device, not from the device.
> 
>> As for the PoC, from my knowledge on sdm845 the system cache, aka
>> Last level cache (LLC) lies beyond the point of coherency.
>> Non-cache coherent buffers will not be cached to system cache also, and
>> no additional software cache maintenance ops are required for system cache.
>> Pratik can add more if I am missing something.
>>
>> To take care of the memory attributes from DMA APIs side, we can add a
>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
>>
> 
> So does the device use the correct inner non-cacheable, outer
> writeback cacheable attributes if the SMMU is in pass-through?
> 
> We have been looking into another use case where the fact that the
> SMMU overrides memory attributes is causing issues (WC mappings used
> by the radeon and amdgpu driver). So if the SMMU would honour the
> existing attributes, would you still need the SMMU changes?

Even if we could force a stage 2 mapping with the weakest pagetable 
attributes (such that combining would work), there would still need to 
be a way to set the TCR attributes appropriately if this behaviour is 
wanted for the SMMU's own table walks as well.

Robin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
