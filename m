Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39103C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39882087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AxZRYslH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Af9kWOHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39882087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ShfSZ/Hloz5Ah3UzRkvU4EJ1svfJi63GnhHLvKA40kw=; b=AxZRYslHfHU8Uf
	oNVSWLGXA8Ph93ojy58luzSXV+Z24G90TA1Khs8TRhdblO7MclUXzcVOzHE84p+JUoTuAEpMnBp6r
	1Unn1nTZNkS+R37X1q6UjPBiBGphAFFvY+ruc85L132hswdXxydC5LmZNJQhA8E95rt3G87N8tDCS
	Gc8vmJg7KUrVcCIKJVPqZc7ne35+9Eh/CvWsHoC0xBnmtSRCCvHagyHarciYts0/P1ha14HTFPo4Y
	hM1P9aQjsMfXzapGGWTHE9KpeQgjDsEs/Btdbq8qMpvNATemfupujowy9whJJWTwgEUIGsoRq1dcZ
	XQ3jrFI19yd5f19MAXTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggju4-0002S6-DX; Tue, 08 Jan 2019 05:26:16 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggju0-0002RH-Ht
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 05:26:14 +0000
Received: by mail-pg1-x542.google.com with SMTP id t13so1182659pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 21:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDe0ZaHlOJKTGA+krCM2g71oz8tu91Sp3uzVesKhIQs=;
 b=Af9kWOHUzpZaS3AVYOtaZlNCdVr6aeJJHifNMcL3i7NdyE4x6DBw1AUAHpYrcYx33s
 j2G0Yh0GGW3SryZ5V3iwXQclvOz1BpjLAQkaq+kfBSAgJybNfAJpKThgYBOyXrUTqjAP
 LhNmpoWuol+mswQq/oRyOdcATchf0pz8YJCbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mDe0ZaHlOJKTGA+krCM2g71oz8tu91Sp3uzVesKhIQs=;
 b=iHdkGQ2oJm+RSPKcfmNF1RmvLh/Hwdlut307DANqex3olcsPtUyQd6hKKhVpYNQBBk
 R27HW8c7LFBugciBPD021gmgzDtu6We0tvWEZjZPXgHrms/pRnBRgE+Eb+vsuAMaLHSa
 NZw/VPwuqvi276JLo4rx9k4TOVHaQyEx5tpK0kq8AZrUT75ccCaiZHwOUjz7ha8pcRBX
 cPmIYigKkzgXN14SwTetf+i6c5fji+mgKIIi0WZPf1brZj3DsFowRv//9mqMWuwKQYh4
 ExUyD7Cuh3BwR1S8HrwXEvrt/cmPL6f5j+aXVCqPu4g4uZG2POZAlrAPTziktQCk1fp/
 uIvA==
X-Gm-Message-State: AJcUukcnXSTvt+Hpg+LsfP7YDKreQ+1X01juvkXU0AaS/Hvn8UygStMX
 2pHCGf6loWD526csvr7JvcKUgw==
X-Google-Smtp-Source: ALg8bN7WrOG7M3i8Kcun9NENz+v6MnvKrthCZ4E6CIOqkx5sJBvBe4tiW/6lIcnhkbUaJG2gNvCgPw==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr345842pgc.42.1546925170851;
 Mon, 07 Jan 2019 21:26:10 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 21:26:10 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC v2 0/6] Add support for mt8183 SCP.
Date: Tue,  8 Jan 2019 13:26:00 +0800
Message-Id: <20190108052606.59426-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_212612_637655_A9D72266 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, Pi-Hsun Shih <pihsun@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for controlling and communicating with mt8183's system
control processor (SCP), using the remoteproc & rpmsg framework.
And also add a cros_ec driver for CrOS EC host command over rpmsg.

The overall structure of the series is:
* remoteproc/mtk_scp.c: Control the start / stop of SCP (Patch 2).
* remoteproc/mtk_scp_ipi.c: Communicates to SCP using inter-processor
  interrupt (IPI) and shared memory (Patch 2, 3).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 4).
* platform/chrome/cros_ec_rpmsg.c: Communicates with the SCP over the
  rpmsg framework (like what platform/chrome/cros_ec_{i2c,spi}.c does)
  (Patch 5).

Since I'm not familiar with the remoteproc / rpmsg framework, and there
are not much other custom rpmsg driver for reference, would like some
review / comments on the overall structure of the driver.

Changes from v1:
 - Extract functions and rename variables in mtk_scp.c.
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).

Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (4):
  remoteproc: move IPI interface into separate file.
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: add EC host command support using rpmsg.
  cros_ec: differentiate SCP from EC by feature bit.

 .../bindings/remoteproc/mtk,scp.txt           |  10 +
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/platform/chrome/Kconfig               |   8 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 159 ++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  76 +++
 drivers/remoteproc/mtk_scp.c                  | 459 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 108 +++++
 drivers/rpmsg/Kconfig                         |   5 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 384 +++++++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 132 +++++
 include/linux/rpmsg/mtk_rpmsg.h               |  34 ++
 17 files changed, 1399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.20.1.97.g81188d93c3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
