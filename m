Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31BA217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J1WnI7ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BA217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KvZM12QnsXmdhjzTyDYmIDHXG8Ve2AWLCD3VUHrB2t0=; b=J1WnI7kiu34LFK
	XgrHgoCtAR6+dH8//5WuvZynfLeirAGaF0gKhPiX56/j/mzFtHc6CRaVsWYMlK2x9RHyHYsYjQdlM
	K7tDOcM1Z+pKFagKcMKhOvdFuNc3Nu7CV40W82H0QjL+zZY2RNtkGdqs5tEO1SMmv0sU9IniL3VTY
	xnc8MLeC0R+l6TO9sHmzQ0u+lfn2TwGMI4bIGRCMjJvT8te+h2yrAQSPtZ6JKtIgiNyC36Uyahb6g
	gqADbzHCR+HrxZkCkSp4KOmoDLKboLSYMChcR36jxkcYw1Ot8vyL9eaIeJ7OTrUOPxQMn7QRLefI/
	WSDIgfBQx//cUSFQxc9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvgC-0001jp-3J; Tue, 08 Jan 2019 18:00:44 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggveV-0007EE-8h
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:59:15 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 52C0B100056;
 Tue,  8 Jan 2019 18:58:57 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id BCYiUlhQpEPb; Tue,  8 Jan 2019 18:58:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id A6486100052;
 Tue,  8 Jan 2019 18:58:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id exfZ-Ige95WI; Tue,  8 Jan 2019 18:58:28 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id A409D10004D;
 Tue,  8 Jan 2019 18:58:25 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
 platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 10/15] x86,
 olpc: Use a correct version when making up a battery node
Date: Tue,  8 Jan 2019 18:58:13 +0100
Message-Id: <20190108175818.705110-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095902_054996_86BDDCFC 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature. Add a different compatible string to the 1.5
battery.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Avoid splitting string literals

 arch/x86/platform/olpc/olpc_dt.c | 84 +++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index b4ab779f1d47..8557add82752 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -217,10 +217,28 @@ static u32 __init olpc_dt_get_board_revision(void)
 	return be32_to_cpu(rev);
 }
 
-void __init olpc_dt_fixup(void)
+int olpc_dt_compatible_match(phandle node, const char *compat)
 {
-	int r;
 	char buf[64];
+	int plen;
+	char *p;
+	int len;
+
+	plen = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
+	if (plen <= 0)
+		return 0;
+
+	len = strlen(compat);
+	for (p = buf; p < buf + plen; p += strlen(p) + 1) {
+		if (strcmp(p, compat) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+void __init olpc_dt_fixup(void)
+{
 	phandle node;
 	u32 board_rev;
 
@@ -228,41 +246,51 @@ void __init olpc_dt_fixup(void)
 	if (!node)
 		return;
 
-	/*
-	 * If the battery node has a compatible property, we are running a new
-	 * enough firmware and don't have fixups to make.
-	 */
-	r = olpc_dt_getproperty(node, "compatible", buf, sizeof(buf));
-	if (r > 0)
-		return;
-
-	pr_info("PROM DT: Old firmware detected, applying fixes\n");
-
-	/* Add olpc,xo1-battery compatible marker to battery node */
-	olpc_dt_interpret("\" /battery@0\" find-device"
-		" \" olpc,xo1-battery\" +compatible"
-		" device-end");
-
 	board_rev = olpc_dt_get_board_revision();
 	if (!board_rev)
 		return;
 
 	if (board_rev >= olpc_board_pre(0xd0)) {
+		if (olpc_dt_compatible_match(node, "olpc,xo1.5-battery"))
+			return;
+
+		/* Add olpc,xo1.5-battery compatible marker to battery node */
+		olpc_dt_interpret("\" /battery@0\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1.5-battery\" +compatible");
+		olpc_dt_interpret("device-end");
+
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1.5: add dcon device */
-		olpc_dt_interpret("\" /pci/display@1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end");
+		olpc_dt_interpret("\" /pci/display@1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
 	} else {
+		/* We're running a very old firmware if this is missing. */
+		if (olpc_dt_compatible_match(node, "olpc,xo1-battery"))
+			return;
+
 		/* XO-1: add dcon device, mark RTC as olpc,xo1-rtc */
-		olpc_dt_interpret("\" /pci/display@1,1\" find-device"
-			" new-device"
-			" \" dcon\" device-name \" olpc,xo1-dcon\" +compatible"
-			" finish-device device-end"
-			" \" /rtc\" find-device"
-			" \" olpc,xo1-rtc\" +compatible"
-			" device-end");
+		olpc_dt_interpret("\" /pci/display@1,1\" find-device");
+		olpc_dt_interpret("  new-device");
+		olpc_dt_interpret("    \" dcon\" device-name");
+		olpc_dt_interpret("    \" olpc,xo1-dcon\" +compatible");
+		olpc_dt_interpret("  finish-device");
+		olpc_dt_interpret("device-end");
+		olpc_dt_interpret("\" /rtc\" find-device");
+		olpc_dt_interpret("  \" olpc,xo1-rtc\" +compatible");
+		olpc_dt_interpret("device-end");
 	}
+
+	/* Add olpc,xo1-battery compatible marker to battery node */
+	olpc_dt_interpret("\" /battery@0\" find-device");
+	olpc_dt_interpret("  \" olpc,xo1-battery\" +compatible");
+	olpc_dt_interpret("device-end");
 }
 
 void __init olpc_dt_build_devicetree(void)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
