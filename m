Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D88C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:34:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C2321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBWdi+2q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFkKmT9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C2321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VUCESVtl5g98vibI6aJ9FlGvfaOLxm2/hsnPXKKM1pI=; b=pBWdi+2qZsB+3p
	RkTrz6ZaudrdS63v3Qyz4MI5JUEln8Z1rjCJqrXlsP3nZeV89sMX7Lh7t5Ju0l4sYxIxRWo29VRas
	mbyIsoLBz7xkKOQI4xmKOhcwu5UCGD57B9JgYySrEB5ijiatie9RGVz0/Vqaa1MH5mXAx8FZrEgL7
	qnWHZrPXEiVQo1JQfBnlYOQDko90aZkMX9pm+VAnB8F1WzMCAx0V+va08qjpkD7k7RAZj/pMYmoz9
	WD2Tpk8F0L6EDoO9UMWmeb/kgsFlwoqWvPFOGh+g6XC9sH/gkAmcNx16iGYcIsxl7IGAby/ZOXEXl
	bISGyMp+pyieR6qwg6zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golK4-0006fW-Cx; Wed, 30 Jan 2019 08:34:16 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golK0-0006f3-DB
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:34:14 +0000
Received: by mail-io1-xd42.google.com with SMTP id m19so18697500ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ckuC3ZQVRrVuPH+nAFncXNWtfLzpYSyWJJoM09owGmM=;
 b=LFkKmT9pxhM5w5Id+lWqN8LjFNiv8A/2D5nUsO/fu+/t1S6gs8+A22tVGTvKHhj5Yt
 saZaVWjC8J9TQIUzlen9YKFipM26J8FS0z2RCKq2AtOygsFOpuQpjLyULopEthUxW8rm
 3Ftq/Lyjt47bimkWdnhlqJDw4rcuR9vn4Ug50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ckuC3ZQVRrVuPH+nAFncXNWtfLzpYSyWJJoM09owGmM=;
 b=Q+CdDEFbP6TjUL8Gk3Iu+6QjGmxXXkpXs0a4q/r2dnczY9xjj4A8g0hyym7U09sCP7
 tmdMsv1BVpC4b0vAV+PMYfbPlDcEw7JwN9236S05ut5895mSlHiTQLsnGJHn1pxpBrPk
 ZLZpTpfCBWgw5dLemjj0SgajYPUr66U61aXyXNSzHNFZE4l58Trfm5GSRrizpGnlLjsZ
 lwL3DgvQOwJmGjfKStffvFKaiMXSoYQGJZc6pRruUnFiPAW/8Le6gyT0MuwP0Q3Kr6Ua
 s8lrmipZOsFtKKSC5350hYCCzA41OqXbrT5oXKOV3NPDapoQwSUKQirBHMMusfJqzH0g
 md5Q==
X-Gm-Message-State: AHQUAuYAtbErcahF36Ddn1oKLKwpxeaZImKBjroMgscXGE/iliFnc0Im
 MpEUhGdql1iGQWthhVALfkrxUH7veDdFuoEAIZgw6g==
X-Google-Smtp-Source: AHgI3IaVd5RYshAFtY7mq4CrT8ycn9S+PqmXKMIfNC284bwd4CnMFb8YmObMXDBTmfOZA2xwgJlYnzRWgmhKMtCtfe8=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr481607ion.173.1548837249850; 
 Wed, 30 Jan 2019 00:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20190130031444.28935-1-ebiggers@kernel.org>
In-Reply-To: <20190130031444.28935-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Jan 2019 09:33:57 +0100
Message-ID: <CAKv+Gu95j-ZJC7vbUzJKqNczht1cjgx09sBiSRcwg+qn-HtXew@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] crypto: crct10dif assembly cleanup and
 optimizations
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_003412_447436_F17D288D 
X-CRM114-Status: GOOD (  19.97  )
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

On Wed, 30 Jan 2019 at 04:15, Eric Biggers <ebiggers@kernel.org> wrote:
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
>
> These all pass the new extra self-tests.
>

Hi Eric,

As a FYI, the issue that broke ARM and arm64 with your updated
selftests was the 1 byte length special case that you also have
special handling for in the x86 version (but while fixing that, I
noticed my version was reading beyond the end of the input). I think
it hardly matters, though, given the way T10-DIF appears to be used in
practice (disk blocks), although it is hard to be sure from reading
the code, and the algo should be correct in any case.

So what remains is the way these implementations are encapsulated by
the crct10dif() library function, which is raster nasty, making
CRC-T10DIF an excellent use case to discuss whether we can make any
improvements to address some of the concerns that were also raised in
the zinc discussion. I threw some code together a while ago [0] (and
posted it as well, IIRC). In the mean time, a 'static call'
infrastructure is being proposed that could be used in a similar way
to avoid function pointers. I'm also interested in hearing opinions on
whether the indirect call overhead is actually significant in use
cases such as this one.

-- 
Ard.



[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=crypto-crct10dif


> Changed since v2:
> - Removed the unnecessary '__LINUX_ARM_ARCH__ < 7' case.
> - Added Ard's Acked-by.
>
> Changed since v1:
> - Moved constants in arm implementation to .rodata.
> - Eliminated a few instructions from the x86 implementation.
> - Tweaked a few comments.
>
> Eric Biggers (3):
>   crypto: x86/crct10dif-pcl - cleanup and optimizations
>   crypto: arm/crct10dif-ce - cleanup and optimizations
>   crypto: arm64/crct10dif-ce - cleanup and optimizations
>
>  arch/arm/crypto/crct10dif-ce-core.S     | 552 ++++++++--------
>  arch/arm/crypto/crct10dif-ce-glue.c     |   2 +-
>  arch/arm64/crypto/crct10dif-ce-core.S   | 496 +++++++-------
>  arch/arm64/crypto/crct10dif-ce-glue.c   |   4 +-
>  arch/x86/crypto/crct10dif-pcl-asm_64.S  | 844 +++++++++---------------
>  arch/x86/crypto/crct10dif-pclmul_glue.c |   3 +-
>  6 files changed, 794 insertions(+), 1107 deletions(-)
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
