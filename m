Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A1CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:24:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B44420818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdbSqHgF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXg0dW/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B44420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=03kcRUlgTPVVOw3oWxzldIdWkESgOiUZ8SIvNm+oMQg=; b=gdbSqHgFAAzi2U
	FgT14uedn4VWb9LgqiHWrtENeea+lkuRmy1VGIusVYF7snOh0b3QfnLpb4CCcQ/ImhVY0vHIuqg5Z
	ZVL5md//qamOvMUsaloOpEhr7lgR2NEEFi1h5wVHynnaKIk2ZMZvvWhwNNdLbZFfB/Ha90Sq3iva/
	Rsuz+SdBHgPJ3FOmOvAOl4t2OM/HWQB7/YKbr/jdEtPW89mdI2yX6Ym4N5JPIUF2lxzlHjCj65gGE
	XEeDQSfy37UlmzYHxGljFkGTO3GlxijBFokSqO61ZjGcp8OSuWjGYdBtRC6lb5+yelkdjrCFMZSBh
	MZCwcxZHiD1Q4/Bs34Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBkZ-0002IS-He; Fri, 22 Feb 2019 14:24:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBkW-0002I5-Gw; Fri, 22 Feb 2019 14:24:25 +0000
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0402A20657;
 Fri, 22 Feb 2019 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550845463;
 bh=wPSwlY0Ps3V8dUmNA/P2jxRwoYACAAks+vbcB1p3pZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jXg0dW/j/V1y+PQUw+e5jimpOGE8OQZJKvkIPUFB0ViKWRX7wF+rEIsQex3fW1KF9
 Pg8Jnw0jTJk5xC74ya1tgWhYtdmVmXcDMFQorb7oIT40ho0PehfUA1B5pG6FHMdw5O
 gzGktUZysNHVz2xygy6EPnmvw1v9UkkRSkyz8pHU=
Date: Fri, 22 Feb 2019 15:24:16 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 16/27] mtd: nand: ecc: Let the software BCH ECC
 engine be a module
Message-ID: <20190222152416.734a2818@kernel.org>
In-Reply-To: <20190221150224.7b01b553@xps13>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-4-miquel.raynal@bootlin.com>
 <CAHCN7xJhoEAjPchpp=-zEyyK1Ggzt24aQAX9ujfavdP329+ouw@mail.gmail.com>
 <20190221150224.7b01b553@xps13>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_062424_595610_8E46A1F0 
X-CRM114-Status: GOOD (  19.57  )
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
 Brian Norris <computersforpeace@gmail.com>, Adam Ford <aford173@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 15:02:24 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Adam,
> 
> Adam Ford <aford173@gmail.com> wrote on Thu, 21 Feb 2019 07:48:46 -0600:
> 
> > On Thu, Feb 21, 2019 at 6:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > >
> > > There is no reason to prevent the software BCH ECC engine
> > > implementation to be compiled as a module, so change the 'bool' into a
> > > 'tristate'.    
> > 
> > If you're booting from nand and need the BCH engine, it seems to me
> > like you'd need it to be compiled into the kernel because you'd have
> > to mount the filesystem before loading the module unless you have a
> > initramfs.  If you need the BCH engine to mount the filesystem, it
> > creates a dependency issue.  
> 
> That's true, I could mention this use case in the commit log. But the
> action of choosing to compile it as a module is done by the user, so I
> guess preventing any user to use it as a module is nonetheless too
> restrictive?

I agree.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
