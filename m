Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF33C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBA920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s2LxLUfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBA920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tbhsj28kEgneH3+81Wd8SJWDYHGMf9f48MUovDEFp/o=; b=s2LxLUfZiZ1p/G
	op2TJ0dhVH1n6psRUGo8WxYO59hfs0PKFLKPFHTTDi/bk4U16qbFq+u/8774McYWQAa6OXj7rgRa4
	STmTN+4h+wUi2lNtdF7tAXs5O0ZWAlCrhcaEC0gCWEmcUc4EU51Zl8GdA7DT0JOGOlez7DaChv2W8
	wdsb0oSUjGQsX882GSi00UrjGmVUHum7f86qwYcqI/P2hvwyvlKnxnrLQJ6uIW+4NWkQOAzGhcASa
	9DJNrbEh/TfdXzJOoaah+DeCka0Z7PYp9KCMExI+HCKaGUbZ+/eAlRm9z8vfM0aMIX49TX4MV/er0
	4spatpVKZQmI8rKc5z7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJid-0003Us-Lc; Mon, 10 Dec 2018 11:27:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJiZ-0003UG-H0; Mon, 10 Dec 2018 11:27:21 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 93AAA20CE3; Mon, 10 Dec 2018 12:27:07 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id 373E420711;
 Mon, 10 Dec 2018 12:27:07 +0100 (CET)
Date: Mon, 10 Dec 2018 12:27:07 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Message-ID: <20181210122707.3416095c@bbrezillon>
In-Reply-To: <VI1PR04MB5726164D7E52B013FF2F135B99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181210115717.01ad2e60@bbrezillon>
 <VI1PR04MB5726164D7E52B013FF2F135B99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_032719_833593_CB361C24 
X-CRM114-Status: GOOD (  14.21  )
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
 "vigneshr@ti.com" <vigneshr@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 11:17:20 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, December 10, 2018 4:27 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; broonie@kernel.org;
> > marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
> > commands
> > 
> > On Mon, 3 Dec 2018 08:39:18 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > - Add opcodes for octal I/O commands
> > >   * Read  : 1-1-8 and 1-8-8 protocol
> > >   * Write : 1-1-8 and 1-8-8 protocol
> > >   * opcodes for 4-byte address mode command
> > >
> > > - Entry of macros in _convert_3to4_xxx function
> > >
> > > - Add flag specifying flash support octal read commands.
> > >
> > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>  
> > 
> > Looks like the SoB and Author lines do not match
> > 
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> vs Yogesh Gaur
> > <yogeshnarayan.gaur@nxp.com>
> > 
> > Can you find a way to make them match?  
> I am sending the patches with my smtp server of OutlookOffice and in that my user name is "Yogesh Narayan Gaur" and in gitconfig of my Linux machine I set user name as "Yogesh Gaur".
> Is it mandatory to have same Author name in SoB and Author lines, if yes I would change the settings in gitconfig file.

We have scripts that check that the author/committer has its SoB,
depending on how strict the check is, it might complaint that SoB an
author/committer do not match, so yes, please change gitconfig to make
them match.

Thanks,

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
