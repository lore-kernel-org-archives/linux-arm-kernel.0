Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:02:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22B6206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaDL2Grm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22B6206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Twc6grqtoL6767QE6kPa5DMZX3I/aKcemby5npZuCMs=; b=IaDL2Grmx5hQDh
	U7FMaevoAx8W41VzBTxtRxeB30XjhZtO35EX6/B+WlS2xghaxIFS6360jVZct9jUhlIDSSqX9xdpa
	+GIjfTTbeuzAhGJib7nPjcmYlMvlo7laJOGT265ArQsz1alxar5xvP+tzGW2dM+R1UeLJW45ratus
	/QTYKNUsI3OUPnJsBte4akTVqSgPJWmiha8nBKByt9k7+zSzHfv2PK7u8h06zaUsWXv0lnCBhexeZ
	NwMrb+UXD24rPVjJMxcW9yuE6BlAkOeco3r+DWd82omaBJyHzXHwNCRq+O2FKnFGX7KFzOFECk3Hf
	YDAC+S1DFIKIrXDo9RTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqey-0002zD-SX; Mon, 17 Dec 2018 11:02:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqer-0002v3-35
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:02:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F77DEBD;
 Mon, 17 Dec 2018 03:01:46 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC3E3F6A8;
 Mon, 17 Dec 2018 03:01:44 -0800 (PST)
Date: Mon, 17 Dec 2018 11:00:28 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
Message-ID: <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_030157_137230_98D3DA22 
X-CRM114-Status: GOOD (  12.37  )
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

On Sun, Dec 16, 2018 at 03:09:13PM -0800, Andrey Smirnov wrote:
> Lorenzo:
> 
> These are patches fixing things pointed out by Bjorn in [1] and [2] as
> well as something I noticed while giving pci/next branch a try (#endif
> placement). Hopefully this is at least somewhat helpful.
> 
> Thanks,
> Andrey Smirnov
> 
> [1] lkml.kernel.org/r/20181214203828.GD20725@google.com
> [2] lkml.kernel.org/r/20181214203042.GC20725@google.com
> 
> Andrey Smirnov (3):
>   PCI: imx6: Fixup Kconfig and #endif placement
>   PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
>     imx6_setup_phy_mpll()
>   PCI: imx6: Make fallthrough comments more consistent
> 
>  drivers/pci/controller/dwc/Kconfig    |  4 ++--
>  drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
>  2 files changed, 21 insertions(+), 12 deletions(-)

Andrey,

please follow-up Lucas' remarks and submit a self-consistent patchset
that I can apply on top of my pci/dwc branch (where I removed your
previously queued patches).

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
