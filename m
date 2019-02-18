Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093F8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC502177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dTW0UIcJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="byU9vJc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC502177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lUGqA1AusZ95zurCCz0iiMnnN4jE+Nh/kULsMoSC/24=; b=dTW0UIcJbmd0yI
	1mTKyRrL2DhAWcPf5F8lVPGgCa1Fhiue9ZLEE6Hxu6mNA81IX0DvrF/C80HmrJikADxD9+gNXm4Uf
	m3ib8gs9tEv/lLJJMjJI+Kjvi9gz4sxs7/xIDzQfBF9dkknHOR3RV5U+bpOqHyXGj3PokaXmITGqo
	2LoGUu84W/i4p32n76yOC7idltYwCquQbGGTBvznYo55ZcH+KUyr+43PAkIR7rA4qckaCaIfrPDdU
	KLKS3oyZT2LE81PsmUo74y3NUAYOI+nxyMSuavHglLtUT2PH2hsMo/6McPIDGqXIWbfcin2P6JyTo
	3C2HOM2MDAAHeJd+tzlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvh58-00087y-Lq; Mon, 18 Feb 2019 11:27:30 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvh54-00087X-EI
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:27:28 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 6757725B73F;
 Mon, 18 Feb 2019 22:27:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550489243; bh=eGiQNi8TPn8Yx8vbacBOQfprj4ZAZcfkjtn4kl7CV+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=byU9vJc0C5y664mxP17ZTzVkFsgbHg2bJIPHh9Ax/KLwL0p63oUIAvhjQrur2yDb3
 sYfS6smaAyA1VkC6JMj6COOxVDnfnsKPGSvT/JFuEEoNMlrvxqGzGtZIhzBY3oFq5T
 kjX58RphN96LlhN6O/WzupyGYnzVT9ho/y/t4epY=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 53E8CE21807; Mon, 18 Feb 2019 12:27:15 +0100 (CET)
Date: Mon, 18 Feb 2019 12:27:15 +0100
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
Message-ID: <20190218112715.zufzr3knrhs37t6h@verge.net.au>
References: <cover.1549622472.git.horms+renesas@verge.net.au>
 <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_032726_624813_105721B7 
X-CRM114-Status: GOOD (  16.64  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 05:49:32PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> >
> > Hi Olof, Hi Kevin, Hi Arnd,
> >
> > Please consider these Renesas ARM based SoC updates for v5.1.
> >
> >
> > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> >
> >   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> >
> > are available in the git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v5.1
> >
> > for you to fetch changes up to 5347a0203709d5039a74d7c94e23519eee478094:
> >
> >   ARM: shmobile: Fix R-Car Gen2 regulator quirk (2019-01-07 13:24:07 +0100)
> >
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC Updates for v5.1
> >
> > * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> > * Add missing dts files to MAINTAINERS
> 
> Should the bugfix be marked Cc:stable and and Fixes:... ?
> 
> Pulled into arm/soc, thanks!

Thanks,

Sorry for missing that, I think that the bugfix should have had the following.
Let me know if/how you want to handle updating the patch's changelog.

Fixes: 6d14d4d313d09dab ("ARM: shmobile: Rework the PMIC IRQ line quirk")

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
