Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D084C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE85F206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BI92zGaN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixwMxwKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE85F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jPql1gvzB6f2HCY9J9DO3tdMyrDgRRlyVhfO7Cw4WYk=; b=BI92zGaNi2Q4sY
	l2e+lyBOehd22Ew2h0a2U/+hWphOk3/nZjWdyLXUZsUDOZAOFn5QdHzKjsoD9mpeZ3fRseAPXOxSp
	t8ba1H6of1qbU6OslzT6yMYWi5hA50oAaoMZ6GwH1CXkyge+1RKS+XbRcpfIs2Me9L7GBEASAL3PN
	so2r644/4k48WI2DuFrdYOqhLXTabbLikcNVbta+WRdvT/tZWBtutmX2gol/2AQFDHVws7zypV+mO
	OXB+2aidYy547UBtguWEIcb28ClvF0CePPjancyj+qTVQnHEV/Gd6q+oxhI9sq4ZgUSPfkSuUs1sh
	lofgTKVEe3soHZ5h4rqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxTXq-000312-Mx; Sat, 23 Feb 2019 09:24:30 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxTXn-00030J-PM
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 09:24:29 +0000
Received: by mail-io1-xd42.google.com with SMTP id e186so3811640ioa.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5GEK9T81wP2kkW0fGPs84l3c71v8YZl8ebkkAOY+AUg=;
 b=ixwMxwKjOA02jOAfKReQH+U5dJf/7Bmtwf3QJaS+JfgRgYPnSWd5rEmC/uXwj2AYMk
 rs6WjAxjqWUcRnYQ3aJQwfS6XDolm1/HJ0QMKQgWAsoxsXjD3INaSmPG6W+FBEZh3GHR
 iLEb3JvdCg+cj5xo1eu+ew9JvCx3XyMVvLh+uYNOpKOMN77gpTaOn4gQK3FJuIdh6xeP
 bYEJGvxIRRVEQOtSim17Pgc6VMH0MlTsesDvi36k5ju7kEtGEckI/s2lDfkHS3NzPpwF
 T2YKr/R0h1D439jYfUHew7HaQWOb00Yz1tCOjmNU6ClDFvs9HfpolhOGME1KCw3Qd/D1
 VUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5GEK9T81wP2kkW0fGPs84l3c71v8YZl8ebkkAOY+AUg=;
 b=Hj6hWToChCfvOF0ZoM4R69jsN0woeMQrKAAPihs8bhC5e8OnD6hlABvflHxOcqQYvT
 8dYDAMEGfxtYveMAZJLtiZexV1/n2t0taAjXgaSQ4mmGGT7RLaiKGSi43z1IK9yRAUds
 HvQYxGDgqpM9k+tOd7dW7YxVljtj/EMAS6CNsilxJXSzPW0F+lfWq24fqK95uR+KjBTD
 V6wJ8T2gN0YC/eJXKMwdAC+yqleluT8niruYQ016V7YJYtQTG4igWq1FzUDHoaGaYuvl
 qaJ42GSQnf84l5GfZYAqI70oflE9LZ9v0FuuBjxSVDih9lHbJxFmWN8GGASxxdVOUHUU
 vVjw==
X-Gm-Message-State: AHQUAuaimpVH/O7DcOQv7RUF0U3zca/u63hfaHz4APK/WR/rjtPGMY3r
 0jGsO4wM+ItD1+wX5IDx3UsBGFVcFVXNdxd0b1nxow==
X-Google-Smtp-Source: AHgI3IYioZEEo5dn3jF15pSfs4EhC5bMFtq0C3+fDzEYnTq5fNsnlhhErGYj6uKxNsjXoUV9gFrOfFC5rQ+QUsxPgto=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr4457196iom.170.1550913866814; 
 Sat, 23 Feb 2019 01:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20190223065408.6279-1-ebiggers@kernel.org>
 <20190223065408.6279-3-ebiggers@kernel.org>
In-Reply-To: <20190223065408.6279-3-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 23 Feb 2019 10:24:15 +0100
Message-ID: <CAKv+Gu99nQc-eoOu4=Vxzmc0ypYecYhSThmsr3gu4T84tYStOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: arm64/chacha - fix hchacha_block_neon() for
 big endian
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_012427_826896_2DFEA486 
X-CRM114-Status: GOOD (  13.60  )
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
> On big endian arm64 kernels, the xchacha20-neon and xchacha12-neon
> self-tests fail because hchacha_block_neon() outputs little endian words
> but the C code expects native endianness.  Fix it to output the words in
> native endianness (which also makes it match the arm32 version).
>
> Fixes: cc7cf991e9eb ("crypto: arm64/chacha20 - add XChaCha20 support")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/crypto/chacha-neon-core.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/crypto/chacha-neon-core.S
> index bfb80e10ff7b0..706c4e10e9e29 100644
> --- a/arch/arm64/crypto/chacha-neon-core.S
> +++ b/arch/arm64/crypto/chacha-neon-core.S
> @@ -158,8 +158,8 @@ ENTRY(hchacha_block_neon)
>         mov             w3, w2
>         bl              chacha_permute
>
> -       st1             {v0.16b}, [x1], #16
> -       st1             {v3.16b}, [x1]
> +       st1             {v0.4s}, [x1], #16
> +       st1             {v3.4s}, [x1]
>
>         ldp             x29, x30, [sp], #16
>         ret
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
