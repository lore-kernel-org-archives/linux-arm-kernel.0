Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C060AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:21:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA37206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OnCQ7DNC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyKmattx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA37206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=amMnxDa7nJ9KWg4nixA1JlpbNBZmTyFUKZSq6qruOhc=; b=OnCQ7DNCRB2Lvz
	QsBhYeUdtOIY78f1wbyjuip39pwYYsUTt4fYQ+nwkCcKODK5ZEYf1MXpaSRN2/zlL/VaUNFovPQ5K
	uZR1SF2rJzEIkE7hQ5VGNIgRK8ju92oqxpI9O1snuEGG14bADnCfHkZ2kjCYOAVzNHVG8B6UPvPxP
	onTR+peKeEJo9fvHRXDigI4AZwfrNT4cRXgPrfTHAyfYtAcVuZ5T988PYLf2PYhd2tLZl/Ac/tmSu
	5+HSxK0clLkDJso4RGy9eBx587jM4hsb0vaKYnnOYB0PelPOMnxwwYKzEf+EWPDTjziP174MqctM2
	PDlBvRd1QRikgysxPpgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxTV7-0002dm-7Z; Sat, 23 Feb 2019 09:21:41 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxTV3-0002dP-Gh
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 09:21:39 +0000
Received: by mail-it1-x142.google.com with SMTP id z131so6498742itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jO2yAy+2/DrGSuo8Mb/2diw4loSjrfq9Z9UTiFMxaQ4=;
 b=yyKmattxVj5pg78ekQ65pQNhpw1n5/CyCPH/x00PTR341Vd8ivampTF3P4iw326cyQ
 G/06KZbOriMDdU0Y3h4kMXA7Z44TAI/CPV4ykrEaNM0e1pdD0k8U2rRO6QGlhJiVndUY
 qtomCIF0tqD0YnytekB/4dO+WLfsJ4O4NH7q8w6+WVk+l+om+OSPXocHIipm83t5Fo6J
 YcTpOqvjSnPLBlWPrHAuBFmVq4SMpB3t0+j69BHsCTNJTXfw7J75qq5tn3QnedvcTzhR
 rfeq45QZif5Ivl2JrPmT5+3NADVgi6FPn74jxkQXfas9vrdmY88v6Lwxq3Nvaq7LgodR
 8KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jO2yAy+2/DrGSuo8Mb/2diw4loSjrfq9Z9UTiFMxaQ4=;
 b=CTs24B46q/yY31V3PWVYIHmWd3Ft9OhDdkxwOY6oHgtI5aqwvaL5kXs8DCR1UlvKor
 Gd5y+7DdOUD8B43Js6AYuvuUSo4o0LCD1swWoB6tbFMyCw24Wi8k5n9E36zTWxTGh7Ry
 xRq741ep1mWeInJwVZZ3a3wEQ5acQP3QnIgxaCKO4YVxlNjzHogIA3zkROkg229vpBX9
 8R58c/Pi7p/u6r26DeyvnxQVkk+Rq+CDeKiaQyKDJk35/Ifso4cQ4gwajj3Nmwp2aJZj
 13YvfS7zZ1xnu4Gz0JOPkkQrEraA3N3TSajIlnWwsjGFNxlIy6UKjVgOTp5GDpjiul9Z
 nXGA==
X-Gm-Message-State: AHQUAuaawFfgwUrk9Occ8npTH+vXMvfqz5FwLULwnakf596s8Gak2JPU
 joQkcSk/gTzHXINpznHjhunu8ARqxf6JyHtthwSVaQ==
X-Google-Smtp-Source: AHgI3IaRcsHtDW03uNXc2vPh39oKd8T5aDPBY3IdBwUmNcWxxEeVF+l9ASj0wvdJKSBzqwcHUcuQRRW74/hyja/uC0Y=
X-Received: by 2002:a02:3342:: with SMTP id k2mr4439773jak.62.1550913695492;
 Sat, 23 Feb 2019 01:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20190223065408.6279-1-ebiggers@kernel.org>
 <20190223065408.6279-2-ebiggers@kernel.org>
In-Reply-To: <20190223065408.6279-2-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 23 Feb 2019 10:21:22 +0100
Message-ID: <CAKv+Gu-4dwMsukX9jf9U0GfCOtd7cGfaRfSeJ+xL+4cqBAsDmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: arm64/chacha - fix chacha_4block_xor_neon()
 for big endian
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_012137_562687_558CD991 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 23 Feb 2019 at 07:54, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> The change to encrypt a fifth ChaCha block using scalar instructions
> caused the chacha20-neon, xchacha20-neon, and xchacha12-neon self-tests
> to start failing on big endian arm64 kernels.  The bug is that the
> keystream block produced in 32-bit scalar registers is directly XOR'd
> with the data words, which are loaded and stored in native endianness.
> Thus in big endian mode the data bytes end up XOR'd with the wrong
> bytes.  Fix it by byte-swapping the keystream words in big endian mode.
>
> Fixes: 2fe55987b262 ("crypto: arm64/chacha - use combined SIMD/ALU routine for more speed")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/crypto/chacha-neon-core.S | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/crypto/chacha-neon-core.S
> index 021bb9e9784b2..bfb80e10ff7b0 100644
> --- a/arch/arm64/crypto/chacha-neon-core.S
> +++ b/arch/arm64/crypto/chacha-neon-core.S
> @@ -532,6 +532,10 @@ ENTRY(chacha_4block_xor_neon)
>         add             v3.4s, v3.4s, v19.4s
>           add           a2, a2, w8
>           add           a3, a3, w9
> +CPU_BE(          rev           a0, a0          )
> +CPU_BE(          rev           a1, a1          )
> +CPU_BE(          rev           a2, a2          )
> +CPU_BE(          rev           a3, a3          )
>
>         ld4r            {v24.4s-v27.4s}, [x0], #16
>         ld4r            {v28.4s-v31.4s}, [x0]
> @@ -552,6 +556,10 @@ ENTRY(chacha_4block_xor_neon)
>         add             v7.4s, v7.4s, v23.4s
>           add           a6, a6, w8
>           add           a7, a7, w9
> +CPU_BE(          rev           a4, a4          )
> +CPU_BE(          rev           a5, a5          )
> +CPU_BE(          rev           a6, a6          )
> +CPU_BE(          rev           a7, a7          )
>
>         // x8[0-3] += s2[0]
>         // x9[0-3] += s2[1]
> @@ -569,6 +577,10 @@ ENTRY(chacha_4block_xor_neon)
>         add             v11.4s, v11.4s, v27.4s
>           add           a10, a10, w8
>           add           a11, a11, w9
> +CPU_BE(          rev           a8, a8          )
> +CPU_BE(          rev           a9, a9          )
> +CPU_BE(          rev           a10, a10        )
> +CPU_BE(          rev           a11, a11        )
>
>         // x12[0-3] += s3[0]
>         // x13[0-3] += s3[1]
> @@ -586,6 +598,10 @@ ENTRY(chacha_4block_xor_neon)
>         add             v15.4s, v15.4s, v31.4s
>           add           a14, a14, w8
>           add           a15, a15, w9
> +CPU_BE(          rev           a12, a12        )
> +CPU_BE(          rev           a13, a13        )
> +CPU_BE(          rev           a14, a14        )
> +CPU_BE(          rev           a15, a15        )
>
>         // interleave 32-bit words in state n, n+1
>           ldp           w6, w7, [x2], #64
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
