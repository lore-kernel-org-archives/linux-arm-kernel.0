Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:18:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D818218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RiJgsXuz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YX+nY/00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D818218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A+TRligXjvQifUKAt2CV6otv95TEfpIBVW92MPhxqHo=; b=RiJgsXuzw4dFdf
	LjGqBqmHFtky6op3VJOqQi2cLWR8THFpxKW6ZsuexKMomCvS6ILmGM5yKdumhMQ8ceZoQ7e0e+szm
	q/EtxW8s6e6ekrBCI58xlL7P7KTZOR8bhukFzdJN3uu8m5iglWTvzC8uzT5BUOhIk+OJE0Bqeq7O4
	yRmIOra9piWCnoh6NqZhEbOzKczjvAN47+oNPNWTEu6hW9MINOkqXLv8fgAPbsuANVKkMqdAGehxG
	0GmXEeTwj2lQrmksn/m58Fru3HXa8h95gN3cROUfDvNprmykj+jhJbdDTN+C4CtSntoZ17S4A/3j9
	KGv3GrIVF+AWTUxNsvOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJ0L-00015u-66; Tue, 18 Dec 2018 17:18:01 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJ0E-000146-HI
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:17:59 +0000
Received: by mail-pl1-x641.google.com with SMTP id y1so8098460plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=442vwuYNQl3+5+R2IJ9SAnj2SpikSYGCJwnnp94ndjs=;
 b=YX+nY/00hzrzrhGcabJW/utVNQDVyaI34CjDeDXKdc+Rseslqj7UR8Ddf5oCmldnMu
 NOITKWcZM2vowIlLpKt8CFETsRtFUdkcTxML5wsC57nFe7RVhaopiw/fpJa930YD6t74
 8qfLKIhzkFAR5R0nPvqEbmcfgcUKGMA6Pr7RQPrUBaub+zeGk0TkNL69RRZVX/uaowCb
 pBoU6GGUSJhH5lfPOab4FTFUAf665kyCMpzfWH3BAUmlCElkBEhTU3/yWqBfbVQOOKaR
 C5LvriU6dLuNtMc9zhUa7YvuK42A2ONFp1wckXdby+ZB+ujj9fA/of8OCMQ/xJH6B8mW
 JIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=442vwuYNQl3+5+R2IJ9SAnj2SpikSYGCJwnnp94ndjs=;
 b=EPNyzHT7IUKOLTUOSEhy1jZPZNXuHbw0rEw26XBAUNhtg02AYA+jv0VQufLXoa6KBe
 J/tzlPOJgGNWHd56KNBd7NjPyCmNe43GUGCgTDobAF7lR9QqvV+nsljnKaKMtwVrz193
 wplZdLbpLsVKUuGxcZW1PKpn9/lqiq6SHnF0bUswA/gDIHqKhbvnCRHGaBja23FMVrnu
 3dQ2uq3iC8EcmKnxNfJUKeWmTP+OZF8UwXPDGPW2gxFP6jBAGZlg94dX34WWYdCh7PKA
 u5S8ouGOjOM/6fJ6VO7jKRhc9vFQFY2/3vHQTDDD31T0EzdiZ8Qe1W2yVtLguM5tQsxy
 hmdQ==
X-Gm-Message-State: AA+aEWaWl+jritfUnpowt2xQk5CrhZxeG3iGEHBwZSVgFKbmB8ShEv00
 esSTD34VQGBlGbDR78uESwGTQ0d3hxFpSldVbNN/KQ==
X-Google-Smtp-Source: AFSGD/XG6prkkaGhEvsMh8RZmmoz4vN18xdqZlmvYKp7Ep4oBBgcJW+0c2dBBYrLaiWSMA/XFYvCi2eisvSYSxagorI=
X-Received: by 2002:a17:902:b406:: with SMTP id
 x6mr16359864plr.329.1545153463562; 
 Tue, 18 Dec 2018 09:17:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181212170108.GZ3505@e103592.cambridge.arm.com>
In-Reply-To: <20181212170108.GZ3505@e103592.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 18 Dec 2018 18:17:31 +0100
Message-ID: <CAAeHK+zf=qxfk0yRp-yb7rAJLFdUXJdidq5tA-x8-EBdV7kE7A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] arm64: untag user pointers passed to the kernel
To: Dave Martin <Dave.Martin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_091757_229746_02EF2643 
X-CRM114-Status: GOOD (  39.23  )
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
 Kostya Serebryany <kcc@google.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
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

On Wed, Dec 12, 2018 at 6:01 PM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Dec 10, 2018 at 01:50:57PM +0100, Andrey Konovalov wrote:
> > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > tags into the top byte of each pointer. Userspace programs (such as
> > HWASan, a memory debugging tool [1]) might use this feature and pass
> > tagged user pointers to the kernel through syscalls or other interfaces.
> >
> > Right now the kernel is already able to handle user faults with tagged
> > pointers, due to these patches:
> >
> > 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
> >              tagged pointer")
> > 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> >               pointers")
> > 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> >               pointers")
> >
> > When passing tagged pointers to syscalls, there's a special case of such a
> > pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
> > These syscalls don't do memory accesses but rather deal with memory
> > ranges, hence an untagged pointer is better suited.
> >
> > This patchset extends tagged pointer support to non-memory syscalls. This
> > is done by reusing the untagged_addr macro to untag user pointers when the
> > kernel performs pointer checking to find out whether the pointer comes
> > from userspace (most notably in access_ok). The untagging is done only
> > when the pointer is being checked, the tag is preserved as the pointer
> > makes its way through the kernel.
> >
> > One of the alternative approaches to untagging that was considered is to
> > completely strip the pointer tag as the pointer enters the kernel with
> > some kind of a syscall wrapper, but that won't work with the countless
> > number of different ioctl calls. With this approach we would need a custom
> > wrapper for each ioctl variation, which doesn't seem practical.
> >
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [2] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
> >
> > 2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
> >    a modified syzkaller version that passes tagged pointers to the kernel.
> >
> > Based on the results of the testing the requried patches have been added
> > to the patchset.
> >
> > This patchset has been merged into the Pixel 2 kernel tree and is now
> > being used to enable testing of Pixel 2 phones with HWASan.

Hi, Dave,

>
> Do you have an idea of how much of the user/kernel interface is covered
> by this workload?

Not really. I don't even know what kind of measurements can be used to
obtain this estimate. But Pixel 2 kernel with these patches + Android
runtime instrumented with HWASan works.

>
> > This patchset is a prerequisite for ARM's memory tagging hardware feature
> > support [3].
>
> It looks like there's been a lot of progress made here towards smoking
> out most of the sites in the kernel where pointers need to be untagged.
>
> However, I do think that we need a clear policy for how existing kernel
> interfaces are to be interpreted in the presence of tagged pointers.
> Unless we have that nailed down, we are likely to be able to make only
> vague guarantees to userspace about what works, and the ongoing risk
> of ABI regressions and inconsistencies seems high.
>
> I don't really see how we can advertise a full system interface if we
> know some subset of it doesn't work for foreseeable userspace
> environments.  I feel that presenting the current changes as an ABI
> relaxation may be a recipe for future problems, since the forwards
> compatibility guarantees we're able to make today are few and rather
> vague.
>
> Can we define an opt-in for tagged-pointer userspace, that rejects all
> syscalls that we haven't checked and whitelisted (or that are
> uncheckable like ioctl)?  This reflects the reality that we don't have
> a regular userspace environment in which standards-compliant software
> that uses address tags in a reasonable way will just work.
>
> It might be feasible to promote this to be enabled by default later on,
> if it becomes sufficiently complete.
>
>
> In the meantime, I think we really need to nail down the kernel's
> policies on
>
>  * in the default configuration (without opt-in), is the presence of
> non-address bits in pointers exchanged with the kernel simply
> considered broken?  (Even with this series, the de factor answer
> generally seems to be "yes", although many specific things will now
> work fine)
>
>  * if not, how do we tighten syscall / interface specifications to
> describe what happens with pointers containing non-address bits, while
> keeping the existing behaviour for untagged pointers?
>
> We would want a general recipe that gives clear guidance on what
> userspace should expect an arbitrarily chosen syscall to do with its
> pointers, without having to enumerate each and every case.
>
> To be sustainable, we would also need to solve that in a way that
> doesn't need to be reintented per-arch.

As I understand your main concern is userspace/kernel ABI changes
these patches introduce. This concern was already pointed out by
Catalin, and working out the details is still in progress.

>
> There may already be some background on these topics -- can you throw me
> a link if so?

I don't have a single link, I would suggest to look at the comments
for all the previous versions of this patchset. I see you saw the
pathset by Vincenzo, it also has some information about this.

>
> Cheers
> ---Dave

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
