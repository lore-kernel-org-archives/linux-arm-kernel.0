Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:28:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411EB2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ODZp3/T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411EB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BSvgzTNZxBPIG5AHO1j/7vgoSSnlgkwyrlSn46V7De8=; b=ODZp3/T2siWxDD
	JlBqByoSG6BVaBps2KRkpkZmxRChmKmmg974g4LcfiPvWAT9AAe1qrKCENgamM6pFxvRqkU8Ee3dG
	PEFQFsKosT2nNdjgaTqeRwbbfR4PoH9J81GOIgJ18jcqvzuuchmrk/MncfxwIUHZ9zPo0V4UG5SZF
	f2zP3xA6SyMJbjKbkSJ9vEGDKgpIUsV7O1PqX5Uu82CutHeXBT4Ibzd1gfR/KQq0e04HwnAsEp4EA
	XhB/VTgpOKCzRlDhoGape+85KcaK1HzTHezsIfCDODnkFQSOWeia5Lqdm60Rxo9iv5oUZSyADfAdm
	eBTLaPr0SGibVU7uusRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJjp-0004KJ-Ai; Mon, 10 Dec 2018 11:28:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJji-00041m-A5; Mon, 10 Dec 2018 11:28:34 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1608A2079D; Mon, 10 Dec 2018 12:28:19 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id CA4232037D;
 Mon, 10 Dec 2018 12:28:18 +0100 (CET)
Date: Mon, 10 Dec 2018 12:28:18 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Message-ID: <20181210122818.15de3232@bbrezillon>
In-Reply-To: <f6c3a649-f580-513d-644d-5010b3b5cf0b@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-4-vigneshr@ti.com>
 <20181210094513.6282d55e@bbrezillon>
 <f6c3a649-f580-513d-644d-5010b3b5cf0b@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_032831_238763_08ADD4E6 
X-CRM114-Status: GOOD (  19.87  )
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
Cc: devicetree@vger.kernel.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 16:49:29 +0530
Vignesh R <vigneshr@ti.com> wrote:

> On 10/12/18 2:15 PM, Boris Brezillon wrote:
> > On Wed, 3 Oct 2018 22:26:03 +0530
> > Vignesh R <vigneshr@ti.com> wrote:
> >   
> >> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
> >> It also has an integrated PHY. IP register layout is very
> >> similar to existing QSPI IP except for additional bits to support Octal
> >> and Octal DDR mode. Therefore, extend current driver to support Octal
> >> mode.
> >>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>  drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> >> index e24db817154e..48b00e75a879 100644
> >> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> >> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> >> @@ -101,6 +101,7 @@ struct cqspi_st {
> >>  #define CQSPI_INST_TYPE_SINGLE			0
> >>  #define CQSPI_INST_TYPE_DUAL			1
> >>  #define CQSPI_INST_TYPE_QUAD			2
> >> +#define CQSPI_INST_TYPE_OCTAL			3
> >>  
> >>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
> >>  #define CQSPI_DUMMY_BYTES_MAX			4
> >> @@ -898,6 +899,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
> >>  		case SNOR_PROTO_1_1_4:
> >>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
> >>  			break;
> >> +		case SNOR_PROTO_1_1_8:
> >> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
> >> +			break;
> >>  		default:
> >>  			return -EINVAL;
> >>  		}
> >> @@ -1205,6 +1209,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
> >>  			SNOR_HWCAPS_READ_FAST |
> >>  			SNOR_HWCAPS_READ_1_1_2 |
> >>  			SNOR_HWCAPS_READ_1_1_4 |
> >> +			SNOR_HWCAPS_READ_1_1_8 |  
> > 
> > Is this really supported on qspi versions of this IP? I guess not given
> > the description in the commit message and the name of the new
> > compatible (ospi instead of qspi).  
> 
> No, qspi version does not support Octal mode. I guess you are pointing
> out its logically wrong for driver with "*-qspi" compatible to declare
> SNOR_HWCAPS_READ_1_1_8 capability.

Exactly.

> Will update patch to declare SNOR_HWCAPS_READ_1_1_8 based on compatible.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
