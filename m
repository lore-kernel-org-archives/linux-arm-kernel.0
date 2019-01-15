Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A859C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:47:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEE320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gAn8ldb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEE320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B+n7uqmaYl7Ztk5e6CYhHYnTw8G8uw3k/awX/73NQKg=; b=gAn8ldb95e/rdI
	TgFMALH5+5qdcNF6kRSBuXfvVjw+g21h0TLua0QQ0nUYIzT1iOynVoyx4RTYIHB6qTTwzygcYRT2X
	lkwGiyyQWeETlgY0j8FInMEsk/YggX8t4zocO/cYOcRciP7xyuMH/8K+8mJ/h7WjaDD7Ct22dnq30
	u/4AqCt8dwdprlxn8NibOFrEBk3FHbIdViXlg/LEmU+I3UzKgQH2rRH3V9bJpxCiyVV9AmFdTL+yf
	kuoQ7xrjxXkGgDiPRnfMrj2C3qt0g5J+DOrE0qQ0RG3vtKvhXzX8J2DJAOK58JtDwCJpJHfjYxLYs
	vpnamI5ozqQRsQVPnRJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQ07-0007Td-AF; Tue, 15 Jan 2019 14:47:35 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQ04-0007TC-Kt
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:47:34 +0000
Received: by mail-qk1-f196.google.com with SMTP id y78so1637532qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 06:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CJSgcbSLHBpkQA1mStr0T4cc3D19F0djyMHOoCBmTQM=;
 b=DpRrd1gscNMrnNfBx6lFOoLcsYSOiqlwhVyhmsjG8xfTzxhzopamwVw/Y72fRVrF+/
 RngJokp1pdIeKmWxDFc7uICgA3ayMKCIA3+C6yCJjb4BSEFwGyuLUieLhtbk0TkRreCe
 gcpLkPCJpUGEbohGkzEBm0NvFRFSsIzxXpzaaOTyNvQ9AMfsFzBbrJ2y3QeeTfXMXkjH
 xF8J55C71sidNZRbD9SaKkWy0s0tb8CjBcg4zOeiuxDhMpcAwsBLLQMSXPz7s2QzLrgr
 y830jKVZPWc33yrrKcAlJtJDVtPq+YIrPP86MoEpLqDyP0BVyyBT9x1p/2CbCpf4lbRA
 02Jw==
X-Gm-Message-State: AJcUukd4j4lhqOcV/4PzlgjMcBFgEHj6GhxUsjIsavLp7OHq0NA3EbxJ
 MAjruWaUj3sPNvRxARPUs8a7ghSARoF09MClct0=
X-Google-Smtp-Source: ALg8bN7NyBBLgCUds8tYMS0JcD3kjA3gSFqxzkmVv/3Wlh5Gl2kGahA1WPnfsZKIUU3QSibwFh0em/FK52DjAc3L5UI=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2838414qkf.107.1547563651094; 
 Tue, 15 Jan 2019 06:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
 <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 15:47:14 +0100
Message-ID: <CAK8P3a1Xb4z-mbhBTPZ0Cpy0Hy_s2wwT-8UG9yO6AGbUTjdkyw@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_064732_680811_58C1BEF7 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 12:52 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> > Most architectures define system call numbers for the rseq and pkey system
> > calls, even when they don't support the features, and perhaps never will.
> >
> > Only a few architectures are missing these, so just define them anyway
> > for consistency. If we decide to add them later to one of these, the
> > system call numbers won't get out of sync then.
>
> I was lambasted for adding the pkey syscalls for 32-bit ARM in 2016,
> which will probably never support it.  Why has the attitude towards
> this kind of thing now apparently become acceptable?

I was (and still am) a bit unsure about this one. A number of architectures
added the numbers that won't ever support them, but I wasn't sure if
any of those that didn't add them might need it later.

I tried to just go by the rule that anything that we list in
asm-generic/unistd.h
is probably important enough that we want to list it everywhere, even if
that includes a couple that we end up being rather architecture specific.

I'm happy to drop this patch if you or others feel that we're better off
without it though.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
