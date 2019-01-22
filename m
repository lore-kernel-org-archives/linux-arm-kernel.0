Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96111C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6303E20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VItY7r1V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICkeb7HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6303E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BJzzTRqCNnQ8JjV1uPZ/GR38f0cOxqd4O1ghOIG56IE=; b=VItY7r1V/oxpgp/k6S1AvZZT9b
	1szG0QN0SYARdc9P8D1D8kKC7oAWHDsI5JaUJC4sluLT7xgIUJ9IYXUw5XQAM1NwWxHs8+0+9R8Kh
	I8He4bo23ZlVaXyZ4VPUDgwQcVDOd3vN0Dxf1+VXAMMc+6lzozYg3VohiYmGhLKygA4YvJ8bWiyCc
	zDnwS/SuBE3U8O2j3CCB4FCrXC//MdK9OtFraeNM+zPOOnSzSDHRrFEnilCJvohpzxuSkQQfxVcnr
	Lzegh4FqX0yx+D33L/W7Qk//lC32aVvpk/ZIzuZ2/aCphjzpP8QAhZiLMySi/+T9OzqXj0w79p+Ox
	yRvafELg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glnZq-0001Er-87; Tue, 22 Jan 2019 04:22:18 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnZd-00010f-4t
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:22:09 +0000
Received: by mail-pl1-x641.google.com with SMTP id t13so10783391ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qh9OH2ewndXqi7LmYpIulU5BfBE/yUMVvx34aUuKYu0=;
 b=ICkeb7HRNIH9VLfwNSH+e9HuXwGT5x7DgnnfjwxgUJrUM17uD5HgT73ahqxLOeGTHu
 FLJhMxTvCnvZ510Ay3ZCHeXKDuJSGqcJWBpmLDnc7woc9NR0FUbO9DvlvMFu6UG15fl1
 XcLpLTRg3AQVGIpgn6ZWXYRnrKm9GJZF7q16E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qh9OH2ewndXqi7LmYpIulU5BfBE/yUMVvx34aUuKYu0=;
 b=V99w/BbA2i+3W6SXNfNMi/UJwNjmlg9ywK0y66OU7dp5RT2UjyPxqSorcJCc6BwFZk
 k1/0b+V2b1RIESh/5l0NcQo0GqZYJmQtgMdHWmbBdTjo78bhdiWTz3eo/kOpp05D94Bm
 WDjRtdpmMIiaSYIlPrDHe8W8XWajNJoIYlAcz8NKhmc2Vg3vdZkyUR0izgwwtCiBJYSa
 wSS673HAmQVspcWbXuDEtvxYeEkzY3K0I/9kRrZQ09cxFt6SOs7gEF/HUjFpcL6Q8+z4
 S7EU18bgz0iNx5p7qpOr5XxKKbxYK3aVPxjPS0C97XfV4zfIF1/g9wBB/jcsgdKEk/YM
 DauA==
X-Gm-Message-State: AJcUukdvCwtDM3DHYPqtK5ea9ZKzkse44FSnmw9ip1x8JI7GDke3PMrZ
 qtodY+hpw5zCwDx3mdB+jYhF
X-Google-Smtp-Source: ALg8bN6+W9kfH9ubBJQ+oNWmtl6QwFd+5/vhMV/fvcYNf3EekCAbeAmIvchON8qbdu0113MEFRwU2g==
X-Received: by 2002:a17:902:850c:: with SMTP id
 bj12mr32192473plb.46.1548130924334; 
 Mon, 21 Jan 2019 20:22:04 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id q199sm25083953pfc.97.2019.01.21.20.21.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 20:22:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org,
	leoyang.li@nxp.com,
	robh+dt@kernel.org
Subject: [PATCH v3 1/5] dt-bindings: arm: fsl: Fix bindings for LS1012A and
 LS1021A based boards
Date: Tue, 22 Jan 2019 09:51:43 +0530
Message-Id: <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_202205_311319_E77FCA59 
X-CRM114-Status: GOOD (  11.52  )
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

Fix devicetree bindings for Freescale LS1012A and LS1021A SoC based boards.

Fixes: a1a38e1f4d1d ("dt-bindings: arm: Convert FSL board/soc bindings to json-schema")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d34fe0749199..20fb61006f2b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -173,12 +173,20 @@ properties:
               - fsl,vf610
               - fsl,vf610m4
 
-      - description: LS1021A based Boards
+      - description: LS1012A based Boards
         items:
           - enum:
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
+          - const: fsl,ls1012a
+
+      - description: LS1021A based Boards
+        items:
+          - enum:
+              - fsl,ls1021a-moxa-uc-8410a
+              - fsl,ls1021a-qds
+              - fsl,ls1021a-twr
           - const: fsl,ls1021a
 
       - description: LS1043A based Boards
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
