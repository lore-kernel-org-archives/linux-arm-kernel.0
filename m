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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A17C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723D42184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGbABfA1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy4/4YPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723D42184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n4NclGtm94lDOdOO8oLpOB5tMtPdHmli+UKCFd/PxIg=; b=OGbABfA1qW3EjF
	rMNvbs1amLR8UqJgauLC0hReWZ717v+6ZbgXbU0STny+M7GoCloDAv1DDYfpbcJH9MQFiePqCutYt
	xYxRSoreg73oovy8NvT2uEswPX5omQhvV4IB0ytH61d8xBFlUJFtWyM0WA36iH2fQr1PwcWzPIJYi
	R7UWp/a/cwyGY56evZXtCpIAl1gCujNaMOP7rBDSMdlbvj1S7xCFpUU3GlaI6LKHWhs0u//IzNlXs
	zkzprL4eyNr7zbwurGpllWV77Erhn4QU4p+/1pUQYoQOENu0IcZbDAkpkL0k2gUE/xRhig+dct2jn
	fVRy+OrYa8QCI3CCWDcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyda-0004td-8n; Fri, 25 Jan 2019 10:23:02 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmydX-0004sj-3O
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:23:00 +0000
Received: by mail-wr1-x442.google.com with SMTP id p7so9722723wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JEtUeNiTn5vNFe6J3SPAnRRWUa20e0l+oIS0yYQZETQ=;
 b=Cy4/4YPwyTb+C9azbTEsneInzEt56kYkJMtPWZz2KHEX3MijAZPGSEyyB+MCP/evL8
 t0XpXV4U+CFv8jpdGNE98PW3zGIoNCTS/nrA8VRW2eEl5sHLqTciD9hfHMktRf6Xev5H
 XrAI0sBh4VmwAROl4b+iKwcKmPhPDu0qH8zBz8spmszWWuNTGXZMChrZQ6PQmId7cKuh
 RdvgZbqAJb4mf07uefzblr3alCX+8j2gjdcQaDtxzcWHKfnMsbVqhRyXsbSOUCYVBulI
 WmcGHeOxT56b5FLz0OYnawVjz6rBTQijS20GPUdDvr34jSIB3XyU8ZYRdKrQ8KBSyxID
 vkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JEtUeNiTn5vNFe6J3SPAnRRWUa20e0l+oIS0yYQZETQ=;
 b=b2KK9jDhFo5n7LxDF/4kTR0VBDKj7tR+9X8APNZwfcyFHB3L18RWUp4+vJwNCGFopa
 0/YayeBwkgTGys+4NzpjMyatBGjFJccjQfdPQT0Fwce4YzZWdkR/gdUINu4oYWZ+C4dK
 8zW9xXRfSg4rF++UPjaLzuum88pApAwALeIBE2GTp4yOuJ765xNRYC5GVRb6DMq9B9Zy
 XsFfV8PNi0LU+NxkY4FPwMDmIrHdN4FjLSasOIk7/9ttXfqD1DfygAkN2QpJoDF7FUQD
 Jw3bNXfPhUiZ3dG5zToXo8od7sW5xMdAKTYM/wGUg1N7dsWnBEOJ1uC3mvasDXcVLuOd
 cRcQ==
X-Gm-Message-State: AJcUukdDbMvOdLg++HuzdmJZkn/qU/LrrmyjoXNlGYup89tXyegtq1Uk
 XMuEQVmjjV8jbxbJmw3U48zo1Iq7YJo=
X-Google-Smtp-Source: ALg8bN5jwC/HPQA0odeUESW2Dya4zZot6IPlWj2lO+9E1FhwkuaAP4zEEKnYynnRZ+SakpYxrtQYww==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr11109427wro.262.1548411776970; 
 Fri, 25 Jan 2019 02:22:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id m4sm40433406wml.2.2019.01.25.02.22.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 02:22:56 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/7] soc/tegra: pmc: Sort includes alphabetically
Date: Fri, 25 Jan 2019 11:22:49 +0100
Message-Id: <20190125102255.6862-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_022259_137458_A264EEAB 
X-CRM114-Status: GOOD (  11.15  )
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

This will make it easier to insert new includes in the right place in
subsequent patches.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 7ea3280279ff..cd865be3b195 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -20,7 +20,6 @@
 
 #define pr_fmt(fmt) "tegra-pmc: " fmt
 
-#include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
@@ -30,16 +29,17 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/of.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reboot.h>
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
