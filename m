Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:46:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A267A20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+4r8lni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A267A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WC8q8G613wI8wY5wDd0lza5kwlq8cDk5tho5J7l8T34=; b=I+4r8lnivC6Ep6
	qyamxWJ9MYP365wM8gR/oOeOzEuUtcFglitqltaNIqqFxlQrbhc4tloxonoLi6XwV8huewXy08dgp
	GVAWQ2cXaMw1nJRlVSwW7zN6pKyPClZWsBfbgbVu3EVds7fEgOtbybEN4FNDYvbb7GHD9PYy2kk/U
	hCYwcU2o/8bLFTK0WZxk0Fb72n0Y4sdoq46tXzf7DnAnBN8m3Yo8ageqE8HLyk8QAilCnRE9H43gm
	y5lON6RnqR1z55/Hz/jdLlP0YdAIHl9nEktJ+Q+5A5S69rB22Xq+FOC1P2qByxyDY76dvaZJwr/Zu
	6iD6gjITYPjJ/n2+M59A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHCh-0004ji-4V; Mon, 10 Dec 2018 08:46:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHCY-0004TF-DB; Mon, 10 Dec 2018 08:46:12 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1A7D820DBC; Mon, 10 Dec 2018 09:45:55 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id CF0272037D;
 Mon, 10 Dec 2018 09:45:44 +0100 (CET)
Date: Mon, 10 Dec 2018 09:45:44 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] spi-nor: Add Octal SPI support
Message-ID: <20181210094544.3843e782@bbrezillon>
In-Reply-To: <0e4286ea-85d1-a909-17c0-47f9506b3e5a@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <0e4286ea-85d1-a909-17c0-47f9506b3e5a@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_004606_809678_61DE9DCE 
X-CRM114-Status: GOOD (  16.39  )
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
 Tudor Ambarus <tudor.ambarus@microchip.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 9 Dec 2018 14:17:18 +0530
Vignesh R <vigneshr@ti.com> wrote:

> Hi Boris,
> 
> On 03/10/18 10:26 PM, Vignesh R wrote:
> > This series adds support for octal mode of mt35x flash. Also, adds
> > support for OSPI version of Cadence QSPI controller.
> > 
> > Based on top of patches adding basic support for mt35xu512aba here:
> > https://patchwork.ozlabs.org/cover/971437/
> > 
> > Vignesh R (3):
> >   mtd: spi-nor: Add Octal mode support for mt35xu512aba  
> 
> 
> >   dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
> >   mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller  
> 
> Could you consider above two patches for v4.21 once [1][2] are merged?
> 
> [1] https://patchwork.ozlabs.org/patch/1006717/
> [2] https://patchwork.ozlabs.org/patch/1006715/

I asked Tudor to have a look at those patches. I'll apply them once I
have his R-b.

> 
> Let me know if this needs to be re-posted.
> 
> > 
> >  .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
> >  drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
> >  drivers/mtd/spi-nor/spi-nor.c                         | 11 ++++++++++-
> >  include/linux/mtd/spi-nor.h                           |  2 ++
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >   
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
