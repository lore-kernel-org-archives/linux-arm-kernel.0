Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7A52083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A89HR91k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7A52083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HAXB93u4dXkSW+XCo7ouIfsGuyZ0j5LqKS/jr0E71wY=; b=A89HR91kPdBNw7
	J43n8HbjCSWtNO9vcEA7ENOrj0ZKZD6oXOgS3JVvO7uOwOyibEBJ9NiVZ+pxuAImjLRGAQj1GxDGE
	rDyxRL7aFq8TCZalMaTy1EimnkrdxRhh+gDbrUf4DWydeCeiRhBfMCn7M0AiFxY/UwO1WA1qY6Yru
	5ZB27B8giJ0JQ6fypbsQtYN4UBKGisgDT3pLR0u8TFm0vB40EwJ2RomRQOg+JIeEgNq5kWy5uVNk/
	HkEjDrm5WXXHy+JVyrs439IPeN2Nbi42sg17PiT9Ut9WZcGPFKMDioxQ4zqkmPyo2rjR+xH93kGyS
	kMjNtop3PBWMLN4eV2RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJZN-0005Pi-FA; Mon, 25 Feb 2019 16:57:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJZK-0005PB-W9
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:57:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 896D180D;
 Mon, 25 Feb 2019 08:57:28 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 8F15B3F703; Mon, 25 Feb 2019 08:57:23 -0800 (PST)
Date: Mon, 25 Feb 2019 16:57:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20190225165720.GA79300@arrakis.emea.arm.com>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_085731_045546_97ECFDF7 
X-CRM114-Status: GOOD (  24.08  )
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
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, Evgenii Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Kevin Brodsky <Kevin.Brodsky@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Szabolcs,

Thanks for looking into this. Comments below.

On Tue, Feb 19, 2019 at 06:38:31PM +0000, Szabolcs Nagy wrote:
> i think these rules work for the cases i care about, a more
> tricky question is when/how to check for the new syscall abi
> and when/how the TCR_EL1.TBI0 setting may be turned off.

I don't think turning TBI0 off is critical (it's handy for PAC with
52-bit VA but then it's short-lived if you want more security features
like MTE).

> consider the following cases (tb == top byte):
> 
> binary 1: user tb = any, syscall tb = 0
>   tbi is on, "legacy binary"
> 
> binary 2: user tb = any, syscall tb = any
>   tbi is on, "new binary using tb"
>   for backward compat it needs to check for new syscall abi.
> 
> binary 3: user tb = 0, syscall tb = 0
>   tbi can be off, "new binary",
>   binary is marked to indicate unused tb,
>   kernel may turn tbi off: additional pac bits.
> 
> binary 4: user tb = mte, syscall tb = mte
>   like binary 3, but with mte, "new binary using mte"
>   does it have to check for new syscall abi?
>   or MTE HWCAP would imply it?
>   (is it possible to use mte without new syscall abi?)

I think MTE HWCAP should imply it.

> in userspace we want most binaries to be like binary 3 and 4
> eventually, i.e. marked as not-relying-on-tbi, if a dso is
> loaded that is unmarked (legacy or new tb user), then either
> the load fails (e.g. if mte is already used? or can we turn
> mte off at runtime?) or tbi has to be enabled (prctl? does
> this work with pac? or multi-threads?).

We could enable it via prctl. That's the plan for MTE as well (in
addition maybe to some ELF flag).

> as for checking the new syscall abi: i don't see much semantic
> difference between AT_HWCAP and AT_FLAGS (either way, the user
> has to check a feature flag before using the feature of the
> underlying system and it does not matter much if it's a syscall
> abi feature or cpu feature), but i don't see anything wrong
> with AT_FLAGS if the kernel prefers that.

The AT_FLAGS is aimed at capturing binary 2 case above, i.e. the
relaxation of the syscall ABI to accept tb = any. The MTE support will
have its own AT_HWCAP, likely in addition to AT_FLAGS. Arguably,
AT_FLAGS is either redundant here if MTE implies it (and no harm in
keeping it around) or the meaning is different: a tb != 0 may be checked
by the kernel against the allocation tag (i.e. get_user() could fail,
the tag is not entirely ignored).

> the discussion here was mostly about binary 2,

That's because passing tb != 0 into the syscall ABI is the main blocker
here that needs clearing out before merging the MTE support. There is,
of course, a variation of binary 1 for MTE:

binary 5: user tb = mte, syscall tb = 0

but this requires a lot of C lib changes to support properly.

> but for
> me the open question is if we can make binary 3/4 work.
> (which requires some elf binary marking, that is recognised
> by the kernel and dynamic loader, and efficient handling of
> the TBI0 bit, ..if it's not possible, then i don't see how
> mte will be deployed).

If we ignore binary 3, we can keep TBI0 = 1 permanently, whether we have
MTE or not.

> and i guess on the kernel side the open question is if the
> rules 1/2/3/4 can be made to work in corner cases e.g. when
> pointers embedded into structs are passed down in ioctl.

We've been trying to track these down since last summer and we came to
the conclusion that it should be (mostly) fine for the non-weird memory
described above.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
