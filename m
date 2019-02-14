Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C82C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF29222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sEjmogcE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp3DN4br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF29222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PVWq4LChk2+nllAve8Kj0Y9Hi+6REKaqm5izuBS6tC8=; b=sEjmogcEILrNHYHKUGioEO5vuF
	WK6EZMM1Y5VTS9MnhEXNhQZuk0PxOl02olrry/VT5+VhYERImI/Q7XNTXQp20lws0X1bZ15Xoa/5M
	b0qSGlcspz2fBDy0PBuY9k/Y4GERSS64lIGvCcCL2YxJCqqEPqeSvMg03pn37IOWdsLeg++JgFGGi
	vKcFSZkYo9V1rO+kAJPbQj/9fGbt8c9cBMZQbvu1kTK38hIdKWCp64HxhIQ4AT0MxfSapoDpQPETN
	yAov4Zj+sz2gMLiBa3MsucNfPzvkdGZBdsYzlo450o/mPi5UVcSRe6yoXRP7hEMz8O7+4pDCaIMaA
	xP44inNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGlf-0001Xn-B8; Thu, 14 Feb 2019 13:09:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGlW-0001JB-VN
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 13:09:25 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so3043157pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 05:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0v9wVQ3xaGBLf3TQlCnHEwdgsZp+XVStp3m7EDnD+N8=;
 b=Jp3DN4brMf4mZx4wDp3V4QNwlJvaOnGrID+tjX5gtyZlibgtU/rEPVD2L06mULeqpQ
 7vEs4MaEizzqu3pwPD8pDKVAtFDCrZymkUAW24gBhdIkdCWqsMKfkWaTvgc+UOd9JiKR
 2bMPoSGuqpzitElBDZiRmkwKOerBTXbeFg7ItSCEQLS5/jf/lZyQs1we3s2SmCFHS71S
 PZEYRQzKQfGuMeWjfj4d34MvWJKZahtrRKKTmi6n29QPPckcmd+AAOlDIni1LCKLPwdX
 b2G9ksplq3AOKman6glzXuecP7LFleexwpJbhqVUJ4iozuN4SirsRYjzyx1DwKa4/MJ0
 +dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0v9wVQ3xaGBLf3TQlCnHEwdgsZp+XVStp3m7EDnD+N8=;
 b=JhTZr/zHgzLV2wlfecbN8TlOvvB3UzVG7LV3efkdbNiWUC1lbaFtj/Wt8FPtf+p8IJ
 Whn4ZqYVile98OqZKKQA8w9h9ESTlXbDcDjGWg66/uBxm4twxyHos55nViqD3McVAAeY
 4KQbQ3isQbqTOquDL2kKlXbMY2zhmMasMPvN4L9AfuO1T1nh9cUR3puskuHZS1V16d0b
 yODk+Cq8nWruxGfGH8pO+RTtdo1M92DDY6uosnBe90IwPOTQsNydTjpz0Zcfqyb1+ubs
 zGX9IRZeMnwOHQpdPYmiOS9+Nq0HnjmsiWi8x8u145rnHxlaPAM/jG7myf4eGRDMNGnO
 WVZA==
X-Gm-Message-State: AHQUAubPyna2UleHOJdjPqaERDFJ0PlyV+LrPVEN4JjENvTlcz84ooK+
 D2jQKx9TmdZBiuWueAa2kgA=
X-Google-Smtp-Source: AHgI3IZFbl5j8qM5LeBkq0v6BKUCQd5a5Q9vNWiXIvgGz1wlVK2PenecD63p/+Y1tRe97hHC+bi89w==
X-Received: by 2002:a65:6549:: with SMTP id a9mr3598261pgw.21.1550149762462;
 Thu, 14 Feb 2019 05:09:22 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id u2sm2999992pfh.134.2019.02.14.05.09.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:09:21 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com,
	wens@csie.org,
	robh+dt@kernel.org
Subject: [PATCH 1/4] arm64: dts: allwinner: h6: orangepi: Add CPU supply
 regulator
Date: Thu, 14 Feb 2019 08:09:07 -0500
Message-Id: <20190214130910.9201-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_050923_129567_86C8BA28 
X-CRM114-Status: GOOD (  12.98  )
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
 Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original orangepi use the dcdca to supply the CPU cores. According
to the axp805 spec, the range of dcdca is 0.6 to 1.1v, 1.12 to 1.52v.
In order to support more CPU frequency, slightly increase the voltage
maximum and minimum.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index b2526dac2fcf..e7aebaf91ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -159,8 +159,8 @@
 
 			reg_dcdca: dcdca {
 				regulator-always-on;
-				regulator-min-microvolt = <810000>;
-				regulator-max-microvolt = <1080000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -191,6 +191,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
