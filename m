Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4374C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:00:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9772120834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSAVv0gw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lXt5tIOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9772120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J8XMa6q2FEuhtzbyKODEDtX7sm+gZBrAEDDLT4XKZlY=; b=hSAVv0gwQOGZrU
	bzmz5v4l2MGt/mJRQtm4tgNZ7vktVP4HwzPmGbyQKni+1WSz3y1ji7kOh9mx5+8Z/+L1H1s/+sQ6t
	sMOtkPdwcjZ81VH90kEaTYkr4+LUIN4sZ6Gcv1Zr40SIvEBwovhRqnWdoHr4dvnLuNFAOiKfqFA8o
	BAUWxcKCRcc7ZxXzV0kZD+uEjE5Q4f6uDwqUoI8rN0WP5TenOaKDoFCR7swjwCeWvBHAuPg0Lwtln
	0Tgydb5l0YI8RHVPgDgKO/EdHxuYBcdFVl84+yZwGXf7ghZJcnA0J4Fhf7ey+kEfyMWEsxeB15N2l
	dRB5BpCB8ofs/s+fC0+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo1L-0000VV-Or; Fri, 30 Nov 2018 19:00:11 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo1D-0007UH-NB
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A+hP/kWFL3F+0C9qjiWsucmvZtfGx78Cupc7DWWqQIA=; b=lXt5tIOspOHVOt36+udBUSV1C
 GOhvsfSFWxcA4ivOXXEP6EankcVZN2vybbjhGUssR7LWMTTBG0nX4X+c525PkgFpjKFEx9HgXPl+u
 MlU/9o2XYiEFrk5JSgvqId5jg6M9BMJ1fkdenqx8FrC0w7tz/UlldH5XpNahuLgNewC5M=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:46659)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSo0a-0001UZ-Sj; Fri, 30 Nov 2018 18:59:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSo0Y-0002BF-8e; Fri, 30 Nov 2018 18:59:22 +0000
Date: Fri, 30 Nov 2018 18:59:20 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
Message-ID: <20181130185920.GG30658@n2100.armlinux.org.uk>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_110003_770642_3E39FBDA 
X-CRM114-Status: GOOD (  21.06  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 xen-devel@lists.xenproject.org, Jon Mason <jdmason@kudzu.us>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 02:22:08PM +0100, Christoph Hellwig wrote:
> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess.  Both APIs directly return the dma_addr_t to be used for
> the DMA, with a magic error escape that is specific to the instance and
> checked by another method provided.  This has a few downsides:
> 
>  - the error check is easily forgotten and a __must_check marker doesn't
>    help as the value always is consumed anyway
>  - the error checking requires another indirect call, which have gotten
>    incredibly expensive
>  - a lot of code is wasted on implementing these methods
> 
> The historical reason for this is that people thought DMA mappings would
> not fail when the API was created, which sounds like a really bad
> assumption in retrospective, and then we tried to cram error handling
> onto it later on.
> 
> There basically are two variants:  the error code is 0 because the
> implementation will never return 0 as a valid DMA address, or the error
> code is all-F as the implementation won't ever return an address that
> high.  The old AMD GART is the only one not falling into these two camps
> as it picks sort of a relative zero relative to where it is mapped.
> 
> The 0 return doesn't work for direct mappings that have ram at address
> zero and a lot of IOMMUs that start allocating bus space from address
> zero, so we can't consolidate on that, but I think we can move everyone
> to all-Fs, which the patch here does.  The reason for that is that
> there is only one way to ever get this address: by doing a 1-byte long,
> 1-byte aligned mapping, but all our mappings are not only longer but
> generally aligned, and the mappings have to keep at least the basic
> alignment.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git dma-mapping-error.3

Hi Chris,

For patches 1, 3 and 23,

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
