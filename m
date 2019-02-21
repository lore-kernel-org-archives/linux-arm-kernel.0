Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B641C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:20:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B4A2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FzngbGtI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwNVqKJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B4A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8evwajPbnvNBnA46+sP4dQUNKUV83KHHUKkXJWXCgw=; b=FzngbGtIaDIgpp
	Pu/tqS2UJ33BDhSsrzlEWJ/FXPRycnsaI1B+2iLQLefmWvNAbUy9Wle79E8ZL92EWwqidL+ccmi1Z
	FfecGNUHJC8oos5fOfjYj02++IYYjJge4A5nHzxE6ygfWaUhFqtJwEmAMZb1rXpKNXLtO3rNp/QTM
	K2Hb9ahMDkWEC5w/H4135PLYSddjP1xZ02t/lglXMS9tHAtF6rw1eXWdkYbAUsynOWpbrgd2hOCfg
	a7z3vbNkawbm+ewOE7HBdL4GD/tJJtnB7bOOV+YzRMKHP3cqrnRxW3rwSmHPBPsGmkaPAjAfzYpt9
	krxTdyhp1HsS5wW7zVOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoGt-0001lL-T2; Thu, 21 Feb 2019 13:20:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoGn-0001hS-1J; Thu, 21 Feb 2019 13:20:14 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D0D6F2084D;
 Thu, 21 Feb 2019 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550755208;
 bh=GG7QF0wsArjZndGSLuqz5xT5ggYt/M0dUteRbZmwa2w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VwNVqKJhVZjISx2nwKK7McXAn5uAg1CjLOkMJlcvY91Xbvx1A514IETT/8xDyVMn+
 bJECyi3xRWojIS2YshJL/dx+0NcbDjiivsWBvuNGmfLjIP6iJKJQ1LYC+rvr4e7tGP
 sbO1jptwPkaSMsUObJfK7p716OMF1+twy1pLqMkA=
Date: Thu, 21 Feb 2019 14:20:02 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 17/27] mtd: nand: ecc: Let the software Hamming ECC
 engine be unselected
Message-ID: <20190221142002.5a160f87@kernel.org>
In-Reply-To: <20190221125806.28875-5-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-5-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_052009_098349_67630C96 
X-CRM114-Status: GOOD (  18.45  )
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

On Thu, 21 Feb 2019 13:57:56 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> There is no reason to always embed the software Hamming ECC engine
> implementation. By default it is, but we can let the user decide.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/ecc/Kconfig               | 10 +++++-
>  drivers/mtd/nand/raw/Kconfig               |  2 +-
>  include/linux/mtd/nand-sw-hamming-engine.h | 38 ++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ecc/Kconfig b/drivers/mtd/nand/ecc/Kconfig
> index e0106b3a7ec1..ff20e621ffef 100644
> --- a/drivers/mtd/nand/ecc/Kconfig
> +++ b/drivers/mtd/nand/ecc/Kconfig
> @@ -1,7 +1,15 @@
>  menu "ECC engine support"
>  
>  config MTD_NAND_ECC_SW_HAMMING
> -	tristate
> +	tristate "Software Hamming ECC engine"
> +	default y

Same as for the NAND_CORE stuff, let users this option when they need
it instead of having a "default y". Haven't made my mind yet on whether
this option should be visible to users or not. I guess it could be with
the new infrastructure, but it's probably too early in the patch series
to change that.

> +	help
> +	  This enables support for software Hamming error
> +	  correction. This correction can correct up to 1 bit error
> +	  per chunk and detect up to 2 bit errors. While it used to be
> +	  widely used with old parts, newer NAND chips usually require
> +	  more strength correction and in this case BCH or RS will be
> +	  preferred.
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
