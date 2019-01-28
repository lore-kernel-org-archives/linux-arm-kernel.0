Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E293C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:47:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8DB217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNk+/0KA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr7YbwxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8DB217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjKNnhYJCpoEmkaVhOyRjI26U/uzcKwee/GBi7wOs0I=; b=gNk+/0KAX/eFKe
	jRkoqz+8ocFeXSbkLFyQglbVOhjlEsqllATt09KwRLi31MvXTPt8tM/Ich5Y+uQ2By611ZCt8gGai
	noG6f5vTUZrBekw7Wj4he8JijsuUQ92ateOrq0oNb1xrNVMNDxV8VrGksOP9IBrfA6OTgYivcaU+l
	Zlev97MikMBHBsxAtoiSUWohZmcR+2C6a63hmgNrDEyFK6kJV4Pbln9COFgkDgU5sFnsWQoZTTqQf
	uekhwjzTWEjid0GlWTkE7B5b2/rKJU3HVV8klFufpUvLoRaU9jl3E/mZ6q3u3RzMPTGe+Qg32Ut2F
	9i0U+2Fk4riVygYGsoOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3WA-00063G-NG; Mon, 28 Jan 2019 09:47:50 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3W7-00062t-Cw
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:47:48 +0000
Received: by mail-it1-x141.google.com with SMTP id h193so18399183ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gz6fwVIRsxJfsOehR9yV1xWPf5L1hiXx7mCwXlUn5aw=;
 b=fr7YbwxA+p9V02m6/1Xp9iCDXa/wrxnxGPmnmIkaeHzsJizMK8LEoFp0H73ZNED6TD
 m5VkVC2XZn5XyDK4THCwcSkVVxVmrzJjtZw5+rZbmYbk3z3ev9kG44jmB5cP/j8+K1zq
 tBI4yiKBQJ/ROZXZnoQ7vMJLagzcbOebr0gRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gz6fwVIRsxJfsOehR9yV1xWPf5L1hiXx7mCwXlUn5aw=;
 b=KoXsQsOz9l9FDbMqmdP/shdEU6uaVa2vPL12y62EP598loMwv/uLFk/i6bIJrFVSRo
 GnK5yAL3Mwi0J1gx+DRu/xhxk0xQkc/R9BfUOI6TwaOrlOi2CIKyWzNuJVn6k1mWzgF5
 Y/4rlULTWzjMesBS8c3RL5e7TIGuh4Sg4OA07xXUtc5R7CTjW37UrPji3ZstkM2YXVZT
 kpVdPR2SSDXFm3pflZ85zQo9kIL0kIxJ4cSCd3UsNpcxxaI4P1rQo0MFv2loBnwfV/1I
 mK0IsDklgDfuhMoSmUkqcKbGPT53Bh+esbcdzsijqlqO9SQkxwiFn8wTRvxK/LoSerJ8
 98mg==
X-Gm-Message-State: AJcUukd+Qpmbx8cF0b3k5juaYcc5W3dHAH2nGgnxaLZu31RRG9itEDZQ
 3iFmcRopiXz6r8tGj97qg6ReOjVCzX5lZejNWu8Ulg==
X-Google-Smtp-Source: ALg8bN6R0t9GRKAkWYSI3Fkn0a0Hqexktd9d4flkWuliD5xlvycf6eT+r3gw/FrvyAFXwDj6y01PPtlj2b3yPYHIAFk=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr10893163ith.158.1548668865574; 
 Mon, 28 Jan 2019 01:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20190128085045.6504-1-ebiggers@kernel.org>
In-Reply-To: <20190128085045.6504-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 28 Jan 2019 10:47:34 +0100
Message-ID: <CAKv+Gu_nbKYOvcUxruv00ZBkrCOb3eED-=xw=5nna8sBCuQg4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] crypto: crct10dif assembly cleanup and optimizations
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_014747_436669_D74E2F5F 
X-CRM114-Status: GOOD (  13.93  )
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
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 09:57, Eric Biggers <ebiggers@kernel.org> wrote:
>
> The x86, arm, and arm64 asm implementations of crct10dif are very
> difficult to understand partly because many of the comments, labels, and
> macros are named incorrectly: the lengths mentioned are usually off by a
> factor of two from the actual code.  Many other things are unnecessarily
> convoluted as well, e.g. there are many more fold constants than
> actually needed and some aren't fully reduced.
>
> This series therefore cleans up all these implementations to be much
> more maintainable.  I also made some small optimizations where I saw
> opportunities, resulting in slightly better performance.
>

Wonderful, thanks for doing this Eric.

When I ported the code from x86, I noticed that the comments were out
of sync with the code, but I wasn't aware of the other issues at all.

Assuming the new code passes your extended tests,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

for the series, but with one minor nit for the ARM version: could we
please move the literal pool to .rodata as we did for the arm64
version?



> This is based on top of the pending patches from Ard Biesheuvel.
>
> Eric Biggers (3):
>   crypto: x86/crct10dif-pcl - cleanup and optimizations
>   crypto: arm/crct10dif-ce - cleanup and optimizations
>   crypto: arm64/crct10dif-ce - cleanup and optimizations
>
>  arch/arm/crypto/crct10dif-ce-core.S     | 546 +++++++--------
>  arch/arm/crypto/crct10dif-ce-glue.c     |   2 +-
>  arch/arm64/crypto/crct10dif-ce-core.S   | 496 +++++++-------
>  arch/arm64/crypto/crct10dif-ce-glue.c   |   4 +-
>  arch/x86/crypto/crct10dif-pcl-asm_64.S  | 848 +++++++++---------------
>  arch/x86/crypto/crct10dif-pclmul_glue.c |   3 +-
>  6 files changed, 794 insertions(+), 1105 deletions(-)
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
