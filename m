Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B34F2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNmUlEgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B34F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=boE10CNuZc5o3Afm5INHmkE3XPYbxiJzuJJnGme2MXo=; b=VNmUlEgNRTtTQE
	1X/xxHqlGGeeIMGWBgqUyrTTlla4Vwi+8gV90apWe7HHooVNDlGTcW18ayppYCeLLsYbUIE/YFH6g
	R0tPaFPh8i3Z6lLKDyYCEIr9WZX4iRLhLkov5lrk9Qy2G9+8qSEedyLQBVqdf2LaV2FhsU9qYEtil
	IK7ebWmMD+cYLpMiSbtFOMLb/3ZHniu/udohOoMEDuZp9VcQKbc6yiKPZgcjFv94gEUKTgDAqyWjz
	voMGTrwdo1SZTXV+bDwuqrrjUhTGb60stvqZDHJ1Fe4fiOG63ABm/bHfYAzTJgAsq9ml9rKatrwva
	Aayoq2WW5F2pb6pCCf1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMMG-0005xt-ED; Wed, 20 Feb 2019 07:31:56 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMLc-0005J4-BU; Wed, 20 Feb 2019 07:31:20 +0000
X-UUID: 8177241d9b7c464e91cee0496fa891bc-20190219
X-UUID: 8177241d9b7c464e91cee0496fa891bc-20190219
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <jungo.lin@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1389506669; Tue, 19 Feb 2019 23:31:11 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 23:31:09 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 15:31:07 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 15:31:07 +0800
Message-ID: <1550647867.11724.80.camel@mtksdccf07>
Subject: Re: [RFC PATCH V0 7/7] [media] platform: mtk-isp: Add Mediatek ISP
 Pass 1 driver
From: Jungo Lin <jungo.lin@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Feb 2019 15:31:07 +0800
In-Reply-To: <CAAFQd5CaXz_Lqz8NhGK4DvaxPvuYLj-Y73sG7wFaqW44j+tZQw@mail.gmail.com>
References: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
 <1549348966-14451-8-git-send-email-frederic.chen@mediatek.com>
 <CAAFQd5CWdZUXVb4F9BLhQdN8WHjzA8acPDx1i+WcoudsdGsfUg@mail.gmail.com>
 <1550372163.11724.59.camel@mtksdccf07>
 <CAAFQd5CaXz_Lqz8NhGK4DvaxPvuYLj-Y73sG7wFaqW44j+tZQw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_233116_620473_98333A0F 
X-CRM114-Status: GOOD (  26.90  )
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
Cc: ryan.yu@mediatek.com, frankie.chiu@mediatek.com, ryan_yu@mediatek.com,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Rynn Wu =?UTF-8?Q?=28=E5=90=B3=E8=82=B2=E6=81=A9=29?= <Rynn.Wu@mediatek.com>,
 Jerry-ch.Chen@mediatek.com, Hans Verkuil <hans.verkuil@cisco.com>,
 frankie_chiu@mediatek.com, Frederic Chen <frederic.chen@mediatek.com>,
 Seraph.Huang@mediatek.com,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Holmes Chiou =?UTF-8?Q?=28=E9=82=B1=E6=8C=BA=29?= <holmes.chiou@mediatek.com>,
 seraph_huang@mediatek.com, Sj Huang <sj.huang@mediatek.com>,
 yuzhao@chromium.org, linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>,
 " <linux-arm-kernel@lists.infradead.org>,
 Sean Cheng =?UTF-8?Q?=28=E9=84=AD=E6=98=87=E5=BC=98=29?=
 <Sean.Cheng@mediatek.com>, srv_heupstream@mediatek.com,
 Christie Yu =?UTF-8?Q?=28=E6=B8=B8=E9=9B=85=E6=83=A0=29?=
 <christie.yu@mediatek.com>, zwisler@chromium.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-19 at 17:51 +0900, Tomasz Figa wrote:
> Hi Jungo,
> 
> On Sun, Feb 17, 2019 at 11:56 AM Jungo Lin <jungo.lin@mediatek.com> wrote:
> >
> > On Wed, 2019-02-13 at 18:50 +0900, Tomasz Figa wrote:
> > > (() . ( strHi Frederic, Jungo,
> > >
> > > On Tue, Feb 5, 2019 at 3:43 PM Frederic Chen <frederic.chen@mediatek.com> wrote:
> > > >
> > > > From: Jungo Lin <jungo.lin@mediatek.com>
> > > >
> > > > This patch adds the driver for Pass unit in Mediatek's camera
> > > > ISP system. Pass 1 unit is embedded in Mediatek SOCs. It
> > > > provides RAW processing which includes optical black correction,
> > > > defect pixel correction, W/IR imbalance correction and lens
> > > > shading correction.
> > > >
> > > > The mtk-isp directory will contain drivers for multiple IP
> > > > blocks found in Mediatek ISP system. It will include ISP Pass 1
> > > > driver, sensor interface driver, DIP driver and face detection
> > > > driver.
> > >
> > > Thanks for the patches! Please see my comments inline.
> > >
> >
> > Dear Thomas:
> >
> > Thanks for your comments.
> >
> > We will revise the source codes based on your comments.
> > Since there are many comments to fix/revise, we will categorize &
> > prioritize these with below list:
> >
> > 1. Coding style issues.
> > 2. Coding defects, including unused codes.
> > 3. Driver architecture refactoring, such as removing mtk_cam_ctx,
> > unnecessary abstraction layer, etc.
> >
> 
> Thanks for replying to the comments!
> 
> Just to clarify, there is no need to hurry with resending a next patch
> set with only a subset of the changes. Please take your time to
> address all the comments before sending the next revision. This
> prevents forgetting about some remaining comments and also lets other
> reviewers come with new comments or some alternative ideas for already
> existing comments. Second part of my review is coming too.
> 
> P.S. Please avoid top-posting on mailing lists. If replying to a
> message, please reply below the related part of that message. (I've
> moved your reply to the place in the email where it should be.)
> 
> [snip]

Hi, Tomasz,

Thanks for your advice.
We will prepare the next patch set after all comments are revised.


> > > > +       phys_addr_t paddr;
> > >
> > > We shouldn't need physical address either. I suppose this is for the
> > > SCP, but then it should be a DMA address obtained from dma_map_*()
> > > with struct device pointer of the SCP.
> > >
> >
> > Yes, this physical address is designed for SCP.
> > For tuning buffer, it will be touched by SCP and
> > SCP can't get the physical address by itself. So we need to get
> > this physical address in the kernel space via mtk_cam_smem_iova_to_phys
> > function call and pass it to the SCP. At the same time, DMA address
> > (daddr) is used for ISP HW.
> >
> 
> Right, but my point is that in the kernel phys_addr_t is the physical
> address from the CPU point of view. Any address from device point of
> view is dma_addr_t and should be obtained from the DMA mapping API
> (even if it's numerically the same as physical address).
> 

OK.
In order to clarify the address usage, is it ok to rename "dma_addr_t
scp_addr"?
Moreover, below function will be also renamed.
dma_addr_t mtk_cam_smem_iova_to_scp_phys(struct device *dev,
				      dma_addr_t iova)
Could you help us to review?
If you have any better suggestion, please kindly let us know.


Best regards,

Jungo

> Best regards,
> Tomasz
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
