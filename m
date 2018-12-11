Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7797FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476802082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DHbrPibB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476802082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vphsXWJRdHYgsPWHYc1TS6FirQep1ez6RkGZZHys/u8=; b=DHbrPibBqxmD3JbLCPb2OYEKFe
	3bgCsTvmwUhCWzmDxCzJJHiSYF4H9lqMKH7u4aJ0+AnPpdmIED2P2F5d6F+HKAbcz6LTd7fM9JIe9
	O1y6KI6mCgAgjgOyddCEbL1xKpVMtQvyKHvhKJwrZybO8Vi7qPfsQjOBUaxfpkHhGcKDqMP5L9XA0
	uDNtpP/EI116tLklfNgGf9oAFrke+O7YyYpjqJNVHD7L/E4f2cV6QoO5o7pSxaHiM1IZMB+ckf6RP
	Pecb6yasyh7orDeUohZjpDFhZpsxPMA32F4rgkP3fy3RiaiH9+R34hvjvgYs3zMyh0KS2XhIfydYk
	JgVePWag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiSk-0004TC-KE; Tue, 11 Dec 2018 13:52:38 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiSC-0003ud-Pd
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:52:10 +0000
Received: from stefan-Vostro-260.fritz.box ([109.104.44.229]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjSDU-1hBs1G36Zm-00kx3U; Tue, 11 Dec 2018 14:51:48 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible
Date: Tue, 11 Dec 2018 14:51:13 +0100
Message-Id: <1544536273-17909-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:APUzNabMPZKpWN4VyspibUJ7CkwfmwpOvf1aMw0IxjFELOpCHnm
 LOB5GuT5tIQRFhgQwYSypOe+ieIgOvSoSN+EpX8Y+Xty/57fWUaso6k4mj4l/2FUujQJwK8
 JcSstPwLyYquvz3Vyej08+mxWaQa2GtbbfB60mkhbpvZ43Y0VFvwMRPgNQhQz4gCoMU7UGP
 8Kd/eiwOZErdlPcCorsfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RE84+WQtskE=:GiBySHVOR+SsWMcOeyW/SF
 IzDx4HRJHj3aCrBH5Nz7E8P83wdLMkaOWewBF86TC8xHAfIfAqMgqJZUQ6SUBWLZPEnDvrHlg
 SlRUye/6p4avhjdeUmfihbGVt6GGuk2i+F7dDhh97b1HwnvtoBqBNp+8UlWVtZ/XRrpi7ytyq
 15wuf5zQAYXLdh2zPnCOS/SjEmFt9xtRfkbDc2i22pHoLzLt5jAX6tAw4bgGGyaQ63gqh+uK6
 Vvr0qm4Cw264EHp+YQGwCi6R5vzX/rHP27aHpUqAMZntyWJRYbOpxyuIQUWFEtIHbeJobym71
 i0O/hBRWtckfE3/UZXF9pif0a+gYXTMlenMd+lSiiTUXltYyhxoS1GuWdd8xcs3DBrb5OLdzT
 V6PEI2UD5NGKqAHS6XNDpo+lvmVwgmTLf4Kz9mR1QTJjmQQpUeSq+r3cxjuqGCqTU4Yd61rYS
 03ZGWB+5pPAzfoJf8kz5Rt40z6PK2WTcEaVuWRwemmj5Mdv1kp2tPiAmDdxtvDyB0FJZQ7t1/
 pHuPSQte4rS2zlLJ4JQVvzGGUbHAPPf6ElmMb31W9ZYJQp2h1GXs9TEXrwoBtIx2Y1S1XL8FR
 dOr7dTTSFwymUsRfxx63wzggBlJ0PUbufT++5bA6bnvt5do98wax8YfNgAr04OhJ4uK9pLH1I
 lr+AsZ1TdnHi2f750iSTy7oPMRRbS0yp3Io/UAPV8A1QZzV7E5IYvI0mkAygT3uemuemuHzx8
 z5GyGCvNsQ3AjLHkbTFj5BsUytmRoDPCoXcsFNf0Sh0p2IJUJVM2arMFLMA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055205_136181_30C48B9D 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since imx6ulz.dtsi includes imx6ull.dtsi, we only need to fix the compatible
string here to achieve the correct OTP size for both SoCs.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index f3668fe..9cd1a48 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -30,6 +30,10 @@
 	>;
 };
 
+&ocotp {
+	compatible = "fsl,imx6ull-ocotp", "syscon";
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
