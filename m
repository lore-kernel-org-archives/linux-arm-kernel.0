Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410AC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A09208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srukUc7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A09208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hu8nZOKQXrNN4didRGH/Bo40YJB1MHriMtSj3lJtujY=; b=srukUc7I9eLcK1
	A3uTgrfliPRODPxHXmqZQhtyw4/lQKV/7QyCqg2+my6zQ6QF2/CLDYPjdMuAhP0b1pjUjyaP5t+tY
	yvV0gRNGEHzsTHJWABwodkSo42LcUv1MflVbPTM5wd7X0pLSgl7lnFbb82GssBxfuXayc0dxQgJur
	7EywVgzlkaA1yW3NE0YlldfMyB+sqL9aWf+Rz84qS4+6OCpPkwEnmsInsPLFCl7tXM2a8448B8RtW
	d1gHF/MmuGG2eHo/wMgjDz7fp9aQaSR0OyC3J/qkxnK/qCotgZrSp4ID9n2ismilrR500sH2vBs/r
	c9R79eY1Bv+jHgeJWB3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZ8Z-0007aO-LC; Sun, 02 Dec 2018 21:18:47 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ8S-0007Nk-60
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:18:45 +0000
Received: by mail-qt1-f196.google.com with SMTP id i7so11621952qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=PIRobWtQDTidBY0OtSgvsKREHVVLQzE/zslMsfs7hHY=;
 b=NPZIjx72Sgonu+SrgoojCxP2PYqOG/Mk5T9z7p02aNLzRG9Zqd1BxmNaNFHvlkuOUo
 h8DyGh737KRfQf8lExGcf3as+gpty2xIWWHsJs7sRnI1rDWjBCJTxsrfleZch1TO+oIj
 BNob00V3BE5net4zWNab3OpkltFmn/Ohlrvz5ZdWKB2Eb4fn6wN5D4BWPG+Ia9zADOH6
 YBIHWTce7yuJKA28KO8ijKaP8jdS5Jv4WCWCkafS+rrCVwpjol0eYQkjIEwYVOOhGSgb
 V6XBVWD6Blojmtn0vbdlksjo/LRsP6GKnavS75y+Nx7pJlMvHzrRxUSxofz43aB57TSW
 xM8Q==
X-Gm-Message-State: AA+aEWZFVWKxHylsNRMbnJzcNaS4pvV7LykOs3SXBLnc5FGC2wsyKuTd
 32TpAqcVoedyfoRJBWXRlVEdwDtq
X-Google-Smtp-Source: AFSGD/VhxR0IFsX8OzRANQUwHHYqIH/ugpLoo8odXmm4LytmcmEI666Ek4ylnyx0B3KO0WcZgbNwXw==
X-Received: by 2002:ac8:2281:: with SMTP id f1mr13112012qta.197.1543785508591; 
 Sun, 02 Dec 2018 13:18:28 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id v42sm7643714qth.32.2018.12.02.13.18.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:18:27 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:18:21 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ARM: dts: imx6ul-pico-hobbit: Switch to SPDX identifier
Date: Sun,  2 Dec 2018 19:18:05 -0200
Message-Id: <20181202211809.11621-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_131840_627540_915494C1 
X-CRM114-Status: GOOD (  19.12  )
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
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 52 ++++--------------------
 1 file changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 797262d2f27f..1bc4fb4b4841 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -1,48 +1,10 @@
-/*
- * Copyright 2015 Technexion Ltd.
- *
- * Author: Wig Cheng  <wig.cheng@technexion.com>
- *	   Richard Hu <richard.hu@technexion.com>
- *	   Tapani Utriainen <tapani@technexion.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2015 Technexion Ltd.
+//
+// Author: Wig Cheng  <wig.cheng@technexion.com>
+//	   Richard Hu <richard.hu@technexion.com>
+//	   Tapani Utriainen <tapani@technexion.com>
 /dts-v1/;
 
 #include "imx6ul.dtsi"
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
