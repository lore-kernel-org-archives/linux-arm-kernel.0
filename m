Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA02FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:34:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C57B214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vDh3w2Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C57B214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sdk33QRRU6AdwnLVmJRT1jITps381q+8IPRgqM17De0=; b=vDh3w2KrksCa89
	GXXAxCKR3XpTSUlJJPhXH3gHp1Xis2Sv3KU8IMGTJ1cJCL54dRv0nWcv0pXtcIAm8X8ITZK9ZLL7n
	cxeNlUvWzRTzsRJcBYnlMD08EvHJ4tgdmYLzs7hf6lvXtSzIrIRaN8eogZ6yg411I5fjfmDHfYfu1
	jaCpFJalKyEOb9p4ZJjy3mIkW0N7VSV+EFJS/V2fc+P3ipAiBDWyX4EyzqH8SALweXLKMDVLutZC8
	6PbEfdkTVI6p4LSoMMkdzuArUYo6FpdM+5HyntzcIAGMP8EN7t9lx66dPQJ0fq0r7JTJ76hUnQYpe
	zdHEC34L4SAIjwau+WVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvQKh-0007ZO-4l; Sun, 17 Feb 2019 17:34:27 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvQKV-0007OD-12; Sun, 17 Feb 2019 17:34:16 +0000
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1HHYBai095904;
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp
 [153.232.104.119]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1HHY8YE095893
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Mon, 18 Feb 2019 02:34:11 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Date: Mon, 18 Feb 2019 02:34:07 +0900
Message-Id: <20190217173407.29189-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217173407.29189-1-katsuhiro@katsuster.net>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_093415_392281_4E15B33F 
X-CRM114-Status: GOOD (  12.56  )
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

This patch adds HDMI sound (I2S0) node for rock64.

After apply this patch, UART2 will fail to allocate DMA resources
but UART driver can work fine without DMA.

This error is related to the DMAC of rk3328 (pl330 or compatible).
DMAC connected to 16 DMA sources. Each sources have ID number that is
called 'Req number' in rk3328 TRM. Currently total 7 sources has been
activated as follows:

| Req number | Source | Required  |
|            |        | channels  |
|------------+--------+-----------|
| 14, 15     | I2S1   | 2ch       |
|  6,  7     | UART2  | 2ch       |
|     10     | SPDIF  | 1ch       |
|  8,  9     | SPI0   | 2ch       |
|------------+--------+-----------|
|            | Total  | 7ch       |

HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
I2S0 can work concurrently with other sources, but rk3328 DMAC can
use max 8 channels at same time. If I2S0 is simply activated by this
patch, required DMAC channels will be 9. So last one (UART2) cannot
allocate the DMA resources.

Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
problem.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 2157a528276b..bfc0930d245c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -68,7 +68,8 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "rockchip,rk3328";
-		dais = <&i2s1_p0
+		dais = <&i2s0_p0
+			&i2s1_p0
 			&spdif_p0>;
 	};
 
@@ -141,6 +142,12 @@
 
 &hdmi {
 	status = "okay";
+
+	port@0 {
+		hdmi_p0_0: endpoint {
+			remote-endpoint = <&i2s0_p0_0>;
+		};
+	};
 };
 
 &hdmiphy {
@@ -256,6 +263,18 @@
 	};
 };
 
+&i2s0 {
+	status = "okay";
+
+	i2s0_p0: port {
+		i2s0_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&hdmi_p0_0>;
+		};
+	};
+};
+
 &i2s1 {
 	status = "okay";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
