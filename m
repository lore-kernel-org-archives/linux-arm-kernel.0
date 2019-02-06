Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C63C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:20:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB582080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yru0lmWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB582080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GZOzItHTG9RpbfsnjaFmYfGXv327kJNCDJfKnMQ+w6w=; b=Yru0lmWwuUCMjc
	v13wSllRcm9k3ADsENvp2VAQXCBFCBdUC9NtXciQ3hIW9JJhY/8zU76CZxJzvcCQZvkvZBMbMh/ES
	wkFSC1duVFGxOlxNlx6rSYMV2Qv0Y9HjE4V97FOM2uj372E4cQ34La2yNjVAdKJOrxidPoKVHtjFJ
	rzmgEhujL1I6EXYj6YQgnTQ/6YU0EUlCxjQhWtL7uCmRKf86pQ7+tYIs+MrHArelGOh73rLZt7X4K
	4m9TSg5EqQDH1PPuY56oRKi9eqrmyak75y1r3zc94fNGB8jMNkfFbnprTDli3T9ZmzI0pB739VqGJ
	2H9aucoIy4sjj+bpfg+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grP0H-0006is-Jg; Wed, 06 Feb 2019 15:20:45 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grP0C-0006g6-3A; Wed, 06 Feb 2019 15:20:41 +0000
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x16FKXHe048702;
 Thu, 7 Feb 2019 00:20:33 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Thu, 07 Feb 2019 00:20:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from localhost.localdomain (119.104.232.153.ap.dti.ne.jp
 [153.232.104.119]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x16FKUuc048692
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Thu, 7 Feb 2019 00:20:33 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
Date: Thu,  7 Feb 2019 00:20:27 +0900
Message-Id: <20190206152027.8002-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206152027.8002-1-katsuhiro@katsuster.net>
References: <20190206152027.8002-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_072040_364831_351B6704 
X-CRM114-Status: GOOD (  11.63  )
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

This patch adds HDMI sound (I2S0) node and remove dma properties
from UART2 node for rock64.

The DMAC of rk3328 connected to 16 DMA sources. Each sources have ID
number that is called 'Req number' in rk3328 TRM. Currently, total
7 sources has been activated as follows:

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
use max 8 channels at same time. If I2S0 is simply activated,
required DMAC channels are 9. It does not work.

UART2 can work without DMA resources, so this patch removes 2 DMA
channel allocation for UART2. These released channels can be used
for I2S0.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 2157a528276b..e21645aa3fa5 100644
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
 
@@ -343,6 +362,9 @@
 
 &uart2 {
 	status = "okay";
+
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
 };
 
 &u2phy {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
