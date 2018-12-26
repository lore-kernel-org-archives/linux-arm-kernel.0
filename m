Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C860C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B09217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEs791fk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BHhxaS6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B09217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XcFYQQNyRzqo3+Lo9706TOk/2qQcSLDDOG0bxgBcqiw=; b=IEs791fk0dTYgN
	gONNQ+nMM2wV0MXUNlP6Pm0dOX1ZHgpv8KYh36/L/gqKwmT+t95PGrNnxxObMaz1aixp8YZ6hEibr
	A2b3/6pecsK7cDSNYocYNAJe7lf41uvNHebthImLfE1/S+qAWYhx4q7F3IEYQamOe1fcI8xTeTVep
	Hiz4XhQH+2CZFw+ZaXVEm8XSPkRT3SReyqshx1RLmxr5d3wWmjdrzt+bpmQ3LpHYDSG9S/lbhDs8w
	OWpHNzzJZnTnppYLfBaRzuACzTf5SZI4gjNTab9/Nj3I0bwx9/HgfcfcbyfWOqeGMKPr8MBrTvMv8
	0zG4q/mi+GSc+8mNz1DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc416-0006S3-3c; Wed, 26 Dec 2018 07:54:12 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc40y-0005xl-Kc
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 07:54:08 +0000
Received: by mail-pl1-x641.google.com with SMTP id gn14so7271371plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P6KcVI3cNP/m+Pzq7VPTxDfr/tNVCCBYar/ZL8sY5nY=;
 b=BHhxaS6ToMPmSSUplC5HwpdloMho11QilVm013+jJP2dh7iJGFRyDfG/L++5HApmdK
 AOueomkkX2Vrgjbst6+biH3dVyWE1HcL0bJeR0ac4YKqnswidbLFOOIohXy8vK/Sq3f5
 IElNA8RK87/SKz8wCiB6xCuVyfJtKQOHFUVSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P6KcVI3cNP/m+Pzq7VPTxDfr/tNVCCBYar/ZL8sY5nY=;
 b=C5glnnRaDWIjGcHxbtgP5nlyIdwDc2URq/PxlXjmVLm+xaEuW4wbdfu/aSVk5uW2Fh
 9VBZO+Jymbtp7Mt6hbrBdi5LeBvs2rN5tXEjxG0OcUF9fevvwQv9+LFZXtHQQxOSQ9Zw
 HrshS3LokEbainssk0zr2ceZGl3bPSZW7BkfuuNH+hbgm1IOAK9LL6PJZN7NX7wurmti
 zJU1lEux1BIHbEaY8kyEDG3/eZOT+Vfp+Zz+8rEG05dwKwn8uicq/C89mG6cmHiRibf6
 hxIG7fO98TMTOdAOEEQgJBWMaabVuuMbhyVdOBfYPwOLlqECiErVgztqdX9XqI9EprXH
 9iZw==
X-Gm-Message-State: AJcUuke/NbIXVVBd3UF6OMnkDGeGPS2Z3sDmaEy63soQm6w6VdJ0MFNt
 nDQZfGe/ZYqfFH1MdZIaIx4HUg==
X-Google-Smtp-Source: ALg8bN54QEPfkuxduBY8t3+Ak8DMbpajQxNGG951kjbvOLaqYyatrf2rpWAr5huxlCP+e4gCbZKlig==
X-Received: by 2002:a17:902:a70b:: with SMTP id
 w11mr18770971plq.84.1545810830966; 
 Tue, 25 Dec 2018 23:53:50 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id
 84sm107392395pfa.115.2018.12.25.23.53.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Dec 2018 23:53:50 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC,0/5] Add support for mt8183 SCP.
Date: Wed, 26 Dec 2018 15:53:08 +0800
Message-Id: <20181226075330.82462-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_235404_849972_EF7E87ED 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Pi-Hsun Shih <pihsun@chromium.org>, Eddie Huang <eddie.huang@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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


Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (3):
  remoteproc: move IPI interface into separate file.
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: cros_ec: add EC host command support using rpmsg.

 .../bindings/remoteproc/mtk,scp.txt           |  10 +
 drivers/mfd/cros_ec_dev.c                     |  10 +
 drivers/platform/chrome/Kconfig               |   8 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 164 +++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  76 +++
 drivers/remoteproc/mtk_scp.c                  | 441 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 109 +++++
 drivers/rpmsg/Kconfig                         |   5 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 341 ++++++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 143 ++++++
 include/linux/rpmsg/mtk_rpmsg.h               |  34 ++
 17 files changed, 1356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
