Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72653C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4353A21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nSQH0zIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4353A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d9+HOyFs6IJTISSZEYf8JnUtIbWP289ypL1nNEOjqOQ=; b=nSQH0zIud/huPM
	N3Tt8AW+s3EGR4FzrhHAdXYoNkj/c3Xy1o8oH8J9DdCgKDWhsSOYyZU4MqQ1eMIfP4YwufEdTqAje
	2MgzZBsJ3NWEIYiKFQkBNaRFwrqWId9a4hqQJdo6PI3Uoa/+M2pSRMVVGPecG8fdM+gKtLPYKkQZO
	0t/fPfxrajZDkyx3ODakHXEGbAPpvAoxoyrdsAgj+1xZauvQ/5B78IAEmFvnfU+QcsP7HrTe8Ho74
	Ku1tz0b+Ll2a7CGOaXwUwgDF+GHHkmIP/6PpiX8bijswNYcGFMh2U6GanAfZ6CVw5XJWJfUJzmYjY
	kprA/VeT1RRdTlxq0UDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glzEt-0006jH-KR; Tue, 22 Jan 2019 16:49:27 +0000
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glzEo-0006iH-QB; Tue, 22 Jan 2019 16:49:26 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0F1021FC; Tue, 22 Jan 2019 17:49:17 +0100 (CET)
Date: Tue, 22 Jan 2019 17:49:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Message-ID: <20190122164916.r343pqa2dtopzrxo@8bytes.org>
References: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_084924_449557_5687FD2F 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Frank,

thanks for the report!

On Tue, Jan 22, 2019 at 05:09:09PM +0100, Frank Wunderlich wrote:
> Hi,
> 
> the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):
> 
> a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"

Does the attached diff fix the issue for you?

Thanks,

	Joerg

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6ede4286b835..f60bdb85c4c0 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -442,6 +442,10 @@ static int mtk_iommu_add_device(struct device *dev)
 		iommu_spec.args_count = count;
 
 		mtk_iommu_create_mapping(dev, &iommu_spec);
+
+		/* dev->iommu_fwspec might have changed */
+		fwspec = dev_iommu_fwspec_get(dev);
+
 		of_node_put(iommu_spec.np);
 	}
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
