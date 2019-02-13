Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D977C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CCD20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8FWOlTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CCD20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JvhJmLdHvdpLNgciYrSyx8MaBIw/rzNe9EvgqFGknVE=; b=L8FWOlTR5WZeRo
	m2XrZbA/97kViNg/heoqEGi5l+3gPv7uPAfaRYm8jxOOU4OCwhi59HlpLcDqZF2NcBd34TJuuTEal
	j+xORp5BWZzfS1qy7xlxduRNphHsYjFXATAu/V7tHAzbw5wZSRb7665FGIesNjVQN9uJRhopetbam
	Pgj/g8C37OuRhDf9lBiHSkpeqianYctZanCDtIDSyCksfkfYL+iWs9swYT3fbs2lNEU0xLNjnjnOP
	TECRGXgTz6X513KBPB/j4S3K1JqQsrUBayWlMarjy4yh9L8FU3ZpKGwg1t3VfEgw1HaP3JHyGjYju
	fFfV19H55eEVjUVogVkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyZL-0004B9-Js; Wed, 13 Feb 2019 17:43:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyZE-0003MF-2r
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:43:30 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098A6A78;
 Wed, 13 Feb 2019 09:43:27 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F30E3F675;
 Wed, 13 Feb 2019 09:43:22 -0800 (PST)
Date: Wed, 13 Feb 2019 17:43:19 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20190213174318.GM3567@e103592.cambridge.arm.com>
References: <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
 <20190213145834.GJ3567@e103592.cambridge.arm.com>
 <90c54249-00dd-f8dd-6873-6bb8615c2c8a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90c54249-00dd-f8dd-6873-6bb8615c2c8a@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_094328_360816_53CE3725 
X-CRM114-Status: GOOD (  26.25  )
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
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Branislav Rankov <Branislav.Rankov@arm.com>,
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

On Wed, Feb 13, 2019 at 04:42:11PM +0000, Kevin Brodsky wrote:
> (+Cc other people with MTE experience: Branislav, Ruben)

[...]

> >I'm wondering whether we can piggy-back on existing concepts.
> >
> >We could say that recolouring memory is safe when and only when
> >unmapping of the page or removing permissions on the page (via
> >munmap/mremap/mprotect) would be safe.  Otherwise, the resulting
> >behaviour of the process is undefined.
> 
> Is that a sufficient requirement? I don't think that anything prevents you
> from using mprotect() on say [vvar], but we don't necessarily want to map
> [vvar] as tagged. I'm not sure it's easy to define what "safe" would mean
> here.

I think the origin rules have to apply too: [vvar] is not a regular,
private page but a weird, shared thing mapped for you by the kernel.

Presumably userspace _cannot_ do mprotect(PROT_WRITE) on it.

I'm also assuming that userspace cannot recolour memory in read-only
pages.  That sounds bad if there's no way to prevent it.

[...]

> >It might be reasonable to do the check in access_ok() and skip it in
> >__put_user() etc.
> >
> >(I seem to remember some separate discussion about abolishing
> >__put_user() and friends though, due to the accident risk they pose.)
> 
> Keep in mind that with MTE, there is no need to do any explicit check when
> accessing user memory via a user-provided pointer. The tagged user pointer
> is directly passed to copy_*_user() or put_user(). If the load/store causes
> a tag fault, then it is handled just like a page fault (i.e. invoking the
> fixup handler). As far as I can tell, there's no need to do anything special
> in access_ok() in that case.
> 
> [The above applies to precise mode. In imprecise mode, some more work will
> be needed after the load/store to check whether a tag fault happened.]

Fair enough, I'm a bit hazy on the details as of right now..

[...]

> There are many possible ways to deploy MTE, and debugging is just one of
> them. For instance, you may want to turn on heap colouring for some
> processes in the system, including in production.

To implement enforceable protection, or as a diagnostic tool for when
something goes wrong?

In the latter case it's still OK for the kernel's tag checking not to be
exhaustive.

> Regarding those cases where it is impossible to check tags at the point of
> accessing user memory, it is indeed possible to check the memory tags at the
> point of stripping the tag from the user pointer. Given that some MTE
> use-cases favour performance over tag check coverage, the ideal approach
> would be to make these checks configurable (e.g. check one granule, check
> all of them, or check none). I don't know how feasible this is in practice.

Check all granules of a massive DMA buffer?

That doesn't sounds feasible without explicit support in the hardware to
have the DMA check tags itself as the memory is accessed.  MTE by itself
doesn't provide for this IIUC (at least, it would require support in the
platform, not just the CPU).

We do not want to bake any assumptions into the ABI about whether a
given data transfer may or may not be offloaded to DMA.  That feels
like a slippery slope.

Providing we get the checks for free in put_user/get_user/
copy_{to,from}_user(), those will cover a lot of cases though, for
non-bulk-IO cases.


My assumption has been that at this point in time we are mainly aiming
to support the debug/diagnostic use cases today.

At least, those are the low(ish)-hanging fruit.

Others are better placed than me to comment on the goals here.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
