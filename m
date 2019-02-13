Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CDA222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+ICIm2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CDA222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C+Dq8eeCjyl72f1FeQLK0PCMYRRBX3CGxrKtHQz0RQU=; b=C+ICIm2EEosohi
	FfgiouHvyBzTcGpmNlN8xkCNRt3t07Z9wCrjRNB7mTu/k7ElN9pP5acQybEf5JfQT+I+LW4fCyOsO
	zKNEV6q1moeLF9rLiOHCzXn9NOr9BbS9aSEqACffYpy0Q9KY4AQd4MuqD7W82XmAseC5Cu5MpdR3V
	PRFpSZYn+hX9VzmYqGrcVqA4nP54pV+VIc/FzPyI5z2mkVZ8jxfbYbrvZpoArB991MEQ9P8Dcu4t7
	UFhlZuhF7RG7BOMCeEEWCmuPS3FQi2DwYpHbq8EZsOYobcBR1ot2Rc/vyPju1tY6jrAYz/oBbJisZ
	PK+vVPqFeHxzY/O7nY5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtveh-0008R5-K6; Wed, 13 Feb 2019 14:36:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvee-0008QG-Kc; Wed, 13 Feb 2019 14:36:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD0380D;
 Wed, 13 Feb 2019 06:36:52 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73D603F557;
 Wed, 13 Feb 2019 06:36:49 -0800 (PST)
Date: Wed, 13 Feb 2019 14:36:46 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get
 EPC features
Message-ID: <20190213143646.GC25260@e107981-ln.cambridge.arm.com>
References: <20190107064148.10152-1-kishon@ti.com>
 <20190107064148.10152-12-kishon@ti.com>
 <20190212150718.GA28306@e107981-ln.cambridge.arm.com>
 <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d72cfdf-97a7-4aab-f746-d0e545431ea2@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063652_678601_1756F6F2 
X-CRM114-Status: GOOD (  21.79  )
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
Cc: Heiko Stuebner <heiko@sntech.de>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Alan Douglas <adouglas@cadence.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 07:08:18PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 12/02/19 8:37 PM, Lorenzo Pieralisi wrote:
> > On Mon, Jan 07, 2019 at 12:11:44PM +0530, Kishon Vijay Abraham I wrote:
> > 
> > [...]
> > 
> >>  static int pci_epf_test_bind(struct pci_epf *epf)
> >>  {
> >>  	int ret;
> >>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >>  	struct pci_epf_header *header = epf->header;
> >> +	const struct pci_epc_features *epc_features;
> >> +	enum pci_barno test_reg_bar = BAR_0;
> >>  	struct pci_epc *epc = epf->epc;
> >>  	struct device *dev = &epf->dev;
> >> +	bool linkup_notifier = false;
> >> +	bool msix_capable = false;
> >> +	bool msi_capable = true;
> >>  
> >>  	if (WARN_ON_ONCE(!epc))
> >>  		return -EINVAL;
> >>  
> >> -	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
> >> -		epf_test->linkup_notifier = false;
> >> -	else
> >> -		epf_test->linkup_notifier = true;
> >> -
> >> -	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
> >> +	epc_features = pci_epc_get_features(epc, epf->func_no);
> > 
> > I think it would work out better if struct pci_epc_features was
> > allocated in the caller (stack) and pci_epc_get_features() take a
> > pointer parameter to it rather than the callee and the callee would just
> > have to fill it out, this also removes data in the driver that is not
> > really useful.
> > 
> > Is there any other reason behind the current design choice ?
> 
> Some drivers are used by multiple platforms each with different features. In
> such cases it's cleaner to have separate epc_feature table for each platform.
> 
> I think the driver should maintain some sort of data to even populate
> pci_epc_features allocated by EP function driver.

You mean that every EP controller driver should keep a table of
pci_epc_features (instead of a single instance) to be matched using DT
compatible strings to detect the platform variations ?

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
