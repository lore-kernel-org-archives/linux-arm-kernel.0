Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EDC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636112147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E5N5NLJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jK6YoPD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636112147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=G+nF1sSppelexpz/X67XftQdb2YNQHs1V8Hyw8Yf5ms=; b=E5N5NLJBbKe6ZuQNJrMyswkj07
	lR5SD1t5r8rfnCgSYq71Khx/Z69ue24t1CHnjErZrUrnfuGyimArrH/2e7p5k6Az7NWu2xXgrDJg6
	HTJhPIEJOiAu/OJnM9Vuy3AREC3NcOfE5Wv3s1tLy0QtiBTFKKtk63IU+FWkwXXB2rwwwR25TgckD
	KOKzf16x+emKAVZj2N9AEIRSEl8sFr/iTA0fnBmMX6wNRSp4b5wqG8TCG88mO4S+GQRfFkXtW4XiD
	jnoJaWzFlEi43X0FX0lCYkIZrXvlfl87CcMkdMx6YUKsBey9QoeENnoizjXAe8LJ+5sFZBcSKTm/P
	IreTXZcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqVv7-0007wy-1R; Mon, 04 Feb 2019 04:31:45 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqVut-0007js-Bx
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 04:31:32 +0000
Received: by mail-oi1-x242.google.com with SMTP id u18so10431603oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 20:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s/QI9V7azNjREpO8PpBZGiPOGxr7gO2Kz/Xe8P+g5Ds=;
 b=jK6YoPD7Ut85loQlJ/nGw3xmE2soDDNPvB8ej+AUNn7uXLuVPqXkVsjVWI1ExNhgAc
 D+5c+82j+tlBRE5Veg7WVyjhjcPLj2zLR2eH5Vyx+Ya4rm+whznveg5LqX1TjvXMFBkG
 rwLQSRDDai32aI282yS8zWM9+72fhDy1nR5lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s/QI9V7azNjREpO8PpBZGiPOGxr7gO2Kz/Xe8P+g5Ds=;
 b=Y6MxGqh7r6IAZ/bLpYH8Ei6EkYB8E2S7+6F3wdbzQqfqpqGWWWiwXrIH4+Sp+gl38d
 pce/KkjFlDHCQDaBYE3jCTMaYlw0sTH+x4v+sQHWusYJ/rCvlU3xW2g5PM1Qb4W6bV+J
 NL5giLHB89H57j+zkRlJKIUNmStwARNgXG+CFGDfGINXDHpvNDHV1Z3eKZQExT6NcLle
 5vdpw+OBo/XjQlkeMmKVrXA38NH04fB9g3B9WCa56h/QszDd4gCzsFT8Srffx3zXvRiZ
 iyAJ+UZKfRNX9SC1H4F5AZhwi3H/9+bR4g2fJ2DSQFbt1uwSvNSIt0/mRLOuTApmp5ji
 ATNw==
X-Gm-Message-State: AJcUukeTU1xHnfqzz1R4rMByJ9VIlL/3Fw4OilwotW450Tl9XL5qhADJ
 WE2cZaRXE4jNJdVsxlWcQ3qJGw==
X-Google-Smtp-Source: ALg8bN6qLpI27EkoMV7OmzoN0HALiuL4qJOfzk8pS3q8hZ5qcYoXZ2ENkx2HT5ktziWRejdn7cY+9A==
X-Received: by 2002:aca:d705:: with SMTP id o5mr24563772oig.124.1549254690037; 
 Sun, 03 Feb 2019 20:31:30 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id h24sm6032586otq.11.2019.02.03.20.31.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 20:31:29 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 5.1
Date: Sun,  3 Feb 2019 22:31:19 -0600
Message-Id: <1549254680-1282-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_203131_406911_4284315D 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-5.1

for you to fetch changes up to 4e2256d31f0f24107c36dae35a1d84dff0fced30:

  soc: qcom: smd-rpm: Add sdm660 compatible (2019-02-01 16:08:58 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v5.1

* Add Qualcomm RPMh power domain driver and related changes
* Fix issues with sleep/wake sets and batch API in RPMh
* Update MAINTAINERS Qualcomm entry
* Fixup RMTFS-mem sysfs and uevents
* Fix error handling in GSBI
* Add SMD-RPM compatible entry for SDM660

----------------------------------------------------------------
Alexey Khoroshilov (1):
      soc: qcom: gsbi: Fix error handling in gsbi_probe()

Amit Kucheria (1):
      MAINTAINERS: update list of qcom drivers

Andy Gross (1):
      Merge tag 'qcom-fixes-for-5.0-rc1' into drivers-for-5.1

Bjorn Andersson (1):
      soc: qcom: rpmpd: Drop family A RPM dependency

Craig Tatlor (1):
      soc: qcom: smd-rpm: Add sdm660 compatible

Evan Green (2):
      soc: qcom: rmtfs-mem: Add class to enable uevents
      soc: qcom: rmtfs-mem: Make sysfs attributes world-readable

Fabio Estevam (1):
      qcom-scm: Include <linux/err.h> header

Rajendra Nayak (8):
      dt-bindings: opp: Introduce opp-level bindings
      OPP: Add support for parsing the 'opp-level' property
      dt-bindings: power: Add qcom rpm power domain driver bindings
      soc: qcom: rpmpd: Add a Power domain driver to model corners
      soc: qcom: rpmpd: Add support for get/set performance state
      soc: qcom: rpmhpd: Add RPMh power domain driver
      soc: qcom: rpmhpd: Mark mx as a parent for cx
      soc: qcom: update config dependencies for QCOM_RPMPD

Raju P.L.S.S.S.N (1):
      drivers: qcom: rpmh: avoid sending sleep/wake sets immediately

Stephen Boyd (1):
      soc: qcom: rpmh: Avoid accessing freed memory from batch API

 Documentation/devicetree/bindings/opp/opp.txt      |   3 +
 .../devicetree/bindings/power/qcom,rpmpd.txt       | 145 ++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   1 +
 MAINTAINERS                                        |  32 +-
 drivers/opp/core.c                                 |  18 +
 drivers/opp/of.c                                   |   2 +
 drivers/opp/opp.h                                  |   2 +
 drivers/soc/qcom/Kconfig                           |  18 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/qcom_gsbi.c                       |   7 +-
 drivers/soc/qcom/rmtfs_mem.c                       |  32 +-
 drivers/soc/qcom/rpmh.c                            |  37 +-
 drivers/soc/qcom/rpmhpd.c                          | 406 +++++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                           | 315 ++++++++++++++++
 drivers/soc/qcom/smd-rpm.c                         |   1 +
 include/dt-bindings/power/qcom-rpmpd.h             |  39 ++
 include/linux/pm_opp.h                             |   7 +
 include/linux/qcom_scm.h                           |   1 +
 18 files changed, 1036 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
