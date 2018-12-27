Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FDE208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/ROCXgY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o+lsZIVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FDE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymBJsYViZBbUOHJwitpzIWh887ahUgKLxuq0rz03Ns0=; b=P/ROCXgYTLi5KM
	32OUKQZtApx5nyvuSLNT0AjBKJWHewZOszJSPi3pC8gib84/k+fXK2meB38YgxiCbOx03VsIh3eFv
	SA1ujqMUdKh8a6fp8FMkbJLJ7w4I5BedWWgJEcwxczb4OWIozN0XiJwLgbKMEvbUpRz73HF4uno63
	Bnr0R8BMiiu0w6BHlJnWhq491OBD8OrnPFnoZKLIuDrhKdPaFkH8tBbqtvD0eP8F2n86Vaur4x1/s
	d78k2RfVz7uosG8iTXX9oj9vuZnC/n8tJd37rSrIyjE7Q/LSUY6y9BKKe2Y7zlS+ARGqY0IfbewWr
	c4Pct/vKkmaKzFMrecXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcXTU-0001PM-Un; Thu, 27 Dec 2018 15:21:28 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcXTR-0001Oe-Dp
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 15:21:26 +0000
Received: by mail-pf1-x429.google.com with SMTP id y126so9273013pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h2EGYq8XTKqDNlssItDJr1D7HvVzviICZgcJkBUhouQ=;
 b=o+lsZIViOhVMBZaQmR9XX3L1dHn4EmbIWJalPCayhnKcnph0w5lZ/IAYbjQtdej+E1
 1Msmkxd9/iv3OtnGBCncNWYh/1FmvZrfnhmoETbKp1WhdfohCzcj6Tj04MDAxPmDj+Ll
 nm4steYkwKEhsT8KnAfiTssWcYV81zREG4S99JkH3bpyFNXGtHeEnV/4YpqOuyFj07N+
 aS1J+Tw6i+243o+B6sN7ixqhFJrRReVe8uIaLrK63g1hAR/dvZEzoesIV68JVtr2/YZl
 03lMrTpWc/m/O4KkXny6zjXaWjZNirxNs8i2AR5Jtc5Ju3o3moKPoFAgDkxnkqH4eNEI
 +teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h2EGYq8XTKqDNlssItDJr1D7HvVzviICZgcJkBUhouQ=;
 b=Ka0UjBHd17e5HC31wOuoMCwWkM1i2I2rZcPOliZ1zY43ouqKYtLIpcqbP8DuMgnXBM
 TSqHzNOJY9TtSTBN8ONrGEt9HO9ifLO1VzaSq2hdAivcuTzJ0CzUehYG+NIkvkb/q5b3
 Qm4rAVapKuMLQs0Rg8a6BGA90zM2gjDk+2Zk/NzV5Hx6lzicSe0T/Hm2MDuTxj9VhARZ
 emMUc2lK1sliX8v1c8RJlHtdH79H+6Lt+Miz3cTbdGeaaoYbxbgBAXffrFKa0VpF4Oiv
 Bq1Jo4C80kpPxUUMpCDtprFtZg2LA4V7erEwfwCJFqi0jpTiKpVJcUBLohq8KzhXmb35
 sYMg==
X-Gm-Message-State: AJcUukce7mcrnTB3BlaJWLN/Aewh3O2iVhMwXFu3XFiqRGan+F+7i3Hl
 LG3wPaytrvurdio7E/rvYTraVq0vu+E4k82iDRxl2A==
X-Google-Smtp-Source: ALg8bN6T8NvDJ2PBQQwHgBrKDWlnRFUo+0Y11//Bd7DA4F8zknOWe3sAFZQutsygcML14CuAp8P5ZBXhNq7w9Ap/5mU=
X-Received: by 2002:a63:9e58:: with SMTP id r24mr23625868pgo.264.1545924071964; 
 Thu, 27 Dec 2018 07:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20181226020550.63712-1-cai@lca.pw>
In-Reply-To: <20181226020550.63712-1-cai@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 27 Dec 2018 16:21:00 +0100
Message-ID: <CAAeHK+zj0LcjhcQFd4H9CfRbyzz8u+HuhA4-c-pjnDobkDGRJQ@mail.gmail.com>
Subject: Re: [PATCH -mmotm] arm64: skip kmemleak for KASAN again
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_072125_490488_5332F0EE 
X-CRM114-Status: GOOD (  15.69  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 26, 2018 at 3:06 AM Qian Cai <cai@lca.pw> wrote:
>
> Due to 871ac3d540f (kasan: initialize shadow to 0xff for tag-based
> mode), kmemleak is broken again with KASAN. It needs a similar fix
> from e55058c2983 (mm/memblock.c: skip kmemleak for kasan_init()).
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Hi Qian,

Sorry, didn't see your first kmemleak fix. I can merge this fix into
my series if I end up resending it.

In any case:

Acked-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  arch/arm64/mm/kasan_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 48d8f2fa0d14..4b55b15707a3 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -47,8 +47,7 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
>  {
>         void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
>                                                 __pa(MAX_DMA_ADDRESS),
> -                                               MEMBLOCK_ALLOC_ACCESSIBLE,
> -                                               node);
> +                                               MEMBLOCK_ALLOC_KASAN, node);
>         return __pa(p);
>  }
>
> --
> 2.17.2 (Apple Git-113)
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
