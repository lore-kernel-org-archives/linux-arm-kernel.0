Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:17:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02BD2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqb4foDD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvNrr/QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02BD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b3sDVNwXHUj85YTIH9fqHsABeqp0WQjcGdZaXpgL+tM=; b=nqb4foDDuh7VY3
	8l0wtDcoCzEBaBrAwvx6/R8cYKOpLY42rNechE/9n7Zdeua1zdhsTH7qNUtIVoTDwEXmJj4axKn53
	GONrnHpHabk1jC9JOIKigUWQHPTL6TdwUNyqfe8l/I0/Ofc4h3WRQkpZQlMHcrK6+O6fpHDflPuhj
	IumU54jZZe+zv2dckYTdAPLb+/esBDvdVbFeYFeGnqsmX0kHVf30054QohY7gVTjuufkDxMJxrWvh
	LBRHI2tFrOCGWZdVGDfD9an4cI4ayxVSCWmP4Go88aHca2MzAUuffYeOZbvlxOzm3fzQUPOguu0ej
	Tlk9c/eBLF+0RE5j4Vug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxLwF-0005UI-KF; Sat, 23 Feb 2019 01:17:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxLwC-0005Tu-8q
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 01:17:09 +0000
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 41BD820879
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550884626;
 bh=qM14GEA1kkynPtQj8xGQpiWRgD0+Lb0IQ9VIKLs/xlo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dvNrr/QF9nsP3SA1IxNklWLSjsgEC0KkyQ0P+5ccFpOKQ3gB62tFXDpB5qdjMFmj1
 hGKWNOWGvyBwZzgx7RRxc+QDd43ZD/tqC0xWyq+5zKkOWbVKw1FAiVXYRjI2camFNq
 A2yw+oN7p4QJcFNtWWp/cYZRlnTBJX91kFyJxQl0=
Received: by mail-wr1-f49.google.com with SMTP id d17so4182736wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:17:06 -0800 (PST)
X-Gm-Message-State: AHQUAuZUDL2J01wbKfbrtpqUMjgcMSKgVaBTFQ+MXUlSMWavOgi2ZQd1
 Bvjmqhs0PbJgDCkgMWcl4JF2HhNEJ7QYqMN5XthXLA==
X-Google-Smtp-Source: AHgI3IZJwjT2wJcsX85CRD/D/STdl4TV9r2/HnoSQuEPGbPMohFdTxvJg2kZuRLCdObU7Vur8NVU0PfUkc2IgTa4/VQ=
X-Received: by 2002:adf:e747:: with SMTP id c7mr4674564wrn.176.1550884624657; 
 Fri, 22 Feb 2019 17:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
 <CAHk-=wjmp0UugFnD2KaXyGO8RprfgULwMhseDhAxQQMqqL1Eiw@mail.gmail.com>
In-Reply-To: <CAHk-=wjmp0UugFnD2KaXyGO8RprfgULwMhseDhAxQQMqqL1Eiw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 22 Feb 2019 17:16:53 -0800
X-Gmail-Original-Message-ID: <CALCETrXX1cWxp7m7WVL7VWj4BKriEePxhj0noEFeHtAXvm8Dow@mail.gmail.com>
Message-ID: <CALCETrXX1cWxp7m7WVL7VWj4BKriEePxhj0noEFeHtAXvm8Dow@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Linus Torvalds <torvalds@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_171708_335472_FE9ED3D5 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 5:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Feb 22, 2019 at 4:34 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > [mailing lists removed because this is a potentially large source of exploits]
>
> I think you're overly worried.
>
> AC doesn't protect against "large source of exploits".

What I meant was: a potentially large grab bag of ways to help turn a
bug into an exploit.

> That said:
>
> > Um, wait a moment.  You didn't find an oddity in ptrace.c.  You found
> > a giant freaking error in uaccess.h.
>
> I agree that your patch is good, and should be applied. Mind writing
> up a changelog and committing it to -tip?

I don't have commit access :)  But I shall email it out once I test it a bit.

--Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
