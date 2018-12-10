Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEB6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AD22084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VY1hNTe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AD22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Da/YkI8b2YRT0Y+rJHqd2OVAx2ugtsiPJdH0rGzSs0E=; b=VY1hNTe/MNfpzu
	PvAeHwNgJ93FdoKCKt6+aOdbg0Uisl62735MIQrYRaCUPUANQ+6M70bAiftGSTEnmoMqp2A82KfcL
	LctVLSFfHIXhx4sBiCzIaWMW3iARcQ8BGSZihuGv9cChI93yZR9oITXKE/mThsyfbc3T2MttJvXtF
	JyFm8HH94LQlIa3ddvMnn7C8fuv1JHSXLY5ZZ9/GWTdE5zdQ/DNKDuhT26J7bOMXVC5h5XD5ZasBn
	wVX46d4s+wjL+LGOmqWPFwBFIDgjU7e2bAA6lAS8PzZmzYQoVGftlPB5pP7zAIeZbsaeJnc6LnFVF
	2ionLJKpmmCzc/RCvMfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKRM-0002Ug-Ja; Mon, 10 Dec 2018 12:13:36 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKRD-0002KQ-BC; Mon, 10 Dec 2018 12:13:34 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 04A5A20CEC; Mon, 10 Dec 2018 13:13:16 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9C81220CE8;
 Mon, 10 Dec 2018 13:13:15 +0100 (CET)
Date: Mon, 10 Dec 2018 13:11:00 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Message-ID: <20181210131100.6e4801e2@bbrezillon>
In-Reply-To: <VI1PR04MB57269A32C1FF1592F117B97799A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210111909.35384eee@bbrezillon>
 <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210115001.6c7af1d7@bbrezillon>
 <VI1PR04MB5726F0DDAC84F1AEC20B56DF99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210120925.3c6336f6@bbrezillon>
 <VI1PR04MB57269A32C1FF1592F117B97799A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_041327_884261_04AEAB98 
X-CRM114-Status: GOOD (  24.27  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 11:25:55 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, December 10, 2018 4:39 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; linux-
> > mtd@lists.infradead.org; marek.vasut@gmail.com; broonie@kernel.org; linux-
> > spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> > mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> > 
> > On Mon, 10 Dec 2018 10:59:54 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > Hi Boris,
> > >  
> > > > -----Original Message-----
> > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > Sent: Monday, December 10, 2018 4:20 PM
> > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > > Cc: Schrempf Frieder <frieder.schrempf@kontron.de>; linux-
> > > > mtd@lists.infradead.org; marek.vasut@gmail.com; broonie@kernel.org;
> > > > linux- spi@vger.kernel.org; devicetree@vger.kernel.org;
> > > > robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > > linux-arm- kernel@lists.infradead.org; computersforpeace@gmail.com;
> > > > linux- kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
> > > > controller
> > > >
> > > > On Mon, 10 Dec 2018 10:43:56 +0000
> > > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > > >  
> > > > > > > Thus, in LUT preparation we have assigned only the base address.
> > > > > > > Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register
> > > > > > > then for  
> > > > > > read/write data beyond limit of ahb_buf_size offset I get data corruption.
> > > > > >
> > > > > > Why would you do that? We have the ->adjust_op_size() exactly
> > > > > > for this reason, so, if someone tries to do a spi_mem_op with
> > > > > > data.nbytes > ahb_buf_size you should return an error.
> > > > > >  
> > > > > Let me explain my implementation with example. If I have to write
> > > > > data of size  
> > > > 0x100 bytes at offset 0x1200 for CS1, I would program as below:  
> > > > > In func nxp_fspi_select_mem(), would set value of controller
> > > > > address space  
> > > > size, memmap_phy_size, to FSPI_FLSHA2CR0 and rest all FSPI_FLSHXXCR0 as  
> > 0.  
> > > > > Value of memmap_phy_size is 0x10000000 i.e. 256 MB for my
> > > > > LX2160ARDB  
> > > > target.  
> > > > > Then in nxp_fspi_prepare_lut(), I would prepare LUT ADDR with
> > > > > address length  
> > > > requirement 3/4 byte for NOR or 1/2/3/4 bytes for NAND flash.  
> > > > > Also for LUT_NXP_WRITE would program data bytes as 0.
> > > > >
> > > > > Then inside func nxp_fspi_do_op(), set register FSPI_IPCR0 as the
> > > > > address offset i.e. 0x1200 and in register FSPI_IPCR1 program the
> > > > > data size to write i.e. 0x100
> > > > >
> > > > > If, as suggested if I tries to mark value of register
> > > > > FSPI_FLSHA2CR0 equal to  
> > > > ahb_buf_size (0x800), then access for address 0x1200 gives me wrong
> > > > data. This is because as per the controller specification access to
> > > > flash connected at CS1 can be performed under range of FSPI_ FLSHA1CR0  
> > and FSPI_ FLSHA2CR0.  
> > > >
> > > > Don't you have a way to set an offset to apply to the address
> > > > accessed through the AHB? And if you don't, how will it work if your
> > > > mapping is smaller than the flash size?  
> > >
> > > Write operations are triggered using IP commands instead of AHB command.
> > > For Read AHB command is used and in this we are adding the offset when  
> > performing memcpy_fromIO operation  
> > >       memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val),
> > > len);
> > >
> > > AHB/IP operations are independent of the way how CS got selected. CS  
> > selection depends, e.g. CS1 on the value of register FSPI_FLSHA1CR0 and
> > FSPI_FLSHA2CR0.  
> > >
> > > Mapping can never going to be smaller than the connected flash size as per  
> > discussion with the Board design team and if it's possible by user manually
> > changes the non-soldered part then flash area beyond complete mapping is not
> > accessible.  
> > > On LX2160ARDB, with mapping of 256MB, for now we are having 4 flash  
> > devices connected with size as 64 MB. If user wants he can have only one single
> > flash with flash size of 256MB.
> > 
> > Given that the dirmap interface has now been merged and the MTD side of
> > things is soon to be merged, I'd recommend you to implement it in your
> > v6 and only use non-AHB accesses for the ->exec_op() implementation.  
> 
> This would going to be performance hit if I would use non-AHB accesses for ->exec_op().

Not if you implement the dirmap hooks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
