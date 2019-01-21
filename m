Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DBEC31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C6520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rfTl5g12";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHGposEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C6520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/4/hN04yuhI9mX9CzLQS++12uoycML4Y5q0gvv/a0Q=; b=rfTl5g12vLHWiR
	6NzT39mzywi/mhwT2jPiUKzSFTdagkaqhQSBtfHmnsZPmewm0dVTVg91UUmkF5EYpQ3JvcL35Gk23
	EPlUKVDH84rlUNUaG+E1WJ482SOkwbm/QWRQ+PZM9eqK01Iom6fh2MJimTTATn0yF+tsY0hps4nHQ
	4pPvccxYrUk1+QbYJ7I4KvVHYLIaqe2wkcXtNRON3QGLaBHjwUdenTphhfs88ZSQLsFInXfO7K+hg
	judn1jMF/toFW1nFA5/xiyd6PaaqV3+HfWo5NEVDxwqhzhH+pmGM62K8xeNZY9xf6Dt9SiTE2tSNu
	M/oPPxRw48gFi1cQijeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTrO-0001CU-0L; Mon, 21 Jan 2019 07:19:06 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTr2-0000ov-G7
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:18:49 +0000
Received: by mail-pg1-x544.google.com with SMTP id w6so9057222pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2k9l07RpBYtlakWHYn6mfcQ2BX0Oyp6D4xN2whb1JAM=;
 b=YHGposEiTssTcSqGZtgYx2dVgnPBd0Hr2L0ZNoezTNxOFX9gYK0GT0rIektdBsqfSh
 pAYERBOy19LCrDiO6D2D27WKl7PmD4ApYqXmcgsixiKHIW+ukuq3WKUuFt2cTbYpNKHG
 3PXRcCB00xNMVcW+f/vMoStwKtEWceweud/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2k9l07RpBYtlakWHYn6mfcQ2BX0Oyp6D4xN2whb1JAM=;
 b=j+aMgINB9hleMDsW/am+V3A3al4M5/AR12kBDBi5cATxHKbsvpYTc/OyfmgwHGjr0b
 DNoUklarQy4KqFzM6aBxF7YAgjhqRT8lXbFlEjN+u/mRplmzM5HA4DG87ZETUSxeENQN
 dJUPHkMqo734O31FNNO9ihKJYs0cWOiH2GaCDJGXg9ENsUGy+TmQHF5EUBZgBbYsuBa4
 T1polBRaGeu2ojJBarzkHEb88YYRs1Ux3lI8+Cns8dFHR3pDXJOB/KrT6Weg28zDljg7
 ItsFV+HJeBCrxHKrd4eYRojR8vwjQ9o1q7/oZTwEjzUndlzYSntrbYQVhw/6KWpEk0EY
 oebw==
X-Gm-Message-State: AJcUukdashxy2lIKLpDTkwHUcRlRqYq8YMsrqEwXe9q/lDFRdNMf5MRm
 rib+f294eqluijj6XWeXMgdHyw==
X-Google-Smtp-Source: ALg8bN7ctnSw77rAAv6wB9bo8P+orwZEGpWC6exG6HSvmM+5Hnnvhww0NAiky5glTrOkAaYkL/KMNQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr27520144pgk.425.1548055123617; 
 Sun, 20 Jan 2019 23:18:43 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id v15sm14941843pfn.94.2019.01.20.23.18.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 23:18:43 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC v3 1/5] dt-bindings: Add a binding for Mediatek SCP
Date: Mon, 21 Jan 2019 15:18:29 +0800
Message-Id: <20190121071833.43443-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190121071833.43443-1-pihsun@chromium.org>
References: <20190121071833.43443-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231844_820412_9E1FF029 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
---
 .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 00000000000000..b07e5c4ca9af1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,10 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+
-- 
2.20.1.321.g9e740568ce-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
