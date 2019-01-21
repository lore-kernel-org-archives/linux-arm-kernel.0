Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C2C282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:17:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3752085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ja0XiX7+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIjJ6pxo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MKtPIAZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3752085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u5sRqk4RjtMU8UZ+a1yodi44q07gigFpqPUVzXQ1sqo=; b=Ja0XiX7+YrVVBw
	l5LyZJcYi/dXYkjGY3fdc3hmoURuCcKoIQD+0L/yqdIqAoFot1Ghc9U/bls5rAiUywTnYN82arTFX
	zU0ac4tsSy5EN756O31JXsfjglbD1VAG0gKAvD/IAuVfd1iWeI+hYT+sRQ5/PZcwRWMIPZiihrEuI
	FXYT+255/1bd25CLy+5Zl5vemD2OTkSFXGYW1jm+gdzqybDRKVpIk20b3OOPwsReNegjOuka+zdQ+
	ONcLcDTqu1oWDZVZ2bPRozKBQ0NpKVQNtTTu/OxyB+FOywF2NEmr4ADDfPZAdcoO4bvmJr+xw5TLk
	2ZkeuhBb0B41v24Ium0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWe6-00040P-OQ; Mon, 21 Jan 2019 10:17:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWe3-000405-Lo
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:17:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0F1506087B; Mon, 21 Jan 2019 10:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548065851;
 bh=8LIht97H1AgIOgZUi4NvRsOkdsUaK0MY0BQfKfBJ3PM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aIjJ6pxosNo97S3NQYePgftR21HrydbpuRH9YSi5q4CmjYQEsUlWCe2IWd5aVlE7f
 xymyzl57ca5SGgGEaTsgjNoaOEnjBb2gVJ8qul1svTYGIFqH6pSnpnLMAVOC7OHWG2
 5KTyvWfeLwe4zlYAdNX+Rbi1MzmGGYTtiW+fBOTU=
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 364296024C
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548065850;
 bh=8LIht97H1AgIOgZUi4NvRsOkdsUaK0MY0BQfKfBJ3PM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MKtPIAZcdaik5jMzzI2dkY/eXAJsYiKTHHmk4BZSt5ES85NSRSNyQegPkWx+kaeZ2
 owZUq+B4frFLPCRlWKseXwO5kVA5Wg+nQos5ZQoXhMVml3W8luGMLQJPt4KJnTMYm4
 NpkRD2vCKb2BZvRhUkWiznBxnbRnmC6yPT+T0XdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 364296024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f49.google.com with SMTP id x30so16154280edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 02:17:30 -0800 (PST)
X-Gm-Message-State: AJcUukeQ4VZQ1KRzj8PeBz9KzmEZwaZWHgplmfRgWjrNFwGHTdJwoOt+
 yzcUZTG+MoE5DxfXjk0vH3ZAbAuhPQlzPlmiJe4=
X-Google-Smtp-Source: ALg8bN5bgnBUvp7KNeLdx419CF5OcZUCrV68jGUPzczNnqeykMwOedhNTX8LnTt4d/1y6T0/5H5u1VS5a+F7UxZsDkA=
X-Received: by 2002:a17:906:4e14:: with SMTP id
 z20-v6mr23716988eju.187.1548065848901; 
 Mon, 21 Jan 2019 02:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 21 Jan 2019 15:47:17 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
Message-ID: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_021731_766065_90315F22 
X-CRM114-Status: GOOD (  28.45  )
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
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 pratikp@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,


On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >
> > Qualcomm SoCs have an additional level of cache called as
> > System cache, aka. Last level cache (LLC). This cache sits right
> > before the DDR, and is tightly coupled with the memory controller.
> > The clients using this cache request their slices from this
> > system cache, make it active, and can then start using it.
> > For these clients with smmu, to start using the system cache for
> > buffers and, related page tables [1], memory attributes need to be
> > set accordingly. This series add the required support.
> >
>
> Does this actually improve performance on reads from a device? The
> non-cache coherent DMA routines perform an unconditional D-cache
> invalidate by VA to the PoC before reading from the buffers filled by
> the device, and I would expect the PoC to be defined as lying beyond
> the LLC to still guarantee the architected behavior.

We have seen performance improvements when running Manhattan
GFXBench benchmarks.

As for the PoC, from my knowledge on sdm845 the system cache, aka
Last level cache (LLC) lies beyond the point of coherency.
Non-cache coherent buffers will not be cached to system cache also, and
no additional software cache maintenance ops are required for system cache.
Pratik can add more if I am missing something.

To take care of the memory attributes from DMA APIs side, we can add a
DMA_ATTR definition to take care of any dma non-coherent APIs calls.

Regards
Vivek
>
>
>
> > This change is a realisation of following changes from downstream msm-4.9:
> > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
> >
> > Changes since v2:
> >  - Split the patches into io-pgtable-arm driver and arm-smmu driver.
> >  - Converted smmu domain attributes to a bitmap, so multiple attributes
> >    can be managed easily.
> >  - With addition of non-coherent page table mapping support [4], this
> >    patch series now aligns with the understanding of upgrading the
> >    non-coherent devices to use some level of outer cache.
> >  - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
> >  - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
> >    stage-1 mapping.
> >  - Added change to disable the attribute from arm_smmu_domain_set_attr()
> >    when needed.
> >  - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
> >    level.
> >
> > Goes on top of the non-coherent page tables support patch series [4]
> >
> > [1] https://patchwork.kernel.org/patch/10302791/
> > [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> > [4] https://lore.kernel.org/patchwork/cover/1032938/
> >
> > Vivek Gautam (3):
> >   iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
> >   iommu/io-pgtable-arm: Add support to use system cache
> >   iommu/arm-smmu: Add support to use system cache
> >
> >  drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
> >  drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
> >  drivers/iommu/io-pgtable.h     |  4 ++++
> >  include/linux/iommu.h          |  2 ++
> >  4 files changed, 43 insertions(+), 6 deletions(-)
> >
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
