Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD88C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5AD20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fFgGuAVU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6MhKC5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5AD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wwJCrMzG8JXvB9Y8esaD9ZAu4xwrE7oY8oqWDyvQXVM=; b=fFgGuAVUDD4D9b
	3H8B638+c8WFO3lEt9qjAJQkbJ6RgZXFuKK0cFIpFDZn/k5fuO1af2f8cDeW0ePBT1Fp1Mgfr8JqE
	kLcTnFaPLfMW8PaIWK7Qic5G3rQn+N+Y6Ri3N+1cprDs23L33HxLqcapZuriPyRNhP7KDjVhRVwEf
	FdI4gYiCMbx8mxzohTLmeOyOtdThCXBzBEzGqSVIiZtSZZ16NFo0VaoTP4zsgrjZMSnnSLw0YTDws
	sdHyB3Q4RhiJ10hYUMauq1tOn6JbfhUm14tDkkz9pL+Gc3M/cc6KvFBq/QjfRGLAfqhi5akkwt7aP
	BKOgJiuKj+Au54HXJIRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSP0n-0001IK-Gt; Thu, 29 Nov 2018 16:17:57 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSP0i-0001Fu-Hl
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:17:54 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so2493301wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=v29Av/O3k6yDuo4+kiDJ6V3r/5u6liE5o8KSDjhVItE=;
 b=d6MhKC5qeixE4tLfHfFhAfgXb/q27ysWfEif1XJPh+BsHoZD2NoKy2809JGPnTGNIR
 HyAr0zeTL7HUjISdSeiPUupYPMTSBC15YDSsho6E7uVZeEZR+ort4Q/5WdXW1ftuPmyy
 pMaGaQn2e72ZTObXyIDSGuv80c3Jw9Wdw7UgJnGmR5PZ2O4qNErUN4g3qOUaTb+9vuGl
 YZxrxf+PZvnsQfYkS/PK7Y8k4B3g9Btkp+VmWwcODS+nD2iJxKxwwR+pemhr1pkJ1+qN
 ITS/t7+B6UEgJR4Ae2I5bXD6F+IQ1G6KrSgCUtatF9W9jj3cxmemF6YtElrO4qmfg9W3
 2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v29Av/O3k6yDuo4+kiDJ6V3r/5u6liE5o8KSDjhVItE=;
 b=tiqBtV0rpadCBANiL+xyIzbMKON6x8BTh7qSeZZMRC1wtQvn1HFNsrRlHnaPs5VIJp
 wAzGae/jMpeeHuPIQiP7B/UMLxBxAWm6S+FKD5/aVI7vc3xZ8Dslf8SZAboD1AC+jXH3
 mVj8Nus+yKac4VZ6lssmDYbgCcHOW/aSV4WrD4uaysExGA5LKtDLwHQKwMU8fzxB/kMx
 1YJ3FTqmnId+KbYIGU26Mj54AXLfIqipArDtG4W1S8xvKA4BaGRfuqorhNA4IOc3N7t4
 8YAet/gt8Owiomreg761NBnJF7t8IwjMB9J/5TQIiJQ2ByIKD9lDt6FGB7j2DhRv/xH4
 aGUg==
X-Gm-Message-State: AA+aEWZ1XvVxUwNifvZ7p+Xz0Lf6VdTA1IenwniNA7vHdA57QbKnbELa
 Qc4I0aFqZDZs7ny2ld0WCSk=
X-Google-Smtp-Source: AFSGD/VU6RYIvuWrVCndfcB5AN4btA9SadYXfRhIegBj31ssGs4dZhgf8u18TFObeZ4+BegMm8lruw==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr2180732wru.245.1543508260736; 
 Thu, 29 Nov 2018 08:17:40 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id x136sm2753630wme.0.2018.11.29.08.17.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 08:17:40 -0800 (PST)
Date: Thu, 29 Nov 2018 09:17:38 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161738.GA9805@flashbox>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com> <20181129161039.GA17063@flashbox>
 <20181129161337.GA21349@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129161337.GA21349@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081752_695411_62E28D61 
X-CRM114-Status: GOOD (  23.51  )
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

On Thu, Nov 29, 2018 at 04:13:37PM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> > On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> > > On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> > > > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > > > Fixes the warning produced from Clang:
> > > > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > > > register size specified by the constraint and modifier
> > > > > [-Wasm-operand-widths]
> > > > >         return readl(addr);
> > > > >                ^
> > > > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > > > >                                                           ^
> > > > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > > > >                                                   ^
> > > > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > > > >         asm volatile("eor       %w0, %1, %1\n" \
> > > > >                                      ^
> > > >
> > > > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > > > The variable passed to the inline assembly for %0 is unsigned long, so
> > > > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > > > register for it?
> > 
> > Sorry, this was my fault, I accidentally added a w during testing to see
> > what constraints were valid (given that my assembly knowledge is nearly
> > non-existence so forgive the non-sensical experimentation) and I used
> > that message rather than the original one. This is the unadulterated one.
> 
> Aha, that explains it. Thanks for clearing that up.
> 
> > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > In file included from ./include/linux/dma-mapping.h:11:
> > In file included from ./include/linux/scatterlist.h:9:
> > In file included from ./arch/arm64/include/asm/io.h:209:
> > ./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >         return readb(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                        ^
> > ./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
> > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                ^
> > ./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
> >         asm volatile("eor       %0, %1, %1\n"                           \
> >                                     ^
> > 
> > >
> > > Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> > > read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> > > I wonder if the following fixes the problem:
> > >
> > 
> > This doesn't appear to work, I get this error:
> > 
> > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > In file included from ./include/linux/dma-mapping.h:11:
> > In file included from ./include/linux/scatterlist.h:9:
> > In file included from ./arch/arm64/include/asm/io.h:209:
> > ./include/asm-generic/io.h:695:9: error: expected expression
> >         return readb(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                ^
> > ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
> >                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
> >                                          ^
> 
> Can you try throwing another set of brackets around it, please?
> 
> 	((unsigned long)(v))
> 
> Will

Thanks, that fixes the warning as well.

Nathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
