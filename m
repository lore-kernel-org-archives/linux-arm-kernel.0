Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243DDC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:11:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72FA2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYLbPQzQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAdmnQPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72FA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8FI1YTcV5sYXfu2YlT+NCvAQ7ZBb6mpjpAhZwI1Kc1Q=; b=TYLbPQzQ/ccRkN
	hBK8uyvPPnAcnk/I61B31UQKHC0vKBQP1dP2ClowGig/jyJHHjhz45nqCP4SQjDQHFsDWxWfROsrG
	Sxs6iWT1zIKxNgQRSgcV+YivpNpAF0hBarwOR2XNAxCbNsxEOXhHGvbAfVrzMF0YEPRZJm1S2jLSe
	rN1wgXQ6lVhXr791I0hvLXBNZGF8ZqGV61w7f70+Q+JZrjIjPpeBSOpzICn0kr3DwXLj0bq9OE/0s
	npPnnqb6mVdp3GmM4I9S+BzZZld/ak2rEedxbImYAH/zjR+nslyrrMEtdcBtFC2QzL744Kyq5fF6J
	d/xYGOtwHkydgrlSbuPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOu2-0005Uc-7Y; Thu, 29 Nov 2018 16:10:58 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOty-0005TG-MN
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:10:56 +0000
Received: by mail-wr1-x443.google.com with SMTP id x10so2457724wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8gapXwiXjGxXSVtyA4Gab236Oo4t1DTJ0o6K8zWtc74=;
 b=EAdmnQPAcEzq4wSna6JlGM22swIFYHnlnKMc79TYv3jVWpqq7fz4AcZMRxMTHn7Nlx
 rAIsWhTegSI4RbCG4xqMEu1z/CMS/e7A0GiUnKDrS/PvMKUcx/M/WvFNavZQTWFIx7Fg
 ioChnq4RJhK/BhAbew0vC7sgk1mvaiG1U5ZBA/UPruscd810QOpAYMDbuYeMQPJlmuvk
 LO2E44/ZCa/HzOSO4aL/bpWwKQN7kDHolezZziogfxGm17odJxZWzmzjQQNKO+p9LAAA
 wtOIzqHvpt9+vZvEJMxfnSm8fvM0rtnT78thsxPNuSXLRIozpuyUHmGLSr1sWfRZd8E7
 xSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8gapXwiXjGxXSVtyA4Gab236Oo4t1DTJ0o6K8zWtc74=;
 b=henJUXpLZh4h22JwCBmZOKrg9xDKCADoQ1wVAoaApBjvCPSubuMqoAwNRzGjZPT0ne
 WC7X+DYoUGKBXkMOc5jZzskuJWDKcmNOsnEf9VEMV4uOKBgRQ9Mm6m1K0VybsSmP3MY7
 oKVH9o+YA3cR9S3Kz8nuAssDn8gyLrzapV4p9uVH8A2/wXSW3pfeKR5nfoAY9FhBb7qL
 yGUvihdMQgoOWIaaIBTK/36TGFCNCDLBxYOivfTwQIWCcaw8Ilx61ZhiGO+kc4i/lF1S
 gBf+cN+xvRA51NUPfIREo2GGH6ooCN/8DN7YGDUGxclKqmje2hXktEhoJLXj97N+KvXl
 czfg==
X-Gm-Message-State: AA+aEWaN0baTYbPpO3uFgBQXm35WjEtDjIPwXiP53xIU5Ja9mPJGtF+3
 cueSB8ZLCXGg+yzP9agbAyM=
X-Google-Smtp-Source: AFSGD/X25r3VcSoWfqBbq/vOEGSexhxh04nk/Q8iGRJPdA6GRgyZS6B//fdPytrbc129p+szccG3lA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr2125359wrw.50.1543507842052;
 Thu, 29 Nov 2018 08:10:42 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id j8sm1689948wrt.40.2018.11.29.08.10.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 08:10:41 -0800 (PST)
Date: Thu, 29 Nov 2018 09:10:39 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161039.GA17063@flashbox>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129104902.GA2377@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081054_765301_292EF184 
X-CRM114-Status: GOOD (  21.29  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Julien Thierry <Julien.Thierry@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nick Desaulniers <nick.desaulniers@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> >
> >
> > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > Fixes the warning produced from Clang:
> > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > register size specified by the constraint and modifier
> > > [-Wasm-operand-widths]
> > >         return readl(addr);
> > >                ^
> > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > >                                                           ^
> > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > >                                                   ^
> > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > >         asm volatile("eor       %w0, %1, %1\n" \
> > >                                      ^
> >
> > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > The variable passed to the inline assembly for %0 is unsigned long, so
> > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > register for it?

Sorry, this was my fault, I accidentally added a w during testing to see
what constraints were valid (given that my assembly knowledge is nearly
non-existence so forgive the non-sensical experimentation) and I used
that message rather than the original one. This is the unadulterated one.

In file included from arch/arm64/kernel/asm-offsets.c:24:
In file included from ./include/linux/dma-mapping.h:11:
In file included from ./include/linux/scatterlist.h:9:
In file included from ./arch/arm64/include/asm/io.h:209:
./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        return readb(addr);
               ^
./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                                       ^
./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                               ^
./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
        asm volatile("eor       %0, %1, %1\n"                           \
                                    ^

>
> Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> I wonder if the following fixes the problem:
>

This doesn't appear to work, I get this error:

In file included from arch/arm64/kernel/asm-offsets.c:24:
In file included from ./include/linux/dma-mapping.h:11:
In file included from ./include/linux/scatterlist.h:9:
In file included from ./arch/arm64/include/asm/io.h:209:
./include/asm-generic/io.h:695:9: error: expected expression
        return readb(addr);
               ^
./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
                                                               ^
./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
                     : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
                                         ^

>
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index d42d00d8d5b6..13befec8b64e 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>          */                                                             \
>         asm volatile("eor       %0, %1, %1\n"                           \
>                      "cbnz      %0, ."                                  \
> -                    : "=r" (tmp) : "r" (v) : "memory");                \
> +                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
>  })
>
>  #define __iowmb()              wmb()
>
>
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
