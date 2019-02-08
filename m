Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A000AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705E52085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cyE4m719"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705E52085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N7+vfzjl24TFw7SEy4MbfH2XZjD5PdMUVSQoweWU+RM=; b=cyE4m719gZG3cm
	focypjvKVpyFrDoyZ/NYkQ4okf+lvYlDix0KtALP7WnJNOFOhIcOu80RV6FDXvQfDfJrz9+T7MunV
	tG1Vc2aRtEjkjqJXQZt4XnX1+ZjTsl/qHdSddgYE9PNp+UJzbxdnsJJhf/5PvXw+i7Qelsu7qsos2
	qaT/+ONvqdX8WDEmyCi2B7L06XIHdT1eMGOIjXVYbgXu8aLupNXgsWMuRkLs7Q820ay0QD14bLtSe
	ZgHZZRK2Ca7PuXKZBFxDTABNtNKSqFMXJsRnhF1EvzSEor5j+fRgaKMr+R/gAIhDq6nUgEpA7GTPD
	Utbe706Rorq9faedFXAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Ee-0008RJ-4M; Fri, 08 Feb 2019 10:18:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Ea-0008QS-59
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:18:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D012B1596;
 Fri,  8 Feb 2019 02:18:09 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA1913F557;
 Fri,  8 Feb 2019 02:18:07 -0800 (PST)
Date: Fri, 8 Feb 2019 10:18:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Message-ID: <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-4-tpiepho@impinj.com>
 <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
 <1549563351.3075.49.camel@impinj.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549563351.3075.49.camel@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_021812_206472_2CDFF62C 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 06:15:52PM +0000, Trent Piepho wrote:
> On Thu, 2019-02-07 at 12:31 +0000, Lorenzo Pieralisi wrote:
> > +			/* De-assert DCC_FB_EN */
> > > +			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
> > > +			/* Assert RX_EQS and RX_EQS_SEL */
> > > +			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> > > +				| PCIE_PHY_CMN_REG24_RX_EQ,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
> > > +			/* Assert ATT_MODE */
> > > +			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> > > +			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
> > > +		} else {
> > > +			dev_warn(dev, "DT lacks imx7d-pcie-phy, unable to apply ERR010728 workaround\n");
> > 
> > It is a nit but the warning log is not necessarily true ie you may not
> > have a mapped address for other reasons as well. It is up to you but I
> > would change the log message.
> 
> True, but I hardly want to enumerate every possible failure point in a
> log message.  How about:
> 
> Unable to apply ERR010728 workaround.  DT lacks imx7d-pcie-phy?

I would just log "Unable to apply ERR010728 workaround" but it is up
to you. I can make the change myself with no need for reposting.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
