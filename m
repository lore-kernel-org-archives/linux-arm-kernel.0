Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F47C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8776721473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pj7abSFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s3KkIZkYkPgi/PGsQ2NxaTsblcHnDiZzxOXTjWehIdo=; b=pj7abSFhLfcyca
	J0FKTfo2E+CdgW0rxcZ9g+5MiJHRygOWu88KSY+2d61wMi8AeBQlpXnGElhSF+daYvn2U0kr1flPa
	lg83LasENwaZtGrymYOiCU9qXvl2pU8cS+rZqHmWSHM9QZLNjO7HR5QEzujHMYp8moDI7WfOrIFbE
	2XCAulmJXH+Sq35HKv/pkSoVihzrQf2KFa/UIm5sKM2r3nVuBH/OWw8NjsBLwKVXU8DVVmI37/ANx
	YCzEWI8ENMoOeID8cZ5iG7Y32Nk0W5XBxcNGSCQKbVAbo9K7rtg/VInTjoWar6iklDMaHBB4kB3aj
	sz8mNrXyCGkiDUgmaTjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gokrJ-0004KZ-GO; Wed, 30 Jan 2019 08:04:33 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gokrG-0004JV-24
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:04:31 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 4A33868CEC; Wed, 30 Jan 2019 09:04:23 +0100 (CET)
Date: Wed, 30 Jan 2019 09:04:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Message-ID: <20190130080423.GA29937@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
 <20190114095804.27978-6-hch@lst.de>
 <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_000430_262174_24F5A3AF 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ben Dooks <ben-linux@fluff.org>, linux-omap <linux-omap@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 08:57:47AM +0100, Ulf Hansson wrote:
> On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Instead of setting up a kernel pointer to track the current PIO address,
> > track the offset in the current page, and do an atomic kmap for the page
> > while doing the actual PIO operations.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nitpick: This one have some trailing whitespace errors, which git
> complains about when I apply it.
> 
> No need to re-spin due to this, I can fix it  up.

I'll need to respin to limit the segment size to a page anyway, so I
will take this into account as well for v2.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
