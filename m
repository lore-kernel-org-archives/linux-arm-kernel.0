Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28803C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BED21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ne9KbAwx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOZAmER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BED21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KNdfAG8bJskVuPSqkdhfgj4dOHEkcDtSJLpk+XJUJJk=; b=Ne9KbAwx4j51CxSGYJcNcauMt3
	FJYrcfec6DJzS7LXslEmyo1fbUYXR/gMYqlPVSf8NS8+gezmnlhNyPoSs8pYhlfnxnccICY1jpp99
	OPqsopk870wfvPTrjDh1Y1HIRN5Cg/KeJ3ZAfNmzWIgrUVXzF+VUdqkoM0g7+VCO/yqJ3TnJ+bSpy
	3NL99HdIrmYoD8w2cwZMvYShYMmCdW878JFf0sZR9ff4G2haiTivMttSlNk/6N6HiAp59wKC1sqjB
	JavDECDJZvH/SYYLVX79PmUTEdD+wFafGaka0GR25gwZBvHmNyTOmfgVEljEXD0qmsHRFg6xkdWf0
	e9YKyPXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYHx-0004dU-4u; Mon, 24 Dec 2018 22:01:29 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHa-0004HI-Vq
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:08 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so12540883wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UVK3picnxEN2rlJmIqzlDdlyx6P0B1CQOZKOVIBWBms=;
 b=PZOZAmER3sPxNMpPc/WXdL58IrIRLODqkUw3bojdeQ3GkKKKPv/h7ZsT4fo+4z/hS1
 PHOHfr9KEYDp31+vpVyKdTqZMC6p11vhcTZ8dx8BGDPlocuDSExLak3tvlbd/uMkgJ6y
 eGN4wk74qAh2ref8/V0EiEIUsPTKoSI7+THMjI2gnxO5fSDKjTPeyoEzxFAFJtwkDTTc
 gSdVf9ECJDf5gsqOJpNMCI3RN/gAESsQe0jkz+ZcMgVkyBoWmLRTgIVvYT69Jv12p+xq
 oMSN1UE46oeqdAuO24TcBqZgiCWa8iQNBnJARoRt+blAJdK++QsQjTDGiH72mLgytrqH
 //+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UVK3picnxEN2rlJmIqzlDdlyx6P0B1CQOZKOVIBWBms=;
 b=nzyRehhq04Jxm7YkcsCM2QAYyjP3MMFLMqv6uWZNKqy/lI/RQjDeUbHsLfkhaF/PCV
 AsUd2XWZ3U428THaRUD5bi/AJsUZf9m6TD/8H7xNzWtZCl713MYD9uAGQ091HsNGhOS9
 jxu4dO0nB+/Z+HRez0Qiyze/+oIkwj5pBLN5CFITnEZ+zLmzigzJwvAJ3hM3WFSWSWuM
 OinaRnHEIizOgFMn0SSIhWM0Qu6f2gCVLTmxoUmjv78s/iPZ968s3I4GnZ6o8QJO/mqL
 LmAK9tklB5CEhlHDOLqWsp8YtylpEDYh/BkX8R+e14xVpQnXKQJi136l+Hl+6V9F7U77
 h9aw==
X-Gm-Message-State: AJcUukczFKo8rbJC+bQV2plIJkjPXkr+UJh1piUYcZvfJqnBnmxjk0bn
 2YffPPSP/o1x+e43ac235HE=
X-Google-Smtp-Source: ALg8bN467yOrdPebH2WOjaiAY3PdvXhrHguy4lWN8PvunBAYBSuw1x0bianSlOoMdTk17vkTGh5xBw==
X-Received: by 2002:adf:c505:: with SMTP id q5mr12824650wrf.84.1545688854136; 
 Mon, 24 Dec 2018 14:00:54 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:00:53 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 01/14] spi: stm32: switch to SPDX identifier
Date: Mon, 24 Dec 2018 23:00:27 +0100
Message-Id: <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140107_029014_7C088E3A 
X-CRM114-Status: GOOD (  13.35  )
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
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d..5f30578 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1,23 +1,10 @@
-/*
- * STMicroelectronics STM32 SPI Controller driver (master mode only)
- *
- * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
- * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
- *
- * License terms: GPL V2.0.
- *
- * spi_stm32 driver is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * spi_stm32 driver is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * spi_stm32 driver. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// STMicroelectronics STM32 SPI Controller driver (master mode only)
+//
+// Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+// Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
+
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
