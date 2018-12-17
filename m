Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1408920874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IcTs9U3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YtdsLlCOYw2tTZQ5dtFd0wY0b1eT2FO63k5rLEu3uWs=; b=IcTs9U3oXNz8wR
	Q64s7GS5BkzzzfzgF8cgmZ+G8gGrge/pbdvKJB0Vk+hr/p11kVNiFwdZ9lRMqgO+kBYVaE7CWBS8/
	coQUsFrsFo3oYrrmbluN6AHyMTKUjdIsJtlH7+01kudc6QhK+r4Dl5bj9o4LoTGNPgFdYjQGAC2Lx
	GQq0tXhOsjLuKDw4Yg3CYYfHuxUkSMvwU5LAg6EchQfvbUlK9C/DSL6qtL7m09YnTYsntiDlPVKRc
	IYSoLHmsgh+zH2hx7cxS2kzMYNqKb3MbRt4VoBgtpDqJejRtPNxwauWEVXliotv6L+kc8AMdHgf9z
	QzI7YOsyJCdwEF/8/+cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtoa-0006At-Iv; Mon, 17 Dec 2018 14:24:12 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtoG-0005mk-Lc
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:24:10 +0000
Received: by mail-vs1-f68.google.com with SMTP id h18so7783337vsj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 06:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uWFdQGsWAwEpmwz3etang4qa/q2f5u7avcygfgA48Ms=;
 b=qgy9o1MASoPyorZV0oWgC7tmCzv1+iAuLxiAqxxDC4xJrOkix6e/DPBz1C0fRaIlF/
 ahHEead0qGe0G55PuLRzWepSjYv5E1l6C5NcwDgaqhTKoIoB4eUkyzfMPPPBOLjSYSGt
 +cReX+hrZvfaVKHMqOney3ZX+RvTn2VZ2yDkjESbQrRRvtbQVBaueDQUnZZ63E+Q5gvZ
 M1GWyVSnLiq1qBexsFR7ORFdafY+VHz3bIk9qRvYHwKO0BuGCI/7Tf1XHYHy5nuodW3u
 wDESCPB7MJSb+i890cy5QrQjejLJ23t56ut7/EyTeT+3/3b/Dqhc3myYn5aroSJoJPIe
 QV4A==
X-Gm-Message-State: AA+aEWY+GYdWJp8uKIQfG5sgvKc/LMdOSRqhLynAk0pFoenS1mA9ZOtS
 wDt7B2L77F0DWgOdKAxyb8S6cG8iqMhP6rM2KLU=
X-Google-Smtp-Source: AFSGD/W+IsBbGcf5VWlHEb1L7HVzKePKnrZagSaCvPJToYeAq5KpMMGWeNf7EzHT83Nqu2IiSyU+E50jVm4wZUizrAg=
X-Received: by 2002:a67:c202:: with SMTP id i2mr5880105vsj.11.1545056620259;
 Mon, 17 Dec 2018 06:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20181212105435.28310-1-horms+renesas@verge.net.au>
In-Reply-To: <20181212105435.28310-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Dec 2018 15:23:27 +0100
Message-ID: <CAMuHMdVoJSxOJ4X1_nF8qG-g9EgCYLKUhuqHyJ65J3rjhiqq7w@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Add missing dts files to MAINTAINERS
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_062353_810320_A8997617 
X-CRM114-Status: GOOD (  12.92  )
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
 Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Wed, Dec 12, 2018 at 11:55 AM Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add some more patterns to the ARM/SHMOBILE ARM ARCHITECTURE
> section of MAINTAINERS to complete the list of maintained dts files.
>
> As of writing dts files covered are:
> * arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
> * arch/arm/boot/dts/iwg20d-q7-common.dtsi
> * arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2075,6 +2075,8 @@ Q:        http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
>  S:     Supported
>  F:     arch/arm/boot/dts/emev2*
> +F:     arch/arm/boot/dts/gr-peach*
> +F:     arch/arm/boot/dts/iwg20d-q7*

I had hoped to make this more future-proof by shortening the string, but
apparently there are non-Renesas iwg2* boards.

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
