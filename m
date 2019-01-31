Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9873BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:34:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE282087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h8jc2D3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE282087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/nD3DZ6lyeL8D7LN1uB7ZfMQS3Kehh6LEcgJ31eNps=; b=h8jc2D3vV/tRjD
	syYndOPrSRrm8Q3VzNmXSAiUaqdoh+wDm7oVKa5vKMxy/GMJoEg5znDB/2AoTeieMkXLQfwqgjgnV
	mbdhBaNHXCxFoZedSftxBvSLNPlTee0ymP+sj6nPMnI1qhxhuTlJXN4AgX8nRLZE5u4+QLcRMuDq5
	dwr9lBpZrQmL6zEVJkJ9YS3In+MN/EtYmHsetoNDAmNh/SxmAYqx2vEZ616yCSp2wwGhwe0gwsRUX
	78WY9VWt8pEPSRybYuF04ijniYfwYzfTQCFUdTKkDADJMbRtU2e3NdIJJ68Wa68ABd2ZryYr6Mg0j
	XYkwIkXgw3boc9tHfIiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBYU-0007KQ-9N; Thu, 31 Jan 2019 12:34:54 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBYR-0007Jz-6N; Thu, 31 Jan 2019 12:34:52 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpBXj-000441-H7; Thu, 31 Jan 2019 13:34:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Souptick Joarder <jrdr.linux@gmail.com>, hjc@rock-chips.com
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
Date: Thu, 31 Jan 2019 13:34:10 +0100
Message-ID: <1572595.mVW1PIlZyR@phil>
In-Reply-To: <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <1701923.z6LKAITQJA@phil>
 <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_043451_386355_8FE04E79 
X-CRM114-Status: GOOD (  21.14  )
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
Cc: Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net, Stephen Rothwell <sfr@canb.auug.org.au>,
 oleksandr_andrushchenko@epam.com, joro@8bytes.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-media@vger.kernel.org, pawel@osciak.com, Rik van Riel <riel@surriel.com>,
 iommu@lists.linux-foundation.org, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 vbabka@suse.cz, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xen.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Donnerstag, 31. Januar 2019, 13:31:52 CET schrieb Souptick Joarder:
> On Thu, Jan 31, 2019 at 5:37 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Am Donnerstag, 31. Januar 2019, 04:08:12 CET schrieb Souptick Joarder:
> > > Previouly drivers have their own way of mapping range of
> > > kernel pages/memory into user vma and this was done by
> > > invoking vm_insert_page() within a loop.
> > >
> > > As this pattern is common across different drivers, it can
> > > be generalized by creating new functions and use it across
> > > the drivers.
> > >
> > > vm_insert_range() is the API which could be used to mapped
> > > kernel memory/pages in drivers which has considered vm_pgoff
> > >
> > > vm_insert_range_buggy() is the API which could be used to map
> > > range of kernel memory/pages in drivers which has not considered
> > > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> > >
> > > We _could_ then at a later "fix" these drivers which are using
> > > vm_insert_range_buggy() to behave according to the normal vm_pgoff
> > > offsetting simply by removing the _buggy suffix on the function
> > > name and if that causes regressions, it gives us an easy way to revert.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > Suggested-by: Russell King <linux@armlinux.org.uk>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> >
> > hmm, I'm missing a changelog here between v1 and v2.
> > Nevertheless I managed to test v1 on Rockchip hardware
> > and display is still working, including talking to Lima via prime.
> >
> > So if there aren't any big changes for v2, on Rockchip
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Change log is available in [0/9].
> Patch [1/9] & [4/9] have no changes between v1 -> v2.

I never seem to get your cover-letters, so didn't see that, sorry.

But great that there weren't changes then :-)

Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
