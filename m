Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDED5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9148F2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l0TvHEQk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X3XX+67r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9148F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=43qiLndImmSIYbfsuAVet42VC9fIUcL3DCa/wnPa4x0=; b=l0TvHEQkAN5Gt3Nv6YqIuiVnQM
	5fyfKdp+xukPU0mAsX0NLN6z1dVwDK6tjgLHfX4uM0xr3OW2svT/pA1yepMQVBlxcysoklJVmBPFq
	MSgN42kV9xoC2EoGDPMEawAUT4H6olD8PcGaFG9cYL4bcH0pDMHCfG8ZOKHu7HEc9IsiCz9FrkDIf
	x79tM4ug5dYAhUYVNq5yOqwOCYs10VRi+Cps9ij3oqqzY43h9sdBLmpmzB0udf7jPYlfepMicWIFk
	UWaw3pM+FPMnsCZ8YWEzkOTfA9plL46Ii04qZCZglTZfrgXIKu/CqcqCTSJ+cTQofA7T2scwoHVbP
	p07WQWuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUpR-0005j5-C4; Wed, 20 Feb 2019 16:34:37 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUp5-0005H0-Co
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:34:23 +0000
Received: by mail-pf1-x442.google.com with SMTP id h1so12145764pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
 b=X3XX+67reBKkrMvXlNfWVFEU+fnIh7nMlqCJx3q+OCq+BwKowbHjaL3mPaFV5NP3bg
 DMu9VViwbDfzjm0K9RyV8zhs2vzVHgPodYEG4L+14ss9ZE1bm+Hj5h3pZxBeLx4GwuKN
 xaqTKHoXLOaCrUjYAeeENs32xVXdYhLRhubt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bJTqQVyPqTRoZmzEJxDokZKH2fjNCLF3wrzuRLWaY7o=;
 b=OMXNUS/OvKt8nysYKJfZuaOvzWHflovD5ucSGVJkcLad5PC9N7sBfzOxQYSdziayzE
 tV04fX2mXS4IuPBn2FzLnKca7ZPBimEmG0CbTWKk8xu3xcQnz1AH7jgTH0qSqJ6pr20+
 kw4K6HRt8x+3H5UWxl6HAKgiCbJ4uZaeMH+VIi3uKLBM4cEs4/5L7LpUSGkLC6RDjpm2
 1WnzNJVHpIu6o8FbiGNr8OtPXnhPMb1T12L7t5IhUHdcnBrf1r929dqGrOuYtK/oXY5G
 +OQcyQyPyi4jfFzhu9AfvuAztWm3YcRrNcghMHmfXyLimX4CZvk/eLZmJNf1IdB3lr7S
 guuA==
X-Gm-Message-State: AHQUAuZwNcvwVLm0oPS68T9501tUECSEhBZjGNrStyHLumqDs78Idb7p
 Y5Mux3ZSAKWJD9j8kxPEsZEYUg==
X-Google-Smtp-Source: AHgI3IbWdOKn2kPVyPQZugoB9bJ8zsTbbKF6MSd1O++9KKKnaBS5MqwvPTgfHSG4QW1d4pK61uQzPQ==
X-Received: by 2002:a62:76d4:: with SMTP id r203mr36036679pfc.15.1550680454764; 
 Wed, 20 Feb 2019 08:34:14 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t10sm26556717pfa.151.2019.02.20.08.34.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 20 Feb 2019 08:34:14 -0800 (PST)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v3 2/2] PCI: iproc: Add outbound configuration for 32-bit I/O
 region
Date: Wed, 20 Feb 2019 22:03:55 +0530
Message-Id: <1550680435-9706-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550680435-9706-1-git-send-email-srinath.mannam@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_083415_813826_B494DDBE 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ray Jui <ray.jui@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Abhishek Shah <abhishek.shah@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the present driver outbound window configuration is done to map above
32-bit address I/O regions with corresponding PCI memory range given in
ranges DT property.

This patch add outbound window configuration to map below 32-bit I/O range
with corresponding PCI memory, which helps to access I/O region in IA32
and one to one mapping of I/O region to PCI memory.

Ex:
1. ranges DT property given for current driver is,
    ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
    I/O region address is 0x400000000
2. ranges DT property can be given after this patch,
    ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
    I/O region address is 0x42000000

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index b882255..080f142 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 			resource_size_t window_size =
 				ob_map->window_sizes[size_idx] * SZ_1M;
 
-			if (size < window_size)
-				continue;
+			/*
+			 * Keep iterating until we reach the last window and
+			 * with the minimal window size at index zero. In this
+			 * case, we take a compromise by mapping it using the
+			 * minimum window size that can be supported
+			 */
+			if (size < window_size) {
+				if (size_idx > 0 || window_idx > 0)
+					continue;
+
+				/*
+				 * For the corner case of reaching the minimal
+				 * window size that can be supported on the
+				 * last window
+				 */
+				axi_addr = ALIGN_DOWN(axi_addr, window_size);
+				pci_addr = ALIGN_DOWN(pci_addr, window_size);
+				size = window_size;
+			}
 
 			if (!IS_ALIGNED(axi_addr, window_size) ||
 			    !IS_ALIGNED(pci_addr, window_size)) {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
