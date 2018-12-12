Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E1FC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ED720839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bqeA40QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ED720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UbQhD/5lyIngfCc2E7nkJATwcyklFVjSe04/5T0dWHc=; b=bqeA40QCe0IgE6
	wMgAGXTOlmmnn/xZPGyOHxgnLHWLM2p/DHFQtrqgTXpsP3vllMkk03OwLnVaGIIloc79QNTs2o/q/
	ziL3+MeU0kbao6v/uDZLc26TnvLjhBn2ZsaTvVl+UDS+i66PAZwqy0DqAUC086hyOWYGw2rjv+7GJ
	CcC6J71Ouscu5JHkneJgd3q4Sj3IJUpteyan2yjSDt7Uz4CT8b8T1RVnxLSHn7ttU+K32LcZ/Kgc5
	4zuf6nGAtx3hI0XsAXt1+hT2EpO9D5jExjTwHU505lzZW3WK7dCRtmJxiEGj259MWRUXoWHvTF4L5
	7lrQMr9m59zZdMEIlgsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX62K-0006BV-LO; Wed, 12 Dec 2018 15:02:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX62F-00069m-OG
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:02:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC2E80D;
 Wed, 12 Dec 2018 07:02:37 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5ADD73F59C; Wed, 12 Dec 2018 07:02:33 -0800 (PST)
Date: Wed, 12 Dec 2018 15:02:30 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Message-ID: <20181212150230.GH65138@arrakis.emea.arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_070251_804656_4AC5B347 
X-CRM114-Status: GOOD (  27.74  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Lee Smith <Lee.Smith@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kostya Serebryany <kcc@google.com>,
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

Hi Andrey,

On Wed, Dec 12, 2018 at 03:23:25PM +0100, Andrey Konovalov wrote:
> On Mon, Dec 10, 2018 at 3:31 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> > On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
> > the userspace (EL0) is allowed to set a non-zero value in the top
> > byte but the resulting pointers are not allowed at the user-kernel
> > syscall ABI boundary.
> >
> > This patchset proposes a relaxation of the ABI and a mechanism to
> > advertise it to the userspace via an AT_FLAGS.
> >
> > The rationale behind the choice of AT_FLAGS is that the Unix System V
> > ABI defines AT_FLAGS as "flags", leaving some degree of freedom in
> > interpretation.
> > There are two previous attempts of using AT_FLAGS in the Linux Kernel
> > for different reasons: the first was more generic and was used to expose
> > the support for the GNU STACK NX feature [1] and the second was done for
> > the MIPS architecture and was used to expose the support of "MIPS ABI
> > Extension for IEEE Std 754 Non-Compliant Interlinking" [2].
> > Both the changes are currently _not_ merged in mainline.
> > The only architecture that reserves some of the bits in AT_FLAGS is
> > currently MIPS, which introduced the concept of platform specific ABI
> > (psABI) reserving the top-byte [3].
> >
> > When ARM64_AT_FLAGS_SYSCALL_TBI is set the kernel is advertising
> > to the userspace that a relaxed ABI is supported hence this type
> > of pointers are now allowed to be passed to the syscalls when they are
> > in memory ranges obtained by anonymous mmap() or brk().
> >
> > The userspace _must_ verify that the flag is set before passing tagged
> > pointers to the syscalls allowed by this relaxation.
> >
> > More in general, exposing the ARM64_AT_FLAGS_SYSCALL_TBI flag and mandating
> > to the software to check that the feature is present, before using the
> > associated functionality, it provides a degree of control on the decision
> > of disabling such a feature in future without consequently breaking the
> > userspace.
[...]
> Acked-by: Andrey Konovalov <andreyknvl@google.com>

Thanks for the ack. However, if we go ahead with this ABI proposal it
means that your patches need to be reworked to allow a non-zero top byte
in all syscalls, including mmap() and friends, ioctl(). There are ABI
concerns in either case but I'd rather have this discussion in the open.
It doesn't necessarily mean that I endorse this proposal, I would like
feedback and not just from kernel developers but user space ones.

The summary of our internal discussions (mostly between kernel
developers) is that we can't properly describe a user ABI that covers
future syscalls or syscall extensions while not all syscalls accept
tagged pointers. So we tweaked the requirements slightly to only allow
tagged pointers back into the kernel *if* the originating address is
from an anonymous mmap() or below sbrk(0). This should cover some of the
ioctls or getsockopt(TCP_ZEROCOPY_RECEIVE) where the user passes a
pointer to a buffer obtained via mmap() on the device operations.

(sorry for not being clear on what Vincenzo's proposal implies)

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
