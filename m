Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5053121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TNLq5uuE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJlsRFt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5053121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tHolLzixZIXm1y0YoDTz3zSF4k77YvJiG0j1QdrxQhQ=; b=TNL
	q5uuENMFbbgCvHdh+mUnsL1hkZE8I6Plp7VCmW4FsQ7FN4W5iVECV87LU0awjsJLgiG5m7uQReCY6
	pU/nCpkCbgHabIsNfID7RjCgis4t/ZDJHnYeHgMaRDdA3fUi7/1j8ko11oP6ojmRw81bxgtSXrr5J
	ITJYKPW0gp6JPY+wPmCzLLZDSeBkWbdjZlQPfQnFL/5BJwokpCmdNTBFpyy4O+N1L15vmuA4jrBNL
	Em1z+TykNgftjPsWLld2gX+HPaPxvU2v7kkHZhm4CFgrIWCQNccSPvSjxWszCyRgKNdM/Zzg765CF
	O9GpOB0+R5JOe3Tek91LA4DPyDzv8WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfWWD-000764-EL; Fri, 04 Jan 2019 20:56:37 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfWW9-00075X-Ri
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:56:35 +0000
Received: by mail-pl1-x641.google.com with SMTP id e5so17916950plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ElBjH0oOsuewQ5qkTBqSFhRYlw1E1pEbHM7AsYL8nVs=;
 b=YJlsRFt7rSdlC4/aiKztcBA0pdS+bBJo5TOoc5WsSqN7Tv27V1B+i7t8M8NrjCEXUn
 QzIZ/8EyZwgrtLiS8TssVwo8iYzUlxQgGlxjVsST6y6cbUu3nd9hxaQlN2SmTVroWiaI
 H0pfCb16JSuFLYZ6z/Oy3M8gWMXfL+ErtGsjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ElBjH0oOsuewQ5qkTBqSFhRYlw1E1pEbHM7AsYL8nVs=;
 b=uO4dyZleMO8uXcmwOLzLJ77Wd9H8HwrsMpaT79C1+TdV4gG2eAqHFmdTNopNAwYdCs
 8ZwAOja3Ibx26mEL28DwS2KFzWGg+Hzn8SdXau/BR9DpjzIi6BaVhdhijte5rYA2DrOT
 FBAVd6R62PzPCB3jk31PigvqKyZswORi8GEkClbjRkOagCFnudpZKO0AIHAaaU01ZCD8
 hqxsvq8atDv9c5fop5AJ1KFMy+UYG3FGrZc6kq61DERRXBlE8/AveWn6SMAWVujunkXD
 xGAYoJNsPsrDJOTpFU2aZUoAimeL0TDp457PRqHfvrY4IOURW4RcTQJbY5ID3bioOuw2
 CMRQ==
X-Gm-Message-State: AJcUukdbFKeLFnM5vEl6qpo4SbVzcWubKTgsOUzTf3ESwcvyjzAcilGr
 v1fY8qeCS4iDf1dL6ySieybHVg==
X-Google-Smtp-Source: ALg8bN7HrvutjzMcEujRyx/xslInrqd4lahi7pFchnwiJVKEJcM1nyGUsT+tNVpnxEoWdK7ZgSOkgQ==
X-Received: by 2002:a17:902:784d:: with SMTP id
 e13mr53096524pln.188.1546635392657; 
 Fri, 04 Jan 2019 12:56:32 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 l3sm98058334pga.92.2019.01.04.12.56.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 04 Jan 2019 12:56:31 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8 v2] k3dma patches to add support for hi3660/HiKey960 
Date: Fri,  4 Jan 2019 12:56:20 -0800
Message-Id: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_125633_898103_179CCD2B 
X-CRM114-Status: GOOD (  12.81  )
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

Review and feedback would be greatly appreciated!

thanks
-john

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
  Documentation: bindings: k3dma: Add binding for dma-avail-chan
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-avail-chan

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support to dma_avail_chan

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 22 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 3 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
