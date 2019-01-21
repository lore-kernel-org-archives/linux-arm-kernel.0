Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4EC2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CCA20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o98b/AC6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="mI9oavZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CCA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rhqHNLeIWHsKf4vTnVff8txi5fX8WHXfTYY1Zoxlskg=; b=o98b/AC6waDTbF
	ALgUiE0PxLkPD69MbAu+uyN7UOzB2VZHzM4hMgJm9sHDGGgeKR/vz/PzlHeSU6ouVSZ7RG7c7DyuA
	v5/WBKYA5i5xamWhDWY8flYi14NdiVZ7SHtEDeHGXk3J0Ch392gEJFUHdgFDsVBIuJ4vfGxxRwK4D
	Ho48GfXFeCW/Yxk3y4aseMoYnESJ++62F3BKW9T4RVY3SVAGPyfPUz688+Te18HvyRZf+IyELD/jv
	Vrvp1Ud2Pcc0hkOwSaJShMgrm6+mKrXCd8XLYJ41puwJgENbSh2rLYRiMFTP+pA5JucNkgWsKHgCR
	eQkkIN/870nNESY5/5bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbtG-0000IJ-Az; Mon, 21 Jan 2019 15:53:34 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbtD-0000Hq-6N
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:53:32 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 502145C0231;
 Mon, 21 Jan 2019 16:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1548086008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=vgFqHtX8fjLIbergTlpat5cFh3/hh9idcGERWWcWmdw=;
 b=mI9oavZYjpa7ZfZdgDwMnc86XunWhHZ5g0P29oau/kGJA5WAhU5XZJNhWxppuLbMEJI/pk
 MoeVeG0utJiJ6Gqvs+q78fqzKqG1k8csfKepwN5B3JrcEkUVbA55SERAMxFv5wZjhc5LpX
 PktzjaBBfqiqLiEiYES/9B7/qoPTDK0=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH] ARM: dts: colibri: use valid range configuration for weim
Date: Mon, 21 Jan 2019 16:53:27 +0100
Message-Id: <20190121155327.12554-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_075331_379889_B5FE3B0F 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: marcel.ziswiler@toradex.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, max.krummenacher@toradex.com, dev@pschenker.ch,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A valid WEIM range configuration must specify range entries for
all four chip selects. This fixes an error on boot:
  imx-weim: probe of 21b8000.weim failed with error -22

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index f7bcc1181c4a..5ee2ddedd038 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -238,10 +238,11 @@
 &weim {
 	status = "okay";
 
-	/* weim memory map: 32MB on CS0, 32MB on CS1, 32MB on CS2 */
+	/* weim memory map: 32MB on CS0, CS1, CS2 and CS3 */
 	ranges = <0 0 0x08000000 0x02000000
 		  1 0 0x0a000000 0x02000000
-		  2 0 0x0c000000 0x02000000>;
+		  2 0 0x0c000000 0x02000000
+		  3 0 0x0e000000 0x02000000>;
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
