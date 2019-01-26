Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA1C282C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:52:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5B5218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+pVCIiU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6+IFAvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5B5218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WgVnP5K13jOOLwxmKCo2dNWjA9Szlbzdsd++mOCFAOE=; b=f+pVCIiUOuGNtv
	H2uqKmkGVjyejMlnRDwGT2frcfwsQwU/qW9MdvrMyc5b6KHROm04xRO5K4CbHNIqafwDmeV14RHZR
	HXVO6AWfETxcTrEi94aTdmSBpwDyMeWkW/UiRtFY1y1AqWUpFQHGltxbBGqbfcCkUWv6u1wO2jjrX
	hPCcPO1nK1/KXBjR+2tneXp/7uEFTENvYyBXnvz1xEJVjDjkDxRY6LTWi8hxJoarYgQ+NV6subtGW
	zulb7XEV3kuoZ75V7nAzknxfEHze27BCM4G01y7p6bULepitF12yrp9nRuRUgtiwJqcSjigC4BVhR
	0/7nhdY0nmZVtIptUiuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnKdW-00007c-Oy; Sat, 26 Jan 2019 09:52:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnKdU-00006k-2i; Sat, 26 Jan 2019 09:52:25 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7AB6214C6;
 Sat, 26 Jan 2019 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548496341;
 bh=NvJwRTne2XBLYpaa43t+2CusW49FJOtCICODfrZ8D+k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=J6+IFAvHadi5Fi32frk9X7fK1WAk40QgNpSHA0k9lP4yAwtg+q75FN/2WBsMTmjWb
 i8zrnYxIiyCA89WyCGeQAdyq5ve9VJeRVOLZO5vmuDH8id2dV5IZiRpv0vXbPPiQXC
 xqPXfIhWlalcWpADrK3nL+ua4wFYWKRa9o8afNpg=
Date: Sat, 26 Jan 2019 10:52:08 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190126105208.221a2051@bbrezillon>
In-Reply-To: <20190125210950.GA27855@embeddedor>
References: <20190125210950.GA27855@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_015224_137581_48671CB4 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Kees Cook <keescook@chromium.org>, Wan ZongShun <mcuos.com@gmail.com>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 15:09:50 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> index 933d1a629c51..d33e15dc4cdc 100644
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2251,9 +2251,10 @@ static int __init ns_init_module(void)
>  
>  	switch (bbt) {
>  	case 2:
> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +		/* fall through */
>  	case 1:
> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> +		chip->bbt_options |= NAND_BBT_USE_FLASH;

You miss a '/* fall through */' here.

>  	case 0:
>  		break;
>  	default:

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
