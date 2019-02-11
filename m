Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB01C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404F42070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnNPii6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404F42070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JiS0dGjphpJoepcl4Jo40ojhSfoguD40WGpdZJoiOoA=; b=tnNPii6S7NO/1E
	NgSWecMiTcfEeKqu0MyuQiRba/djZ/GkzTQUOl34THcSrB88il7Y00WV4lTz1J80IQ+yiIVswX8jm
	64yrejAUSki05dREDKvo5dKhRwBRCwf92qAQ0eYcnXgkIQ4qmIngRX6ATIwOVoXV7lYYoquAyHa4m
	pN+2K9EUnBx38AMETyGsOxC/zfjXaNXa82Mw61fRHzqv/rbWBSSpVO2o6BfnXN3dddMx5k7SUS9Bc
	tgrTMoDzU/ZTJofZLqiJe0BspeOvzGYoXmHSaQbHWe7hq73WcV/SQC1NLCxP4mso8xdKyqA+3IOUX
	Uj+IbHYRdxlS7N9Ed0qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt5Bw-0001uC-44; Mon, 11 Feb 2019 06:35:44 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt5Bs-0001st-Qw; Mon, 11 Feb 2019 06:35:42 +0000
X-UUID: 24cd342b382440738e1cc2bcf1b46352-20190210
X-UUID: 24cd342b382440738e1cc2bcf1b46352-20190210
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <seiya.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1250195383; Sun, 10 Feb 2019 22:35:33 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 10 Feb 2019 22:35:32 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 14:35:29 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 14:35:29 +0800
Message-ID: <1549866929.22817.20.camel@mtksdccf07>
Subject: Re: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt
 parameters for sysirq
From: Seiya Wang <seiya.wang@mediatek.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 11 Feb 2019 14:35:29 +0800
In-Reply-To: <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
 <898ca3d9-002b-e28e-fc97-86bc2538e9de@gmail.com>
 <626b5b46-aac7-1532-386e-2fed85bf4ad9@arm.com>
 <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0EC95753EDE9BB9F38910B43EEEF03341118F2C1563FCCA041DC54C948DD96C92000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_223540_888423_08093757 
X-CRM114-Status: GOOD (  17.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erin Lo <erin.lo@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 mars.cheng@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
 eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-07 at 15:52 +0000, Marc Zyngier wrote:
> On 07/02/2019 15:47, Marc Zyngier wrote:
> > On 07/02/2019 15:20, Matthias Brugger wrote:
> >>
> >>
> >> On 24/01/2019 09:07, Erin Lo wrote:
> >>> From: Seiya Wang <seiya.wang@mediatek.com>
> >>>
> >>> To support partitioned PPIs, 4 interrupt parameters should be valid
> >>> for sysirq.
> >>>
> >>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> >>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >>> ---
> >>>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> >>> index 90aaf19..282736a 100644
> >>> --- a/drivers/irqchip/irq-mtk-sysirq.c
> >>> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> >>> @@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
> >>>  				       unsigned int *type)
> >>>  {
> >>>  	if (is_of_node(fwspec->fwnode)) {
> >>> -		if (fwspec->param_count != 3)
> >>> +		if (fwspec->param_count != 3 && fwspec->param_count != 4)
> >>
> >> Where is this 4th parameter used?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt#n14
> Sorry, I fired Send way too early.
> 
> What I wanted to add is that it is not clear to me why this change would
> be required here, as this driver only supports SPIs. It could be fixed
> by just relaxing the binding itself.
> 
> Thanks,
> 
> 	M.

Do you mean that we should change #interrupt-cells back to 3 for sysirq
and remove the 4th parameters of every spi interrupts in mt8183.dtsi
(i.e. 3 parameters for spi, 4 for ppi) such that we can discard this
patch?

If yes, we may need some time to verify the change before resending the
patch.

Thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
