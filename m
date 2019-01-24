Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B02C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:55:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C93F218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BWhxHq2W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6Xw5HpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C93F218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wkooOmb/WfdvpqC2OQRUJena7jrawVe4mOutakc+mZg=; b=BWhxHq2WiM3lbv
	KqLvrAj8olVA30zCMxOSKyiNE+mOlQGROCNEqfYvvb2TFeVtSfz0BL6ebiELt6Za7gaE9Bxr+6zVr
	R+T82+HRgPolrw86g/deTH4uW7lN1WfDbFsTMMirq/MTg+81SHNWtXG5coGyC4Ou34DJye22p8pS6
	SKn4vqJkhwOh1STsHfgz/mdvqOhi3ph0bN4KjTYwnfA12A5lx4Y0Ai2nynsghG7C73mk8WrrXCcDh
	IVoz4aFykCXcFJeoFl7A60dr9TH6Uql+R3O+BmGl+v4xSQRleypyWvS+YCZPyJ9xcd3D0wY18a5EQ
	oX6eeFBNMz64bIHrjKUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmZqq-0005R4-Gt; Thu, 24 Jan 2019 07:55:04 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmZql-0005Iu-27
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 07:55:01 +0000
Received: by mail-io1-xd44.google.com with SMTP id b16so3951863ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MSRy2L2VB8tOcY4eKQIsHtwXcNw8n4XOfE0rYivSwIE=;
 b=T6Xw5HpO3iKQBDnzGCEZ5wu1ESraYm4kfWu37hpWhTiry1fL8CVViR0pLTd4O3Afaj
 TWNbl6t/UBOV+Np2D6zSSXR+sS6/1oIxBLr2z7R7rsByf+HfZNNu6gfWCZ90Zl/wZsuO
 QCUl1tYKAfvWXz6cSC31Mr8zspbEfrNcbkbzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MSRy2L2VB8tOcY4eKQIsHtwXcNw8n4XOfE0rYivSwIE=;
 b=E77CZ97FQ9ECUUQWwZcAt1IWq3y9II/JHpdWnYKlqr4kQI2yFlZxJo3unrfzpQx+qF
 iJxtTN/IOZUc0RThbeFladiTvQ7hYvmV2/3SKOqQXvtCPgfIdRu7UiWBdIVig4RCQvx/
 7nIJZnvX/3CkUgYW9El+BMcSs7aH3m9LHYkbiPpsXOJ3fawqTGiy+1JuXPiDkbepeZ/M
 eO+6q6GbB7Oyg6/B62OH8J4p5kLlMq+tPDtM0RBz8CdTpngBxbk1W0PstUbjvpADbC4n
 8tlBeDFYcYWIR1LgLl3iuYzqqvT9rqk08U2JlO51ilEUcWH9w5HBIPs80zRPUbnsWAPL
 Nj0g==
X-Gm-Message-State: AHQUAuZ+5DG1nLeAHOKIxiVd8f8Uy2l9TsaxI8oWFMTKfnXmU41AF3nc
 MVz9I6iWFE7FgmeOle8V6nhkDpKPRwfLa3PP34BeRQ==
X-Google-Smtp-Source: ALg8bN5mZP4e6d/6EwiZpGlghy9+wXsqM+ZeQm3G2pcOQrC+NGkyrjDi1kNGIkHB1GJfopNgrDLkFaL8SEyyCIfxsXM=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr3207708ion.173.1548316497633; 
 Wed, 23 Jan 2019 23:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
 <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
 <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
 <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com>
In-Reply-To: <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 08:54:46 +0100
Message-ID: <CAKv+Gu964=UOPcxh1ZZ4HEvJonrQ_d21t=GbVV9XwV3o91c6ng@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Vivek Gautam <vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_235459_146425_D16D746D 
X-CRM114-Status: GOOD (  36.12  )
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

On Thu, 24 Jan 2019 at 07:58, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> On Mon, Jan 21, 2019 at 7:55 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > > > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> > > >>
> > > >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > > >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > >>>>
> > > >>>> Hi,
> > > >>>>
> > > >>>>
> > > >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> > > >>>> <ard.biesheuvel@linaro.org> wrote:
> > > >>>>>
> > > >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > >>>>>>
> > > >>>>>> Qualcomm SoCs have an additional level of cache called as
> > > >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> > > >>>>>> before the DDR, and is tightly coupled with the memory controller.
> > > >>>>>> The clients using this cache request their slices from this
> > > >>>>>> system cache, make it active, and can then start using it.
> > > >>>>>> For these clients with smmu, to start using the system cache for
> > > >>>>>> buffers and, related page tables [1], memory attributes need to be
> > > >>>>>> set accordingly. This series add the required support.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Does this actually improve performance on reads from a device? The
> > > >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> > > >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> > > >>>>> the device, and I would expect the PoC to be defined as lying beyond
> > > >>>>> the LLC to still guarantee the architected behavior.
> > > >>>>
> > > >>>> We have seen performance improvements when running Manhattan
> > > >>>> GFXBench benchmarks.
> > > >>>>
> > > >>>
> > > >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> > > >>> to the device, not from the device.
> > > >>>
> > > >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> > > >>>> Last level cache (LLC) lies beyond the point of coherency.
> > > >>>> Non-cache coherent buffers will not be cached to system cache also, and
> > > >>>> no additional software cache maintenance ops are required for system cache.
> > > >>>> Pratik can add more if I am missing something.
> > > >>>>
> > > >>>> To take care of the memory attributes from DMA APIs side, we can add a
> > > >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> > > >>>>
> > > >>>
> > > >>> So does the device use the correct inner non-cacheable, outer
> > > >>> writeback cacheable attributes if the SMMU is in pass-through?
> > > >>>
> > > >>> We have been looking into another use case where the fact that the
> > > >>> SMMU overrides memory attributes is causing issues (WC mappings used
> > > >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> > > >>> existing attributes, would you still need the SMMU changes?
> > > >>
> > > >> Even if we could force a stage 2 mapping with the weakest pagetable
> > > >> attributes (such that combining would work), there would still need to
> > > >> be a way to set the TCR attributes appropriately if this behaviour is
> > > >> wanted for the SMMU's own table walks as well.
> > > >>
> > > >
> > > > Isn't that just a matter of implementing support for SMMUs that lack
> > > > the 'dma-coherent' attribute?
> > >
> > > Not quite - in general they need INC-ONC attributes in case there
> > > actually is something in the architectural outer-cacheable domain.
> >
> > But is it a problem to use INC-ONC attributes for the SMMU PTW on this
> > chip? AIUI, the reason for the SMMU changes is to avoid the
> > performance hit of snooping, which is more expensive than cache
> > maintenance of SMMU page tables. So are you saying the by-VA cache
> > maintenance is not relayed to this system cache, resulting in page
> > table updates to be invisible to masters using INC-ONC attributes?
>
> The reason for this SMMU changes is that the non-coherent devices
> can't access the inner caches at all. But they have a way to allocate
> and lookup in system cache.
>
> CPU will by default make use of system cache when the inner-cacheable
> and outer-cacheable memory attribute is set.
>
> So for SMMU page tables to be visible to PTW,
> -- For IO coherent clients, the CPU cache maintenance operations are not
> required for buffers marked Normal Cached to achieve a coherent view of
> memory. However, client-specific cache maintenance may still be
> required for devices
> with local caches (for example, compute DSP local L1 or L2).

Why would devices need to access the SMMU page tables?

> -- For non-IO coherent clients, the CPU cache maintenance operations (cleans
> and/or invalidates) are required at buffer handoff points for buffers marked as
> Normal Cached in any CPU page table in order to observe the latest updates.
>

Indeed, and this is what your non-coherent SMMU PTW requires, and what
you /should/ get when you omit the 'dma-coherent' property from its DT
node (and if you don't, it is a bug in the SMMU driver that should get
fixed)

The question is whether using inner-non-cached/outer-cacheable
attributes for the PTW is required for correctness, or whether it is
merely an optimization (since the point of this exercise was to avoid
snoop latency from the SMMU PTW). If it is an optimization, I would
like to understand whether the performance delta between SMMU page
tables in DRAM vs SMMU page tables in the LLC justifies these
intrusive changes to the SMMU driver.


> >
> > > The
> > > case of the outer cacheablility being not that but a hint to control
> > > non-CPU traffic through some not-quite-transparent cache behind the PoC
> > > definitely stays wrapped up in qcom-specific magic ;)
> > >
> >
> > I'm not surprised ...
>
>
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
