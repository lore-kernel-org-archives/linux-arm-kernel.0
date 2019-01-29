Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA3C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F45720880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTHxZ8h4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9Q4+/+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F45720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cSJUlr6wbVU/sNTnhK+DfB4CnEL8JTgaD295g5Gj41o=; b=GTHxZ8h4AE6JpP
	FjVVC/pqsoQJlPyQgjSisXjGkATPqKblZTTw58AvdMPLbS2pNRVmJgLm1rvPu5rhMC7k9eFI6nwIx
	abEiQkK4PkiC3oM6kJz5S8uF3EB9AdTWO+AltV3v1R6NPN7MHVUPnUUa61CRn8x2xAGzkvTlORomP
	jz4DdtfA9P42nI9RvyBEzNvvJKNCn4SRqN9m9wOljUIVkYIh0+0EXT6O123Io3/XpOtemuMLSMMXn
	E5nVBsYz0890SW3kTR6kRomTu1JjEZjnNS6gRkK/YlIt8nZclbFzYikB5rJtSUfs+ecAwpIdyxnsu
	wPhjlDGeN7muf1/XIj3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTEp-0000J2-6D; Tue, 29 Jan 2019 13:15:39 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTEm-0008Sn-2u
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:15:37 +0000
Received: by mail-it1-x141.google.com with SMTP id b5so4413978iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uAyW2nZnw+/miFxBHbz4nNJJDn0f6yfiB/jBJhvzg60=;
 b=F9Q4+/+Z5KVRwyT1x7LcRbDXuPYMRoel5+qrY7wB+PnEcmngiqPJ4S5HVaMjwTp1WD
 gFgoVlz+crhYLr/r09g3RnxiBgrTKub8Q4TF2DaIIHXzoHQt812CihjOfhVloGfBDZVe
 i5RjGvF1Ge2ip4Yj1661lc0usLXKq+DToRqdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uAyW2nZnw+/miFxBHbz4nNJJDn0f6yfiB/jBJhvzg60=;
 b=b9tfBvqR7FP3N3+xIgNFahtRAvG7cJA2meGADKq2o5s6mSwd91vZJaHjrBRg9Hb/M1
 jotr3ufRAcHqYU2Hx+smJ8eo4L/e7VG4aVpSjRxXHVWFW1ybqmMCzw+bBId+PmkRrXM3
 dlXyYGRF08JtwKJli9UqT5AtVddhFMIFm4sBTD05nwnlu0OoweH6fQXWpz763rBjsQjf
 O01X19DmFFCOUd8raazXgb1JmPpq8ZYLWylrCQhVorU8jKgu0hLOvTN84ePwJ2G50Ir5
 4y111s4MeOP/oeldLqNStB/YjuUcjdDY8fNaXfNwNEfkbWSfz3V2Tlblg4d9f7toSuBA
 raBw==
X-Gm-Message-State: AJcUukdYI59YZTajM9pF/jA9AJ8/DNPs+DfLl9LvnElsM/huCy5o86ep
 2vwEDVYZHdIg+n7uACaqyXv0Dg2r1Z17U3r0qvv0Ww==
X-Google-Smtp-Source: ALg8bN69/7MxgaM8DjIabGxryNw9/JBqa/GNrhz+TradELTVI5+Uy8F5gbHQxJaMuHVZlrI+TTpz9Lu3N4MW5kr/tWE=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr13440259itk.71.1548767734506; 
 Tue, 29 Jan 2019 05:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20190129080029.22261-1-ebiggers@kernel.org>
In-Reply-To: <20190129080029.22261-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Jan 2019 14:15:23 +0100
Message-ID: <CAKv+Gu_8cg_bdxPqvSh8yzdNooNtnMc_CWe_UdCtZ2jTiB4aDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] crypto: crct10dif assembly cleanup and
 optimizations
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_051536_132208_66DECCDF 
X-CRM114-Status: GOOD (  14.43  )
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

On Tue, 29 Jan 2019 at 09:01, Eric Biggers <ebiggers@kernel.org> wrote:
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
> This is based on top of the pending patches from Ard Biesheuvel.

As for v1:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>
> These all pass the new extra self-tests.
>
> Changed since v1:
> - Moved constants in arm implementation to .rodata.

One nit: the __adr macro is a bit pointless for v7/v8 ARM code, since
it will always resolve to e movw/movt pair, but it doesn't harm
either.

> - Eliminated a few instructions from the x86 implementation.
> - Tweaked a few comments.
>
> Eric Biggers (3):
>   crypto: x86/crct10dif-pcl - cleanup and optimizations
>   crypto: arm/crct10dif-ce - cleanup and optimizations
>   crypto: arm64/crct10dif-ce - cleanup and optimizations
>
>  arch/arm/crypto/crct10dif-ce-core.S     | 554 ++++++++--------
>  arch/arm/crypto/crct10dif-ce-glue.c     |   2 +-
>  arch/arm64/crypto/crct10dif-ce-core.S   | 496 +++++++-------
>  arch/arm64/crypto/crct10dif-ce-glue.c   |   4 +-
>  arch/x86/crypto/crct10dif-pcl-asm_64.S  | 844 +++++++++---------------
>  arch/x86/crypto/crct10dif-pclmul_glue.c |   3 +-
>  6 files changed, 797 insertions(+), 1106 deletions(-)
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
