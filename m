Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A0C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5EA217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HsCN0pgv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F01ENsqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5EA217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BriL2X/psex0N03F70Z0nHkPxAzVrfUamrYIIsoFht8=; b=HsCN0pgvMu6Lv+
	u6jrcr4uXXa6hC3sWFPnabsFtAD2UgNgjMwe0naSo/BbgfRNHSTA2IJo9x/1TOWCVNfX84R43O5Sl
	6gT9/Wr4ZCv7tz9ixTt4Qn2V+BwQS2s4zZi0iucLVUpp/dje/Rky53CUOLHZrbaP/vf7EhOPaDSA8
	aZFyBjGbPbXPS2bJurG4tHegQFozaaqn9EFQHtEB46wgblNCC+XqQtPbZmds/jOdAhNpqV2H+g1iz
	rJ8fZsEh9T6o9j2Km+SAbtnKNEdzWgt82SWvo07rsD1Q5DgtfNFEYJVH+R2G42Joj2SnhPeejgQYk
	GhvI7pVel3vW0onZlHaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGzK-0001IF-74; Sat, 09 Feb 2019 00:59:22 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGzF-0001HN-G4; Sat, 09 Feb 2019 00:59:18 +0000
Received: by mail-wm1-x344.google.com with SMTP id x10so947616wmg.2;
 Fri, 08 Feb 2019 16:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DGa6W9vj/kUe70sQNoT86/G0huD4FXwnKFkVKgNXoQw=;
 b=F01ENsqK16OGY4RxNKc2OMzBwf5yrZ4wCIwWQNO/4LYg6MLIEJlc02wPBw38WP9955
 82iyOgVKyl739KuDZSYORecXu0aFYc3Q22CiolTLTRiVaazZLddybRDZq18/YOafuZMT
 /Of/WJq875aZkhs3/AyHXXeMPmGswnLHTBU7nfVOtTQxYIp0RR4j2UbOHLQwiLAAjkIu
 4RDTuG9dYBjBnxkS8jJGohfe17c3JhIPUVVt9BTvWNKO1gUNALcJSQUcpRltbAQNuliz
 5QhGOIlvSKCi8v8yIdeA4MhapXGJYhIRGtt7Jg0qfeBww6uoAtPP5Y7QjpxpqMsyUlhu
 +czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DGa6W9vj/kUe70sQNoT86/G0huD4FXwnKFkVKgNXoQw=;
 b=aJrsvuV37uUIcnFlyR9nhY8JM7DxF12BTrNYP1xIHQ2iCKyag5olvWZzbOqleVdQll
 xOqdhYmnY9X8MStvX/J8jeewQYeMS/YlPXdmEBS49bU3BMlpwSBcI0mhCp8J7ygs3ro4
 PSyE2pFVRCts1Z5wkbBEQKXk/2MX5uv6ZcT5ccBqV5g/oIXLL2fg/PsIsn1SfoRK4das
 RPZFMaBgSqsyf9Lzhgr9MNmMG204YbzSoiFMONFq/J/Ob7jhMp5zaNooCZX4UDRgK4XE
 NeVSh3XiUa2jNg+k+yQG1da7phUdb52iGKSk9vm8q6prfotyNHh2Xec7zSuLMZASWQ4C
 rEtg==
X-Gm-Message-State: AHQUAuagQ9h1Z9EuFUC7YWALD5+kj9k7fvOqXH5JBXC9bhfoZOEgNawq
 5IikijqQtpzdWFAx0FIXC5Z8XDDe
X-Google-Smtp-Source: AHgI3IahYwaG7K5cuPcQT4k4GJabsekXAkbkB/xF0Km+P0CJfaT1QoD960AjYh+fBRPNoCwkKcH/5Q==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr843180wmf.111.1549673955796; 
 Fri, 08 Feb 2019 16:59:15 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
 by smtp.googlemail.com with ESMTPSA id r14sm4927201wrr.65.2019.02.08.16.59.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:59:14 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCH] mmc: meson-gx: fix interrupt name
Date: Sat,  9 Feb 2019 01:58:50 +0100
Message-Id: <20190209005850.11457-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_165917_564106_88E4DEC9 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: xademax@gmail.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 repk@triplefau.lt, linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
changed the _probe code to use request_threaded_irq() instead of
devm_request_threaded_irq().
Unfortunately this removes a fallback for the interrupt name:
devm_request_threaded_irq() uses the device name as fallback if the
given IRQ name is NULL. request_threaded_irq() has no such fallback,
thus /proc/interrupts shows "(null)" instead.

Explicitly pass the dev_name() so we get the IRQ name shown in
/proc/interrupts again.
While here, also fix the indentation of the request_threaded_irq()
parameter list.

Fixes: bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f19ec60bcbdc..2eba507790e4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1338,7 +1338,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
+				   meson_mmc_irq_thread, IRQF_SHARED,
+				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
