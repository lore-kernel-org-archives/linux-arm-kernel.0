Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A224C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DD9206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asL5nJYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DD9206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NtDG3jl0eegPBR4GvBxYmVp7YzebF9ALYqmXw4Rna04=; b=asL5nJYk1LWTYX
	6EMvkHjHf6fsKHP95tpLB8v6UnxROGDmkxXF82jxh74/XC5w1H6Uw497NC4+d/zGTOrgKCtWaDXz8
	w7A+rzAVpPTsByIcCIzM8475shxJgnZepD54mYmMFBo8zfvfqXmwah/Hcbo9ZX/cKTC1KL9NGoP1N
	4G42S17s7C8P3Q75kXBOvn9l3ZlrCuoHtI4+Nyv+qU1Thl4xQY7Jpt9iQOR2YuS2LtnE9rKFXv6qJ
	LtqIE9AzUPJnhxzUSkqt/7tsZxqDpudR59sOEedutUdEwq9XL/qkUHf1Jfx5aI7gXgVgVvxFiWqUe
	EwiFxS7R9gka2UpCWVqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFOF-0001zI-If; Wed, 09 Jan 2019 15:03:31 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFNp-0001WT-42
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:03:07 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 4C7BE5F7AA; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 1/5] ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG
 pingroup
Date: Wed,  9 Jan 2019 23:02:53 +0800
Message-Id: <20190109150257.12602-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_070305_286576_86582BE1 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UART3 on the PG pingroup on the R40 SoC is commonly used to connect the
bluetooth controller in a WiFi+Bluetooth combo chip, with the WiFi bits
also on the PG pingroup.

This patch adds two device nodes for UART3 on PG pingroup, one for the
RX/TX pins, and one for the RTS/CTS pins. Consumers can reference either
just the RX/TX pinmux setting or both, depending on the application.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 89762dbefe42..f1fcfa0bdce0 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -389,6 +389,16 @@
 				pins = "PB22", "PB23";
 				function = "uart0";
 			};
+
+			uart3_pg_pins: uart3-pg-pins {
+				pins = "PG6", "PG7";
+				function = "uart3";
+			};
+
+			uart3_rts_cts_pg_pins: uart3-rts-cts-pg-pins {
+				pins = "PG8", "PG9";
+				function = "uart3";
+			};
 		};
 
 		wdt: watchdog@1c20c90 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
