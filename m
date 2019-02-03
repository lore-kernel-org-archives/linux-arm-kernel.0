Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF79C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D9221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHe6alyD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfFsKZ8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D9221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uX6yLK29jbH5FORfa28jWuZLYx0WWBlFANdH7IyWyVw=; b=GHe6alyDWp2Hwb
	dXZ0Ru4RNQbc+/g4jUvZhD06taF4wAbV6oGipbxN85TqQP+GY1vf9bT3n2NlfgRBH6FPYvmsuMmSV
	pFsUWIX7g2ikDIwniFyfdk5UPi59OrT7tsYz63N/GO0BsNds8TPBmNIWQPXV41knF/Oj8jDVYaJP4
	5/3cIR9xjtXg8jNk3l9SaulnxgxnqobVybdVJWvHh71X330v5NImhZta6os0vq2Db1ztCzIuvoyyP
	7Ks0k6z+xq00BX1b/5BawA3Zz26z22/Wy6NSNdrqRiF3nzE6dx8xi5vmxBCDE13Zf3mjvNoWgrulZ
	qzZpsE2CxeNh2OM4CxiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMvZ-00059r-Uu; Sun, 03 Feb 2019 18:55:37 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvW-000594-M1
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:36 +0000
Received: by mail-pf1-x442.google.com with SMTP id y126so5729337pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=amojimuI0ezobPT5vvD9+9rvW44VQJTSGEIJXSx6KRY=;
 b=YfFsKZ8RKFwBTWX3RwBUhpoSW+B/n5X6aepOVyukge1hTcHV2MslwZgzRE0fEoIR/f
 QUQ//q6wfVPiRPGZx17vsmwEkzS7naYIy3jWeXVj4yUYwjqTLfMQo2g+ge1/AeNwQdk3
 CDEtO05I4cLDvViH/HqX1TBxhbHFMdACF19uwJ4x5ctMvvgHsdAXW08trcaFOZyMVnHb
 pRoxBVfAWIDHcnFaBGNJpapb+I0PSbNg2ul/laGy37ULBzoOz0etb9qKuEHvNC9KS0oU
 AyL79Oo16Ec6CKjY9Ti127RbcclPoFLrZkCAbqPFcwsHXBcIzxl/2gLI649MdWtImZfy
 DdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=amojimuI0ezobPT5vvD9+9rvW44VQJTSGEIJXSx6KRY=;
 b=ialIbh+7rqCnJFNj9CjXVFXouHNBMtT62Ff6GCcLiLl8y2PS1oH4GkvMy339ERnYmb
 roN5i+Es3WHPx7O2+A7rvcsdgmlBjK7lz4EZpfOfHXufJp0U4xwP4Cg8FpGQvQEBz1dr
 im7FXYAfTXbta4X238KIBF+jqiy7PAw41E+DS4fF4gNGWBFxFHKPDG//4ZR0qIABgsEs
 K8eDpvoZ18RQz07KbEj42gezKv+VkjPgF3sKa6lbLzgAj0Ov3U5wjlsIT1oyEnnLytA+
 IOY9ADUj3QrVWa9GGL1G0l3uT1XY4e5K8IS/q5NQwhUM2e35rDpSDjVecVbJ1RmX3i37
 Z6Aw==
X-Gm-Message-State: AHQUAuaPiVfijmNdoSjGHUnA2q9TZL1uw53G2jDeFeXLqqMNKF25dcMQ
 BhNmeHnulGE8YdN100FKVo8=
X-Google-Smtp-Source: AHgI3IabL+dw290zj/IbwWuFdNXAKyou0oCiLu8X6lf4GwQ72aMVgW/IYChvsrcZ+qeyWP17fTUQ8w==
X-Received: by 2002:a63:a5c:: with SMTP id z28mr1536490pgk.446.1549220133713; 
 Sun, 03 Feb 2019 10:55:33 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:33 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 00/12] Analogix ANX6345 RGB-(e)DP bridge support
Date: Sun,  3 Feb 2019 10:54:49 -0800
Message-Id: <20190203185501.8958-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105534_746317_0A1041F4 
X-CRM114-Status: GOOD (  16.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset brings support for Analogix ANX6345 RGB-(e)DP bridge, which
is used by some Allwinner A64 laptops, such as Pinebook and Olimex
TERES-I.

It reuses some definitions from ANX78xx driver that already exists in the
kernel tree, but the driver code itself is rewritten due to significant
difference between ANX6345 and ANX78xx.

This patchset also enables the bridge on Pinebook and TERES-I and adds 1%
tolerance into dotclock check in sun4i driver in case if bridge is
connected

v2: - sort Kconfig and Makefile entries alphabetically
    - remove panel supply from anx6345
    - add support for panels into anx6345 driver
    - add compatible and binding for generic eDP panel
    - replace patch that adds 5% tolerance for dotclock check in sun4i
      driver for panel and bridges with patch that adds 1% tolerance
      in case if bridge is connected.

Icenowy Zheng (8):
  drm/bridge: move ANA78xx driver to analogix subdirectory
  drm/bridge: split some definitions of ANX78xx to dedicated headers
  drm/bridge: extract some Analogix I2C DP common code
  dt-bindings: Add ANX6345 DP/eDP transmitter binding
  drm/bridge: Add Analogix anx6345 support
  arm64: allwinner: a64: add pinmux for RGB666 LCD
  arm64: allwinner: a64: enable LCD-related hardware for Pinebook
  arm64: allwinner: a64: enable LCD-related hardware for TERES-I

Vasily Khoruzhick (4):
  drm/sun4i: rgb: Add 1% tolerance to dclk frequency check when bridge
    is connected
  drm/panel: simple: don't fail if we don't have panel desc
  dt-bindings: add binding for generic eDP panel
  drm/panel: simple: add generic eDP panel

 .../bindings/display/bridge/anx6345.txt       |  56 ++
 .../bindings/display/panel/panel-edp.txt      |   7 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  74 ++
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  71 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
 drivers/gpu/drm/bridge/Kconfig                |  10 -
 drivers/gpu/drm/bridge/Makefile               |   4 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.h     | 719 ---------------
 drivers/gpu/drm/bridge/analogix/Kconfig       |  25 +
 drivers/gpu/drm/bridge/analogix/Makefile      |   4 +
 .../drm/bridge/analogix/analogix-anx6345.c    | 845 ++++++++++++++++++
 .../bridge/{ => analogix}/analogix-anx78xx.c  | 146 +--
 .../drm/bridge/analogix/analogix-anx78xx.h    | 265 ++++++
 .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++
 .../drm/bridge/analogix/analogix-i2c-dptx.h   | 258 ++++++
 .../bridge/analogix/analogix-i2c-txcommon.h   | 240 +++++
 drivers/gpu/drm/panel/panel-simple.c          |  24 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c             |  16 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 19 files changed, 2049 insertions(+), 894 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-edp.txt
 delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
 rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
 create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
