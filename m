Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76037C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487452184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAzNBns3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD2iCqKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487452184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OSTcTn/JE2HGDWuK5o0FhT+3fYw3Igc2W9lo3dGcX2c=; b=LAzNBns3rTqkLI
	FCsdQyd3HdUnrhCFUdpgL/nfQEd+LLwQqFJNIuyahNWJAlHX66AEPiPEDXVoTHe+WCLlxIU53sVyp
	Sxg/yjExagB3QYfhMfrN7oHRd4Nxhzj5HxCvX7zFgNIl4X7RK5QhepVvED1YV43Mpz4XoxZROWKRs
	nIDnybIFFFwFHA8SN1vvwdU3EmKl0X2QvmYMi7+YYEZTUus5VCaahieeq6UEn9YMuzua8UsWgZVxV
	svkv15J26TFUK3QLOpo92nbFudJ75n2BniuyLEvLb8IgaAGL+Toj/qwXOQvPkUmepey/YiX93QDLQ
	0Q0hWbL1VEr1AHgi0trA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmydv-0005Ai-4g; Fri, 25 Jan 2019 10:23:23 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmydY-0004so-92
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:01 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so6152354wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=anWHXks4dR3RctFPJDIM8I5pVVFGH/mgn1vBtB1zbps=;
 b=JD2iCqKx6YiQZ49L5m5ABVOCvBp/L7Hyx/RwgbAgjPYQfEpFKuiqyJrmhbLB6pOSe9
 +b/FuO8mPK8PQurECfS3WdVUV6iLp5xPd1P0J+zmGbe1yxnZQ0mcwL3Y6o9KAix9VU8R
 pwYfIp+yWAyM5lk3uy7ca4opoxp8UXsJZ774R9X7NzPzsf0+isSUFXqWPw5m/76JFrmu
 4dgiFSWyAtzm2+/sgV8Py8OaDpspIJbdT0THT8dgsnuE/XzNAnia6VC/XUpVz495X5bl
 +odasVOp+mOncjsQuZadB1MUHvw8KXZVfF6r6eAcHNKAA6OxtgimWQHa3ZgqBN02USy6
 xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=anWHXks4dR3RctFPJDIM8I5pVVFGH/mgn1vBtB1zbps=;
 b=gzrOkcoXkqL/SpcRlqnDK38xf5QP2OCSoWRLgQLyZtMHaQcxCN/ThRhbHsMPB+wAYu
 pUAsqgfgGyGocNbXza1rhwVy3Hv7+DFGJf9tBFcwS7Y+A3OjCN5OQ8GpzxeYPdK+JYJY
 d2RcQo+Vrq2h6GumouRLAdobOr2ED7N9EbmO/Josn4i8Z8G6mT00f9sCCtrlPTz8kqBF
 26DGNVAn1/e4yF/0N6kPe749jc6L/4Cpq78wv+fjk6kLYpkpwaitXM+v6MbWklucGH7V
 yN+UZXFLa5QZ3o/xqbQFzrIqEa0mq/DWul0I+SDXPE/FpTUi1RXd3dTck+1Ae+VdYx+b
 bPSA==
X-Gm-Message-State: AJcUukfDI11EafNtcvSYy74YTGGpUzmGQN6EmG3aWJNKrVo10FqEmjxF
 8j+yVgWxMFAUNOIqRXS1TlQ=
X-Google-Smtp-Source: ALg8bN5ngV083ol3MKiz3HILmEr7Ybs6iHbMVPMmGxcVV5h4L6AtKPjePIqDRI4MA2+8TmeB1bMWgQ==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr6245864wmj.14.1548411778447; 
 Fri, 25 Jan 2019 02:22:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id x15sm141761591wrs.27.2019.01.25.02.22.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:22:57 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/7] soc/tegra: pmc: Add missing kerneldoc
Date: Fri, 25 Jan 2019 11:22:50 +0100
Message-Id: <20190125102255.6862-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125102255.6862-1-thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022300_313076_44387447 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: linux-tegra@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
 Stephen Warren <swarren@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Some of the fields in struct tegra_pmc had not been documented when they
were added. Add the missing kerneldoc.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index cd865be3b195..550653302ff2 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -273,6 +273,9 @@ static const char * const tegra30_reset_sources[] = {
  * struct tegra_pmc - NVIDIA Tegra PMC
  * @dev: pointer to PMC device structure
  * @base: pointer to I/O remapped register region
+ * @wake: pointer to I/O remapped region for WAKE registers
+ * @aotag: pointer to I/O remapped region for AOTAG registers
+ * @scratch: pointer to I/O remapped region for scratch registers
  * @clk: pointer to pclk clock
  * @soc: pointer to SoC data structure
  * @debugfs: pointer to debugfs entry
@@ -291,6 +294,9 @@ static const char * const tegra30_reset_sources[] = {
  * @lp0_vec_size: size of the LP0 warm boot code
  * @powergates_available: Bitmap of available power gates
  * @powergates_lock: mutex for power gate register access
+ * @pctl_dev: pin controller exposed by the PMC
+ * @domain: IRQ domain provided by the PMC
+ * @irq: chip implementation for the IRQ domain
  */
 struct tegra_pmc {
 	struct device *dev;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
