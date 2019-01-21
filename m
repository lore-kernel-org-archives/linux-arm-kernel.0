Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65753C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FBB20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0xpRpHS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fYN6BbVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FBB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0SE2K0Byl0S6Daz8w+N3xQnCg/o3yY/E1dAjG8UKImg=; b=V0xpRpHSRM91Kh
	tH5IonQtjBIbXib57dc9dIupgSb4lDcvJo7DcLVqClaUgnXQvgKDe1lf26K3TDSrwGNMS04qQ7clB
	nFkDMncSV7kqx8kAxcmHJXIBHdwrGlBRE0l7czHwLJYUymDV7JqzZm82/bLdaZQSkbPhlDumQy6z9
	jdLKMjlTPBJlIycPv1Fm38v9JO+hx7UntWzRKvrDpg45vzRqjo4SmyHeu1Uq4VowemCTXM/RAXOaU
	LyUaDqWopD77/8OA1b7BDEtU75PPWRTKMlaXC63OnjoRJ/36UoxSMI9xDzfgA3+oP+vBQ5691CFwd
	IAXiEtZWdzpjirvKkocw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glTr0-0000nO-L8; Mon, 21 Jan 2019 07:18:42 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glTqx-0000mL-9I
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:18:40 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so9038167pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6nGVfT8DBAMLYYNva9uGnefQdoalESvO1Aa5MDGIIVc=;
 b=fYN6BbVrU/gMF6Av5OwYaeDCI14V7YDqXEnQGPBR56VdAdOeAuTxpzqMg+n/OP5wmZ
 JDAxfNgRamHJhgi0k4swB0jpkZ1GQWPVVCdG8/AwcreGvZvUwa1Gm0kUs9aHtnZDmO5y
 Led74YLuz11HIcppG81PXssc7+cR98d9xDQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6nGVfT8DBAMLYYNva9uGnefQdoalESvO1Aa5MDGIIVc=;
 b=uX1Dm0g0VxgWVp7b4Iiv9Pg4INq+2IGz4M0Qpc78gAOjmzWbHBZbwelx/DlsjTDnTR
 qgb9101xkR/99/zbz1wiFsEBXYSfaJB0A8Id9s+jAm7eAgrknwoexaZWUHISMHHRRdMx
 MQ371vMSULzSel5Fd04TvKmdXcVkrYO5z2d3wEqAU/X2gYgOFRRU28SgNhGCMRMiIMgR
 Rap7rK26KT8gVCx5duh21Wf+kRMnh4ss/1CHz+Q0mkdD4z4m6Hl1WOMkPF4s7oCxjsRd
 2iicU+OmX9K0qj9D3CTfi72389uUUxj4cqzHGij10Rr908FmHRgS/RNMrIQCfyFBQLqL
 JcnA==
X-Gm-Message-State: AJcUukfq5yiXr9QoCVQYXBktcBn4h/H2WjVUns1FSZcrM/KEEMMnOZDm
 54zqmh8120hzbLrnOU3wdKfjtA==
X-Google-Smtp-Source: ALg8bN5UDnYyvb5OngueUpHvUdqg0KIAc3Te6rI7QWqYCrvKNjqdbdWxrmLl/vFUNGmHWq7cRrVbog==
X-Received: by 2002:a63:d604:: with SMTP id q4mr26838953pgg.175.1548055118513; 
 Sun, 20 Jan 2019 23:18:38 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id v15sm14941843pfn.94.2019.01.20.23.18.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 23:18:37 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [RFC v3 0/5] Add support for mt8183 SCP.
Date: Mon, 21 Jan 2019 15:18:28 +0800
Message-Id: <20190121071833.43443-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_231839_338673_2ACFE413 
X-CRM114-Status: GOOD (  12.85  )
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
  interrupt (IPI) and shared memory (Patch 2).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 3).
* platform/chrome/cros_ec_rpmsg.c: Communicates with the SCP over the
  rpmsg framework (like what platform/chrome/cros_ec_{i2c,spi}.c does)
  (Patch 4).

Since I'm not familiar with the remoteproc / rpmsg framework, and there
are not much other custom rpmsg driver for reference, would like some
review / comments on the overall structure of the driver.

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

Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (3):
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: add EC host command support using rpmsg.
  cros_ec: differentiate SCP from EC by feature bit.

 .../bindings/remoteproc/mtk,scp.txt           |  10 +
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/platform/chrome/Kconfig               |   8 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 186 +++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  75 +++
 drivers/remoteproc/mtk_scp.c                  | 460 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 127 +++++
 drivers/rpmsg/Kconfig                         |   8 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 395 +++++++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 137 ++++++
 include/linux/rpmsg/mtk_rpmsg.h               |  35 ++
 17 files changed, 1465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.20.1.321.g9e740568ce-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
