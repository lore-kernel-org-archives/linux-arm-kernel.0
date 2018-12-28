Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:49:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4103A2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eT15HqNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4103A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ip8SffO2bJSmZxcPQt/YvSrluqI4QCvPV6PVMKbOrGM=; b=eT15HqNazSZ2h6
	H9aoQWAOopIKi82eqgoRTfaOQ+/4pzDtQr4682+ULUPW7h8/Z8mkn1Q8JBgaNxzvN6vksc9ENwRDr
	Ix4GnHokb9Yr1a3ukbA4NawRCUeU9JQYMzu44D6X1vXxtEbuyvHZ5FBBCdICyrG8wd5vD01D4KjoA
	0ftqYbzppymaxYKF08UL42/obSOYY1k9iROf5TGw4tVlZWKL8V5ZgFAPHgmnF3RZMJmAtSLsF7MFu
	rABSE7+No5Adi5LDGkn5MR9eg2OLeaBIhEkzyZMOS3zWBtYMtYn4cg/0W1YToBDggzKAWF7Slgc+f
	UThKk4EDNBWcI0dIA2YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcnpC-0004qg-Ay; Fri, 28 Dec 2018 08:48:58 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcnp7-0004pR-Uy
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 08:48:55 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C001468AFE; Fri, 28 Dec 2018 09:48:34 +0100 (CET)
Date: Fri, 28 Dec 2018 09:48:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Huang Shijie <sjhuang@iluvatar.ai>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-ID: <20181228084834.GA8658@lst.de>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228083950.20398-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_004854_149801_1A1A2005 
X-CRM114-Status: UNSURE (   6.90  )
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
Cc: sfr@canb.auug.org.au, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, shijie8@gmail.com, akpm@linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> Follow the kernel conventions, rename addr_in_gen_pool to
> gen_pool_has_addr.

Which convention?  The old name certainly looks more sensible to me.

If we really want to change anything about this function I'd suggest
to drop the size argument, as the address itself should describe the
region good enough.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
