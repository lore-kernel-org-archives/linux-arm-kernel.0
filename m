Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E14F222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EzcF6H8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E14F222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FtL524/hYvBec1WlLXHWknZwRlS0gBOYSK86pBbtpDg=; b=EzcF6H8/dlGU09
	10lom/V1oZ4IVWDKltfwGjIXx31nwfAbFkFCbf5TNX8uckDi8MABe7NT3Vxnfjv8omnReJnwi14lw
	BIgItkJ72iku2J57rD6hIOKhdJG6WND8OLHKJh5wriWSR0skn7dyCAaPuQ8aogtkYPLaWddZsNai+
	oG5w8iKmerpNjQ6Ol2giKvzSkcvC7DbPsN+aJRLrotKkQna+x9GcNyap3p8rdLQxaG/BluhYz6Qtn
	7AjcDgWdhAB5FBDq+++Cnl/a50nTKQXmeJazJVRY8qhq4NKDoqWBjLO57CKIjFECMd3U5Cz+TJwkl
	q7nk22KqaRS2yK30ur5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvzu-0000zz-MY; Wed, 13 Feb 2019 14:58:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtvzr-0000z2-2Q
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:58:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDAAD80D;
 Wed, 13 Feb 2019 06:58:44 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 145323F589;
 Wed, 13 Feb 2019 06:58:39 -0800 (PST)
Date: Wed, 13 Feb 2019 14:58:37 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20190213145834.GJ3567@e103592.cambridge.arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212180223.GD199333@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_065847_124131_D7CE4762 
X-CRM114-Status: GOOD (  38.19  )
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
 Lee Smith <Lee.Smith@arm.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 06:02:24PM +0000, Catalin Marinas wrote:
> On Mon, Feb 11, 2019 at 12:32:55PM -0800, Evgenii Stepanov wrote:
> > On Mon, Feb 11, 2019 at 9:28 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > > On 19/12/2018 12:52, Dave Martin wrote:

[...]

> > > >   * A single C object should be accessed using a single, fixed
> > > >     pointer tag throughout its entire lifetime.
> > >
> > > Agreed.  Allocators themselves may need to be excluded though,
> > > depending on how they represent their managed memory.
> > >
> > > >   * Tags can be changed only when there are no outstanding pointers to
> > > >     the affected object or region that may be used to access the object
> > > >     or region (i.e., if the object were allocated from the C heap and
> > > >     is it safe to realloc() it, then it is safe to change the tag; for
> > > >     other types of allocation, analogous arguments can be applied).
> > >
> > > Tags can only be changed at the point of deallocation/
> > > reallocation.  Pointers to the object become invalid and cannot
> > > be used after it has been deallocated; memory tagging allows to
> > > catch such invalid usage.
>
> All the above sound well but that's mostly a guideline on what a C
> library can do. It doesn't help much with defining the kernel ABI.
> Anyway, it's good to clarify the use-cases.

My aim was to clarify the use case in userspace, since I wasn't directly
involved in that.  The kernel ABI needs to be compatible with the the
use case, but doesn't need to specify must of it.

I'm wondering whether we can piggy-back on existing concepts.

We could say that recolouring memory is safe when and only when
unmapping of the page or removing permissions on the page (via
munmap/mremap/mprotect) would be safe.  Otherwise, the resulting
behaviour of the process is undefined.

Hopefully there are friendly fuzzers testing this kind of thing.

[...]

> > It would also be valuable to narrow down the set of "relaxed" (i.e.
> > not tag-checking) syscalls as reasonably possible. We would want to
> > provide tag-checking userspace wrappers for any important calls that
> > are not checked in the kernel. Is it correct to assume that anything
> > that goes through copy_from_user  / copy_to_user is checked?
> 
> I lost track of the context of this thread but if it's just about
> relaxing the ABI for hwasan, the kernel has no idea of the compiler
> generated structures in user space, so nothing is checked.
> 
> If we talk about tags in the context of MTE, than yes, with the current
> proposal the tag would be checked by copy_*_user() functions.

Also put_user() and friends?

It might be reasonable to do the check in access_ok() and skip it in
__put_user() etc.

(I seem to remember some separate discussion about abolishing
__put_user() and friends though, due to the accident risk they pose.)

> > For aio* operations it would be nice if the tag was checked at the
> > time of the actual userspace read/write, either instead of or in
> > addition to at the time of the system call.
> 
> With aio* (and synchronous iovec-based syscalls), the kernel may access
> the memory while the corresponding user process is scheduled out. Given
> that such access is not done in the context of the user process (and
> using the user VA like copy_*_user), the kernel cannot handle potential
> tag faults. Moreover, the transfer may be done by DMA and the device
> does not understand tags.
> 
> I'd like to keep tags as a property of the pointer in a specific virtual
> address space. The moment you convert it to a different address space
> (e.g. kernel linear map, physical address), the tag property is stripped
> and I don't think we should re-build it (and have it checked).

This is probably reasonable.

Ideally we would check the tag at the point of stripping it off, but
most likely it's going to be rather best-effort.

If memory tagging is essential a debugging feature then this seems
an acceptable compromise.

> > > >   * For purposes other than dereference, the kernel shall accept any
> > > >     legitimately tagged pointer (according to the above rules) as
> > > >     identifying the associated memory location.
> > > >
> > > >     So, mprotect(some_page_aligned_object, ...); is valid irrespective
> > > >     of where page_aligned_object() came from.  There is no implicit
> > > >     derefence by the kernel here, hence no tag check.
> > > >
> > > >     The kernel does not guarantee to work correctly if the wrong tag
> > > >     is used, but there is not always a well-defined "right" tag, so
> > > >     we can't really guarantee to check it.  So a pointer derived by
> > > >     any reasonable means by userspace has to be treated as equally
> > > >     valid.
> > >
> > > This is a disputed point :) In my opinion, this is the the most
> > > reasonable approach.
> > 
> > Yes, it would be nice if the kernel explicitly promised, ex.
> > mprotect() over a range of differently tagged pages to be allowed
> > (i.e. address tag should be unchecked).
> 
> I don't think mprotect() over differently tagged pages was ever a
> problem. I originally asked that mprotect() and friends do not accept
> tagged pointers since these functions deal with memory ranges rather
> than dereferencing such pointer (the reason being minimal kernel
> changes). However, given how complicated it is to specify an ABI, I came
> to the conclusion that a pointer passed to such function should be
> allowed to have non-zero top byte. It would be the kernel's
> responsibility to strip it out as appropriate.

I think that if the page range is all the same colour then it should be
legitimate to pass a matching tag.

But it doesn't seem reasonable for the kernel to require this.  If
free() calls munmap(), the page(s) will contain possibly randomly-
coloured garbage.  There's no correct tag to pass in such a case.

The most obvious solution is just to ignore the tags passed by userspace
to such syscalls.  This would imply that the kernel must explicitly
strip it out, as you suggest.

The number of affected syscalls is relatively small though.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
