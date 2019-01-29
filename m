Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC9DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31362087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJ0juYMk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvnCTxky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31362087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CS5b/8oSkyg/ilhkmmkADSSVDKyCIJzAfB47gZK49ng=; b=SJ0
	juYMkC9XKeW16IYeectingnx9rzr4L9SJgcOmkTZ/qYtvKSUlEzj/YjGPx0PeiEHvJBr9nbNb7E2c
	CMOf282+F14e0MlByWfFATNoz9jM1Y3SvRz4psqeD3lABfwOPV3xXBc2dwMb5a04fjQy0+wDmB09t
	Spd0XevP5SbMFhaO5IrSj6KquKG8MDOH0FzxMg/q3TTcd3iSkS7t1o5ulUxtfDQg4U4QRX+aVxdNo
	US5qdGx3ELbUuE12x/lKoBaxIPmZ0UiI8fj+4j3krWvOayc5gs6JCOHgxCuDKVZr11bIDMMxKAnoa
	vyErBVsibCoN9lcl7CqxISYFf+Z7Luw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZh9-0006T7-J4; Tue, 29 Jan 2019 20:09:19 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZh7-0006Sb-Bj
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:09:18 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so19245261wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=P7uVknH6a2Lm+ESxiJyN8q2dm02UOXfATTairwfK400=;
 b=nvnCTxkyC8qHHud/LHMJZcH7o5qtNZfushQ0ji7K5vDUOBEq7lR3UY8DdLwjdzWa3B
 1sm4PNCqgWa6UW+8otsQCRoJqrlnjCan34yEkHEJi1AkQ87lWgjKnN9kH0HmozJw2HhB
 C4zl83U7rLyI1oUogUSnFxb3hx+ayEYbgIeCCDPdj90TO1rq9zrpmxBm2NJE6ajiBIUf
 lo0TVis7hFLwvm3jpcBU7MtqIqibdNGKzCwzC498GLfmVa2OrPrUY3/Zu3kn2xpPe8+X
 yE3RUB3JAhM7m9R58rZa7DGJLRCRxnc+JaDjqKGE8b5qfn/wasrT1Hrqv1wYyGywBMBi
 yc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P7uVknH6a2Lm+ESxiJyN8q2dm02UOXfATTairwfK400=;
 b=kYsGUceOV+k8ocwnR1bw/tQtnWAldqm9tVmBmzpNHVqBADVy9Jqk7PldvsYOaYBjlm
 cvLjL9BQZkOEna/G3cqh/55zaiDNE3/KNNAd+BoeCVeyDeTtPXk27D0oTsme6oKFSJ37
 QbX0fH/0jeC4lpLtSlz9IdysRlDIewU2pcBrxmI736m+OhDqM7cYpJ+MhyzgJp891KP5
 7BQz9UtH8GEMbozE40KJH9uLl1catBh8hAr72RBymmp0kSuZz2B9DYbYAhMYwvTVey3P
 KaJwSIwnmWTa2g5xjMpzHS26u6H3o8c/zTFojHDsp5Z6NudQ+/vqpC2SgT28YymFivWY
 ZL+Q==
X-Gm-Message-State: AJcUukexSLDPTpd2tjNaYLxXJMDxy8iFZo910R58Gy0zbI/YvAKJnCFL
 eFoKL9iLbFCIFLPSszqMobU=
X-Google-Smtp-Source: ALg8bN5DuFtprYmvcsaJ7ebhyaOqIHffPOA+BEFzkHnf4qwnam+Hcb21/mFU85z/wTkdBjSqVD2iwA==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr23364527wmd.36.1548792554022; 
 Tue, 29 Jan 2019 12:09:14 -0800 (PST)
Received: from ubuntu.home ([2a02:8071:6a3:700:8c22:ee0c:efc8:ed86])
 by smtp.gmail.com with ESMTPSA id w10sm4279020wmb.1.2019.01.29.12.09.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 12:09:13 -0800 (PST)
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
X-Google-Original-From: Simon Goldschmidt <goldsimon@gmx.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH] ARM: socfpga: fix base address of SDR controller
Date: Tue, 29 Jan 2019 21:08:58 +0100
Message-Id: <20190129200858.19773-1-goldsimon@gmx.de>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_120917_418762_5A5C813F 
X-CRM114-Status: GOOD (  16.64  )
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
 Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>

The documentation for socfpga gen5 says the base address of the sdram
controller is 0xffc20000, while the current devicetree says it is at
0xffc25000.

While this is not a problem for Linux, as it only accesses the registers
above 0xffc25000, it *is* a problem for U-Boot because the lower registers
are used during DDR calibration (up to now, the U-Boot driver does not use
the dts address, but that should change).

To keep Linux and U-Boot devicetrees in sync, this patch changes the base
address to 0xffc20000 and adapts the 2 files where it is currently used.

This patch changes the dts and 2 drivers with one commit to prevent
breaking the code if dts change and driver change would be split.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

 arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
 arch/arm/mach-socfpga/self-refresh.S | 4 ++--
 drivers/fpga/altera-fpga2sdram.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f365003f0..8f6c1a5d6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -788,9 +788,9 @@
 			reg = <0xfffec000 0x100>;
 		};
 
-		sdr: sdr@ffc25000 {
+		sdr: sdr@ffc20000 {
 			compatible = "altr,sdr-ctl", "syscon";
-			reg = <0xffc25000 0x1000>;
+			reg = <0xffc20000 0x6000>;
 		};
 
 		sdramedac {
diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
index f2d7f883e..bd7759357 100644
--- a/arch/arm/mach-socfpga/self-refresh.S
+++ b/arch/arm/mach-socfpga/self-refresh.S
@@ -19,8 +19,8 @@
 #define MAX_LOOP_COUNT		1000
 
 /* Register offset */
-#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
-#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
+#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
+#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
 
 /* Bitfield positions */
 #define SELFRSHREQ_POS                  3
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index a78e49c63..30767c254 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -30,7 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
-#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x80
+#define ALT_SDR_CTL_FPGAPORTRST_OFST		0x5080
 #define ALT_SDR_CTL_FPGAPORTRST_PORTRSTN_MSK	0x00003fff
 #define ALT_SDR_CTL_FPGAPORTRST_RD_SHIFT	0
 #define ALT_SDR_CTL_FPGAPORTRST_WR_SHIFT	4
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
