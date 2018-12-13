Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82799C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF9E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ISTt+022"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF9E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ecRO0irsaF9cc+913QTbyC3KDDUvMatnlTKwzBBGJbg=; b=ISTt+022BJJ+Sw
	TssWLl3bC+jjAwnTtWexqvDNoAdtj6bKTN9xB9rL7Vt3zFI4/83j4iHHrmRGyqRC12u2mrd56ERUs
	Q4gJzrTvkiscQF96yLftH6w4YJeZyfq5Sb8pHX3kht2CQB+P8/6eu+9gYkTEPr7whPuP6zm0WIFRZ
	V2Whav3z3gHdsZRZ38LC8xNGOh/m4Rh3JFIHTe33KkBXfMfzSiD6pZGOaK/Vw34n5Kl5xwH5Rurmi
	ClpNZCDAX2UbdYYFGyouEAnEADwWzY4ffTeJur6o6jLaLLf4EZdl6iS9kra8UP3CEuIfbIm1Yh1x7
	9EeX345eIcDtbPJsKt0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXa1w-0008NH-1c; Thu, 13 Dec 2018 23:04:32 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXa1s-0008MC-Er
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 23:04:29 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 0EE918167;
 Thu, 13 Dec 2018 23:04:18 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: Configure wlcore wakeirq for pandaboard
Date: Thu, 13 Dec 2018 15:04:10 -0800
Message-Id: <20181213230411.5009-2-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213230411.5009-1-tony@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_150428_547617_09BC0601 
X-CRM114-Status: UNSURE (   8.38  )
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
Cc: devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With wlcore supporting optional wakeirqs, we can configure it
for pandaboard. This makes ssh connection usable with the SoC
entering deeper idle states.

Note that pandaboard already has a wakeirq configured for SDIO
dat1 pin although that is not currently used by wlcore.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -485,8 +485,10 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 53 */
+		/* gpio_53 with gpmc_ncs3 pad as wakeup */
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_RISING>,
+				      <&omap4_pmx_core 0x3a>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <38400000>;
 	};
 };
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
