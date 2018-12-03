Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C58C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7928D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WA6bpGvt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZQ7Gfyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7928D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K1MEglyEhgkBQsGMkQ7vZJlejk29y4Q42Uq589gS6+o=; b=WA6bpGvtx+re6U
	n0TWQ7lI9oGkeBGXYVj72INXABlzj1g7hgvLT7vbGdkJSH+xo7JKpjLk86+9PK5wD0cytTzHqkoEE
	3nMqcbHpxjcO14A6S+vOn/lajFcS6QRlgCX3wR6drC8nzRcjs8gt3BzUHz9YeSKzOmUuPd/vOfqof
	2Lao1AlVd8UEPxX4JF0rbDotmGgb7mNIPeOH4H7QPFXzW8r5zGypW7NbVUKPtYfVqacUXNd8/MkMO
	hvDlmid41nGMLznEo8hRtZYqh26JytAXxSiO9cAoTLvUdJzLcyZFBImrOE/6a1oHhJQtAVAFj6O3v
	8JmIS+vqzT9FwmvTJYrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnSQ-0007vw-PL; Mon, 03 Dec 2018 12:36:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnSO-0007sF-8d
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 12:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=avbKSFdciR6iqCsc4parxclQe93be93Zo/zusz7rmyU=; b=LZQ7GfyypSod6kg7Kh2SDYIgO
 dbDDrvi0cdJzH1yaLj81IgngAfbiaZdd0qnSqYeYK+hPfY4mrAEJnc37KNBwoLtT43gH02LA76OkP
 wggxh2cU7LuWq+X4FJLwXK9nY6lXgQm7QJoQ6TMharhsmCZjl3YfeZfw3WS2SvMBAz6oHGZohv+JL
 evQzVWpTVjn/lgzTeFqnVxTC3g9Qf9LICeFPlkAuNW2+7JzkEWHNRqDEt3v5CctQ1FVXMt1mqImtJ
 QtgWk5i8ei6q/nQwh/Hql8EuGM17TeOMwD9Okcdcaudx0bkTc1dfYzEo73K/IAIpJnwdu+yNH6hBY
 uBU0fSzZw==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnDW-0002hh-Oa
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:20:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 910E41688;
 Mon,  3 Dec 2018 04:20:39 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D72A3F614;
 Mon,  3 Dec 2018 04:20:37 -0800 (PST)
Date: Mon, 3 Dec 2018 12:20:34 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 0/3] PCIE support for i.MX8MQ
Message-ID: <20181203122034.GC8040@e107981-ln.cambridge.arm.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181117181225.10737-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_122050_958160_18B23578 
X-CRM114-Status: GOOD (  16.60  )
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
 linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 17, 2018 at 10:12:22AM -0800, Andrey Smirnov wrote:
> 
> Everyone:
> 
> This series contains changes I made in order to enable support of PCIE
> IP block on i.MX8MQ SoCs (full tree can be found at [github-v0]). This series
> is _very_ preliminary and by no means is ready for inclusion (it also
> has some unmet dependencies).  However is should be in OK enough shape
> to get some early feedback on, which is the intent of this submission.
> 
> Specifically, I'd like to get some feedback on whether newly
> introduced "fsl,iomux-gpr1x" and "fsl,gpr12-device-type" DT
> properties, added to handle differences between PCIE0 and PCIE1, is a
> good (acceptable) solution for the problem.
> 
> All other feedback is appreciated as well!
> 
> Thank you,
> Andrey Smirnov
> 
> [github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0
> 
> Andrey Smirnov (3):
>   PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
>   PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
>   PCI: imx: Add support for i.MX8MQ
> 
>  drivers/pci/controller/dwc/Kconfig    |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c | 119 +++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 4 deletions(-)

I am expecting you to post of v2 of this series, addressing review
comments so I will mark these patches with "Changes Requested", please
let me know if you have any objections.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
