Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19F1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC172084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qgv2XCgF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y6Ymagic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC172084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UZokcdWIk+AKeuKvbDrQxlejihDMQPwLmBi9wqSOhzA=; b=Qgv2XCgFsGAZIF
	LUdg/JrcsH6XVx7b9E+QKUt5jmGJRr1FQcrwKngzb8pAberWTcmQu7uRMLVjxHOeK2nM6S3lhCPfB
	UWwP8FpLKyXRTGrGchP5V/x4YdOvNNzdDUThCmYfVWWdrUujx6wYA9l7Z/v51SlhsMUcPj0W2MsD4
	oaT0V3rnHGBAlsQOZ2eRnobDNWzOFKKT2O1N41YeRL1jFRYg9y7+LxI2Y5QcZ/Wic0TQxMXWHXo1V
	v3s5piP+Am1tHKc3KEvWCLZnOiVO373ntGm9DqxtmNQRt7A6s+7Wd0U8nucOCwZ2ao/M2JJjXr3Y9
	y9unBGG6wWF8YQKK/YWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoIk-0002IZ-N5; Thu, 21 Feb 2019 13:22:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoIh-0002I8-HX; Thu, 21 Feb 2019 13:22:09 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02ADF2084D;
 Thu, 21 Feb 2019 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550755327;
 bh=S48oQwiBxU8MWekSwFC8xQpJ1OQ1a+mkyrpNS2MBGhY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=y6YmagicjZxb0hsjVIBAsRwCrN097NXPJ2B+24KWJnSbAWphFqcnHh41EHxMmJBXY
 cTC0iu2WaMYeWru3qHJFKDin0aHfBBEUiS9L4LQH/AfoeilZ2oqu4xJ0kyxOSJdgty
 J055nuVGqv1JbG76+m64dOTXcU6uYL+ZFC4kRrjU=
Date: Thu, 21 Feb 2019 14:22:00 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 14/27] mtd: nand: ecc: Turn the software Hamming
 implementation generic
Message-ID: <20190221142200.01877314@kernel.org>
In-Reply-To: <20190221125806.28875-2-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-2-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_052207_591950_4DF1EA4D 
X-CRM114-Status: GOOD (  10.14  )
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

On Thu, 21 Feb 2019 13:57:53 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:


> -/*
> - * Detect and correct a 1 bit error for 256/512 byte block
> - */
> -int nand_correct_data(struct nand_chip *chip, u_char *dat, u_char *read_ecc,
> -		      u_char *calc_ecc);
> +int __ecc_sw_hamming_calculate(const unsigned char *buf,

Let's stop with these __ prefixes. Just prefix functions taking a
nand_device object with nand_ and leave others with the ecc_ prefix.

> +			       unsigned int step_size,
> +			       unsigned char *code, bool sm_order);
> +int ecc_sw_hamming_calculate(struct nand_device *nand,
> +			     const unsigned char *buf,
> +			     unsigned char *code);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
