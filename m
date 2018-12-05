Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5958D2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MRQP1Dbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5958D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q2htn3NpP1oCBAgkIstjVxrdE7iDN5rrVTsbPjqRQS0=; b=MRQP1DbkCGUSqU
	yaMh0K7P6W5ziFfB8uHii6vZ4jyzQ4GSyM/MgbNDRnvLL2ERScdliVNTWsn1eICjEw/N1nOALA357
	fwFxIDyNe0Vc5WGCECmBuqp0BVmDFioz//ethzok0/bO8T5LzjklcmZcKcxCxrgDAojjApzBpJ9Xn
	7HRhGNcas/duK5qFLVAf0+vhJLw4kY3P24BbnNSJ3zKaz89+wVr6dWVbClvMw0DKzZpKuXKAJVqIO
	jtma9FmMYRmQVkFhI/WidWUaDY2NWt6AP8SX8raTbbuKJCQwpsZaYAFZDsRcmyNL1Jc0grG39yNXp
	9xF6jckb9avZrRYPlFcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeXi-0003NP-4s; Wed, 05 Dec 2018 21:17:14 +0000
Received: from mail-vk1-f193.google.com ([209.85.221.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeXe-0003M3-2f
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:17:11 +0000
Received: by mail-vk1-f193.google.com with SMTP id h128so5008978vkg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 13:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nl7XcfIC4sMSc62XFiJfb2fGk4rPANIAbywtAgNoQLY=;
 b=ufWftTg4V658Fsst9VoUHL4GNODPq0L4sleR/OIMi2jk3sokKggdl+rtlWO2n7sN62
 YqGL3Bv2Bk397k3MwgrltjoI03borQsopfH7ssuVs4dcemGYxNUO6fNiNoGBK7QQmhm5
 rOc4lnNgvOojx2spKjUj14OYVNpMZddtN7sM1S5wWLj/z+j375WnPiZ5IR1c7YI5qsGJ
 eY6Z1QIZCP5S+BPKh6wu3TVvhewn3hH6up9GST+5xNnpqF4iTwVl9YsPgRR8w5MlojK+
 oX21b/2kBv68HWHn886kICgSxieBw/D/OHT7WqshDim+8dHvAeMSdtsosfes/wxFCylj
 PG4A==
X-Gm-Message-State: AA+aEWaIUkJGReRyQyp9UePR6n1ysGAMiViHVmvHbA29hE2SabAFZMY1
 Fiwt7IByvOmX2dJAWBnTrr80L2G7kbd+2T5Z6lY=
X-Google-Smtp-Source: AFSGD/UNpaFGrXvfudSYUZpWytqDI5tXModQycfjePV8xl7ilPxyQXqOba1QU35r8mArxbB+p9MUU4rBbuk0bFYtSws=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr11617161vkh.65.1544044618144; 
 Wed, 05 Dec 2018 13:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-5-robh@kernel.org>
In-Reply-To: <20181205195050.4759-5-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Dec 2018 22:16:45 +0100
Message-ID: <CAMuHMdXqww7c26SAc52b8Uum5cUfYm9dQEkQ3SYmhgCDOSn_xQ@mail.gmail.com>
Subject: Re: [PATCH] clk: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_131710_119745_CF95B8B1 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 8:50 PM Rob Herring <robh@kernel.org> wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/clk/renesas/clk-mstp.c   |  2 +-
>  drivers/clk/ti/clkctrl.c         |  2 +-
>  drivers/clk/ti/dpll.c            |  2 +-
>  drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
>  4 files changed, 8 insertions(+), 8 deletions(-)

For drivers/clk/renesas/clk-mstp.c :
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
