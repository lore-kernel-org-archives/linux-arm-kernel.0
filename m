Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511C5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D7621019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1hcQtUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D7621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qgNj3EYsyz4ALvFzQA2ZzlSJfJB45gU+MQ/nwjuKoHY=; b=L1hcQtUp3hPlDl
	mhG0PCj/+wdL3ygsgnd/2LBEpysy/3BHEoq4u3yuUNV4Y5ZfiCpfxMK9p+MMVRvF7vWJa5tKLNua5
	1AWaBDQn6FcgfVTpG/Cvy3FXZTtXjuortM3FcJPcD0NF9vpQeMPevNCmfU6Zp17PIftFdfjVIUSje
	OQdnNk93iqFhJne9ljmUDPs4H3Clek3rfTXabOw6wsdKQzz5hmRBXHTbY8Vftn+VH+DNidppLARtT
	FUl7eZt9vHmAtIxeivY13yl0j7JJQbHiKM0BH0/EH5++KgkYOsybslm2x2HCTP5oE58TQ6Hc2AG/E
	skFaNm7KIeC3WI6oi3uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwbt-0004DM-RD; Tue, 22 Jan 2019 14:01:01 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwbp-0004CV-Lq; Tue, 22 Jan 2019 14:00:59 +0000
X-UUID: 66d243df64f843abb8ecb54016d35e18-20190122
X-UUID: 66d243df64f843abb8ecb54016d35e18-20190122
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 183744887; Tue, 22 Jan 2019 06:00:52 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 06:00:50 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 22:00:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 22:00:48 +0800
Message-ID: <1548165648.2429.13.camel@mtkswgap22>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
From: Ryder Lee <ryder.lee@mediatek.com>
To: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 22 Jan 2019 22:00:48 +0800
In-Reply-To: <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
 <CACRpkdZMgnj2S8xPPFm3PnDGrqTerOwWcS-+Uruy1uLH24HRLg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_060057_714880_F538D48A 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Weijie Gao =?UTF-8?Q?=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, "open
 list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CC: stable@vger.kernel.org

On Fri, 2018-12-21 at 18:17 +0800, Linus Walleij wrote:
> On Thu, Dec 13, 2018 at 3:28 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
> 
> > Remove prompts to make all pinctrl cores to non-visible symbols and
> > make sure the target SoCs would be coupled with the corresponding
> > cores.
> >
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Patch applied with ACK and Tested-by.
> 
> Yours,
> Linus Walleij

I forgot to add stable-kernel into CC list.
This patch should be applied to stable-rc linux-4.20.y.

Sorry for the inconvenience. 
Ryder





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
