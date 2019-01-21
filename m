Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C0C41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300CB2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rkOgfcnW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U44LmsnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300CB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i7q2nAsGndhpcfuQZDL9rb+MLyZDmePB8oCIh6kuuW4=; b=rkOgfcnWyvnzZ1
	3PYrSfaoXUeubW0GsykxV4nLjNOyvDMX4ysGGDn0IpuPhObNWIKU/6aDXgHuE+43gUZ4FJgzOTlbg
	ollJaK6WiL+awGalF35SALk0OcMbPN9gbyPaafcbqBsmUGPCiygEc1OJVy9zNghxyJH5DD6WYkWzE
	rWWnmwRv2lsNPj9wyHaWzTy9QqTmooIut951eLfrbvvJWSTO+HISqorUlx/rKcenv8vIJ1/qohpc3
	IgYX70XJPibaR1JB1Tfn4BSpRlZQKoWP3ZR/tGxdGlAX/PprhGrHVzWahYvcetWbcQs1ElN1SIqnF
	yOYMgON9jkpcHf34Hb+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTyO-0004kh-SI; Mon, 21 Jan 2019 07:26:20 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTyL-0004kB-1W
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:26:19 +0000
Received: by mail-it1-x144.google.com with SMTP id x124so6423765itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ajYMFC2reghOmzcthv0vHrytNzOAbc6ti5YAojE+CZM=;
 b=U44LmsnC/9sS1fBgJPAdNPCuCUDcsd3tgK4roX5+ENPyA8ZkQf02E40wJJWNxe4xoM
 NkDPOIPlBKjLgWJc41d/3Grx7wkY+qpMgQEC5cjXn0EA3bYE06pGlYLLRHwkWlK8E1P2
 iPnD+AU0lgplUJtxXnQKuD4tWXPPAcLuXVqeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ajYMFC2reghOmzcthv0vHrytNzOAbc6ti5YAojE+CZM=;
 b=I0RbKglUEQSvGqnFMSXvXA3m7u5RBJmtkAy8Xb9duYBi/RjyxPNN+5+ghLQPrH4tnM
 JkHyXnBEAgH9yJjouPw2fg1IB6zldAYFC2Cckzlm5+niBIXzZveHRGiYHDx5re+4+VcE
 npLBN8LJO8+M598eh4dYmgs3fcQJNOS7qlJh9x/vdK+LTKB4VBaouajfV3/z6j4GzEh2
 DyBOLq3MFISy0q+6kGiVxGP2TKHG+EfJycLnWQ20OFpX5Vp+5WL0iuW5goCFoSnpB2H1
 /7n4It2J3dIVuTS3Lwuc3MIoh1zHQ9QufhHWhPBD9huAGCK/iBu2xNcMc7dCrZb/gKIH
 QurQ==
X-Gm-Message-State: AJcUukcIYgAMP6OJ5+IIZzecVa/3ZEyWMyGHbWijE6+nM7+8qoBgfVLz
 kudOUm63k2BklX26VrGZ0TXVl7PYuzM4wi+DY0XEzQ==
X-Google-Smtp-Source: ALg8bN5fYHgYbrTBUaHBE6nY3/l1o8uC2r8ga7peqyyblIzHnRu5CCCUAfGtJ6cwlzbXeF3smuZ7abuw90az88epf3U=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr16576843jab.2.1548055574176;
 Sun, 20 Jan 2019 23:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 08:26:02 +0100
Message-ID: <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Vivek Gautam <vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_232617_321726_5149B0A9 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: jcrouse@codeaurora.org, pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 pratikp@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Qualcomm SoCs have an additional level of cache called as
> System cache, aka. Last level cache (LLC). This cache sits right
> before the DDR, and is tightly coupled with the memory controller.
> The clients using this cache request their slices from this
> system cache, make it active, and can then start using it.
> For these clients with smmu, to start using the system cache for
> buffers and, related page tables [1], memory attributes need to be
> set accordingly. This series add the required support.
>

Does this actually improve performance on reads from a device? The
non-cache coherent DMA routines perform an unconditional D-cache
invalidate by VA to the PoC before reading from the buffers filled by
the device, and I would expect the PoC to be defined as lying beyond
the LLC to still guarantee the architected behavior.



> This change is a realisation of following changes from downstream msm-4.9:
> iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
>
> Changes since v2:
>  - Split the patches into io-pgtable-arm driver and arm-smmu driver.
>  - Converted smmu domain attributes to a bitmap, so multiple attributes
>    can be managed easily.
>  - With addition of non-coherent page table mapping support [4], this
>    patch series now aligns with the understanding of upgrading the
>    non-coherent devices to use some level of outer cache.
>  - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
>  - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
>    stage-1 mapping.
>  - Added change to disable the attribute from arm_smmu_domain_set_attr()
>    when needed.
>  - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
>    level.
>
> Goes on top of the non-coherent page tables support patch series [4]
>
> [1] https://patchwork.kernel.org/patch/10302791/
> [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> [4] https://lore.kernel.org/patchwork/cover/1032938/
>
> Vivek Gautam (3):
>   iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
>   iommu/io-pgtable-arm: Add support to use system cache
>   iommu/arm-smmu: Add support to use system cache
>
>  drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
>  drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
>  drivers/iommu/io-pgtable.h     |  4 ++++
>  include/linux/iommu.h          |  2 ++
>  4 files changed, 43 insertions(+), 6 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
