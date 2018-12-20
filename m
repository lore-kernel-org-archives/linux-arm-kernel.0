Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0521FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82A1218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLiePxyH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkwa31It"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82A1218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yPlqxS8ZkP31Dblq47ICdscuJVHdF8XtlQ8OXHy6eYw=; b=bLiePxyHbos+O7pWQZu7KwaLmM
	q5qnVU3/birJARI+87lbc+kvyyDtBB3QasT8vdY63r+2JDWYfZe6FtxX04DNXtl7CnxFJGKoAc5QO
	OO10xUZm+xvJEUbIGdQuhWi3A/9fH+2NmrkZ+nt7svMJ/awCvm0zxhrR/B0+dszSxs+PzrrWSh9l+
	jHSIOVY5T8rbuFi2PXchbaAbimDYAoH2V8bbhGk8kNSK4dCWbi4iLhgfpoQ9GxepWIrcKZNqHNn3P
	4jxnQdemaM8dvZod8ppOfIut942hdeDzt2KVOfv5XQhk8YNHANIUvpgkDVBl/7qFdvM0SMm6SNk4E
	8uWQabPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5HR-0008CO-7a; Thu, 20 Dec 2018 20:50:53 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5Gx-0007Z7-9h
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:50:24 +0000
Received: by mail-pg1-x531.google.com with SMTP id j10so1431011pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W0ODiBCwrHpbgCJ5wuLLPh+VEcu6MXeBYtzHrt7UrQY=;
 b=Nkwa31ItnU1F1jsCGDGl08mGOytMHbjBsBK6oJ7+aTdt3fenHbchBx9xz8zPH8euuO
 ap15jWfj1f08vofasjwU8aIz8OQ6GRpfeHOcgX41mFVoHKkRjFliWTJP9/56LSU8D1AW
 c+KlBUbBrgH/Ui4unngvyks1MPankt//3wToUGYgO9kv4oMPbqBcbMi3FWOwZyGAK6Ss
 ePC5gqPKvMeDui5vNcar8POutCqWqRAovBpc1w0qgtlgyVGKd+4YNhMh3kmTiWZkg9sF
 Ui3ecbrHmfqOPIiJca3/Qz08V6/Hww2X646Az9n9ktZoASoC3+p+69MUB+xIUi+S9ZIK
 J+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W0ODiBCwrHpbgCJ5wuLLPh+VEcu6MXeBYtzHrt7UrQY=;
 b=aj8h73cgckM6LaaI9JTIlc6EGZ+IAt1+QtqDvv4qBIy4mRN/vhCu1L0UXe17kKUCA0
 aWTHDNHxpQxO8yhlL3lx5KGNvmN+SKX3GKzGMI9IKsrMjcv2TLM/8D4Nhrmwzl99DoDn
 agY9zMw1O7xPcyP+QJ4VLSDlAnd3mLi8zoKVYq1q74YhQpKBuOhdjYc2QgYxLTseu2Nb
 pYWGu8I/Xq1stK283X6jnsa+HBT8FiHMVvC1HIql70+3q3BVdRy667+mzLAmr3QkQow7
 J4KkAEEXrHAbjXWLYVtrE6q/cE/qmbjHBKocNAokr0JFe8YwpD/ST/8fDSOGgr0rH8mu
 qymA==
X-Gm-Message-State: AA+aEWaMht0XRS5a5TQGF9OJ+/yZk8KWLySh2743bB1of7t9sBvzBBjJ
 4qrOpQYOW/fdyBLiElCjuls=
X-Google-Smtp-Source: AFSGD/VozfJTBwcBTNuEH5AUcI+InFT/uXZcAsiTMyL6Y4vujqn/TDHkzvfx4VQprHmtU8H7JVnGBg==
X-Received: by 2002:a63:c503:: with SMTP id f3mr23605700pgd.431.1545339012418; 
 Thu, 20 Dec 2018 12:50:12 -0800 (PST)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp.
 [118.155.13.174])
 by smtp.gmail.com with ESMTPSA id r4sm50924003pgn.54.2018.12.20.12.50.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 12:50:11 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Create thermal zone to
 support IPA
Date: Fri, 21 Dec 2018 05:49:42 +0900
Message-Id: <1545338982-19466-4-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
References: <1545338982-19466-1-git-send-email-ykaneko0929@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_125023_395564_DF5C350D 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Dien Pham <dien.pham.ry@renesas.com>

Setup a thermal zone driven by SoC temperature sensor.
Create passive trip points and bind them to CPUFreq cooling
device that supports power extension.

In R-Car Gen3, IPA is supportted for only one channel
 (on H3/M3/M3N board, it is channel THS3). Reason:
  Currently, IPA controls base on only CPU temperature.
  And only one thermal channel is assembled closest
  CPU cores is selected as target of IPA.
  If other channels are used, IPA controlling is not properly.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[takeshi.kihara.df: fix W=1 dtc unit_address_vs_reg warnings]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index b2f606e..c37ba9d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -66,6 +66,10 @@
 			power-domains = <&sysc R8A77990_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <277>;
+			cooling-min-level = <0>;
+			cooling-max-level = <2>;
 		};
 
 		a53_1: cpu@1 {
@@ -1760,11 +1764,24 @@
 	thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-			thermal-sensors = <&thermal>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 0>;
+			sustainable-power = <717>;
 
 			trips {
-				cpu-crit {
+				threshold: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				sensor1_crit: sensor1-crit {
 					temperature = <120000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -1772,6 +1789,11 @@
 			};
 
 			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&a53_0 0 2>;
+					contribution = <1024>;
+				};
 			};
 		};
 	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
