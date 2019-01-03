Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67183C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EF220685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGgMuR3F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="trUrQ4d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EF220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TAAWqsPFC8iJ1CdL8ZWgrud3y9L8euq12fZLMwIpR14=; b=EGgMuR3FY84q8L
	bx4hnwt7Fa5NEVjSS8djw4J07kHnSMnVaM5mINolMtZYXznscDXEy6Nb9pZfyt58VIMSkTnaGsknJ
	wfzEgvStd8LdLR2FfvXhRH4H75H4slXQxWMSugrfw6ftecw55PNUoZA4eKjwpSvd9RlnFhssWkD1P
	fN/6KsmFC+mR+3vj7wV1DWOlXeCEUDIWVVpnAvdML/zk6Dq8j9DyKyq/Gbk8dpuBgpGCodkP8g89m
	cQdEcp6dof3NWi7KQVb5bE4UYwXvitl2yQmvS5vOMoWY4LHQ/HJP5j8PG19KKXU69+5IsiTpMaD1W
	mJnzkQc/jOq+XmQQS8pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ger0T-0005G6-Gm; Thu, 03 Jan 2019 00:37:05 +0000
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ger0P-0005Ff-3Z
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 00:37:03 +0000
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x030aPai026363
 for <linux-arm-kernel@lists.infradead.org>; Thu, 3 Jan 2019 09:36:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x030aPai026363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546475786;
 bh=mJlYWSiWeqCZq2fJPK7I50b08OCqBiH7PgNOiO8M/9g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=trUrQ4d0GJhO3Ji00o7ysJnLg6IbdIjv2lH9K+fNm6Eb/JfGraqu85JH4j6bzHl2m
 03VekhKiMkvrMdhyPGYNohhgmp1GL1btms/aqNntGR8lgQDMl1mXwi38cgt5csr2ZL
 bR+LmhnkzW2aBblu2vFFN47lk1y8k7IkjAnKqWXbbQ02Ii1q7+NA0tL/g1PKSieA0x
 eW8n9yEj7GxC4V5AjKzyOYDnSbuC4YA8EMEsodcLQ9oYAmdVhXhsL1IXMc+a7lfPbQ
 ZTPu6riAnPWyy/IoqC04dxkNapSh5wlaMrZi3M6aTY5B6klUt8TQCiP4N4jOTmi2Mh
 2SB5SHKN4Mjnw==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id y14so6952249vkd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 16:36:26 -0800 (PST)
X-Gm-Message-State: AJcUukdSvsjgpuYV8k8bmvwUBWhRTKCTYpJMIjevkK/iQnpOc4PUrlK9
 AWYKTSGEGtfTywDi2FenVp8V5+zjJgEWBg5SaJE=
X-Google-Smtp-Source: ALg8bN5FKddHcrGWono5UpsMPLqZ5N1NpHGJZCSJ3hQLIGkLGFV1mgyHFxVQz3xse4vncUMh7jRcVM6IwDWcKpScUP8=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr17035556vkn.0.1546475785253; 
 Wed, 02 Jan 2019 16:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
In-Reply-To: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 Jan 2019 09:35:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
To: Sedat Dilek <sedat.dilek@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_163701_367251_DF7E421C 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 X86 ML <x86@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, sparclinux <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 9:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
> support of asm-goto.
>
> Currently, I am doing experiments with clang-7 and a snapshot of
> clang-8 on Linux/x86.
> These compilers have no asm-goto support.
>
> What is your recommendation for Linux >= v4.20?
> I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
> compiling with clang - which has no effect.
> This is confusing.
>
> Thanks, this patch makes things clearer and protects users from
> setting "wrong" in the sense of non-functional settings.
>
> I have tested this against recent Linus tree where kbuild/kconfig Git
> pulls were latest commits.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
> v7 and v8 (snapshot) ]


Which part was tested?

x86 kernel cannot be compiled with Clang
since it lacks the asm-goto support.


$ make CC=clang
Compiler lacks asm-goto support.
arch/x86/Makefile:293: recipe for target 'checkbin' failed
make: *** [checkbin] Error 1






-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
