Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B50C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978B821852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+FkKHw1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KXuf4HSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978B821852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1TWTsCK6mCKqeT/sUVonmv6EAOMPnpjI/UhnuS/qJWU=; b=I+FkKHw1OQKIko
	xyArxi82cRfois+Tm+FwLlz3+8MGqQ88kWmXdlxzOhItqjma95Gm+pSX0Y6Vw1zVLr78bkMFO7prO
	6b0cJxta+CLS7RgThXhz62TtL4TczhmJGoS+6Wm1Gvb6S2kyNeRG3SuIYITJiDfTICQauFJ6G3QYC
	u+vyPU/Ojl83OzT7Qt4H6QgIENbMOKilSeBmkf4f3uSQW7Gpksj4w0CtGpcV8lHlcM+IsOyggO04Y
	4MyDqAAejK2G+tgrWc7MiXePjaT+D9ez+GREzd45wHe6EQu5dodVA0nGucF3FqnJJZpv84mEcG/6W
	gZgPCixf2Y8F7ejyHQ3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDdS-0002Wz-9m; Tue, 18 Dec 2018 11:34:02 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDd6-0002CZ-UU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:33:43 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so2305699wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 03:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/ZX3Vb1QocJF5KFof1FWVSsQ8WcfFPPJfBBeloD+g+g=;
 b=KXuf4HStRvXCEyx6ZBayeQl6dg5cvQ16H6xHY2cCoa2e94TRgzePTaaKnONf2qLhSl
 8EG78HZMizjmSuO0rPsrKtFPBU0LbrN+xDO98Lk8qYN7VD1gvFEKgWjTDW661Ql670tx
 lYc11TlkhfDyxs7Y1ef2xjTZGsbJ/tQ2g9VJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/ZX3Vb1QocJF5KFof1FWVSsQ8WcfFPPJfBBeloD+g+g=;
 b=TAD5S4U5nbMqBk4gaZqfQYdIHaD6v2LQj99z7kxnM2t28QCTl9UFkIaSvFLDEy4Qpq
 vt2l3D0han1azfpmSzhVS2JfbgIR6ElZsRZ9WhZwS3v+tthUSqcu0bDAmqP3LTb0wPBk
 RYWT9c9tG1wrLHSG6SbA9nRBfZ8obDrO826rcx/MJoVk7G0ozq0JNm6zxqfy0G0S8Iio
 b8TWyVvou92GkcvDKFE5YwGeO+/bN3SE/qsnoTY1fPl9PIVG0L6g/T0c5RbrmYTV3UB1
 6vFzdokg/OTsbRwWivMB2oIOR3ZJjQRI9Xj1gkfyWejgG33vltpWWbqQEJT2ilA1BOu8
 f7Yw==
X-Gm-Message-State: AA+aEWaPm33zTdqZ5r/ieXhI/jght3Abe+Eivi3NOMMrzZYuQjFFY6GO
 //6axFL4Pi/DI2rmwTDBR8VRLg==
X-Google-Smtp-Source: AFSGD/W3uAyNuyhOjUpRNXHPgn0EQGx57zsT174w3nETaLsqzuERs0jH6Y/gj6dEh4NVCt1XlZVU7A==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr2907356wmb.28.1545132808608;
 Tue, 18 Dec 2018 03:33:28 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it
 (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
 by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 03:33:27 -0800 (PST)
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
Subject: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support 
Date: Tue, 18 Dec 2018 17:03:14 +0530
Message-Id: <20181218113320.4856-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_033341_029928_61BBFD58 
X-CRM114-Status: UNSURE (   9.78  )
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

This series support CSI on Allwinner A64.

Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.

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

Note: This series created on top of H3 changes [1]

[1] https://patchwork.kernel.org/cover/10705905/

Any inputs,
Jagan. 

Jagan Teki (6):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 compatible support
  media: sun6i: Update default CSI_SCLK for A64
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  6 ++
 4 files changed, 97 insertions(+)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
