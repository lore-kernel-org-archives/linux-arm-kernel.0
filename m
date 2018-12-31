Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8DEC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800712073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y9dTzOiM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b98qWlJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800712073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=sqZizV+3beLDGFoBp5ZA86wd8+pcKlhKpyaQBWxsuRU=; b=Y9d
	TzOiM6Hh2pvGJ7gh7qKiZ/WHrK83SfpKgQM2Oahv3IMwv5H4W6Q/UbV81cP39OnoeJBjto5Hjr7rx
	wusFBRaLqKcHCCfwTXsuR/5ex0LWCxJ0XYUAM1FMP8td5yMSuWZ4UgqapQwqUuOAjButXaWwXDnFZ
	vM3HcjuM185cRmQ20YdZm91x7JNuHK2OsLa1amfFKNWpiCwDrygZQ2zcpA/vD4WsofbTr/fjyvevh
	801hriRIZ7+pMfT+I//q+ThutLm14KZMUxm3JNx0a2pO6ZS7VENouY5oYm7ImJ/NQrvNnX92WLV9O
	14CTepmYXQq2Q8rA9GFudiLpEGASsWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2j2-0002xU-GA; Mon, 31 Dec 2018 18:55:44 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2iy-0002wn-HS
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:55:42 +0000
Received: by mail-pf1-x442.google.com with SMTP id r136so13461703pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=XIzqSzvnS+vj4Sll9x6Seco6sA7Z+UbLnEB7Ylb8mHc=;
 b=b98qWlJYut0UqW3LDhal3ej051J+e5txsgs5wuNpP5qFP84EPLc44VkTayjTFlCezR
 EugbUq5bvrF1Ga+rXUESXzsWJtI3sG0+FcCHF0gCfGWwRE3SGH2OrJfBeiUO8006OoXJ
 TJYdc1ei9ec4P39pFyLvsD1pw/knGRSlGauu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XIzqSzvnS+vj4Sll9x6Seco6sA7Z+UbLnEB7Ylb8mHc=;
 b=dBebmEvD4zU3YxTJBBQHdrxliQeeEgKbLyh5XFeIhqF6zRg49W30NXylrcrVcC6cT0
 pXo9fqDULfgGHWcAqONs+/MKleJFOrM+c4gXEZUYWRviJexHR96HQgBS07veqsvFrfby
 2CbWp+V5i9PE4mhVFwt+akRLP6ZjKqFBS7wcv5zriEtSDy502dWb7NRW4+4YMojAzVMl
 Sa9NOq6lG93WY4bdw6Sxl1E5du33AvMdBYMPja684prnErzDMLGxEmOSIwIJZnzVywE7
 jb+iLFV3qaERG7+CPYPuuZtp1ReJ5DbNEEo0yRvH54Jkk8M8Ot7DUlF7D393FviqCP6X
 655g==
X-Gm-Message-State: AJcUukfwiOcecffwIHsBWG9Aukqatfc6bhNH10cCRJel7GbiFl6zGUac
 zGr65HpfVWuLrrUjTwrq0tD+
X-Google-Smtp-Source: ALg8bN5Usp8F4ykrKm2/LbYg1HM7q7JAX2yRcmpDfT6GvtdTtC/hyJXNCygE78NaIHPx4kXLEXIovA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr8086322pge.93.1546282538801;
 Mon, 31 Dec 2018 10:55:38 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:55:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
Date: Tue,  1 Jan 2019 00:25:11 +0530
Message-Id: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105540_602386_650944FC 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds common clock support for Actions Semi S500 SoC of
the Owl family SoCs. This series is based on the initial work done
by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/

Since there isn't any update from him for long time, I took the liberty
to modify his patches, address review comments and send to list for review.

This series has been tested on Allo Sparky SBC.

Thanks,
Mani

Edgar Bernardi Righi (1):
  dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU

Manivannan Sadhasivam (5):
  clk: actions: Add configurable PLL delay
  ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
  ARM: dts: Remove fake UART clock for S500 based SBCs
  clk: actions: Add clock driver for S500 SoC
  MAINTAINERS: Add linux-actions mailing list for Actions Semi

 .../bindings/clock/actions,owl-cmu.txt        |   7 +-
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/owl-s500-cubieboard6.dts    |   7 -
 .../arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   7 -
 arch/arm/boot/dts/owl-s500-sparky.dts         |   7 -
 arch/arm/boot/dts/owl-s500.dtsi               |  22 +
 drivers/clk/actions/Kconfig                   |   5 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-pll.c                 |   2 +-
 drivers/clk/actions/owl-pll.h                 |  30 +-
 drivers/clk/actions/owl-s500.c                | 524 ++++++++++++++++++
 include/dt-bindings/clock/actions,s500-cmu.h  |  78 +++
 12 files changed, 660 insertions(+), 31 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
