Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5CEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2146D222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YtYTphch";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AEghaGXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2146D222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vetgJbUPv8IpWCD+BGOY2uH070KYkwy/Um1mldtGL6c=; b=YtYTphchfYJxe5
	F0GHBAgvhFJ/llLf6+uT+EYQU58GcLA+U/45NdI46OKFCFb2WCDiONfinDalmxIizBqmgobJ314D6
	YiCJKAA7JR1Vka7injXy1sVZ+h7D1D0FfMCRNdTcQikLPq9PgXblpw8rE0ByJkTLWP7mt0q+6ODwU
	OeZLLl4n8YE+uDliRDilgTjp3fMUuYlmsN90lBjclhy9LRyEa2toIsm/8rCfXyL1vpuhzmPD6h877
	y2IFDX6brWYUY2Icw5fH5Bd9RQZwLLQkKc6We3zSFQ6ywJJMT4IaOVTZe14k963atYDRgmZ37saZJ
	2Us2AY5Gz7HKSB+DUWRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2LO-0000Hy-QN; Wed, 13 Feb 2019 21:45:26 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2LL-0000HR-2H
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:45:24 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so1811078pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Oid5VLfYyCbw+zlKoqlmwcDzK/J99z2Ibs/Mh81IWaE=;
 b=AEghaGXHqeArAE/zH/mAsmAw/V6LfBEns0a2ad9sdLqYzEIR93IsdQchsW3NvYGEho
 hESL3wGu0wMg1vHAm05L152cs0x0BsbboVjOICAw+OcJcxBRWjeOK7ogQuYh0bdZbQcc
 x3mEoDXSf2YrWM/48SQGIxpTOeNkJ+796oqUT5R0W/opkFyV2Sh24emZRI9iIixHndGZ
 ytU/wgCkpmG7j115eAQDS3rg2Vdam1SgcF5+oXh9jR81yXhlru9MkvtwvZBya8GCPs2i
 YzUlLuTLh4ncPStHulbxLdqsFiMO/n9KJrg9eneFM1nEYkwUPAOyLrRYpNowRiJ4AdqE
 9Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oid5VLfYyCbw+zlKoqlmwcDzK/J99z2Ibs/Mh81IWaE=;
 b=G5f6Y9IUpK0J9X3NUjgvI/mo05rxPHhk6qgqZokr9SNDZh95zBalIB+/bMsALCYg9U
 M+KotXD6WpYcysQjJvbsLYp4gjq/9XnsveGLIGW9RXehPBWaubbu00Aj0pq9miueAZM+
 JpP84CCeKmqWnW03mSBQ1hSKmeT3nnhm5jb7tvI7MARPF2LNSkFmG8tSwFKgPtJxkHu9
 76fi3C3CHJ5kknaMP35EodzcESDNUiRYLrJRAw1XQj82ygNX/CmUvaRN1B75cr+NXkwo
 Wl7UzjZMwiVqHnwXcwp29kIgX6UcxBWXgVJA1j03WuxKGPWPh7LJ3pt0X7FuQnCHBsDZ
 DfOg==
X-Gm-Message-State: AHQUAuanaXwy7ieB8dL2Rk86LNo6jQDOVxO5akNLp1gaxgwMkyKYNGsh
 QorTlObpPPYTxyXDRiK+6FU2PyX6iipdcdx4frHjdw==
X-Google-Smtp-Source: AHgI3IbzrQz5prmthYaL+sYqXdZuiQ7GxElPr7dKNjSJNs06vfscebZ99dgUw1ArATlTMe+6Bgy0bm1KGPbNx/1ifyc=
X-Received: by 2002:a63:fc59:: with SMTP id r25mr319828pgk.302.1550094319459; 
 Wed, 13 Feb 2019 13:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20190212194645.32504-1-broonie@kernel.org>
 <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
 <20190213114033.GA7540@sirena.org.uk>
In-Reply-To: <20190213114033.GA7540@sirena.org.uk>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 13 Feb 2019 13:45:08 -0800
Message-ID: <CAKwvOdnx-_KtojEEbnWvygDLXec7ckCfciP4iwigPT5Y3bdmxA@mail.gmail.com>
Subject: Re: [PATCH] arm64: crypto: Disable xor-neon build when using clang
To: Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134523_135221_FD2C7918 
X-CRM114-Status: GOOD (  14.84  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Jackie Liu <liuyun01@kylinos.cn>,
 Will Deacon <will.deacon@arm.com>, Stephen Hines <srhines@google.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 3:40 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 08:33:57PM +0000, Ard Biesheuvel wrote:
>
> > Can we just add the pragma to neon-instrinsics.h and be done with it?
> > As long as Clang is not the dominant compiler, I don't buy the 'hiding
> > real bugs' argument, especially since neon-intrinsics.h should never
> > be included transitively, so it only affects source files that
> > actually call NEON intrinsics.
>
> That's fine from my point of view, when posting this I was basically
> just going for the most conservative workaround possible.

Idealistically, I'm not really happy with either.  But pragmatically,
if this is the last thing preventing us from turning on KernelCI
support for arm64+clang; I'll pick the lesser of two evils, which
would be the pragma (vs disabling the whole translation unit).  We can
always revisit why all of this complexity is going into this
particular part of the code later when we have more time.  I'm focused
right now on finding bugs in llvm asm goto support so that it works
well when it lands, and upstreaming lld support, but hopefully we can
revisit this more later, when I have more time and energy.

Nathan's patch [0] is probably ready to go; with Ard's suggested by
tag [1].  Again, I'm not happy about it; but KernelCI coverage is
ultimately more important to the project.

[0] https://github.com/ClangBuiltLinux/linux/issues/283#issuecomment-457093369
[1] https://github.com/ClangBuiltLinux/linux/issues/283#issuecomment-457087288

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
