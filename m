Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786BBC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481BA2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFhhJrDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481BA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OAjLAHP9hjyfp1m6wxX4is1ERBM40v7U8+mpAsccUe0=; b=hFhhJrDLQCAAya
	VJONDrFLlonPXedpumBuRMLoyp5aWLpMl37a7jwMOPnVWC+iZMJSVMviakRy9jxzbtviLf3pMi1aL
	j8BWGhoBv4RHQOeNLGmU5WYKH8VG23P8z/8X0HnUEfZsRi2/0yMD1VmQ+fJTmgSooRVHtixvaEvzD
	YtOkEntDjCtDTzzaNUVpfi+BwX5i9aYU51vvy7TrpYiVeB9fKLBbT5NnwbZXaxhL9OWG9XMHs+t1G
	4BAt+fB1kltT45L3bCIoxsw6/L3+rOG09osoUSeh/aU38zYfHlxzS8SJpq+q7NHdfhFzCVc3j1Gw1
	dZwm0V6Xe2a8ZF6zem8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5Yp-0005l7-6O; Mon, 14 Jan 2019 16:58:03 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Yl-0005kA-BE
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:58:01 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 9077968D93; Mon, 14 Jan 2019 17:57:55 +0100 (CET)
Date: Mon, 14 Jan 2019 17:57:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: remove block layer bounce buffering for MMC
Message-ID: <20190114165755.GA7456@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
 <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_085759_527228_F927B910 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mmc@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ben Dooks <ben-linux@fluff.org>,
 linux-omap@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 04:52:40PM +0000, Robin Murphy wrote:
> One general point for the kmap() conversions - it's not obvious (to me at 
> least) whether or how that would work for a segment where sg->length > 
> PAGE_SIZE. Or is there some cast-iron guarantee from the MMC mid-layer that 
> it will never let the block layer generate such things in the first place?

None of this will with such segments.  But yes, I guess the old case
could have worked as long as any physical contigous ranges are also
virtually contigous.  So we might have to throw in a page size segment
boundary here.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
