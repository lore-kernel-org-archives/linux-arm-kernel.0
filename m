Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B67C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26CA208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtbs4rmh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bk66Cz+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26CA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=IjxAOWxYT94n85mQS4ZvHXJzGgxqPeaceLj6WoT6ipk=; b=rtb
	s4rmhl2CzGImAfFxiWDNlR2PHSCMvvR5y0PXTlbU39CrFNw2CpWu7MJBfSmlT5QSPNyM7Zk+1Ez6g
	YO4uvxOPn3/XcDcfNflVenFAKM49gpwdgVeYgONZuuVuC2PMvDUepHZmnAu+jOQPEEhPpt4NwgMbk
	x8V1/GcHdVoiw9Xk1Epni7lvwlO2P6LFKnV9+Kh0u0x/MdfJ3oaxNKk4KDx2lTx7B3vrlFdQ8Il4E
	7noGWvUeI7fm27IHD1x4CmYjt/PB4RnFjv30fWDb/TkOqkHsMH2JB80rt794GoEPrICCPfnCOKGNR
	m6nGSkas6hlqYzOOXYZOm+NK9zaVSQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfgOd-0004ro-7w; Sat, 05 Jan 2019 07:29:27 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfgOa-0004qP-3D
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 07:29:25 +0000
Received: by mail-pg1-x541.google.com with SMTP id z11so18452861pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=y2kjBfabd8Ed22a6YMy+7qr6U4HPwKuqVjrbxxMoTC0=;
 b=bk66Cz+E38O/ZC4NZ3HWn4zbC4Z3nv6wD0dd6SVzho7SuWmKjSl0+9VIgg1un9Pgei
 TNShcJxBqQ2L0ttG6uaXAMf4ASRI85yVr7NWPq4V3wpDSYkk0egW2TVi6pBiMFQguzzC
 Dxoiox0dAuHnmSYs2OAeXxOsPwpR5lD7G0f9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=y2kjBfabd8Ed22a6YMy+7qr6U4HPwKuqVjrbxxMoTC0=;
 b=jgFJSrYZFVvGH7tErw1+5ITOOK5SRpDwXd0hi1ARoU5IqQ2vtNJnuKT68Rw5tDfUWL
 8L5FrctHkts/L7EOo88YMmgjo37P7Ul/OfzNn5wfEPy2QKwtE/1muZ2WgFCp3WI9+PUq
 0/Mq1FxDq6K2bv53cCc1IQN3SPEj/XYheBtufVCoFnfs/IfVWt2olAOpOBja7hnGr5O1
 C8RpfRlDCYdB8Jd24iLoVs311gK26ui1mdIdZHg92UfZrpfVFbFvUCPR8G1JrZ8rnJo6
 F4z0x956RLCDxn+cPqRyC8MMRZal8KWVI11gyfkmPB2gjYz/mwSHFaioB54n37PQzeNn
 wFLg==
X-Gm-Message-State: AA+aEWaOmAMNjLjBLiy9UVxSoW3aq0K85arAaiVz/E2IM2qox91m/krY
 zkU9vj5BbnjPQ/3QXUjdmQAF3JJs8A==
X-Google-Smtp-Source: AFSGD/WfGxk0zTINcDE2Y4BN6JhcC+qf57cdNyTjKpB7QDFvlEVSKhuFgfRqChT7SBSqXK3F6frjmw==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr57541884pfc.54.1546673357404; 
 Fri, 04 Jan 2019 23:29:17 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id k24sm90677367pfj.13.2019.01.04.23.29.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 23:29:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH v2 0/3] Add UFS controller support for HI3670 SoC
Date: Sat,  5 Jan 2019 12:58:56 +0530
Message-Id: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_232924_143305_9783AEBD 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patchset adds UFS controller support for HiSilicon HI3670 SoC.
HI3760 SoC is very similar to HI3660 SoC with almost same IPs, hence
the same driver is extended to provide UFS support. Only major difference
is the PHY. HI3670 has 10nm PHY, hence that parameter is used to
distinguish the difference between two in driver.

Thanks,
Mani

Changes in v2:

As per Rob's review:

* Removed interrupt-parent property from binding.
* Fixed the bindings patch commit message.

Manivannan Sadhasivam (3):
  dt-bindings: ufs: Add HI3670 UFS controller binding
  arm64: dts: hisilicon: hi3670: Add UFS controller support
  scsi: ufs: Add HI3670 SoC UFS driver support

 .../devicetree/bindings/ufs/ufs-hisi.txt      |   5 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  18 +++
 drivers/scsi/ufs/ufs-hisi.c                   | 127 +++++++++++++++---
 drivers/scsi/ufs/ufs-hisi.h                   |   4 +
 4 files changed, 130 insertions(+), 24 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
