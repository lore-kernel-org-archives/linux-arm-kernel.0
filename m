Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F19C67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:41:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7249C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/lKvIBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cvJeNExhxIlDItJJDke5pvG/YREBGD7SxYVfJiC2iLY=; b=e/lKvIBmsAxeQo
	yS2Fzfw+TKv+j/gFrQLMCwW6cNkth1so00qMS3Mhgk+tA3W2deICNOuhKjAxfnMqa+0h/Rj1KBZWy
	hpKIXdCLcGSq10MY81iQsh0InVXA94HCIzvXT2Db8H1S33Xzij7lAfgSe86Cut1GLyYUBvq3tkaj6
	gVGml0CFW57GUkmVYttIpOLP8Qla2T9Wz0ttM3J7wZ171VLXFl0QuGMPHZTZgGFxN8XdlPeQSfqVb
	9rUl7mqEJE2IuHAXEOyx7Se8ZvzgXyOpiaWPGOMjwm6l0//1A89FK3RYWfryBm3HXuopA98PKKfEn
	62ekrNKc3hcjtjKnje8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqA2-0006VQ-Bj; Thu, 06 Dec 2018 09:41:34 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUq9w-0006Uz-J2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:41:32 +0000
Received: by mail-vs1-f68.google.com with SMTP id x64so13893337vsa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=81Z3CG/0v3EDIi5JrRBo0k2r90HeZatwZ0P6XOPxOag=;
 b=CrFG5R+SFW+AiY0vy2EIWVDkZFVS7T8AEsJ7CgDaO4WZCN3kn6zoeVpbZYwHnTdX+G
 YTvh1VKjlKM4xiutEHBX7IRM93M0iFC//+yREsd3XZlob1/Mwx/ih3MRwq4HS/NNoXI2
 3and6RuDVDBSpX6GchMvAjfUfdrirHtQr3BYr6wNWONiA7lqvkqFOxIApvaTDFMXadyI
 e45i44I0A7xg/T6ECftn9CZYLTgd5gc/sBVu74x4pZP/u0x53aqigmPrbT5T4xMj3Kb8
 5+F1a6GTK08/2Jak839WS9sMgqzYNP1lnn4m0LpLsiB1QeAm5La57CjV4Y6IBq1ZSU5h
 02yA==
X-Gm-Message-State: AA+aEWbDk1ZwJxOXYytrarXy6k7JrSPSY///QtBeIocpOSNe+es9o3Wm
 gzcgDTKmK723l5fiZR/TVNf8Bm0Lmkv+ctK5uZM=
X-Google-Smtp-Source: AFSGD/UYMfCw1BU650SyAefGanK2tqU3fIIll0aipmQLQvnCw99443AaNCWXkRVb88aEAOOHYOymojFXHOXZJEor+mI=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10738189vsi.96.1544089277202; 
 Thu, 06 Dec 2018 01:41:17 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-4-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1544086559-47141-4-git-send-email-biju.das@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Dec 2018 10:41:04 +0100
Message-ID: <CAMuHMdWTwfRu-NQSf3GbhG=r64uAiq5OHSHix8v13d8TLB5esA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
To: Biju Das <biju.das@bp.renesas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_014128_621469_969BC9EB 
X-CRM114-Status: GOOD (  11.20  )
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
Cc: linux-rtc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
>
> The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> support enable the driver in the shmobile_defconfig multiplatform
> configuration.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
