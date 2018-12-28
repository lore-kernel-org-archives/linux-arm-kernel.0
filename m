Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:18:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F422148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="klerozt5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="qe/aYiIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F422148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZgyYCerGvfMinu7fP3VwHs5Bh3bCGqIWFvgx/e6xbdc=; b=klerozt5Gq3DjM
	Tjbi4QAxs58FwQw4OGARhUDdsQnB6fGrWhnN7o2F61Zr9Id5po6U5XkQJf0i/GkF8Rdc0D/GtV50S
	1jwbK8SNyCdWvTxr63bVE9oLjbBIVK3P8cbM4bnUUtTZFShrYgnar6M84vthTS/A+DlCb0dsv9S3H
	dXPlAaFR9pk7BDUFgwemmZRQUNZ/rjsz8csNjXqEVSoiiFRqhPsd655jKFfN8lN7ouqVc52gWtEn0
	QRaEz+FnfAtQYPPALw2Gu9y3T42MRlf5NKNEaP5DwbsHTZNCQHB461Bw2m3L6d2f0NGsggvtNJn/s
	9hKD9Rv67swyRwCyEnHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcoH6-0005xj-4D; Fri, 28 Dec 2018 09:17:48 +0000
Received: from owa.iluvatar.ai ([103.91.158.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcoGz-0005wm-8O
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 09:17:45 +0000
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
 c=relaxed/relaxed; t=1545988648; h=from:subject:to:date:message-id;
 bh=bXPWMB1a1xv0OU1FHVN4kt0o4N8eWzBIjlSHmha7iBI=;
 b=qe/aYiImnHL5EX4sIlsI1R7c2llB/Kk7VioFQ7AmcWa4sYFeDXL1wWae4yjrLmaDhGXlieEH6o5
 d+a4J/7RvaqGegCaZxBXMFATQlAs8EvACfQGWPkdlZeHHQ8cRmRXKOK6H8FLh3h6vKvZglvBfbrNy
 ElwqJjcGo1C5lOJkrbo=
Received: from hsj-Precision-5520 (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 28 Dec 2018 17:17:28 +0800
Date: Fri, 28 Dec 2018 17:17:26 +0800
From: Huang Shijie <sjhuang@iluvatar.ai>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-ID: <20181228091726.GA22551@hsj-Precision-5520>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
 <20181228084834.GA8658@lst.de>
MIME-Version: 1.0
In-Reply-To: <20181228084834.GA8658@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_011741_740581_0666760F 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: sfr@canb.auug.org.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, shijie8@gmail.com, akpm@linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 09:48:34AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?  The old name certainly looks more sensible to me.
I submitted a patch to export the symbol, addr_in_gen_pool.
But most the exported symbols are named like gen_pool_*.

What about I add a macro in the header genalloc.h, such as:

#define addr_in_gen_pool 	gen_pool_has_addr

> 
> If we really want to change anything about this function I'd suggest
> to drop the size argument, as the address itself should describe the
> region good enough.

Maybe others need the @size argument. I am not sure if it is right to remove
the size argument...

Thanks
Huang Shijie

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
