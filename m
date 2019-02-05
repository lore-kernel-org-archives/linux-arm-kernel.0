Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88291C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:08:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E5B2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QU5xDFfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E5B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kC+7VbycTvVhqv5acBA+N4YIBazQf9lv6PG+FMVEfHI=; b=QU5xDFflyX/IB2
	3RE40ef+cZsVG3z1XYwH4chpzs/nUxI79cjiAyrhASzScrZZoMz5GUIZzxg6nmdmYZadC2YOGJ60t
	jwCF5rwIIpMEkz1yb7cSdReKNuQ7Aaq3qKZESnwFtyTPviBcfFJu9sZLT1iyHOqmsquq88gD7L4Zr
	l3bWpSIbjSSf6pNWWKFApWaPpKZUlwyN2OjkcWjTy0p1ltOp3RE5MaHxpdT9SZV7n1sKWLaqELRzM
	iRwGNGOow/y9rFY5ua/qRaHGVFebXVOXyy4DQ8P7MNM5hmdsT3fi8XJFu2URpLZC8i5cOk6WogDMK
	mntSe2tnHY8CEIIc9uyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqvlv-0005Hi-3N; Tue, 05 Feb 2019 08:07:59 +0000
Received: from mail-vk1-f193.google.com ([209.85.221.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvlq-0005HB-QA
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:07:56 +0000
Received: by mail-vk1-f193.google.com with SMTP id b18so596211vke.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cRvAok8cVR4j5IWXvcjRierjeBluHIjTZklI0Dbx52c=;
 b=MDNtSwDqkLUUQ7gwl8yEzND79v6cZ0RRnNPvFRdej1ecr3JPiBqy7kmvVEvBVoyeGY
 s5FaVOWvp8eCqLbzHfoIOFCQwKW4sO/NqVJH0+w0vN7a+h0OMtB1Z15TC3rAqKiHK6tY
 tXhvXD6QwTI3ehQPpFoH465CCIKxnh+ql/BFVO/VR+Thu6t3zsAk4Y9euv2V9dzCGZj2
 Alh5WzwKltLZywc5Ns6yAv9DsOUwPxF85B7tkV4Q5vXuqt0cqLUVPyHezgH541mjfXtg
 5pB4fphLjfjVVOBU0DgUqTBA4hKoPEohEfbEMLub2Xzb2JyvDJkwFDQzAhZ62vzperBP
 SbfA==
X-Gm-Message-State: AHQUAubERVDRYpq4BPfMTPDRDUWxbG1/3Xu9iUPeqSntXNPXFO5aQtuh
 +q9vJRV0q0LybdUQA1syyKR83gOl5raq7suDg4k=
X-Google-Smtp-Source: AHgI3IZgpXY9j0Q2VhQGYeX4gI27vKFpwqAS7C93WP1K4q4Nm68Agm3x4fB3yyRVC3kqj5su/Dm9SkJgEFgCtfAo3Gc=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr1427585vke.83.1549354070886; 
 Tue, 05 Feb 2019 00:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20190204203747.7376-1-tony@atomide.com>
In-Reply-To: <20190204203747.7376-1-tony@atomide.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Feb 2019 09:07:38 +0100
Message-ID: <CAMuHMdXFF938VWh5F8016nJs4mE4m-xbU1kuqZuX1BFdtFejgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_000754_852580_3EC25B11 
X-CRM114-Status: GOOD (  12.05  )
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
 Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>,
 Simon Horman <horms+renesas@verge.net.au>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On Mon, Feb 4, 2019 at 9:37 PM Tony Lindgren <tony@atomide.com> wrote:
> These are automatically selected with make multi_v7_defconfig,
> except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Thanks, this matches similar changes to shmobile_defconfig in commit
4162325afd0d553c ("ARM: shmobile: defconfig: Refresh for v5.0-rc1")
in next.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

I didn't update multi_v7_defconfig to avoid conflicts.
IMHO the arm-soc maintainers should handle the refresh of the common
config on a regular basis[*].

[*] When is the right time? I'd say it should be the last commit just
    before the release of rc1 (so all arm-soc submaintainers' trees will
    have the new base in their for-next branches for the next merge
    window), but that may be difficult to implement.

What do you think? Thanks!

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
