Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE92C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA7C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="et5h24r0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="bb8w7yA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA7C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLw4NT4QonawObMYu7E0qlJ98vQ2+kQBa446fZTKiPk=; b=et5h24r0ixl/mu
	HNm/ZYsy+f9dIXMBYHIieTyfQvWs76Csyuy880eSFNqNCSibNcZqnF6CYHN0usum4FNrUK1x8NeNf
	Y7AFVFQ+6gRFgpXo2yZs8y5AWxglDSwJ+tvN5NXx+teFaCT7S0eds0A46StZ+iSLZLzY6x7hfQxnS
	0IuMsnXTHIiMzLhXkfWemG9fgHU61w1oIOX5Et+zihmpVhuaSwozRpdBYtsIauVAhb4VjDWkIJuIe
	8Vo1MnD7D6gQpzyMWuOVafwf0Vmi4EE0IfBa3I9tjAEq0E+NhYxwn1BMnCsIOqu+nZhFQHcDlDb/I
	w44+VTS6wk6Umv9OILGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwLW-0001TX-VR; Tue, 22 Jan 2019 13:44:06 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwLS-0001NV-Dn
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:44:04 +0000
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 6A8FB25B827;
 Wed, 23 Jan 2019 00:43:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548164639; bh=CK0zwahvSfmj6RT5ohZk+GQg9MOhfp2HeiUj6q2BL38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bb8w7yA1BB/ODQNVnYJUFy7rvYkB0b51NG6XtY5K8ExMXjhgA6ZGAtUbG8gR8W5rY
 +NAk4t+K8KBKiH+aMxtiYGewF1CY1nw4OOBVS5No8aFOPuaVkSlMiw8YhMtOgbUVVh
 boLQUYAKhlfVF4X64Q97r7nanaPHFGvnflgVWmj0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 94C39E21269; Tue, 22 Jan 2019 14:43:55 +0100 (CET)
Date: Tue, 22 Jan 2019 14:43:55 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ARM: shmobile: defconfig: Refresh for v5.0-rc2
Message-ID: <20190122134351.63lubcrccpak5zp4@verge.net.au>
References: <20190118155938.12124-1-geert+renesas@glider.be>
 <20190121165600.2lavtrk2djj4adgb@verge.net.au>
 <CAMuHMdV-AM9GNnDo7W55Mv-uLtWn-nTBtmh3jn30tRSEDLNfTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdV-AM9GNnDo7W55Mv-uLtWn-nTBtmh3jn30tRSEDLNfTQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054402_740193_AAD8935B 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 09:25:33AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jan 21, 2019 at 5:56 PM Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jan 18, 2019 at 04:59:38PM +0100, Geert Uytterhoeven wrote:
> > >   - Move SoC config options (moved in commit 062887bf5ef73313 ("ARM:
> > >     shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")),
> > >   - Move PCI config options (moved in commit eb01d42a77785ff9 ("PCI:
> > >     consolidate PCI config entry in drivers/pci")),
> > >   - Drop CONFIG_I2C_MUX=y (auto-enabled since commit ea6b13e9fed0fda9
> > >     ("drm/bridge/sii902x: Add missing dependency on I2C_MUX")),
> > >   - Drop CONFIG_SH_DMAE=y (no longer selectable since commit
> > >     a19788612f51b787 ("dmaengine: sh: Remove R-Mobile APE6 support")),
> > >   - Drop CONFIG_ARM_UNWIND (auto-enabled since commit f9b58e8c7d031b0d
> > >     ("ARM: 8800/1: use choice for kernel unwinders")).
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Would this change be any different if it was a refresh for v5.0-rc1?
> 
> No it wouldn't. Same for rc3.
> 
> > I ask because the ARM-SoC maintainers prefer the oldest possible of
> > the current rc series to be used as a base.
> 
> Hence feel free to s/rc2/rc1/g or s/rc2/rc3/g.

Thanks, I have applied with s/rc2/rc1/g

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
