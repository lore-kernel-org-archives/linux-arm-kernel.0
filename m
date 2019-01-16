Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CC8205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fdrk7xTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CC8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PHNdRG0F/t36yUnlhrMB1iWOrLXpgq5r51+tYDeYoEI=; b=fdrk7xTUIMbhqH
	FztV0CrzTECMTrjE9Ic+Uf8EcAHTgyc8DMc4w7xNl2VUZSPdBsZGG28JUFxRL1KfIwpuXltmrJdtj
	1+1Q5Zo7MxyvhVfvkv7xlfAppZ7zPaUp6+gYk0g8rIcJ8eezmc1Kb1YbfoLb7AHwGtRRqnG5v/24p
	Qc5DCk+edySdKEUfUDCFsBgJrW9NI3CQ6ir24mi34Qma7xoZTN/EZtYbaJtDf/Ov/GreGiPrPg0ON
	01+4QlT8kqoapeD23v/uUkP2wLKGwzCQfpb9vXds+RqRcmBGbtl9Er7xa74KgTaai9ZrTjmVidFxT
	uwJrxNuMfVWwn1QXUlbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjm0i-0003J4-Ag; Wed, 16 Jan 2019 14:17:40 +0000
Received: from mail-vk1-f193.google.com ([209.85.221.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjm0e-0003IS-T2; Wed, 16 Jan 2019 14:17:38 +0000
Received: by mail-vk1-f193.google.com with SMTP id o130so1436169vke.10;
 Wed, 16 Jan 2019 06:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vUoQNGZurxEieeNNkZzDAFHiiSFH7qL1lJ5rxrPcqZQ=;
 b=WxxiG5G2rkW+yFvEbDtaXRkhkB1/uWR0HpeAqqTd72jkdUMy3OpegAsZ/5c7PnqCxd
 jfKk/IUw9l/QRnu1/xWVyy4iwpUeMdxXkpOaXufh3pLjCSgoLVUeXLaM/7iLonZ28uhl
 zxwLo2UUQHVJjKu5zHtlr55j+iACJIw3jLghJjRcOxYBfKDhX606lvG97nyvZcxen4aC
 EEIC/13QcC3fmQas6qPHqGg9mRyCVL32ODG8m4I/M6f+ICUyH3A2AsMZFH+NRnzUu2KN
 78FdXzLXAC6VvRV2b12/u2xbPuG6017X1OXmAsasrNb0JrkteSDibh7aaJ2U//w615lz
 dDQg==
X-Gm-Message-State: AJcUukd+HaZWRNbNvQliZFt/MsOcRtJ1sTmUXm7QdH7Fd9hcXLCFnR94
 DAEOlC7lr2KL5hhjM+LqOTB/roWoVSCL6k5i9G4=
X-Google-Smtp-Source: ALg8bN5i1YrhP7vEzWfAblym8WHD9rDPmIjtAsXIX2+EXB6htxAQHG2ya7Av+N0ySlQVktSH89EOjOgISmgR9ezPUnY=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr3570847vkd.74.1547648254958; 
 Wed, 16 Jan 2019 06:17:34 -0800 (PST)
MIME-Version: 1.0
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-14-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-14-git-send-email-rppt@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Jan 2019 15:17:22 +0100
Message-ID: <CAMuHMdXt8fPgAGp3KPGM=qVT_QzU=FJS7f5XUbK2hGXYdE9Yeg@mail.gmail.com>
Subject: Re: [PATCH 13/21] arch: don't memset(0) memory returned by
 memblock_alloc()
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_061736_937641_1CFAA072 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Greg Ungerer <gerg@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 alpha <linux-alpha@vger.kernel.org>, linux-um@lists.infradead.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Openrisc <openrisc@lists.librecores.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 2:45 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> memblock_alloc() already clears the allocated memory, no point in doing it
> twice.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

>  arch/m68k/mm/mcfmmu.c       | 1 -

For m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -44,7 +44,6 @@ void __init paging_init(void)
>         int i;
>
>         empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> -       memset((void *) empty_zero_page, 0, PAGE_SIZE);
>
>         pg_dir = swapper_pg_dir;
>         memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));

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
