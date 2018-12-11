Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C082081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebchGOSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C082081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GzMnKfwtezn/B7edQUY2yz8BS8LATX6KE1i3KcEyZ58=; b=ebchGOSFcbrK1w
	ASgSCLxLJi3FXcDVLykHbNEFzr5nXbOPwH7hSLZKD3vIgRMaGTKjPRRv5j57Do242f7X4dESQ0VJI
	SxrfLl73D3/B94s7StyyZ4eMNW+q7IIkOKpfilLT1UMDx6WSu2graOabJfoG9vgyavHVYr2wmOnU5
	R6rg18x8ibpMdri/O0Qg0Ep0+VOIp40PnSBK+9zLzrItCDDpL6fyXJ3hyACYFPKuQseLEPplGkN/i
	DTccYEM/25UXsXd1F0/U++TIS0FEfK3MAIUEx4OmywpuoTt9X4hGuO+Hc14npotULv7xRXczjNmpO
	4U9INdlWewoHT6LoUPTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdaL-0001Lj-J8; Tue, 11 Dec 2018 08:40:09 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWdaG-0000A6-Mx; Tue, 11 Dec 2018 08:40:06 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 34C7320723; Tue, 11 Dec 2018 09:39:52 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id E1DB820717;
 Tue, 11 Dec 2018 09:39:32 +0100 (CET)
Date: Tue, 11 Dec 2018 09:39:33 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Liang Yang <liang.yang@amlogic.com>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181211093933.2fab8cc3@bbrezillon>
In-Reply-To: <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_004005_028924_464DDB23 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Jian Hu <jian.hu@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 09:56:25 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> Hi Miquel,
> 
> On 2018/12/10 22:50, Miquel Raynal wrote:
> > Hi Liang,
> > 
> > Liang Yang <liang.yang@amlogic.com> wrote on Mon, 10 Dec 2018 20:12:39
> > +0800:
> >   
> >> On 2018/12/10 19:38, Boris Brezillon wrote:  
> >>> On Mon, 10 Dec 2018 19:23:46 +0800
> >>> Liang Yang <liang.yang@amlogic.com> wrote:
> >>>      
> >>>>>> +			mtd->ecc_stats.failed++;
> >>>>>> +			continue;
> >>>>>> +		}
> >>>>>> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
> >>>>>> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
> >>>>>> +	}  
> >>>>>
> >>>>> Are you sure you handle correctly empty pages with bf?  
> >>>>>     >> if scramble is enable, i would say yes here.  
> >>>> when scramble is disabled, i am considering how to use the helper
> >>>> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
> >>>> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send
> >>>> out the ecc parity bytes.  
> >>>
> >>> Even if the ECC engine is disabled?
> >>>      
> >> No.
> >> When ECC engine is disabled, it can read the ecc parity bytes ; but there is another problem that i need to consider how code struct looks better when reading error with ecc opened and then try to raw read.
> >> Is there a good idea?  
> > 
> > When reading with ECC enabled, in case of uncorrectable error you
> > must re-read without ECC, then check if the page is empty or not with
> > the core helpers (nand_check_erased_*()).
> > 
> > Is this what you meant?
> >   
> yes. when uncorrectable ECC error, i need firstly read out the ECC bytes 
> without ECC engine and then use the helper nand_check_erased_ecc_chunk 
> to check if blank page.
> Of course, the precondition is without scrambler, or the bland page can 
> be detected by meson NFC.

Yep, raw accessors should disable both the scrambler and the ECC
engine (see what's done in sunxi_nand.c).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
