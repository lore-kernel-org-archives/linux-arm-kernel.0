Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D79C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0B820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ktV+umWb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eF4lMLd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0B820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6n0CG6X/87b+lpYOUPGgJ7I0KMWKENQdDUlDjL8LP+w=; b=ktV+umWbYoZz/Z
	2Yl1qWoF6O2XcdUTmU6sHE3juVShOVlnJLggPXVxvB2coC5WlK+NIaB0ZYdytaZLbrZVsbAkX0PfW
	Vzn7hQ9ZSfbxNTUPCqomDtm1fEGecjr9WaJ3l1Df0tnnygi3nKKg7ygpbL/pYrB6iSqYclIYwjky4
	h8tmskgWa10Eb9jt8hX1ARSPRgluXyti9bl3t8jTUufIE9mFVZuOPbYPDROY/lavu9fDzIIKNoeuF
	qDG+Lel4hNzQqEA9sEmskIDTL0OhvPzlALqL+zCcV2Bseac40pwJBs4ZYZNMvDMQWtmsFBwlfRAUP
	Jl2cezww/sXDURNkDO+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUstz-0007Jr-Fc; Thu, 06 Dec 2018 12:37:11 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUstw-0007JV-HQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:37:09 +0000
Received: by mail-io1-xd44.google.com with SMTP id n9so210907ioh.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WidNIP8PGlQQtkA0lmSuS7tUfoPMSknLn9VUL0IsozE=;
 b=eF4lMLd2gM5bZJkTfp6Rs2kYVm7O2ljRh8HtAeOfR/uvqp9VX9Le/TtrRT4623RIW9
 S37itEwpEmj2zoERka2diuAljUcjkjdXO182hvOyUN0whOir04e6TkSCA33JGJhc04yc
 vA0VMroGWF2XsAc9XPb2Ti576+1OhnTFlFLpuSYYU9PlebzUtOiYlNDXrS7Q3wLpNtpv
 VTEefTG7R6HvqN1nlJnEta/2ds92zk+a+UXyTze/lHXdz5XyqfUTgAu2aMkeBOT3EWdZ
 +0v4SzUCJkcJF52coaPIb3gYx+Uu7LXUvWaHF1dyFK8zP8+M/DrG8ohcEnrL4h4pDCXE
 DaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WidNIP8PGlQQtkA0lmSuS7tUfoPMSknLn9VUL0IsozE=;
 b=XHGkhG36CMREiZB8tVNggHuZLoAQzXuBLfdiLyuh5fapXJz0SG7Vy18OEwA4mzvp90
 Qs0BOy4gR/S2KyQ4d2B8z83bQCZ91HTK5dbSaV6RPd/FtsKFL+m8LgGCuL+3cMikxigz
 AJOkjr+TpIHy0x3nBtBfgnZJa1aAiH14oqqruNet1GnxD1FJgvS3pxL2Q+0BvIpmikLj
 Wnh7jJklPvpSay3zXRIzgktx2CJzbYcxn/T3x0aZ2UjtrsyOFpHgko3loZlSFH9ZWWx8
 hqBaxZKIjJr3uZ7rXQbqWETKW5fmXcItZxJnKPYRFO8j3ek6VBzeLEvPv0lJ28xOAxmE
 opug==
X-Gm-Message-State: AA+aEWaGKBfnVoF8fd8/Q96HjuqaV09EygBGr1KRTv/hHwDEJVJ0wlnh
 9b6oX94+y5Qh71J9ywfsaNcgPefeQD8BMaYTnp2tGw==
X-Google-Smtp-Source: AFSGD/Xm9VGdnSPf1hWOUupCpcd7a1Mg3qQvtYoJwqmAMi3YOnI7fV93LEeSmCsW4kQDTIuBhjZmOXHOAFzCCUI1QE0=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr8796163ioc.119.1544099817423; 
 Thu, 06 Dec 2018 04:36:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com>
 <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
 <20181129182323.GI22027@arrakis.emea.arm.com>
In-Reply-To: <20181129182323.GI22027@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 13:36:46 +0100
Message-ID: <CAAeHK+y7AwdXsEgBYqLUzps2K8aGcbDsSpS+obCs11voZX55og@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] uaccess: add untagged_addr definition for other
 arches
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_043708_642785_486FF359 
X-CRM114-Status: GOOD (  11.89  )
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
 Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 7:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:09PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index efe79c1cdd47..c045b4eff95e 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -13,6 +13,10 @@
> >
> >  #include <asm/uaccess.h>
> >
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) addr
> > +#endif
>
> Nitpick: add braces around (addr). Otherwise:

Will do in v9, thanks!

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
