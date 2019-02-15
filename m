Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0592BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B99222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KzihqKsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B99222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LtfrJsib0+Z0RChRs8WbckKSbAIma1Uac+5uptlOANs=; b=KzihqKsErVlgXi
	d21VOo//eM8XAhEWCWHg+yo7LlsPFjdV1/DRfpz95O4KNPq2eVGMV63g8WnjeRn38niBNOET9OZuk
	aRQPOLulL3m/rHmGUIbrsrdEHiq1tG1bagBwZ52vqPSgs7dsfN+W3hVz0ffjXdo2xYGyYzMl58dVk
	zpazUD+dW3c4m2Ye8nsZV5KiYf2ZU1yvfBdqJezrw4ou5+atGxAtc/Od5vyuWzQnlkcFvdKVEhliM
	tNp3Vb3N2Dam7jLswA6HQPtReg3swANNEB3jL3ln1P9YrZqAEMm7ZZf0KSUTfXfdiHrkquknS6YT1
	tRmMzYg5CWJELHEIu8yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujDT-00060c-Ta; Fri, 15 Feb 2019 19:32:07 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujDP-000604-RX; Fri, 15 Feb 2019 19:32:05 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gujDO-0002ny-9R; Fri, 15 Feb 2019 20:32:02 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] Rockchip dts64 updates for 5.1
Date: Fri, 15 Feb 2019 20:32:01 +0100
Message-ID: <3976614.8kaIahWTG7@diego>
In-Reply-To: <CAK8P3a2UkmVOJDddi3rC=GFcBSeqciNuYaT8s3i5E4bOwJE1Bg@mail.gmail.com>
References: <2570520.8EeqtpO5V7@phil>
 <CAK8P3a2drxVzNgsKcM2ii62+NsVmsCiOKGirQeby0kOFRQnX_g@mail.gmail.com>
 <CAK8P3a2UkmVOJDddi3rC=GFcBSeqciNuYaT8s3i5E4bOwJE1Bg@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_113204_043820_77B70EBF 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 15. Februar 2019, 16:38:43 CET schrieb Arnd Bergmann:
> On Fri, Feb 15, 2019 at 2:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Feb 1, 2019 at 12:24 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > > New boards are the Rock Pi 4, NanoPC-T4 and NanoPi-M4, with the last
> > > two being part of a family and sharing bigger parts of the devicetree.
> > > rk3328 got sound-related upgrades and a wider patch drops mmc display-wp
> > > fields from nodes which shouldn't use it.
> > 
> > Pulled into arm/dt, nice to see the additional rk3399 boards. Thanks,
> 
> I still get some warnings during 'make dtb', all specific to rk3399:
> 
> ../arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning
> (graph_port): /edp-panel/ports: graph port node name should be 'port'
> ../arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:46.9-50.5:
> Warning (graph_port): /edp-panel/ports: graph port node name should be
> 'port'
> ../arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:94.9-98.5:
> Warning (graph_port): /edp-panel/ports: graph port node name should be
> 'port'
> 
> Can you see what is going on and send a fix?

hmm, that should actually be fixed by the fixes-pull requests, see
	https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=arm/fixes&id=26cd8657c7e745686a4c54a5cccf721ede208a25
for reference, which supposedly fixes exactly these issues.


Heiko




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
