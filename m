Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D760C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3161A20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gzcq6hwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xc5IEvFMTzRGOm98hS+bP4PRf05qH056J5a/Q2Fcl5I=; b=Gzcq6hwVwxDyOP
	3j2ijtM9zjsxTIcR7I2iVQfFE1mB9dUkwewsGQeNPlmCvHctnuVR/EsT1BmcH+BzZPYwR02G6TlMK
	QD6yrwKEKH+nFfuKf0MBtjQUrkYyXLIgOQcLdhRAaY2AAFNcq8jIUjZFbdV9I/EoKjv7DD+tv9QDf
	eWtGBsQFkCYhf6SDYRzph0F1yV5WRkPqse38PAwiu3iCA8tEO+nntj4AovTX0o6WaBayTG2ovB00O
	NBkdyN3fcrZUhVS0V0mB6xdXoAqwPoTI57p9PJ9YP8Du0+YvRYTa6ACPyO0efb8a4MMP9mwMiqPAu
	pCaGXWHDARJG8xoF25vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtOVK-00040L-P1; Tue, 12 Feb 2019 03:13:02 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtOVG-0003z3-Hp; Tue, 12 Feb 2019 03:13:00 +0000
X-UUID: b07a2f6026ea4f8f8f7c245f617d5a98-20190211
X-UUID: b07a2f6026ea4f8f8f7c245f617d5a98-20190211
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 629352478; Mon, 11 Feb 2019 19:12:48 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 19:12:47 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 12 Feb 2019 11:12:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 11:12:44 +0800
Message-ID: <1549941164.4980.64.camel@mhfsdcap03>
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 12 Feb 2019 11:12:44 +0800
In-Reply-To: <20190207195230.GJ7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
 <20190207151816.GI7268@google.com> <20190207195230.GJ7268@google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_191258_594751_E8CE3066 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com, poza@codeaurora.org,
 fred@fredlawl.com, linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-07 at 13:52 -0600, Bjorn Helgaas wrote:
> On Thu, Feb 07, 2019 at 09:18:16AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> > > change the class_mask values to make portdrv support this type bridge.
> > 
> > I assume you have a Root Port or Switch Port that supports subtractive
> > decode?  I'm trying to understand how such a device would work.
> > 
> > Out of curiosity, can you show the "lspci -vv" output for the device
> > and the downstream devices of interest?
> 
> Actually, since subtractive decode has to do with how the bridge
> interacts with its *peers*, what would be interesting is the host
> bridge window information from ACPI _CRS or DT and the lspci info for
> everything under that host bridge.
> 
> Assuming we're talking about a Root Port, I guess that would mean
> anything inside the host bridge windows but outside the positive
> decode windows (the normal PCI-PCI bridge apertures in the Root Ports)
> would be claimed by the subtractive decode Root Port?

Per my understanding, mediatek's Root Port does not claim anything, or
it's fine to assign no resource which is dedicated to this bridge. Those
information could be got through lspci output which is attached in the
last mail. All the resource it claimed is from the subordinate device,
bridge itself does not need any special resource.
> 
> I guess you would want this because this path ultimately leads to an
> ISA or similar bus where you don't know what resources the device
> actually consumes?
> 
I was not get to that far, I just want to start a discussion about this,
since spec does not forbidden subtractive bridge to support port
service.

Thanks.

> Bjorn



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
