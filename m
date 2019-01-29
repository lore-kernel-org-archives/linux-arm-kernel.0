Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0ACC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFC620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p8PsSqxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFC620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cfpWRYXf3EpeidgjWOaxShlep22a86nTIntkHpGu6iA=; b=p8PsSqxbD4BFx6
	4QpC3234HnwZwfLEejk1jcGfoqnJYql4onA6TqnMSHeGSbDSa2G/+1lLheTEwTPsh76qfh8gvQFhF
	+Z3yDM9WLwHpy4k5Q0FTYo6fL0a0wC/f+3Op/jy6yNarqJRmqW038Z02tUt9clchJAk+SgAmfWQ6V
	E0HOix4k1QeWvbyxV/yS/C4DVw+4Dwu3odhvoy9LK7+jydivewZTz+LMyXWN4OR6E+GsnOkhom3pV
	h28laa/iCasmVobQ/GfIUJdNh8nasTRG69YLotFWydQw0GllUqcQ19+OKecRMZdIF7M4BlXk2npYz
	2Ckgy7EoZUcM9yFIxoQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYyl-00042I-H8; Tue, 29 Jan 2019 19:23:27 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwV-0001pq-Ip
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:10 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 6858043EF2F;
 Tue, 29 Jan 2019 19:21:02 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 11/13] ARM: dts: lpc32xx: ea3250: beautify gpio keys children
 nodes
Date: Tue, 29 Jan 2019 21:20:47 +0200
Message-Id: <20190129192049.11223-12-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192102_449457_09F698E6 
X-CRM114-Status: GOOD (  10.95  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192102_449457_09F698E6 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Regarding the 'gpio_keys' device node a dtc reports a couple of
warnings:

  Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary
  #address-cells/#size-cells without "ranges" or child "reg" property

  Warning (unit_address_vs_reg): /gpio_keys/button@21: node has
  a unit name, but no reg property

The change fixes these issues and adds empty lines between adjacent
children device nodes. The device node itself is renamed by substituting
an underscore by hyphen to follow the standard naming convention
of device tree nodes.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc3250-ea3250.dts | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/lpc3250-ea3250.dts b/arch/arm/boot/dts/lpc3250-ea3250.dts
index ef6b3e74cd9f..f46a11827ef6 100644
--- a/arch/arm/boot/dts/lpc3250-ea3250.dts
+++ b/arch/arm/boot/dts/lpc3250-ea3250.dts
@@ -23,56 +23,64 @@
 		reg = <0x80000000 0x4000000>;
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
-		button@21 {
+
+		button {
 			label = "Interrupt Key";
 			linux,code = <103>;
 			gpios = <&gpio 4 1 0>; /* GPI_P3 1 */
 		};
+
 		key1 {
 			label = "KEY1";
 			linux,code = <1>;
 			gpios = <&pca9532 0 0>;
 		};
+
 		key2 {
 			label = "KEY2";
 			linux,code = <2>;
 			gpios = <&pca9532 1 0>;
 		};
+
 		key3 {
 			label = "KEY3";
 			linux,code = <3>;
 			gpios = <&pca9532 2 0>;
 		};
+
 		key4 {
 			label = "KEY4";
 			linux,code = <4>;
 			gpios = <&pca9532 3 0>;
 		};
+
 		joy0 {
 			label = "Joystick Key 0";
 			linux,code = <10>;
 			gpios = <&gpio 2 0 0>; /* P2.0 */
 		};
+
 		joy1 {
 			label = "Joystick Key 1";
 			linux,code = <11>;
 			gpios = <&gpio 2 1 0>; /* P2.1 */
 		};
+
 		joy2 {
 			label = "Joystick Key 2";
 			linux,code = <12>;
 			gpios = <&gpio 2 2 0>; /* P2.2 */
 		};
+
 		joy3 {
 			label = "Joystick Key 3";
 			linux,code = <13>;
 			gpios = <&gpio 2 3 0>; /* P2.3 */
 		};
+
 		joy4 {
 			label = "Joystick Key 4";
 			linux,code = <14>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
