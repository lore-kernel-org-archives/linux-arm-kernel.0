Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5828C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AFF2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cDBXP9NU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f1StIL2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AFF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YFwFKTNzZ0xndEL0IKIZZyzoK+VcSlV313vCGZcSOFM=; b=cDBXP9NUYsYxCK
	wET+qicqM2rAj92KRKSDDSRTPO8dtTsaYk0m/iLxJfOP0JV/EKSn31yqnPdKAdWirq/lRd0DJDvFR
	zN1b1aDqjcRW9z1piA1YgkjnBHtwRX6os8DsXV+1L/Lqne2Dtq2/0YTjOfJxNg756lFEiWc5kLGXj
	FjA55sVPOhHn5iBAApUd49IL0G+B4hRWz931+AxMZKHZ8yfvJ/6JbcgGEhNiEU5gOnpFzXoxbjk9v
	ruv6tb0tOhnvV8+6ixCkgzunLEYtXcfnuYWtAcdW/lvCgpf8ZN9imH8K7H6F2lhBZQFHa72E0km4J
	unx8yLB3mwacO7f/ajmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOxs-0007MA-If; Thu, 29 Nov 2018 16:14:56 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOxf-0007Dr-7g
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G54T+5sk6bFuEzUiWI+1yMrD5NhH22z54h6GsTDnDwI=; b=f1StIL2vd+aZG0lWDUjey7mIu
 D4B6Q4p8e00zFjBP4riywI2PlJN7AwIcdTxtJBGZ30PKYmkQF961aG0a7b3e9SZn4idaVxCEvgpYN
 yZz0tGD6f4CWDk6sexveDfJPqvA9213cjE0vkcb0j6HWJxo8zSjIZ5k1uLrfamF0m9tD8=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38357)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSOxL-0003Hc-A6; Thu, 29 Nov 2018 16:14:23 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSOx7-0002HX-1U; Thu, 29 Nov 2018 16:14:09 +0000
Date: Thu, 29 Nov 2018 16:14:01 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161401.GY30658@n2100.armlinux.org.uk>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com> <20181129161039.GA17063@flashbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129161039.GA17063@flashbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081443_414040_51C3C8ED 
X-CRM114-Status: GOOD (  24.25  )
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
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Nick Desaulniers <nick.desaulniers@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> > >
> > >
> > > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > > Fixes the warning produced from Clang:
> > > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > > register size specified by the constraint and modifier
> > > > [-Wasm-operand-widths]
> > > >         return readl(addr);
> > > >                ^
> > > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > > >                                                           ^
> > > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > > >                                                   ^
> > > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > > >         asm volatile("eor       %w0, %1, %1\n" \
> > > >                                      ^
> > >
> > > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > > The variable passed to the inline assembly for %0 is unsigned long, so
> > > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > > register for it?
> 
> Sorry, this was my fault, I accidentally added a w during testing to see
> what constraints were valid (given that my assembly knowledge is nearly
> non-existence so forgive the non-sensical experimentation) and I used
> that message rather than the original one. This is the unadulterated one.
> 
> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                        ^
> ./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
>         asm volatile("eor       %0, %1, %1\n"                           \
>                                     ^
> 
> >
> > Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> > read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> > I wonder if the following fixes the problem:
> >
> 
> This doesn't appear to work, I get this error:
> 
> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: error: expected expression
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
>                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
>                                          ^
> 
> >
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index d42d00d8d5b6..13befec8b64e 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >          */                                                             \
> >         asm volatile("eor       %0, %1, %1\n"                           \
> >                      "cbnz      %0, ."                                  \
> > -                    : "=r" (tmp) : "r" (v) : "memory");                \
> > +                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \

The parens around the passed value are part of the asm() syntax, which
is:

	"contraint" (expression)

so should be:

+                    : "=r" (tmp) : "r" ((unsigned long)(v)) : "memory"); \

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
