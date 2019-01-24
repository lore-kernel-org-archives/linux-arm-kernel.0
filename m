Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBBC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8D02082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QFXGkZBh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YdDWcSws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8D02082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/z6rT41cwe0j5Ot+0eSXjDqqJslHmcWOsIPYorewtQE=; b=QFXGkZBhFxRffi
	6okxW+GMzZ7Tued5G8YNtPR3qCdOKuXb7BnTye9k8OcivtynjTnfrPAMg13g9sOvRuLBl9DY78Hvk
	WG6lG1KkOI+g1UIPsF6k0y4O/39nbx7GaHPiL7aOc+/8ZeT7v1FPjYGiagLSv4oGU9lH8i27v6cPf
	Ds3MgyYCWHl3JRwplZ7tSKOOcrWZ2f1C/i7zkk3XzO4Gfli2s3Qe9F2u95bDjxn+3enwozbb8gGKg
	vQxry05GcreGIMA85QSNczHKLsPjIxX/SPwgVTEEZ1w/WKQ3NF1mhqi3gVhX27N69z3+pwK/Zoiiu
	DzNWNI36yb+mJ6UA7cUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjQL-0001mw-Ej; Thu, 24 Jan 2019 18:08:21 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjQH-0001lp-Fs
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:08:19 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so2977748pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aLdT+u4Gxzzx90j2NuIsLStcS5jPDAhiHJriLgQ53lI=;
 b=YdDWcSwst38VE/NhrrMoRhY7ccNdzKffPGiIoiwy2ZkaVL05lQGL4t/n/xBe4XURAL
 GLxYPbhv3Jmo6IeoeDRasUdiQlB5ygpzp3fqTeQZUcO6WqjHOsaejwGnzpeZf8bnCOzV
 AEhcp2y7uSicfcsG8fDuI6spNYWzNCqRfsycw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aLdT+u4Gxzzx90j2NuIsLStcS5jPDAhiHJriLgQ53lI=;
 b=m5RZ11D0N5Umn/3sz2VkzaDLfgfmJPkorsPFou0Q2lQS/UeGjb6bf8/TGEZSRD4Ur7
 mQozSmZHFjSzx8+E7ZGlkfg8+iwb4VwRnPIjTDkX+PWYwghxnjitxOUc0A6EZcLSw5sL
 Ly8Us6l2L2xSqZZDo9l7cnxayawjDP0r0p2Vc35dMPAj5Z9hD2tPPL/MrN3f+BDmF4gw
 MQ081jXIHpGf/0FR9MeD2g52Ccdk9hv5iGSYFMnZtmMqK2N8KzX9Dj5aPNi7VckEtgOn
 r0Eb3pjnwjFWyLFxb4mTNT0neHmNq+exi0iltPQVonc9XV8CYPsfOcz5l6ocnf0sMxjr
 T3Ow==
X-Gm-Message-State: AJcUukdoLhr4ydZw1iUP1JZieOqRH+wDpypdBbrVBRgOP8MAgVrzVdjg
 a1IQgdos5ssLwxRGbcSsx3T/ag==
X-Google-Smtp-Source: ALg8bN7BikrYw4LzC4CV4SwXTjP19kXInmHQpg4bu9ttD9uHyCnZPQF3ok+cTLCp/iPcmFW6LLWAwg==
X-Received: by 2002:a62:a209:: with SMTP id m9mr7636807pff.218.1548353296431; 
 Thu, 24 Jan 2019 10:08:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:08:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 0/5] media/sun6i: Allwinner A64 CSI support 
Date: Thu, 24 Jan 2019 23:37:31 +0530
Message-Id: <20190124180736.28408-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100818_014764_AF7A6377 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add CSI support for Allwinner A64. Here is previous series[1]

Changes for v7:
- Drop quirk change, and add as suggusted by Maxime
- Use csi instead csi0 in pinctrl function
Changes for v6:
- set the mod rate in seett_power instead of probe
Changes for v5:
- Add mod_rate quirk for better handling clk_set code
Changes for v4:
- update the compatible string order
- add proper commit message
- included BPI-M64 patch
- skipped amarula-a64 patch
Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

[1] https://patchwork.kernel.org/cover/10771163/

Any inputs?
Jagan.

Jagan Teki (5):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 CSI block support
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGET] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 13 +++-
 4 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
