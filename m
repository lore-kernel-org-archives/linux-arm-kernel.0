Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DF52147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hk0V3L0B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4cMTBsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DF52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vP0cPy4zFD02p/vjHyrbGVSUFG2SPUKisp1h4UNV0D0=; b=Hk0V3L0BjA46yL
	UTh+38AzWxhCndT89OqnNFmq9UT0XWy7F/Mhaf1u6dufyDvEs7GyVeWL2InudttxftPtfqF9M1Aq4
	YpKmOT8VUKISNGs5SQTzI5NdvA+i8sYBsZHxxLhcbr5uSZsXyseODw6rZur1ix0MrS84ra1V46Ejj
	zjhkDT0wd3ixzd5jOumXvIfYWio4YGxHjkl4hhBV6Bvz5MwRZOCiLUkXnjMBzRSmCykWLbw++UUtN
	AyX7VbzCnMtplJEfuXOQf0b9rneUCRgBPbbByJp5iWXxiDLIHr3H0OSO4VgCuD2lWb5S5oWMh3J4w
	JIcdL4cT9D8PDxE862qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwEqG-0004Lq-4G; Tue, 19 Feb 2019 23:30:24 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEqD-0004L5-DA
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:30:22 +0000
Received: by mail-lf1-x12c.google.com with SMTP id l10so16116996lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C3HpskIZHOlSnWS6IdFryCO/r0xlCFW+NgKCY956cuE=;
 b=h4cMTBsCf3wBIE7mkGV6oYFDz0+/pP42StFGmSeLSMCqqHPwEZnuyA2CVuW+/bwsrp
 MpeaZnKFbrD9EYr9iQMGHEi3tpHLy73PXBiabsnZSjHqmEPZA2gDQgyuyq1iwvDjdv3E
 zavMKQdN2MiCp+yAMOkXeQdPXdQ8w1VfMWB48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C3HpskIZHOlSnWS6IdFryCO/r0xlCFW+NgKCY956cuE=;
 b=jifd6XN1o89N4BPrL2XgkfrGstYoRKKB8oeIP4gMIYy1mjxyzzS5IldhnGgjiE33IT
 jpVqnIP2HYDo/l+Y0mXCOEKmB43AgLaJrCl1D3wqCd/fTOFlX3298V97EsMAWu3Tj4g5
 LO1qidALm0UlVLBW2q/XC39W+MQCougRu5bumEts8TXHGJL5lXbkP7/cOHuwMpp4DeJn
 D26Ha9+e4exeff9L7UDT/cPFRBnNc4Isgeqa7SFEQ5/eA1r8IGqQaW2AJh/5pTgS6sb0
 LkpuUjTjmQxfeRczxaqf+JRpefv697bYRYQxDVixz5qlPj6X6xr+SUr6AtNn1VsXDWAE
 XQ0w==
X-Gm-Message-State: AHQUAuYDfBRMm2zOOUmxxNMxJTG9GQgni+D0tECuTbXqzUJ1a9Gti6q0
 nH/pPpcwE7NIx9CZqSvKRfFjfPiAX4Q=
X-Google-Smtp-Source: AHgI3IbZpRJa3lGg4gAYnqNSTjsDTO9VIxOlxG2gx+fWj0OJHmNpm8Df0QMU/gHGW0ANbWlTN1QyfA==
X-Received: by 2002:a19:cf4f:: with SMTP id f76mr18345068lfg.125.1550619019196; 
 Tue, 19 Feb 2019 15:30:19 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id e26-v6sm3840695ljl.73.2019.02.19.15.30.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:30:18 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id n15so16142841lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:30:18 -0800 (PST)
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr13049011lfc.104.1550619018042; 
 Tue, 19 Feb 2019 15:30:18 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-7-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-7-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:29:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft5vUoxNgYfGEQ_KVQ7OfJxXG3R_jv6nbiNdM86uVHJ4fQ@mail.gmail.com>
Message-ID: <CAE=gft5vUoxNgYfGEQ_KVQ7OfJxXG3R_jv6nbiNdM86uVHJ4fQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/22] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153021_448857_84D01310 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:07 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek extend the arm v7s descriptor to support the dram over 4GB.
>
> In the mt2712 and mt8173, it's called "4GB mode", the physical address
> is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> bit32 is always enabled. thus, in the M4U, we always enable the bit9
> for all PTEs which means to enable bit32 of physical address.
>
> but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> 32bits.
>
> In order to unify code, in the "4GB mode", we add the bit32 for the
> physical address manually in our driver.
>
> Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> has to been moved into v7s.
>
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't. thus keep it as is.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> Comparing the previous version, I add MTK_4GB quirk always since mtk_iommu
> has already controlled the PA itself. Helped from Evan.

Thanks for all the explanation on this one. I think I understand it
now, and it looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
