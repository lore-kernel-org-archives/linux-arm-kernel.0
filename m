Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B22C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:15:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EDC2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ld1sVody"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EDC2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DFPefSiP2dnb4bW3qHwy8v0zHoVbbKzWvH5G/PypyiA=; b=Ld1sVodyRAgGKm
	wLvOnRclfJL6f1FlGvSzZfRhtmJMHLgt7O4T/G/+C1Wjoz0JYOug1WZy8AS7OAI9wON05DdiY+Id8
	YAlOJIYhvlZi3RJwQqPEigguERzvx+HePA8fNFD+BPN57WFfqveXrMc02At/fFBw0kyxg4rxgYmAK
	oWUyXT5SnlVyPy7KSJmNNWy2tA3ZBsfsuJ4lJctqlFKKnnW2PNJ2l9XT0k+ZyMgw7nv35bMpqVYsJ
	CgGLeadUtqzzVJTaxPe5ifzoJqpxAFpMbCVLitC1SKOLC3WZUnlnIRLCcHUnDhh/1zd01drbO32lj
	GoEXgfr9RT6AqY/1MLbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8dW-0005yW-6Z; Mon, 28 Jan 2019 15:15:46 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8dT-0005yA-82
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:15:44 +0000
Received: by mail-vs1-f68.google.com with SMTP id b74so9907422vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uc6WoO2z+zsVLDXH5Em8MO6e3XxGu77yxdM3mgUPFZI=;
 b=ejC+Nw5dQYQfMC3CfF23joGzjdrgul2Kn7M2Xed3uUNcynMChkucAhre4Ig8g5t7su
 lNycSTz8zWqzCZSwfK28Roc3QVucTdHh9QR7G44GqvBI0gn+qt7zI9k0QDgDJIz4Ek+2
 weSB92moc6O79jGE3VWxSoEe2AbVuJZBwIyAWQ1JtTIaMWiX4mR6SYczd103ujBNubiN
 YYbTt4E/Hmlwn3szorHKGlkK6yqMkfGN9mOTMjndtojrj1nU3QxP4OYBjRuDQRhZASN0
 nqbNLySlOi6+lcEDSAbo5mJ0XBdqaC6zPZ29GhWp2pFg/Y+HjqevRS/EEvmdmlq+l7no
 fSwQ==
X-Gm-Message-State: AJcUukcxEMeQaLEmrnnP0HGlNZNri0pXzoNVPjmqPwyJy4Q49DzwwCKX
 jgYOi/G7UWXCHBMF/A1AAkb7zhs6pLgjdrDoVfI=
X-Google-Smtp-Source: ALg8bN6d9uiiQyk9jw6ePJt5Y/NpGdb12sk10RzXY3+u9ucnmZLkdbQ16LGJz14eLM7aKoce7NemZL0WK22duM8doG8=
X-Received: by 2002:a67:f43:: with SMTP id 64mr9127438vsp.166.1548688541740;
 Mon, 28 Jan 2019 07:15:41 -0800 (PST)
MIME-Version: 1.0
References: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
 <20190128140519.wfbnpgznbkx3msft@verge.net.au>
In-Reply-To: <20190128140519.wfbnpgznbkx3msft@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 16:15:30 +0100
Message-ID: <CAMuHMdW2j4e4yc2ZkeJ71uqGz7FS2Kb2141tyZp9y3zTrJ21_g@mail.gmail.com>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add OPPs table for cpu
 devices
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_071543_280328_12A7B7EE 
X-CRM114-Status: GOOD (  13.99  )
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

Hi Simon,

On Mon, Jan 28, 2019 at 3:05 PM Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jan 15, 2019 at 09:02:42PM +0900, Yoshihiro Kaneko wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch define OOP tables for all CPUs.
> > This allows CPUFreq to function.
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
>
> Thanks, I have tested CPUFreq with this tested that with this patch and
> "[PATCH] clk: renesas: r8a77990: Add Z2 clock"
> (https://patchwork.kernel.org/patch/10783723/) applied on top of
> renesas-devel-20190128-v5.0-rc4.
>
> Geert, or others, is it expected that z2 does not scale
> in this test?

Given your patch adds the Z2 clock as a fixed clock, this is expected ;-)

Note that the BSP adds this clock as a programmable clock of type
CLK_TYPE_GEN3_Z2.

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
