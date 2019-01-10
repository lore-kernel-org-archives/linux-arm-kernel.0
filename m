Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C651C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:51:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81E721783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmNS3Rj8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZADNJv1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81E721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CNilX6BnoJV2kx5WXjX9PJz1I1849Q09uZHlrlbPiXI=; b=FmNS3Rj8ShYEK8
	b+gDc9zpp3gsUfp2jNduhMP0pxC94/bkKMh35Nqn4Fcwn7M08+zOfznmTuP7tfHUtdkJJyfmi11ft
	hdARH3XNkk4dDTIRHdYQxXBdwFz24kVLNfvIRCXewRJrzxpT+ZRZkOg6GC3vO3DAQc7ByLu8P/BvT
	gOxgHHUvanM+krCsG2e1hhXIibgPH7UZY9bEPm8uXF61Rv2yyPNQsIo8+k8AgVueti31yrxlFEeBB
	az6OSyla2OSiMql1D6xQhSyxQ7xjEqxG5wTeSQ51PFrcis3dPmiOBTkwap205SCjHweo/mQa1+ZIK
	TnLmSIG4+p1dg7j0l3vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbfc-0000G3-9w; Thu, 10 Jan 2019 14:50:56 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbfZ-0000FZ-6J
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:50:54 +0000
Received: by mail-lj1-x243.google.com with SMTP id t9-v6so9955965ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q0HQyZdzxTvoAzgCdS78WuvS6bSWXWchuUQCFdCboQ4=;
 b=ZADNJv1bAq6ReF9oMaUjKqRgOpSpfbmOY8oDNK4zOxaokanN1Vlt33dn0EZ7qY+hzl
 dQXDpvYk/WRmGsRQXKParGv/5fkW5SsjYJGHKa1LQPcgEnmnAXJlDo6a1tOuZ59ut7lt
 ooT8ytgVl87E3LoxmUmolFMnRp+sMDCbx8j8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q0HQyZdzxTvoAzgCdS78WuvS6bSWXWchuUQCFdCboQ4=;
 b=Cv6EH/oPMNrimSu4/q8/e9HRQN5MRY6NvhHmWrATrcz4VonqmnVUqSv8/cezeoDJVx
 ArnW7Hz/FGaB0A5pGH+yGCWwGAsgsKIuSJYJvOTA5h81nm+FCb9Xik6osGU+BHaPGErL
 d6ZDbqgk11s2+NRV2Cm4owzaz0jIZOotWKcOYWDHBDM5+SeJHk9xiPmbZ7TT5pFaa3ZH
 Dejhi34KFyM29FjE35+P/lehz4OxNLIc4Tjv4mST7aYsD3sHVWoK1advCrSPSOc3uimi
 13JfAHISV77p4FIHicWE/jQy/5iAs9vcwDozd1SNx+5stCYLwwhG9d4UsHWWL+tL9A9e
 MgHg==
X-Gm-Message-State: AJcUukcDBg8e3nz6pheytxUWhFscLvWdWbXeyjrKY4YzqaK9rVs/ruCY
 1AwWx36YV8n9YqgdrTOj3SiPdA==
X-Google-Smtp-Source: ALg8bN6oQxIvW546zJcOn7MAFcUpFaqCPnT9rlrbSQn/YMUxkGddA4ZGsEP4sA/KrTe5nIdCSRxG8A==
X-Received: by 2002:a2e:81d3:: with SMTP id
 s19-v6mr5371033ljg.138.1547131850755; 
 Thu, 10 Jan 2019 06:50:50 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id d15-v6sm15205652lja.38.2019.01.10.06.50.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 06:50:49 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>
Subject: [PATCH 1/2 RESEND] ARM: dts: msm8660: Mark two GSBI blocks "disabled"
Date: Thu, 10 Jan 2019 15:50:45 +0100
Message-Id: <20190110145045.11883-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_065053_238431_DE707BEE 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GSBI module complains:

gsbi 16500000.gsbi: missing mode configuration
gsbi: probe of 16500000.gsbi failed with error -22
gsbi 16600000.gsbi: missing mode configuration
gsbi: probe of 16600000.gsbi failed with error -22
gsbi 19800000.gsbi: GSBI port protocol: 2 crci: 0

So we should mark these GSBIs as "disabled" in the SoC
file by default.

If boards appear that make use of them, we can simply
set status = "ok" in the DTS for them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 70698941f64c..9b1cf00d8ca3 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -133,6 +133,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			syscon-tcsr = <&tcsr>;
 
@@ -167,6 +168,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			syscon-tcsr = <&tcsr>;
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
