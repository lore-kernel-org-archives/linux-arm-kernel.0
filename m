Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67ACC31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F41217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 06:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fl85tYYi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eH+5DAAZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nCus+WXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F41217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdhXQ/mMteJOo84CONdpu9LaNWghFEW/7mAFf0GQ5Oc=; b=Fl85tYYisxBHO2
	eCuuuaadfrePM5ScfaTQkwnv3g2OfxmZvgbN1lz8S33p0RA/d+V4X5Th0NsKXu+5LbdAWhLdMjevC
	1+AoUnlN6wXg+X/CxQV+lH0T7bYfY31cCt+yEfjw8GMVr8AdCiVXRjdmouqGZseYbsHkw1OhC2CUM
	LhFp5spShwpkrpYZSxmjIIIopWc9x1s1/Li5D4FuaL3VuvkdFvmY7JRoWsnLRMPaCb9Q02jzuFueB
	xxxCCX81h8FHCxkZY/mATJ719ipauycuZdIB7mA8IpaAcEf+h8JEGnl3T3BN/zeF60XDnc4h4hAea
	RLI0Wdcy6HKQOeWST9YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glSiS-0006or-5v; Mon, 21 Jan 2019 06:05:48 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glSiO-0006oW-PF
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 06:05:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 5FC426085C; Mon, 21 Jan 2019 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050744;
 bh=Y1F7ZjV/FsFNJuYd4G9AXKgIC9hZcdkYWSwP8ggf6OM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eH+5DAAZa80tNpDhIJ3O21BXzbQJOc9B2oMUBHQY/OWVO58ph2En4p7dwJzGn7bEJ
 t2YiieGxpdGKwisBehn8go0wzSOEuZH59BWZwCjBg/hLA8eXbESr1N8PI/JEND8KtR
 +zXRe1DfaGPVjuaad23/9yP3y7z8zR3UDmweXsB0=
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CD1F6086B
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548050743;
 bh=Y1F7ZjV/FsFNJuYd4G9AXKgIC9hZcdkYWSwP8ggf6OM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nCus+WXg4sXwWN/Xeb7jzLA9onnM5nP/4M4GXsSk6O+xtqSYUgWA3dauiwEo5JyN1
 xXv52V2epWfJbTdOe6MJk1ShzC3Fk4ztNehq46w1+UZxiVYbQk7CxI3aCYm/r3azsf
 nX4rJuEW0XGNoW78gvegkb64VxEgHtx/nXlQOKww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CD1F6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f44.google.com with SMTP id y56so15579016edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 22:05:43 -0800 (PST)
X-Gm-Message-State: AJcUukfp5cPkGP+xaSOJaYW0l7EkYRnxYGiO5Po9dohDRBW8nAqYsjfk
 JcfId0055/ad+3eeOPc97gcWaTjMMe2HyS4ih1c=
X-Google-Smtp-Source: ALg8bN7LNUtLnTrd7kArGVwS+vwLRfDV4avJP1pnXk0N11jxNBQaviTjHq1g9w/OE8hG5oKE5XuhkpO37dZUbxs8XdE=
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr25116444edp.173.1548050741904; 
 Sun, 20 Jan 2019 22:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
 <20190120000117.GH26876@brain-police>
In-Reply-To: <20190120000117.GH26876@brain-police>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 21 Jan 2019 11:35:30 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
Message-ID: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_220544_860504_1476D2B4 
X-CRM114-Status: GOOD (  17.86  )
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


On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > Adding a device tree option for arm smmu to enable non-cacheable
> > memory for page tables.
> > We already enable a smmu feature for coherent walk based on
> > whether the smmu device is dma-coherent or not. Have an option
> > to enable non-cacheable page table memory to force set it for
> > particular smmu devices.
>
> Hmm, I must be missing something here. What is the difference between this
> new property, and simply omitting dma-coherent on the SMMU?

So, this is what I understood from the email thread for Last level
cache support -
Robin pointed to the fact that we may need to add support for setting
non-cacheable
mappings in the TCR.
Currently, we don't do that for SMMUs that omit dma-coherent.
We rely on the interconnect to handle the configuration set in TCR,
and let interconnect
ignore the cacheability if it can't support.

Moreover, Robin suggested that we should take care of SMMUs, for which
removing snoop latency on walks by making mappings as non-cacheable
outweighs the cost of cache maintenance on PTE updates.

So, this change adds another property to do this non-cacheable mappings
explicitly. As I pointed, omitting 'dma-coherent', and corresponding
IO_PGTABLE_QUIRK_NO_DMA' does takes care of few things.

Should we handle the TCR settings too with this quirk?

Regards
Vivek
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
