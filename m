Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADDA217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="af1IxL/g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oIhh19xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADDA217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SSYBiOkXnH6ydgN67tU0ng4nwxdMuXO37dejXuHIKgw=; b=af1IxL/gRMcI7S
	cASwho2mT7d/juw8QJRZ2/Fd8/aWkMqyIX1wwqw5h8GPTetapteIsTunyR0b5dsNeILW88hjvczXW
	2OUXGkZS31MF1MRuokzZB9KfHy/UccfZF8rI4MEn444EXcwDp0AhTlHlf4dXLzsLROOme2Kmcsi9A
	a30keeP8SaDBMb6eDi9SzavCru5PRuIA34OhkouFsMi2W+51islMxP7O70gN2lk2+tEP2W5rKrXWd
	iitX3EXlzGC8T6RbcwrEs6c7R3Xtd9wj7DODDE4X/qkyn2LTfc6AfHN8LrGU183I/EZ/qCLq/mmkL
	ojAf0ow/drmbiQDZlK1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaJ0-0001Uv-Mu; Wed, 19 Dec 2018 11:46:26 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaIV-00011q-E5
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:45:57 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJBjoIX084200;
 Wed, 19 Dec 2018 05:45:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545219950;
 bh=DCm6br2diZ4UW0PT12idfjpiM2j9byjVu8qbjt5e3/w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oIhh19xWaeCm1d6K5QrPpXE3pi0m1EvoNFuB75wB0dAq3AbSv1NwwXfuIYeNbxAkn
 PDj4cjbmcnSvyH1hGSdK1lr2uSW1YKFdYQn5QID36b99ntyFrez4tS2IJViRyRXB41
 s6/ojf2h0ZLGWYwNaS6Dw3LPRS/VtAOBkxnSJhj0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJBjoYn008758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 05:45:50 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 05:45:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 05:45:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJBjfog011774;
 Wed, 19 Dec 2018 05:45:48 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <nsekhar@ti.com>
Subject: [PATCH v2 5/5] ARM: dts: da850-lcdk: Enable the analog mic input
Date: Wed, 19 Dec 2018 13:47:27 +0200
Message-ID: <20181219114727.6865-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181219114727.6865-1-peter.ujfalusi@ti.com>
References: <20181219114727.6865-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034555_529605_C21ECC86 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The LCDK board have additional analog mic jack.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 3a2fa6e035a3..26f453dc8370 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -74,12 +74,16 @@
 		simple-audio-card,name = "DA850-OMAPL138 LCDK";
 		simple-audio-card,widgets =
 			"Line", "Line In",
-			"Line", "Line Out";
+			"Line", "Line Out",
+			"Microphone", "Mic Jack";
 		simple-audio-card,routing =
 			"LINE1L", "Line In",
 			"LINE1R", "Line In",
 			"Line Out", "LLOUT",
-			"Line Out", "RLOUT";
+			"Line Out", "RLOUT",
+			"MIC3L", "Mic Jack",
+			"MIC3R", "Mic Jack",
+			"Mic Jack", "Mic Bias";
 		simple-audio-card,format = "dsp_b";
 		simple-audio-card,bitclock-master = <&link0_codec>;
 		simple-audio-card,frame-master = <&link0_codec>;
@@ -250,6 +254,8 @@
 		#sound-dai-cells = <0>;
 		compatible = "ti,tlv320aic3106";
 		reg = <0x18>;
+		adc-settle-ms = <40>;
+		ai3x-micbias-vg = <1>;		/* 2.0V */
 		status = "okay";
 
 		/* Regulators */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
