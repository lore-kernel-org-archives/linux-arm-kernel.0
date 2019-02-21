Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350232085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpAT38bf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSgsNRnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350232085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Rc2XxLZ651WKQ/ZWVlrKSBSayzGpDhGakrZ3Ka5X6c=; b=MpAT38bf6vw0T4
	rjvJG5MRHieNLkoTz6fcl1jINhEICK1d0VCr+trIDOqg8ZrenOXQ3X4XmAYM65INeHYAal3im6Gzp
	uOsIvrplsgY4a+5s8mJ8cyqVPvLFI2EDYpWRP6VRyuJzMPCbfW9jWvfgynoFBd0FSw0U4tBvr0A3B
	dqcuFZAKCcwzGVNAwG2REHhSLEWXopJuTk60rDyQJHgr1pJubU8aHOiON0fP6oje1OElh3svsA9Uy
	Vm216cY9mFjx9oo1BqT7IUft6qgQJrR+v/g9zqbC5HqjARDNH31GcKOLZkVbtbdl/f3z8Azi3d9YZ
	du36xiEwZ9QN4ALzWrUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnRQ-0007DG-NG; Thu, 21 Feb 2019 12:27:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnRN-0007Ck-Qw; Thu, 21 Feb 2019 12:27:03 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8A01D2084D;
 Thu, 21 Feb 2019 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550752018;
 bh=0YmgBMjAQgXw9KocFUc9+ofp1hmuW9dvRiM2KjPL9KE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jSgsNRnmTQjUNrtp12aowPtfbqpDmhZK09mHYWiFvSEhqP4iuAfzIXtalCpNP8g91
 j7M584dPAEUqu6JXdbN1DVNsFSSeR8+brbir5P+tdeat9eSn1Y5O9Q3uR9TxQ30tIl
 rETHDN6tIPSXTtuNexNlD1t5ADdQbtBAMMbxEOr8=
Date: Thu, 21 Feb 2019 13:26:52 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 09/27] mtd: nand: ecc: Turn the software BCH
 implementation generic
Message-ID: <20190221132652.417f0c5d@kernel.org>
In-Reply-To: <20190221100216.25255-10-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-10-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042701_891368_6D6324DC 
X-CRM114-Status: GOOD (  12.48  )
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

On Thu, 21 Feb 2019 11:01:58 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:


>  /**
> - * nand_bch_correct_data - [NAND Interface] Detect and correct bit error(s)
> - * @chip:	NAND chip object
> - * @buf:	raw data read from the chip
> - * @read_ecc:	ECC from the chip
> - * @calc_ecc:	the ECC calculated from raw data
> + * ecc_sw_bch_correct - Detect, correct and report bit error(s)
>   *
> - * Detect and correct bit errors for a data byte block
> + * @nand: NAND device
> + * @buf: Raw data read from the chip
> + * @read_ecc: ECC bytes from the chip
> + * @calc_ecc: ECC calculated from the raw data
> + *
> + * Detect and correct bit errors for a data block.
>   */
> -int nand_bch_correct_data(struct nand_chip *chip, unsigned char *buf,
> -			  unsigned char *read_ecc, unsigned char *calc_ecc)
> +int ecc_sw_bch_correct(struct nand_device *nand, unsigned char *buf,
> +		       unsigned char *read_ecc, unsigned char *calc_ecc)

I'd keep the nand_ prefix, as ECC is employed in other places in the
kernel and here the API is clearly tied to the nand_device object.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
