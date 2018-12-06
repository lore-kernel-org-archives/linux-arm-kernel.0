Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84543C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580CC20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vfr1G21Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="a0lv78Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580CC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2AT8HMs1wMYBrnjq90icL0xGecHvwOTtCDBEoQg7jMM=; b=Vfr1G21Z94GgJ5
	v6NmQkL2TA712gjMES9/UEZ4e6K8x9JT0bffXVY6XZjcLeLEOy04FQeVJuQcVWm19KOP944larjth
	hw/9J7rpW1eQBgJ/sE2zR6FK1vHhl9aOgHvHj3T9T3OcjgL8WsfsJl/JTtliWovrgvNz/VG4KffNp
	2MwVPoSVt0GVuwUPcf6nFxZqKSEPuLtAUE/iVjPW5g2XLSKE/Xrxho4kMK2WNoNzfDyNttwIFC2XS
	EeCNku7lO6jZs+EQ20ZHF+mRzy1hpPqlNT6ccKQzzGks7FgM9arvLPWr7Ha5SfTrYRrP9Lle7zqop
	+8Tty+20PCIPvkEc7HEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUt1N-0002rw-Pf; Thu, 06 Dec 2018 12:44:49 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUt1K-0002qP-N2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:44:48 +0000
Received: by mail-io1-xd43.google.com with SMTP id s22so220891ioc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HXfEeer8lXiTzxdO568lQH0i3J/k1WTWOP8z/E4CgAE=;
 b=a0lv78WzuNp7XEpWonO8wUhrSSI6l/F7CXDT6FsiSZHZqcgxpH55mW9Tktanmms4bd
 5WCvksPkUVVuWKdYjbtNl5XPuUAi+CEshOgTxF28JKtHNyMf2rozq8k7gTIZd0tjGte/
 0Jm76bCRRLJ50ynvAsj54vvoHRYBD97InWazLHNBTVgwH+KtFbEOXEGnx6EoC5r92IOS
 3af+Ope8V3NZ1nVOlPbh2VisJkNtrEaB8vhSDm8+o9ojvgiLA5qm7ffdoOhR37ULhPEN
 /kzgOF3bW19VejcLSpCAWdn00qf6I5rktWTvGGB69uEdC/RPKj44A8fS9K7EQ/9shASB
 99Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HXfEeer8lXiTzxdO568lQH0i3J/k1WTWOP8z/E4CgAE=;
 b=pCocR11T6wuENqSMzUVeTdy10ToVTOId7LJlGVjR7bYhXadb2v1f8iyUZkMxkm2HJY
 0KLyDyAUN5sJyPvw82Y+kqhgGPfH57wJGTpF3OOtb8upXEsqFpispQPA55R6LTrjeDNo
 nQTGFGF/CL5Ig7qilnIukbhWJLIBeRS4N9luAybEIKFH58TF2UNWmk7hAdkg8UeQDrrp
 RPKQmI/EJkwj0S7WXNYkZgvkw6mDv5W/JyhMZWif49JULRKmLftWg+qAasI/YFAAca7+
 4hYVhealST9OfW04wCpAhPN+BBty+FK7lXd0L/NI2G6MrjnAG+00wTvRA33bzRzcSeue
 eDyQ==
X-Gm-Message-State: AA+aEWaaSx3LXIvbn7q0gggoVn8ukZvk4Q8nkWs9jc1m6/AsXIc/bj9B
 lK5VvQ92JS4zaYvsfBRH+obybYeKB87KxJRNzli75Q==
X-Google-Smtp-Source: AFSGD/ULBxYF7T4c0NJD5O2DilLikv+Y2xbpu6RXWu/u1zlwiz0r4xTAJbdjlGtLEshBsqDhgSfLqaIzXSLUBXDHZCg=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr8810806ioc.119.1544100275528; 
 Thu, 06 Dec 2018 04:44:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com>
 <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
 <20181129181650.GG22027@arrakis.emea.arm.com>
In-Reply-To: <20181129181650.GG22027@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 13:44:24 +0100
Message-ID: <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_044446_776394_222075CA 
X-CRM114-Status: GOOD (  23.13  )
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
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 7:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Andrey,
>
> On Thu, Nov 08, 2018 at 03:48:10PM +0100, Andrey Konovalov wrote:
> > On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > Changes in v8:
> > > - Rebased onto 65102238 (4.20-rc1).
> > > - Added a note to the cover letter on why syscall wrappers/shims that untag
> > >   user pointers won't work.
> > > - Added a note to the cover letter that this patchset has been merged into
> > >   the Pixel 2 kernel tree.
> > > - Documentation fixes, in particular added a list of syscalls that don't
> > >   support tagged user pointers.
> >
> > I've changed the documentation to be more specific, please take a look.
> >
> > I haven't done anything about adding a way for the user to find out
> > that the kernel supports this ABI extension. I don't know what would
> > the the preferred way to do this, and we haven't received any comments
> > on that from anybody else. Probing "on some innocuous syscall
> > currently returning -EFAULT on tagged pointer arguments" works though,
> > as you mentioned.
>
> We've had some internal discussions and also talked to some people at
> Plumbers. I think the best option is to introduce an AT_FLAGS bit to
> describe the ABI relaxation on tagged pointers. Vincenzo is going to
> propose a patch on top of this series.

So should I wait for a patch from Vincenzo before posting v9 or post
it as is? Or try to develop this patch myself?

>
> > As mentioned in the cover letter, this patchset has been merged into
> > the Pixel 2 kernel tree.
>
> I just hope it's not enabled on production kernels, it would introduce
> a user ABI that may differ from what ends up upstream.
>
> --
> Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
