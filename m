Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35019C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABD42075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ulKaQb5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABD42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FbVFs+JXn0JPllePM3Scwe59bMxVcxuU88qSBu09zNA=; b=ulKaQb5UFTzALF
	N6dQkgJVvC0c2vzHc/UYubcTA145I5GqMoGSJpFtnP7nxrGKQU2mApXKxBAYz06txd+3P7q4RIwOO
	eJctjWkaVt/OKxcVf1GJuAtnEqtlO7sqQ5p0aISV3/LtArrtHZd4netnqZ5lBissC8FbHBkvREFVk
	a2nzZCexd9iAUVk6m0DIZw+oSu9Dnk6IzLSOqVg0Hz+xnGgRBZ9LIpYrlq6/dQsYAv10k3BLRpZ3n
	dUSvTjMc8zk5u+Y46f4+2GEN1A97kLGT0ALfxhO6MLkmCE7fcZlM10wy6kzrc+q8qfyHfB9LQKFIh
	4dVzrlHV03v6g1L+BAYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEyc-0003rf-EH; Mon, 11 Feb 2019 17:02:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEyP-0003kT-JD
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 17:02:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBEC780D;
 Mon, 11 Feb 2019 09:02:22 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF053F675;
 Mon, 11 Feb 2019 09:02:18 -0800 (PST)
Date: Mon, 11 Feb 2019 17:02:16 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 0/8] arm64: untag user pointers passed to the kernel
Message-ID: <20190211170212.GH3567@e103592.cambridge.arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181212170108.GZ3505@e103592.cambridge.arm.com>
 <20190211113511.GA165128@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211113511.GA165128@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_090225_807057_60D3D4E5 
X-CRM114-Status: GOOD (  40.61  )
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
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>,
 linux-kselftest@vger.kernel.org, Chintan Pandya <cpandya@codeaurora.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 11:35:12AM +0000, Catalin Marinas wrote:
> Hi Dave,
> 
> On Wed, Dec 12, 2018 at 05:01:12PM +0000, Dave P Martin wrote:
> > On Mon, Dec 10, 2018 at 01:50:57PM +0100, Andrey Konovalov wrote:
> > > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > > tags into the top byte of each pointer. Userspace programs (such as
> > > HWASan, a memory debugging tool [1]) might use this feature and pass
> > > tagged user pointers to the kernel through syscalls or other interfaces.
> [...]
> > It looks like there's been a lot of progress made here towards smoking
> > out most of the sites in the kernel where pointers need to be untagged.
> 
> In summary, based on last summer's analysis, there are two main (and
> rather broad) scenarios of __user pointers use in the kernel: (a)
> uaccess macros, together with access_ok() checks and (b) identifying
> of user address ranges (find_vma() and related, some ioctls). The
> patches here handle the former by allowing sign-extension in access_ok()
> and subsequent uaccess routines work fine with tagged pointers.
> Identifying the latter is a bit more problematic and the approach we
> took was tracking down pointer to long conversion which seems to cover
> the majority of cases. However, this approach doesn't scale as, for
> example, we'd rather change get_user_pages() to sign-extend the address
> rather than all the callers. In lots of other cases we don't even need
> untagging as we don't expect user space to tag such pointers (i.e.
> mmap() of device memory).
> 
> We might be able to improve the static analysis by introducing a
> virt_addr_t but that's significant effort and we still won't cover all
> cases (e.g. it doesn't necessarily catch tcp_zerocopy_receive() which
> wouldn't use a pointer, just a u64 for address).
> 
> > However, I do think that we need a clear policy for how existing kernel
> > interfaces are to be interpreted in the presence of tagged pointers.
> > Unless we have that nailed down, we are likely to be able to make only
> > vague guarantees to userspace about what works, and the ongoing risk
> > of ABI regressions and inconsistencies seems high.
> 
> I agree.
> 
> > Can we define an opt-in for tagged-pointer userspace, that rejects all
> > syscalls that we haven't checked and whitelisted (or that are
> > uncheckable like ioctl)? 
> 
> Defining an opt-in is not a problem, however, rejecting all syscalls
> that we haven't whitelisted is not feasible. We can have an opt-in per
> process (that's what we were going to do with MTE) but the only thing
> we can reasonably do is change the behaviour of access_ok(). That's too
> big a knob and a new syscall that we haven't got around to whitelist may
> just work. This eventually leads to de-facto ABI and our whitelist would
> simply be ignored.
> 
> I'm not really keen on a big syscall shim in the arm64 kernel which
> checks syscall arguments, including in-struct values. If we are to do
> this, I'd rather keep it in user space as part of the C library.
> 
> > In the meantime, I think we really need to nail down the kernel's
> > policies on
> > 
> >  * in the default configuration (without opt-in), is the presence of
> > non-address bits in pointers exchanged with the kernel simply
> > considered broken?  (Even with this series, the de factor answer
> > generally seems to be "yes", although many specific things will now
> > work fine)
> 
> Without these patches, passing non-address bits in pointers is
> considered broken. I couldn't find a case where it would still work with
> non-zero tag but maybe I haven't looked hard enough.
> 
> >  * if not, how do we tighten syscall / interface specifications to
> > describe what happens with pointers containing non-address bits, while
> > keeping the existing behaviour for untagged pointers?
> > 
> > We would want a general recipe that gives clear guidance on what
> > userspace should expect an arbitrarily chosen syscall to do with its
> > pointers, without having to enumerate each and every case.
> 
> That's what we are aiming with the pointer origins, to move away from a
> syscall whitelist to a generic definition. That said, the two approaches
> are orthogonal, we can use the pointer origins as the base rule for
> which syscalls can be whitelisted.
> 
> If we step back a bit to look at the use-case for TBI (and MTE), the
> normal application programmer shouldn't really care about this ABI
> (well, most of the time). The app gets a tagged pointer from the C
> library as a result of a malloc()/realloc() (possibly alloca()) call and
> it expects to be able to pass it back into the kernel (usually via the C
> library) without any awareness of the non-address bits. Now, we can't
> define a user/kernel ABI based on the provenance of the pointer in user
> space (i.e. we only support tags for heap and stack), so we are trying
> to generalise this based where the pointer originated from in the kernel
> (e.g. anonymous mmap()).

This sounds generally reasonable.

It is not adequate for describing changing the tag on already-tagged
memory (which a memory allocator will definitely do), but we may be able
to come up with some weasel words to cover that.

It is also not adequete for describing tagging (and retagging) regions
of the stack -- but as you say, we can rule that use-case out for now
in the interest of simplicity, since we know we wouldn't be able to
deploy it widely for now anyway due to the incompability with non-MTE-
capable hardware.


Ideally we would clarify user/kernel interface semantics in terms of
object and pointer lifetimes and accessibility, but that's a larger
project that should be pursued separately (if at all).

I could also quibble about whether "anonymous mmap" is the right thing
here -- we should still give specific examples of things that do / don't
qualify, to make it clear what we mean.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
