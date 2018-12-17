Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:52:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1715E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H0NMV2uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1715E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RfQi+VqgNpIIqkIaN5yW2CMoA9MvEBeBHVs/q8m8osI=; b=H0NMV2uU3PzABS
	DFfEgFcF7MydEKMyxnfWuhDpjT/Uk8BDikM88CTQmTBQMYkBX06pbSRSgo1aApaa4FbcVXXr9jofV
	rRUxGu/GJow0m9ITLtOL+fAUDjQZjysuifZNO9232bZLJSdVMS6oy11Kb5wrBHDXmPGLjRlm3euTx
	8J4DLcEoRtldyyjIPBdDW9DPf//TFrR6Ls9rIsTfr3mE2/Mpmplsa/TWBrMvALxhbe4rXu7fBnPfJ
	65X/sHvEY+iQy5JI3H4LJH3dPBhYeRrJ9iSGfs4b/pkxhvPyLkatvKomI9LPQpDwM0apv1zn7gOU/
	bVosrE+dfrS7GAqmL3hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvCK-0006h0-HH; Mon, 17 Dec 2018 15:52:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvCH-0006gW-6u
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:52:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DA4BA2072D; Mon, 17 Dec 2018 16:52:33 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7237A20723;
 Mon, 17 Dec 2018 16:52:23 +0100 (CET)
Date: Mon, 17 Dec 2018 16:52:23 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 3/7] phy: add A3700 COMPHY support
Message-ID: <20181217165223.6f98b8a4@windsurf>
In-Reply-To: <20181217164857.68df3f84@xps13>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
 <20181213083908.14180-4-miquel.raynal@bootlin.com>
 <20181217164857.68df3f84@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_075245_387946_7CCA2D43 
X-CRM114-Status: GOOD (  15.59  )
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
 Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Evan Wang <xswang@marvell.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Mon, 17 Dec 2018 16:48:57 +0100, Miquel Raynal wrote:

> I received the following bug report because I added a dependency on
> COMPILE_TEST in Kconfig:
> 
>         config: i386-allmodconfig (attached as .config) compiler:
>         gcc-7 (Debian 7.3.0-1) 7.3.0 reproduce:
>                 # save the attached .config to linux build tree
>                 make ARCH=i386 
> 
>         All errors (new ones prefixed by >>):
> 
>         >> ERROR: "__arm_smccc_smc" [drivers/phy/marvell/phy-mvebu-a3700-comphy.ko] undefined!    
> 
> Unless someone complains, I will drop the dependency on COMPILE_TEST in
> Kconfig.

Keep COMPILE_TEST, and add:

	depends on HAVE_ARM_SMCCC

perhaps ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
