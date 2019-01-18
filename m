Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B25C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5712620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="coBoIaJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YPCZUcup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5712620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RAFE91PQArc1yc1MO9jsknp5YEGBK7SDYmzbYTyy1yw=; b=coBoIaJ7yOgzhA
	qtWdeKm4wZtOYjMz9qS3IxzOMLcp/0GykKFHw+lF4G9T8cgDVYx45O4F1kAMys0BnfWJ4dyOmLmG8
	CtePXUDkkzuzmAqKo3dGCVdNGpi+IXw0rKAazviMuymNhPhnBoG//hKoQlgxDMZ/CEqgZ41xxCHed
	7K2bdP5UJUU5CMrYxuhzZcZfMAl7f1GYERolgTYiPn2Ic/uYmCqLZpJrNbC0wgIRcVOvElPEOEW7l
	ktTUzenK0Xhk09BmszN9NRBupgLXcXN4MKvq4ZAQdrrZpQ2ndGLqTpSwLffso4PaqXyPZY/erRsMF
	3p8yeCn+YAnFC/83OCig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX4V-0005mP-S4; Fri, 18 Jan 2019 16:32:43 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX3x-0004Jw-Kg
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:32:20 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so6564747plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VJQVSYfjj+xbs/VVNFWJJ8UsMZ+mUtGQYZPt6JxkRhs=;
 b=YPCZUcupuz6x1zsmyyY3R6FK69GK1DwjQA9sJZHuZ6X9U16wbhVBAz6O7Crk93VXa9
 sq9HNEYM6X3+d28+ESDNVlesMNSaaWyzqc1uklue7DIMUUyOwYu0vl5SP4Nb+I1pY0sz
 0HYQ7Tb+vUrzzKrMmnUDq2Po3jzuzP4nUR4cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VJQVSYfjj+xbs/VVNFWJJ8UsMZ+mUtGQYZPt6JxkRhs=;
 b=TPljIB3+qWQz4ODx+N4bcF29G0RlaiaNTkg8kBG3cReXVsLCaV4Q//668zsfijhoh0
 I7smsKZK9UmuFnK0IAXalAf2MFO32wG4SSxh6U3nNwKLgeVPp5vCvAFWWoKD33GGEpBK
 1W/pUwFY/ms8B2DRrq+3NxJwKf3gq5tpb+1q1H5zm7+eDYUqeaCmhYsyaiC3hf4emGDA
 0Xhp12apVht1LXgIAwiBtnNS51zRJeCsZl7MiROeZkGRWP7kgyCOKktgDT6FFuTkGNeD
 MBAFD5OTTIOrwCibn2m64kaMK4NUGVL3PQPQVmQNjmrcp+NUWzd+xjRnMkKMr3N1G7KV
 wyEQ==
X-Gm-Message-State: AJcUukdb7rH47dERNCY8hAgicA8H1yJp3Gk4LG8cxCROqhb1x/uSVmxr
 OEgsQXB84lTy1n9cR0xVonLZNg==
X-Google-Smtp-Source: ALg8bN7p7RQXpMtYRpMmmnAWrcYEqtZTyPQ09dQsUPhIA0d/o9rQIj6+kab6ufgEJkQSut3svZt41g==
X-Received: by 2002:a17:902:4:: with SMTP id 4mr19958908pla.20.1547829128741; 
 Fri, 18 Jan 2019 08:32:08 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 08:32:07 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v6 0/6] media/sun6i: Allwinner A64 CSI support 
Date: Fri, 18 Jan 2019 22:01:52 +0530
Message-Id: <20190118163158.21418-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083210_696291_BD1D9A4C 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is v6 set for previous version[1] series to support CSI on Allwinner A64.

Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.

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

[1] https://patchwork.kernel.org/cover/10738841/

Jagan Teki (6):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add mod_rate quirk
  media: sun6i: Add A64 CSI block support
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 31 +++++++--
 4 files changed, 118 insertions(+), 4 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
