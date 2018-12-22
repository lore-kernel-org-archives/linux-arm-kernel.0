Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A383C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:57:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C849D218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N4tRmAqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849D218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bq0UULh5xL5N5zdSDsGAWywGyjVFE6H3iy43RBXZccY=; b=N4tRmAqRZPwxHl
	BrqMEvcR8vjocC3L5D1ZYBxkvY5FTnkz76c91gYaSlUU6+kTk3cs0WjvVr7wFb1vUD8OXSmYR+XGY
	XrUgd6cOz+W3Dp3wqADZAfr6VbMrjsZyDLBiqMBMfUQD7Dx2sm0jbjCFaDDZpmZqwatTfiNFijqao
	6F98dPofB0SPsxXfh9sZfbF34f8VjdcJ6gpLUWiaPzBpTnY0BzKYsmmLlb43udPdAnKDWq/+HSsaf
	UNk2tCEFHbr4h0ZHmgz266Dqg4yqRpz4HFENbqdqsgxogfOGPrXX22x481SN6rWHN3wUVoVASqUTZ
	/zP6acp4zmrCg22gxOQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaYPs-0007IU-9O; Sat, 22 Dec 2018 03:57:32 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaYPo-0007HT-Et; Sat, 22 Dec 2018 03:57:30 +0000
X-UUID: 2d2635b84153470c99e8e05dbddebae5-20181222
X-UUID: 2d2635b84153470c99e8e05dbddebae5-20181222
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 420443479; Sat, 22 Dec 2018 11:57:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Sat, 22 Dec 2018 11:57:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Dec 2018 11:57:09 +0800
Message-ID: <1545451029.29587.88.camel@mhfsdcap03>
Subject: Re: [PATCH v4 03/18] memory: mtk-smi: Use a general config_port
 interface
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Sat, 22 Dec 2018 11:57:09 +0800
In-Reply-To: <aa91ceb7-673b-7022-d718-f9f61d4b2f23@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-4-git-send-email-yong.wu@mediatek.com>
 <aa91ceb7-673b-7022-d718-f9f61d4b2f23@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AB02C084B20EE4BCA50763E1D82E09562B22C2F6AEDB29FB3F7D7D8289E858D62000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_195728_628150_47CC9DD2 
X-CRM114-Status: GOOD (  26.00  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-21 at 18:47 +0100, Matthias Brugger wrote:
> 
> On 08/12/2018 09:39, Yong Wu wrote:
> > The config_port of mt2712 and mt8183 are the same. Use a general
> > config_port interface instead.
> > 
> > In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> > are not the normal larb, their register space are different from the
> > normal one. thus, we can not call the general config_port. In mt8183,
> > IPU0/1 and CCU connect with smi-common directly, they also are not
> > the normal larb. Hence, we add a "larb_special_mask" for these special
> > larbs.
> > 
> > This is also a preparing patch for adding mt8183 SMI support.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/memory/mtk-smi.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 8f2d152..3b9ad0e 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
> >  	bool need_larbid;
> >  	int port_in_larb[MTK_LARB_NR_MAX + 1];
> >  	void (*config_port)(struct device *);
> > +	unsigned int larb_special_mask; /* The special larbs mask. */
> 
> I'm not really happy with the name larb_special_mask but I can't think of
> anything else. The comment is not needed as it just rewords the name of the
> variable.

Thanks this comment. then I reword more detail instead this common
"special", How about "larb_to_common_directly_mask"?

> 
> Other then that (or even without changing anything):
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Thanks.

> 
> >  };
> >  
> >  struct mtk_smi {
> > @@ -176,17 +177,13 @@ void mtk_smi_larb_put(struct device *larbdev)
> >  	return -ENODEV;
> >  }
> >  
> > -static void mtk_smi_larb_config_port_mt2712(struct device *dev)
> > +static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> >  {
> >  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> >  	u32 reg;
> >  	int i;
> >  
> > -	/*
> > -	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
> > -	 * Don't need to set it again.
> > -	 */
> > -	if (larb->larbid == 8 || larb->larbid == 9)
> > +	if (BIT(larb->larbid) & larb->larb_gen->larb_special_mask)
> >  		return;
> >  
> >  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > @@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  
> >  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> >  	.need_larbid = true,
> > -	.config_port = mtk_smi_larb_config_port_mt2712,
> > +	.config_port       = mtk_smi_larb_config_port_gen2_general,
> > +	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
> >  };
> >  
> >  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
