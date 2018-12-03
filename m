Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1D32087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTNmrOpe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQopV02n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1D32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UjFOD9SYt22f+kVYuL/fH/rwMeQtcKEv596IWCdlvzs=; b=pTNmrOpewFEgCe
	qH9hKBaJh3Qib6j/22XuvpKKgMMN3B4UaQ4Ji929gCLApfuPBpKu+nBcQ7WO7X6DdLxpY/S/DPHVb
	Yb4K1u19/nGd6os0hq9cvqRlbLt+yYS+DN3CFHM4POsO3ySUoMsuY9iFYnzh5OYKFS92FC8FLDqIV
	0vWkXGEwUnnTfY/Y3QvrSO64AcUpHLUxezA77dFKKp9/uvNA5N741evxaQ/yX+rx6vQVEBVdlMVKU
	YLuPnsn3WNqYU6T2hMpmzcUAE+fcmWa5QN41mUWunLVgNLsjYkCIXEdf2QANO+gZMdNH48v37yfQS
	ffqu78BqEYZWVxnrb/uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwlf-0000Ql-UL; Mon, 03 Dec 2018 22:32:43 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkW-0007ax-BL
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BgwOjYGaUM4jacGS7tw342B/DTF9EbMnkpVRYFr+pqY=; b=hQopV02nXRjwnfibZC1qI+gzVQ
 OXThJSN4w0wHkn/Loru3u+UJtVM1HN3GM29hMDwpJYjPWvu1vfTOgDxDAhwplAmRzD2GmjsAAiZ//
 l7jP4aJZyItrR5PCeNNuDjaAQsvVZEMJWdWnytlwU005Z7PwgsUjLQISeLHbEKZWDu176Fk4hjMSu
 HoI7+6xF6AZxyKMTSeZLK8lN/xdyezuPzIenP+EqujnBjg9+OYNCeMSnroUTKyqI3vjXzWYGJfVKt
 EwtICERRj4oizMq9XPbQtPxdr0yqURoc3jqyPinq34c3DLWQEO3JjnmiSk7GU+yxqCMEG+4jf0QA6
 8uWqcJmw==;
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq2-00036z-Pi
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:11 +0000
Received: by mail-oi1-f194.google.com with SMTP id x23so12358715oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BgwOjYGaUM4jacGS7tw342B/DTF9EbMnkpVRYFr+pqY=;
 b=ksnBnK49eQa/xFE1uCdiouFOyBvnQNChzaYbFv/CPBC3xRLs6MCJAHjcxVN9Am53St
 I3ILV53iRLElNxP8AfjjH2dlgcgTzqizAbxKN5C9nmERJH1ZAOtghCDflpDP6eMMplJb
 xg/91JFdLno5i5bmO9F6vTSrVOjBA2QwmVRHBbS7Fth8Axnfdx81Z4W0ErQFJLrmanNh
 VA+1NfJWBi8vtJKDZzZbRnXsPz9/+5JUkePoUcfRxlUUmFFeVb9EPyuXW9nPDP1vB0Oh
 vCo8o73KO4mYucRguAnAW4MAPX9MSxrmTd4Ym1bJ/Sl0cBVjtNsHnnBdOzjsjNgUFOjX
 xJqQ==
X-Gm-Message-State: AA+aEWbyfVMEXHaZdXaCbq25V7Ots+r7NqZVQ7R23CYSFObfzwV8eH5S
 0MUHdWyF9E3cf85tXzEzgA==
X-Google-Smtp-Source: AFSGD/VgCUDrNHBT/uGjxuTWorLqCSCE7WshaNATuumRyWinarPM3J+GZiUM/gI/C1Xz4hhKTjWr0g==
X-Received: by 2002:aca:e283:: with SMTP id z125mr10414602oig.23.1543872785413; 
 Mon, 03 Dec 2018 13:33:05 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:04 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/34] dt-bindings: arm: Add missing Xilinx boards
Date: Mon,  3 Dec 2018 15:32:22 -0600
Message-Id: <20181203213223.16986-34-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163311_019479_291B290D 
X-CRM114-Status: GOOD (  10.59  )
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
Cc: Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>

Add missing description for Ultra96, zcu104, zcu106 and zcu111.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/xilinx.yaml       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index 64cd21b737af..c73b1f5c7f49 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -70,6 +70,14 @@ properties:
           - const: xlnx,zynqmp-zcu100
           - const: xlnx,zynqmp
 
+      - description: Xilinx 96boards compatible board Ultra96
+        items:
+          - const: avnet,ultra96-rev1
+          - const: avnet,ultra96
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
       - description: Xilinx evaluation board zcu102
         items:
           - enum:
@@ -79,4 +87,28 @@ properties:
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
+      - description: Xilinx evaluation board zcu104
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu104-revA
+              - xlnx,zynqmp-zcu104-rev1.0
+          - const: xlnx,zynqmp-zcu104
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu106
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu106-revA
+              - xlnx,zynqmp-zcu106-rev1.0
+          - const: xlnx,zynqmp-zcu106
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu111
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu111-revA
+              - xlnx,zynqmp-zcu11-rev1.0
+          - const: xlnx,zynqmp-zcu111
+          - const: xlnx,zynqmp
+
 ...
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
