Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C6C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:58:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8F52184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rtq8y5Nm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HO3TH/bc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O9z6VRYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F52184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O0+18hynRi9d+kujUCdQaaMMVMQn73q/fbbGZ4Xgh1g=; b=Rtq8y5NmbCLtok
	FOTK/33xsxs1Qq+R3Tg07h8yXTjn4hAOv4RiXncy2ug8SUBTlsr7l4nbWu5qGrT0S0RnswesVZ+4T
	eDE+6KTWqGnqpvrJu05IYCfwcClw1kx/pBZsJz5WSAzMKYfi2RmQoJW3zHCVB68h820lnXuAFyElW
	wMxuRgZomnbNpLsHrN8HdXTzL2O6wdZVFmEApr4BICMCPpqKHXaNiJTI+rLjCnAFt4Y0E7hiHRskC
	tm5h6iJ8aWdVp4/JBLsiGtGac2a+IRO3AjKDlDDT1KEjE8V2i/0C3V2OpQNgDLQsbTZyQOUodpKS9
	8e31eklPR7Jlm0QUa51w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmYxz-0004DM-Mk; Thu, 24 Jan 2019 06:58:23 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmYxv-0004Cm-3g
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 06:58:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3B7C460795; Thu, 24 Jan 2019 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548313098;
 bh=njDRlprMxI0qLtIk0ZEqPrhYxG6uwkZe42WtrF39QV0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=HO3TH/bcP/JnsYvRvhbEm8/lEJ1ZqnUZXzGJGmjThIwACY6bd7eQx1z8GzYRihHgB
 LQFZywm9ZM8OPe/ZDjMyVfxDUeZnFrMv2T6patkWqESqlxQ1EeYcsdQciWQY1M9tyD
 OU7/0z7b3G4SYoJQ12ZHBb0mvXQrG0syo3uquSeM=
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DA8B56085C
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 06:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548313097;
 bh=njDRlprMxI0qLtIk0ZEqPrhYxG6uwkZe42WtrF39QV0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=O9z6VRYk9mxWxwwugE8ZwtNVR+zUJ0afRWwIRtDoyL16rsFp6leYt+YLH1FU86N+x
 kL+Ib1bv9xJflgsu39xGQMqYQXYKUZ8ouFcVaY3bKZpK4ONNkWLmezHX+TwGjJla8f
 qYpoiyH0ml6K0UR5fRappESj2/5Eb8yzNTxN/B7A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA8B56085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f43.google.com with SMTP id h15so3694440edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 22:58:16 -0800 (PST)
X-Gm-Message-State: AJcUukdX6T+aq0EWgMZrsztXav1kzO7XtqNc0olBoCYenu7ESuB4Vj9X
 okVnoD/fQDOcG6TtNiImUNog5hv2yW+EsQezs/Y=
X-Google-Smtp-Source: ALg8bN4Rngo8jKcGaqdsIFNBJAKiARrqQ8SFIAU1vP7LvvTsNtxDoXCQvQm/uxcLce0ZqySSV3i2tN1/FjIsEv93M3w=
X-Received: by 2002:a05:6402:3d1:: with SMTP id
 t17mr5651101edw.21.1548313095461; 
 Wed, 23 Jan 2019 22:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
 <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
 <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 24 Jan 2019 12:28:02 +0530
X-Gmail-Original-Message-ID: <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com>
Message-ID: <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_225819_242922_F3E47E1F 
X-CRM114-Status: GOOD (  32.92  )
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
Cc: Jordan Crouse <jcrouse@codeaurora.org>, pdaly@codeaurora.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 pratikp@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 7:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> > >>
> > >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>>>
> > >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> > >>>> <ard.biesheuvel@linaro.org> wrote:
> > >>>>>
> > >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >>>>>>
> > >>>>>> Qualcomm SoCs have an additional level of cache called as
> > >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> > >>>>>> before the DDR, and is tightly coupled with the memory controller.
> > >>>>>> The clients using this cache request their slices from this
> > >>>>>> system cache, make it active, and can then start using it.
> > >>>>>> For these clients with smmu, to start using the system cache for
> > >>>>>> buffers and, related page tables [1], memory attributes need to be
> > >>>>>> set accordingly. This series add the required support.
> > >>>>>>
> > >>>>>
> > >>>>> Does this actually improve performance on reads from a device? The
> > >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> > >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> > >>>>> the device, and I would expect the PoC to be defined as lying beyond
> > >>>>> the LLC to still guarantee the architected behavior.
> > >>>>
> > >>>> We have seen performance improvements when running Manhattan
> > >>>> GFXBench benchmarks.
> > >>>>
> > >>>
> > >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> > >>> to the device, not from the device.
> > >>>
> > >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> > >>>> Last level cache (LLC) lies beyond the point of coherency.
> > >>>> Non-cache coherent buffers will not be cached to system cache also, and
> > >>>> no additional software cache maintenance ops are required for system cache.
> > >>>> Pratik can add more if I am missing something.
> > >>>>
> > >>>> To take care of the memory attributes from DMA APIs side, we can add a
> > >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> > >>>>
> > >>>
> > >>> So does the device use the correct inner non-cacheable, outer
> > >>> writeback cacheable attributes if the SMMU is in pass-through?
> > >>>
> > >>> We have been looking into another use case where the fact that the
> > >>> SMMU overrides memory attributes is causing issues (WC mappings used
> > >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> > >>> existing attributes, would you still need the SMMU changes?
> > >>
> > >> Even if we could force a stage 2 mapping with the weakest pagetable
> > >> attributes (such that combining would work), there would still need to
> > >> be a way to set the TCR attributes appropriately if this behaviour is
> > >> wanted for the SMMU's own table walks as well.
> > >>
> > >
> > > Isn't that just a matter of implementing support for SMMUs that lack
> > > the 'dma-coherent' attribute?
> >
> > Not quite - in general they need INC-ONC attributes in case there
> > actually is something in the architectural outer-cacheable domain.
>
> But is it a problem to use INC-ONC attributes for the SMMU PTW on this
> chip? AIUI, the reason for the SMMU changes is to avoid the
> performance hit of snooping, which is more expensive than cache
> maintenance of SMMU page tables. So are you saying the by-VA cache
> maintenance is not relayed to this system cache, resulting in page
> table updates to be invisible to masters using INC-ONC attributes?

The reason for this SMMU changes is that the non-coherent devices
can't access the inner caches at all. But they have a way to allocate
and lookup in system cache.

CPU will by default make use of system cache when the inner-cacheable
and outer-cacheable memory attribute is set.

So for SMMU page tables to be visible to PTW,
-- For IO coherent clients, the CPU cache maintenance operations are not
required for buffers marked Normal Cached to achieve a coherent view of
memory. However, client-specific cache maintenance may still be
required for devices
with local caches (for example, compute DSP local L1 or L2).
-- For non-IO coherent clients, the CPU cache maintenance operations (cleans
and/or invalidates) are required at buffer handoff points for buffers marked as
Normal Cached in any CPU page table in order to observe the latest updates.


Regards
Vivek

>
> > The
> > case of the outer cacheablility being not that but a hint to control
> > non-CPU traffic through some not-quite-transparent cache behind the PoC
> > definitely stays wrapped up in qcom-specific magic ;)
> >
>
> I'm not surprised ...



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
