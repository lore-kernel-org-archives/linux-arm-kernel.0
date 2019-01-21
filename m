Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930FC2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AD72085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uqYUBN2y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArwJ8Lr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AD72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qk5Z+ePRg1LpkmszNm5mkpsrvm+q7DGiCpqngjCMhHA=; b=uqYUBN2yJyEo9k
	RQBLdAKbZhGpnxlGZ2JRJ9yKCndPWX6aJY4hwa3xDC5IKX06V5PeV0xiAN03zrSexe7CnPfFv9nhp
	t6ePTZTklcx8aqKVO/1oyQafGx9no3TKtc5r9ZQu6aDB0olrcehc8O+kc8cyLclvSl9CSovionBm9
	IZNdDNcFGRMR2bl6WK4z1L4pSRl5R2XSIGGaJKUKFsEY9ntkVUWS/YG3xt9kLGLQve8iCSgf7n7v5
	Ypu1zwLcmjkxxcwUPOhDNGL4mW8HRC2AWKVWufK3nVcJUsQvCDscCvWdnqlKMvO0HAM4+am5OIiiw
	K82tyoq0GH3SyekO9sYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZkW-0004Hl-6P; Mon, 21 Jan 2019 13:36:24 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZkS-0004HJ-2m
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:36:21 +0000
Received: by mail-it1-x143.google.com with SMTP id c9so15125058itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ouVfrYoE4tBo/aI/S/8fegEEIgNFev38fWx5MQf/VJM=;
 b=ArwJ8Lr5+Hg4clYMFji1qY6Vo2rofrnjVP0RHCXnIPk+vN/lZ1h84Xu3WmeVnunuTg
 bQpqIwVqgYFTWo4Yb1ZWpKYyN2Ifm4/cFTkOcm5qT4aL30RDYLeLAqp6+7sB9ucFvD2q
 XpZFUGGZ2BVDn8RjrRtpA4VoRdh3P1L/TQVC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ouVfrYoE4tBo/aI/S/8fegEEIgNFev38fWx5MQf/VJM=;
 b=ZhtFFWz85XGpDoDLsXusoOd7C2AWfnWCIhpbxNVfzYOW6HIo+J36XfXcpL2fGOXESv
 FobCNLjZ4pI8usn2MKSZBZwSiWxjDjqoMEa/sKDjxTquoZfVVBrc936VzsfwexJTFwMt
 cZ34zhQYlm1/zbaFbIFVq13UwBl61NMaxcTGSdwAwiNtlPYFWUaJqypUq8t06OERaBU9
 Ni/C/VFNqD3fGTG8tKq6mQrlTSpgGguW+2Xcp1AL+vtPtFexT5NStyT/hfZO0+PmSlzr
 qc4nILIlQEV1s1iDFXd1K82vaUVls+BUe2lMlwsntSklntIZEECzjzY8ylBeZWmW4DAb
 jDqA==
X-Gm-Message-State: AJcUukfRjwS6vwa+egY+p2lC+4xVXitN0uCbHnGH5mquI0yMPXnKwHRv
 tkGOthlTX1atCUtngj5uGNlyuxwv0ifI+rhDKKBeIQ==
X-Google-Smtp-Source: ALg8bN6Zg2VceQChmTEUHfR/ksvGIMgODGDM+Sdy4ePGOWyA3+sSUky68PBxxjfLquGDgip4RzLmQ9e76n7P0+tx5AI=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr17398985itk.71.1548077778941; 
 Mon, 21 Jan 2019 05:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
In-Reply-To: <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 14:36:07 +0100
Message-ID: <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_053620_118806_67C5745A 
X-CRM114-Status: GOOD (  21.20  )
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

On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>
> >> Hi,
> >>
> >>
> >> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>>
> >>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>
> >>>> Qualcomm SoCs have an additional level of cache called as
> >>>> System cache, aka. Last level cache (LLC). This cache sits right
> >>>> before the DDR, and is tightly coupled with the memory controller.
> >>>> The clients using this cache request their slices from this
> >>>> system cache, make it active, and can then start using it.
> >>>> For these clients with smmu, to start using the system cache for
> >>>> buffers and, related page tables [1], memory attributes need to be
> >>>> set accordingly. This series add the required support.
> >>>>
> >>>
> >>> Does this actually improve performance on reads from a device? The
> >>> non-cache coherent DMA routines perform an unconditional D-cache
> >>> invalidate by VA to the PoC before reading from the buffers filled by
> >>> the device, and I would expect the PoC to be defined as lying beyond
> >>> the LLC to still guarantee the architected behavior.
> >>
> >> We have seen performance improvements when running Manhattan
> >> GFXBench benchmarks.
> >>
> >
> > Ah ok, that makes sense, since in that case, the data flow is mostly
> > to the device, not from the device.
> >
> >> As for the PoC, from my knowledge on sdm845 the system cache, aka
> >> Last level cache (LLC) lies beyond the point of coherency.
> >> Non-cache coherent buffers will not be cached to system cache also, and
> >> no additional software cache maintenance ops are required for system cache.
> >> Pratik can add more if I am missing something.
> >>
> >> To take care of the memory attributes from DMA APIs side, we can add a
> >> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> >>
> >
> > So does the device use the correct inner non-cacheable, outer
> > writeback cacheable attributes if the SMMU is in pass-through?
> >
> > We have been looking into another use case where the fact that the
> > SMMU overrides memory attributes is causing issues (WC mappings used
> > by the radeon and amdgpu driver). So if the SMMU would honour the
> > existing attributes, would you still need the SMMU changes?
>
> Even if we could force a stage 2 mapping with the weakest pagetable
> attributes (such that combining would work), there would still need to
> be a way to set the TCR attributes appropriately if this behaviour is
> wanted for the SMMU's own table walks as well.
>

Isn't that just a matter of implementing support for SMMUs that lack
the 'dma-coherent' attribute?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
