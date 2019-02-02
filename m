Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC23C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:31:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC78B20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kZAkt9ay";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhmfSMSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC78B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z/uActzYG4FLFzvSCE/2AMrK67wWmqexvp2Wts7xUe0=; b=kZAkt9ay+qpv0T
	mfNnNYF1/hngTnSCljyA0C/a/XV/94K8h3NDrOD2v74mmXTF1TAn9Nil2Md2bMZPwVS+bpxkKVi3B
	v31gfIUnuC6ndqe1IVhD6uA1EUmP9NGJgyf9Nmh4SxetkUZ0mZzNqkGeLaQG+WFKRrGzbYvpJePrf
	GTFEgLapePbe1QccGo73NYsTBYHnuPvVf0W44g/46PxZgQgy0kqJXL34w5nuF0fICvNBa7MEbF+e5
	lQ9r2u42mOGMPyIlDlx+zxns9AmSGWCyw+bUJ8bhbBVBtxXLjbPRDu0Ya4ksUPTqU5bwQQN8k125O
	GNZZkI0AT1SiRA5hLVEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvO3-000073-Ga; Sat, 02 Feb 2019 13:31:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvNy-0008WO-QP; Sat, 02 Feb 2019 13:31:09 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7188320869;
 Sat,  2 Feb 2019 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549114265;
 bh=1gY2hOeLHhSzQ5G894my2ziGlBHN6TYeMJr5fQWQMg4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GhmfSMSFU83ARO6wJmCvItpVnqdbGiZmxSzmVotq2qAG87o2Z8m/J5f2yvi8+C3Kz
 tqr6dkqHJ9JQd1Njq5XTNPBnAbGyQp2B4TWC0TSiB3vaNNpLaSj6oaol4i31hMcNuZ
 Ycar7kFJCA6WwkirF5nNUcEc7Mnzf0Iuxd7CC83U=
Date: Sat, 2 Feb 2019 14:30:54 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190202143054.4db7c465@bbrezillon>
In-Reply-To: <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-14-tudor.ambarus@microchip.com>
 <20190202082910.0e60a757@bbrezillon>
 <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_053106_986294_AA08633F 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2 Feb 2019 08:58:25 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >> @@ -117,6 +120,7 @@
> >>  #define QSPI_IFR_CRM                    BIT(14)
> >>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
> >>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> >> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > Maybe add a comment saying it's only available on SAM9X60 or prefix it
> > with SAM9X60.  
> 
> I'll add a comment. The macro name is more generic how it is now and can be used
> by future versions of the IP. Hypothetically speaking, if we rename it to
> QSPI_IFR_SAM9x60_TFSFR_READ and other sam9x will come out, then I'll have to
> rename this macro again, to make it more generic.	

Okay.


> >> +static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
> >> +			      const struct spi_mem_op *op,
> >> +			      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	void __iomem *base = aq->regs;
> >> +	int ret;
> >> +
> >> +	/* Set the QSPI controller in Serial Memory Mode */
> >> +	if (aq->smm != QSPI_MR_SMM) {
> >> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);  
> > 
> > 					    aq->reqs +
> > 
> > and you can get rid of base.  
> 
> I will wait your reasons on this, see 3/13

ad->regs is only dereferenced once in this function, so there's even
less reasons to add a local var. 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
