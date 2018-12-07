Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7670C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EF620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PoPVLAcI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7xAs8JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16H+GtuS5H70UAEvj6dSdT3neVnIeFLnHVsl3VrE5PI=; b=PoPVLAcI2M1g9I
	eRYZxN7wSFEQJTt7Mo03gXjJxAiWCdNMcGy28BvlsyA2mECjP1+2hM9rrvj30ah2yYwGhe+lHr6Kx
	3T9UZ1mUFahcgBlCCmotmF0hxRzrq+kOC5Xx2vvH6BoampFeuFvGCyy2qO/NsSXUX9GMCfCGQ8H8m
	QcfB6kxNPPrY0xUdlVg1TXLOy+R0F1BEGPYisnqf65D3FC+wpBn7BJRQUOgMd4qkade46Sj42dHHL
	LN1GGi+cKTfUoF3oI3MUHiIrCJdUpgssLIaPv68J2UtHKbAAipIfwax5aqeiWEI3HscYivRhgblco
	YyI0fxBnmsyGkOAANvYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI5K-0006pZ-FG; Fri, 07 Dec 2018 15:30:34 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI4T-0004qv-3d
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:29:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id j2so4218240wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
 b=D7xAs8JNPPya8GVhcKCgjUJ+JMGyVzW4mh+aMFhWFaqg32QM2wWlBQna9NoxPN21Uj
 ZcxVkarFmapau66SYXcDVLKh4pGBtVPT4uie54JuN2jAyq1ST0ZDfLq74YDa5pCh6if1
 ny4s7+twU+uaLkc2fUgwYhfaWjPpUssOyJw44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7BDdV+2LfEOv90ebMJ7IWK2gg41mit+gJlwgdlxTuVc=;
 b=Z0BFnpWjGjF3u9ryZWggraYbtzFe1IDfPYcTsybyoA4KZDTHndbb4fjqSlNYNwZdDo
 YjjG9edA65pVaX0dKvWhS0VrnUyyTH7japm4i+E5F/0bthvzuWwOqWGMMVLba/J/CmwK
 MXK4YdK+cL2ff9rUZj3+jqrJSkfo7z7NPceKEV/VzZavRHjDWo9cmapcEBj9eYfwAiy2
 +/oEGuwpseiV/vK5NtKzeBTFSukxXBP1qycRqBZMDMYBzYBUK6RwsfXxISOg20i/xqPF
 4DIrkCNAkJSpwFq2DVl83URzMxG4YQSy1RW2mUrCG5xjNx68zRWGIGpUapEGCl+IU+BX
 7v9Q==
X-Gm-Message-State: AA+aEWb7zehu6ZOrK/e+L7BEZGSPjRrnHzBT1jnIvkNFlexc7o983I3p
 5CrPGTFVul3G5LYQwkFqa9kcJQ==
X-Google-Smtp-Source: AFSGD/VG5tq955HoOVCaG6geZh98mkykDzR3qPv/MCr9bvaZc6yjQnhYOG7toBvFcgNFh/0BiJ+O1A==
X-Received: by 2002:adf:b592:: with SMTP id c18mr2147050wre.89.1544196575708; 
 Fri, 07 Dec 2018 07:29:35 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 07 Dec 2018 07:29:35 -0800 (PST)
From: Georgi Djakov <georgi.djakov@linaro.org>
To: gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 7/8] MAINTAINERS: add a maintainer for the interconnect API
Date: Fri,  7 Dec 2018 17:29:16 +0200
Message-Id: <20181207152917.4862-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_072941_365969_8BE2B9CF 
X-CRM114-Status: GOOD (  11.19  )
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
 arnd@arndb.de, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, dianders@chromium.org, amit.kucheria@linaro.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 georgi.djakov@linaro.org
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
