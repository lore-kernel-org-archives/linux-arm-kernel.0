Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058EAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92072080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTk3cRky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92072080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LwnxOTmlcQbLZO5ohKuXnLvG61IVgHZ/SHfCFhbXNdA=; b=bTk3cRkyNL4l78
	7gmC5uIcFNLn1o/ivzZWzzDrPtLRRJUKMtslA5XB90U+F1B/dvzLvToi8oGg2rLqZIPGN21bZsrlQ
	m+L64eHC7I66mbrXUzx0Mk+MPv/H+S8cHZ7vW2bv/3Q0FL8T06gDl17V/0Eox3Obl0Tc8tHwfx43T
	oNO4vi8K3Rq4QPTNKFA3U7JQWaZx53j6UE1bGB2Fd1+WYhYFlED6YrdLoPcuZKNkZepffyIj3vkYY
	P5dWiQVs+cd3zey+e6FXtJl9QFkNyCU43fQXDqPfawzPHZ8/XAzwJdZuM5t7/9ZnGr+9IZjaIaeLn
	dRREWyS58HuyZZwFnF1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7tA-00056R-8e; Wed, 12 Dec 2018 17:01:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7t3-00055r-QS
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:01:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D4A80D;
 Wed, 12 Dec 2018 09:01:19 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDEF63F575;
 Wed, 12 Dec 2018 09:01:14 -0800 (PST)
Date: Wed, 12 Dec 2018 17:01:12 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v9 0/8] arm64: untag user pointers passed to the kernel
Message-ID: <20181212170108.GZ3505@e103592.cambridge.arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_090129_867387_6DC94266 
X-CRM114-Status: GOOD (  31.47  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>, linux-kselftest@vger.kernel.org,
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
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

On Mon, Dec 10, 2018 at 01:50:57PM +0100, Andrey Konovalov wrote:
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> Right now the kernel is already able to handle user faults with tagged
> pointers, due to these patches:
> 
> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>              tagged pointer")
> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
>               pointers")
> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
>               pointers")
> 
> When passing tagged pointers to syscalls, there's a special case of such a
> pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
> These syscalls don't do memory accesses but rather deal with memory
> ranges, hence an untagged pointer is better suited.
> 
> This patchset extends tagged pointer support to non-memory syscalls. This
> is done by reusing the untagged_addr macro to untag user pointers when the
> kernel performs pointer checking to find out whether the pointer comes
> from userspace (most notably in access_ok). The untagging is done only
> when the pointer is being checked, the tag is preserved as the pointer
> makes its way through the kernel.
> 
> One of the alternative approaches to untagging that was considered is to
> completely strip the pointer tag as the pointer enters the kernel with
> some kind of a syscall wrapper, but that won't work with the countless
> number of different ioctl calls. With this approach we would need a custom
> wrapper for each ioctl variation, which doesn't seem practical.
> 
> The following testing approaches has been taken to find potential issues
> with user pointer untagging:
> 
> 1. Static testing (with sparse [2] and separately with a custom static
>    analyzer based on Clang) to track casts of __user pointers to integer
>    types to find places where untagging needs to be done.
> 
> 2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
>    a modified syzkaller version that passes tagged pointers to the kernel.
> 
> Based on the results of the testing the requried patches have been added
> to the patchset.
> 
> This patchset has been merged into the Pixel 2 kernel tree and is now
> being used to enable testing of Pixel 2 phones with HWASan.

Do you have an idea of how much of the user/kernel interface is covered
by this workload?

> This patchset is a prerequisite for ARM's memory tagging hardware feature
> support [3].

It looks like there's been a lot of progress made here towards smoking
out most of the sites in the kernel where pointers need to be untagged.

However, I do think that we need a clear policy for how existing kernel
interfaces are to be interpreted in the presence of tagged pointers.
Unless we have that nailed down, we are likely to be able to make only
vague guarantees to userspace about what works, and the ongoing risk
of ABI regressions and inconsistencies seems high.

I don't really see how we can advertise a full system interface if we
know some subset of it doesn't work for foreseeable userspace
environments.  I feel that presenting the current changes as an ABI
relaxation may be a recipe for future problems, since the forwards
compatibility guarantees we're able to make today are few and rather
vague.

Can we define an opt-in for tagged-pointer userspace, that rejects all
syscalls that we haven't checked and whitelisted (or that are
uncheckable like ioctl)?  This reflects the reality that we don't have
a regular userspace environment in which standards-compliant software
that uses address tags in a reasonable way will just work.

It might be feasible to promote this to be enabled by default later on,
if it becomes sufficiently complete.


In the meantime, I think we really need to nail down the kernel's
policies on

 * in the default configuration (without opt-in), is the presence of
non-address bits in pointers exchanged with the kernel simply
considered broken?  (Even with this series, the de factor answer
generally seems to be "yes", although many specific things will now
work fine)

 * if not, how do we tighten syscall / interface specifications to
describe what happens with pointers containing non-address bits, while
keeping the existing behaviour for untagged pointers?

We would want a general recipe that gives clear guidance on what
userspace should expect an arbitrarily chosen syscall to do with its
pointers, without having to enumerate each and every case.

To be sustainable, we would also need to solve that in a way that
doesn't need to be reintented per-arch.


There may already be some background on these topics -- can you throw me
a link if so?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
