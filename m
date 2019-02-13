Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A2C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D36222C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I/TOnpcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D36222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/futOYAB0M3iyxSwt+ly2X6tvcGW/2VoeWR7rC83tXE=; b=I/TOnpcrBWGJYG
	MaKkHlGD4xbQKKu03QuZKeM9reC/NB2Z9NTyBRbE2L9TTHHUVtP9QVuH/RKuLUi8NMC5tyEBxjWjD
	BmtWoCqfbckq6ptb914EL/cSJqK1iQQV5IITM6KI5pmU5WMahtEP9LlmFwzar05qRLpKyVfhN4JAr
	HHzqq0qW6HBtFRfCN5+Ph3QoqNN0tzBq6CBr+Wn6J7hb1Rq/7vwjOHYkXDzWMR3klWJQWBPaXKJ32
	l0+O24CSfGQ2Rs+UtSL4yPLFvGo3PVGinqsk2huCoL2DOI4vIUw94zV2El7JRHn2slm1EK1kWEg0a
	+5B6TYZGoN6K1n4oHN7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtobm-0002vJ-PO; Wed, 13 Feb 2019 07:05:26 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtobW-0001pT-Of
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:05:13 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 2D3235FBF9; Wed, 13 Feb 2019 15:05:04 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/2] arm64: allwinner: a64: Rename hpvcc-supply to cpvdd-supply
Date: Wed, 13 Feb 2019 15:04:55 +0800
Message-Id: <20190213070457.26049-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_230511_020837_5663DDAC 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This is a small series to fix the CPVDD regulator supply name for the
A64 codec. The datasheet specifies the name "CPVDD" for the supply rail
for the audio codec's internal headphone amp charge pump.

Somehow I managed to write "CPVDD" in the commit message and the device
tree binding, but used "HPVCC" (which is the name used by the A33) in
the device tree files and the device driver. (facepalm)

This feature was just introduced in v5.0-rc1, so if we could merge this
as fixes for v5.0 that would be great.

Thanks, and sorry for the blunder on my part.


Regards
ChenYu


Chen-Yu Tsai (2):
  ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to
    cpvdd
  arm64: dts: allwinner: a64: Rename hpvcc-supply to cpvdd-supply

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 2 +-
 sound/soc/sunxi/sun50i-codec-analog.c                     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
