Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237382084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzaZIVcS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oa/WRdXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237382084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vajknrDzNbabDTFKM6bEfbzZX2GfAw99xjkUmQxbKqA=; b=AzaZIVcSjw31vD
	RvFDA2UgPn2wuQvrfVudNKCsdwCRGZhEHfWQ8J9egQh1hK528JFD7WqrxEfwB1joDkULYGOOHLR99
	lB/azc7YdRQnxvdzs2yz4jCbyfuJXxQKMJiB967tyGipdOzjRL+6WJH9Xvz7ZboD0ac6seIPuJbxQ
	ZkJXaLcQBoDN3Ta7Ve5fi09VHmisQ1pwUcfqlS2eIbmo56RHXvTRIPgo5F3xYYNz+jXw0mg03Bi85
	vNnom4ojEHZxqxgRe57Fd+/XfLjpcAkodPQgdRQLHzZ7ptCMJhzH2EuliUtkqkm9PbJKasy1OwL5I
	JZqTPDZGwBEaGfwdgs0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwk2D-0006io-8j; Thu, 21 Feb 2019 08:48:49 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwk1z-0006Rk-RZ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:48:38 +0000
Received: by mail-pf1-x441.google.com with SMTP id n125so6138580pfn.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5iBvG4HqidiXxiGis5rvY71e0EFMSebp/Zntf2KFIo=;
 b=Oa/WRdXX+4W1q0fB/rVIGahugIrASieUZcaKxUUf1E/5TbKb9lwC4zhBD5NDipC8SK
 8HW8jRhnxT1cc0AeeKkw1KqJ8EL0NBva/AIJSK7fxVbCbNszg0SOwO87B/bviWxGCjLJ
 PIzTnoYtieukZcNJ3kWdbXX9PdzM5zGHUdmzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5iBvG4HqidiXxiGis5rvY71e0EFMSebp/Zntf2KFIo=;
 b=DD9OtnPaaSIGlOsXHG7U1p9H4GGinK8I4ike87fRW4LoIxwKz2OG1vRP3XaGfuMDxE
 UxJg3p0jF2MevfQeX4npht/rvvO0foUaXPk4raoA+TS7IdXv4YXM1WAkL10bhkwSoEgh
 131cMio7cZBEJtqRnkx5gsVGWmEZvW9ELmTGSJyYZvo3AZmRVRgkc+yIjm5zu0zRIB+q
 xTGEQ1LO/B9MWL4Ooxgnqgap8LKrfW2jDm2wntyYiSqNl1rQnHyGK2KyT6LiFDRbLteZ
 mD5dD5BbFdt345UxhrPXCn7Yi7S7CSyXHdxti3q4h1DOO6R4T/lrzpd4V8T0pFoDH1an
 Zttw==
X-Gm-Message-State: AHQUAuasCDJB7tagn+NatTVd+1jQKNhXfbiyNiOjUnRmjnR2cnjql0nn
 Qg1Nl2KkqJ8TwoF+VWOn9cvf1w==
X-Google-Smtp-Source: AHgI3Ia0m4hNRUVYGFbaW9a96CjS9AFRocoWSC9WAqTfUc7xQXwvjOlNc9NUoEvU2OUAMpF7uflabw==
X-Received: by 2002:a63:d104:: with SMTP id k4mr32626620pgg.227.1550738915080; 
 Thu, 21 Feb 2019 00:48:35 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.48.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 00:48:34 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
Date: Thu, 21 Feb 2019 16:47:24 +0800
Message-Id: <20190221084729.101784-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221084729.101784-1-pihsun@chromium.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_004836_108897_1A25CC7C 
X-CRM114-Status: GOOD (  16.40  )
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
Changes from v4:
 - Add detail of more properties.
 - Document the usage of mtk,rpmsg-name in subnode from the new design.

Changes from v3:
 - No change.

Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
---
 .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 00000000000000..8cf8b0e0d98a4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,37 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- reg			Should contain the address ranges for the two memory
+			regions, SRAM and CFG.
+- reg-names		Contains the corresponding names for the two memory
+			regions. These should be named "sram" & "cfg".
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Contains the corresponding name for the clock. This
+			should be named "main".
+
+Subnodes
+--------
+
+When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
+devices. The names of the devices are not important. The properties of these
+nodes are defined by the individual bindings for the rpmsg devices - but must
+contain the following property:
+
+- mtk,rpmsg-name	Contains the name for the rpmsg device. Used to match
+			the subnode to rpmsg device announced by SCP.
+
+Example:
+
+	scp: scp@10500000 {
+		compatible = "mediatek,mt8183-scp";
+		reg = <0 0x10500000 0 0x80000>,
+		      <0 0x105c0000 0 0x5000>;
+		reg-names = "sram", "cfg";
+		clocks = <&infracfg CLK_INFRA_SCPSYS>;
+		clock-names = "main";
+	};
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
