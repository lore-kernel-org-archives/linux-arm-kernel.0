Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF02C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E06D20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dIAw+3Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MPE/jGmuGsd/uouxkSc1E7IKXV+UCKNRwEyEDdRD13E=; b=dIAw+3VgqxjLdF
	AnRMk5nw4CDJA/Vn9gacmWtotNsVoKLAWsWBvgFWPPYH8GViDGB2Ce64Ok75s57Hz/0wCCQMWviO2
	50DPNad/nn5m+iEKEFA10n2CjzAShgHjSb0Gavykr3zgMamL9lC0B03EkCVJnX5j65Qu4d7gKzanm
	4S8sLrQ1KgOkrorRJ2dhmq267/QCR1rAUHCnL5YI/uVMEQyhFQda9SFM9Gvk7oxOq5V0ataRKA+dy
	jAV4w8LaFBwyIY813oFMu9mS+7VZ5XAvBWn/lFKOqktp6AEAtufa+R700bL1g5lBDAPn3mLxkJyVK
	ps5u/CJNpGaKoudc1BFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVERf-0001eO-P7; Fri, 07 Dec 2018 11:37:23 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVERc-0001cN-29
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:37:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAADDEBD;
 Fri,  7 Dec 2018 03:37:08 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C63A83F5AF;
 Fri,  7 Dec 2018 03:37:06 -0800 (PST)
Date: Fri, 7 Dec 2018 11:37:01 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 0/3] PCIE support for i.MX8MQ
Message-ID: <20181207113701.GA19058@e107981-ln.cambridge.arm.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181117181225.10737-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_033720_103585_04D75EDB 
X-CRM114-Status: GOOD (  14.63  )
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

Applied to pci/dwc for v4.21, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
