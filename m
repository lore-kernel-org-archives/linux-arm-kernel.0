Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2883C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511BD218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nTlq24/N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHZLccXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511BD218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=w0Pq8c3gS2ccIWLanOmrwSRu/qdT93RG8oERfhcrHec=; b=nTlq24/NYlz8D8
	NDjek4QOQ9t02LEMrOOANsBkj0OOG9CgqLA7jKrWMjaWLC1/2RxSVGP/mUWuPGtbrkny3TRQgBgkE
	ERAwV4xwdJPAuGTceJotvY8LPpjg0C4GmNs4fXU3mrzcBb14MUPtZDX2n3a1+GTJi5Pqqc+pJ4hTf
	t1oYjdFW8r07eZwKs0adTn8y//P5ehtjwwCVX7MYnF3r2d3+HdjAEOKZhFWlbDOTbuC6AdydLBzzn
	vwLC8ItBJovs4hc3KCf6d3a9JBln0A4rR2UQek9ViWdlfoiCRHORW/ohycdEQj/pT83SfuhqRrZP0
	bl36+zQV8OC+zNNZaRUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8hB-0001M8-P0; Thu, 31 Jan 2019 09:31:41 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8h7-0001LN-N4
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:31:39 +0000
Received: by mail-pg1-x544.google.com with SMTP id c25so1127108pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4OtgONdJwDFd234v9Pslh5YREJZOrcQFD7neLLWvizQ=;
 b=CHZLccXLaDg9+KFMEYFlx4YSl746hZhxGzFP/L+KAFwPw0whxzS99AIiRm0E4pODS3
 12Y85ZJJH+A3u/J0Xog2wO8bVROVtVZkfHr9dzT4AH5sGsRTWqLovnEmWlAPOb7bJ5nc
 nFc6CklsW+XZUmYgGR+QRfWp41rlIAfkySa3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4OtgONdJwDFd234v9Pslh5YREJZOrcQFD7neLLWvizQ=;
 b=jkK6bwGMqpHfk853gHlpY9Td8PwJSJNr4Pmvkdy8P5kkGEgRATJCM+0kH44aGV+OB1
 TjpfqGPv8SYnpi2pBOxXiqrsPXdMbZobQE518JrNzFqR6bR+XlmOx5BDtQSUn1xJlDqi
 hwhwrLGVPTB6IF5flZOT9hbNRjPBAJpZUeb2tNOTrkFjEbh/9lNLcKZXWE9lEWZdlve0
 IGLbi74RrxQxZguOtPWrwJ0mAi57tztXQjsfQZSlZvVt5TMupB/9u6TtxhKNjfe5K80J
 3aJljrd5mXn+BIp7u2eYENuba+la8TQvcnFHHwraj4yiJpdmTWTetI1Lb5oHutMnzpSd
 U0kw==
X-Gm-Message-State: AJcUukfOGOwKO9M+hrI3LKGiOZp34wK4+QW++8swyir6v4oJDAuONDdO
 5+VzUt3CFYTn9z6YH54lprNTJinvR7Y=
X-Google-Smtp-Source: ALg8bN5TektkrY+Po7AxJfIuDBh0Om3Y3YLa0ivgbaake1UzSqG9jplBvVV29z7Pk5q85F70m+yJug==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr31025454pgj.410.1548927096317; 
 Thu, 31 Jan 2019 01:31:36 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com
 ([2401:fa00:1:10:7889:7a43:f899:134c])
 by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.31.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 01:31:35 -0800 (PST)
From: Pi-Hsun Shih <pihsun@chromium.org>
To: 
Subject: [PATCH v4 0/6] Add support for mt8183 SCP.
Date: Thu, 31 Jan 2019 17:31:25 +0800
Message-Id: <20190131093131.245531-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_013137_772837_51CE34A0 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Erin Lo <erin.lo@mediatek.com>,
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

Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (4):
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: add EC host command support using rpmsg.
  cros_ec: differentiate SCP from EC by feature bit.
  remoteproc/mediatek: Load ELF instead of bin file for mtk_scp.

 .../bindings/remoteproc/mtk,scp.txt           |  10 +
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/platform/chrome/Kconfig               |   9 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 240 ++++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  78 +++
 drivers/remoteproc/mtk_scp.c                  | 519 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 165 ++++++
 drivers/rpmsg/Kconfig                         |  10 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 384 +++++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 137 +++++
 include/linux/rpmsg/mtk_rpmsg.h               |  35 ++
 17 files changed, 1611 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.20.1.611.gfbb209baf1-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
