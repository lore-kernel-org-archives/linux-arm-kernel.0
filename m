Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CD9222ED
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pn5Kf80q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CD9222ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=to2PArEPoUlDqbs1sWVqp3bymWxiahPXL79AHhBZOKY=; b=Pn5Kf80qj88AQ6
	3x6Wx/YjOO2gYE67N9tbSzCc2KfJIPKHEXccFzWMg92JaUiM5LvIpK/tCRFdjNlMbyZZua4nRcGCF
	8ncpeg0K4xpK6dg52qnTZUlCRD9i6yJZA5WMT0H+L3KJ2rRTiYVfnlDd5bTo1QFwhHKSRjIcueL+m
	cE6PG2neBqzgMHufGFYdrzl3DK8625DIvZ5njZBAvoF/anKEWXE2qJVz9JI7cAM8ULSWOqvfTMghu
	uGOlXBXWN5W+dCuMvCAcpuA06IJDc+Ma82TxHy8cXFLvjNN1fEsGUOcxnbYHIQmZr0FaPBcXCjj+n
	aDmu+Y3iI8atiVlusa9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvLN3-0007NM-LT; Sun, 17 Feb 2019 12:16:33 +0000
Received: from avasout06.plus.net ([212.159.14.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvLMq-000781-34
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 12:16:21 +0000
Received: from localhost.localdomain ([87.114.170.31]) by smtp with ESMTP
 id vLLzgM2tCHd2LvLM8gaQAQ; Sun, 17 Feb 2019 12:15:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FK01Odgs c=1 sm=1 tr=0
 a=IwDniP0DpuMObaUqJdRMiQ==:117 a=IwDniP0DpuMObaUqJdRMiQ==:17
 a=qyKJLktWOQhn6OkCE7gA:9 a=ltk_qqI1dF5I-_NL:21 a=Q6soJdELGrPS4MJB:21
From: David Summers <beagleboard@davidjohnsummers.uk>
To: heiko@sntech.de,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 1/3] ARM: dts: rk3288 Tinker Board (S) sdcard changes
Date: Sun, 17 Feb 2019 12:15:11 +0000
Message-Id: <20190217121513.22965-2-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfIW+p07NV00SDPjke0JokRGo/JUIiMUldPYL6vNcBNYI25W/O+aaQZDpkEE1XTcJ7pQYGS09Up9Bw6d9LnEM19gDMVktu6Knnv0OJSlvrAFc8zB3xuUo
 cIod8oRuTSrkBFAvs2DjA8ztNP1fRMkZjpFJ4u1wPAimV9sCFmxqCtxOEi5bT0jHXMvPk0vYHqfMfFQMaMSB+Tni4veflrX7OZ8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_041620_273076_9981213D 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: linux-rockchip@lists.infradead.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch makes some minor changes to how the sd card is
described in the device tree for the ASUS Tinker Board (S). In
particular on the Tinker Board S, when booted from the eMMC, and with
no card in the sd slot, and the log has endless messages about not
being able to detect the card.

Several methods to remove this error have been tried, the only one
that works is the broken-cd and so that is what is applied here.

Alas the ASUS schematic is not clear enough to indicate if the card
detect is wired up to the cpu, the schematic does not show internal
wiring on the Tinker Board!

Now this error didn't show up on the Tinker Board, as that machine
only boots where there is a sd card installed. However as the TB and
TBS are so similar it is expected that the Tinker Board also doesn't
have a functioning card detect. Hence the change here is made to the
dtsi file, so it applies to both TB and TBS.

The disable-wp is also removed, it doesnt seem needed on the micro
sdcard slots, and without thisn the card can still be written
to. Hence this flag is also removed.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 2b38075a2917..fceaeed44e34 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -432,9 +432,7 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;			/* wp not hooked up */
+	broken-cd;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
-- 
beagleboard@davidjohnsummers.uk


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
