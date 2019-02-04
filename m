Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B00C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440A02081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lkpsoTZN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FIKgrVow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440A02081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Y2D24QXU6tGgh6cLh7tR8NpXgpayNVKSGBji+wIRFHs=; b=lkpsoTZNJd20RUe4aDhAS1dGcc
	h+0oM/FWNcCB3fNoqDhCYdPBKLsJP3gbJJah1aZZvYw/pYhbExosqZgiPNpXiDC8xJ7FmOdzXGphk
	3SZF0QI+w/MVjeGzEYhUAyjeVVF0PVtDO/DG69CSdf6vEQ0heHPmnyeauIBaSUPRo/o/kfkbUNJco
	ukd+HxVUfm94XH8QNTggoCYQ/FgZ2eGovelHIbLh5vBKS7WrLXa0UcIl1fGA9fgml7+g9MaYisy2R
	rl0KucVWga82yeeq1tZd4Ki2eGurtVIaFxbg1pmFPFlMZZgbLOXnwYPiUKaAhp6OEu3kh7rmpn6Ww
	5IxCHH9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnUw-0008Ek-3R; Mon, 04 Feb 2019 23:17:54 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnTY-0006qm-1m
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:16:48 +0000
Received: by mail-pl1-x644.google.com with SMTP id z23so662283plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a7MzBPjh33iBCLs/1GM1JkRcNR8aZ6QrK9iw1qmq9bg=;
 b=FIKgrVowW6CfM0Y9NwQ082rA4bqUiM8F5ayBQQdQx9KezoF/7lvegKdpr+U+Sq6yFc
 Xa1EtvxEuO814TC7tSUEw9/ipcVJeTLOSX+tnIFG0Oo6ZXypo0NjwcqnjYh/SfEVJNRL
 Qs1PFTydyPvNLCHAu8JcKoPVZbZThlNEGQLaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a7MzBPjh33iBCLs/1GM1JkRcNR8aZ6QrK9iw1qmq9bg=;
 b=EdXZDzrn2/N0iofROPXkCnHjbqDmLo87qdnrPfsRldveiLV94UYwQ1L4EOvpsNrVsr
 emjD+FGWTc/xAIM9MCS/mN9WZjyAcn+7wNmzv7uMuO5LEi50BC1JRgqq08THrw03UT5A
 ES3Mk61LdEOiFIvL/D2meu1Nt2oTWZWhuTPuDHiKGibXcpf/oXCizQTZWgW770XCDRPn
 fJwCEVDuo5a/KZPALXR4KNaQErxGHhi496NZpaqeInDBziOrZRngG+oEAu7qmfRGxc5k
 69xhkIjIDJPJqeNfSUtg2LeYQTFqPtLgtTZOjNdr6Rghc7NBv6jhfxryyV31VQbStxw3
 /8Kw==
X-Gm-Message-State: AHQUAuZLv47vvPoNTMd//UCwY4Uf8iJMQjHSHLEP4zv+FjwEBvmHAcMI
 K5JVZRmTT75fSP8zyMTp2DOo8w==
X-Google-Smtp-Source: AHgI3Ib23vBnlx4Cct0sztg0qclMcEJbcJJu7Mkp0p/uxl0JTAIGFkmeNFcRmn+c1nOIQymn9ttIuQ==
X-Received: by 2002:a17:902:1101:: with SMTP id
 d1mr1929664pla.136.1549322187393; 
 Mon, 04 Feb 2019 15:16:27 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 15:16:26 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,
 iproc-nic-i2c" compatible string
Date: Mon,  4 Feb 2019 15:15:52 -0800
Message-Id: <20190204231554.87666-7-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_151628_443971_F57E9EF6 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: devicetree@vger.kernel.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index d3a3620b1f06..02e82d20239e 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -24,6 +24,9 @@ Optional properties:
     Should contain the I2C interrupt. If unspecified, driver will fall back to
     polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor
 
 Example:
 	i2c0: i2c@18008000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
