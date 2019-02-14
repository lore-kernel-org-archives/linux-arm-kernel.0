Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:23:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8702222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5pqhGLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8702222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H8VWy21kpltjwRs1MefhprghEs/yV78crOJPjbD/RT0=; b=T5pqhGLEHwZFbL+0ePOSzUiT8
	gO3xgiUhFYzjqFERrPJK7Z2VWtmFTsEmKOhLNamBJGto73NDrMwm9F9Y1Ry3I210hjykJadAzKHSo
	lQaeg07w2KuDf9oBVkP3hEPDKrFk/ZAYBiYGtyK9DhbODHtmlPthldkrVX7BTDXu21Dwxl0oNoxgA
	eCUqkFUn6KHsb6AkuKdi2itDFQy+X8tKwEoF6bBqB3OK3LpP7NHERzaWZ6UyM+6GGC9TNDFnVkOw8
	QtLPatV6b7yLj8XrVBjMIqxpKZQ2hXb8mhSCtRi4szay6HsC6pM9+hpBl0/4BzFNmVZ1U8NXS/svL
	weXq8Nytw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guF6d-0004uy-DD; Thu, 14 Feb 2019 11:23:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guF6a-0004ua-Fp
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:23:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C283EBD;
 Thu, 14 Feb 2019 03:22:59 -0800 (PST)
Received: from [10.1.199.35] (e107154-lin.cambridge.arm.com [10.1.199.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EECD3F675;
 Thu, 14 Feb 2019 03:22:54 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
To: Evgenii Stepanov <eugenis@google.com>, Dave Martin <Dave.Martin@arm.com>
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
 <20190213174318.GM3567@e103592.cambridge.arm.com>
 <CAFKCwrgV0VNJ_jEU79XwkX0o7qLFcqh3MbVMg2=Vs8VKYyY9=Q@mail.gmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <8047504c-3b9d-0c46-c0cf-9d584f5ca241@arm.com>
Date: Thu, 14 Feb 2019 11:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAFKCwrgV0VNJ_jEU79XwkX0o7qLFcqh3MbVMg2=Vs8VKYyY9=Q@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_032300_536517_0E1EDD08 
X-CRM114-Status: GOOD (  31.07  )
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
 Linux Memory Management List <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Branislav Rankov <Branislav.Rankov@arm.com>,
 Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/02/2019 21:41, Evgenii Stepanov wrote:
> On Wed, Feb 13, 2019 at 9:43 AM Dave Martin <Dave.Martin@arm.com> wrote:
>> On Wed, Feb 13, 2019 at 04:42:11PM +0000, Kevin Brodsky wrote:
>>> (+Cc other people with MTE experience: Branislav, Ruben)
>> [...]
>>
>>>> I'm wondering whether we can piggy-back on existing concepts.
>>>>
>>>> We could say that recolouring memory is safe when and only when
>>>> unmapping of the page or removing permissions on the page (via
>>>> munmap/mremap/mprotect) would be safe.  Otherwise, the resulting
>>>> behaviour of the process is undefined.
>>> Is that a sufficient requirement? I don't think that anything prevents you
>>> from using mprotect() on say [vvar], but we don't necessarily want to map
>>> [vvar] as tagged. I'm not sure it's easy to define what "safe" would mean
>>> here.
>> I think the origin rules have to apply too: [vvar] is not a regular,
>> private page but a weird, shared thing mapped for you by the kernel.
>>
>> Presumably userspace _cannot_ do mprotect(PROT_WRITE) on it.
>>
>> I'm also assuming that userspace cannot recolour memory in read-only
>> pages.  That sounds bad if there's no way to prevent it.
> That sounds like something we would like to do to catch out of bounds
> read of .rodata globals.
> Another potentially interesting use case for MTE is infinite hardware
> watchpoints - that would require trapping reads for individual tagging
> granules, include those in read-only binary segment.

I think we should keep this discussion for a later, separate thread. Vincenzo's 
proposal is about allowing userspace to pass tags at the syscall interface. The set 
of mappings allowed to be tagged by userspace (in MTE) should be contained in the set 
of mappings that userspace can pass tagged pointers to (at the syscall interface), 
but they are not necessarily the same. Private read-only mappings are an edge case 
(you can pass tagged pointers to them, the memory may or may not be mapped as tagged, 
but in any case it is not possible to change the memory tags via such mapping).

>
>> [...]
>>
>>>> It might be reasonable to do the check in access_ok() and skip it in
>>>> __put_user() etc.
>>>>
>>>> (I seem to remember some separate discussion about abolishing
>>>> __put_user() and friends though, due to the accident risk they pose.)
>>> Keep in mind that with MTE, there is no need to do any explicit check when
>>> accessing user memory via a user-provided pointer. The tagged user pointer
>>> is directly passed to copy_*_user() or put_user(). If the load/store causes
>>> a tag fault, then it is handled just like a page fault (i.e. invoking the
>>> fixup handler). As far as I can tell, there's no need to do anything special
>>> in access_ok() in that case.
>>>
>>> [The above applies to precise mode. In imprecise mode, some more work will
>>> be needed after the load/store to check whether a tag fault happened.]
>> Fair enough, I'm a bit hazy on the details as of right now..
>>
>> [...]
>>
>>> There are many possible ways to deploy MTE, and debugging is just one of
>>> them. For instance, you may want to turn on heap colouring for some
>>> processes in the system, including in production.
>> To implement enforceable protection, or as a diagnostic tool for when
>> something goes wrong?
>>
>> In the latter case it's still OK for the kernel's tag checking not to be
>> exhaustive.
>>
>>> Regarding those cases where it is impossible to check tags at the point of
>>> accessing user memory, it is indeed possible to check the memory tags at the
>>> point of stripping the tag from the user pointer. Given that some MTE
>>> use-cases favour performance over tag check coverage, the ideal approach
>>> would be to make these checks configurable (e.g. check one granule, check
>>> all of them, or check none). I don't know how feasible this is in practice.
>> Check all granules of a massive DMA buffer?
>>
>> That doesn't sounds feasible without explicit support in the hardware to
>> have the DMA check tags itself as the memory is accessed.  MTE by itself
>> doesn't provide for this IIUC (at least, it would require support in the
>> platform, not just the CPU).
>>
>> We do not want to bake any assumptions into the ABI about whether a
>> given data transfer may or may not be offloaded to DMA.  That feels
>> like a slippery slope.
>>
>> Providing we get the checks for free in put_user/get_user/
>> copy_{to,from}_user(), those will cover a lot of cases though, for
>> non-bulk-IO cases.
>>
>>
>> My assumption has been that at this point in time we are mainly aiming
>> to support the debug/diagnostic use cases today.

MTE can be used both for diagnostics (imprecise mode is especially suitable for 
that), and to halt execution when something wrong is detected. Even in the latter 
case, one cannot expect exhaustive checking from MTE, because the way it works is 
fundamentally statistical; an invalid pointer may by chance have the right tag to 
access the given location. So again, I think that a best-effort approach is 
appropriate when the kernel accesses user memory, in terms of checking that tags match.

More specifically, different use-cases come with different tradeoffs (performance / 
tag check coverage). That's why I am suggesting that in the cases where tag checks 
would need to be done _explicitly_ (before losing the user-provided tag), it would be 
nice to be able to choose how much should be checked. I am not suggesting that always 
checking all the granules by default is sane. Maybe checking just the first granule 
is the right default.

I don't think we need to get to the bottom of this specific aspect at this point. 
This ABI proposal is not about memory tagging, so there is no need to specify how or 
when tag checking is done. As long as this ABI allows tagged pointers, pointing to 
mappings that could be potentially tagged, to be passed to syscalls, I don't think 
further relaxations are needed to enable memory tagging.

Kevin

>>
>> At least, those are the low(ish)-hanging fruit.
>>
>> Others are better placed than me to comment on the goals here.
>>
>> Cheers
>> ---Dave


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
