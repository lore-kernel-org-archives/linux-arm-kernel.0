Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B396C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:55:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C308520C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAqQ+ySB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C308520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m93USAUwDjrr0CKrVQnENAWUCyA1ChHTcvjgdpFToso=; b=SAqQ+ySBJpP4U8
	Pp6MOsCPfGky/Iqk13N4JgCvuphAEhrTiY3k17Jtxdve/Kwd64iBPCWFWHvcs8UazIgI0mzD0A47W
	aY447ZsU3KQRiEexEobvaf7qA2IouZDSG/FmiDthE4sYZd8qCzI9HXRNJXnNrJqaf27Vgl6LujtNG
	gM0UI3BxNBw5lxxBTXcB+30W3j5sm8WgAD2rn6mzkaUGwmhG7h/sJaXBbkdk/mr5Jcr2Aw/pBfOUL
	UrYMTQD0C563OeCVrRJTy3hdlxW+QnIA4Pvgf2I+/MFOuCXGhkZc2dxCYm61P2EFuR1lOLp0dcLOQ
	yp+kHWpqh5x1ICqCevew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyf4X-0005n9-93; Tue, 26 Feb 2019 15:55:09 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf4S-0004aL-D0; Tue, 26 Feb 2019 15:55:07 +0000
X-Originating-IP: 90.88.147.150
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A503FC0005;
 Tue, 26 Feb 2019 15:54:43 +0000 (UTC)
Date: Tue, 26 Feb 2019 16:54:42 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC PATCH 20/27] mtd: nand: Let software ECC engines be
 retrieved from the NAND core
Message-ID: <20190226165442.7ca9415d@xps13>
In-Reply-To: <20190225171322.654189c8@kernel.org>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-8-miquel.raynal@bootlin.com>
 <20190222152957.737a8c5c@kernel.org>
 <20190225164933.4b0e1489@xps13>
 <20190225171322.654189c8@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_075504_597674_0F4AA194 
X-CRM114-Status: GOOD (  16.79  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 25 Feb
2019 17:13:30 +0100:

> > > > +{
> > > > +	switch (nand->ecc.user_conf.algo) {      
> > > 
> > > Note that the conf is supposed to be passed afterwards, when the ctx is
> > > created, so you should check nand->ecc.user_conf directly here.    
> > 
> > I think this is what I do so I suspect the above sentence is not what
> > you actually meant?  
> 
> Sorry, I meant "should not". My point is, the user_conf should only be
> passed at context creation time, and should not be modified in-place by
> the caller, unless proven necessary.
> 
> There's really 2 different steps that I think need to be isolated:
> 
> 1/ retrieve/create an ECC engine instance (SW, HW-controller-side,
>    on-die)
> 2/ ask this ECC engine instance to create a context out of a user conf
> 
> Your user_conf seems 2 mix the 2 concepts: the engine to use, the
> strength/step-size you expect.

No, I am not mixing things: the user might want a specific engine and a
strength/step-size. All of this is what the user requests.

In the ECC logic, I need to make a choice: I really need to check
what the user request is in order to choose the provider. I am not
changing anything here, just reading.

Later the chosen ECC engine will be prompted to create a context with
the rest of the user configuration.

I don't think it is relevant here to split this structure.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
