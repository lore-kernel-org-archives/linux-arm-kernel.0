Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87257C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF8720870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYJ0/p8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF8720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0kvsTFAxD8taYalmehxvz+AB74U4bbFYp8M+njjF6o=; b=iYJ0/p8i3AKMx7
	qzBkEzCPLhlzfcgX0l8AVC0+oqH70WN25T/4Lq3aHXNqObGRQWQ4mZpCPMg3qeSawECuZo0dQbc1T
	+WaLFrcQdEsY0YeHgjGn6X5RwM5zq4OnIOVbEjaZe26rw9rsjeGtNZyDRavMNunBz4yOWxnWO2zcn
	1uq/9Cs1s4/c+17CkEa0O+jPjDJcTjALWkIHM0W3roIP+8b5SOfci4KAeRF4AqQ2/rOQTsDGhtJQe
	hXQW7jYkdE7ilN5rSMDj5jbhuRDz84y9jP8NGv7mV0CWf2G0hUFLj5DuOP7BRZxRromKoK1hulGeP
	/T4dM2+pgH3XdCp7UhkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2uv-0003ZV-5k; Thu, 31 Jan 2019 03:21:29 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2uq-0003YZ-DK; Thu, 31 Jan 2019 03:21:27 +0000
X-UUID: f20373853a8747d1a5e4de2dadd6aa02-20190130
X-UUID: f20373853a8747d1a5e4de2dadd6aa02-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1455084985; Wed, 30 Jan 2019 19:21:10 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:21:08 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:21:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:21:05 +0800
Message-ID: <1548904865.19710.37.camel@mhfsdcap03>
Subject: Re: [PATCH v5 19/20] iommu/mediatek: Add shutdown callback
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:21:05 +0800
In-Reply-To: <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-20-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4g4HbDG7shtiqUP5vw9tiyRr4VEheMGM2uhEL_65yYmg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_192124_599213_1C702EFC 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: youlin.pei@mediatek.com, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 11:12 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > In the reboot burning test, if some Multimedia HW has something wrong,
> > It may keep send the invalid request to IOMMU. In order to avoid
> > affect the reboot flow, we add the shutdown callback to disable
> > M4U HW when shutdown.
> 
> Sounds unpleasant. Hopefully the reboot flow still continues properly
> even in that case, since this shutdown code may not run during some
> rougher resets.

Thanks this hint. I will reword the comment avoid writing reboot.

> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
