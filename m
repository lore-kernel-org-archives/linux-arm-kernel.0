Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5548C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21C721901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ov8nMKk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21C721901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oASaDKGJUa+Ot4OXORDKO85ktB1YYnQaf1IKaHJJuZw=; b=ov8nMKk5bUmX00
	pWZCyEG6aM4l14lAcU+NFEgsBvBZmhWqqehmV3sP9aUMVFs53/wn1+iYrlVBZT3k7GD/7fjJ32WeE
	tzOyxd7Y6UbtXzrn9zxJDGs+4WZ3CgM/o5DeVwWn6dMfJdiBVn5sk/X2dMJG3P/1ogWeIfmO6I52r
	d8meFFHuga21N3Fi2i/4vOxK9ulM+yQTZXOqCh8Pb8MgOP7vzWSV/kYfXYjsGI2esOGdTy1diBxRw
	oWk/U+O9OSHLQrrJqxiNFE65Bf8dj3KDEcigcIXdSmXKp06ixI8KviWAXzaTxOtlFkjZEBtYKGTuf
	eCmgOAtHCRUjnfWJlJ6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjnd-0000vr-05; Mon, 18 Feb 2019 14:21:37 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjnY-0000sr-OH
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:21:34 +0000
Received: by mail-qt1-f193.google.com with SMTP id n32so19259333qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tedBm7tEj+42p5CtJWgjBm2AF23zaCje89BVBJneM0M=;
 b=HcQ77d3EIEsTYBk3OkvAbd0A+PbhMtZwKn6zyY7/YTIxI96I/dcdGoHEdQWIRbR53G
 yQuoLyjIWBrnCAsz0XDhnRuJGFxX0Yt8u7OLdn5q7Q+CpWQfdCrmWjdyagXParJZoSXa
 c5QMkrd5vkkIcpOlqIm+vCVgkPrDyGVHYfafK26CRsU9d1CN2CwHdJBdYiMqzzZqKh8F
 HUOLOhx9sCDeIussK3/j1J0sElnH4S2R0qF34wn78/Z4P1m1uxXxJp0xFrHDdvk0kDzg
 ZGPuZ7PiX/uCIkS5MClZIWZKckt6iLm5KOY31ufFmUN9gEFw/zV1GSyNhvQYhZ670cXT
 hpRg==
X-Gm-Message-State: AHQUAuZyRbRm7rL1e04uOvzcLeed9Y9oqNSi26pnfVtZJYIHXMiENT/5
 tPTMOGOkWbwDEecWCG6dReOP6C1t3YBltPKwj8g=
X-Google-Smtp-Source: AHgI3IYDAZCUlkI7uxhgCkk4TDyxQIXuDT4FYtE1p2U9SAK447aJaSaRygET62vtdWwZLvPjF3nMocbUC5+AbSI/fvg=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr18226786qtn.212.1550499691188; 
 Mon, 18 Feb 2019 06:21:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549622472.git.horms+renesas@verge.net.au>
 <CAK8P3a0prd-4eyVOVUpp2Bhn1mGOVZwA_we79TNjSa4FF5DP6A@mail.gmail.com>
 <20190218112715.zufzr3knrhs37t6h@verge.net.au>
 <CAK8P3a1BrahyfrRD=1dSLNzc1mujh+rxdLoU8CtGruRSbo3JVg@mail.gmail.com>
 <20190218141417.7n6q5petp5oepd55@verge.net.au>
In-Reply-To: <20190218141417.7n6q5petp5oepd55@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 15:21:14 +0100
Message-ID: <CAK8P3a3ULz5BG=hUmhX0a+AX4yYs9gB9G8QEjYjV9pDO=5BBuw@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_062132_791253_7FDC9794 
X-CRM114-Status: GOOD (  19.17  )
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
 stable <stable@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 3:15 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Mon, Feb 18, 2019 at 02:12:07PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 18, 2019 at 12:27 PM Simon Horman <horms@verge.net.au> wrote:
> > > On Fri, Feb 15, 2019 at 05:49:32PM +0100, Arnd Bergmann wrote:
> > > > On Fri, Feb 8, 2019 at 12:14 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > > Renesas ARM Based SoC Updates for v5.1
> > > > >
> > > > > * Correct shared IRQ handling of R-Car Gen2 Regulator quirk
> > > > > * Add missing dts files to MAINTAINERS
> > > >
> > > > Should the bugfix be marked Cc:stable and and Fixes:... ?
> > > >
> > > Sorry for missing that, I think that the bugfix should have had the following.
> > > Let me know if/how you want to handle updating the patch's changelog.
> > >
> > > Fixes: 6d14d4d313d09dab ("ARM: shmobile: Rework the PMIC IRQ line quirk")
> >
> > I think the easiest way is to send an email to stable@kernel.org asking for
> > a backport of commit 5347a0203709 ("ARM: shmobile: Fix R-Car Gen2 regulator
> > quirk") after that has hit the mainline kernel and asking for a backport.
> >
> > I've added it to Cc here, but I don't know if that's sufficient.
> >
> > If you'd rather have me pick up the patch for 5.0 as well, I can also do
> > that and add the Cc/Fixes lines there. We will then have a duplicate
> > commit in 5.1, but it should not cause any merge issues.
>
> Thanks Arnd,
>
> I'm happy to handle this via stable and avoid the duplicate.
> If I don't hear back from them in a few days I'll make a formal
> submission there.

Ok, sounds good.

To clarify: I think you should only write them /after/ the commit
is in mainline then, i.e. near the end of the 5.1 merge window.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
