Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27037C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E2E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMfAxoW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1xVUXMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E2E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yk9XgFBqUirpdGcb8GYJ8TLmdDOhqiOmiBp2knBiNbI=; b=XMfAxoW9awpif8
	wlAyUrJb/vS10o3e/nwT8vehzkoHFhknkXOslP3NQDD0qt5o7deYWv0x6xAUAq5y7AD46UFBAFQG8
	mPBEq/C1+lEa6BPbeDE5b6x3uvalEupD+SUr40GhIadU7w7bRhd2ZM3Tfw+l/TpgMznuJ6QxQt22K
	/BIrzdpMkcEaWOX6HOHQ+ydPUd/MTbs8iw6Z8/Hmyg+oRFAYmvi5ntcCmAMxVypH3umoSqD5bqeyQ
	oYuIB1CYqF1zlkSiWRg9R8zN5/AbAvnYJQTKQ+OjoSDhjidNnkFDcyf6mrZPDfuOGAFFsCn6KdTGV
	t3AjU5Cld0XrlrU1ubOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpJCD-0003SY-UO; Thu, 31 Jan 2019 20:44:25 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpJBe-0002xv-Vz
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 20:43:55 +0000
Received: by mail-pf1-x442.google.com with SMTP id 64so2012964pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
 b=O1xVUXMmY8mLwMYtaFSd0Mi55r4/0iuNEytSdQ5/azYdmkHpmH5LPAgZgs+JBFIKWj
 Kt7+76kvZyGgMLODm00ZTUeybIkv8wOZdEmGJzlYhplCRtmLxmzAi/meNXpzfmQMReZO
 EA8DFsLEVqwuV3Vny+igmrAoXw+CNhoOJsL6UvA9ZdqDwkSt1nUqPhBTIi1PYDrIraph
 GRNKyNJk9fcakxEluSHBooEIVyjSzTe99/1ggcQfatgOj1Gay0Y/nDbH68aVauxz/F1b
 YLYttGTI2rI9fQJNsrluRyJxUyctd37UJ8va8XGhIF5mJbx1O5rQnNOjpDLKrwsTN+p5
 xYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
 b=RLervGPpU/t7PPJg6ljCrR3HUqPvBlURspDA3RGJiQSacZzPBQzLSDtFuxE1PEVk6l
 +NKA++DPh4yN+/WdL8WMKxk0cFN34HqgyM1AKQk2gLADPkChglrGPkPpvHUBH7C+RsUl
 CWMUi4zE7LnpzTggTHrS9+Ma6iyNXrKoN5WACKtuNyjxC0PxE8pppjHqVMO2Jso+hEvA
 fBMq4Qk/zkN5PjxBqgwD1SkgT+eTLCa33xLa9YKB7oGMnMkpoUv7RXF1+Kpwg+ajOIoF
 KEnebSU0DQnS6XnfBJt1oPn+9ijtcoRzUwTWztFVoPiBgG6w6x7kvIutgh56rQNJhyUy
 AjsA==
X-Gm-Message-State: AJcUukcFqPM/17VD4TWFvTcn4kPeg9zd5+nm+SAyWbtmOa1wDmf8yUyj
 fktwQI8MBAADF0Wyb6SE5ew=
X-Google-Smtp-Source: ALg8bN4BqZ9LC4h3GFTwcODC23FmHtDL/aJJyqv6O/kkXxW6SHpSg9WimWbsxDDndW4CSbLbDMK0yw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr26721389pgh.39.1548967430002; 
 Thu, 31 Jan 2019 12:43:50 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 12:43:49 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RFC 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date: Thu, 31 Jan 2019 12:43:30 -0800
Message-Id: <20190131204333.31846-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_124351_026876_26010A2F 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f6c37bf9cbce..50436bd393ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -254,6 +254,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
