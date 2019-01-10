Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49102208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DNl7rY8I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+snrzqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49102208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lKdLCwE/prgAccJKDAREl3mMHFA17JtVy3/jXiLXBeo=; b=DNl
	7rY8IdZkYlaayGHG1aCSiMkn4zGOHNs7bnUbxOa97CCEU2j7THOQGpyBuOZMyrFOdqtnG8lS+5x2E
	4keSRcuOQovw3Qmyf1KBtzosRiWooojZFImYevGpBFt7+/tHjeL/DP1w+82a0maYzbmdxV8JDxJRf
	XL59yL0lwuCJjXqg0CGvOrSnra6sl2x+VNl0aAHlDdZPsD/3hrlQ8WTjG8qCh6CGv6LuIIAJEn6ZN
	HEqLXG3sysyTXIM/SmE8K5sLYjBmYRylMH6qVMx2oibjnwK1yW5ntUFilSKQhTRqmcuzg0FZKGIWC
	6sUJPwf8abnNQIwFNId1yz4oyMdUeDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheDk-0006bJ-2n; Thu, 10 Jan 2019 17:34:20 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheDg-0006ay-Oi
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:34:18 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so5489261plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=UMvSdiE9NQb8Gth/j6Scv5auomzdDy6K1LUx8wBPip4=;
 b=S+snrzqVx87Vv8vO3Vd4/93M99EhiAo+3zcwPBjfg+caaG83DhaALpoDIZcM5NbcNb
 V8hTusXjeWHskqvlbM51H4HUSXZsuoehPol+HkoMQcFe0BDjoJT6Q224yzQfhkI9j85C
 LlCoo1gci/dGQ+bVrLzIbaSgViF6Oq8ouSQHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UMvSdiE9NQb8Gth/j6Scv5auomzdDy6K1LUx8wBPip4=;
 b=qrlBA2aB/EgDyKCT+IKBR5JNYj+JYR2TaLGxHd19HugdxtyPQS5qHHdYhtl5Ly+j8a
 yMB3ivZEhpekltedmv5IXcE0YSU8zK9ZuNujHRKw3alepTtvcODpdCzmA5P3SAf6P40j
 SnUMv+u3dcFhfegi36kWQ9a/TK/lzOA9RnF3TNxME1L39kn+1bBNC3AjYJFIP6N7X0KM
 S/m/xlUIn0eFIE3dDKFtUTwfpEKFdaN9t6aOpxeLaOOt6J0ZM8rSZxF5hbwmiTEqNGuh
 kVSUSdo4LpBWdT9k3DDxEn3z7gXWISRiPBkvC8pyeLTCatijaN1Wtdys9Bh3WH67IFoW
 rCiw==
X-Gm-Message-State: AJcUukezKt6eh9jc93JN8XOnVrAULiBaIpuQUDYdMe518YJVba/u5obP
 VJcvHWam3Q8A/qp471SzmHIg+A==
X-Google-Smtp-Source: ALg8bN5XWk2o54dWlRyD9TPXSEYKYh3HdyebYLKoOtSdvrA0c9KEPzTfpNiFMCAEsTt+WysR55zxDQ==
X-Received: by 2002:a17:902:780a:: with SMTP id
 p10mr11498934pll.54.1547141655294; 
 Thu, 10 Jan 2019 09:34:15 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 k15sm125977409pfb.147.2019.01.10.09.34.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 09:34:14 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8 v3] k3dma patches to add support for hi3660/HiKey960
Date: Thu, 10 Jan 2019 09:34:04 -0800
Message-Id: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_093416_810010_AA6F25CB 
X-CRM114-Status: GOOD (  13.37  )
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
  Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to
    hisi-dma-avail-chan

Li Yu (2):
  dma: k3dma: Delete axi_config
  dma: k3dma: Add support for hisi-dma-avail-chan

Youlin Wang (3):
  Documentation: bindings: k3dma: Extend the k3dma driver binding to
    support hisi-asp
  dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
  arm64: dts: hi3660: Add hisi asp dma device

 Documentation/devicetree/bindings/dma/k3dma.txt |  7 ++-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 20 ++++++++-
 drivers/dma/k3dma.c                             | 60 +++++++++++++++++++++----
 3 files changed, 76 insertions(+), 11 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
