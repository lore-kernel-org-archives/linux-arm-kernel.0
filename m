Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD48C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:28:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFCA21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fe0AIZm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFCA21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ZOYiZqw7t8UD4+DH6dizv5wh+HHiC2ypIQg/sfch6w=; b=Fe0AIZm//fvBmt
	cltQWSXYUesT1O8guZWa5MAaztdVQWyh0ePzGz6bCH3S+j8harFDTOVrFhdRgNctCpQHkprzpOahh
	Ek0lVBxR02jNqcMmoNBCp3zW0CKc51FdEEtXAuaHowwKxKW/D/nNsP2r7u58iUZuQTTRIH2OTkGnL
	BlDAIpbam9k1thuKmD12K93LtgfCajwkwnsJ8Bq45xako5Zu8O5L3i54beWgAv/S73X4cL81tyDAa
	j1psEzS3SR9OEj6FgxeBctwg6P+roVSTDaT3pCyZJoQo9YqkZTHR+aqECE0rU7sDOiCDoYU6Rq8J2
	A5vj/BYO3nh+GbskZ3jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz4s2-00062j-T1; Wed, 27 Feb 2019 19:27:58 +0000
Received: from mail-ua1-f67.google.com ([209.85.222.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz4rz-00061t-B0
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:27:57 +0000
Received: by mail-ua1-f67.google.com with SMTP id j8so16441495uae.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3cLq+kIlMMXRZaenVxSwc6pfzBM/ls2MR1D4QP0Hu2k=;
 b=MhRYNJNaj+DmFxmtrCUr+aiCUAsavLzkiK7o60AoYlGf+6G2vf+IQlJN3Qf8brQQql
 Dg8tHUNf/we5Krz6aEhzeieHQ4XytFKJS9WwOhUtTUkP3ym+cjJ7DeRDg7LlneBBZOKA
 +2xjhMuJpFuWCdL6WVvQmSYjbeQlSa/Xr3WNtGnYZy+cbXZBjVkRaEppf+HsQFZnss9g
 DDHdft8wrhWXgHmz7HOdvEz1mJxagMGRGhCzwxk1I2LjVDdyrnxMK7QHJA5wUC2cswX+
 VvUldChd/ITe7MHv1J3pwdjYAm401TKYtMc03VXM8S6Sdqmx5S0KSJ0DXIJCO7gFcg1S
 9z7w==
X-Gm-Message-State: AHQUAuaXPAFiO1Sic6iD1drQRXJ0EXm/vMfc7EIWfHz/c97+6uUeSEmx
 xJ60rWFnQAeoirCp+yAhffyqiga2+S/Yn9mUsnc=
X-Google-Smtp-Source: AHgI3IYIIgJnnj+3JVj92wdAfbL35gf/TxgoFevJ67043vd71Gt2nCkIM687D/Ouf5eryemB/ak7axdzhzJsiRNvfRk=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr2797801vsp.166.1551295673138; 
 Wed, 27 Feb 2019 11:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-10-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-10-steven.price@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Feb 2019 20:27:40 +0100
Message-ID: <CAMuHMdXCjuurBiFzQBeLPUFu=mmSowvb=37XyWmF_=xVhkQm4g@mail.gmail.com>
Subject: Re: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
To: Steven Price <steven.price@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_112755_383556_31D337FE 
X-CRM114-Status: GOOD (  14.20  )
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
 the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, "Liang,
 Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steven,

On Wed, Feb 27, 2019 at 6:07 PM Steven Price <steven.price@arm.com> wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
>
> For m68k, we don't support large pages, so add stubs returning 0
>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Thanks for your patch!

>  arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
>  arch/m68k/include/asm/motorola_pgtable.h | 2 ++
>  arch/m68k/include/asm/pgtable_no.h       | 1 +
>  arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
>  4 files changed, 7 insertions(+)

If the definitions are the same, why not add them to
arch/m68k/include/asm/pgtable.h instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
