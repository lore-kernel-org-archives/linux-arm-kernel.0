Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:13:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6130A20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D4dTa8WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6130A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V2Wjb18jCuhikD+RW1rMWVM+KykertrjvsPl/EPKZ14=; b=D4dTa8WWcF4AQ+
	vqAxCz2WnV7zz5YgR4wvYRZ1zYG8eR1+3cVySdcEEKvPcMw+Jxekq4pIJR5kflJiHPP3YaPwj3GP9
	k0CookLnkxnIKoGxZzRRdjw+8uMQbH+uAga5Phj3OAgf4kBQT6STyYSejEKiaJFgcBEMBJCOLh7CZ
	DSl5QmJBQN1nBvPA/UIgNhYbz3DZmjbF3ZkjhtUYKfsdfCs+3MV0+ZEfvTrDu6+cyz/ycaOv29uy9
	6V8Bz/B7XqCdsvA+cPhn3oKGd+Nz/HqTNX9gwYOS8XSN3Nk23Q6TJdYJhLKmgLxFWuRl/MDZfUnZW
	dlXxd3pFU1PvkAzym9CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIsu-0003K2-JY; Mon, 25 Feb 2019 16:13:40 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIsq-0003JV-Kt; Mon, 25 Feb 2019 16:13:38 +0000
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8B73528092C;
 Mon, 25 Feb 2019 16:13:33 +0000 (GMT)
Date: Mon, 25 Feb 2019 17:13:30 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 20/27] mtd: nand: Let software ECC engines be
 retrieved from the NAND core
Message-ID: <20190225171322.654189c8@kernel.org>
In-Reply-To: <20190225164933.4b0e1489@xps13>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-8-miquel.raynal@bootlin.com>
 <20190222152957.737a8c5c@kernel.org>
 <20190225164933.4b0e1489@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_081336_950008_21682EBB 
X-CRM114-Status: GOOD (  26.14  )
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

On Mon, 25 Feb 2019 16:49:33 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <bbrezillon@kernel.org> wrote on Fri, 22 Feb 2019
> 15:29:57 +0100:
> 
> > On Thu, 21 Feb 2019 13:57:59 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Before making use of the ECC engines, we must retrieve them. Add the
> > > boilerplate for the ones already available: software engines (Hamming
> > > and BCH).
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/mtd/nand/ecc/engine.c              | 14 ++++++++++++++
> > >  include/linux/mtd/nand-sw-bch-engine.h     |  3 +++
> > >  include/linux/mtd/nand-sw-hamming-engine.h |  3 +++
> > >  include/linux/mtd/nand.h                   |  3 +++
> > >  4 files changed, 23 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/nand/ecc/engine.c b/drivers/mtd/nand/ecc/engine.c
> > > index 7dd3f9772698..318dbb2d56a2 100644
> > > --- a/drivers/mtd/nand/ecc/engine.c
> > > +++ b/drivers/mtd/nand/ecc/engine.c
> > > @@ -286,6 +286,20 @@ bool nand_ecc_correction_is_enough(struct nand_device *nand)
> > >  	return corr >= ds_corr && conf->strength >= reqs->strength;
> > >  }
> > >  
> > > +struct nand_ecc_engine *nand_ecc_sw_get_engine(struct nand_device *nand)    
> > 
> > What if you want to instantiate SW ECC with a custom layout? Can't we
> > instead have a function that create a new engine dynamically?
> > 
> > struct nand_ecc_engine *
> > nand_ecc_create_sw_engine(struct nand_device* nand,
> > 			  enum nand_ecc_algo algo,
> > 			  struct mtd_ooblayout *layout);
> > 
> >   
> 
> Right now, for both sw engines, a default layout is applied if there is
> none at engine initialization time.
> 
> Also, do we really need a "create" helper? I don't see what's created
> there. Maybe you had something else in mind, and the
> ecc_sw_xxx_get_engine() approach do not match what you expected, so
> please tell me more about your idea, otherwise I don't see what a
> nand_ecc_create_sw_engine() would bring.

The layout is part of the ECC engine properties, which I why I suggest
to create one engine instance per user and specify the layout to use
at instance creation time.

> 
> >   
> > > +{
> > > +	switch (nand->ecc.user_conf.algo) {    
> > 
> > Note that the conf is supposed to be passed afterwards, when the ctx is
> > created, so you should check nand->ecc.user_conf directly here.  
> 
> I think this is what I do so I suspect the above sentence is not what
> you actually meant?

Sorry, I meant "should not". My point is, the user_conf should only be
passed at context creation time, and should not be modified in-place by
the caller, unless proven necessary.

There's really 2 different steps that I think need to be isolated:

1/ retrieve/create an ECC engine instance (SW, HW-controller-side,
   on-die)
2/ ask this ECC engine instance to create a context out of a user conf

Your user_conf seems 2 mix the 2 concepts: the engine to use, the
strength/step-size you expect.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
