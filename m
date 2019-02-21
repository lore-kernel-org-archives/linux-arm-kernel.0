Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D08520880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hwfACbfy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGkxXLAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D08520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vLA2HF08Pw5Sar10F2c4/twGZKtwEAgkwbMKIyFOJIo=; b=hwfACbfyHm/Tre
	aFhM7+h0xYCd82bAwxYTE8zE7xgkvrUEsIfbKZhxKa1VHVhSFfBbqt/Tp55BGuUlNSr7RdLAFiO+0
	Lz0k1Jqvpgq60e2cW/Wk/ogqKvf5QYUvMkbkvKS0qJIGUUcnz/AN0iVEFQbyRXuCaL3NA04gG4TEz
	Uh7lJ/dAC8rzsACCWObAE6dLdmvdjw4wmvm1b0RNWcQNdlEQo4DNgyhzgzKcoKkMs25LcM/iSx+2/
	FKSAxuXSxyJItpH180JM7eQ4r0H/SfK/voFQG7vBZDDpuyPfMZ/TihuY2KkN4amXEL6qA53DEFgMY
	MWEr7lWskof5GEiEFtRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwk1z-0006RB-9q; Thu, 21 Feb 2019 08:48:35 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwk1u-0006QN-HK
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:48:32 +0000
Received: by mail-pg1-x543.google.com with SMTP id u9so9918860pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 00:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vROhy5Plmd50xPCC/Q/QS2fuBqQNtJbtmF30XL2rY0I=;
 b=OGkxXLAmXTDDTQhksDfNZ3HIwUESqZRKIiXe1lTFBIsfOhKk4vM2yPtQggUEcdTLkX
 haIPRtLM0cwfZif0RFUPilAP4Tl2WMeSseeLLr1wKr3ghgl7JbN+ujN/4etP7xq4erLK
 0qx+huuYpwCCy/itxxpB3zdZ9V8vn/MpZbru4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vROhy5Plmd50xPCC/Q/QS2fuBqQNtJbtmF30XL2rY0I=;
 b=exdBaQ5ng5vGhc/ognDzhTeDEEqnwvOtcL8NbTS/Tvi2H9sAldEY6jmMui5sfM8yfR
 DzgpQiHurlzp5A7KX5whGhxoQjphfgEEPhbJ/7zkt2559lRAGRjZIPqVB3ho50lGgtnz
 /2HrryrlD9OmB/KmYyi18J1oRTRmTvrp4Gh8Eu8XeEW4/YTBHGXJfXulpFFJCVNaP8Kz
 5N4u6f2rRlJYHu7gFfaUDbUSRpoBdGieik6afbDXlZAa+LOD8f2jT0knZH+Qf0oBXjtc
 MOQ9eMfxMAHt6jl2Jza9gfL0iDIDiagLtrF9EhW8yGxSH2XyGe91akIpRSEm1QQnfFRo
 7VEg==
X-Gm-Message-State: AHQUAuZkvURh66dL0hCXIB10UyQlXsY+uOhQtjvD/4/EEwgkCd6xMMxh
 iNUlJ6AZhVVpxNPQedmooaYS7g==
X-Google-Smtp-Source: AHgI3IaIXSJgaHD3TpFvI1ZV1oCwiy9yvB+mWo08WPJvnounP2mYhOStOn/R8hmpARgiwYyfGsKrWg==
X-Received: by 2002:a63:541:: with SMTP id 62mr4487159pgf.172.1550738908655;
 Thu, 21 Feb 2019 00:48:28 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.48.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 00:48:27 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v5 0/6] Add support for mt8183 SCP.
Date: Thu, 21 Feb 2019 16:47:23 +0800
Message-Id: <20190221084729.101784-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_004830_600427_460C1083 
X-CRM114-Status: GOOD (  16.76  )
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
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
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
* remoteproc/mtk_scp.c: Control the start / stop of SCP (Patch 2, 3).
* remoteproc/mtk_scp_ipi.c: Communicates to SCP using inter-processor
  interrupt (IPI) and shared memory (Patch 2, 3).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 4).
* platform/chrome/cros_ec_rpmsg.c: Communicates with the SCP over the
  rpmsg framework (like what platform/chrome/cros_ec_{i2c,spi}.c does)
  (Patch 5, 6).

Since I'm not familiar with the remoteproc / rpmsg framework, and there
are not much other custom rpmsg driver for reference, would like some
review / comments on the overall structure of the driver.

Changes from v4:
 - Merge patch 6 (Load ELF firmware) into patch 2, so the driver loads
   ELF firmware by default, and no longer accept plain binary.
 - rpmsg_device listed in device tree (as a child of the SCP node) would
   have it's device tree node mapped to the rpmsg_device, so the rpmsg
   driver can use the properties on device tree.

Changes from v3:
 - Make writing to SCP SRAM aligned.
 - Add a new patch (Patch 6) to load ELF instead of bin firmware.
 - Add host event support for EC driver.
 - Fix some bugs found in testing (missing spin_lock_init,
   rproc_subdev_unprepare to rproc_subdev_stop).
 - Fix some coding style issue found by checkpatch.pl.

Changes from v2:
 - Fold patch 3 into patch 2 in v2.
 - Move IPI id around to support cross-testing for old and new firmware.
 - Finish more TODO items.

Changes from v1:
 - Extract functions and rename variables in mtk_scp.c.
 - Do cleanup properly in mtk_rpmsg.c, which also removes the problem of
   short-lived work items.
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).

Erin Lo (3):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183
  remoteproc: mt8183: add reserved memory manager API

Pi-Hsun Shih (3):
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: add EC host command support using rpmsg.
  cros_ec: differentiate SCP from EC by feature bit.

 .../bindings/remoteproc/mtk,scp.txt           |  37 ++
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/platform/chrome/Kconfig               |   9 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 248 +++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  77 +++
 drivers/remoteproc/mtk_scp.c                  | 628 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 163 +++++
 drivers/rpmsg/Kconfig                         |   9 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 385 +++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 157 +++++
 include/linux/rpmsg/mtk_rpmsg.h               |  35 +
 17 files changed, 1772 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
