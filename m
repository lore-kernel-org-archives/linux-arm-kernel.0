Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AFDC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8EB21928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s7xUJaHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8EB21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6mtdHEI3U712OJDcv1xLqVXJEeRNBzLZhmkOxOvZS1Y=; b=s7xUJaHe6LF1+S
	NE1jdEgdEdmwdGSaMuViLLUcceDjg6XOTkWarMb1FTWp2Lj7IEawEuxEpysmindxxxclInUJMFuBh
	s02/VmrfxBFIx4WGsqPH59FjgNqgvpO5yLzZ90XUJZaiqG/wHr6uD9hCYTsep9iHDlHU1rXkLi00U
	ueN47oC8QNgk4HWTG1YX9bwGTpZwf9wR/PWLozw8mcXNSpylXrd846J7YFvePfCrDbm69C44ChsDA
	2F7aTb3Ba4+uXQEWm18qETpdLSKCn8c0on9SjCSVb/VjuDlN1qu+ypWszzG0EjCOxVGH+84kFd75I
	NWN9WR5HNHM5KdrT4TYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKwJ-00081F-Kj; Thu, 14 Feb 2019 17:36:47 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKwG-00080n-7D
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:36:45 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id B62106FA8C; Thu, 14 Feb 2019 18:36:42 +0100 (CET)
Date: Thu, 14 Feb 2019 18:36:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
Message-ID: <20190214173642.GA2704@lst.de>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
 <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_093644_403646_C644BAF2 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 John David Anglin <dave.anglin@bell.net>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 05:27:41PM +0000, Robin Murphy wrote:
> Oh wow, that driver has possibly the most inventive way of passing a NULL 
> device to the DMA API that I've ever seen, and on arm64 it will certainly 
> have been failing since 4.2, but of course there's also no error checking 
> for anyone to notice...

I did take a brief look and didn't see how we got the NULL device
pointer, so it is well hidden for sure.

> This crash will be a fallout from 356da6d0cd (plus the subsequent fix in 
> 9ab91e7c5c51) that's otherwise missed Christoph's big cleanup. Obviously 
> the right thing to do is for someone to try to figure out the steaming pile 
> of mess in that driver, but if necessary I think the quick fix below should 
> probably suffice to mitigate the change in the short term.

The fix looks ok.  And for 5.2 I plan to explicitly reject all uses of
NULL device arguments in the DMA API.  I've sent patches out for all
the obviously problemetic drivers, and most of them got accepted by the
maintainers for the 5.1 merge window.

It seems like the mv_xor code is mostly unmaintained as far as I can
tell unfortunately.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
