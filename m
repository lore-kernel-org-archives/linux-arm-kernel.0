Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6875BC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398F320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JaV44o3v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W74LD6fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398F320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tjYPPvghJStnVTODajO93NJkkFRxofDLKpX/vTCRKfg=; b=JaV44o3vZNiRpI
	OOXTEPB3tCew5F+USWO9ayWbgI0/hfC+NkhQjgToCLDiMsm7RfFfsXVBm/U4t3AwDGr6DB6S1qOze
	dJKo0ANpOhoAz9M5X1qvCO0287UbDuNaYAlaVXkQq8CRWHYWGAxB/yjR4CMGQGSTHxuhfhDKGNeuZ
	aSvNvII3xjtc3vqNgOMxRDb3yZ9seqH1eBtzx8k63+vdKSXqmjKeCRkNED++aJegHeKPaoZHXa8Fq
	5YtGOisInsfwn4peVgyydFJ0ISzO6K8YNtpk+7l/hVxNiFHWbi6ERKXarf4OTtaHtBSfUgkiGHM5O
	BoRTGrYgct5igA7y3Oag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXAb-0004Aw-92; Mon, 21 Jan 2019 10:51:09 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXAX-0004AZ-0d
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:51:06 +0000
Received: by mail-it1-x141.google.com with SMTP id h65so14515683ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kZG6s3eS8O+Mar/3L/gvujTkcPoy9mBP6SvWrZ1AAL0=;
 b=W74LD6faC9UTZ4Cci0rtns3bNle+1yA0bGh6FjsWHbGWci2K3pngKAuBKOil0nZl9u
 dMuoXpjCxhXJ9H8AnlnSEHcYKz2+W2tibHMM2VLs2K1PNdmISh6Wp277/DGnkkpqWfZm
 vzAVqEf8LsS0EwA/ev0IUYWg/3KgTAHlGXjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZG6s3eS8O+Mar/3L/gvujTkcPoy9mBP6SvWrZ1AAL0=;
 b=FO0A3q5Ql4lSChpEAcGt932syzEMsvHDfuNToAUJSRLMUHq28JbJMg2fFObokc/zjP
 60tg+of8JHZ83VNzE/xl3GWYOYHUvVYahd4rdZy5mxeLM6g4wf3Z3j5jBFLlbX7YBHvA
 9egjn+zdPR7lqoHqrLEg261Qutpu5ICgdoD9yARVHuWmJOrnnD+0eVMg7QH+EcBFxjQm
 rYalQFPMCqYehWLWtGm9np5VnxHeeV4COC0T+t7ir3VedxsI5OhRvcjQ1EHFK5fvrF7X
 wYGU8I212Qiz/aXqttUO5gpQ814jxCbVy6Uc7pjtUDqM+UcHrrS7nM6k/4dFr2O/9wdi
 VkGw==
X-Gm-Message-State: AJcUuke8NvCE25OsG0TxLHj95bh+fmWMDUzoqKU/wSKAgkOgThhxA7kU
 +1xslAy5QQkhJKyS0rkF8vr1t+oHsb09hmOZqYg3yg==
X-Google-Smtp-Source: ALg8bN5VOKAIyrSyYaD13M+6+CenuhEJ88Ty8sGuuVyVWt1mjlvT4P/C5SXAIIvgWt9I+WIZmSgF3tY1aLpWQuZ/IyM=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr18369678ith.158.1548067864287; 
 Mon, 21 Jan 2019 02:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
In-Reply-To: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 11:50:53 +0100
Message-ID: <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To: Vivek Gautam <vivek.gautam@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_025105_071708_AD22F12C 
X-CRM114-Status: GOOD (  18.37  )
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

On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi,
>
>
> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >
> > > Qualcomm SoCs have an additional level of cache called as
> > > System cache, aka. Last level cache (LLC). This cache sits right
> > > before the DDR, and is tightly coupled with the memory controller.
> > > The clients using this cache request their slices from this
> > > system cache, make it active, and can then start using it.
> > > For these clients with smmu, to start using the system cache for
> > > buffers and, related page tables [1], memory attributes need to be
> > > set accordingly. This series add the required support.
> > >
> >
> > Does this actually improve performance on reads from a device? The
> > non-cache coherent DMA routines perform an unconditional D-cache
> > invalidate by VA to the PoC before reading from the buffers filled by
> > the device, and I would expect the PoC to be defined as lying beyond
> > the LLC to still guarantee the architected behavior.
>
> We have seen performance improvements when running Manhattan
> GFXBench benchmarks.
>

Ah ok, that makes sense, since in that case, the data flow is mostly
to the device, not from the device.

> As for the PoC, from my knowledge on sdm845 the system cache, aka
> Last level cache (LLC) lies beyond the point of coherency.
> Non-cache coherent buffers will not be cached to system cache also, and
> no additional software cache maintenance ops are required for system cache.
> Pratik can add more if I am missing something.
>
> To take care of the memory attributes from DMA APIs side, we can add a
> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
>

So does the device use the correct inner non-cacheable, outer
writeback cacheable attributes if the SMMU is in pass-through?

We have been looking into another use case where the fact that the
SMMU overrides memory attributes is causing issues (WC mappings used
by the radeon and amdgpu driver). So if the SMMU would honour the
existing attributes, would you still need the SMMU changes?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
