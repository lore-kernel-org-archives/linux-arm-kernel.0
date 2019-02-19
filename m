Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81EDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53F32081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V38j6vuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53F32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4e+lut428rio60rprKtEuR0v5/H1hVEt0AsPOQJjVE=; b=V38j6vuS931OLL
	RnmQrqngAHb0fTy75Q/lHKn1lMU6WSAMz3FCZJLPs7VvaH74lsLdT7MBxAq08bhnppqns/Zc7vh8i
	3dZWVKETSRJDWt2L2jzvzCaafC4C2rgsAAXG414lTj5BPHHSMMTubk2ACH/0B1XTZU4yQy8/y5BDa
	+BVITCcpdy08Q9a2kfx3X/7BB60nbqnUkhFcx7iDoSufdkmRJwozcb5XFYxpCzvrGWkbp+8fhqDxg
	WCvYtWzKTC7uFvkIoBVBPPlXKFYpiruyxgiJAG9opBoU/WvLUvTvvnAS1Ed4U/NuJ3lVAco6Idvaf
	KDcImUp5+4FUNnK7zFGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6wW-0000EB-07; Tue, 19 Feb 2019 15:04:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6wG-0008RD-Uk; Tue, 19 Feb 2019 15:04:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2AFA78;
 Tue, 19 Feb 2019 07:04:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225AA3F690;
 Tue, 19 Feb 2019 07:04:00 -0800 (PST)
Date: Tue, 19 Feb 2019 15:03:53 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20190219150352.GA21833@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com>
 <1545034779.8528.8.camel@mhfsdcap03>
 <20181217143247.GK20725@google.com>
 <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
 <1545124764.25199.3.camel@mhfsdcap03>
 <20181220182043.GC183878@google.com>
 <1545651628.5634.57.camel@mhfsdcap03>
 <20190123154023.GA1157@e107981-ln.cambridge.arm.com>
 <1550559699.29794.2.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550559699.29794.2.camel@mhfsdcap03>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_070404_998990_CBA44F6E 
X-CRM114-Status: GOOD (  38.29  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>, honghui.zhang@mediatek.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 03:01:39PM +0800, Jianjun Wang wrote:
> On Wed, 2019-01-23 at 15:40 +0000, Lorenzo Pieralisi wrote:
> > On Mon, Dec 24, 2018 at 07:40:28PM +0800, Jianjun Wang wrote:
> > > On Thu, 2018-12-20 at 12:20 -0600, Bjorn Helgaas wrote:
> > > > On Tue, Dec 18, 2018 at 05:19:24PM +0800, Jianjun Wang wrote:
> > > > > On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> > > > > > On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > > > > > > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > > > > > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > > > > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > > > > > > The read value of BAR0 is 0xffff_ffff, it's size will be
> > > > > > > > > > calculated as 4GB in arm64 but bogus alignment values at
> > > > > > > > > > arm32, the pcie device and devices behind this bridge will
> > > > > > > > > > not be enabled. Fix it's BAR0 resource size to guarantee
> > > > > > > > > > the pcie devices will be enabled correctly.
> > > > > > > > > 
> > > > > > > > > So this is a hardware erratum?  Per spec, a memory BAR has
> > > > > > > > > bit 0 hardwired to 0, and an IO BAR has bit 1 hardwired to
> > > > > > > > > 0.
> > > > > > > > 
> > > > > > > > Yes, it only works properly on 64bit platform.
> > > > > > > 
> > > > > > > I don't understand.  BARs are supposed to work the same
> > > > > > > regardless of whether it's a 32- or 64-bit platform.  If this is
> > > > > > > a workaround for a hardware defect, please just say that
> > > > > > > explicitly.
> > > > > > 
> > > > > > I do not understand this either. First thing to do is to describe
> > > > > > the problem properly so that we can actually find a solution to
> > > > > > it.
> > > > > 
> > > > > This BAR0 is a 64-bit memory BAR, the HW default values for this BAR
> > > > > is 0xffff_ffff_0000_0000 and it could not be changed except by
> > > > > config write operation.
> > > > 
> > > > If you literally get 0xffff_ffff_0000_0000 when reading the BAR, that
> > > > is out of spec because the low-order 4 bits of a 64-bit memory BAR
> > > > cannot all be zero.
> > > > 
> > > > A 64-bit BAR consumes two DWORDS in config space.  For a 64-bit BAR0,
> > > > the DWORD at 0x10 contains the low-order bits, and the DWORD at 0x14
> > > > contains the upper 32 bits.  Bits 0-3 of the low-order DWORD (the
> > > > one at 0x10) are read-only, and in this case should contain the value
> > > > 0b1100 (0xc).  That means the range is prefetchable (bit 3 == 1) and
> > > > the BAR is 64 bits (bits 2:1 == 10).
> > > 
> > > Sorry, I have confused the HW default value and the read value of BAR
> > > size. The hardware default value is 0xffff_ffff_0000_000c, it's a 64-bit
> > > BAR with prefetchable range.
> > > 
> > > When we start to decoding the BAR, the read value of BAR0 at 0x10 is
> > > 0x0c, and the value at 0x14 is 0xffff_ffff, so the read value of BAR
> > > size is 0xffff_ffff_0000_0000, which will be decoded to 0xffff_ffff, and
> > > it will be set to the end value of BAR0 resource in the pci_dev.
> > > > 
> > > > > The calculated BAR size will be 0 in 32-bit platform since the
> > > > > phys_addr_t is a 32bit value in 32-bit platform.
> > > > 
> > > > Either (1) this is a hardware defect that feeds incorrect data to the
> > > > BAR size calculation, or (2) there's a problem in the BAR size
> > > > calculation code.  We need to figure out which one and work around or
> > > > fix it correctly.
> > > 
> > > The BAR size is calculated by the code (res->end - res->start + 1) is
> > > fine, I think it's a hardware defect because that we can not change the
> > > hardware default value or just disable it since we don't using it.
> > 
> > Apologies for the delay in getting back to this.
> > 
> > This looks like a kernel defect, not a HW defect.
> > 
> > I need some time to make up my mind on what the right fix for this
> > but it is most certainly not this patch.
> > 
> > Lorenzo
> 
> Hi Lorenzo,
> 
> Is there any better idea about this patch?

Hi,

I did not have time to investigate the issue in core code that triggers
this defect but this patch is not the solution to the problem it is a
plaster that papers over it, I won't merge it.

I would appreciate some help. If you could have a look at core code that
triggers the failure we can analyze what should be done to make it work,
I do not think it is a defect in your IP.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
