Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7103C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A665E21928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDnNZOP2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IhlLw0Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665E21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fFX6KZcb4B1++TGo45galqcJpMz8bn8ggjBpV8ZqXKI=; b=tDnNZOP2nmzR7SGemw4T5Zfdcg
	QzLmW752jbdRjkVblb/SjANIdIka7g9mgzGz/lz/C5+l9VhRMkTLTyruTL9aWzu1rr4Xg/GYIonNR
	vse5nWM+9S06GzlIdBPatWPq/k4Bk8Zg6Vu0dHdk7JzkMqdtETeRtLdXvkIf9zuUF4W5ez01jORY6
	A1W+pdF3rLXoxfjk/FHe6vOfJI2v5FsJpgU+91gySRcyaT0Qh2Cm8bj6ftwiUO0lVy1c1CYBgJKeX
	UhFVydkEeSuQ0ZCXe6b3H5oBJKC4yO8YKEImml07HooYQ0AxXEhvvVQveo5ofj8P0VtEwTGv5DDK7
	Wgepklfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLH4-0008OO-2u; Thu, 14 Feb 2019 17:58:14 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLGj-0007xD-HQ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:57:56 +0000
Received: by mail-it1-x143.google.com with SMTP id z7so17265790iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qd5kI+SJawXscvy5gQFO6CdGhw4ESxIavmw5z4kZ0JE=;
 b=IhlLw0Jf9Ut/A90TYhXhoRD+hkewG/boZsw/12RupQo+z5Z0IcUcQ6SvcCS5o0M4fU
 3a/A3P61va0qcZohzWHF/mb6bHmZj71/KwYLFpsATu/igCw410WnKmbBImRzWOAuUzyP
 wkWOeMfjI0nf2SO5efto6SnXCdzcpoBOE5EJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qd5kI+SJawXscvy5gQFO6CdGhw4ESxIavmw5z4kZ0JE=;
 b=mo2dvvXY5Aj3Q2lnpX8XkDX09dnZZ5J6OEvgrKq4VziB1kjAMauD/ypP/jVfPOUz2W
 KCdZwtorI+go3Pf0IHCEJBL0kq1OcvofSQ3DhcHxLFNPGEKvHvkopnIegXUq6fxb8PBk
 LLkVAJeWZaz6MeY1S0pZVeBYhGQ7O5X8VLliu1dC3NG11wR348u3ihJtMoi07/goEoJq
 0OyGHTp85gYz4/scPzK1facFRPhiWSCyPaEX0e6J4kssyJxVZipW0hpaMSxwspy7Icrq
 81IcrYQOchHSH60ZYZnbJUpWLF1rsbr9BGe3VP5PLxe5lT/7IV4ezV9JAjtg5fRQIX6t
 tWxQ==
X-Gm-Message-State: AHQUAuY5R3T9Fu4U85G5q07lVt0nKtN5CrSkhABVuyajQ2FPLccYeFKH
 TkUaQBbF/fjjugXL49YqqkuehA==
X-Google-Smtp-Source: AHgI3IYC8QBY5QAdgIeyfE2U1qAUURc9s9naP+Q4N8K1ULjptwjVPqo1znC2pqepovVwCFVkNkiplw==
X-Received: by 2002:a02:9c16:: with SMTP id q22mr2884177jak.49.1550167072510; 
 Thu, 14 Feb 2019 09:57:52 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 09:57:51 -0800 (PST)
From: Ray Jui <ray.jui@broadcom.com>
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Date: Thu, 14 Feb 2019 09:57:20 -0800
Message-Id: <20190214175725.60462-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095754_305285_F830E149 
X-CRM114-Status: GOOD (  11.51  )
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

Update the binding document to make the 'interrupts' property optional.
For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
interrupt is unwired to the interrupt controller. In such case, this
'interrupts' property should be left unspecified, and driver will fall
back to polling mode

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..7a32bf81bfa9 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -9,9 +9,6 @@ Required properties:
     Define the base and range of the I/O address space that contain the iProc
     I2C controller registers
 
-- interrupts:
-    Should contain the I2C interrupt
-
 - clock-frequency:
     This is the I2C bus clock. Need to be either 100000 or 400000
 
@@ -21,6 +18,14 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. For certain revisions of the I2C
+    controller, I2C interrupt is unwired to the interrupt controller. In such
+    case, this property should be left unspecified, and driver will fall back
+    to polling mode
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
