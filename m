Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD619C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19BF2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gbZmRBJz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ow3FavPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19BF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Kq1Gi4oHaAv7a0d1blV4MsN4bP1kqHvLa8KDVZgd1U=; b=gbZmRBJzXJb9Au
	6Li46D38A0cNoIMmLk2F7Iz2tuTkidBoXWtFmcrUCkAz5NW12xKj79ELlRRT4BI/6FGfs1Fuv3zN/
	biEVgDV01OU1fArReLVtudfcSQexnjGENxxtYm/sT6bbHYgykbTRcwzH3OVwDsKwKxOsAlwD7GX7n
	mLw78al+zQtYOJ+F3kb4iPCyuqvr97jTDYr2uC80mDddY0Uvbb9ucglHWBcnaBidkzpAoDiX6KKZu
	PqrGBLl81Xr9yhzJmNiUItcSCJX5a2KJQcGLsfjTCRtigS0K5ifH5e/TG1mVXCsKe/4oFABIt35b5
	fAGfZvYC+FfMheVnUeWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyQi-0002aO-2R; Tue, 05 Feb 2019 10:58:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyQe-0002Zm-C6
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:58:14 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 355B525B812;
 Tue,  5 Feb 2019 21:58:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549364286; bh=WgsNuKxzT67JrWfOYypdc1u4VZXj3PqfiVgjo/a5Roo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ow3FavPqhlXjfNZBI2XGw9imX1bR9wg10ecI8Fe2HqLHMCZxauVFyO2d+T0S5bMQi
 CCBVyFkYsqyZnEuo9iWKogio7a+93n83Q0mpnU6joQ3Je+orUXNIAorukW9p4STMkb
 nwjO8iR5C6CUp+2aiHeGAM/IXJnYHFCrz1eyHIEs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 4BD3D940486; Tue,  5 Feb 2019 11:58:04 +0100 (CET)
Date: Tue, 5 Feb 2019 11:58:04 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
Message-ID: <20190205105801.3eysznz63x3na4ui@verge.net.au>
References: <20190204203747.7376-1-tony@atomide.com>
 <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_025812_629183_FD65A1AE 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Olof Johansson <olof@lixom.net>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 09:07:38AM +0100, Geert Uytterhoeven wrote:
> Hi Tony,
> 
> On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> > These are automatically selected with make multi_v7_defconfig,
> > except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks, this matches similar changes to shmobile_defconfig in commit
> 4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
> in next.
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> I didn't update multi_v7_defconfig to avoid conflicts.
> IMHO the arm-soc maintainers should handle the refresh of the common
> config on a regular basis[*].
> 
> [*] When is the right time? I'd say it should be the last commit just
>     before the release of rc1 (so all arm-soc submaintainers' trees will
>     have the new base in their for-next branches for the next merge
>     window), but that may be difficult to implement.
> 
> What do you think? Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
