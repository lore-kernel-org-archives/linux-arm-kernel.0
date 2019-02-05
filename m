Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C430C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:58:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EA72145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zu6vZAU2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mtXB+NuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EA72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H7qOhH7Y9PyzgAefTY4PtumXdOXaAcgi8w/UxTIqS84=; b=Zu6vZAU22biRDb
	D59Q1oXYC0ZhTCeTcJXIEqxB6RSTId6QjvessaAxRzX8pYU/jfskwT65W74YmRlmOcW72uvEcICS4
	iGC12OoX7+d906mes1J6jvGvgJdC5SlPO6KOIqjW14L/0mgRC9DnFnqQOvVEtQC7Jn7kSvdqdvIgZ
	oeQe9BKyydEItyIKWCTBlq6L37O9XyVaJMzjudilqO6ODxv2IS56ZLDqM5B0hUGoZxseXVQP+DH/b
	Z9CPmnial5/oHw5CZbT/zXgdVhhPsb2KPW2fa1kc51PdR1FXIBUmjTYVUxLWsrHq7wQtV9iTHXQtv
	X7SZEyjh5LRIHWup4FTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyQt-0002lw-BP; Tue, 05 Feb 2019 10:58:27 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyQm-0002ez-Fb
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:58:24 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 42C4325B812;
 Tue,  5 Feb 2019 21:58:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549364299; bh=YPgFu0dPaONIcL9PAoiGa+wmMOFZy4vBprYLs6jCl9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mtXB+NuEtY2yqFN98El8WsWBmO2Xfj7XSLsqLTplTMb5Eigu4tB2ZN2ZurYqdehcK
 1rwoo+AapyCo2coE6iOh1L5gM1H8G1/d7flF5fJJePBY7/gHr1ZGyIoWajJd5tm2hf
 ruotZCwHZXZLkUfrqM67QfiDH6OkYmjPZVbJLgs8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 86E03940486; Tue,  5 Feb 2019 11:58:17 +0100 (CET)
Date: Tue, 5 Feb 2019 11:58:17 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Update for moved options
Message-ID: <20190205105817.fn4ua6fjgkdxuvea@verge.net.au>
References: <20190204203747.7376-1-tony@atomide.com>
 <20190204203747.7376-2-tony@atomide.com>
 <CAMuHMdV68HxMzyMAgy6Cy_ECussJmpVTh5=vDAHwD8rA-BWsTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdV68HxMzyMAgy6Cy_ECussJmpVTh5=vDAHwD8rA-BWsTg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_025821_304586_E3E3BA07 
X-CRM114-Status: GOOD (  11.79  )
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

On Tue, Feb 05, 2019 at 09:09:16AM +0100, Geert Uytterhoeven wrote:
> Hi Tony,
> 
> On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> > These options have just moved around, let's update with make
> > savedefconfig to make patching the file easier.
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
