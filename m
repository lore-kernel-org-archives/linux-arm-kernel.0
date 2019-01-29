Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E4C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:43:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726E02148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXX8e8Dd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C+nCPt/l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KXjhPqYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726E02148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kqKUKxDTSPv3mYuFmk+6jNzjU6Tkn5QI/otVFIZ20YQ=; b=bXX8e8DdYP2KVj
	gUvd7vICDp5P6qJgmJGKntixNEWgi9YO7s0Xldg4FZx/NNocPiShkiqTzmX8QQ6kXWtS1v0xPbLWU
	+njfFY+u2B59lvD3Cc1FEojDfIFONMDftOCSc/VdS823u4eOQ0gt3V6NCfrVAbUxHHjAXX389qcfs
	BzfTSVqTSyfJOGsbLel4G/JU+pEWYmKawyQ79XmEvzewi1y9uoVHj++lh6SMxRimzAlHF0ObYLtGH
	YsXjauBaaFOS/kgXGts8svvpg5oYcCiCD6H0D2yZKC1aeo3kMQ+5x8NxVZkKreWaDyzv+Vm0k7TVI
	qw8RG/BjcgyFRHTbfA+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQrb-0001Kg-Qb; Tue, 29 Jan 2019 10:43:31 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQrX-0001K0-41
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:43:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7D53B60850; Tue, 29 Jan 2019 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548758606;
 bh=b8SkCNRhjNOfUi0XfdquRN5VpBwkG9P4jLXAjsvZQdQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=C+nCPt/lF+oxnenPcKCFA5OZAp4MhujiewCbiXiq45IAmoveM+T2Qfj6DJXywNIyc
 ks6DYG4wSrgRiADLjRbIZRElnLeN5jXRlSLLzjvYsnG4GLazNPRCvegzzSWx7tJA5c
 KlJXxU4lDUJuKl2WUyaxGsr+Mc0Z4H5JUyfUIv7E=
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D1FA609D1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548758605;
 bh=b8SkCNRhjNOfUi0XfdquRN5VpBwkG9P4jLXAjsvZQdQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KXjhPqYbcmmPih5E5qJpApgRkwMj/jHrkpaTUTqTgQsXD8mMWLDAMeZ5Li1WWXG2V
 NFebdVUSMVeSKcQglGyAOYpR3gkOI46YRGJHfGTP8KKjuxi9CVeeno15UA1SexdY98
 g6lkef0tX/E/IkoSxbNvuHg94hKSPziV/QKzE4hQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D1FA609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f51.google.com with SMTP id d39so15538324edb.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 02:43:25 -0800 (PST)
X-Gm-Message-State: AJcUukekyAeKmWD/6yggtv9XI1bbM6rKgEKZDVIX5IF4XMwGlw5Xjn7a
 +aYvmrORZq3FPAcprhau/0jt/HgXZb8c+8aA5F8=
X-Google-Smtp-Source: ALg8bN4wRRQQdDYNNzhSv9KBKIAwkqmbUvcI5Sz6uW5VBaUr5b2J+z2xBius0AjqsCH1Rj0DiXBmii/VvjNGJg/6EoM=
X-Received: by 2002:a17:906:452:: with SMTP id
 e18mr11493850eja.142.1548758604052; 
 Tue, 29 Jan 2019 02:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
 <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
 <20190122054326.GA6445@brain-police>
In-Reply-To: <20190122054326.GA6445@brain-police>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 29 Jan 2019 16:13:12 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHJ_Ctjh8-y8p4KWGrCVHE+1uv3KX2-rfKkt1uqb0YqHA@mail.gmail.com>
Message-ID: <CAFp+6iHJ_Ctjh8-y8p4KWGrCVHE+1uv3KX2-rfKkt1uqb0YqHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_024327_220335_78694B09 
X-CRM114-Status: GOOD (  24.06  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Tue, Jan 22, 2019 at 11:14 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> > On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > > Adding a device tree option for arm smmu to enable non-cacheable
> > > > memory for page tables.
> > > > We already enable a smmu feature for coherent walk based on
> > > > whether the smmu device is dma-coherent or not. Have an option
> > > > to enable non-cacheable page table memory to force set it for
> > > > particular smmu devices.
> > >
> > > Hmm, I must be missing something here. What is the difference between this
> > > new property, and simply omitting dma-coherent on the SMMU?
> >
> > So, this is what I understood from the email thread for Last level
> > cache support -
> > Robin pointed to the fact that we may need to add support for setting
> > non-cacheable
> > mappings in the TCR.
> > Currently, we don't do that for SMMUs that omit dma-coherent.
> > We rely on the interconnect to handle the configuration set in TCR,
> > and let interconnect
> > ignore the cacheability if it can't support.
>
> I think that's a bug. With that fixed, can you get what you want by omitting
> "dma-coherent"?

Based on the discussion on the first patch in this series [1], I can
update the series.
First thing can be -
if QUIRK_NO_DMA is set (i.e. the IOMMU _is_ coherent) then we use a
cacheable TCR;
So, we may need an additional check for this when setting the TCR.

For the second case -
IOMMUs that are *not* coherent, i.e ones that are omitting
'dma-coherent' property,
anyways have to access the page table directly from memory. We take
care of the CPU
side of this by allocating non-coherent memory, and making sure that we sync the
PTEs from map call.
Shouldn't we mark TCR for these IOMMUs as non-cacheable for inner and outer
cacheability attribute?


[1] https://lore.kernel.org/patchwork/patch/1032939/

Regards
Vivek

>
> Will



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
