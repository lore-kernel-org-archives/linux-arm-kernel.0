Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7244DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE2E2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aATTObwg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="dyDYul+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE2E2176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GnV+z1+xmSJ8G+daiOJtXGnVCYvqqVapWngNyn9F1hc=; b=aATTObwgeGXbtTQoQa1xZqBNkJ
	75ft5NMphxuoL5XmdEOrGwajngd2qSU79sj4sB1WmPBsXaYqh9WOK2K9+X2vnZXn4gu+qv1izwq03
	iUHQZcXRq3kdZfll4mi7bPe0rAClgaFsjUZgt2E8sIZNfsYfOWIN3ltlVXzggfwVM4jep4rvqLigX
	wkbSX3ovlXK9j9DvuJqkx/qA2KO/eSQ2YZ3Rlbb+POFxcs2FVJ5mbbHvA+BQwEzROaMRKgrVLF/fO
	j5FOBPtqs1qg/u2y6JXxC1mkBcjS6QNDYo/dbkm76++4w4tqgfUX/Ck5dcdud8937oBLMzQFSiuIc
	4eFR1ZsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI5U-0004AS-NX; Fri, 21 Dec 2018 10:31:24 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI4j-0003WG-Ll
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=3f66pvQzSbpiksDPe/i2FxdHiantj+SU5au+sZQvr18=; 
 b=dyDYul+xLwZoevueN1PoUjKQmwE5hxpVbSX0+ae15NucgNmSALzRH4dIej4Z5Ol2dh/+gY1qaAZNoL/KG6MbToN0CC1h1kkxp2LZ776SPbAme8eAhB6x90Gtyk0q3rWxZhoG6h55y6zj6W3XAzDR/aqjMNQ/fRDivzVHRJOJZjs=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaI4V-0007db-N6; Fri, 21 Dec 2018 13:30:24 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: clps711x: Add keypad devicetree node
Date: Fri, 21 Dec 2018 13:30:19 +0300
Message-Id: <20181221103019.15374-4-shc_work@mail.ru>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20181221103019.15374-1-shc_work@mail.ru>
References: <20181221103019.15374-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: BBE463BEF7A60BD05A78504BD2AC29419868B496DAF47A9F08ED325AB75B808BE20822DBF87D4E567C7F92F1E188C0E0
X-7FA49CB5: 0D63561A33F958A586FCB78A0F755E9AB22B7DB495E7256ADF850BE52090BD238941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE76340D046AB03C35241FEB0FE36B52EB075ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 8261CADE3D3FA0B4C2F1292954F703E9B4DE5E4DD44461499E1C17A7944253D9072FDF03832979696B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_023038_096182_0C3A1FAE 
X-CRM114-Status: UNSURE (   9.76  )
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
 Rob Herring <robh+dt@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds keypad devicetree node for Cirrus Logic CLPS711X CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/ep7209.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index 1630b3d3873e..6e86b22c1b90 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -193,6 +193,12 @@
 		};
 	};
 
+	keypad: keypad {
+		compatible = "cirrus,ep7209-keypad";
+		syscon = <&syscon1>;
+		status = "disabled";
+	};
+
 	mctrl: mctrl {
 		compatible = "cirrus,ep7209-mctrl-gpio";
 		gpio,syscon-dev = <&syscon1 0 0>;
-- 
2.13.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
