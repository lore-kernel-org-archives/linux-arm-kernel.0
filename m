Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB8C2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D692E20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ah9XbBvv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7N7w54M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D692E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d50O9ZbxXiuTkVMDADRH87BeuNpWrfej460uUMZSbaw=; b=ah9XbBvvIIMevj
	4m2forTJBjWSltB8xVtCGwlYwLWv+f4jK+iCZwPt0hvHXMSWg0tH/vjZvrozDtuPN4/cDD7/PzCx9
	TCThlWs1e1jtTJWGbdVAOayQCB3gtbiKza0Q4FFLlcbvUzWMV8cQOWvpThUFNSI0KyaY/9GFmookT
	lnq3uw4o69GxsT8GLH2m4kdX5xTtshQYF7JDRms+QjFQ0hw7tUSpDnpyevE78QcdggIs9C8u4RwCV
	BUrhUqmGQ/v89Tj4svHdcOeREz5+Zg/yxfYM5hzUSN76+CXo8t/9lO/fBtAJq0RDelgrdDI/6xnkj
	qJ0X6aB3ru+MsuwT7VZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glaVl-0001FO-Ck; Mon, 21 Jan 2019 14:25:13 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glaVg-00015v-9M
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:25:11 +0000
Received: by mail-it1-x144.google.com with SMTP id m62so16565527ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/u94eUF5mgF2KHAxjyAftYpA3ypiVepGKgWhzr9h2W4=;
 b=e7N7w54MBAKV9DZq0MZ7LOLDV2AarARteFuPyCSQMy4juxp6Sp/YwZKQ9jMfam3QJ6
 /Yi8cFJWl3yBc65GwOy6HzxZwxnU2gVk+rs6hLIF1164xDzBwkk33wCUL8JYqSo17T7+
 iphonCyY82qrtMHsSEVHJgoLREb/Le/J+mjUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/u94eUF5mgF2KHAxjyAftYpA3ypiVepGKgWhzr9h2W4=;
 b=FTnJA3qKUxixOmWdrlhe66y7BBMvUAtvKvWZ1+E1RZtqBsGlrK3fhrVFbYAUrvS4gd
 zHCOnO4Cac8emXROjHZAuzG9pk0HuaASiOfplDVrP9zede6nIaVZKPZ+F9if/xPJh/51
 XTxWkap+SOALGVsayVhQsQNdM8YryIqRX05yHLY8WHwA7PSWPQUYFgj5nRV+Hbhseuj9
 y0g/tnCQ9dr7B4+nQK4IHXuoXHjRLLR6HTjuuvQXgJ6NgdCMduCcPZYUolyrRr+pNGHO
 jb4xwRG8jSkw4sNAuVm1+unikfgfi5TvJlXn9mcPepIr6JDAplV6u49iNumpBqT6QbLk
 6F2A==
X-Gm-Message-State: AJcUukeFmj9Hk1gCiw8tk2tSwO40Tyl/V6jMSLpbuctw9DPyNrP+tIeZ
 hONnypdskNC4ufAeW6ZDEIsNH3FliKSgVGS5H9yO2Q==
X-Google-Smtp-Source: ALg8bN4vZOqku531Dx/WHFBcJYrfl4tYJgZq6IRDEcLoS4fIkywiUCK2nNgSGC9K3c6YEnkly2mE1dy8Rg0hoIHQmCg=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr17498155itk.71.1548080706851; 
 Mon, 21 Jan 2019 06:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
 <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
In-Reply-To: <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 15:24:55 +0100
Message-ID: <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_062508_356112_9402715B 
X-CRM114-Status: GOOD (  24.93  )
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
 Tomasz Figa <tfiga@chromium.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 pratikp@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>
> >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> >>>> <ard.biesheuvel@linaro.org> wrote:
> >>>>>
> >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>>
> >>>>>> Qualcomm SoCs have an additional level of cache called as
> >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> >>>>>> before the DDR, and is tightly coupled with the memory controller.
> >>>>>> The clients using this cache request their slices from this
> >>>>>> system cache, make it active, and can then start using it.
> >>>>>> For these clients with smmu, to start using the system cache for
> >>>>>> buffers and, related page tables [1], memory attributes need to be
> >>>>>> set accordingly. This series add the required support.
> >>>>>>
> >>>>>
> >>>>> Does this actually improve performance on reads from a device? The
> >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> >>>>> the device, and I would expect the PoC to be defined as lying beyond
> >>>>> the LLC to still guarantee the architected behavior.
> >>>>
> >>>> We have seen performance improvements when running Manhattan
> >>>> GFXBench benchmarks.
> >>>>
> >>>
> >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> >>> to the device, not from the device.
> >>>
> >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> >>>> Last level cache (LLC) lies beyond the point of coherency.
> >>>> Non-cache coherent buffers will not be cached to system cache also, and
> >>>> no additional software cache maintenance ops are required for system cache.
> >>>> Pratik can add more if I am missing something.
> >>>>
> >>>> To take care of the memory attributes from DMA APIs side, we can add a
> >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> >>>>
> >>>
> >>> So does the device use the correct inner non-cacheable, outer
> >>> writeback cacheable attributes if the SMMU is in pass-through?
> >>>
> >>> We have been looking into another use case where the fact that the
> >>> SMMU overrides memory attributes is causing issues (WC mappings used
> >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> >>> existing attributes, would you still need the SMMU changes?
> >>
> >> Even if we could force a stage 2 mapping with the weakest pagetable
> >> attributes (such that combining would work), there would still need to
> >> be a way to set the TCR attributes appropriately if this behaviour is
> >> wanted for the SMMU's own table walks as well.
> >>
> >
> > Isn't that just a matter of implementing support for SMMUs that lack
> > the 'dma-coherent' attribute?
>
> Not quite - in general they need INC-ONC attributes in case there
> actually is something in the architectural outer-cacheable domain.

But is it a problem to use INC-ONC attributes for the SMMU PTW on this
chip? AIUI, the reason for the SMMU changes is to avoid the
performance hit of snooping, which is more expensive than cache
maintenance of SMMU page tables. So are you saying the by-VA cache
maintenance is not relayed to this system cache, resulting in page
table updates to be invisible to masters using INC-ONC attributes?

> The
> case of the outer cacheablility being not that but a hint to control
> non-CPU traffic through some not-quite-transparent cache behind the PoC
> definitely stays wrapped up in qcom-specific magic ;)
>

I'm not surprised ...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
