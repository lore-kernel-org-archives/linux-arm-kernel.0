Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA8AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:01:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9B62086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sGsm93bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9B62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9fcCDGXlaUnllLgWalJ8vwd2/RespXa/oKh1/PmBUUQ=; b=sGsm93bXLZbGog
	bjlkziZ8AQ7Y/VRhhOx4ZuQxbIKXFQpuRjHt+PISOzDUMcviwtoLEtUYVkPPr6xORr+T53/2L2xLD
	dkiJpE6SCEZrDDmGlYAr4FVE9WPB10iAVarKF2STUJsWzJ41e9A2XSz23C3FRyJVnTb9E5QfhQGhP
	3612ly8NAQvB6SGXesFrZIcAaS9+X5b1W3HpHr7hdkterrDy/A0Th1wDubwjD6iMjGC5GQyr9IFcB
	tcZfQLyXH8s/mur3Rx/ob0lknRQ6LwsPtYhCQFQVZEqMO2I1SEGtEdVwpB+uPhtbCDRXE9sz+NU/2
	KR7IjxV1s4Pc3LVpx3tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcBl-0005Oi-SP; Fri, 01 Feb 2019 17:01:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcBf-0005Nk-MU
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:01:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 173C215BE;
 Fri,  1 Feb 2019 09:01:07 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2BCE3F71E;
 Fri,  1 Feb 2019 09:01:04 -0800 (PST)
Date: Fri, 1 Feb 2019 17:01:01 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v6 0/4] PCIE support for i.MX8MQ
Message-ID: <20190201170101.GB22887@e107981-ln.cambridge.arm.com>
References: <20190124201522.8973-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190124201522.8973-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_090110_417299_C38B823E 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 12:15:18PM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains changes I made in order to enable support of PCIE
> IP block on i.MX8MQ SoCs.
> 
> Changes since [v5]:
> 
>  - Reformatted commit messages to adhere to
>    https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
> 
> Changes since [v4]:
> 
>  - Collected Reviewed-by from Lucas
> 
>  - Replaced ((ARM || ARM64) && COMPILE_TEST) with COMPILE_TEST as per
>    suggestion from Rob
> 
> Changes since [v3]:
> 
>  - Based on feedback from NXP, DIRECT_SPEED_CHANGE quirk was expanded
>    to cover both i.MX7 and i.MX8MQ
> 
>  - Code setting device type in GPR12 moved to a standalone function
> 
>  - Explicit "fsl,controller-id" binding was dropped, replaced by using
>    controller physical address to determine logical ID
> 
>  - Dropped Reviewed-by from Lucas for patch 4/4 due to the change
>    above (haven't heard explicit "yea" for it from him)
> 
> Changes since [v2], [fixes]:
> 
>  - Incorporated [patch] introducing drvdata
> 
>  - i.MX6 PHY operation gating converted to a single patch and to use a
>    dedicated flag instead of doing explicit variant check
> 
>  - Kconfig entry changed to use ARM64 && ARCH_MXC
> 
>  - Dropped FALLTHROUGH annotations
> 
> Changes since [v1]:
> 
>  - Driver changed to use single "fsl,controller-id" property to
>    distinguish between two intances of PCIE IP block
> 
>  - All code pertaining to L1SS was dropped to simplify the patch
> 
>  - Documented additions to DT bindings
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> [v4] https://lore.kernel.org/linux-arm-kernel/20190104165335.13205-1-andrew.smirnov@gmail.com
> [v3] https://lore.kernel.org/linux-arm-kernel/20181218040702.29231-1-andrew.smirnov@gmail.com
> [patch] https://patchwork.kernel.org/patch/10712261/
> [fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
> [v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
> [v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/
> 
> Andrey Smirnov (4):
>   PCI: imx6: Introduce drvdata
>   PCI: imx6: Mark PHY functions as i.MX6 specific
>   PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
>   PCI: imx6: Add support for i.MX8MQ
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   3 +-
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
>  3 files changed, 133 insertions(+), 24 deletions(-)

Can you rebase it on top of my pci/dwc branch please and repost it ?

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
