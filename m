Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46E8204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mM2UM+jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46E8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zv9/p6R8FH8NM7fyzll2eQ+a2sPK+v8v3ZlhuOcgoJE=; b=mM2UM+jz9KcahV
	+HCmrfUn9xCZKQ6d40BJttuIH6tGEqheIGgrLHCXT+YuWcdF4Z06Cz0KGgDtZdIB3bnZGrc2OIThE
	t9ivDOfMZXPSixnTo+8ZjIY3z85EVDuqdY+Gca31TS2FDCXePjrYPGOk2vBYNJb7iLE3bst8aqTM0
	BrC71VxPJ4ENXHCtJmyCKPJVoRP5irnEJZabpPnbBkqGME7Sf7udiMjsQm2KxWSBdEZ52wIqjXt74
	ARWfUWW1GmlsdNcfRImwQ8GdOXZegkK3oRx8ohNdz4vTvGDa4y0tArdd2kvAEpzYwUPHkZR9DvET7
	98wyel2OEnRVmh5KU4kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb0ie-0001wp-V8; Sun, 23 Dec 2018 10:10:48 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb0iY-0001kw-LE; Sun, 23 Dec 2018 10:10:44 +0000
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBNAAUBL079349;
 Sun, 23 Dec 2018 19:10:30 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sun, 23 Dec 2018 19:10:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp
 [153.232.38.183]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBNAARd8079332
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sun, 23 Dec 2018 19:10:30 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: enable analog audio node for rock64
Date: Sun, 23 Dec 2018 19:10:26 +0900
Message-Id: <20181223101026.12998-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_021042_947348_A25E911E 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Rock64 boards has analog audio jack on it. RK3328 can output
analog audio signal using I2S1 and ACODEC core.

This patch adds sound node for analog audio for Rock64.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---

This patch depends on the following ACODEC node patch. If ACODEC
patch is not good to you, please drop this patch too.
  https://lkml.org/lkml/2018/12/23/53

 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index bd937d68ca3b..0a71e1287a1b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -66,7 +66,8 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
-		dais = <&spdif_p0>;
+		dais = <&i2s1_p0
+			&spdif_p0>;
 	};
 
 	spdif-dit {
@@ -81,6 +82,17 @@
 	};
 };
 
+&codec {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	port@0 {
+		codec_p0_0: endpoint {
+			remote-endpoint = <&i2s1_p0_0>;
+		};
+	};
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -243,6 +255,19 @@
 	};
 };
 
+&i2s1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	i2s1_p0: port {
+		i2s1_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&codec_p0_0>;
+		};
+	};
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
