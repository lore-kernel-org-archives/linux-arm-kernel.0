Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E4C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517572147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KImhcIBo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="hLVVHeEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517572147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=57Jg8N/7kaOucbjv8Uqd/zGxtFJdXhrCymkypITsVYs=; b=KImhcIBoWkrqLn
	pO3Rb+IVJWKz0RwvyrP0gICYAK76M+YB0eGd0o+CYQHe+mqO1i/1rdB/YY4AxRhD9vEGcdzQ4jSWm
	0fC137nEbkXVXnu/WTOFYBPvTBIvaPL+SHayJms7BwgjnS1cDu8Hvky3MJMbm9/XSWpjsst+c8Sot
	hdoZhxDBO8Xwni+ZDKK9OJOiRRd71IoZoYWDnpt1tadjFtOArfuhYKBchi5BM+uAaG7Np9HelGubR
	01FQIjNFJ/UUEPdc7TCY09KuowiiRUvEBxxD8ieV1D4jwsm3MqMHnUcDfhYYQ23ccFvr5NT+PSvg7
	PcooG3c2KxGHCuE+EiRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9tv-00067E-8z; Mon, 28 Jan 2019 16:36:47 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9tq-00066V-8T
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:36:44 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 1F00225B7BA;
 Tue, 29 Jan 2019 03:36:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548693401; bh=2sLAV7iyLNGcktOzcHf+SyLx6Xh84dfZei/gxoWwa+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hLVVHeEsX/SoVAqxzDxHLr00BMACtVlbYZK/NVdbPUBGUhLUtwIkLCT4JvuVko85T
 PtDrGta3QrlbS+A4gDMZ4k8m9wUuSg1RBD9ioh7xtf84lYkFpStTIr0wO8dbpjg6OS
 nm8rZ4WhG2rqpUsSYzOxuTCSWqhUI0uu2uzCEfh0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 538979403E0; Mon, 28 Jan 2019 17:36:39 +0100 (CET)
Date: Mon, 28 Jan 2019 17:36:39 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add OPPs table for
 cpu devices
Message-ID: <20190128163639.kv77wczde7d7lntv@verge.net.au>
References: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
 <20190128140519.wfbnpgznbkx3msft@verge.net.au>
 <CAMuHMdW2j4e4yc2ZkeJ71uqGz7FS2Kb2141tyZp9y3zTrJ21_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdW2j4e4yc2ZkeJ71uqGz7FS2Kb2141tyZp9y3zTrJ21_g@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_083642_602991_C6BCDBC0 
X-CRM114-Status: GOOD (  14.81  )
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
 Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 04:15:30PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jan 28, 2019 at 3:05 PM Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Jan 15, 2019 at 09:02:42PM +0900, Yoshihiro Kaneko wrote:
> > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > >
> > > This patch define OOP tables for all CPUs.
> > > This allows CPUFreq to function.
> > >
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > ---
> >
> > Thanks, I have tested CPUFreq with this tested that with this patch and
> > "[PATCH] clk: renesas: r8a77990: Add Z2 clock"
> > (https://patchwork.kernel.org/patch/10783723/) applied on top of
> > renesas-devel-20190128-v5.0-rc4.
> >
> > Geert, or others, is it expected that z2 does not scale
> > in this test?
> 
> Given your patch adds the Z2 clock as a fixed clock, this is expected ;-)
> 
> Note that the BSP adds this clock as a programmable clock of type
> CLK_TYPE_GEN3_Z2.

Thanks, understood.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
