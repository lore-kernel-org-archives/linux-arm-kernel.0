Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B644BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:06:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8860920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZkx/SNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8860920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dE1s+Hz+SYSkbrdxHCsK2BCLEVZJi7sL7b5eDh1/xBQ=; b=FZkx/SNo7caP2I
	Rvr9FRqS0mLSSEFbO0QMWnoBhnF5z6xHP3zSbAg5F/ndtGUTtZiRHpNJXJ/A/a+ZfqAdsjdWIkyMs
	iPhpEWF8q0W0ECKYkfislwQTnphENZd+ZcMQs10G0/JKXiseKv/ypLh0d3LGgB7C9MBMUmXMNhwx2
	fwy/TSqY10/t3vuV6SFj+rZRgv8xXhq2Kt0aO1P8HAzC5ecCw2pDi8a56pZ1SmAM79nsVzyIEQBQi
	JxNgJg3pmUOpFNtcVmqDcXWeQjm2Nfoj3F01h6snMHFeZT5kNG+FxdSpInaxGV4BHG5Be1G0+Pd4f
	oDFiVPb5K4yQsp/j9Zng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX0k-0000PW-Nq; Sat, 23 Feb 2019 13:06:34 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX0O-0008VV-41; Sat, 23 Feb 2019 13:06:26 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 013B1628106;
 Sat, 23 Feb 2019 14:06:10 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:06:09 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:06:09 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 06/15] mtd: rawnand: Prepare things to reuse the generic
 NAND layer
Thread-Topic: [PATCH 06/15] mtd: rawnand: Prepare things to reuse the generic
 NAND layer
Thread-Index: AQHUycZZT8RyaY+zGkm+Ybo283JtFKXtTMWA
Date: Sat, 23 Feb 2019 13:06:09 +0000
Message-ID: <ab5bdb96-68ac-3a7a-a37a-723b8d1147b2@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-7-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-7-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <B86392C11E6B7A4388DEB453B913DD80@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 013B1628106.A2928
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service
 Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
 dwmw2@infradead.org, juliensu@mxic.com.tw,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 marek.vasut@gmail.com, masonccyang@mxic.com.tw,
 miquel.raynal@bootlin.com, richard@nod.at,
 thomas.petazzoni@bootlin.com, tudor.ambarus@microchip.com,
 vigneshr@ti.com, yamada.masahiro@socionext.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050612_822356_8E74D9C7 
X-CRM114-Status: GOOD (  19.30  )
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
Cc: Vignesh R <vigneshr@ti.com>, Julien Su <juliensu@mxic.com.tw>, Masahiro
 Yamada <yamada.masahiro@socionext.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21.02.19 10:15, Miquel Raynal wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> The generic NAND layer provides abstraction of NAND devices no matter
> the bus that is used to communicate with the chip. Basing the raw NAND
> core on this generic layer should avoid duplication of common
> operations, like iterating over all pages/blocks for MTD IO/erase
> operations.
> 
> In order to re-use this layer, we must first inherit from nand_device
> and then initialize the nand_device struct appropriately. This patch
> is taking care of the former.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   include/linux/mtd/rawnand.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index c20ea012aab6..dfeedfe2f3e0 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -22,6 +22,7 @@
>   #include <linux/mtd/flashchip.h>
>   #include <linux/mtd/bbm.h>
>   #include <linux/mtd/jedec.h>
> +#include <linux/mtd/nand.h>
>   #include <linux/mtd/onfi.h>
>   #include <linux/of.h>
>   #include <linux/types.h>
> @@ -861,6 +862,7 @@ struct nand_operation {
>   int nand_op_parser_exec_op(struct nand_chip *chip,
>   			   const struct nand_op_parser *parser,
>   			   const struct nand_operation *op, bool check_only);
> +
>   /**
>    * struct nand_controller_ops - Controller operations
>    *
> @@ -973,7 +975,7 @@ struct nand_legacy {
>   
>   /**
>    * struct nand_chip - NAND Private Flash Chip Data
> - * @mtd:		MTD device registered to the MTD framework
> + * @base:		Inherit from the generic NAND device
>    * @legacy:		All legacy fields/hooks. If you develop a new driver,
>    *			don't even try to use any of these fields/hooks, and if
>    *			you're modifying an existing driver that is using those
> @@ -1050,7 +1052,7 @@ struct nand_legacy {
>    */
>   
>   struct nand_chip {
> -	struct mtd_info mtd;
> +	struct nand_device base;
>   
>   	struct nand_legacy legacy;
>   
> @@ -1115,12 +1117,12 @@ extern const struct mtd_ooblayout_ops nand_ooblayout_lp_ops;
>   
>   static inline struct nand_chip *mtd_to_nand(struct mtd_info *mtd)
>   {
> -	return container_of(mtd, struct nand_chip, mtd);
> +	return container_of(mtd, struct nand_chip, base.mtd);
>   }
>   
>   static inline struct mtd_info *nand_to_mtd(struct nand_chip *chip)
>   {
> -	return &chip->mtd;
> +	return &chip->base.mtd;
>   }
>   
>   static inline void *nand_get_controller_data(struct nand_chip *chip)
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
