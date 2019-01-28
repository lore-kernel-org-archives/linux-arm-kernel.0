Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56929C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:12:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278B32087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mcgM7cCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278B32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6OzUBmd5eU2wSqL85g1GgriO8bnnTv0j3w0J+5vQhm8=; b=mcgM7cClFzwhPe
	2TQPOC9WO+pWdWNERJsNqP8eWVdAYJVSptu1wwb/jUHl8ht5Dy8n5mguWQOX1AlCT6knSZZTK7e3f
	5gsD0lcHPZ6NYmHRNjHCrBpj5BneTenvGigQ3nBxFZ3NvcJ9UXMYMjBZKTA0vm7NyY17qqgaTj6l/
	Isk0e2888OBt0dCQwp9RR6WMLQgLRpv3uBAKkaoSlp6wc4bftboRVIZZ3TQ64Ce1wi8BReKq4E/kG
	Z1LgulF85OzaOLEdOL4Zu3cNb/KVOfYMPFDgKt8qVdJ4kO1wLtoji0Qvg1iPvPcHJgX7JRBCFdhr2
	jeoqdwLTVxTzTQafaoUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8aD-0004CU-M8; Mon, 28 Jan 2019 15:12:21 +0000
Received: from mail-vk1-f196.google.com ([209.85.221.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8a9-0004C2-C6
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:12:18 +0000
Received: by mail-vk1-f196.google.com with SMTP id d201so3747428vka.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LaWS8/GqOJCLlErkAfmP5eHLZl/bb5Pi4EzVD6jxTw=;
 b=oVa3JkDEJyuFollBreAGorhiHNT+Ap9AK7/6xjmBTflcARIMjEa4Sx1pRYzshNNkuF
 hXXxEStf8ZAOfFAbXjpggDN6g+SdwbX68YGbkAPUpwM/NNRB9R8rbqbgm0kK+S8KdHrr
 CQPswOFztPTorqvVnyVfo/Lz7TZehLM5nymyEPXMOMe+4/vP7lEaIEBTK44wyfEPxw4j
 JUHR0FyFmZLah22Di5J1fqoPzoi4rrRppxiYjIbya7Zf8qEH+c66orRXVFhhzFR7hrsv
 lLLoxwEfvY0rdjztY9wrd31ZUnM2DKdfG3WuJwwOHP7PenG/C0Qn1BI6BRtZX12VkJKh
 /O5Q==
X-Gm-Message-State: AJcUukeuBwxLyFEvm/2+3E51blSsu9Z+gwRqph3/gF63w5rnwPzhHFI3
 H3Ih+SQTWglw6UEzL0O2d85PqHcOz+YiYiBuq3k=
X-Google-Smtp-Source: ALg8bN5yROmhXfPl7gRLbLk9EES4WA3XqV1vZdAs2oaqKJc7zluJex0FhoY/1eaFa2d/jbufrM/3P6v6wd2CtGXjZ2o=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr8846220vkd.74.1548688335910; 
 Mon, 28 Jan 2019 07:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20190128140127.17540-1-horms+renesas@verge.net.au>
In-Reply-To: <20190128140127.17540-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 16:12:03 +0100
Message-ID: <CAMuHMdUw6WjkykiCwK6_SYt+ktF-DkU+jczuoLuRh0-fKpVNwA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a77990: Add Z2 clock
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_071217_441904_4AE7ED83 
X-CRM114-Status: GOOD (  10.79  )
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
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Mon, Jan 28, 2019 at 3:01 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> Adds Z2 clock to CPG driver for the R-Car E3 (r8a77990) SoC.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for your patch!

> --- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
> @@ -79,6 +79,7 @@ static const struct cpg_core_clk r8a77990_core_clks[] __initconst = {
>         DEF_RATE(".oco",       CLK_OCO,            8 * 1000 * 1000),
>
>         /* Core Clock Outputs */
> +       DEF_FIXED("z2",        R8A77990_CLK_Z2,    CLK_PLL0D4,     1, 1),

According to R-Car Gen3 Hardware User's Manual rev. 1.50, the SYS-CPU
Divider 2 is controlled through the Z2FC bit field in the Frequency
Control Register C. So it is not a fixed clock, unlike on R-Car D3.

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
