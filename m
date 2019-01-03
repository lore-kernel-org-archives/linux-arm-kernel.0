Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D890C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C79D2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMDjAU+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C79D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rIfce/E5D+bVNwZcMV15GE63wzrMNqbCr1fh14raHvA=; b=cMDjAU+93IFJZv
	ojpfCHV7e+K1F56Cnos8kc7qQM6/DVDroN4rEerI9PxhthKjSSvLbiGA7XAt1mrk4WrruqTvpUW2l
	x2pdC5sUAsFEY0fGZv3LmpzDn59DrWkpSncNS7GnVlKZHq3LodPsbd4hykqZm2sFXBucihJor7B/w
	aRG4oMLS9W/0U/vlsPDsJB6gjN+EAcur5N6Gj9BjSb9X0OILL2bZwz663wF3Emr+tBUuL7TaJ+rnk
	QLiwD1c3SGLS/19ohPcwQ2J4E0+bNs7zYnx7hsBtBpw9LG0bS+Jj/2142h65zDe5lwZoSVI51ZGxF
	JFfCdTdjHZYDxePMQsLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5zY-0003W5-Lm; Thu, 03 Jan 2019 16:37:08 +0000
Received: from avasout03.plus.net ([84.93.230.244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5zN-0003Mx-Jz
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 16:36:59 +0000
Received: from localhost.localdomain ([87.112.196.180]) by smtp with ESMTPA
 id f5yHgSh7KimnMf5yRgALVK; Thu, 03 Jan 2019 16:36:09 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CoqRjEwD c=1 sm=1 tr=0
 a=Y1wGFK3FhPvFCcGACwKsaA==:117 a=Y1wGFK3FhPvFCcGACwKsaA==:17 a=ag1SF4gXAAAA:8
 a=OE3fWgKIv0mTuvs3W8IA:9 a=QAsrkg2CaESh2Yvt:21 a=3fakuoe7C_Kcefeu:21
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-AUTH: davidjohnsummers@:2500
From: David Summers <beagleboard@davidjohnsummers.uk>
To: marcel@holtmann.org, johan.hedberg@gmail.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATCHv2] Description of the realtek bluetooth device tree hooks
Date: Thu,  3 Jan 2019 16:35:37 +0000
Message-Id: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfKyYh3KwvVeg/SYQnk+srzCGvbXf0hDWYxtR5u3FmJWhvt6Xx7YkMeyGd0EcMXosAwDGsOYqofbRZAOcbrEYoAR5jDuptiTPNYZDWaLMwUIPJWQrOul9
 NRzA709LRAGJqGcpbr5GxPHVny77uVxGTKUppzNs0cXVZ7M8eEXCrYSzDlARdCiDDjeM4679T4xsgQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_083657_804208_66913AD5 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: linux-bluetooth@vger.kernel.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the desrciption file that describes the hooks for the
realtek bluetooth serial devices, as needed to refer to the interface
in the device tree.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
new file mode 100644
index 000000000000..0aabca1fc002
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
@@ -0,0 +1,28 @@
+Realtek bluetooth devices connected via a UART
+
+- compatible: should be "realtek,<name>-bluetooth"
+  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
+       "realtek,rtl8723as-bluetooth"
+       "realtek,rtl8723bs-bluetooth"
+       "realtek,rtl8723ds-bluetooth"
+       "realtek,rtl8761atv"
+       "realtek,rtl8821as-bluetooth"
+       "realtek,rtl8821cs-bluetooth"
+       "realtek,rtl8822bs-bluetooth"
+- These device are bluetooth devices, that connect via a uart
+- all devices (except for rtl8761atv) are also wifi devices, this is connected
+  seperatly via sdio - and is not covered by this compatible node
+- ideally these will be referenced in a device tree serial node via serdev
+ http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
+
+Example:
+
+&uart0 {
+	status = "okay";
+       	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
+       	bluetooth {
+               	  compatible = "realtek,rtl8723bs-bluetooth";
+       	};
+};
+
+this ensures that the bluetooth device is tied to the correct uart
-- 
beagleboard@davidjohnsummers.uk


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
