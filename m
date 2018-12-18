Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9429C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FE321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BfwVKh6D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tftRytD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FE321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=05NSRMofP2h1IkxwP74VvcJ+UiEPKvm/tKd8qlS8bCk=; b=BfwVKh6Dq6SA2W
	xzvHtyXaM8/4Xt4SgQgvXEimzQ0vhMTUPx+NmQHljqB5jIpQDy5x3zNJATJD2LG85dAB/hj1p0ldV
	YSkFzq2OaUHCg+BFkFpWSf5nWrBEgoMQvdmRsd0Kc10DgyhV556zEXq7aGZufel5W8h/mW/ccyGaC
	2zcd//ZMaI0vcfnsa96/xTLvm7k4yIQc2D8Zo9od8BL/N4QeZbK5V426DDYskUsjxitiHeo4xnoRm
	lQ2i96fagFWfNbR7tDylwapOutgUEG3CiBZ2BnPE8Tz3wrVq/Ds50RGksUgoYmEPPBYpZW8SBzNXt
	MWxnLzMBlfAL65TuvjOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGvi-0001mw-Tg; Tue, 18 Dec 2018 15:05:07 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGug-0000l7-7k
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:04:17 +0000
Received: by mail-pl1-x644.google.com with SMTP id u18so7939394plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sfl3jpT+Z6dPcoWKLdIC2EG1bdaigl5ehtSeHXXAKIU=;
 b=tftRytD/Y/atZpWfzM4JEyT85SgQxakaxsQa4NkmgL4FdrpvZG3e2148E9bgtXrSeI
 1LIlHdVlV5dVPXzj0HzMIBPV9O+QFsM43gb7UDC4F9b70HVYaHAx3YagrqQ6NRnX0Eoj
 tVkHox5MPSXBa+QSwtGB0tZhv7Ogm9PJJ1iRZlkPOzmUEcBr62sM7OEpvcPEPcUqRDoE
 bkTsWB0UhRZvezXm2FgW1e30O/vfLjEB0lw/OYEZFLIKaGZbPFK9sYjxAq3PkOK9IDBs
 N2BqU1yBw3U60WDm8iZUuKNnCQTZetBt9HnkAZ51j7N0PmIy1OBOxbu5xbhfwL7uE6+K
 g1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sfl3jpT+Z6dPcoWKLdIC2EG1bdaigl5ehtSeHXXAKIU=;
 b=iudlVSE2Ax1+taWQ9ikvyuO4PAVggkO7uB4J2KnMFdiW3Y+f85cW6qxRJP5ok4yAun
 M8caNmxdq7bYsBVGUZnT2UbRn5Rlkf4mLCSe5FQWF2y/UaSSynO/WFJoVhTwob2+9+W+
 tDB+dpWU7NcwdjrxNcLriPfD33M6ZG/F4oONwqn6UFxhsGuvp3DVmvfJIwlpW0ukYKqS
 VfKNW92lYRP1TFUgXQW+Fecsz2r6ZB2ZQipAIVMDptiHYiSUtnqXYhhA6dVHoMQefkDz
 wQLzaQIczXKDDD8Wq3JTScoWmigoRmKqGzuJcrvR+DjRzx37kkLtN3YrN0QZr+6Hase5
 uPNw==
X-Gm-Message-State: AA+aEWZkZdysOgkOGtijV77oV+zLvOrZIlR3svi0/2Z61a2d60f3Wmwg
 t4VeKRdWbfUqn8ZrIk70O6y4Kif2gKOEXXwsPMzESQ==
X-Google-Smtp-Source: AFSGD/UzhMrkNuMyEwebGi2TeQRVTqS5wzGKyjGmvoYXSgz4FVYzGPhGy+Dl3TxijCqgg3hCP90RHV+czduuqkIeWHA=
X-Received: by 2002:a17:902:b406:: with SMTP id
 x6mr15943874plr.329.1545145430285; 
 Tue, 18 Dec 2018 07:03:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
In-Reply-To: <20181212150230.GH65138@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 18 Dec 2018 16:03:38 +0100
Message-ID: <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070402_600967_CDD7D765 
X-CRM114-Status: GOOD (  30.23  )
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

On Wed, Dec 12, 2018 at 4:02 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Andrey,
>
> On Wed, Dec 12, 2018 at 03:23:25PM +0100, Andrey Konovalov wrote:
> > On Mon, Dec 10, 2018 at 3:31 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > > On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
> > > the userspace (EL0) is allowed to set a non-zero value in the top
> > > byte but the resulting pointers are not allowed at the user-kernel
> > > syscall ABI boundary.
> > >
> > > This patchset proposes a relaxation of the ABI and a mechanism to
> > > advertise it to the userspace via an AT_FLAGS.
> > >
> > > The rationale behind the choice of AT_FLAGS is that the Unix System V
> > > ABI defines AT_FLAGS as "flags", leaving some degree of freedom in
> > > interpretation.
> > > There are two previous attempts of using AT_FLAGS in the Linux Kernel
> > > for different reasons: the first was more generic and was used to expose
> > > the support for the GNU STACK NX feature [1] and the second was done for
> > > the MIPS architecture and was used to expose the support of "MIPS ABI
> > > Extension for IEEE Std 754 Non-Compliant Interlinking" [2].
> > > Both the changes are currently _not_ merged in mainline.
> > > The only architecture that reserves some of the bits in AT_FLAGS is
> > > currently MIPS, which introduced the concept of platform specific ABI
> > > (psABI) reserving the top-byte [3].
> > >
> > > When ARM64_AT_FLAGS_SYSCALL_TBI is set the kernel is advertising
> > > to the userspace that a relaxed ABI is supported hence this type
> > > of pointers are now allowed to be passed to the syscalls when they are
> > > in memory ranges obtained by anonymous mmap() or brk().
> > >
> > > The userspace _must_ verify that the flag is set before passing tagged
> > > pointers to the syscalls allowed by this relaxation.
> > >
> > > More in general, exposing the ARM64_AT_FLAGS_SYSCALL_TBI flag and mandating
> > > to the software to check that the feature is present, before using the
> > > associated functionality, it provides a degree of control on the decision
> > > of disabling such a feature in future without consequently breaking the
> > > userspace.
> [...]
> > Acked-by: Andrey Konovalov <andreyknvl@google.com>
>
> Thanks for the ack. However, if we go ahead with this ABI proposal it
> means that your patches need to be reworked to allow a non-zero top byte
> in all syscalls, including mmap() and friends, ioctl(). There are ABI
> concerns in either case but I'd rather have this discussion in the open.
> It doesn't necessarily mean that I endorse this proposal, I would like
> feedback and not just from kernel developers but user space ones.
>
> The summary of our internal discussions (mostly between kernel
> developers) is that we can't properly describe a user ABI that covers
> future syscalls or syscall extensions while not all syscalls accept
> tagged pointers. So we tweaked the requirements slightly to only allow
> tagged pointers back into the kernel *if* the originating address is
> from an anonymous mmap() or below sbrk(0). This should cover some of the
> ioctls or getsockopt(TCP_ZEROCOPY_RECEIVE) where the user passes a
> pointer to a buffer obtained via mmap() on the device operations.
>
> (sorry for not being clear on what Vincenzo's proposal implies)

OK, I see. So I need to make the following changes to my patchset AFAIU.

1. Make sure that we only allow tagged user addresses that originate
from an anonymous mmap() or below sbrk(0). How exactly should this
check be performed?

2. Allow tagged addressed passed to memory syscalls (as long as (1) is
satisfied). Do I understand correctly that this means that I need to
locate all find_vma() callers outside of mm/ and fix them up as well?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
