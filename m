Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B4FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3572520660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A154klgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xKuwRjCYPD/rHNtdHWtqmCgcDe+fdMiMVK6mD5XytQE=; b=A154klgnmgr/+R
	SbD9Bx0Z/K3aCa9F6DwXuN6wN5iyue1jZmZcEgMAkqlxrbG7PrCLbTzbwO+eDIN8qfiYrNArNHuLL
	Kw19cskEOwjMVWM/YjafJWvbKpRIxBPlyRIXN5c/ta5z0NeTaOroztTXllllu7AHqT1C0dZV5tw4j
	kEEaIEonlnwxf63an2+tnCjeXfhxteHhBl9HD0Y3M38dgB/aPTojbLqjERIwFZkbsdYYmNKQ8JWt/
	g585ubZfwHrvjNG05CZM7rCU+YHtd88Adncyv6/jyjG+Ynl3TPe3pay0XhLU6r2VzwrE9JqfblkiP
	yoV0h/JU/4RXz/hJ5v7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giwBy-0005hL-2R; Mon, 14 Jan 2019 06:57:50 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giwBt-0005gD-Tx; Mon, 14 Jan 2019 06:57:47 +0000
X-UUID: d7e971ef8b314330befcf337df985de3-20190113
X-UUID: d7e971ef8b314330befcf337df985de3-20190113
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 800403704; Sun, 13 Jan 2019 22:57:32 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 13 Jan 2019 22:57:31 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 14 Jan 2019 14:57:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Jan 2019 14:57:28 +0800
Message-ID: <1547449048.24830.15.camel@mhfsdcap03>
Subject: Re: [PATCH v5 12/20] memory: mtk-smi: Add gals support
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 14 Jan 2019 14:57:28 +0800
In-Reply-To: <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_225745_972641_8B10484F 
X-CRM114-Status: GOOD (  14.91  )
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
Cc: youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 arnd@arndb.de, srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Matthias,

   Gentle ping about this and the other mtk-smi part in this patchset.

   The memory part don't have its specific maintainer, normally we need
SoC maintain's help. Thus, For this file(memory/mtk-smi.c), your review
is needed before Joerg accept it.

    Appreciate in advance.

On Tue, 2019-01-01 at 11:55 +0800, Yong Wu wrote:
> In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
> which can help synchronize for the modules in different clock frequency.
> It can be seen as a "asynchronous fifo". This is a example diagram:
> 
>             M4U
>              |
>          ----------
>          |        |
>      gals0-rx   gals1-rx
>          |        |
>          |        |
>      gals0-tx   gals1-tx
>          |        |
>         ------------
>          SMI Common
>         ------------
>              |
>   +-----+--------+-----+- ...
>   |     |        |     |
>   |  gals-rx  gals-rx  |
>   |     |        |     |
>   |     |        |     |
>   |  gals-tx  gals-tx  |
>   |     |        |     |
> larb1 larb2   larb3  larb4
> 
> GALS only help transfer the command/data while it doesn't have the
> configuring register, thus it has the special "smi" clock and doesn't
> have the "apb" clock. From the diagram above, we add "gals0" and
> "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> This patch adds gals clock supporting in the SMI. Note that some larbs
> may still don't have the "gals" clock like larb1 and larb4 above.
> 
> This is also a preparing patch for mt8183 which has GALS.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
[...]
  




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
