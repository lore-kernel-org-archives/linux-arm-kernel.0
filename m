Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC784C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0C4208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cdgqk6N3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwcVYPR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0C4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/rOpKH5aQyTiQJ1c/G0Jmt22r6TNTLagBeUnkfayuSM=; b=cdgqk6N3lPUVsZH5JPvDuCy+T8
	uVwmU9bCvE1r464dpCCf+8M4i68maqdxJw28owxDJ5GT4IysZMEG0XC/0ySYixLdATDymCM/bl9Xo
	jeKP3byDKG23CvlJsumd7+sKo2FGSSwb6xZOkTv4mzZIwuJH/KFja+1S/PjpQaY/39HF1NEyj37kF
	OKkA8OA/6aWw1VErivAl807h5U2jxL/36zGQBRzx4mk5MsDpoInZY6Bh+Is/69ZSK1nR2zs0KhaO2
	AE7SXYaYV0RBZwUsf4zpxqUeTOIbPLWjZG6Je0+qaTtpJpbrbJ9te2oBNrpeKtVPsVN0Jhvf0hwXq
	1HqdndZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu4d-0005vS-Ly; Mon, 03 Dec 2018 19:40:07 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTu3v-0004xq-Mg
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:39:28 +0000
Received: by mail-oi1-x241.google.com with SMTP id w13so12034480oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hYM4DihHngTcygMqlJ/OpJr39UU/+sI4RrKyV1rkS24=;
 b=UwcVYPR4QnP8KjjJEn4YYqMN4CwAk+iV+hGzAOVbf7QK51slMGpBQNJxRFn+CVSr9k
 v2QjBVGZJqAm5xvtzpR+bzjQ2q044h2TzTEzMmqMI1INEN0HZmvZ5nrdrCKa4/ghCWqP
 ygh7DFVRQA9zncz+c6pcRz+qyYr6JNwuCDFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hYM4DihHngTcygMqlJ/OpJr39UU/+sI4RrKyV1rkS24=;
 b=hHkG5VR7/822nsLys+5lvi+q9wA1vYJ0mcOZ2ECean381nE8SFYP/D9IGlFxbLnlLd
 Kmf/MGuukq1jEEQGfMffBpvPzl0vZ4Oj6mUyyprw7FWGwR4hR0Srr1HcYsPSAzYzqcaf
 RQkVBgkLm5teGu020AB2pDzhj4RnYGukShhENv05+CtVY27LgY7/qfRv5BrKyhjJrjYe
 uqJYMbEitQ+6/xdg6MRmV+YlcZ8ugjGS8vqblicM6BYXs6EigrlmgdRAwKatXdLYTi8P
 ckTCRzfksSQhYrvn+Ens18auicRXNu6+p2EGqUr3EsVUZlyXzgIFHOpQpDLy51WtmNAr
 UjMA==
X-Gm-Message-State: AA+aEWa7GC4sa2WSoErVO7rn8iHKrZT5F9oR2HcO+gWeiyJ3K3JPKdWF
 SY+XZdCYEvcS1guGMI17SWl9csQSW3r0vQ==
X-Google-Smtp-Source: AFSGD/VAnWtAWcqv1GlP0gPtyZXJuaT7stvu16FqgljC6ePfNsjD3d/oPrYPw/M+mES4Es1ehssCmg==
X-Received: by 2002:aca:da02:: with SMTP id r2mr10188577oig.66.1543865949268; 
 Mon, 03 Dec 2018 11:39:09 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:60aa:6557:7f4e:5d7d])
 by smtp.gmail.com with ESMTPSA id x9sm4963006otq.73.2018.12.03.11.39.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:39:08 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 4.21
Date: Mon,  3 Dec 2018 13:39:03 -0600
Message-Id: <1543865944-3591-3-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113924_092468_4EA3D50A 
X-CRM114-Status: GOOD (  14.60  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21

for you to fetch changes up to b601f73130a375c912d9f2ec93c5f3cea5d6a3da:

  drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.21

* Fix llcc license, includes, and error checks
* Remove use of memcpy in cmd-db and fix API breakage
* Add QCS404 compatible to SMD-RPM
* Minor fixes for QMI
* Add irq clear handling in QCOM Geni SE during init

----------------------------------------------------------------
Alok Chauhan (1):
      soc: qcom: Add irq clear handling during SE init

Arnd Bergmann (1):
      soc: qcom/llcc: add MODULE_LICENSE tag

Arun Kumar Neelakantam (1):
      soc: qcom: qmi_interface: Limit txn ids to U16_MAX

Bjorn Andersson (1):
      soc: qcom: smd-rpm: Add QCS404 compatible

Jordan Crouse (1):
      soc: qcom: llcc-slice: Add error checks for API functions

Niklas Cassel (1):
      soc: qcom: Drop help text for QCOM_QMI_HELPERS

Stephen Boyd (3):
      soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
      soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()
      drm: msm: Check cmd_db_read_aux_data() for failure

YueHaibing (1):
      soc: qcom: llcc-slice: Remove duplicated include from llcc-slice.c

 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 59 ++++++--------
 drivers/soc/qcom/Kconfig                           |  5 --
 drivers/soc/qcom/cmd-db.c                          | 93 +++++++---------------
 drivers/soc/qcom/llcc-slice.c                      | 17 +++-
 drivers/soc/qcom/qcom-geni-se.c                    | 25 +++---
 drivers/soc/qcom/qmi_interface.c                   |  2 +-
 drivers/soc/qcom/smd-rpm.c                         |  1 +
 include/linux/soc/qcom/qmi.h                       |  2 +-
 include/soc/qcom/cmd-db.h                          | 12 +--
 10 files changed, 88 insertions(+), 129 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
