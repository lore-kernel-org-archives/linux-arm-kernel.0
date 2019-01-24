Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8E9C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF949218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+o6lHfq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgKLtKIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF949218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=gAHTkx+HofidQ2GErXjKh9Hds3INw/YakaZpVUChmiI=; b=a+o
	6lHfqHm6fFog0EIeNg2McZW6+ZmzuTvniLGz6fsSSMYzOrkECnNQ/pNDbLOKRIeEQabEFU9lieiRU
	DHW01skEPz3QMrd4tq7ILjMLx5ZPHh21c66BbcxAF+ViBP9uwnHTF7kEz9iuWII8vT+c13stnlbFx
	lmjzEi+kbcboL8qif1x6n8HvP7YMXF2/BjRcV3ab94HqRfcbVezKntV7r7aOP8Du1C3q3szuX+1EA
	JeL4vpWhqo3kJkJNDP/7Oef4zNvgUUv2ygx1jd89UNQIp5uAlrv1Zins2oyMhXuOhNBnI+dqJorXp
	8hJ/kJZQKBSc0KdjjKEghoNbtefiyKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlY8-0005ji-8q; Thu, 24 Jan 2019 20:24:32 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlY4-0005jM-Mi
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:24:30 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so3559992pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bp8b67pG2vTJ7yWzC/S5wh8lIvcx0mZj/HjgKpZRDlc=;
 b=bgKLtKIufJMwtHBgfGMqC+7n6MJbRWrqDhVyWcgTLdVlF3WxSryGjvn4NFTKtMxnul
 eISMksc55KItcYirUqh9zmt3q1zdsoWrjRSJI3d9JPvgTHVMFxU4jAslj5SOImQOq8UY
 RMT8wZeWsgM2jT9P/HZ3zwnrHEu9QZq8RLAOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bp8b67pG2vTJ7yWzC/S5wh8lIvcx0mZj/HjgKpZRDlc=;
 b=JOYLiunbLsuokQqj0UXHPpvScjR6eGCdatV5yr/0QKfvP0xs9gqUGZHQOc0aHEQ3S/
 u7AOj3HJLTCll1vUcmH6KtA/8yk7cGeK0m5Xet6dJfO5oYr9MQj6Uz+WrGzVpMtXEUxl
 yoLhFSyTAzZLD6ATcK0FT0Ih5iXJ6u6NRREtwqgvh86SYwTZfEveDf8n5Xc+S/kWjm/Q
 jHupeHbDU9HW/3lu5IstIxxDawhbho/F4zQ3Flf+qmt8xc6BQ35Sc9G9IP3VDK51v20Z
 bEg2pWYXonGjhecDYieBVnxCvoLqMKvbUDzb4Q9sWiI8zEPB2O2aF0Z1kBWPmsbHhVEc
 pSOw==
X-Gm-Message-State: AJcUukeCNCJhdWVFBzE5thgDlFd32f5T2h5aAH+CNxm7f1BSdwDxudo7
 u7b6DRf6Xd39RdAYEI25Rw/rCSHYLEwbCg==
X-Google-Smtp-Source: ALg8bN4dXRv1fmtfHH9kDqCWAAdrhTfrb2iLdGric4sRzwtXAUuaN++SnL9PbVNOik8ST2bSLXtLug==
X-Received: by 2002:a63:c848:: with SMTP id l8mr7214918pgi.78.1548361467519;
 Thu, 24 Jan 2019 12:24:27 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 c72sm45263309pfb.107.2019.01.24.12.24.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 24 Jan 2019 12:24:26 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Date: Thu, 24 Jan 2019 12:24:15 -0800
Message-Id: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_122428_745700_E8C1D41B 
X-CRM114-Status: GOOD (  12.39  )
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

New in v5:
* Minor typo fixes, minor rework to use BIT() macros 

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
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 +++++++-
 drivers/dma/k3dma.c                             | 61 +++++++++++++++++++++----
 4 files changed, 78 insertions(+), 11 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
