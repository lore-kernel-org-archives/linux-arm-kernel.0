Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56B213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUCk8FPA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DfXlNEUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5ZTe6UJwSZg/z1bles0bq2Tb36yhsLHcankHYZK8VnQ=; b=ZUCk8FPAAIfi7G
	ia9eZbHLJUNOW9f7JdSG5hbKeeTlRe6pqSTY0hg7gpEgF31Ry7Ge9mBy2B55a9hPIop5dVQesfro5
	eItVrSPQd9b1Rx1x3TndHECjIJ95GEOk4FCctB0QW4dOpIt0pAdxbtuOLoKnPfFtdn4TEaA+5bW5S
	oAXAECFF/vslqnwBZwLJ8R2fR19dr2Jdq+StXqUfMhvBAXpfOekO1F24WL/iYoI77fhxy2GnXWLb4
	VL76VyzCMSI8mlIy1Ms6AO0uPlK01GSFp3TrALlcB4TCq30GujPw3ZXjbAbIA5U5tUW8yJ3QonI1H
	g5rqpR3FXlO5FuA2EkDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyVpT-0002Uf-00; Tue, 26 Feb 2019 06:02:59 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyVpQ-0002Tq-2n
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 06:02:57 +0000
Received: by mail-pf1-x442.google.com with SMTP id h1so5685043pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ts+gw7kSFMO+AcwOSg4xR5ZxcHxVFhftHYNFvGSUC4o=;
 b=DfXlNEUmqzEWf2OGimMIod8UcHRGp9NFyfSJ7t33nN+Ax6t3TpUByM/RJVWhrNU7w1
 y9GYbRUd33VYa4Vc/p11Trgea1CbL3iNFnIYlSQvP2Nrw5Z08HWCOaPGbOo3J+BxJST6
 K39gK1wc6gUS/uwyxwPhHL9hL4zd2bj4wNl6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ts+gw7kSFMO+AcwOSg4xR5ZxcHxVFhftHYNFvGSUC4o=;
 b=EDwnFc7/EYEBo4SgkDjyd9/VxKmlC4l5bqhvkeDeBMOH/+OLS3y8kMfr0wpVzYpri5
 6FIM7XaxTwqIjdqNmh8PICzNoFp4WbxMxl/68IrHa/a6LM8EM9tVCqJEQMFCZP7evcsu
 4zLkhA4swtIK3nFm/abib6hTqzZZObJC+mmRFYf+aV8HHTrBZsLmsqrH2JWi5jxHBb3R
 8Tw+t6MP3pDyR1mKX1Cq8JqOzMDxQK5Jr8j+LPBaCeemy1alfPeFnbV9XWIL5zE8V3dP
 DE3wo87h9e8nBNoPFJBwvpepmpV73rXlcPQiw0U/rphRxXDAzwem/db/P3L2Tid5y1Nx
 naLg==
X-Gm-Message-State: AHQUAubNHA+/eMHJkrUc9sI3NKB/pkHECLDofhTQVFjK3ulMh2/6hQgL
 O6vZNsTnoxS3pJndpTNOP79C8g==
X-Google-Smtp-Source: AHgI3IZaSSiywoY6Knnsw3CZAaqPceMk0S1UuklAerlE5MyYgWoJBPb0gK+7mip0wCgBMByXlN1uSQ==
X-Received: by 2002:a62:1b92:: with SMTP id
 b140mr10536064pfb.159.1551160973116; 
 Mon, 25 Feb 2019 22:02:53 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id v15sm18976940pfa.75.2019.02.25.22.02.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 22:02:52 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] dt-bindings: Add vendor prefix for oceanic
Date: Tue, 26 Feb 2019 11:32:39 +0530
Message-Id: <20190226060240.8783-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_220256_288988_579F6112 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: devicetree@vger.kernel.org, Ryan Pannell <ryan@osukl.com>,
 linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add oceanic vendor prefix.

Oceanic Systems (UK) Ltd design and manufacture world-class marine
systems for control and monitoring vessels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f42e12eb9d64..5b551407f487 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -285,6 +285,7 @@ nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
 nvidia	NVIDIA
 nxp	NXP Semiconductors
+oceanic	Oceanic Systems (UK) Ltd.
 okaya	Okaya Electric America, Inc.
 oki	Oki Electric Industry Co., Ltd.
 olimex	OLIMEX Ltd.
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
