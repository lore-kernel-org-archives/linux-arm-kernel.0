Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F362C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071BE21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ho4cEkYv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kobNtMP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071BE21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QsIH3kAtuM2bu4L4QlfKQRofQU8AnE0h0USExZARmyU=; b=Ho4cEkYvX6PRI7
	HlZcqfiQE8HhjcXkEZ77TTMBIixmwhAa8vUVuqsuB5LtNULv3esCYP+SbhlJCNcD3MQMH2VlE/TnA
	mpdC3CntIbteU/Sz44LJnmFjeGwDLlYN8sV2AR8/LsK72LhUJh/KI1516JRlHfp/EX61+UJ39TkxL
	6lVz0TcLmzeQYcd5czCyibwjsFWzvZ/3r5ON1WzkHzpXY3JsnPB5R97CbeH9RH55RlUmQbiklt7St
	ZnFtxRDH0oqse0UDVDVLbOYSo4Xxe/OxgbUsHe84B2XMiYk+lUBZIYDnADR2PtHzKwDzwn6Q8qIxy
	/aJV2RaDgr2qnwiXlOPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouJP-0004dZ-SB; Wed, 30 Jan 2019 18:10:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouJM-00045z-Qf; Wed, 30 Jan 2019 18:10:10 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD98720869;
 Wed, 30 Jan 2019 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548871808;
 bh=EmZvF7H+0NygrHmdlDz0uULZfAPgJ3b1iTz8wkkFJ5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kobNtMP2vKsufH+UdkMFWtKPcG4I8u8Alcsc0gT169GbufQF/UBNjxPNxV1XSrcnB
 OzfFFD9q7pwtJq7mdYPGPGBoCYII84u9A9mUF8kWSz0Ucvg9/ESjiiKL2lbMAmU+qx
 7S+5VaLnaiPgqT9ZPBFp7Y/t1/DpkjKKm3kH6lRM=
Date: Wed, 30 Jan 2019 19:10:05 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130181005.GA15653@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130163817.GF21904@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130163817.GF21904@lunn.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_101008_893309_29DCC5E0 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Carlos Henrique Lima Melara <charlesmelara@outlook.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "neil@brown.name" <neil@brown.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 05:38:17PM +0100, Andrew Lunn wrote:
> On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> > 	This patch fix the checkpatch.p1 warning:
> > 
> > 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > 	+/*
> > 
> > 	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.
> > 
> > Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>
> > ---
> >  drivers/staging/mt7621-eth/ethtool.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> > index 40a7d47be913..49d417de64c8 100644
> > --- a/drivers/staging/mt7621-eth/ethtool.c
> > +++ b/drivers/staging/mt7621-eth/ethtool.c
> > @@ -1,15 +1,17 @@
> > -/*   This program is free software; you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; version 2 of the License
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Hi Carlos
> 
> drivers/staging/mt7621-eth$ grep LICENSE *
> gsw_mt7621.c:MODULE_LICENSE("GPL");
> mtk_eth_soc.c:MODULE_LICENSE("GPL");
> 
> And include/linux/module.h 
> says:
> 
> /*
>  * The following license idents are currently accepted as indicating free
>  * software modules
>  *
>  *      "GPL"                           [GNU Public License v2 or later]
>  *      "GPL v2"                        [GNU Public License v2]
> 
> So the SPDX string probably does not match the MODULE_LICENSE.

No, ignore the MODULE_LICENSE marking for this, go by what the text at
the top of the file says. See the patch about all of this from Thomas on
lkml yesterday for why this is the case.

So the patch is fine.  If the changelog stuff ever gets fixed...

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
