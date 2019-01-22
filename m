Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18EC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9329520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="seJWLKE8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCRgEPob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9329520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uUa0a3FREadnoYxERJ4SoFMy6JdRudSMpEvUNW7/3hE=; b=seJWLKE8Xnn0/NOdW0MEIYmA3h
	4L2ooKh95RtgA7mghtg+XybktFySLM5h11TlrlSBXlW0ptc9qhhnTtObUqh6vhTVv7wByD/QXRV3Q
	MSH1zVqfVcOFFd5rbzYeObuyVPbnE0VuW16elZVK7qk31VrfRinD825W2yFnc59HSst5HAeVWsxeI
	esQJrVUaRDIx41ZOg74oydiguywOnwo1+dSYHcc2szgY6qAsnyVNff/5Z3AQsaSgKJvW+MfaW3Ur5
	xnrOxRK8MlmCB2SroZnlMOk1midO8o1BOqlpXe3BkVJeyMmxqEtL5uvBDQQdkFMMi1wo8nxJ1ofX3
	/xtHknOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glna6-0001Th-6V; Tue, 22 Jan 2019 04:22:34 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnZh-00016E-Ui
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:22:15 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so11104020pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Cru5fUZcAQInENZrdcyg+x0Ztwsn5ae0UMz5WQRLO18=;
 b=HCRgEPobXdqHttzbeiuJnCe85Tmytm+W+vD2MDcZINqbJRvpu1Y08HUArUb1Rb3pSr
 tTFP6VbfnKNxzbG59b0NvN91Ln6i20TdUdbuUwkwoPhQnRKbmzN6+Bp0mWb4angAhvUT
 j3+NWw8M0eAkCCipI/lS9upxh7sWFBzbY9aEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Cru5fUZcAQInENZrdcyg+x0Ztwsn5ae0UMz5WQRLO18=;
 b=JeyOHGJATnlblUcqvFbF4kx0ksxguSywqQVb+Ltm1CHswgktQAOaa71BCBQPGWr22f
 +cwZ+m/nqgvY22gIJuCX1RaieOrHF1wb6CkqA6o6qPB95AYYzpBCzHh4dUO2Jy58crN1
 OTPOZ2mjnedFgvbLT7TrdM8fz6cWRR/rXBafLBCAfULbnDgS53H8LDFHNniYgW6QGpVg
 LpUNXcnvoWGSoAeIacERSg2mlb2FbqgEyhk/xDTbE7TTqQi1r4qsMcbPJ2O7iNoqt36d
 hDIIos4B0xXDmZw+WOwym8Jwp0P21oogLh1/3wyd5Ul8djNqDug6M/tLDZjMI/nRuyiZ
 4lNQ==
X-Gm-Message-State: AJcUukdaxe0ner/3oAm/1vuLvtXgwXzjLt/gEFSNIfgMQE/e9jr6/9Mp
 hCqVriU/vrVoSmKkDarrTLi+
X-Google-Smtp-Source: ALg8bN4ioSoUadOHvZuwQ6WlKjt/aHoSgxworlT/2TT7kHDoD+zoTCW5BHU5r2bdOtWIOx/cxiN0tw==
X-Received: by 2002:a63:88c7:: with SMTP id
 l190mr30006124pgd.110.1548130929254; 
 Mon, 21 Jan 2019 20:22:09 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.22.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 20:22:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v3 2/5] ARM: dts: Add devicetree compatibles for LS1021A based
 boards
Date: Tue, 22 Jan 2019 09:51:44 +0530
Message-Id: <20190122042147.5424-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_202211_251186_85273E05 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add missing devicetree compatibles for the following LS1021A based
boards:

ls1021a-moxa-uc-8410a.dts
ls1021a-qds.dts
ls1021a-twr.dts

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 1 +
 arch/arm/boot/dts/ls1021a-qds.dts           | 1 +
 arch/arm/boot/dts/ls1021a-twr.dts           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index 6a83f30029ea..ba1ddd93b8f8 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -18,6 +18,7 @@
 
 / {
 	model = "Moxa UC-8410A";
+	compatible = "fsl,ls1021a-moxa-uc-8410a", "fsl,ls1021a";
 
 	aliases {
 		enet0_rgmii_phy = &rgmii_phy0;
diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 923a25760516..ca60730dda40 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -51,6 +51,7 @@
 
 / {
 	model = "LS1021A QDS Board";
+	compatible = "fsl,ls1021a-qds", "fsl,ls1021a";
 
 	aliases {
 		enet0_rgmii_phy = &rgmii_phy1;
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 8b48c3c7cd21..97e1fb7ea932 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -51,6 +51,7 @@
 
 / {
 	model = "LS1021A TWR Board";
+	compatible = "fsl,ls1021a-twr", "fsl,ls1021a";
 
 	aliases {
 		enet2_rgmii_phy = &rgmii_phy1;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
