Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE315C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9AF2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gF/9ZZA4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KWb62IKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9AF2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J/++qGBiaBUiRmPILyNcD90oXi/iXIjbesmUXWGl4kQ=; b=gF/9ZZA4l0up8P
	jEhG7yqgbH7jIIBqj+6x9WqSmVZDYp/+1+tNy8h5fhq+t0AjLEJMaMOaKvBmG6pjTJVhL2+Jw5d6c
	wu9uG/C+uTav+FVNF3eQp3iewfPWLNmWLhK/8LeUpltaP9C9/7H37PX196tED4nDDupG4+o/9YYp/
	ZxEOKIvaaTVahbm4tzgpbl2zbMO3kBGwkOgliX3lCek/s7+P1Pn72C6kML8/N2FDhIF+0MI4fHn8H
	VzXgv4ZWirVQrCZYYUaXJOTZRGE1Ix/EQ62UJAJO6EaMsLS2UMSqEcAUvlnqrAP3yGBK/s7McPQgS
	cfYfZyCLx8GYVXOIahwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goNGw-0003Pb-CW; Tue, 29 Jan 2019 06:53:26 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goNGs-0003PF-6o
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 06:53:24 +0000
Received: by mail-pf1-x442.google.com with SMTP id r136so9235259pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 22:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LQebTt8H43w58ILFzzWdklfMJ5I40KjUTMdOq7rdPFs=;
 b=KWb62IKXiWKhZpzBR8DwI1E5tKv96JQNKSVA3HWamq/f96y0fgaH5NzT+jDS1NoZB/
 oaJyLCzDdvw3s2D/wYo7uwrPU91JPZJGYh9n67NI51zNYnsjfSaVCk9dtnc0f3co/T08
 I5L4f3ZtV4ruzdK4sRFXMm/MQ0ouqArUBQwP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LQebTt8H43w58ILFzzWdklfMJ5I40KjUTMdOq7rdPFs=;
 b=HaYW5EWbVhGeQGR3L0h/n1PAN86ZIj4RdmJQe8b0xYe57QrD2VOsbwKC6agSJ/agqI
 1QMZO/nAnPs2+x/22Qssma8HTlHG1HLMjm+OrTZ0xAm1+KbjNOkny52SPt9iU2d0SFzj
 6/tP4cmtDw4tg23FRLYY+ZTn1U0DFVJPhgViLQvAQFUiqP7CGKoDKgXSU9M3gUChEoX5
 5bGHGpoQWFO8ksG4ln3WEvwNiHz6QoYFnBJ1YcZ4hi99tyGmaPsR4RjMWfRaCOg7o53C
 Gx3bhGtEN89lnwEF4dyeQhwtOxXUCU0/+dGSjhNLw8nut6GD4OroOSBjNnKBpGjkO5Wm
 fIgg==
X-Gm-Message-State: AJcUukf7e8YIRkqRYOFXjOGqwKWoD70q8muo+o9/iN/5xRPK3AKGsKlr
 tUbIMN0Sl5wD3GOYjxzbRiBNAw==
X-Google-Smtp-Source: ALg8bN657+CEbbS0IlTk8zJ2gcvw/FJegOHunz/N5mbCLEFgVXk3+RSwZX3CbEOJTv/xtDnwUaQbYA==
X-Received: by 2002:a65:584e:: with SMTP id s14mr22655054pgr.142.1548744801283; 
 Mon, 28 Jan 2019 22:53:21 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id d21sm40091825pgv.37.2019.01.28.22.53.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 22:53:20 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] dt-bindings: Add vendor prefix for techstar
Date: Tue, 29 Jan 2019 12:23:04 +0530
Message-Id: <20190129065304.6396-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_225322_756547_E43A174C 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for techstar, known as
Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 88dcdc04c8c9..2aa2688b21a5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -392,6 +392,7 @@ tcl	Toby Churchill Ltd.
 technexion	TechNexion
 technologic	Technologic Systems
 tempo	Tempo Semiconductor
+techstar	Shenzhen Techstar Electronics Co., Ltd.
 terasic	Terasic Inc.
 thine	THine Electronics, Inc.
 ti	Texas Instruments
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
