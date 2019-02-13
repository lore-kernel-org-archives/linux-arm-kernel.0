Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A633C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45BF222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ErrnDIyx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpFzzCuu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSoR2YWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45BF222B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FLrgumGk//6ptG7rDGhzGCsGwdMmoHsmCSZghCnGiMk=; b=ErrnDIyxNmQxEquDoDj6t5L85U
	DhOYdGb9U1+H3N2iPkGEA1zzQYzpnwQraq5QQdk+PX65aoWjvhz6iW2FD8k5BYDixx2niKg+mjAnz
	fdVTVp2GCw1Jz2x4xWxodaFNlSv40nzqL3LttR+lvXmUeqQ0JpTz5PdmpR7Ys5Y901mUKq7WXYJWi
	rApwAvP2SRL/7f1TPuOnL6hFIfaTi0xnVEhNspt3VxyhxvSX2IVnY5IAnfnrTjRBsq+uGDgjnD9x2
	9F/j/uIjT95Fpeeog90Ytm6iM0CeAlGr0LycavG3KdZpcEYaa45UM7+x3SD53irYNLcC3LI7rysJ8
	C6+0jrVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuJK-0003VY-JP; Wed, 13 Feb 2019 13:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuJH-0003VK-Qb
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 13:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Ftil2JC2XMfueJ0xbXmoE9WbLO/vJyO48RDROHSDf0=; b=HpFzzCuuEsSbcKTfI2V1Z2zJM
 eJ76Dir+SOXXFWhYu+UzRcWZ5CUlm5jU0s01zi7JZUPsUFV+lGcKV/c/6vFamqYKdpzQ3wDRMpmkG
 rtm5FFppeDLclWCgJR9HTs3D30i4eSflHpJA5LTG8J9Z6Eabdu20JHR5jrcYMOX+vcR9oWSeftxTJ
 2i0jV7e3/NrEKumT94Nr3C85Z9U4S5qijYxnVsUJ8eUpgCzhhWgLKBh+QmDR+RbLwi1BUNT0Dgra9
 PZ3+iLwRRVNZ3aB0sg5h8E6DBNBYMCNZJ9nwg1AOPGNkrISnzd2jv1S7nzJG7ajxmX8MWO0X/Addc
 gl0IPeHyw==;
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttkH-0006rO-47
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:35 +0000
Received: by mail-pg1-x542.google.com with SMTP id q206so1079902pgq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=1Ftil2JC2XMfueJ0xbXmoE9WbLO/vJyO48RDROHSDf0=;
 b=OSoR2YWHmdDR0TDR0DDK+/GdBK1YYrgUQhsHJFLsbFRkAFflM/s+JBorKv1keFVe/g
 G3WqTYVQfjWh428+yj8hIUKf2o3TfTSpJNrICx6PEjLtFAOzY40uXayS5vPSWgLb12zK
 6x97NWMknbiZgNm8oqbwQMRaYGzrbXcNfsU+owOiAkuJaiqpkOKejjmRPS2fpaC/+p46
 xGjrBfLDHT3bsvLpb28JPjDNEkm7QsmsT4fUuKpYkaOcULj6FsBH9EGukBiRmarVCvQd
 AoW/FRr/i4aFl0KXtniSeunNac6cBvKh3GDVOWdvFtXTjJK9dlJIKyTpXW7bzq4S9KfE
 vOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=1Ftil2JC2XMfueJ0xbXmoE9WbLO/vJyO48RDROHSDf0=;
 b=FVUL1HzZXlbz/ZN85fbofL5/yrDi/shK9rONOs+n1+W792e9r+MckBIcRzbkAq4/xe
 podRSuNlv3Jq5SqT23213KAxYuQ9dM9O52Esbjyh5j4PrvWwxyRmIpgy/++Z7M7j9Osi
 UXI4q0W0IMv5RSrOpu8XeLvY1GWFftss9Ye/GLI7783Tiy5l3vDKfEmF4MKNiBzEW//S
 tdHQj5BLV4oHJu7KH3jJ4caObordHiy0eN7eJycvtXgWnNzNOAOJaL5avjVgYnWECcUZ
 Hye+fsy0w4Q2imyi7FOPvc5bhh0SwsXulNQXhqzzj2yfPz5WHXGQh//MeE9z7pP7THrP
 K2RA==
X-Gm-Message-State: AHQUAuanwi1x6Jo4Yz8YqcbVpc50BGqm2z2R+cND7vRPeZwzSOH4j3nm
 15FNp0qURcIOEybwGDcJHGeFmw==
X-Google-Smtp-Source: AHgI3IaK6Wa7iLqOWxwNxcPopviGukSLhRAOTKcWTlf1/MHf1annhvER9HpSF5TrQ2X73RS6hu+3nQ==
X-Received: by 2002:a65:6294:: with SMTP id f20mr293397pgv.174.1550061263973; 
 Wed, 13 Feb 2019 04:34:23 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.20
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:23 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 4/5] arm64: dts: sprd: Add SC27XX fuel gauge device
Date: Wed, 13 Feb 2019 20:32:48 +0800
Message-Id: <46be35679912ffa446d67bb9b81f0cee065c1ca2.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_073433_190600_81375E64 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add Spreadtrum SC27XX fuel gauge device node to calculate the
battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index dbf6242..4a79ddf 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -70,6 +70,11 @@
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
 
+			fgu_calib: calib@6 {
+				reg = <0x6 0x2>;
+				bits = <0 9>;
+			};
+
 			adc_big_scale: calib@24 {
 				reg = <0x24 0x2>;
 			};
@@ -90,6 +95,19 @@
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
+		fgu@a00 {
+			compatible = "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
+			io-channel-names = "bat-temp", "charge-vol";
+			monitored-battery = <&bat>;
+			nvmem-cell-names = "fgu_calib";
+			nvmem-cells = <&fgu_calib>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <4>;
+		};
+
 		vibrator@ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
