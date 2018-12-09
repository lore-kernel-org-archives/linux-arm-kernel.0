Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30317C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:55:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C762081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qwemcjeL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRouTrVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C762081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xCrWo5QcgFZCza3N7L2Fackj9rgAmxwSqi8nA7m3SXU=; b=qwemcjeLvl/nJWYXcnimnlh6qf
	DQsxme6+ntJS7b1Bh5d5zzm7JIw7XhvKZAL/H30W88Zk4KLJ2GRxGv3niXiweDazyQ924pHUVSNRU
	AJTMWJBQlPBeBSdV/R3kSzOuGXfDga0MRj1v07RcnxFsnJPnsF496ISPubX7YmFQyVhsO+hy85zyw
	p+0w4OGZk0Kf7HsC7OYHkhxvCSFQaqq2zR8bJKl8rSd8MA+5gr/fvztdKB/wCzWKWIfGUY2v7RYB9
	56ItQEPFU44Tjmi6QYkvFhEqpnjg5S/F92/jtwY/btd3BUwndxXk30UhkP8Pop7mB6qEaZeMRrVws
	PvwJrtUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVzXp-00062L-C9; Sun, 09 Dec 2018 13:54:53 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVzXa-0005lg-Qr
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 13:54:42 +0000
Received: by mail-wr1-x444.google.com with SMTP id 96so7947965wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 05:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
 b=MRouTrVj72aJHi/oL5sJu3n78v8HyQ4+bSXQ8+nlkavs3lkOMnCAERi4yMuiPEUjq+
 tFg5gYZ71B+VdAjQl9a47qwL4ecjryE+iITLoGIKJQ11WaIBm4rrucVl62RQvr8xK3bZ
 wL/152r8VN4PwvaSQMwqef8UKdp6+xKLfsPzPYJLZnOnonCYvl0/FrVeSUV4Aq9775SS
 pklLzJ4xQFuotaXAmq5XrXrShZeAjZPiH5ygtGeL8NtpJCeDTAB5fCTd5m/oSLlvBjWz
 abDZKWtJj312UcykC1fLQ1CKwcklpJw2B4pPUGCVQUDOUISdrCdAjRsriUwru9aGsCGE
 Io5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lduvTdvt6JcEpnSpmltVeafjnok+c/QPakMMBL6iHiM=;
 b=orKL6mHP5sLlvMiSJ4O5vDM0JCytzG1IyTHXXJO3wIC480ZuHEP87hpNIEJYJ8w2Yz
 l15Y8Uwv3y4V1mppCcFEWECuTPCx7FiCT/H8u00l99pnpSnOhwWSutp+h1HU9lybyKuf
 sDvVQZgE2qUVwYGt92i4bvR/C3NCkTpi8FpZ8MOYb6awmJRA7ZSTSvKRFVDdryW78ylx
 Yv+Cs2HKo6fIcHQ/kBbtqTFZc7NuS9E/poSPcgOkDJHuYTSSLZ6mkIfE7W5/19D++JW4
 YAIXmRiGpXMKJrjc5mk1t9brXfLBIsCddcceRf+C8Njul9dNp5Tk7l1NVt3NP7CJAeYR
 R3Sw==
X-Gm-Message-State: AA+aEWaQb/6c+GUMo5nI67+7kuiXtELhkkcUc9/mLkQ15EAmbNk1d/mS
 JadaQUpQzNQRZXzwfYNgZbSJn3MrPFc=
X-Google-Smtp-Source: AFSGD/U1f13BFk1GmH1h5GH9qXtgedLUaXOPbXGP/73LQNrgQT/8Uc8bRSqrXCkjn/Yo7Nxfevm9hQ==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr6700257wrv.147.1544363669513; 
 Sun, 09 Dec 2018 05:54:29 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl.
 [83.23.177.239])
 by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 05:54:29 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Date: Sun,  9 Dec 2018 14:53:56 +0100
Message-Id: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_055439_273501_18143AB1 
X-CRM114-Status: GOOD (  11.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Amelie Delaunay <amelie.delaunay@st.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add description that STM32F4 can be used in compatible property.
Master Inter-Data Idleness optional property cannot be used in STM32F4.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 1b3fa2c1..d82755c 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,9 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32h7-spi".
+- compatible: Should be one of:
+  "st,stm32h7-spi"
+  "st,stm32f4-spi"
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -30,8 +32,9 @@ Child nodes represent devices on the SPI bus
   See ../spi/spi-bus.txt
 
 Optional properties:
-- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
-		  nanoseconds inserted between two consecutive data frames.
+- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
+		  delay in nanoseconds inserted between two consecutive data
+		  frames.
 
 
 Example:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
