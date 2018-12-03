Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF6CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29202087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGYwm8A3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A9XOQzTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29202087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IyMdNVEFmhbMZaO8RCr8c8cDxeSWpNMSRQsY6+QX+cY=; b=eGYwm8A3ZYHw4p
	NKfRFxH4VhKBAfLmpR6Y8H92RYRe3yvdcDNcIb7tcpRAlE5KIf5drl7xbkfU/YYfMx2t3I+JaT7qj
	SY3Wm6r38l0p9X+r1JEZ4CqXpauc6VfjpwVBMoGO3pJwwDyozBBXsTrR0tUW0hnc9j86YILiWUU0+
	h0Y9JN8r2aIix3iP8ebLzZtFdcBXV88XhoJQQfcBc3GDyXTyPlN7yvxzxxCB58L7SYrHd7mH3i9El
	l9etixIN3B16AsXVXx8NGBnBOkoYqW4YIIrdBRaUxFbCIOltqBeHYP8Gqc4cjn2PbKOybX2l1OHbv
	PtHZWciLESpjfl4dgMVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwkZ-0007jG-Iz; Mon, 03 Dec 2018 22:31:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwkQ-0007ax-3y
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 22:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KeZnuus+ZQpEVnlN+wmNEXJ5n6BcAmDK+P7WR/GWygk=; b=A9XOQzTohXf1MjBVDf0TKrAvW7
 kftv/qxXwG6XwIbsy9yBHReK1fxUqc1ePns3rdX59vikcIWVD/WBPvBO1YZc6IpPbUAG6GmD4yQ0/
 GukhAx29TfaKYDKqkQi94aJvgi9YE5cNTm81MMaUCn0Q8kjWDjSmUJtgQG/2fmRTwlll1kA0uSAAK
 6Kj90vUx0l0gY4z40yiioqKoiqyed8QtHVs3XSjnqhPJJmyZIH5lcA8EFO89Sgc3c4jsmZZ4OwAZh
 2DUoYCYq0fxxJKL0CNeU/eviSvSvSzUhTSdfPQ+JQ4mnrEKE8hWInIvub11Xp5fKUPqPm6IBO7D+r
 xlaV/BGg==;
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvq6-00036U-8q
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:16 +0000
Received: by mail-ot1-f66.google.com with SMTP id f18so13096992otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KeZnuus+ZQpEVnlN+wmNEXJ5n6BcAmDK+P7WR/GWygk=;
 b=NIZubPWo12e6sY1EtvIsbicFuHMDl9rEWGUltmlDxaSR+i3l9v9+FX7h+ynJP2jEgJ
 ZvQF9rvIT3zLu7mn55yD64VKa0Nouk25SfHkgDfCRSQP/J6iP2xJor+xoMqQ7TgMweZ1
 TItjICbUEVf6I/RCIi7+br48BEL+iuo1ySO9+7p4OgAnBVCO5Eseb+q74UOtWrbkdimZ
 t8u5d/NHxnB5YiQaaFEjESSzfaAv4AlYpCQZL/+q30eARNVT/vi/8saMC7H4zqMC5pyB
 j6kod2ZJhr/dSrknnc1ntsOeJcqyqH5jQa4f9qUQaVxTQYdrCF7OxcSfJGrkODQce6aB
 d23g==
X-Gm-Message-State: AA+aEWa1n2SjlsOQznsMN4PO/kW9gdWgRTZT5uo5cELeH3LPtOK+pDUn
 mYkkpivvFP0Sf08fFo7nsg==
X-Google-Smtp-Source: AFSGD/V8cy+kF23PRCwPLdfrTXgC258vUtxGnyrueIzMgRY4FRj1ivgxz+4E8hQ3j2jzF4Ma1D46Tw==
X-Received: by 2002:a9d:439d:: with SMTP id t29mr11843807ote.284.1543872783148; 
 Mon, 03 Dec 2018 13:33:03 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:33:02 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/34] dt-bindings: arm: Convert VIA board/soc bindings to
 json-schema
Date: Mon,  3 Dec 2018 15:32:20 -0600
Message-Id: <20181203213223.16986-32-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163314_418146_108AF24E 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Tony Prisk <linux@prisktech.co.nz>,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert VIA SoC bindings to DT schema format using json-schema.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/vt8500.txt        | 22 ------------------
 .../devicetree/bindings/arm/vt8500.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.yaml

diff --git a/Documentation/devicetree/bindings/arm/vt8500.txt b/Documentation/devicetree/bindings/arm/vt8500.txt
deleted file mode 100644
index 87dc1ddf4770..000000000000
--- a/Documentation/devicetree/bindings/arm/vt8500.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-VIA/Wondermedia VT8500 Platforms Device Tree Bindings
----------------------------------------
-
-Boards with the VIA VT8500 SoC shall have the following properties:
-Required root node property:
-compatible = "via,vt8500";
-
-Boards with the Wondermedia WM8505 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8505";
-
-Boards with the Wondermedia WM8650 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8650";
-
-Boards with the Wondermedia WM8750 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8750";
-
-Boards with the Wondermedia WM8850 SoC shall have the following properties:
-Required root node property:
-compatible = "wm,wm8850";
diff --git a/Documentation/devicetree/bindings/arm/vt8500.yaml b/Documentation/devicetree/bindings/arm/vt8500.yaml
new file mode 100644
index 000000000000..7b25b6fa34e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vt8500.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/vt8500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA/Wondermedia VT8500 Platforms Device Tree Bindings
+
+maintainers:
+  - Tony Prisk <linux@prisktech.co.nz>
+description: test
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - via,vt8500
+          - wm,wm8505
+          - wm,wm8650
+          - wm,wm8750
+          - wm,wm8850
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
