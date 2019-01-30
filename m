Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81DAC282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:45:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8865321473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnIIlqJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a95pNU9i/FfOJDuN4oivgPDYSfAW/+3QtxnDFzbVgJk=; b=tnIIlqJd+R5waA
	Wh/Q9mMsjc6Ff0rHPHMdgXGUT1yKNbZdMDGlJIj58veF+qy2JefR8pEe/7SXfhFV8YP6ES8/+FyV4
	N3rQN3os9BvGen5wxCcv7akUXioFRbl1i8iErsAgxWOhdJRKTFVRkKHIrdRGoNp8YvVvkQscFW3ZL
	GuiGrRXw2jmZSOlYG8Zgsm8dFeVfwNOMNyeLL8B1mDZBNuOI8UYPVNdzh7rnuRZvYDfOXqlcidlvG
	s+EBb98JR27BkmP8OHQbhuWr3H9INdIw+WS/2LwsSh9+7gf/Ls1SXakIP3aeg4ztsjebmvFsSXYik
	C1FfIQwnCzPnMyhgEyCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golUl-0005JM-41; Wed, 30 Jan 2019 08:45:19 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golS1-0002Cq-LX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:42:33 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id C6BB65FD0F; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 03/10] arm64: dts: allwinner: h5: Hook up cpu regulator
 supplies
Date: Wed, 30 Jan 2019 16:41:56 +0800
Message-Id: <20190130084203.25053-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004230_179724_D8DE528A 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some of the device trees for H5 boards already have the CPU supply
regulator defined, but they are not referenced in the CPU node.

Add the reference, so CPU DVFS mechanisms can see them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
index 85e7993a74e7..0c7b2b3d92f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
@@ -71,6 +71,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_cpux>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 506e25ba028a..10e52b612892 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -126,6 +126,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_cpux>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
