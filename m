Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0016C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30020651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EK1PFECE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSC6QX8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF30020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4zvrQ3LGwuVQa/ScMQ8bvG0YMAIdjrCmTlO6K2Z2sIo=; b=EK1
	PFECEtX9gun+Ex+k4XGaDX6M1MOs5HpbAL3B5LhIs3NJEZmcwfn6y20f0+xCcejK5+EhdUmbrFWbl
	oVGMs130SmFTF7INCtLZHGGLDcftkerQUVZEUzhiQPRobYPSC7DyAH+yAch3X02lGuFx/o3+nqs0H
	CJPJHkBER/7opOpBumhEWeFSYqOeBfArzxr2IW+JaBmkFOjPD2m1h/K5wq/kbm9JV3pKDZ3nmwvWc
	ovCsvI/3tdtqqhs/fAYZIW5RUNSBs0NeBbnW42/GoGA917vmc2xVp4dd3jV1Iw5gYdrxZRN6z2HE2
	6jiD09KkyLQvn9d7OXN6fmVeejWlwBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoiE-0000B0-Ke; Wed, 16 Jan 2019 17:10:46 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjoiB-0000Aa-S9
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:10:45 +0000
Received: by mail-pg1-x541.google.com with SMTP id t13so3078729pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6lU/QXZ6PixbpkGrYwz26+me4JRjz2P8Wqin4wO2y6M=;
 b=eSC6QX8WfE0rag8cfgMdkJN3CCSoBhtoh6K1UYVX2FwEpCEB1asANskYRWgMLCGJID
 8LX//X1dn7zi6X1zurVR11JxF1GaX2qaxub+uGrH7JUX+TaGbBUMuQyWdiMt35DmVie+
 GwMiHHW82fDsFCTx2GY6p/tUFM6UJ0IQuVyC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6lU/QXZ6PixbpkGrYwz26+me4JRjz2P8Wqin4wO2y6M=;
 b=jEsgmLt6D8qGeQEfd967Y6InUEFkZY+Fk55V9lHaEQLtSWUC9BdAs9eCcm9A/ygDnP
 Nlaw7UI14WkUkNLFbRUea39IWMV6LruX7j7UR16WyE8j4/DNFNTd+uDgk+eIpegTzf8S
 4BbYTwW/qZf6TAByQXHiKYXDOy0q6KAny3l/SZHXh6Xn5qkyK46L90JBLFdI4qTlQXIl
 R8YQhtVWSxVv4HcGJemF6gWf2gdQU28UKYqAKDtaLJLIF/5oqtByJCwsNYy6QT8tpIyk
 vPpNjoBngiSAPKIInsPo7YBXikkKvoCGs5ZXjRIFlxXol5S60e/fo++CE6C+42lI43lW
 HFrg==
X-Gm-Message-State: AJcUukd0dTR9r/M7sxkMuPu1AfK2QO7nbdBLlhzyHHW5vXFTXmeFnT8S
 uztfZXJ5tfFIsFzEQFH+cGWYYA==
X-Google-Smtp-Source: ALg8bN4aeDHRM6MhJ58qVrHEyVr3pC2SujM5CGqXC7rRAq11+k/dU8aM5R4KyLc0sdIGmVxpa92PXg==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr10745642pfe.152.1547658642471; 
 Wed, 16 Jan 2019 09:10:42 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 h129sm17914023pfb.110.2019.01.16.09.10.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 09:10:41 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8 v4] k3dma patches to add support for hi3660/HiKey960
Date: Wed, 16 Jan 2019 09:10:21 -0800
Message-Id: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_091043_914506_96063D36 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Guodong Xu <guodong.xu@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series is based on recent work by Tanglei Han, and
adds support for hi3660 SoCs as found on the HiKey960 board,
along with a few patches I've been carrying.

thanks
-john

New in v4:
* Rework hisi,dma-avail-chans to generic dma-channel-mask, per Rob's suggestion

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
CC: devicetree@vger.kernel.org
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


John Stultz (3):
  Documentation: bindings: dma: Add binding for dma-channel-mask
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support for dma-channel-mask

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/dma.txt   |  4 ++
 Documentation/devicetree/bindings/dma/k3dma.txt |  4 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 4 files changed, 77 insertions(+), 11 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
