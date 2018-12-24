Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:46:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6069A21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NRa+5eXu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftYwLhId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6069A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0H9mpZc0pAAXDGX8MzJh3eaM7cNXVw0Re7Lzd5GSSg=; b=NRa+5eXuFvJ1ja
	manJksHsE4wo2gVPN4NKk1iELRo71vQ/MJmO6etNGRPoMIiieXSV3BfWbuSWAgqto8vQSdX1As5Oo
	mhBPL7pO2fC9PhGl65ROiuvcuDZYxKnKdH2zLi6U/AKbilWWvHP49Q/PLhaRFkHo8EkKq3A+OhLIJ
	JgiRhNq3LINiFOZ61iQiJ/9+zWoi4Pab2Po3ba1T9wcy+bpk3jktMkqhk/aAs2dI1TKCqB41FBsrg
	4hO5d+UwcjzjFIVXQ7N/JU+UptDqhwITTWS4GRmnRohJMDepNSSnhfWRMpE6qh3Gs9QLyTXTSzlFO
	t4z6FbwgvqBM9VWK7bag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbMoK-0002sP-Ly; Mon, 24 Dec 2018 09:46:08 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbMoH-0002rR-GC
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 09:46:07 +0000
Received: by mail-it1-x144.google.com with SMTP id g85so15277032ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=biCQmdDY24vx8InW8AEFkECihgQ9z4WjVvSJR8Vj0zs=;
 b=ftYwLhIdQHSyhEAJ2jnewLdWgM8NMMiTBvSAIB1GkTYC63mlapxqhYl4bawctj+p0p
 5vdAwdvT55MiaiEgQQhKd4xxHdHz4P6Qo8ZPsaZ8zUdwSjiIWaByFMSAECOedFnM1CDM
 pG397hIPimUfTmmictKc1yQlZmnK9AsEXSNfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=biCQmdDY24vx8InW8AEFkECihgQ9z4WjVvSJR8Vj0zs=;
 b=uGE0tybEPWgbjbeTij9n8KWhOEN2ExvlBJOp+xTsA84lfPw60xGKMCvvnkD8uRf+9I
 ngJBPsLL8RXkE3vqFYd5EZqvcWEyUyivLUu5CYwT5pq/KIzCOo/oaUi0ff1h1XiS8NC3
 ymDQA/79Gb77deimC4sN9egLxNHCAug3wvSY8XagYgfNpxwmLfvQjdeXtYKlJFY0yiUB
 sq3N++Af0m0JDwMqGGrofrWNdRUneW72DmetslSkf+72kAaAEll4CPF8uawZNidUO5dl
 idGVNh9EXezKh1qmIY1LuneJF28SNtfkCJO7wap0UMxSEA7kYpnkzAKZ8GpNTTUAp/ho
 oUVg==
X-Gm-Message-State: AA+aEWYQc3Dbe2bUop8RWiPqKuQjnIQrOMr42fCLv8wkOWjdirwaHsXr
 8jY6hOpSQus5jJ6eApPEAJz/lw01m5wVkEN8pgt4tQ==
X-Google-Smtp-Source: AFSGD/WXkibwPgHAsFsg03CQBE9XcTnTLxgKrY3m9mCMAS5q0DnFbArFXWind5omClKtQ4GM84HdItION/iBv1OFxzc=
X-Received: by 2002:a24:710:: with SMTP id f16mr7199968itf.121.1545644753637; 
 Mon, 24 Dec 2018 01:45:53 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 24 Dec 2018 10:45:42 +0100
Message-ID: <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To: Yueyi Li <liyueyi@live.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_014605_545991_F6E2EF49 
X-CRM114-Status: GOOD (  20.11  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "markus@oberhumer.com" <markus@oberhumer.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 24 Dec 2018 at 08:40, Yueyi Li <liyueyi@live.com> wrote:
>
> When KASLR enaled(CONFIG_RANDOMIZE_BASE=y), the top 4K virtual
> address have chance to be mapped to physical address, but which
> is expected to leave room for ERR_PTR.
>
> Also, it might cause some other warparound issue when somewhere
> use the last memory page but no overflow check. Such as the last
> page compressed by LZO:
>
> [ 2738.034508] Unable to handle kernel NULL pointer dereference at virtual address 00000009
> [ 2738.034515] Mem abort info:
> [ 2738.034518]   Exception class = DABT (current EL), IL = 32 bits
> [ 2738.034520]   SET = 0, FnV = 0
> [ 2738.034523]   EA = 0, S1PTW = 0
> [ 2738.034524]   FSC = 5
> [ 2738.034526] Data abort info:
> [ 2738.034528]   ISV = 0, ISS = 0x00000005
> [ 2738.034530]   CM = 0, WnR = 0
> [ 2738.034533] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffff94cee000
> [ 2738.034535] [0000000000000009] *pgd=0000000000000000, *pud=0000000000000000
> ...
> [ 2738.034592] pc : lzo1x_1_do_compress+0x198/0x610
> [ 2738.034595] lr : lzo1x_1_compress+0x98/0x3d8
> [ 2738.034597] sp : ffffff801caa3470 pstate : 00c00145
> [ 2738.034598] x29: ffffff801caa3500 x28: 0000000000001000
> [ 2738.034601] x27: 0000000000001000 x26: fffffffffffff000
> [ 2738.034604] x25: ffffffff4ebc0000 x24: 0000000000000000
> [ 2738.034607] x23: 000000000000004c x22: fffffffffffff7b8
> [ 2738.034610] x21: ffffffff2e2ee0b3 x20: ffffffff2e2ee0bb
> [ 2738.034612] x19: 0000000000000fcc x18: fffffffffffff84a
> [ 2738.034615] x17: 00000000801b03d6 x16: 0000000000000782
> [ 2738.034618] x15: ffffffff2e2ee0bf x14: fffffffffffffff0
> [ 2738.034620] x13: 000000000000000f x12: 0000000000000020
> [ 2738.034623] x11: 000000001824429d x10: ffffffffffffffec
> [ 2738.034626] x9 : 0000000000000009 x8 : 0000000000000000
> [ 2738.034628] x7 : 0000000000000868 x6 : 0000000000000434
> [ 2738.034631] x5 : ffffffff4ebc0000 x4 : 0000000000000000
> [ 2738.034633] x3 : ffffff801caa3510 x2 : ffffffff2e2ee000
> [ 2738.034636] x1 : 0000000000000000 x0 : fffffffffffff000
> ...
> [ 2738.034717] Process kworker/u16:1 (pid: 8705, stack limit = 0xffffff801caa0000)
> [ 2738.034720] Call trace:
> [ 2738.034722]  lzo1x_1_do_compress+0x198/0x610
> [ 2738.034725]  lzo_compress+0x48/0x88
> [ 2738.034729]  crypto_compress+0x14/0x20
> [ 2738.034733]  zcomp_compress+0x2c/0x38
> [ 2738.034736]  zram_bvec_rw+0x3d0/0x860
> [ 2738.034738]  zram_rw_page+0x88/0xe0
> [ 2738.034742]  bdev_write_page+0x70/0xc0
> [ 2738.034745]  __swap_writepage+0x58/0x3f8
> [ 2738.034747]  swap_writepage+0x40/0x50
> [ 2738.034750]  shrink_page_list+0x4fc/0xe58
> [ 2738.034753]  reclaim_pages_from_list+0xa0/0x150
> [ 2738.034756]  reclaim_pte_range+0x18c/0x1f8
> [ 2738.034759]  __walk_page_range+0xf8/0x1e0
> [ 2738.034762]  walk_page_range+0xf8/0x130
> [ 2738.034765]  reclaim_task_anon+0xcc/0x168
> [ 2738.034767]  swap_fn+0x438/0x668
> [ 2738.034771]  process_one_work+0x1fc/0x460
> [ 2738.034773]  worker_thread+0x2d0/0x478
> [ 2738.034775]  kthread+0x110/0x120
> [ 2738.034778]  ret_from_fork+0x10/0x18
> [ 2738.034781] Code: 3800167f 54ffffa8 d100066f 14000031 (b9400131)
> [ 2738.034784] ---[ end trace 9b5cca106f0e54d1 ]---
> [ 2738.035473] Kernel panic - not syncing: Fatal exception
>
> in = 0xfffffffffffff000
> in_len = 4096
> ip = x9 = 0x0000000000000009 overflowed.
>
> Always leave room the last size of ARM64_MEMSTART_ALIGN region
> in linear region.
>
> Signed-off-by: liyueyi <liyueyi@live.com>
> ---
>  arch/arm64/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 0340e45..20fe11e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -439,7 +439,8 @@ void __init arm64_memblock_init(void)
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 extern u16 memstart_offset_seed;
>                 u64 range = linear_region_size -
> -                           (memblock_end_of_DRAM() - memblock_start_of_DRAM());
> +                          (memblock_end_of_DRAM() - memblock_start_of_DRAM()) -
> +                          ARM64_MEMSTART_ALIGN;
>
>                 /*
>                  * If the size of the linear region exceeds, by a sufficient

Does the following change fix your issue as well?

index 9b432d9fcada..9dcf0ff75a11 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
                 * memory spans, randomize the linear region as well.
                 */
                if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-                       range = range / ARM64_MEMSTART_ALIGN + 1;
+                       range /= ARM64_MEMSTART_ALIGN;
                        memstart_addr -= ARM64_MEMSTART_ALIGN *
                                         ((range * memstart_offset_seed) >> 16);
                }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
