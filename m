Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1892082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oro+A45A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1892082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RJ1/xTLXoaS1VmBDYtUF5+NVB5p4HLSUW5XuvrQN5BQ=; b=oro+A45A11W39D
	Ykkt+melT4mc9C6F1/WzzhHaAURZQjYuAIYSm73q3cnvrSJhtU/Dif7+V67uw22R+hpIxmKi2os7X
	1YTZFk3Z5uOzIiedrNqKbSAkxLKr/W1vVNCQInuFamPqjQJerkGHqxSTtAA0RWD8nLPfFBZ9cgDHV
	iHseRlBDNn63prTR5HyVUCQ1Jz/u8Ntyx4UYidAf4qNp91nh9uyo5dsiHDiM57IY+fuBpz7SQv0qS
	pQfOEkqSM5bQlNPRpPiMGD/2JQWUYdO5epyAj3YBi2UNXCnSpqbZzMnbApvp0rYOsj+Uq/44A0xwp
	xF2sRzHv+C5IS9fo8RJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgBH-0004eY-4C; Tue, 11 Dec 2018 11:26:27 +0000
Received: from mail-vk1-f193.google.com ([209.85.221.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWgBD-0004dH-7d
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:26:24 +0000
Received: by mail-vk1-f193.google.com with SMTP id j23so3279443vke.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 03:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bf/xfMLnPgwfdBxQ4RuQti2tz7jqx0xRV3g44stcn08=;
 b=NdlzlwxtsiyCTSp70gUoI2RvN4bLzKpzRHyTdggfQ+9WbGnwNNtbqrPlnZxyI2T0lM
 LV5m94OEIjdavvlyUk7G//MfFGi9RpF2jKznolQbjm1B/irE5SzHstXatB1YTDBPhzAW
 +X7uVux9sKNVCHl4IODKsCw6qnp9ZsSu3i+K5NACAkWXT24JcybPGjn8AS/0wAmDB0kQ
 LHdhEE9xlcBhGExeoFXSguo92PPIZBAisKEjF+MTUmg7CoN4uFN7/i1eUAAaEk/I7yGo
 J5qHy4QOTrjD2Stuw/V0yUNwBM7hHl9trvYlirIGo9GyrE3pIjnQ7GmP0w3rFp7jtSSN
 EQTw==
X-Gm-Message-State: AA+aEWa3xdiXidXcWy9kMvLpVSLiN7xmJOrJzEgU7Q/dQkhJH9OxQyHS
 /2OSogKXXblhZza/YXslk5jtBX6ZCarS7MBSC0E=
X-Google-Smtp-Source: AFSGD/UHQs1zy9VFoF1TIVb6Z7dyhfGZi6LYpYu5LTPfY1/qTJFcQc11Frd5/y5mXeFy+BQF/xypd2jY+AWsTvUAH30=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr6969031vkd.74.1544527571326; 
 Tue, 11 Dec 2018 03:26:11 -0800 (PST)
MIME-Version: 1.0
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Dec 2018 12:25:59 +0100
Message-ID: <CAMuHMdUcyzoMkiu-XaD5hM3uxhh+G3wMWWkVrFRNBkv5GbDGmA@mail.gmail.com>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files with
 double quotes
To: Masahiro Yamada <yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_032623_271527_B6E2ED5C 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Ulf Magnusson <ulfalizer@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "David S. Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 12:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
>
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
>
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
>
> Make it treewide consistent now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

>  arch/m68k/Kconfig            |  6 +++---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
