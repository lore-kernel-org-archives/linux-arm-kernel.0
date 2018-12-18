Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E30AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AB1217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XKSQ69Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AB1217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W0yNZazZqOPdBnUSRqH9xt6/6aVYnldwOCeaU7xH0YI=; b=XKSQ69Wl934zJt
	d0iSHDvyXHJbXSZvJqr756Qoew0bttpl6Z9rPSH7L1FarZEPzkO1CktOInh2RrUoEZACbzdhUrB6L
	orIGeWaC5popwHTO+oY6MF47PNwzBVTJ0V6UEwYj3AjdOBBUI7UhIfdeLUJVnkElaCE6JTMgkd8OF
	rp383EZ4Cal2Qyrj0mYAtmi63qEwrviP2O0Jp8bDXOHH0IJxdVOeJuO2YQTkmgoAy+I9NUVZEa/kx
	LlSGMafsqAOEFV/xCDCMG/f75pbduoTy5fk+AqCZh2oe0DmId2HiQX1gV0m7OX7TjaYOGD1tlcpBk
	4+KplTifHr2JXA470dzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBYL-0004wo-Nf; Tue, 18 Dec 2018 09:20:37 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBXZ-0002xC-Q8; Tue, 18 Dec 2018 09:19:53 +0000
X-UUID: 5f02a978f3734bb487b3de176a956c4f-20181218
X-UUID: 5f02a978f3734bb487b3de176a956c4f-20181218
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <jianjun.wang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1600722779; Tue, 18 Dec 2018 17:19:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 18 Dec 2018 17:19:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 17:19:25 +0800
Message-ID: <1545124764.25199.3.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 18 Dec 2018 17:19:24 +0800
In-Reply-To: <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <20181213145517.GB4701@google.com> <1545034779.8528.8.camel@mhfsdcap03>
 <20181217143247.GK20725@google.com>
 <20181217154645.GA24864@e107981-ln.cambridge.arm.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_011950_463239_3203B019 
X-CRM114-Status: GOOD (  18.43  )
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
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com, robh+dt@kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>, honghui.zhang@mediatek.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2018-12-17 at 15:46 +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 17, 2018 at 08:32:47AM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 17, 2018 at 04:19:39PM +0800, Jianjun Wang wrote:
> > > On Thu, 2018-12-13 at 08:55 -0600, Bjorn Helgaas wrote:
> > > > On Thu, Dec 06, 2018 at 09:09:13AM +0800, Jianjun Wang wrote:
> > > > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > > > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > > > guarantee the pcie devices will be enabled correctly.
> > > > 
> > > > So this is a hardware erratum?  Per spec, a memory BAR has bit 0 hardwired
> > > > to 0, and an IO BAR has bit 1 hardwired to 0.
> > > 
> > > Yes, it only works properly on 64bit platform.
> > 
> > I don't understand.  BARs are supposed to work the same regardless of
> > whether it's a 32- or 64-bit platform.  If this is a workaround for a
> > hardware defect, please just say that explicitly.
> 
> I do not understand this either. First thing to do is to describe the
> problem properly so that we can actually find a solution to it.
> 
> Lorenzo

This BAR0 is a 64-bit memory BAR, the HW default values for this BAR is
0xffff_ffff_0000_0000 and it could not be changed except by config write
operation.

The calculated BAR size will be 0 in 32-bit platform since the
phys_addr_t is a 32bit value in 32-bit platform.

Actually MediaTek's HW does not using this BAR0, just omit it when
assign resource is totally fine.

When assign the resource for each device, software will check the
resource alignment first, and the resource of length zero will be
regarded as a bogus alignment resource, it will be ignored and won't
claim a resource parent for it.

When drivers try to enable the PCIe devices, the software will enable
it's resources, but it will return an error number when found a
unclaimed resource, in that case, the flow of enable devices will be
interrupted and PCIe devices won't work properly.

Thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
