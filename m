Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40422C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:18:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071D1218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r1F2a2Mz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns64+bku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071D1218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iFDS3igzDtjOa/iQeQGXgHOW70p6uZilG2gaQP+F4qU=; b=r1F2a2MzkCKWe+
	Iz36t4oEJZsqaVMpOFAX0gcV4z/s7pSO65R3rrOGAoufb+A5ijYGa6Y+gcQuXltKw4kwbn+JbxNea
	FNWRL3463+D70fh2TqR6bKRIcSebSDj+hjUxR8OL2eboLYYDRAKjdJuMhzUeGofAa7zEXnpGW+AH8
	YMJJ1ldYE9hYZ1rWuvtj697vs0ffd/eZr9lmMspOjaJvu0XJ164ECmMvCfa1qBmXxOLclgdMIhmJx
	XK+entG0F9rFmo4zQwuLSN+RWQQpaE6Vu0q0kBtKhZjZpWtI2F1l1BH7tXfoZwXLAPP9BTH6RRQE3
	6BEkGRyWqDJ9y4t01nuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylz3-0000xs-9h; Tue, 26 Feb 2019 23:17:57 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylyz-0000xK-QC
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:17:55 +0000
Received: by mail-ed1-x541.google.com with SMTP id m12so12294441edv.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F/ZWUspDnO9H+N1b+3KaSbEisQ9DROKLGDc6Wk9zF/Q=;
 b=Ns64+bkuLm12DoKtMqYvm9spiyuFy91esqRW620Tr8a7c6yO/zBoKktXkM25pJWO7N
 KYZHrHySgbKp0ukEqgvOhVKztZuddf20j5XWcS8omSkG42v0aRxVNYrlBxPtJ5MKsME7
 ICL0xa9DMOfylbdIxpEwAZmOFNWw8UhcTBw6asiXQj4RekvDc6+JweuyVSjAgI3eHELu
 vrpNWsBvdmFuFoBrNOxVtfbPgEBXp3J4Y4DdxNVAhdJW9HKxxO6kJVWQ6cQR3MOt6yFp
 sJZMlrFYPfy5nxUdukFrBbjcMPSYdZIfmqc7x6DDDKYm9VEv7xqnU2PBR6i514uULX4k
 dhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F/ZWUspDnO9H+N1b+3KaSbEisQ9DROKLGDc6Wk9zF/Q=;
 b=UnEZAG1Q0xSRT53aBywu0oAw5uhVwbG7mAnRocqfwojzbx/8lgN9SZ1KHsB2j4rrO9
 Op4+mYmlCRkT4Jl1NlEnf0kVXtRTV8mS/JmMWHZuV0UwmJQ369YuiSUAlkTvFO8jJfFg
 OtU7MdEy+LrxD8Fn4pzLOJqYjc1VQfVkARcjjnEsl0FWRXDhi4zBrp9VLWfOYHrlVKvv
 eHq4ocejjwJWptnePQxRU4wGsDqq4Pn/njRK+xHkdN2W0ig675rFRifdN6beKSOTttyx
 J5pJgkjuGu5dtgsllk2uhdoXxkMO6+ROckZjJ2OqDLVjDi3088Vabe3TRF0cqEGuL4nw
 hg1g==
X-Gm-Message-State: AHQUAuakvoh2+6cAw0i53u1WcenxvomiOyt3mwnyl2CtAtowqOMA4IWN
 sLdwIWa6jiH00Ly6+O8aDf4=
X-Google-Smtp-Source: AHgI3IY1BbDU8p0Py+W8Y6W1UeY89PQP3LwkVqNuoCAqT9ACsIxnL06lQwM6hryAvvVGWelTdqrUAA==
X-Received: by 2002:a50:ca41:: with SMTP id e1mr3769377edi.73.1551223071600;
 Tue, 26 Feb 2019 15:17:51 -0800 (PST)
Received: from ltop.local ([2a02:a03f:4034:3c00:69ad:1253:f4b5:5458])
 by smtp.gmail.com with ESMTPSA id fy6sm2459233ejb.52.2019.02.26.15.17.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 15:17:50 -0800 (PST)
Date: Wed, 27 Feb 2019 00:17:49 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Message-ID: <20190226231747.z3lc6yr6xmrw5q2z@ltop.local>
References: <cover.1550839937.git.andreyknvl@google.com>
 <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
 <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_151753_867952_AD80303A 
X-CRM114-Status: GOOD (  22.41  )
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
 Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 06:18:25PM +0100, Andrey Konovalov wrote:
> On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > > The following testing approaches has been taken to find potential issues
> > > with user pointer untagging:
> > >
> > > 1. Static testing (with sparse [3] and separately with a custom static
> > >    analyzer based on Clang) to track casts of __user pointers to integer
> > >    types to find places where untagging needs to be done.
> >
> > First of all, it's really cool that you took this approach.  Sounds like
> > there was a lot of systematic work to fix up the sites in the existing
> > codebase.
> >
> > But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> > sparse" to find issues with missing untags.
> 
> Yes, this static approach can only be used as a hint to find some
> places where untagging is needed, but certainly not all.
> 
> > This seems like something
> > where we would ideally add an __tagged annotation (or something) to the
> > source tree and then have sparse rules that can look for missed untags.
> 
> This has been suggested before, search for __untagged here [1].
> However there are many places in the kernel where a __user pointer is
> casted into unsigned long and passed further. I'm not sure if it's
> possible apply a __tagged/__untagged kind of attribute to non-pointer
> types, is it?
> 
> [1] https://patchwork.kernel.org/patch/10581535/

It's something that should need to be added to sparse since it's
different from what sparse already have (the existing __bitwise and
concept of address-space doesn't seem to do the job here).

-- Luc Van Oostenryck

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
