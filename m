Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866BA20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0mP/FNA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="DqsDJYWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866BA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3qQq5ZGbMSohS43fNBQT5snrwJpmLEYb0auVneTGIeE=; b=m0mP/FNAiwORGQ
	ChNl3+c6YH/jwJA+h/aN24ioxOn5kdxu3FqlO9daBh6WIi66hqZheMHuV8cTmqfR6ON990GLwJ3oE
	yW2MV+VDpSMFg6qW1rc/Wxv50pPpKFnYiCIaakWJaaGJ+AKKkNJzVj87Fc5rTiry50g7x/KWqDbq0
	x1ZkXBdW/wvI3haCClaI9QPKTfaNBZzbdIN/Mo6pC+CTUncv2LkOIFMIzzbOfPfBNFObBZyel9N5I
	qKSInuuhwxNGZ61QRUkikI1xbFcOMtRGpzv5mFkNUusgzHqWQM6BBid04lhuL6XuLJlVq8lx6X8KG
	NVQC585sP5RD0vhULINg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLWW-0005Tg-Em; Mon, 10 Dec 2018 13:23:00 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLWF-0005Ch-6i
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:22:45 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2F9FE25B73F;
 Tue, 11 Dec 2018 00:22:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544448149; bh=wKrnhrTitCSOZm36DG3ToIrfZAuKKgrjPx5U6aDpugs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DqsDJYWWmBoBYCh7zIrdoRZV2ikiHYvp8bb1NlT9MpnT0iK0Jg0KZUlFmZpxupEJN
 UhBzR7scfWlqBObsd5iKpi7HtHEIYR1RZCyyVnZ7z9HBR9Lij+PEohvf0syYfU/N+3
 Dd81D1p//DsTEz4hccDKf/4utXEaVB0aY/XULWF0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 33BDC9402E1; Mon, 10 Dec 2018 14:22:27 +0100 (CET)
Date: Mon, 10 Dec 2018 14:22:27 +0100
From: Simon Horman <horms@verge.net.au>
To: Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Message-ID: <20181210132226.ppn74nzto6bv3mm3@verge.net.au>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-5-git-send-email-biju.das@bp.renesas.com>
 <20181210121340.iuwyq5myk4woezpg@verge.net.au>
 <OSBPR01MB2103861EF91EE6456EB3E03BB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2103861EF91EE6456EB3E03BB8A50@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_052243_464895_E5E9B1A6 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 12:35:35PM +0000, Biju Das wrote:
> Hi Simon,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
> > shmobile_defconfig
> >
> > On Fri, Dec 07, 2018 at 11:27:45AM +0000, Biju Das wrote:
> > > The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> > > support enable the driver in the shmobile_defconfig multiplatform
> > > configuration.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks, applied for v4.22.
> >
> > Is a similar change for multi_v7_defconfig also appropriate?
> 
> Will send a separate patch for adding it to the "multi_v7_defconfig"
> 
> CONFIG_RTC_DRV_PCF85363=m

Great, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
