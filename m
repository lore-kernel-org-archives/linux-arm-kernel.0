Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69317C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CFA2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q7+zjrDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CFA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hrh3CXna3+33RsRx/juClE2wB0qfG1Ch33fvxrkv/0o=; b=Q7+zjrDioVkO6z
	g5ZGvCeqAd86UqkjzVB0VWHF3Rtip+tMH2joPG3bHL4R/i7rWE8IPW+tKeAvzG/Ts9/7xnJbuphKf
	356F56yc2Dn9/rtju///TfIjXvXgIbBkij2t9pFAVOahuUPBMDnKrc8korX/IT4PNBGI9Qvt6PIrl
	JExW8wyPYt30OqRKHFrJOaIxCQ7UOfg+yzHuGSbNrcaVWROa+Ur7so6BVAnbKMjvuyQx3Z3kwbcN+
	8MOcmJfl428gk2rG+G7a4sO0bVcUKoFmFjMcvUwp9BUl6uZ3i+5YwKXV2lANDUBwgyac8ncf14KDo
	WYUghBfIhP6QRqrUb+dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggPO2-000653-5c; Mon, 07 Jan 2019 07:31:50 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggPNx-00063n-8w; Mon, 07 Jan 2019 07:31:47 +0000
X-UUID: 0a5d2e256d684aa6b33bcab4817e8482-20190106
X-UUID: 0a5d2e256d684aa6b33bcab4817e8482-20190106
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 693730079; Sun, 06 Jan 2019 23:31:37 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 6 Jan 2019 23:31:35 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 7 Jan 2019 15:31:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 15:31:32 +0800
Message-ID: <1546846292.4433.24.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From: Min Guo <min.guo@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Mon, 7 Jan 2019 15:31:32 +0800
In-Reply-To: <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
 <20190103221414.GA14639@bogus> <1546570807.585.31.camel@mhfsdcap03>
 <CAL_JsqK5x8=b6gXfBStZwHbq4zvuCuHCLAwsSqFEMJtSffC3BQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_233145_499889_5B234855 
X-CRM114-Status: GOOD (  25.48  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Bin Liu <b-liu@ti.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-04 at 10:10 -0600, Rob Herring wrote:
> On Thu, Jan 3, 2019 at 9:00 PM Min Guo <min.guo@mediatek.com> wrote:
> >
> > On Thu, 2019-01-03 at 16:14 -0600, Rob Herring wrote:
> > > On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> > > > From: Min Guo <min.guo@mediatek.com>
> > > >
> > > > This adds support for MediaTek musb controller in
> > > > host, peripheral and otg mode
> 
> [...]
> 
> > > > + - interrupts      : interrupt used by musb controller
> > > > + - interrupt-names : must be "mc"
> > >
> > > -names is pointless when there is only one.
> > The MUSB core driver has two interrupts, one is for MAC, another for DMA,
> > but on MTK platform, there is only a MAC interrupt, here following the binding
> > of MUSB core driver.
> 
> You should probably be listing the same interrupt number twice if 2
> interrupts are combined.

If only one interrupt is regisetred in driver, dose still need list the
same interrupt number twice in dtsi?

> > > > +Optional properties:
> > > > + - extcon : external connector for VBUS and IDPIN changes detection,
> > > > +   needed when supports dual-role mode.
> > >
> > > Don't use extcon for new bindings. The usb-connector binding should be
> > > used instead.
> > This is used to detect the changes of the IDPIN and VBUS, the change
> > events are provided by other drivers, such as extcon-usb-gpio.c, and
> > then switch MUSB controller to host or device mode, but the
> > usb-connector can't detect these changes.
> 
> To repeat, do not use extcon binding for new bindings. It is poorly
> designed as it reflects extcon driver needs, not a description of the
> hardware. If you have ID on GPIO, then that belongs in a usb-connector
> node because that GPIO goes to the connector. For Vbus, you should
> have a vbus-supply in the connector and use a gpio-regulator if it is
> GPIO controlled.

Sorry, I didn't find a common driver describing the usb-connector. Is
there any driver that I can refer to, specially the way to switch MUSB
controller between host and device mode?

> > > > + - vbus-supply : reference to the VBUS regulator, needed when supports
> > > > +   dual-role mode.
> > >
> > > The controller is powered from Vbus? Probably not. This belongs in the
> > > connector or maybe the phy (if the phy is powered from Vbus).
> > The Vbus is used to provide 5V voltage to the connected device when the
> > controller works as host mode.
> 
> I know what Vbus is. Unless Vbus is providing power to the host
> controller, putting the Vbus supply in the controller node is not a
> accurate representation of the hardware.

I will put vbus-supply in usb-connector after implement it.

> Rob



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
