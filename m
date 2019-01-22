Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C59C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A090921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZO2DW3Jr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifqNeXZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A090921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XITe0xF2ZVxHNNE+Axj4kqkU89I0n9ELVsHZwGjdtRk=; b=ZO2
	DW3JrdRiQ6zUzanv1+H4PtDNPN0fPSc77E2Td09nYRed+bAWyUYWk7aoHizVC1CxIktkF/mOtaewJ
	e861SErARNEd/MFgdE1EoIWplon1l0yio9ThkchgmQsit7+2pdyIRU/Gun7wQlAxOB7C/mUPjHUcf
	+Ox2xFdjEq3gig29r+LqVg/uONFkzld7ek79Q/jDPCAgauxq8td0KVHtyxaN2evEwImxqHWwLrjAX
	u8ANwYR7I+KQLxhRMobTsIesucRsCSNn2JWLPm7oazZtECwzErWcewFH/nI+QFS02hTm1p9vrB8v9
	puy2WjdcLOUHt7js+dGtkln7rrJtfXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glvzt-0003L5-BG; Tue, 22 Jan 2019 13:21:45 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glvzr-0003Kf-2A
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:21:44 +0000
Received: by mail-pl1-x643.google.com with SMTP id gn14so11479654plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=euK4ZIyk6B19PT813VSDOnPJkx4d5LHCeMqPJd1aM7s=;
 b=ifqNeXZWBx+cSJs+BkrC38f3XF88AhaIyImBMv0oNKRrpwVKoNXtInlwfbqYw0UebY
 +4EH3Ry0FtdIIDBbkAC/8XAds81tNArKoVFQLhRvfGLJLLno7l4BP+zpVtIQOvVYCxfd
 UeXzZ3Hewmv+k0WwxS+vGHQykIMx64UYi/3z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=euK4ZIyk6B19PT813VSDOnPJkx4d5LHCeMqPJd1aM7s=;
 b=WcXa73rXu6dRQ2Q5Ts3/GHf/Ms94o+rxLDaklZQBJgCvt/+rZU6V89irDP1yiX+7u4
 nRoUbYpWoeERVMDsatlnVZqmwwAODGe9DpA4HNoK3bQoc39ekevHwh1rYwuPb3cbxKMF
 Ee/r6DOG/iiIXLvlDdnOA6bpHqKrWmn2ZBH3knCIXWJXTWJACs6307kyZ0PzANEyAcKO
 QA+lB5CD4vpU5YKidETGprTPr361BB1zaoTymkhYZEKMg1kIkyKT4cHKqjbuz7djUrxk
 e85O42SVa8dSQwzMx79d9ay2XuBnrueEwdaxWK9spllq5PZnuxWkKVw7619wmeP0n6zf
 bUvQ==
X-Gm-Message-State: AJcUukfg0H72j61upcBUVbKeyI8BBH7/ancx3h0mbgBlqYPD07pv3b62
 yN2aRrSwTNKmhZOzw3mVhtkiHA==
X-Google-Smtp-Source: ALg8bN7o9RYueCBe0lZNaR5aIq2epf1WyUYhHSDbVeRj+xDQpH350xWmTJItTx1o4/fQxRnAchpVDg==
X-Received: by 2002:a17:902:583:: with SMTP id
 f3mr35085581plf.202.1548163302104; 
 Tue, 22 Jan 2019 05:21:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.37
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 22 Jan 2019 05:21:41 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: vkoul@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
Date: Tue, 22 Jan 2019 21:20:51 +0800
Message-Id: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052143_102710_C7E5593A 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: devicetree@vger.kernel.org, eric.long@unisoc.com, arnd@arndb.de,
 baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The DMA engine clients can trigger DMA engine automatically by setting
the corresponding hardware slave id for the DMA engine. Thus add one
cell to present the hardware slave id for DMA clients.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
index 7a10fea..7812cf0 100644
--- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
@@ -6,8 +6,8 @@ Required properties:
 - compatible: Should be "sprd,sc9860-dma".
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel.
-- #dma-cells: must be <1>. Used to represent the number of integer
-	cells in the dmas property of client device.
+- #dma-cells: must be <2>. Used to represent the channel id and slave id
+	of integer cells in the dmas property of client device.
 - #dma-channels : Number of DMA channels supported. Should be 32.
 - clock-names: Should contain the clock of the DMA controller.
 - clocks: Should contain a clock specifier for each entry in clock-names.
@@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
 
 Client:
 DMA clients connected to the Spreadtrum DMA controller must use the format
-described in the dma.txt file, using a two-cell specifier for each channel.
-The two cells in order are:
+described in the dma.txt file, using a three-cell specifier for each channel.
+The three cells in order are:
 1. A phandle pointing to the DMA controller.
 2. The channel id.
+3. The hardware slave id which is used for clients to trigger DMA engine
+automatically.
 
 spi0: spi@70a00000{
 	...
 	dma-names = "rx_chn", "tx_chn";
-	dmas = <&apdma 11>, <&apdma 12>;
+	dmas = <&apdma 11 11>, <&apdma 12 12>;
 	...
 };
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
