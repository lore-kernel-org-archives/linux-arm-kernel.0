Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29AE20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jq0B8bzY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVXX9YUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29AE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mgi85IpnFcBg9ijywVDIGNrcjwwz0hbdKseS6g5Byvo=; b=jq0B8bzY0P6hWuU7joMhrFnhJ8
	0v1rzSw9R6fpClTmezsxMfuNutkLaNWXmyYrWtU6kxslKplMMR5Se3QUU9CDUIg9yxBpSyhjYAbvf
	P1NmJGmm6nQafV8kF/35f333hkh2zAgt0qlWhAJiHLKV+SIvQxid96fTn/ABMyB/R2XAlqyA+Qn3G
	jqJSIHf9Sh3Hebrb2fkYfmtN8A4VIYAhlWKqwKA5CbB6JR5SySz8+tTSaVcsZNPfoQHDkMFi9gSjy
	nSZEqGRBg5cYDPFOe6BGJqUx4O/fbhD9kxh//c//3ho+0fZloLgM2uD3bHRvrvvBVX3VNOYk63pb1
	1lXJlMUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjTha-0003tU-Dz; Tue, 15 Jan 2019 18:44:42 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjThP-0003k9-2S
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:44:32 +0000
Received: by mail-pg1-x544.google.com with SMTP id v28so1591401pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TtWJIG9DHX8rBzM5ORFS81BvPd0cvEPbKrsCQLC4nJQ=;
 b=jVXX9YUrSm/xZtDg/5o9+YVQ2q7TIz2h9LvZWGWrkKSObKgAa/P48+BkyCS7vq7crU
 v2lchY1ClGOdbk1O3t7OVSogfbRlNaVhGNyiwnURO4hu3wuifD2zWW0QaMx35G1auAH4
 BUqr+pi0BU2HRKE4P2CCQDPoSDYkRGnIRFMUvkpGCrzcvASJf2giNqmOxE3e4ZPqgkmi
 cqgT1v8ghIJp88p1S4lWEiofQ9xpjyLJc4UhYMrV8XVkpodtmVch9i4jIhG3BKrDnQSC
 ++1Kyd3/qPhpi9FhQTWWtILuRsq68XYRcM7Ar1ziU9WfzSjjJzhMsAEofNwDcGWh4TLc
 tHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TtWJIG9DHX8rBzM5ORFS81BvPd0cvEPbKrsCQLC4nJQ=;
 b=bzD2NABB+z5yhEEHrUg9vtd+4N+pNAjfLwlKrf+oyRwWlbHO27WdQQQYouBoTNEwD4
 ilxjPDK6enoiyBxEsKZI8K8TUqFp+9xMwXZIWw6TKe8Flhw8JuGylN24r9Y7WbomFdj9
 sf6fTLXqsDkW9zYhS/N58F1iwF3kDHc7kV3Z2P4yQAh2tjbKDMkLsAAwB01wUZGWCmaD
 cWF7ikshfmjPTv4GFUTXThFGVokKmuh9Qb3Jod//s8n0ylZNcyNZN8un0ZBhKojoPX/o
 zgV6mUw/NRuOEzltRu3FZuC2BF+0mZsT/rnbvD2oC4Hp3RltCCnTchBr96X3JSQFG6By
 l4zQ==
X-Gm-Message-State: AJcUukcGEXsbZEm2NE6kB4BztVObd6qaE8qZqK1ok+klI+B5l5W+50Nk
 OxcA1vn8Km38Kz0wUkx5iVc=
X-Google-Smtp-Source: ALg8bN52k4uoOXF4b1ts7nOGJmtf6spsbkUrT78jEE03O8uBWS+RmoBW1S8QUKynAESj23oH/0nIrw==
X-Received: by 2002:a63:2315:: with SMTP id j21mr5038901pgj.297.1547577869575; 
 Tue, 15 Jan 2019 10:44:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id m67sm9156950pfb.25.2019.01.15.10.44.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 10:44:28 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Date: Tue, 15 Jan 2019 10:44:05 -0800
Message-Id: <20190115184406.3164-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115184406.3164-1-f.fainelli@gmail.com>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_104431_111015_13808971 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a binding document for the Broadcom STB reset controller, also known
as SW_INIT-style reset controller.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/reset/brcm,brcmstb-reset.txt     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
new file mode 100644
index 000000000000..6e5341b4f891
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
@@ -0,0 +1,27 @@
+Broadcom STB SW_INIT-style reset controller
+===========================================
+
+Broadcom STB SoCs have a SW_INIT-style reset controller with separate
+SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
+reset lines.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: should be brcm,brcmstb-reset
+- reg: register base and length
+- #reset-cells: must be set to 1
+
+Example:
+
+	reset: reset-controller@8404318 {
+		compatible = "brcm,brcmstb-reset";
+		reg = <0x8404318 0x30>;
+		#reset-cells = <1>;
+	};
+
+	&ethernet_switch {
+		resets = <&reset>;
+		reset-names = "switch";
+	};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
