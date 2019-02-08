Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB72C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B92520857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f9+DwZJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B92520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FHOXAdVV95bvvgfU38CRyeL9T/yubrD/dXKf3b9TWwU=; b=f9+
	DwZJeF8qIipArcdcSoLZEPP7WFuonRNYPO9NT/jHI1RsM5jNbVB5QqepD2yOwU661bU7Mp50eAs/8
	TRnVva7H8JBune7r9IEhpOagsCLr131GXW5Urm6FcKJZis4qg98y9jU9QJqcEIWwT8Z06fVm2At+E
	Ga0UJt1opVjyqLiL1BDSbJM8mFXqeP3WhC4OTdOcgSIvnjUObScwmESXg/Qdgx0QoMqvzLuanh9m4
	qCMG4SxyEwxmZVYzr52m+icm1cY3FDAtpHAqKWqFhBHNYGScs4CNvLGI//wF/2NHXyYrEZKRPoVoE
	LXMoHP2ZTZYedYLh6sL9QHGUit0dH6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Fj-0000T3-Ax; Fri, 08 Feb 2019 12:27:31 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5F0-0008DI-5b
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:27:03 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 08 Feb 2019 21:26:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6C62F180D62;
 Fri,  8 Feb 2019 21:26:45 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Fri, 8 Feb 2019 21:26:45 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 4FAA31A04E1;
 Fri,  8 Feb 2019 21:26:45 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 380C51202F1;
 Fri,  8 Feb 2019 21:26:45 +0900 (JST)
From: Sugaya Taichi <sugaya.taichi@socionext.com>
To: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
Date: Fri,  8 Feb 2019 21:27:29 +0900
Message-Id: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042646_867188_D034860E 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DT bindings document for Milbeaut serial driver.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
new file mode 100644
index 0000000..8f61c38
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
@@ -0,0 +1,21 @@
+Socionext Milbeaut UART controller
+
+Required properties:
+- compatible: should be "socionext,milbeaut-usio-uart".
+- reg: offset and length of the register set for the device.
+- interrupts: two interrupts specifier.
+- clocks: phandle to the input clock.
+- interrupt-names: should be "rx", "tx".
+
+Optional properties:
+- uart-flow-enable: flow control enable.
+
+Example:
+	usio1: usio_uart@1e700010 {
+		compatible = "socionext,milbeaut-usio-uart";
+		reg = <0x1e700010 0x10>;
+		interrupts = <0 141 0x4>, <0 149 0x4>;
+		interrupt-names = "rx", "tx";
+		clocks = <&clk 2>;
+		uart-flow-enable;
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
