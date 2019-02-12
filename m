Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4537C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BDC217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOIOD8eP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lyC9fH+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BDC217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c3BNBcbdZAvV6a111GwuaqXVy1noajccaqcxL/nm6rM=; b=XOIOD8eP7OKDDd
	LOIsN5cjQpqLs8sdBOhpSA/40d86Bb/eHcvb/LNoj/go5bE2+RraZ2e03y0JpEpID2I2Lox7RbQPR
	gbXAGzBhQyxPiewszX5EujRlCFoTqe0Hschi1O/vSnohLTsnTAxoXUc9mxwpjEojTxX5SfYtFVrqj
	XBvypXz9gDA4kSOquE4lks12NdfHzw5L987Y1m96bw2ZU5SKteN1O/4z4CoCkKpqZQU+bzeATog+/
	aBv5q8hmLlZ+AxULHmODfc6YF/6Um43FqQ/fxFa9+KlD8corA3xTk+wJJc3iQ/PvokuPmSd7s9RgY
	+w5dF8sV8xlTtEmAI1/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWcN-00069h-1a; Tue, 12 Feb 2019 11:52:51 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWcJ-00065j-E6
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:52:49 +0000
Received: by mail-pg1-x543.google.com with SMTP id y1so1132359pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bHjcYouDUwGmYADd2nQo1JQfRUDKDl/5dUGsqZC02YA=;
 b=lyC9fH+HVS8pwNgQwHAJHNF62bOHJAEOq2H9ZUeA5eYLyuH8IoePItDYHNvHHTWC02
 QLNcPyjDQgayofr2pogSrMFZ3Tvw8RSm2YGhfzM8inhKjUxkFQRFUJA+/be3zSJD6usu
 FiHzojz6xlHvqsy0ot851H7mdev0dnZVWaFrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bHjcYouDUwGmYADd2nQo1JQfRUDKDl/5dUGsqZC02YA=;
 b=jsSkuaX4ca5i2e9jOToPB8bDZ05lgRNh7QPVkF0T3zI7pJbDdWtOWn08XCK0aWXWB1
 rR/y9j+t+hek7gH/QOkV3iZsyf5qFnfqH1mX6VAuIsU1wPWyLcz7d7nxyuUs4EUEMK5w
 zis1So83upmxieNuOfLXHoKgKBEvSmyUwMOIBsBI1Ec398TwC7sZBUa9A8KuO5LJnGP4
 BC3UEpsegXWWNMaV8DDuVdfhwYZ3+a0AHKnwC/pMRsihTDWavUdVYiodmByHdpZhaUZ8
 0ejnRmzO1xOvU93HntBphA/z3xmo7XmzAS8wjCB6484aV9k1PHlmXB9Abar4YPqCENvJ
 CB4Q==
X-Gm-Message-State: AHQUAuayoHbt2kwg05EX9dAoc/tdRcWmmhu+12KMamowsjdIZBNO6KGO
 OfidxiUza7KH7HDcxKeYsH0SnA==
X-Google-Smtp-Source: AHgI3IaKqQHIlQSbHjCIef9SP96WPBF+7Gbf0eBjwsGtNk0oWCABSQ0xiCz9fzqtvArDk7ppl+w7Dw==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr3278040pgb.249.1549972366416; 
 Tue, 12 Feb 2019 03:52:46 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id 10sm24244632pfq.146.2019.02.12.03.52.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 03:52:45 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] dt-bindings: Add vendor prefix for feiyang
Date: Tue, 12 Feb 2019 17:22:32 +0530
Message-Id: <20190212115232.4532-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_035247_928501_5AFD4C7B 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for feiyang, known as
Shenzhen Fly Young Technology Co.,LTD. a known producer for LCD modules.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: notation about using 'feiyang' is based on the datasheet 
http://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a5ad57eaee20..f42e12eb9d64 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -140,6 +140,7 @@ fairphone	Fairphone B.V.
 faraday	Faraday Technology Corporation
 fastrax	Fastrax Oy
 fcs	Fairchild Semiconductor
+feiyang	Shenzhen Fly Young Technology Co.,LTD.
 firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
