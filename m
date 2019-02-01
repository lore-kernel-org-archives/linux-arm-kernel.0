Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF22CC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDF42086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YcN3VQx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDF42086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MpPH8P4rw+ib+DJ6b2fRbe0ywcPFNzf+YlRRBgjsRRs=; b=YcN3VQx51SlD9w
	CTajuUPBlFJAbm4A8xUBNpoYUzzbX4IRKlRwOkF6TkkGIRlh6D6NH/BnAwZYXNRyiUWI3CHjhVyxj
	cn03H/whVlmCBxHwSb23bd25XJzH06aR1trQa5gownttGtXhkv9XwY4wuvKhh6ka3EjE5/38lJNVT
	VC8WLOIgHuEnquP3VeI+aDg19iqgNkadvm7KReAEzWEGlMbekC8G1lFbJ29fQnRpzgbA57inGMeUF
	r7pCHpeS+R4dp2KchpSExaMqlmIWJBNES2Y73xjfrG53+juLaetd0n5Dw9M0U1cMYqCVmGRS4KI06
	UN2M9wsnU/ML23Fnpv1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbfK-0003zY-KC; Fri, 01 Feb 2019 16:27:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbfH-0003zB-N7
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:27:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B706815BE;
 Fri,  1 Feb 2019 08:27:36 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80A203F71E;
 Fri,  1 Feb 2019 08:27:34 -0800 (PST)
Date: Fri, 1 Feb 2019 16:27:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
Message-ID: <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_082739_759071_F3689302 
X-CRM114-Status: GOOD (  17.38  )
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

On Fri, Jan 04, 2019 at 09:49:05AM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.

Side note: You should trim the CC list, eg I do not think CC LKML is
needed at all for this series.

@Lucas: May I ask you to consider please which patches you deem
worth for inclusion ? I will have a look too but I would be grateful
if the driver maintainers can chime in to help.

Thanks,
Lorenzo

> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Changes since [v1]:
> 
>   - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
>     already having been addressed by "PCI: imx6: Fix link training
>     status detection in link up check" from Trent Piepho
> 
>   - Changed "designware" -> "dwc" for all subject lines
> 
>   - Collected Acked-by's from Gustavo Pimentel
> 
> [v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (20):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Remove redundant debug tracing
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove duplicate macro definitions
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
>   PCI: dwc: Make use of IS_ALIGNED()
>   PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
>   PCI: dwc: imx6: Share PHY debug register definitions
>   PCI: dwc: Make use of BIT() in constant definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
>   PCI: imx6: Use common mask in imx6_pcie_reset_phy()
>   PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
>   PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
>   PCI: dwc: Make use of GENMASK/FIELD_PREP
>   PCI: dwc: Remove superfluous shifting in definitions
> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 139 +++++++-----------
>  .../pci/controller/dwc/pcie-designware-host.c |  61 +++-----
>  drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
>  drivers/pci/controller/dwc/pcie-designware.h  |  60 ++++----
>  4 files changed, 115 insertions(+), 163 deletions(-)
> 
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
