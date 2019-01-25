Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D58C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68216218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITcn/7Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68216218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P0GCcn60V8RYYw9dIyvXVJiPbLDZXRMgtz/i8iSWCls=; b=ITcn/7CdXM1Jr2
	BmIOw9q4+diupKRCbgj6Du8q+b2f52AeBZC2307/s2auEHy8NSku91bSNvnFL6VOO5b9tfKlchNhJ
	l3Z3Wsg13Noc5w0qtcJWQnyG1Nd2KUFM9t3MkIyaHMKF7DguW+c8nIftdGgTm7Np8GI7O452PT0Za
	mNdTEY0S4aOKfsjIoNMhvLRSPIT3et4eC/7aoJsxDOhVH96crYFSxver1lA/GLaAYhLWDrXphgu3G
	MA6wALckUzI00upl86tFV6freZ1eZ3IPwDTMJRf2U9ZwXNmd4HvplTMZ+Qsk4YXo+UDqjiWVrPLTR
	fq96yqrJhez/Yiwlx2sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5lF-0001kf-Sr; Fri, 25 Jan 2019 17:59:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5lC-0001jr-1r
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:59:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE2DEBD;
 Fri, 25 Jan 2019 09:59:21 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E057F3F5AF;
 Fri, 25 Jan 2019 09:59:19 -0800 (PST)
Date: Fri, 25 Jan 2019 17:59:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 0/2] PCI: imx: imx6_pcie_attach_pd
Message-ID: <20190125175914.GA25128@e107981-ln.cambridge.arm.com>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1548110502.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_095922_109204_22832B53 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Lukas F . Hartmann" <lukas@mntmn.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:50:03PM +0000, Leonard Crestez wrote:
> This fixes pci probing on imx6qp as reported by Lukas Hartmann.
> 
> The second patch fixes a check that shouldn't actually fail.
> 
> Leonard Crestez (2):
>   PCI: imx: Fix probe failure without power domain
>   PCI: imx: Fix checking pd_pcie_phy device_link
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

I have applied them to pci/controller-fixes and Bjorn already
queued them for one of the upcoming -rc*.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
