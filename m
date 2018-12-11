Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468C9C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AA82082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eju7eK2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VmAP8VTlAqlAmiO1fj+Hj8oN1dzogb5kCYfilYBamfk=; b=eju7eK2hAYOmKR
	d36RBh1MCSnoLXhYk/TQmexiBstP3BsuWY10Lt4LCG7M9jFwwyse0/Yt9hs4M6VvpDPbU3ZUs1tN7
	10ms9dvj3ceJfYLc2oJjWl1ZB+1y3CX/UaFktFSxr6duIFKoL0zMVJx7ykvzFTrY1Z1AscI2/Rg9P
	60DK1YEbx2J5XUp7EeCIHGi3hNmTeJdOUnBS4ruvxf2/truX6Y1CqJ+R+zo7XlIr7nmAQiYMkqtvD
	E2FtUni6AvW8xZDGHwvtaAuOxUQcNSaPpG6s+g3FrMkjEJv4ckxrM9DKSdl/jKL+j8H8mokTfIAgP
	2Iwve95tEvX1BoTRURwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeiL-0006tc-T4; Tue, 11 Dec 2018 09:52:29 +0000
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeiH-0006ru-Ip; Tue, 11 Dec 2018 09:52:27 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8812F3AF; Tue, 11 Dec 2018 10:52:07 +0100 (CET)
Date: Tue, 11 Dec 2018 10:52:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 00/18] MT8183 IOMMU SUPPORT
Message-ID: <20181211095206.hj7bnddgv2hqvm4w@8bytes.org>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_015225_769258_51C5A43C 
X-CRM114-Status: UNSURE (   7.72  )
X-CRM114-Notice: Please train this message.
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 04:39:13PM +0800, Yong Wu wrote:
> Arvind Yadav (1):
>   iommu/mediatek: Constify iommu_ops
> 
> Yong Wu (17):
>   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
>   iommu/mediatek: Use a struct as the platform data
>   memory: mtk-smi: Use a general config_port interface
>   memory: mtk-smi: Use a struct for the platform data for smi-common
>   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
>     helpers
>   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
>   iommu/mediatek: Add bclk can be supported optionally
>   iommu/mediatek: Add larb-id remapped support
>   memory: mtk-smi: Add gals support
>   iommu/mediatek: Add mt8183 IOMMU support
>   iommu/mediatek: Add mmu1 support
>   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
>   memory: mtk-smi: Add bus_sel for mt8183
>   iommu/mediatek: Fix VLD_PA_RANGE register backup when suspend
>   iommu/mediatek: Add shutdown callback
>   memory: mtk-smi: Get rid of need_larbid
>   iommu/mediatek: Switch to SPDX license identifier

If Matthias is okay with these patches, I'll queue them for v4.21.


Regards,

	Joerg

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
