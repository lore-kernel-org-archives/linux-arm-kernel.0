Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:00:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F1B21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JSyOGd8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F1B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vwaqgP6cn7ixHgOECLLxKWXt47nin2p380MOoKEDK8w=; b=JSyOGd8Z3mtE45
	wqGyzL7gGvHMdfYREuAv9nKMZhldYGPe+ttwbhk1M9DdaR7jB4ozYBzshX6ftNVMvUngJzPvjwGrh
	uZPHJB/2r3fWqnXgMoPfN0mH7eexJiEfnV00zgJeTzgiUsPdoyP85qLd0++MfduoyYT7JIBUqp6tr
	YLVno7uBwMaojc1jJOyM+auVdI88UCnzHQI7REVkN20ZpBb5aVptR/aNXnikGtTfO3U3tDSLGoXgR
	y980Y7jpU6/j0IdOXJKfFaBFC5f2ZAMe24oIijHBA9s6ETG4uUO92KFJsWRGS8W9RIm21NwzezFEW
	ZrEM/uJ1xlwr6CP5nobg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJf1-0002sz-33; Tue, 18 Dec 2018 18:00:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJex-0002iw-85
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:00:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB88AA78;
 Tue, 18 Dec 2018 09:59:45 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 78DF93F5C0; Tue, 18 Dec 2018 09:59:41 -0800 (PST)
Date: Tue, 18 Dec 2018 17:59:38 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20181218175938.GD20197@arrakis.emea.arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_095959_295636_DBCE8820 
X-CRM114-Status: GOOD (  20.81  )
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
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Tue, Dec 18, 2018 at 04:03:38PM +0100, Andrey Konovalov wrote:
> On Wed, Dec 12, 2018 at 4:02 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > The summary of our internal discussions (mostly between kernel
> > developers) is that we can't properly describe a user ABI that covers
> > future syscalls or syscall extensions while not all syscalls accept
> > tagged pointers. So we tweaked the requirements slightly to only allow
> > tagged pointers back into the kernel *if* the originating address is
> > from an anonymous mmap() or below sbrk(0). This should cover some of the
> > ioctls or getsockopt(TCP_ZEROCOPY_RECEIVE) where the user passes a
> > pointer to a buffer obtained via mmap() on the device operations.
> >
> > (sorry for not being clear on what Vincenzo's proposal implies)
> 
> OK, I see. So I need to make the following changes to my patchset AFAIU.
> 
> 1. Make sure that we only allow tagged user addresses that originate
> from an anonymous mmap() or below sbrk(0). How exactly should this
> check be performed?

I don't think we should perform such checks. That's rather stating that
the kernel only guarantees that the tagged pointers work if they
originated from these memory ranges.

> 2. Allow tagged addressed passed to memory syscalls (as long as (1) is
> satisfied). Do I understand correctly that this means that I need to
> locate all find_vma() callers outside of mm/ and fix them up as well?

Yes (unless anyone as a better idea or objections to this approach).

BTW, I'll be off until the new year, so won't be able to follow up.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
