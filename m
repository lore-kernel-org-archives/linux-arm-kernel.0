Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A253AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EE72086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HHAqAwf/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMkC5urK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE72086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9wz7TEgr9V/JWfJwa0gwZxrhtAOifDGRoI9+kh3Du2g=; b=HHAqAwf/YGS800+Abpt5FnlqPb
	Fm7IzqOzMifNhQggD2h6+DTLQ97Ehm9Fw/dLB7wv19wDRxVXW7xEuJNUSG5DX/2ibY4w7bNdal5Jw
	O0zwLGNmqw/QRxYESJu+guL1Nu4vAW+nttHrgG9DWql7OOO2zbYB2YbXGAj4ReKGSzMmTyZwuR3gM
	cHhMDDwScJxwfVkdX7S7YNlDiTZ4KZCtE3LbYQfcGFbIGEqhiwP65VYahK+b221dVY/QB4+JIClQb
	PidoCrNYSfiTBpaM3Lst0O+1sfvYdR3Xp3M8OXtFk48+radkHXVgtVTPUV4Clb2M34XU+tBZw1rdT
	NN+LGXIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpWy-0000IT-JN; Mon, 17 Dec 2018 09:49:44 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUO-0005w5-DE
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:11 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so11631337wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
 b=hMkC5urKEck/zn5xSgMuam1rniWk/yQbP4srf4MLONnN9Z6SsKDuVHSY9Zw4tdfAws
 QMGRwRY5tU3zqgRXgGdeb9F5lnl7Cf9rXo7E4dBhmnlHdDxnfVFUOtbhk0tKXYe7GBCN
 dxipQAVzK5xuZEKt97qd3h7gvGGRoSdY0Rh0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
 b=ApoW8k+flPPVFJYda32u1lPJWh8GJemutnhGB5QF5Auxc/RSSCLaHDgFyZWPxo4rVZ
 V4GXmrXqU72mXLqd6gl4nFnKP+sCxLOpF9jjAKR5ZFKFMzJVzrs8Azujq/BfhOZtTO1K
 59RjNHCOzTeM6Lpd1Xt2syneCSvGMi/TOH8rT2WBMKdQjO2GB1Xusqgf69JEFgx597Yz
 Jt3khTBeNqw0RUcJ2+5fjQ6fSP8S0VMX0OGw93bu92IvrWnFUJk+uZVeIOs0qsEMOlPT
 WkPhaFwoYVq0Tp4BbqsiO6+Lcw2pVkXDLrOFzE+U/JrBX35Ud0oSrK5lzuHOz6P641Nf
 RIlg==
X-Gm-Message-State: AA+aEWZ+4hbqVI8koIS+RcEI70hvFLoqxUzmNVPLE1+fu0G6nj69N5Ag
 0lnkSGD85Mq9LUQyG7KTkHBDAg==
X-Google-Smtp-Source: AFSGD/XEAqABFCF+vzzoc6Evp5frnxOq8ZucUcPTzNqlvHX2OCzE6pYNSSCHRNax02pKjaL+IURaxQ==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr10526130wme.32.1545040013020; 
 Mon, 17 Dec 2018 01:46:53 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:52 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 09/13] arm64: dts: qcom: qcs404: Add OPP table
Date: Mon, 17 Dec 2018 10:46:26 +0100
Message-Id: <1545039990-19984-10-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014705_369888_FE30923E 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a CPU OPP table to qcs404

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c165..4594fea7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,6 +62,21 @@
 		};
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-qcs404", "qcom,scm";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
