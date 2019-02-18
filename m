Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA04EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:58:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85502217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="De807xF2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlpwVPBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85502217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7oym0ozDIdabPpLcP9GEBoVCxqJI5pSxYOip1I8bnc0=; b=De807xF2ynu/Lm
	2VtYaDP9a3bwQTxGoFmRXNgo38GoSWlZvC2rmIjBNwIJj3gC+NQ3gTB15FuVrMLlOe2PwBqD6cdyd
	hvB9ruK+J9IRoPnLgHU2rUmmHCMT5wUf2VLb2NA/je2IN/6zH01w0DtjFGlZH7rk/G2DLpgVlNuFN
	Dio56K223supXuyRWgTEaQ+448a9J77/owzfZl7qGcQSgcnLetBDSW0imscbW2j/xxd+aRubzBfYd
	pVZjvKdu+muD0oxgUQKSxwhxkZRAFU/tuWPTv2ZYp2FBKZ9qC8n04hynWL7ppdKVS2kbCIRw+pfKi
	02yXnJr4BpZzzDH57BvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhYt-0002qh-P2; Mon, 18 Feb 2019 11:58:15 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhYq-0002q4-FR
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:58:13 +0000
Received: by mail-wr1-x442.google.com with SMTP id o17so18063770wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6TIaFkRBRHes/6rQuhJJNnE4CEePMbaav+3orK9pd6A=;
 b=PlpwVPBuWE98ntuh7Yhw9sdryQvJoZ5pVcMumFzCVaxGLv09GFsZdtqnweeqtMGMZ9
 dS2gO4vPRtb9WZyI9EbKM2e2kHEbu3mM3KpIhWijSVcTTlKtzSLd7d4iXBktbhpxrz14
 h30NNyHgUcc7Kqrsl01Z0+jwkNU7B21uFSSWyBevRiw7UxScKZ5+yvGURymlC7TjH2hR
 axf+UsYd/hCcpDIJrAL5qGMsYwGhz490sTALtBSg02N9+ErrpHHPmbXe7ekgQ7W9s+ju
 /k5fGW9JP2Lc1HuTbn0r3N184mcvLMHgrMmbpkRzuxQnCA8btoVYucC/ddyhCydgmE6z
 7m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6TIaFkRBRHes/6rQuhJJNnE4CEePMbaav+3orK9pd6A=;
 b=el4cXt77qm2f6EfGXlZ/XIzOyy4JLKWhIEXkSnlEDJD5iCyJqG9ZXGaLGuHYdkHu68
 dun3zUdLKqNw62sdEsyy8slMc44YqOPEFb27jKNCB7UHav64nnfMmQYZSXhqrB1UI7eY
 RyfcN8kN6ll34WNmIHX5FTPPR8WShVXDfaeIKGixxSlHUfOiyOLeG/BB9JZD70FtC9i2
 ResOcuyDDLbW6uX06CUYHs8NMPxigRWoEtC4VLqG6VpVcfRj24+zxynoowFJLua/4WHa
 q15DXfYZd2uQcIJ+bzevpa8bbKHyE7v88bR4CJWtv7lg91I8KTfVDWWxRJXiIX4oVqFU
 VbmQ==
X-Gm-Message-State: AHQUAubBipHMCG5pIwCZYC2FL2ma00ixjAsvv1gL646P9mbmFXiHeqAc
 WTULTEJLlHqAR/w3ptyMDR2XaiUp
X-Google-Smtp-Source: AHgI3Ibvz3+P6fchtXo8AV/xdXAq0CXWwrq/TW0+WUXZ/mj1mwHe6MjQqvKS6cKbcEPNd17IHAE5wA==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr15394355wro.266.1550491090091; 
 Mon, 18 Feb 2019 03:58:10 -0800 (PST)
Received: from localhost.localdomain (85-169-74-166.rev.numericable.fr.
 [85.169.74.166])
 by smtp.gmail.com with ESMTPSA id n3sm15003295wrs.10.2019.02.18.03.58.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 03:58:09 -0800 (PST)
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
To: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
 catalin.marinas@arm.com, linux@armlinux.org.uk
Subject: [PATCH] Make ARM_TIMER_SP804 depend on (ARM || ARM64)
Date: Mon, 18 Feb 2019 12:58:05 +0100
Message-Id: <20190218115805.10969-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_035812_517024_B69D4D73 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: David Abdurachmanov <david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is only used on arm and arm64 platforms. Other timers also seem
to depend on (ARM || ARM64).

After I moved Fedora/RISCV kernel to 5.0.0-0.rc2 it keeps asking me to
add CONFIG_ARM_TIMER_SP804=n to my config. This patch resolved the issue.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..7593d80e1c88 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -369,7 +369,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
-	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
