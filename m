Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E39C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B9E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sVLihNsh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZKoIwSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B9E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g6EFtPu29MQ210NZ7rOz94DnxQGxkFBmvP1Hee7wSNY=; b=sVLihNshFuVavM
	i5nNunmEjaU2WOuYnrQDWEr8V7WWsAtfWUIhI4dHEXpGUBZXsbUPcgDAgjAGoyGtF+sylKwbGONxm
	ei0YLtQPseCsxeqQ4MEwLlKFh5Nm2R12/qLJALCVhllLnXtgWrrIKPukeFv7STl9hD2ivls2wU7LB
	rLbBVIgFuZT6GuiSHdKHyKwYRBukE7SxlfZvDclw9SKhGwPK9B4LxGWRjjpD0eVYFFRlRIwZ5jajh
	GyYIpvovPFfhs+CwCqkukFj3jBm0FsGy5mzFOzyy8bLns/K/ZqXoGDEf5b+s8a3/VOCSqR8z6H8gs
	OplyCiM/qfxNo0hzAaaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggjuL-0002k5-Tq; Tue, 08 Jan 2019 05:26:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggju5-0002SY-9m
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 05:26:21 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so1178880pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uNzw5Mk6p5U5OxaVpQeJN5aDRHrWFdN2erFBwQa0hHs=;
 b=XZKoIwSKfezjosQOu+ngF1GT0QEchy9/7Z+4W2HAe1x2qK98Jfe/dncW1ZnpSbvzJl
 rwrVrYWFm+F7PJ170/SljVsKzTtwOoBFtEHIqqjNq4WHKLyrup1DK1v+MjNA7Ri/thmP
 piRZ+o8FIEOlk0U5jnPV7lKIqGnh3FMc0zZB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uNzw5Mk6p5U5OxaVpQeJN5aDRHrWFdN2erFBwQa0hHs=;
 b=roQxUeuCw6qn1VbKk3ww46kKN3iPAu6ADjOfJ6NXWl6//p0RNzD1HdfWPtCM+goGiY
 gzg95zngmc14mXWhVMLeGkqfCAr0w2sq9o1HDg5SxRjcuI7STiUzjZY+pG+BgYNyLL9U
 oDMR9oCeYG2RvxAJABp4caKfp/UQZd2sPHjAK1i8eZbxteGPgINhOZOuF3on2hYZWg56
 9XcTPfK8QOPnGelyQImllzZKknwKwAChH7W6sIPdEEAOZb65zryxOnjWftGuNJ3hWkpx
 ur9bLVWxl7o6DQTAaTLAgNPU2NBLvb9MQ35tg/NaVGoMfKzUNyQTugqwV1KxoeXSXcoR
 yjVQ==
X-Gm-Message-State: AJcUukeOoYzYSfDwh8n0KEqJmHDRxwW5y7ng+hNQbY3hcY6Tig4qvdTc
 OmQ/vv33gbknWFpAyImujOHOyA==
X-Google-Smtp-Source: ALg8bN6y+HgAeIq1CoUzGQS+QOmaCrHLWl3foL3n/aRE2RH9j1FMirVc1Z1h+eZtOpJ6XvgtOxkFLQ==
X-Received: by 2002:a63:d252:: with SMTP id t18mr324509pgi.133.1546925176324; 
 Mon, 07 Jan 2019 21:26:16 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 21:26:15 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC v2 1/6] dt-bindings: Add a binding for Mediatek SCP
Date: Tue,  8 Jan 2019 13:26:01 +0800
Message-Id: <20190108052606.59426-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_212617_684697_975AB820 
X-CRM114-Status: GOOD (  13.96  )
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
Changes from v1:
 - no change
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
2.20.1.97.g81188d93c3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
