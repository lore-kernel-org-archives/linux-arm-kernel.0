Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:10:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48702192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XdX1sqpU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKTgwk5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48702192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UFdCABbwT2WNWuQZeFO4Gi/gYjinUZjzZDicMsySf64=; b=XdX1sqpUhJfiK+
	dv/suB0VDBxJdS2AmxafbRLociWCvuKAr4qIq5lwqk8ckXh/oq0phOO3ZlXZcJnfOxPwyeCwgQ0vj
	sgcurUtEwagkHr5Rm/1N4+StNUnxb+NBNTAaXodDpSdeqL0/7aXKICgejxkc0yzNHE924z5kEm9T3
	HuZ1LNbd8or226HwHqheEFHdI8VtE9dsmcEANdSUfdNWfjQnoiTEQWs7sK5qmYKIuSFQBC+hAyHZR
	exoiosZdyKDkPaU0aVr+d3JEo4B12WdXLAtwfvoCzGVx8UPcrHT7/D57/8a8XqQ/ddXy106jvtEqQ
	1yzCZ7NQVjTltU4rhtow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVlZ-0003V3-Vf; Fri, 15 Feb 2019 05:10:25 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVlX-0003UU-2C
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id r124so4231850pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8s+H7lj60BiLptDN+KBUxWv5PfCaR6r6g6JP6RGFK5Q=;
 b=PKTgwk5k1GG+tI8EdXEEpv7ycf2Dx25kmfLtcZKl+8Q/B/ERCrHcW1EEDc9T9te1DH
 fSy4mgBcTCdsdmCtdpa97Mur6zAN0rde3FTl4/CrwhCoMzW6aDAoLZsEEV5gOczRj0gk
 h8GpWkL4nq+8k1TWuLPE4gmy8YWYKudACoBDGw1QQCO19LUqaDTcuK9GDdoWOM7z6yXj
 MuAsp6OGuAznASAngk5GY0/IZo5R86TTp7EEVWIqu5xzhdME3KGNDFQsSWFrhBhawrQI
 sTiGsg37YnW+LehPsxHTCXtFkxoRUNYfNwhy6U1VUDvTbDLWsf92PoPkS7EUoUpys6Zh
 +whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8s+H7lj60BiLptDN+KBUxWv5PfCaR6r6g6JP6RGFK5Q=;
 b=Zpr0+k/lAEVy11tkyGKyhdTMrYLVEH4dGagHLPxq9a1AEEf63/FOrhKAKtI7ht2vYL
 LxH1DhxhBYaBHmgWLyMsdSDdzRffemVs4aSsOiaqLFsc8PwvuSzOlYAPRy9A4Lyf4s30
 50a0vQdiqyxL7emtBOH3eiwLdqjSsgoIx8k/k4KEyHkJV/K58KC/fID7RoLkr5iO4xqo
 eu4Fn04BotBvYt/A7PyybE1zoOCp2kVjmSbEV8tZ15cw/RCDXMK7ALSiuNhIboAL/iJS
 NYCuQihZMOUGlkV8PUnnSgFe5LcSAv/EmivqMij+9T/cW6O9fDlyk4e9J27/SlGSlCZ1
 RSJg==
X-Gm-Message-State: AHQUAuYj4dIVh6znDlDZ4s2QkgOo1fd6rFh4WrmTk0i4chpLPvr5A+Pu
 nO23Biht3y8gyEF7Ig4lNYQ=
X-Google-Smtp-Source: AHgI3IaT3jYNlXrg3NqN9vZzmdZlQNEDmsFK3Rp3RpMgGmpsd9JuVSRht7MsnDBZo1Ie5KIZcIeSdg==
X-Received: by 2002:a63:4e1a:: with SMTP id c26mr3594383pgb.175.1550207422325; 
 Thu, 14 Feb 2019 21:10:22 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:21 -0800 (PST)
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
Subject: [PATCH v3 00/11] Analogix ANX6345 RGB-(e)DP bridge support
Date: Thu, 14 Feb 2019 21:09:46 -0800
Message-Id: <20190215050957.20755-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211023_107434_F88CE5C3 
X-CRM114-Status: GOOD (  17.90  )
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

This patchset also adds support for LCD panels used in Pinebook, dt
property to disable strict dot clock check in sun4i drm driver and adds
nodes necessary for LCD support into Pinebook dts.

v2: - sort Kconfig and Makefile entries alphabetically
    - remove panel supply from anx6345
    - add support for panels into anx6345 driver
    - add compatible and binding for generic eDP panel
    - replace patch that adds 5% tolerance for dotclock check in sun4i
      driver for panel and bridges with patch that adds 1% tolerance
      in case if bridge is connected.
v3: - replace 1% tolerance patch with patch that adds dt property to
      disable strict dot clock check
    - add support for LCD panels used in Pinebook
    - drop generic eDP panel driver
    - drop Teres-I changes, I don't have hardware to test them anyway.

Icenowy Zheng (7):
  drm/bridge: move ANA78xx driver to analogix subdirectory
  drm/bridge: split some definitions of ANX78xx to dedicated headers
  drm/bridge: extract some Analogix I2C DP common code
  dt-bindings: Add ANX6345 DP/eDP transmitter binding
  drm/bridge: Add Analogix anx6345 support
  arm64: allwinner: a64: add pinmux for RGB666 LCD
  arm64: allwinner: a64: enable LCD-related hardware for Pinebook

Vasily Khoruzhick (4):
  drm/sun4i: rgb: Add DT property to disable strict clock rate check
  drm/panel: simple: Add BOE HB140WX1-501 panel support
  dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor
    prefix
  drm/panel: simple: Add NewEast Optoelectronics CO., LTD WJFH116008A
    panel support

 .../bindings/display/bridge/anx6345.txt       |  56 ++
 .../display/panel/boe,hb140wx1-501.txt        |   7 +
 .../display/panel/neweast,wjfh116008a.txt     |   7 +
 .../bindings/display/sunxi/sun4i-drm.txt      |   2 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     |  76 ++
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
 drivers/gpu/drm/panel/panel-simple.c          |  65 ++
 drivers/gpu/drm/sun4i/sun4i_rgb.c             |   5 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   3 +
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 22 files changed, 2041 insertions(+), 876 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hb140wx1-501.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/neweast,wjfh116008a.txt
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
