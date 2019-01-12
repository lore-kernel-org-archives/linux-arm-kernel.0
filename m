Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D1C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mdc/7U+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D1C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dGiWtwF3an/B7LiqcXx3FCXk9msq5ZnLatobfTCb2F8=; b=mdc/7U+/dpYNkS
	MzuaSueyFpy4an+79p/AzBmXlqNzk9b5dICgNaN1nf+8GPQUwkabokPaFGBp/75u+a4VO71YPpJcg
	0TjTXioJzZaKoMDd2dwAMA85+Y2xZ99nvxoDsq18d4Td8bEkC4GZ7ZcAINET1vNPlMeHg1e0NcThw
	MepVRx1f4ehzgSmzkgA94rGVfLhwoIreG4NIOmPeJlO+aGNC/x1Hll+m8p0X8y2f1T7KBUSzJQ9S7
	h8xffxRGlQntkT28FGjd7NRlvKy6Aa1c4l1dvuvrqq3NjUDqnY0F+VhMTwtZJU24t0//wjP1MSdH+
	EfoKIoYVcNhnWVIGKMmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giOPq-0000DJ-41; Sat, 12 Jan 2019 18:53:54 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giOPm-0000Cq-Ti; Sat, 12 Jan 2019 18:53:52 +0000
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1giOPa-0006j3-6C; Sat, 12 Jan 2019 19:53:38 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Date: Sat, 12 Jan 2019 19:53:37 +0100
Message-ID: <2938788.qBnkOikdhP@phil>
In-Reply-To: <20190111145424.GA21604@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <154632658.xpTMZOjgxT@phil> <20190111145424.GA21604@bogus>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_105351_107138_9DA1440B 
X-CRM114-Status: GOOD (  17.24  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org,
 Johan Jonker <jbx6244@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 11. Januar 2019, 15:54:24 CET schrieb Rob Herring:
> On Sun, Dec 30, 2018 at 06:22:00PM +0100, Heiko Stuebner wrote:
> > Hi Johan,
> > 
> > Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> > > From: Mark Yao <mark.yao@rock-chips.com>
> > > 
> > > This patch adds the rk3066 VOP definitions.
> > > 
> > > The VOP or LCD Controller serves as interface between
> > > framebuffer memory and a display device (LCD panel or TV set).
> > > 
> > > This SOC has two symmetrical LCDC's for a dual panel application.
> > > 
> > > A LCDC has 5 display layers.
> > > Only 3 are used here.
> > > 
> > > - Video layer 0 (Win0)
> > > - Video layer 1 (Win1)
> > > - OSD layer     (Win2)
> > 
> > Patch itself looks good, we'll need to wait a bit to give Rob a chance
> > to look at the (simple) dt-binding change and I'll drop the paragraph
> > about the display layers when applying.
> 
> Don't wait on me for simple oneline compatible additions.

This more or less was the fault of the year change :-D ... most of
the time I'd apply a simple new compatible earlier and possibly
without Ack ;-) .

And I've applied the patch to drm-misc-next now (for 5.1).

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
