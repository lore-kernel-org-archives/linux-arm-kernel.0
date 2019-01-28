Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA66C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:55:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0CE21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hbk5Xdm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0CE21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9LkxEndT13XonnXB36lOx1rZ3U6sGFAlMFus7huqa3M=; b=hbk5Xdm5ibduNt
	O1U3AaXd7h6e1nUivOGCoa78e4519OpRPy55P1RjjuFwLLUPY5ArMIkuGJ1/H8ADyMOS7GERW2yHq
	AEsv9V5i5rKsxT9vPwLPa47V9E2rS+IX0B6lOjZ2ixWkvxc/vD0RrD8uOimPNcCzSxsOgOM5YPzDe
	FbORBDUTIEX0j2SdyIz9+rycgSXJbb2MvrU8kDpw8b6SQCi5x/Wntvs0WIg05Dpld5bYl4AWTFimU
	n6dpGV4NyIZrKO8Rk4GW0VcYqCZeC2Vxjrucih1qA+Mgag8Z992KVV2RqqKWZtlsK+Zatg0Eb2PWR
	cHLP+FI/Ey3RJvqVBNsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goDwS-0000DA-P0; Mon, 28 Jan 2019 20:55:40 +0000
Received: from mailoutvs8.siol.net ([185.57.226.199] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDwD-0008Ru-Ee
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 20:55:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id 306425208E6;
 Mon, 28 Jan 2019 21:55:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id jRCSuBCFPMvI; Mon, 28 Jan 2019 21:55:12 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id CF129521814;
 Mon, 28 Jan 2019 21:55:12 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Zimbra) with ESMTPSA id 0E1D55208E6;
 Mon, 28 Jan 2019 21:55:11 +0100 (CET)
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com,
	wens@csie.org
Subject: [PATCH 0/6] H6 Cedrus support
Date: Mon, 28 Jan 2019 21:54:58 +0100
Message-Id: <20190128205504.11225-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_125525_664052_E49EA2E2 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, robh+dt@kernel.org,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds basic support for H6 VPU. VPU itself has some new
features like 10-bit HEVC decoding, support for AFBC output format when
decoding HEVC and IOMMU. However, none of that is currently implemented.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (6):
  dt-bindings: media: cedrus: Add H6 compatible
  media: cedrus: Add a quirk for not setting DMA offset
  media: cedrus: Add support for H6
  dt-bindings: sram: sunxi: Add compatible for the H6 SRAM C1
  arm64: dts: allwinner: h6: Add support for the SRAM C1 section
  arm64: dts: allwinner: h6: Add Video Engine node

 .../devicetree/bindings/media/cedrus.txt      |  1 +
 .../devicetree/bindings/sram/sunxi-sram.txt   |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 25 +++++++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  9 +++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +++
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  3 ++-
 6 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
