Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:26:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C502190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qvsfIf3A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="OFoUjrv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C502190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nVYNGhZ+DcSpVKR58d+CgoxDTujpRw77AG+B4QWB7s=; b=qvsfIf3Ag5vxtZ
	kNsIbyVw1ZlXDjvDg5AhhBHQlIgUWGayVsj5eSgUUOv2tvs6jyNd+rWtp42FrMADPqdAUIcRlTt9A
	OTEndZCSMwO8ubB5jwTSAw1pGDhdFmN/m7q4CYZbax767Zm1P7PVbeAuuUnlPe23fH5ZGLA7uRQVH
	l/9Uk7bFnPTDj2dliShL9ILSYSMAU3Lf+jrHmXdkxPQ0Plru+h+eBYJ/xI1PQ40GrVua8uv+2PM8o
	nAeGEzoDSNg/DQ8fZqA24RyoC6KLrV5I57U4z1jTjI+ou4GINolN0sc+DeCUbMSK+iiEymXedlJ5K
	qwKiUGmk0bgyGpC9D5zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdhb-0006Gi-Qb; Tue, 12 Feb 2019 19:26:43 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdhX-0006GB-IL
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:26:41 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 012025C08D0;
 Tue, 12 Feb 2019 20:26:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549999596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMAsB1iZFN1YlAUlS1QoRPtJAL//cY9F2EkH1ZgpbxQ=;
 b=OFoUjrv+26oYRTa6vjpk2jFsvuaxdACurbDjQXyvlQ3O+WC+SwFgAazXGvEeNaStYK/yrL
 9q/W9tn0lGUDILBNx+CEP7m2fd8I+sYdgWl/AbLcYMBsEYMqJ/p16PRSDrK9PCpuYV76nS
 YDGPDKuIrIqF8V7JSy61tTMMDjYEelA=
MIME-Version: 1.0
Date: Tue, 12 Feb 2019 20:26:35 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 4/5] ARM: use unified assembler in c files
In-Reply-To: <CAKwvOdnqOkdD9fFoXmSKZNmceaXcWtdaZ2iwKej3=X-LL0DS9Q@mail.gmail.com>
References: <cover.1549532513.git.stefan@agner.ch>
 <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
 <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
 <CAKwvOdnqOkdD9fFoXmSKZNmceaXcWtdaZ2iwKej3=X-LL0DS9Q@mail.gmail.com>
Message-ID: <d0bab705305af664772b87d40c9c0ffd@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_112639_899020_63D96994 
X-CRM114-Status: GOOD (  20.92  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, julien.thierry@arm.com,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11.02.2019 19:17, Nick Desaulniers wrote:
> On Sat, Feb 9, 2019 at 9:28 AM Stefan Agner <stefan@agner.ch> wrote:
>>
>> Thanks for the reviews so far.
>>
>> During some more testing I stumbled upon another issue:
>>
>> On 07.02.2019 10:48, Stefan Agner wrote:
>> > Use unified assembler syntax (UAL) in inline assembler. Divided
>> > syntax is considered depricated. This will also allow to build
>> > the kernel using LLVM's integrated assembler.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > ---
>> >  arch/arm/mm/copypage-v4mc.c | 2 +-
>> >  arch/arm/mm/copypage-v4wb.c | 2 +-
>> >  arch/arm/mm/copypage-v4wt.c | 2 +-
>> >  3 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
>> > index b03202cddddb..b19c7ad1a6de 100644
>> > --- a/arch/arm/mm/copypage-v4mc.c
>> > +++ b/arch/arm/mm/copypage-v4mc.c
>> > @@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
>> >       ldmia   %0!, {r2, r3, ip, lr}           @ 4\n\
>> >       subs    %2, %2, #1                      @ 1\n\
>> >       stmia   %1!, {r2, r3, ip, lr}           @ 4\n\
>> > -     ldmneia %0!, {r2, r3, ip, lr}           @ 4\n\
>> > +     ldmiane %0!, {r2, r3, ip, lr}           @ 4\n\
>> >       bne     1b                              @ "
>> >       : "+&r" (from), "+&r" (to), "=&r" (tmp)
>> >       : "2" (PAGE_SIZE / 64)
>> > diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
>> > index cd3e165afeed..6e3c9b69dd25 100644
>> > --- a/arch/arm/mm/copypage-v4wb.c
>> > +++ b/arch/arm/mm/copypage-v4wb.c
>> > @@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
>> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
>> >       subs    %2, %2, #1                      @ 1\n\
>> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
>> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
>> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
>> >       bne     1b                              @ 1\n\
>> >       mcr     p15, 0, %1, c7, c10, 4          @ 1   drain WB"
>> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
>> > diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
>> > index 8614572e1296..4a40fa1cbc2a 100644
>> > --- a/arch/arm/mm/copypage-v4wt.c
>> > +++ b/arch/arm/mm/copypage-v4wt.c
>> > @@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
>> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
>> >       subs    %2, %2, #1                      @ 1\n\
>> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
>> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
>> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
>> >       bne     1b                              @ 1\n\
>> >       mcr     p15, 0, %2, c7, c7, 0           @ flush ID cache"
>> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
>>
>> When compiling with gcc, this leads to:
>>
>> /tmp/ccrvA1wy.s: Assembler messages:
>> /tmp/ccrvA1wy.s:180: Error: bad instruction `ldmiane r0!,{r3,r4,ip,lr}'
>> make[1]: *** [scripts/Makefile.build:277: arch/arm/mm/copypage-v4wb.o]
>> Error 1
>> make: *** [Makefile:1042: arch/arm/mm] Error 2
>>
>> Unfortunately, the gcc option -masm-syntax-unified which allows unified
>> syntax in inline assembly is broken (see also
>> https://lkml.org/lkml/2019/1/7/1320).
>>
>> So this requires to sprinkle those inline assembly with ".syntax
>> unified" strings, similar to how I've done it in uaccess.h.
> 
> Not sure if this is purely a bug in GCC; Clang treats inline asm
> statements as unique, so asm directives do not carry over from one
> inline asm statement to another.  This has caused issues in other
> arch's inline assembly, where we need to repeat asm directives
> repeatedly for each inline asm statement.
> https://bugs.llvm.org/show_bug.cgi?id=19749

I don't think that this Clang bug is related.

GCC always emits a ".syntax xxx". The -masm-syntax-unified flag allows
to select unified syntax, but it is broken in current GCC releases. I
reported the bug and sent a fix to the GCC community, the upcoming GCC
9, as well as 7 and 8 bugfix releases, will have it fixed.

See:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

--
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
