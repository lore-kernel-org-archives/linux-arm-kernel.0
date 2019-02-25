Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56383C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:15:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257E220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWKnk/rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257E220842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KQTR7TjRCxSp+Fv+cHCY3gAsEIGt0SerJVKaTtO3JGY=; b=eWKnk/rLrgtzws
	OLOifndqbraxfk8GKHrZve2orABuxGP775gNYwGegFp/5foI+W9cr7r3I6RjzQPraGGzxFzlFIVEU
	nX/RphkWtrnKTKlOrU/lZtCABj+lf8+tE3LVc2ZkMFznZ2pIYV1dQOI+l/LR+Bui+RuHTZCTL7Pyu
	+Ey9s45MeXWXE8k14HLF3LzAAnb243tPiRgWToaiz2BZP5W5CY4fCRhvse+5nf4TSNji+Q/qdynQX
	QjRyrtmyiWp58trx5Lds+vK/NP+T7vTU/Z2GR5MzuMuoKJL6zECMibz8vccx4KGyAQOdyV8fWSYR1
	shqKh85R6bIfVtEQP9wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyFAR-00040N-PD; Mon, 25 Feb 2019 12:15:31 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyFAN-0003zF-Iy
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 12:15:30 +0000
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id CADC744046E;
 Mon, 25 Feb 2019 14:15:20 +0200 (IST)
Date: Mon, 25 Feb 2019 14:15:19 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
Message-ID: <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com>
 <87tvgt7o0q.fsf@tarshish> <20190225115826.5bc17f6d@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225115826.5bc17f6d@xps13>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_041527_858522_FA2E06CC 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,

On Mon, Feb 25, 2019 at 11:58:26AM +0100, Miquel Raynal wrote:
> Baruch Siach <baruch@tkos.co.il> wrote on Sun, 24 Feb 2019 07:29:09
> +0200:
> 
> > On Fri, Feb 22 2019, Miquel Raynal wrote:
> > > There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
> > > may be used thanks to a mPCIe -> SATA extension board only. Hence, the
> > > cp1_sata0 node must be removed from the device tree.  
> > 
> > Not true. You can use the mini PCIe serdes as SATA directly if you
> > configure it as such. You only need to invert the serdes Rx pair
> > polarity. This is the default configuration for the Clearfog GT-8K CON3
> > mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
> > that this setup works on Clearfog GT-8K.
> > 
> > This patch would break mini PCIe direct SATA.
> 
> Thanks for explaining, I am a little bit surprised that it actually
> uses the SATA host IP on CP110 but fine. So can you tell me which SATA
> port is used in this case? Because I will have to update the DT
> representation along with the CP110 changes.

According to the cp110_comphy_phy_mux_data[] array in U-Boot 
drivers/phy/marvell/comphy_cp110.c, serdes 0 of CP110 can only be SATA1 (i.e. 
the second port; first is SATA0).

Please Cc me on your next submission.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
