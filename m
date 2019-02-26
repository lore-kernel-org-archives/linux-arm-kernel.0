Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:31:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B72A217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hc+vDufa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B72A217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zm1eDy2SbzPXbHJEfnLVzgFzA29Nd6EUsgo/OZaCUWg=; b=Hc+vDufaKCzoh7q+9xkKYxcN3
	BrsxRWf0AVTpDB55K1iMhoL7ZWNaR2vNuoRoFhx0mFHl6vIDDRnAu/FFrCAzBzh0KfM9KRkfcsr6+
	p9eqvdZeJ9nIBVoIaPE5XG3MkNH1Ks076jORZYQzMFWxUuiob6ABh51PrOvazQenrJL2kvgDReGQE
	i7j3aIcgK1SYchTVy+ahQAm2t4e2x5wy/SIH10uHfzCPXGvIhBSHjcJbnD0w3JrI67ys2HbYMFWxV
	moIlxDx75jYoSoOeP4P6O2DE31ebeBtJ4GE5tDH+iixFijLQCVknag+cTOlaQTDUbGpMv9S7/W+/m
	3cGlEeEbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygZO-0003uy-CM; Tue, 26 Feb 2019 17:31:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygZL-0003u7-Fp
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:31:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8278B80D;
 Tue, 26 Feb 2019 09:31:01 -0800 (PST)
Received: from [10.1.199.35] (e107154-lin.cambridge.arm.com [10.1.199.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D92C3F738;
 Tue, 26 Feb 2019 09:30:56 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>
References: <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
 <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
 <20190225165720.GA79300@arrakis.emea.arm.com>
 <7afa18b8-f135-036d-943c-b6216e7da481@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <4a301222-e6bd-dda8-ebef-da724bb15028@arm.com>
Date: Tue, 26 Feb 2019 17:30:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7afa18b8-f135-036d-943c-b6216e7da481@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_093103_540807_B3FE0BEB 
X-CRM114-Status: GOOD (  29.36  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Dave P Martin <Dave.Martin@arm.com>, Evgenii Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 25/02/2019 18:02, Szabolcs Nagy wrote:
> On 25/02/2019 16:57, Catalin Marinas wrote:
>> On Tue, Feb 19, 2019 at 06:38:31PM +0000, Szabolcs Nagy wrote:
>>> i think these rules work for the cases i care about, a more
>>> tricky question is when/how to check for the new syscall abi
>>> and when/how the TCR_EL1.TBI0 setting may be turned off.
>> I don't think turning TBI0 off is critical (it's handy for PAC with
>> 52-bit VA but then it's short-lived if you want more security features
>> like MTE).
> yes, i made a mistake assuming TBI0 off is
> required for (or at least compatible with) MTE.
>
> if TBI0 needs to be on for MTE then some of my
> analysis is wrong, and i expect TBI0 to be on
> in the foreseeable future.
>
>>> consider the following cases (tb == top byte):
>>>
>>> binary 1: user tb = any, syscall tb = 0
>>>    tbi is on, "legacy binary"
>>>
>>> binary 2: user tb = any, syscall tb = any
>>>    tbi is on, "new binary using tb"
>>>    for backward compat it needs to check for new syscall abi.
>>>
>>> binary 3: user tb = 0, syscall tb = 0
>>>    tbi can be off, "new binary",
>>>    binary is marked to indicate unused tb,
>>>    kernel may turn tbi off: additional pac bits.
>>>
>>> binary 4: user tb = mte, syscall tb = mte
>>>    like binary 3, but with mte, "new binary using mte"
> so this should be "like binary 2, but with mte".
>
>>>    does it have to check for new syscall abi?
>>>    or MTE HWCAP would imply it?
>>>    (is it possible to use mte without new syscall abi?)
>> I think MTE HWCAP should imply it.
>>
>>> in userspace we want most binaries to be like binary 3 and 4
>>> eventually, i.e. marked as not-relying-on-tbi, if a dso is
>>> loaded that is unmarked (legacy or new tb user), then either
>>> the load fails (e.g. if mte is already used? or can we turn
>>> mte off at runtime?) or tbi has to be enabled (prctl? does
>>> this work with pac? or multi-threads?).
>> We could enable it via prctl. That's the plan for MTE as well (in
>> addition maybe to some ELF flag).
>>
>>> as for checking the new syscall abi: i don't see much semantic
>>> difference between AT_HWCAP and AT_FLAGS (either way, the user
>>> has to check a feature flag before using the feature of the
>>> underlying system and it does not matter much if it's a syscall
>>> abi feature or cpu feature), but i don't see anything wrong
>>> with AT_FLAGS if the kernel prefers that.
>> The AT_FLAGS is aimed at capturing binary 2 case above, i.e. the
>> relaxation of the syscall ABI to accept tb = any. The MTE support will
>> have its own AT_HWCAP, likely in addition to AT_FLAGS. Arguably,
>> AT_FLAGS is either redundant here if MTE implies it (and no harm in
>> keeping it around) or the meaning is different: a tb != 0 may be checked
>> by the kernel against the allocation tag (i.e. get_user() could fail,
>> the tag is not entirely ignored).
>>
>>> the discussion here was mostly about binary 2,
>> That's because passing tb != 0 into the syscall ABI is the main blocker
>> here that needs clearing out before merging the MTE support. There is,
>> of course, a variation of binary 1 for MTE:
>>
>> binary 5: user tb = mte, syscall tb = 0
>>
>> but this requires a lot of C lib changes to support properly.
> yes, i don't think we want to do that.
>
> but it's ok to have both syscall tbi AT_FLAGS and MTE HWCAP.
>
>>> but for
>>> me the open question is if we can make binary 3/4 work.
>>> (which requires some elf binary marking, that is recognised
>>> by the kernel and dynamic loader, and efficient handling of
>>> the TBI0 bit, ..if it's not possible, then i don't see how
>>> mte will be deployed).
>> If we ignore binary 3, we can keep TBI0 = 1 permanently, whether we have
>> MTE or not.
>>
>>> and i guess on the kernel side the open question is if the
>>> rules 1/2/3/4 can be made to work in corner cases e.g. when
>>> pointers embedded into structs are passed down in ioctl.
>> We've been trying to track these down since last summer and we came to
>> the conclusion that it should be (mostly) fine for the non-weird memory
>> described above.
> i think an interesting case is when userspace passes
> a pointer to the kernel and later gets it back,
> which is why i proposed rule 4 (kernel has to keep
> the tag then).
>
> but i wonder what's the right thing to do for sp
> (user can malloc thread/sigalt/makecontext stack
> which will be mte tagged in practice with mte on)
> does tagged sp work? should userspace untag the
> stack memory before setting it up as a stack?
> (but then user pointers to that allocation may get
> broken..)

Tagged SP does work, and it is actually a good idea (it avoids using the default tag 
for the stack). It would be quite easy for the kernel to tag the initial SP and the 
stack on execve(). For other stacks, it is up to userspace, as you say, and would be 
made easier by making it possible to choose how a mapping should be tagged by the 
kernel via a new mmap() flag. Some software that makes too many assumptions on the 
address of stack variables will be disturbed by a tagged SP, but this should be 
fairly rare.

In any case, I don't think this impacts this ABI proposal (beyond the fact that 
passing tagged pointers to the stack needs to be allowed).

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
