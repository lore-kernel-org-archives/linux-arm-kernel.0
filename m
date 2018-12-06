Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:08:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E1920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qErmrk8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E1920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FzSzITQb2JTRdhLcx1EznOZhGTo0BuJI5W2cQSysjZM=; b=qErmrk8HSuK3CU
	JPruCdAlHFtAPArcvcw1GFulO0NFUtNh3jl0yDgbPptZYrMYXfRaSJMAPB5187mlGhlyXCdLvjSFi
	DLLWkGdpjiVobgo8ZtR08JxAgxKM/InoZcq9NbH0EKzmD29Icxxbww8zVzYELz8inpPLh24OGvDNP
	ivB67wHFzxP5z5X5JpK2a3cKPQGpJpQSWCrXLYaISVTyq3bNpC37KBEHHeFCeD8POBrIWoQPJSEPM
	dCkOk++K2uzVrTgOfY2HIeSSGg93eYGX3khoVVnRNbxkL3qq4aPvm0M1Z+51F0BzN2kdq6iY+OFXP
	fKjnJUCNE1qFSi9Mkdrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuKk-0007mR-1s; Thu, 06 Dec 2018 14:08:54 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuKh-0007lv-ED
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:08:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F18FA78;
 Thu,  6 Dec 2018 06:08:40 -0800 (PST)
Received: from localhost (unknown [10.1.31.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0867A3F575;
 Thu,  6 Dec 2018 06:08:40 -0800 (PST)
Received: from cmarinas by localhost with local (Exim 4.89)
 (envelope-from <catalin.marinas@arm.com>)
 id 1gUuKT-0003cv-5H; Thu, 06 Dec 2018 14:08:37 +0000
Date: Thu, 6 Dec 2018 14:08:36 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
Message-ID: <20181206140836.vhhfnv7hta6pzwd4@localhost>
References: <cover.1541687720.git.andreyknvl@google.com>
 <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
 <20181129181650.GG22027@arrakis.emea.arm.com>
 <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_060851_491610_4BD1C486 
X-CRM114-Status: GOOD (  25.70  )
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
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
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

On Thu, Dec 06, 2018 at 01:44:24PM +0100, Andrey Konovalov wrote:
> On Thu, Nov 29, 2018 at 7:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Nov 08, 2018 at 03:48:10PM +0100, Andrey Konovalov wrote:
> > > On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > > Changes in v8:
> > > > - Rebased onto 65102238 (4.20-rc1).
> > > > - Added a note to the cover letter on why syscall wrappers/shims that untag
> > > >   user pointers won't work.
> > > > - Added a note to the cover letter that this patchset has been merged into
> > > >   the Pixel 2 kernel tree.
> > > > - Documentation fixes, in particular added a list of syscalls that don't
> > > >   support tagged user pointers.
> > >
> > > I've changed the documentation to be more specific, please take a look.
> > >
> > > I haven't done anything about adding a way for the user to find out
> > > that the kernel supports this ABI extension. I don't know what would
> > > the the preferred way to do this, and we haven't received any comments
> > > on that from anybody else. Probing "on some innocuous syscall
> > > currently returning -EFAULT on tagged pointer arguments" works though,
> > > as you mentioned.
> >
> > We've had some internal discussions and also talked to some people at
> > Plumbers. I think the best option is to introduce an AT_FLAGS bit to
> > describe the ABI relaxation on tagged pointers. Vincenzo is going to
> > propose a patch on top of this series.
> 
> So should I wait for a patch from Vincenzo before posting v9 or post
> it as is? Or try to develop this patch myself?

The reason Vincenzo hasn't posted his patches yet is that we are still
debating internally how to document which syscalls accept non-zero
top-byte, what to do with future syscalls for which we don't know the
semantics.

Happy to take the discussion to the public list if Vincenzo posts his
patches. The conclusion of the ABI discussion may have an impact on the
actual implementation that you are proposing in this series.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
