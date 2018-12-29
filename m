Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE56AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD34920828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3ATMmcZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOiS1e1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Na0HuNZtIFJG2z3OSbB7arN9sjTkcF0bo1fQoqUUruU=; b=f3A
	TMmcZPpSk/jr5V3pFdR4VbOR5aujxYXmTXm4MUbNJJvv93AgOnGZhr6MvaAQO/w2WU8lzrG/VuNZf
	T3ZuzisfWOJdGRKoEfytvC8RUAdbnrSm00mQ4amRK2ME/Of5TFxhNx50tV/LTHOgX7r2Ch4FdxfJY
	iOv6Jn9nTCYuPWPoyvJK8rq7KskCbT4CQREXx3CB+hy+S38cKKWU6CHnnsDMXdf3Sb5GODnhFoLWZ
	YqmU3lsOoq3NjhxUO34HSwSUPqJtk4ZAONn9HTsd80c9pP6OwCdapUge3kBD4gzOGkh3D8jpE3WP3
	EeYX/SbUOP4ww7Np9ne2FMiwTykyk1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdEkO-0005S2-3J; Sat, 29 Dec 2018 13:33:48 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkL-0005P4-8n; Sat, 29 Dec 2018 13:33:46 +0000
Received: by mail-ed1-x542.google.com with SMTP id f23so19485932edb.3;
 Sat, 29 Dec 2018 05:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=VOEwkIxvI1q/i/WRRxMwm990tTHzp40HbWJrY1h5Srg=;
 b=QOiS1e1/tVwWeJpUnmvNrUZZmxafF+rTouOn0afGnzvEUNG6c+xsn3E2DfIGlY7oxh
 SNIPS0YcmX/i9WDRWW/Mi7vwbWpXu7PAOES8pg71CxrimPXFVdXVwNXdUjC4SDsr6ah6
 ArNCwZtxMtBaXsTYOIGRrxY8fGwEso+yCsbismMQEw3jEYo9Rmb4Kr/CgHczmjQFRKvs
 XDXnAFlfg4DhBJlvTbesd3crHVq8bWXkp0ulgMhsa7WUSxowAcW2gJsZmHf6ZysPgRzX
 dgR2/seLZ9ssm3UE9w+yvM4cPEMpY5dl4UfgOwyRLk3D5UriEj1JspqvlwLyovfFYbzB
 GbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VOEwkIxvI1q/i/WRRxMwm990tTHzp40HbWJrY1h5Srg=;
 b=N/fS2s+8MVxCX3Yf2VKRASiRzmpEr9TZImoT2BzI/ykaABnjITQ4FUDWRKCUGc6H1L
 YGHiWMiAZZ7bpavg53tGA0F1vkXDaFMLPmN+wbuvEdLm5RPLh2J1Fe9mDfVrDlLG5l4s
 CKwSPpvmYC1QTtKBPhkVAanMOMBNZbHDf2GofNG+wlLCp2KbnlSeT1BZYarwT9TWv3eI
 oJlDCc7JbTTmdUSzaFJYJnqYTj43OBBTcX6xcqIHV0UyUu++CNGnvGTJ5E5ZgvllhQFF
 1kdjoJ1OSbXXbKbYt9bSfva+q6GRPFdNkzM6VQbXo3E0mU5IDNWfKps0qAfB0WfwlsdC
 jI4g==
X-Gm-Message-State: AA+aEWZ2d6oG39kk/CDcnvz0uphBlZwRuIoGTDjBGZ+ibAjoV+WfOZ/v
 XCQMN9SsGq9+9AwtlylRVmc=
X-Google-Smtp-Source: AFSGD/UYOFS24TVFvlBj0Ecv6cUdhZZA7uE6oF+NVkTRWHBxFbetPqX3nvlmZdYuB1++JNd2TppOJw==
X-Received: by 2002:a50:9153:: with SMTP id f19mr26220211eda.159.1546090412895; 
 Sat, 29 Dec 2018 05:33:32 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:32 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 0/7] Enable rk3066 VOP and HDMI for MK808
Date: Sat, 29 Dec 2018 14:33:11 +0100
Message-Id: <20181229133318.18128-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053345_314870_E4C5A9C4 
X-CRM114-Status: GOOD (  13.02  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

DISCLAIMER: Use at your own risk.
For testing only!

Version: V2

Title: Enable rk3066 VOP and HDMI for MK808.

This patch serie only works in combination with a MK808 TV stick and
a rk3066 processor. Other boxes and tablets with a rk3066
need extra software for power management and lcd's.

What does it do:

With these 7 kernel patches a MK808 can show 2 penquins and a console
on a DVI-D monitor in combination with a framebuffer.

Not tested:

HDMI TV
DRM
Xorg
Display managers
Android
etc.

Problems:

Fixed screen size for DVI-D.
HDMI sound not included.
etc.

///////////////////////////////////////////

# How to make rkfs.cpio

find . | cpio -o --format=newc > ../rkfs.cpio

# How to compile/flash

make menuconfig  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-
make -j4  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-

cp ./arch/arm/boot/zImage ../zImage-dtb
cat ./arch/arm/boot/dts/rk3066a-mk808.dtb >> ../zImage-dtb
../tools/rkcrc -k ../zImage-dtb ../mk808.img
sudo ../tools/rkflashtool w 0x4000 0x8000 < ../mk808.img
sudo ../tools/rkflashtool b

///////////////////////////////////////////

Finley Xiao (1):
  clk: rockchip: rk3188: add CLK_SET_RATE_PARENT for lcdc dclk

Johan Jonker (2):
  ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu node
  ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes

Mark Yao (2):
  drm: rockchip: vop: add rk3066 vop definitions
  ARM: dts: rockchip: add rk3066 vop display nodes

Zheng Yang (2):
  drm: rockchip: introduce rk3066 hdmi
  ARM: dts: rockchip: add rk3066 hdmi nodes

 .../bindings/display/rockchip/rockchip-vop.txt     |   1 +
 arch/arm/boot/dts/rk3066a-mk808.dts                |  12 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  92 ++
 drivers/clk/rockchip/clk-rk3188.c                  |   4 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 928 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 235 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 110 +++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  53 ++
 12 files changed, 1445 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
