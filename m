Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E708C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F52A218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X0wSvrAp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gpnPyU45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F52A218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fUrrkYW7cE0Mhy6Ini6+jVMWht+gxErMIxpCAbagpXs=; b=X0wSvrAp0Ehrh2
	sd8EYuA7HpMACLas+Ihx3QM7AASYsY0qg5LmXXgs53vlgtNv2EORzI0yoNaWuQFGKsQPVOy+jw31m
	GDcFCi74/2gGy/J3EXMcZaUwpvGfEYwAl1O8j6W99AWoBnn+198Zj5/sx4SkAxMB/bTLrThrOGvFV
	aHZM2bIOpknA/3gdbLMS9i8bor5CWJECn++oh8wm5U7SczdNp3bgN7o4GyQ91S2cCTak3cRY2V/BK
	mfm8xz6+toe5wK0h3JwdxBNxc8flcG8A2zPOtbT6KLEO2j6EtMXP1ScC77C3eIjfZW/Bpm8pdv73F
	p5cZW7A2bg8uXLGv/rlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymGh-0008RJ-Rx; Tue, 26 Feb 2019 23:36:11 +0000
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymGd-0008ON-Sp
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:36:09 +0000
Received: by mail-qk1-x749.google.com with SMTP id b11so4967506qka.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xwLLkVZVrKsESATG/Bj+yNpM6E6f7I8z/W+5OcO4Kcs=;
 b=gpnPyU45bx8iW23CkthrrXNIg7y9cfb/upaEFJeu3hW1uLTedjfdGDJ6qPdJI27ZuS
 V51tPpHUtYM6unXtEM333OxnIXzeV2fi1JyJG4nAn6+7qtIQp07t1sc25I7qEz5VH44Q
 PJIPte+R7TtNHFGvIG1NVZgYzyH8qUO4CkHwtKi0FF+RMY585JZiyccKBjiHzO08gPrT
 vmoYK7gNVsR60vjwXbfBjskHFZl7UByIWCWtR6qYMEWUs7sZIf7MyCz35G4Q2b+pflor
 HoThi9Pe/cSqJmKuCtbjqGZqAywEzC3WK9w3Plqiltu8ZvAJi6hXa8pca1/iPUYdy6BH
 ZJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xwLLkVZVrKsESATG/Bj+yNpM6E6f7I8z/W+5OcO4Kcs=;
 b=lEW3qBwSTCfJkxzYD4N2jtCFrf4TBxYrupN4awNpUon8RHvORr9xUXnL9uvOq0ucC/
 8HxHR2f9JVUKgNnh24MrYh69jy3fBueesINNZ+Q9UNbCQRHHLixqDlXHhfWb7RbJ44yW
 1euaConNNNIB02TX7jhNIc19AaaFWfK3QCQp8OgkVeRZG3bcwIAHamegYLm3dDYBmxD8
 BBIB6sjIqu1OpoXJjAk7KbhjVy7akwXRmNLe47n1GXzL/sKFbY90A3Lyjhbt2zjnKdyW
 FaNgCVUBR3drXo/jXFR/6AFPijdIK7VxZ140gRb9QYSbf2PaSrdSGg/EZLd89IR08ef+
 cITg==
X-Gm-Message-State: AHQUAuY4N6Myfvmam2ZSoKfTCBv19JUT6QY52OsodAv16jAfPNX4ld8z
 UOeBIPSboITJnWMlEZnEtecIYhth1pCI
X-Google-Smtp-Source: AHgI3IZrTgR8opxWkUGsEGbDKGCRjFiXKDFEMQsz/Y26Suq94jJkJ3C2GcqzXdDU5BpYif6bW2i6FacU0mwj
X-Received: by 2002:a05:6214:1048:: with SMTP id
 l8mr14825293qvr.46.1551224165568; 
 Tue, 26 Feb 2019 15:36:05 -0800 (PST)
Date: Tue, 26 Feb 2019 15:36:00 -0800
Message-Id: <20190226233600.140153-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v2 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From: Patrick Venture <venture@google.com>
To: venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com, 
 joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_153607_993191_8ECE0DE4 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.

Signed-off-by: Patrick Venture <venture@google.com>
Change-Id: Ic89a2df0f555dee10598f87537ee004e82d13acd
---
Changes for v2:
- Added comment about syscon required parameter.
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..1092d62d1c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,32 @@
+======================================================================
+Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
+======================================================================
+
+The bridge is available on platforms with the VGA enabled on the Aspeed device.
+In this case, the host has access to a 64KiB window into all of the BMC's
+memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
+has read access to all the regions of memory, however the host only has read
+and write access depending on a register controlled by the BMC.
+
+Required properties:
+===================
+
+ - compatible: must be one of:
+	- "aspeed,ast2400-p2a-ctrl"
+	- "aspeed,ast2500-p2a-ctrl"
+
+ - syscon: handle to syscon device node controlling PCI.
+
+Optional properties:
+===================
+
+- memory-region: A phandle to a reserved_memory region to be used for the PCI
+		to AHB mapping
+
+Example:
+
+p2a: p2a-control@1e6e2000 {
+	compatible = "aspeed,ast2400-p2a-ctrl";
+	memory-region = <&reserved_memory>;
+	syscon = <&syscon>;
+};
-- 
2.21.0.rc2.261.ga7da99ff1b-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
