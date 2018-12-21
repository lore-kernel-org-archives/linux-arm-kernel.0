Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561E32176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VB3dPkdE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="davKJCtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561E32176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fpMFnxEkyU0r3kER7kUSxD5KepJnvxIFywZKN5gyomw=; b=VB3dPkdEeh8GOWufeitoawFpQi
	W7sBfRO0T1y+10SpIlBvXZLyuJUxVMd2+bHyhdSOi9oO9kPYZJppOjzqmCoQAKzjjtWM06dLVwv7+
	kGR3RkIf0LTY79NFUZ+3l68tdF9XNZ9nvhTKFpacuTzUM40ALPymsbaTxz0mUJKDTYeMQBDuCbLfV
	9QRm9IdXFda/N4o567rU9QgPqzPAxU6HhBWNMJOEe17DtYVMgzo1fPEtcD/TzoDVO42N5zn3S/KAG
	H34w8bLKqpRM3n7DZpxmgYlYhzVNfSYbclCm6ZSwpSyzSmIsc0g8ZEhe2t0AsONRVW4bE8PjOKKRj
	PaWBTx+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI4v-0003eX-Lv; Fri, 21 Dec 2018 10:30:49 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI4j-0003WE-LQ
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=wqpe4d9kG9Kkv3i1WbXGm+3XMVtnjkqfBZgrYacw+pQ=; 
 b=davKJCtGkQXaM0zkeIL9GL0G+8AUygEZ3Dp6SCeVSPeKxn8oXjSdjxwIGhCydSuzmbDOtKG/LqxP4W2pmvLxr/lLS2xVWSAIzSDnoHausO18JBAoxXlaVPhF88gmuw04ojRJZ3yX0nVpwySEaCoT5DLIckgh/BVmnAVbUC0pmEQ=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaI4V-0007db-8l; Fri, 21 Dec 2018 13:30:23 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: clps711x: Add syscon phandle to device nodes
Date: Fri, 21 Dec 2018 13:30:18 +0300
Message-Id: <20181221103019.15374-3-shc_work@mail.ru>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20181221103019.15374-1-shc_work@mail.ru>
References: <20181221103019.15374-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 6115F4D8777AF1675A78504BD2AC29419868B496DAF47A9F08ED325AB75B808BC1FF7E5F7721EC9B62F6C0DF2C2DBB0D
X-7FA49CB5: 0D63561A33F958A586FCB78A0F755E9AB22B7DB495E7256A8D04890473460C928941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7939D6621314C44ABA664B24FF5715BC2EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 8261CADE3D3FA0B4C2F1292954F703E9B4DE5E4DD44461499E1C17A7944253D9E8B451D53EC5A68A6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_023038_088211_FC2ACD02 
X-CRM114-Status: GOOD (  11.01  )
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

This patch adds syscon based phandle to Cirrus Logic CLPS711X device
nodes that can use it. These phandles will be used to replace usage
of syscon_regmap_lookup_by_compatible() and
syscon_regmap_lookup_by_pdevname() by syscon_regmap_lookup_by_phandle().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/ep7209.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index 48a1660a9cf2..1630b3d3873e 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -119,6 +119,7 @@
 			compatible = "cirrus,ep7209-fb";
 			reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
 			clocks = <&clks CLPS711X_CLK_BUS>;
+			syscon = <&syscon1>;
 			status = "disabled";
 		};
 
@@ -158,6 +159,7 @@
 			reg = <0x80000500 0x4>;
 			interrupts = <15>;
 			clocks = <&clks CLPS711X_CLK_SPI>;
+			syscon = <&syscon3>;
 			status = "disabled";
 		};
 
@@ -181,6 +183,7 @@
 			clocks = <&clks CLPS711X_CLK_PLL>;
 			clock-names = "pll";
 			interrupts = <32>;
+			syscon = <&syscon3>;
 			status = "disabled";
 		};
 
@@ -192,6 +195,7 @@
 
 	mctrl: mctrl {
 		compatible = "cirrus,ep7209-mctrl-gpio";
+		gpio,syscon-dev = <&syscon1 0 0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
-- 
2.13.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
