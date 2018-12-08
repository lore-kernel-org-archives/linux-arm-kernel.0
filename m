Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:04:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FF62081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kdsdy9Ox";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU17DI2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FF62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16H+GtuS5H70UAEvj6dSdT3neVnIeFLnHVsl3VrE5PI=; b=Kdsdy9OxxdOCj5
	EPaQEEXMMeqdgNvrVpfCJVmNGtcJpqmUFTl4tQWJudCS7cxMt2+VvCrT+LCphGHkNsYIiaxRmR1Q9
	7uZrTecBDZMXYpKgn/2tk3/8Ni5ZoWurO+2M8mJ2Zh/lgcphikkfUFQBIszKxiLASFXcXtDVisz71
	B1Wn9LcIJzTDLCMhCcqyR3EDkQALwge35bs3h3wf7ROWuODxtFQH8/0100lbnhAgZiDVUg7HwGGBw
	n6BdRMWtHRNGvqRMfGvxKzsTmKnxb9XIjiJ5lTPzCskhExC81ViQKshbk+TzIElKWODATOAItMntP
	W3VzvLOJhP3JdZ0rsv4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVg1x-0000To-0v; Sat, 08 Dec 2018 17:04:41 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVg05-0006jq-Kd
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 17:02:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so6518886wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
 b=LU17DI2qahHMqaJQXOzP8agwl5/WHXt+pRvIXohaL4ByJLN5o7fmrX8MY9gw6tuA1V
 OQFMKTOjxDkhVXmqRSAEbDUYZDuMVGNRU0CdO0rcdGuB7dgckkXLcZKMgCiJxyG9B2eB
 6O3Kgpao1vr3bgbMawA1iP+3by/c7J4qXtX5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
 b=filKfdOC2/mAcQkwdUISTN4p6yqDyE5y5CBzxD0zRfg210zfRT0APneHiWExHqob9d
 Ji4LkPWYZkANy2IWrUxSTWuinu5hKBQSd19V3yvx2zHCXgGM/saGvX6chwCW3pvC2b+2
 nXOyoAosrxj5AGxBkz59juMn7n+2soMOXolSe0h9qx4NHZzzisXNNIE5n5NUzZmk0QyD
 UzNs70DiD3ooYLSa41bg9SJUVH2ZETsD8N0fBSTyVc4+WyLlOktFDbNveQcXiRuuYqQ6
 cjCI3ALI9Gwr9wfqafg3VeonekwfmeIQD3b1ZvaBb2Qgd1NsN+p5BIpG1kzpsvIOubYO
 gZIw==
X-Gm-Message-State: AA+aEWacwcfXXgsHuxz96e0hiqu+/HUHsryT/EzBOstSdRQ57NPnRKmm
 UniAODz9WVRC2VVmRCWOVRyPFQ==
X-Google-Smtp-Source: AFSGD/VbNYHXX+JW6bwUfEkzdejqlsGdAkV5AHeqd7yvAnD3CO4WbNLC3vhm9xT7rrRK3dxZ7rW0yA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr4969911wru.222.1544288554348; 
 Sat, 08 Dec 2018 09:02:34 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 08 Dec 2018 09:02:33 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
 arnd@arndb.de, linux-pm@vger.kernel.org
Subject: [PATCH v12 7/7] MAINTAINERS: add a maintainer for the interconnect API
Date: Sat,  8 Dec 2018 19:02:16 +0200
Message-Id: <20181208170216.32555-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_090246_158015_AF81CED5 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: mark.rutland@arm.com, sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 skannan@codeaurora.org, abailon@baylibre.com, lorenzo.pieralisi@arm.com,
 vincent.guittot@linaro.org, seansw@qti.qualcomm.com, khilman@baylibre.com,
 evgreen@chromium.org, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, dianders@chromium.org,
 amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..4f426863ff3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7694,6 +7694,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
