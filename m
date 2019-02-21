Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8966A2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erO9QcMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8966A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GUXQHJJqURE8XANVuM5XB5/4dIK27d2nNvjhHDWqmZk=; b=erO9QcMVaV4zWJ
	vJWiPliBpGHzoYuyzF4LJCVYkjD/ClfdcrGdE3DybGYdClLV7mMSrMbW8jTyqaqjDCZm7rgBD6xF3
	r2FP6bV261tOThSy8rr1GUnqVwLjvNxZW6tyrLkVJGvwvdtQxxV0o8S4vLe0C3FioYQNbmGpdMvDF
	UOYJ1ZUlYh2OW+Ih/bkdbd2OVlALGg0uBLE+Ly8c+Hx/0d1QaG0Hw3lic5kdLIsVESw2bJ0Z0hwb0
	NsNOijNs8DbtWVp+zAV2XTDrFbpVcLoj7e0C0oMe38mJGSDC0XUwVMsYcTruoyHB05oYB2ZUwjb4z
	vmRLTxuXoPqI3VnG1Rqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwiio-0008R4-W8; Thu, 21 Feb 2019 07:24:43 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigW-0005ze-4R; Thu, 21 Feb 2019 07:22:26 +0000
X-UUID: 85807902aadf497aaffa842b04de74ff-20190220
X-UUID: 85807902aadf497aaffa842b04de74ff-20190220
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <louis.kuo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1520224167; Wed, 20 Feb 2019 23:22:06 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 23:22:05 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Feb 2019 15:22:03 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 21 Feb 2019 15:22:03 +0800
From: Louis Kuo <louis.kuo@mediatek.com>
To: <hans.verkuil@cisco.com>, <laurent.pinchart+renesas@ideasonboard.com>,
 <tfiga@chromium.org>, <matthias.bgg@gmail.com>, <mchehab@kernel.org>
Subject: [RFC PATCH V0 3/4] dt-bindings: mt8183: Added sensor interface
 dt-bindings
Date: Thu, 21 Feb 2019 15:21:57 +0800
Message-ID: <1550733718-31702-4-git-send-email-louis.kuo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550733718-31702-1-git-send-email-louis.kuo@mediatek.com>
References: <1550733718-31702-1-git-send-email-louis.kuo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232220_676587_3F17CA88 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: devicetree@vger.kernel.org, Sean.Cheng@mediatek.com, Rynn.Wu@mediatek.com,
 srv_heupstream@mediatek.com, holmes.chiou@mediatek.com,
 Jerry-ch.Chen@mediatek.com, jungo.lin@mediatek.com, sj.huang@mediatek.com,
 yuzhao@chromium.org, linux-mediatek@lists.infradead.org, zwisler@chromium.org,
 Louis Kuo <louis.kuo@mediatek.com>, christie.yu@mediatek.com,
 frederic.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the DT binding documentation for the sensor interface
module in Mediatek SoCs.

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
---
 .../devicetree/bindings/media/mediatek-seninf.txt  | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-seninf.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek-seninf.txt b/Documentation/devicetree/bindings/media/mediatek-seninf.txt
new file mode 100644
index 0000000..5c84a77
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-seninf.txt
@@ -0,0 +1,52 @@
+* Mediatek seninf MIPI-CSI2 host driver
+
+Seninf MIPI-CSI2 host driver is a HW camera interface controller. It support a widely adopted,
+simple, high-speed protocol primarily intended for point-to-point image and video
+transmission between cameras and host devices.
+
+Required properties:
+  - compatible: "mediatek,mt8183-seninf"
+  - reg: Must contain an entry for each entry in reg-names.
+  - reg-names: Must include the following entries:
+    "base_reg": seninf registers base
+    "rx_reg": Rx analog registers base
+  - interrupts: interrupt number to the cpu.
+  - clocks : clock name from clock manager
+  - clock-names: must be CLK_CAM_SENINF and CLK_TOP_MUX_SENINF.
+    It is the clocks of seninf
+  - port : port for camera sensor
+  - port reg : must be '0' for camera 0, '1' for camera 1
+  - endpoint : config mipi-csi2 port setting for each camera
+  - data-lanes : the number of the data lane
+
+Example:
+    seninf: seninf@1a040000 {
+       compatible = "mediatek,mt8183_seninf";
+		reg = <0 0x1a040000 0 0x8000>,
+		      <0 0x11C80000 0 0x6000>;
+		reg-names = "base_reg", "ana_reg";
+		interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT8183_POWER_DOMAIN_CAM>;
+	    clocks =
+			<&camsys CLK_CAM_SENINF>, <&topckgen CLK_TOP_MUX_SENINF>;
+		clock-names =
+			"CLK_CAM_SENINF", "CLK_TOP_MUX_SENINF";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				mipi_in_cam0: endpoint@0 {
+					reg = <0>;
+					data-lanes = <1 3>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				mipi_in_cam1: endpoint@0 {
+					reg = <1>;
+					data-lanes = <1 3>;
+				};
+			};
+		};
+	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
