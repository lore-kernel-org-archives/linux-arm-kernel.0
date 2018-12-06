Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD68C20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R2JMV/vM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ospD2Ghq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD68C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=00wyZ1X7FD1giFAbhL/rE2OFEVkxk3qszlChKEiWMqQ=; b=R2JMV/vMMlM1CsLLl+8pzm4CJC
	EQMSz+3o+NuKUIxk2SEyK/zTKHtpk5rpyf0Ewv7KYnTsfebJzkoXy63pvpRxdLILmj+r0Vpr08zk7
	83p/OUee0G2OXMRm3LTH0TUMu5fwNIKUoRFXVP/M6MelxTJM8A3aGW/g75b3e5fft8i88zITBTEo5
	TAovmh8TTDeW8VhRM/+xTFwbHlSYgasmulBHAsSqCZY+YgpnmJaF4oVvCalsSgORZqaZ7rj1hxUnK
	7ANiylwCSxU5hdQSANfopR+iA1BD2k/klbZgOCI0jCQFXEpaAXesD3HlUmMrw2ztBLiruvTrBzIqr
	c2id629A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1fB-000885-EB; Thu, 06 Dec 2018 21:58:29 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1eU-00077Q-3L
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:57:52 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C688125B74E;
 Fri,  7 Dec 2018 08:57:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133455; bh=g4v0NrPCbHRH+qzbbL7G0UeV1RCBapeDvpZMwCkTJ2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ospD2GhqzJFdcVpM7Red1ztHhPvmP+hbJB3gR+rFviAhW+J/4XGD+zjtQM0XPNIPd
 JmlJ6Pl3aGt0HzWTD9bRlm0NADaTL1HXiHUyJzR4IWksiR2leuol7j7Sk1K/9XVy6/
 gAHEunN7VGECVftEt77ausiW7IqYewvyU8cu7t6A=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 7EE29E21D86; Thu,  6 Dec 2018 13:57:33 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: r8a77995: draak: Add backlight
Date: Thu,  6 Dec 2018 13:57:32 -0800
Message-Id: <4fbd4158fe8967e9296516ebae2cfaf7a1c7a214.1544126426.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544126426.git.horms+renesas@verge.net.au>
References: <cover.1544126426.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135746_767163_A7378E87 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the backlight device for the LVDS1 output, in preparation for panel
support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 48bb1d77744f..52d044b9f3f2 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -24,6 +24,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 50000>;
+
+		brightness-levels = <256 128 64 16 8 4 0>;
+		default-brightness-level = <6>;
+
+		power-supply = <&reg_12p0v>;
+		enable-gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+	};
+
 	composite-in {
 		compatible = "composite-video-connector";
 
@@ -104,6 +115,15 @@
 		regulator-always-on;
 	};
 
+	reg_12p0v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "D12.0V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vga {
 		compatible = "vga-connector";
 
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
