Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A1C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3F020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irvxH2jN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tS66kPRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3F020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wz59Rv4T1C0Me81u6SEx7bU2m3fOBsn8SgZlkGZ3ULg=; b=irvxH2jNT+jqch
	GHGM+2kws8MT+HoT2vyuH6C0p61405z8VRs7y1l9+tsXvzKHkGjHEqvNetZHxNOHlH/m0a2QkL+AM
	BISoLMD+Eodc/WuWLd1wmguqgL6l5NjyStPrt5RmEoicoQQSTZw4lDcoezly/km8rAR3jhP8Hmu4H
	08M4FWNn3Dlv12dJdsqDf6VVTA1+5yQnI1fuIJcr7KQ9mT/xekzlpAsWqn9LUWDLJtNbczzr8FDbb
	2EvYqnO6tsvLwpwThjxBY4eIT65yTn9ILWFLo4T42tITxJIJKguB5EXWH3D8okn7QnT1Nogd/8/bh
	awjRkTHn7e5s8o1ukNcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkV5-00011G-O2; Tue, 11 Dec 2018 16:03:11 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkV1-00010H-Qj
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:03:09 +0000
Received: by mail-it1-x143.google.com with SMTP id o19so4275140itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6lDXo7875JvpNdIIVM85W2LwkMrgyNvSCv8MEHJ7j3k=;
 b=tS66kPRg4T6a6sS3sCR8zxd6jJehHiIxUakWflPr5JBabcgJNYs/9EXBlKW/nn/cjS
 8hiuTHeetM9Z6fjYktYVpqCqOgioXJJH40Kut411yYAQ5Sg7FsuXHZyS1cZcXcal3RUQ
 1fxKxyiPEgqlARKdyP+QLzED8jm5S2YHBV3trOwG705At6V1sOrYIZ4N6TpORwF38vaO
 4mNwGg+o8jgncxjb+Z6S5I2oySkLj8UWXWIJehk4yw62OPMSEnvRUmrkhrp6b9pgD4R9
 G3PMqrp5qTOXRWC08JbCfJi6hymkWk2uIhjCQrJP9f9sRUtvhVS2snCjgwH2TZJi0s7l
 NlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6lDXo7875JvpNdIIVM85W2LwkMrgyNvSCv8MEHJ7j3k=;
 b=T0QyG7lA+4FrUpFVMa+wZDjlCAqO+9RdGpqLwHIUiqtaL2CHVD/0MbGOaRnscI65qJ
 jpEccgpyshoOYK3WuDw6ArqMMlKAuRkUYr94k9XCNXdoUd94H5g+JqkM65k6hjF+gqCj
 da6XTLMtQhreimaDzxHrex6dLnSMKxFGNIfkA2CU3uaKN0iFuqm8Lvb19Zm1oQQu2kq2
 2/TWGqAaqsUs6PDR6ozd8IAKQi9TNpHXTNV0eiwABV84MxfjqptuSXKuiXIIi0pEs3gm
 5KNU/USMpvorQ73IRS2OcEk5ABFX3JlflMk6DeRUGhWCqLn/n+vwrqovsx7m3S+2yKWv
 tA3g==
X-Gm-Message-State: AA+aEWZuQwTL/jBooa4o3r9zBaT0JpZNN4yBuTaZvfYJxidYblyAB9LC
 vPGX/U3AQSW0YhdfyXKGMSf5JqW+D52WzXYEY1M0jg==
X-Google-Smtp-Source: AFSGD/U6BIMWUwS3xtHV5rNSN2HKjNYFekO3qmjT25rL0Od6qoFKALCSF3wVHgir1HaFI5iW36y7+D5gI8TVCF3PLbk=
X-Received: by 2002:a24:2716:: with SMTP id g22mr2447702ita.40.1544544174164; 
 Tue, 11 Dec 2018 08:02:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
 <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
In-Reply-To: <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 11 Dec 2018 17:02:42 +0100
Message-ID: <CAAeHK+y0AzO8r21L=9HftHuoTXMuTjkZYJOZ6hKZqCEQOjygHQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/25] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_080307_892471_FADE9E3C 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 4:28 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 01:24:23PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index 3e7dafb3ea80..39f668d5066b 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -16,9 +16,13 @@
> >  /* all clang versions usable with the kernel support KASAN ABI version 5 */
> >  #define KASAN_ABI_VERSION 5
> >
> > +#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
> >  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
> > -#if __has_feature(address_sanitizer)
> >  #define __SANITIZE_ADDRESS__
> > +#define __no_sanitize_address \
> > +             __attribute__((no_sanitize("address", "hwaddress")))
> > +#else
> > +#define __no_sanitize_address
> >  #endif
> >
> >  /*
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index 2010493e1040..5776da43da97 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -143,6 +143,12 @@
> >  #define KASAN_ABI_VERSION 3
> >  #endif
> >
> > +#if __has_attribute(__no_sanitize_address__)
> > +#define __no_sanitize_address __attribute__((no_sanitize_address))
> > +#else
> > +#define __no_sanitize_address
> > +#endif
>
> Not really important but it's the name with leading and trailing
> underscores that is tested with __has_attribute() but then it's
> the naked 'no_sanitize_address' that is used in the attribute.

Hi Luc,

You're right. This shouldn't be important though, since "__" in
attribute names are optional AFAIK. It might make sense to fix it as a
separate patch when this series is merged.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
