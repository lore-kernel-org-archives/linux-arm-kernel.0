Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77150C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469BD2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MbJyQGYq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDUAo/OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469BD2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JQh4GCcmWrKeCZP17pF4jYFjE/GC41+FZh+OgstwBp0=; b=MbJyQGYqBdEKaJ
	MF8s4aWGdH4l9tP7wnDP5LlPriNLBqBpBT6rJaCo9CSnbcLxDd4pviKEI7eBnU3m8eaHv1IMvFJ2x
	ks/+af+AvIf1l6OmW/3N7klWIKfyDqC33Qw6JftvlE4Z4qIVGky11pjQI+edjPaYuqsnczdpQSZFH
	Bdll+NekmbCEmyq//vbUw3Q5lZcAYBx1UaYBHOYL/kJz1+NR70GeudmvNxK8Rl4dfiuD3EnNmU0pR
	0PaPNCTnrKkSs8MBmBKDJsKeUeT1qXM821MzepGwc2AApRsH4uyhnnVcYfWTapYNNwk4AM99tzzRl
	/NnZzLp5pxdrI0GrZ0+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfBC-0004PL-6q; Thu, 07 Feb 2019 08:37:06 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfB7-0004Ox-N2
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 08:37:03 +0000
Received: by mail-lj1-x243.google.com with SMTP id v14-v6so5751866ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JtUMH/35ElTqFW+ykGE8PxkgKLFJgC1+YJuQMFELJkg=;
 b=lDUAo/OUIbTsRIcyrQaJzkumM0IxO2uWQnvkDh0l3wQvxINYo4pV3bTPB1/+lINNTI
 HyU3TqskJ1COC47z/ohYVZlbGn5X+auPRTxxLCnVFEnuSrrvImwXkx5JuANICFZKf+KJ
 lH1Pjt+ApPhLms9kdKL21/iEBmmIv7HjDqH8VMDpX4UHfcRLuxGXGP+Sh2w4DIuy0bOG
 m6QwvbsGZD3f2F7kwiWn82G6TESNZ7Fl6UJ+LJDQBk/Kos7oBRGmy3rOBVisTamI/Aih
 KRBOLFiAKMMw6s3NacQiD1IdU6m4chL0y3sPqCjGx8SVpfQbI5136X08727JqF7czON4
 tlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JtUMH/35ElTqFW+ykGE8PxkgKLFJgC1+YJuQMFELJkg=;
 b=QzOf8+XMbDrOwms+Y9sjifrxlYZt5AETco+wFVxP0faabUzXWMn4gXSWeoVbIAgGnO
 m7xlzcXwIsqvRcGtHKzWrtj15j5lkJFl/f0EQuD70YcVZvHX5iERulQaVH+EHyT+xZl8
 dmOmwHp2cPCHyMsu063RNvaYQoz6U4DRK4KgIIoxr9nkMPgjTbI1M/fcmvuzlsPBZ/Mv
 +yHptfeqhaUVjOr6AVcvEf/KhkRfRPrQ3o6Eku8d2p5uWZmLzJ6OhGjAwiHdvWm2Uhwe
 QxLmiFQkdeAgo/ipTsWR7+4kyUHVpEjzafuZx6mn3p5L3lsl1yQtIijO380e7xVI/KZv
 UtcA==
X-Gm-Message-State: AHQUAub+EVtfLun1i42ejlUMYFHtQlantRTpq3AqYJVwzCcs2jn74bv1
 mU9+5zNPdrZfQX250KO6oE/Fvw==
X-Google-Smtp-Source: AHgI3IalGO8V2PobPKIDFbQelh8zOTCBUohCZHMb6vxHXYsIFhg8e6EDYyAOm4NYkY28A4OmLwNfuA==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr300033ljj.9.1549528618031; 
 Thu, 07 Feb 2019 00:36:58 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l72sm470910lfg.75.2019.02.07.00.36.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 00:36:57 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH 0/4] DRM driver for ST-Ericsson MCDE
Date: Thu,  7 Feb 2019 09:36:43 +0100
Message-Id: <20190207083647.20615-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_003701_814651_E0237C5B 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a driver for the ST-Ericsson MCDE.

I had to come up with some way to support passing an external
encoder to the simple KMS helper to make DSI work with the
simple KMS helper.

This work was motivated by the ongoing work on the LIMA driver,
as Ux500 has the MALI400 so once that driver is in place
as well, there will be a full graphic stack for Ux500 with
this display driver, which is pretty neat.

Linus Walleij (4):
  drm/simple_kms_helper: enable use of external encoder
  drm/mcde: Add device tree bindings
  drm/mcde: Add new driver for ST-Ericsson MCDE
  ARM: dts: Ux500: Add MCDE and Samsung display

 .../devicetree/bindings/display/ste,mcde.txt  |  110 ++
 Documentation/gpu/drivers.rst                 |    1 +
 Documentation/gpu/mcde.rst                    |    6 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi             |   36 +-
 arch/arm/boot/dts/ste-href-stuib.dtsi         |   25 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi    |   25 +
 drivers/gpu/drm/Kconfig                       |    2 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/drm_simple_kms_helper.c       |   23 +-
 drivers/gpu/drm/mcde/Kconfig                  |   18 +
 drivers/gpu/drm/mcde/Makefile                 |    3 +
 drivers/gpu/drm/mcde/mcde_display.c           | 1285 +++++++++++++++
 drivers/gpu/drm/mcde/mcde_drm.h               |   52 +
 drivers/gpu/drm/mcde/mcde_drv.c               |  540 +++++++
 drivers/gpu/drm/mcde/mcde_dsi.c               | 1376 +++++++++++++++++
 15 files changed, 3493 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/ste,mcde.txt
 create mode 100644 Documentation/gpu/mcde.rst
 create mode 100644 drivers/gpu/drm/mcde/Kconfig
 create mode 100644 drivers/gpu/drm/mcde/Makefile
 create mode 100644 drivers/gpu/drm/mcde/mcde_display.c
 create mode 100644 drivers/gpu/drm/mcde/mcde_drm.h
 create mode 100644 drivers/gpu/drm/mcde/mcde_drv.c
 create mode 100644 drivers/gpu/drm/mcde/mcde_dsi.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
