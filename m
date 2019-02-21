Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C6320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJFbiWZl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjEMWwKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C6320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=453Q5AySwUZ0r8SNEl744T+kY2cW5vYR0jPmxGNReBU=; b=XJFbiWZlTAPlOj
	q9WTG9Yqr6eyX6tH5QW3DaR+n+yhy+6fDC33kQKAZ2uaAYE8VDrILD2sySSVgqnIUueDAk4HRZqVP
	gGx1Lw6CSXk07S2S/GhLqniALH99bdqSCx7PoqQvyWGWlCH6yUh6Zmdsow0Ula0Iv/gd2kbhEhGvQ
	kqjOkGZIi8hSsqRuiTd9t/+clU/1Lf3w+mKVJ+c45fZ7c2BxVpJJ3SiaScWapGlEczQPlmXM0k81T
	KAit8gubdG6Du1sYL93e4f03WWlClHGQhXecyi6vJlKi5wToeW3J322jwy9T/7j2ihK8k7m87zZwS
	ujlQ0sBATPu0tOGoEmdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwn9P-00065j-73; Thu, 21 Feb 2019 12:08:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwn9K-00064x-70; Thu, 21 Feb 2019 12:08:25 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 58EB720855;
 Thu, 21 Feb 2019 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550750901;
 bh=fpaFN2eK2DE98FA8SCXmmCYjNYjUVZWlfRrxsUVSUdU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NjEMWwKMawag2vuZ4XsYkLrWUF8tnjzh6jf6j5qspq2gZDuMJy7TOIZmA/xHGR0Mg
 RNMXbI/WqQCjucarzwNWB5Q4HTdqvUUqh61hDGX+FX57S+eCeGC13uBnPV/ot6Me41
 iWHb88gByPnR0zlITYWWfl9EdRiBkhKTt+LMVrM8=
Date: Thu, 21 Feb 2019 13:08:15 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Message-ID: <20190221130815.7bd550dd@kernel.org>
In-Reply-To: <20190221124628.3538ecb0@xps13>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-3-miquel.raynal@bootlin.com>
 <20190221115554.315fbd9b@kernel.org>
 <20190221120610.5abb49ae@xps13>
 <20190221121437.7c551bc5@kernel.org>
 <20190221124628.3538ecb0@xps13>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_040823_904836_CD52E7CA 
X-CRM114-Status: GOOD (  27.52  )
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

On Thu, 21 Feb 2019 12:46:28 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Boris,
> 
> Boris Brezillon <bbrezillon@kernel.org> wrote on Thu, 21 Feb 2019
> 12:14:37 +0100:
> 
> > On Thu, 21 Feb 2019 12:06:10 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Hi Boris,
> > > 
> > > Boris Brezillon <bbrezillon@kernel.org> wrote on Thu, 21 Feb 2019
> > > 11:55:54 +0100:
> > >     
> > > > On Thu, 21 Feb 2019 11:01:51 +0100
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >       
> > > > > Force the NAND core be compiled-in when using any kind of NAND.        
> > > > 
> > > > Why?      
> > > 
> > > Because all the logic that comes later in the series relies on this
> > > change. I need the NAND core to be compiled-in,    
> > 
> > Hm, not exactly compiled-in as it can still be selected as a module.  
> 
> Yes, do you think it is a problem?

Yes, it is, at least for the SPI NAND case (and soon the RAW NAND case
too) since you remove the select but don't add a depends on. If you
select NAND_CORE as a module and SPI_NAND compiled-in => BOOM!

> 
> >   
> > > as well the ECC engine
> > > core, as well as everything that is shared between raw NAND and
> > > SPI-NAND which I move in the NAND core.    
> > 
> > Yes, the core is required for SPI NAND and soon will be for RAW NAND,
> > but I still don't see the problem with the "select NAND_CORE" approach,
> > sorry.
> >   
> > >     
> > > >       
> > > > > 
> > > > > Also remove the redundant dependencies on MTD which is enforced by the
> > > > > game of the if/endif blocs.
> > > > > 
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  drivers/mtd/nand/Kconfig         | 12 ++++++++++--
> > > > >  drivers/mtd/nand/onenand/Kconfig |  1 -
> > > > >  drivers/mtd/nand/raw/Kconfig     |  1 -
> > > > >  drivers/mtd/nand/spi/Kconfig     |  1 -
> > > > >  4 files changed, 10 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > > > > index 495751ed3fd7..e8d26a715922 100644
> > > > > --- a/drivers/mtd/nand/Kconfig
> > > > > +++ b/drivers/mtd/nand/Kconfig
> > > > > @@ -1,6 +1,14 @@
> > > > > -config MTD_NAND_CORE
> > > > > -	tristate
> > > > > +menuconfig MTD_NAND_CORE
> > > > > +	tristate "NAND"        
> > > > 
> > > > Definitely not something we want to expose in menuconfig.      
> > > 
> > > I considered the NAND core as essential when using raw NAND and
> > > SPI-NAND.    
> > 
> > It is needed for SPI NAND, and will be for raw NAND for sure, but I
> > still see no reasons for turning it into a user-visible option.
> >   
> > > Hence, turning it into a menuconfig option make the whole
> > > NAND subsystem available (or not) and will appear in a different
> > > "menuconfig page", which really enhances the readability.    
> > 
> > That's a different thing, and I have no problem with adding an extra
> > level in the Kconfig hierarchy.  
> 
> Then why not using this symbol? I don't get why you are opposed.

Because, not only you're forcing onenand users to pull the nand core
code in, which is not needed until the conversion to the generic NAND
layer is done, but you're actually forcing that for all existing
defconfigs because of your "default y" approach. Also, I don't see
what's the benefit of letting users know about this intermediate
framework when all they care about is supporting a specific class of
devices.

> 
> So you would like a config NAND_CORE (invisible) and a visible
> menuconfig NAND? And all entries in the NAND menu selecting NAND_CORE?

Not all entries, just SPI NAND, and soon, raw NAND. And yes, I'd prefer
that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
