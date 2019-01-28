Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AEC282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F072177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TIvnASw3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zzNW7Z4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F072177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l1GiOUp14G3HslosFMuX95aq9LLq31ztaGdKEi7nE7A=; b=TIvnASw3u8WUWQs4gZIm/87hG
	/b+2wtHroRGt6A600sVBjVzNOdZARBfyFUbXfPhcMIFXpqoz0VhPmqKcKcE8hMdrjb8fqVSzQS0ep
	OEjz9x0J9AcLYESm+xvhXXMTsSiXQejp7GN7yQoZWIn97Qi1HA3QhM/TeEwwRYF0hVniHPd0JNU+7
	n9sqBt6d1Au6Jsz7TaXlXaBXbw/KgrlQS7tWMbrXU2OHyrNkIkeBlAIWvMN+Ao8hjzHuFv/luaBhs
	8MCQbkS8knRUs6XtPl04+TG6pm1kqNHXSM83rYm1DjAvehH90jFK/4fGa520deLkExjxqhzacDPjX
	2lv0w3A+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goFa5-0004wP-Bv; Mon, 28 Jan 2019 22:40:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goFa1-0004vz-Ff
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 22:40:38 +0000
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 209A92148E;
 Mon, 28 Jan 2019 22:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548715236;
 bh=tbzSxD0+xFSM1ishrWAIPPJwZeIV502YIUzNV+Sd0uc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=zzNW7Z4LR3ETzKrCTkVsT/OzrEOvNfZkXJeSaqXHB5jZnzvdsqT4Rwrs/k1y8fQwF
 7EQhRMf1ZbiFejPninoNPC3WzMAUpu/7gzvInJVIrFP2bI4Pgn45O7bgF+TqbGQ5KB
 0BqhdD68RW7CzO7wsKJaGW/s7ZDpXYe6JtRYX+FE=
Date: Mon, 28 Jan 2019 14:40:35 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
In-Reply-To: <d386f867-715f-0667-93bf-b42d728f546a@oracle.com>
Message-ID: <alpine.DEB.2.10.1901281440010.17936@sstabellini-ThinkPad-X260>
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
 <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
 <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
 <cd855c41-dca0-14dc-6703-886feccd34ea@gmail.com>
 <d386f867-715f-0667-93bf-b42d728f546a@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-120884440-1548715237=:17936"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_144037_542388_B12FE39E 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Oleksandr Andrushchenko <andr2000@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Souptick Joarder <jrdr.linux@gmail.com>,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>, xen-devel@lists.xenproject.org,
 linux-arm-kernel@lists.infradead.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-120884440-1548715237=:17936
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 28 Jan 2019, Boris Ostrovsky wrote:
> On 1/28/19 3:29 AM, Oleksandr Andrushchenko wrote:
> > +Boris and Juergen who can also help getting it in
> 
> I can put this in but I'd like to have Stefano's ack, this being ARM.

The patch is OK. Sorry for not replying earlier, this thread fell off my
radar somehow.

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> >
> > On 1/28/19 8:34 AM, Souptick Joarder wrote:
> >> On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
> >> <andr2000@gmail.com> wrote:
> >>> On 1/7/19 7:37 PM, Souptick Joarder wrote:
> >>>> Remove duplicate header which is included twice.
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >> Can we get this patch in queue for 5.1 ?
> >>>> ---
> >>>>    arch/arm/xen/mm.c | 1 -
> >>>>    1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> >>>> index cb44aa2..e1d44b9 100644
> >>>> --- a/arch/arm/xen/mm.c
> >>>> +++ b/arch/arm/xen/mm.c
> >>>> @@ -7,7 +7,6 @@
> >>>>    #include <linux/of_address.h>
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/types.h>
> >>>> -#include <linux/dma-mapping.h>
> >>>>    #include <linux/vmalloc.h>
> >>>>    #include <linux/swiotlb.h>
> >>>>
> >
> 
--8323329-120884440-1548715237=:17936
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--8323329-120884440-1548715237=:17936--

