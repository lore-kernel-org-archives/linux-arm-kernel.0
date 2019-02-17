Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58379C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:17:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A60222E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qYd9rYHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A60222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Azuv6JRYouPHUuNXHA1sG6OK+e2s+cyQKmr2DwUWUI=; b=qYd9rYHB2b1hyO
	WPdevxCAHXD+U213WIytuxWXjuvg9dg6Q2Vhb6Z4PWX3pVwAIWD+V1V8G8tp7dOrj0pJj8BjJyhqE
	d+FAu73giRB/ih1MJzRenx5aWw9UU3w0d3at6kiaeTs+jkYFcsglM8TUWZioesAA25BR6aJmXe8VD
	KJMYd7d4ZFS/DzTOOG8Ut6gBS0lfUuU077OTVHPei4NE6Cy2Lv95H17tz+zi3NXrU/NqxvI/mJikE
	pVbvWrGQqE6/e8k3Wu34S31cDKTKr0D0PN9sCEymSL4ZpnRpTi461Ek9RSFEjLodYXSFp1iVl6cG6
	2g2nf9IxveeMyDKBhMVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvLNb-00081p-4e; Sun, 17 Feb 2019 12:17:07 +0000
Received: from avasout06.plus.net ([212.159.14.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvLN5-00078M-18
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 12:16:56 +0000
Received: from localhost.localdomain ([87.114.170.31]) by smtp with ESMTP
 id vLLzgM2tCHd2LvLMNgaQAy; Sun, 17 Feb 2019 12:15:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FK01Odgs c=1 sm=1 tr=0
 a=IwDniP0DpuMObaUqJdRMiQ==:117 a=IwDniP0DpuMObaUqJdRMiQ==:17
 a=X63dCvaKAAAA:20 a=TkpssyMGhm8DTbAZXSUA:9 a=NnB7W_RyFDSnDlNr:21
 a=n5Fje-ibHYVCOY7u:21 a=zA7_2-WrKBG-IMKZYL8h:22
From: David Summers <beagleboard@davidjohnsummers.uk>
To: heiko@sntech.de,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
Date: Sun, 17 Feb 2019 12:15:13 +0000
Message-Id: <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfKsWF66wGX/1ob0yUw6pZb1Ra+A7Mb3vvE0UNWPIhTnYXJPCQHrNK+z1j9v4p0vQcjNSNuG7JWq0sEtbSEhcrzLJInFj2vWBECkVi85a92z3OUw6l4Z1
 rBmKb6lRLfho7cV2svTVtLNv/STLEGdf8r1UavPww8viHMX65mVcj1498zYq/41Jmzvj8hj3TIBv1GRhJQuox1CRWL3eFOJVaX4hKiYApvpGpC57pAlnQmzM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_041635_693287_7E007B0F 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: linux-rockchip@lists.infradead.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch is to add Bluetooth to the ASUS Tinker Board (S) device
tree.

This patch is more contraversal - so probably view it as a request for
comments.

The reason behind this, is this patch does not currently set Bluetooth
working on the these boards. The problem is that the
bluetooth/hci_h5.c driver, that is used for Realtek serial devices,
depends on ACPI. Unfortantly ACPI can not be enabled on armv7 machines
such as the TB(S). And so the kernel module for the RTL8723BS
Bluetooth can not be loaded.

However this patch is believed to be an accurate description of the
Tinker Board (S) wiring. It is strongly based on the ASUS patch:

https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678

As the Bluetooth is connected via a UART and this is wired into uart0,
this has been described as a SerDev.

The ASUS patch mentions the UART_CTS, but not the _RTS. Now as the
RTL8723BS has both CTS and RTS on the uart, it has been assumed both
are wired into uart0 on the cpu.

The Bluetooth connection has several wake up pins both device and host
and a reset pin. The wiring of these has been described; however how
the kernel driver will use these isn't clear. E.g. should HOST_WAKE be
an interupt?

The main reason for asking for comments, is that when it comes time to
make the changes to the bluetooth uart code, and add compatible flags,
robh has indicated that this will only be accepted with a valid
example. So the code below is that example. So I would like comments
that this approach is valid, which can be used when the later
submission comes. 

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index e1796f340eef..931b4c652fdc 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -481,6 +481,17 @@
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
+
+	bluetooth {
+		clocks = <&rk808 RK808_CLKOUT1>;
+		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
+		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
+		vcc-18-supply = <&vcc_18>;
+		vcc-io-supply = <&vcc_io>;
+	};
 };
 
 &uart1 {
-- 
beagleboard@davidjohnsummers.uk


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
