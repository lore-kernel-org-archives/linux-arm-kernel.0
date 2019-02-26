Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720622173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jkcIucic";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Jk4s/BkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720622173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f0ktNjaB0mTyF9ycjKbY/gcXv5aJuSPANBkUVclOefY=; b=jkcIucicpsPHXO
	RTPhmg6TgEmGofV+PCg73rOMDhPsDlg+6CW7HKPVIy9k283PfzCEpF5cd7teHKV9S/sT5FUrF/3Lv
	hu3rNZVHjUK0ojJrLV1ljY3AVGwySJY+S5A9wX4Eihqx2Rt7glCN0dZ/99jVsXkpioMQDpBMzC4NO
	Q7K2Xwc1w75WKv6M1PvZSjZSdFy1SjCGPsgw5nTEwrZVrSqEPRPC7PZr2IOfcp99Zvur2dWiLoFvw
	75tqSr5FCHIWmTV1Dp5Vby+xRxc1J2tMcvv6+yiVPEimv2kzqnKj5aEHUmW/43VMXCaKd4Z05VUpt
	LjiQmc3LH1PEBOQ/Wc4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydvR-0001iH-TY; Tue, 26 Feb 2019 14:41:41 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydvO-0001hZ-Oi
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:41:40 +0000
Received: by mail-pf1-x441.google.com with SMTP id u9so6352677pfn.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ORID1v1ozYXyKv1mw/ofFm5kiuOuJ/TBoHbnGpDrQY0=;
 b=Jk4s/BkFrIcxrk4e9Mx5smnm1MMtapGUCpafH868xdIWYkLK7M78NPFfkO1hXlBR3s
 fHSFCSGQY90XYaDQqb63dSKPREtSbEi2GwRgT00jYvnEy0yQetugEzlFqBmtB3qipsAd
 q/rhOJ6CKsqxpXxBDrJDcb0ls8JRx8hPmbNL5pXQCFMY5+3weHhsnBcu5hbxiUG4WqQl
 pBEq1Wji+wh6z+8emU3AosXH6snGNQBpu8akU3FP96jjwWcneLVMTgn776abphESvY54
 iMhXTsCqkSEIu1VQDJchEorqdn4d1RpFfWm51ZaV3ypfOUhUpwNhpwhi50tHIgnGBRqu
 SjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ORID1v1ozYXyKv1mw/ofFm5kiuOuJ/TBoHbnGpDrQY0=;
 b=lrR1sGFgR965BX1Ab0bcNDCebFgM0uZOojTNUTCVKrXVIUfvlbA/pCNZ6W6xhAylmB
 FFCmRk8dvu/PCjmosDY/76WtobKFFCNST06GRHqpSwbeUc8zAFc5QbNM573oOY3NmV0i
 TcIWtHA2+czgtSWbYrQdmOLzVISaYh07crIa7dU7Aq4g6PatoRkwqs7NxfGkawENu+p5
 61V/bZZ65UaB4kC9JmlwxqfseQ8maKGKCNWqCwOshGx49Ea45VaqJeO/gxVG08Lgj4P8
 ej0omXfbPX/EjycMkuyDa+vjT12C62ZDdkMNBG/wobTMxHM0vUgtcnXePwHVi/LbvIan
 7wcg==
X-Gm-Message-State: AHQUAuZ/ptaMjZtB6eJI4uKUGu0j5e8IyjAUO17s9g6aBC/9KSNOL9Px
 eylSZnCv9O6Pant3Lm/qINDXeUMc7QkkuXAEAzCvFw==
X-Google-Smtp-Source: AHgI3IZRaeChYbi2J79TLZ2OQNrL+zd2lHSInwkIpfXgbjWxpzJly0F0LoxycLTV6qaHuDyyWxELKtQh0Gjyn9jKmaE=
X-Received: by 2002:a62:4299:: with SMTP id h25mr26113838pfd.165.1551192097850; 
 Tue, 26 Feb 2019 06:41:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com>
 <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
 <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
In-Reply-To: <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 15:41:26 +0100
Message-ID: <CAAeHK+z2qw__Kpeih2mEyhVJ-gbor1vYsOZddT5E71JDiSg7pg@mail.gmail.com>
Subject: Re: [PATCH v10 04/12] mm,
 arm64: untag user pointers passed to memory syscalls
To: Dave Hansen <dave.hansen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_064138_837861_CAC17491 
X-CRM114-Status: GOOD (  14.92  )
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
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 12:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -578,6 +578,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, -1);
> >  }
> >
> > @@ -586,6 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >  SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot, int, pkey)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, pkey);
> >  }
>
> This seems to have taken the approach of going as close as possible to
> the syscall boundary and untagging the pointer there.  I guess that's
> OK, but it does lead to more churn than necessary.  For instance, why
> not just do the untagging in do_mprotect_pkey()?

I think that makes more sense, will do in the next version, thanks!

>
> I think that's an overall design question.  I kinda asked the same thing
> about patching call sites vs. VMA lookup functions.

Replied in the other thread.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
