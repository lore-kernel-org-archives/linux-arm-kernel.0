Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578BC20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DXZolZUj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LHUDZGZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578BC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HdziOSr1Cn3EIw9ZD1upo+ZYnE0Elg10ycdB09hXGOg=; b=DXZolZUjKAs/y4
	fv0Sdb1ZM0+JmCdixqEckR6Nh8Irqo+LqljzWibaHD8PaY4ZRcXjv02BF3BHHopJdVi2QVS1Wf6B+
	RUF07to1MFs8qWS/IclJZEqqoFpy67ydrbZBm9MjZIWSpVY9mAQbFOj7zIJNhfSswjZnHNuX3lpy9
	glPTTxpmda3R1VHi3mH2/iFuATP8vq1jleV85AO+BeqYh8JBjAHCJoXnsy/I/iUpOT2Z43Vg0/YJK
	bsae2m9QRkqGN7bdf/SGRmM8VBpBcCw9d00d9h+i2qfxBlnYCus1J0+S6CLkSmDT4FIY8dOn5T30K
	1vG6ew+wMOop35xjOYVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdKh-0004ED-Gw; Wed, 19 Dec 2018 15:00:23 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdKd-0003UY-FU
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:00:22 +0000
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id wBJExgnV010917
 for <linux-arm-kernel@lists.infradead.org>; Wed, 19 Dec 2018 23:59:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBJExgnV010917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1545231583;
 bh=oEyUaPRgoOB5/8i/zNyaTV3hiVewFWSWNsRx2RayK7A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LHUDZGZDt3HJpB460baizFQdy+PkwOTA8FdLH0x/Ts0CHUV+GwmDwiZJBv/9AueSf
 rVVSPLgkbc6JR5Tr4+O5LsB4I2HmCxl//b27PqOJ41I1sx4BfMWfKNmPoT0usS1Ued
 86HVwB8hukZg44kz81EaStH2AhtMfQd/7VRCsGg+ACQDkz/SHT3eZQW9MO57yeyP3b
 nUa06aMAzfhYVM5+paPWFtxGgQiarwLX7xCSmdOmwj2pnn3xzCItrp5djSE68YMwOt
 Kvdvfsgdeu6CFT1WdwIqUc11I3Yp2k2rmgVcCsaUncIxQF3nHdqJEKdQcA6lZHf7vB
 pbmm7+pouK33g==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id n10so220172vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 06:59:43 -0800 (PST)
X-Gm-Message-State: AA+aEWaXFliEQl42wzoX3wABZzLazdJlQ1tIYvQ9rot6ir2S0glz9G76
 1VLfuGatGt/5TP3/cIFqfRYCkAez8P66wj2u+Ko=
X-Google-Smtp-Source: AFSGD/WlXGX0E+JpbfMdBvcAjMEit+ipXLxaalp+G9cBKAZ5gK1+VOg3XtfI6HU9SeP1Qold8lZlTarARj9HoxnAgmw=
X-Received: by 2002:a67:385a:: with SMTP id f87mr10388847vsa.179.1545231582289; 
 Wed, 19 Dec 2018 06:59:42 -0800 (PST)
MIME-Version: 1.0
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 19 Dec 2018 23:59:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQigp+cnH18w6iYKjix3oZtOOjOF=e1RKiJPdBFr3TwPw@mail.gmail.com>
Message-ID: <CAK7LNAQigp+cnH18w6iYKjix3oZtOOjOF=e1RKiJPdBFr3TwPw@mail.gmail.com>
Subject: Re: [PATCH 00/27] kconfig: remove all reduce/shift conflicts,
 refactor lexer, fix various issues
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_070019_765958_EF52E595 
X-CRM114-Status: GOOD (  16.54  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>,
 Ulf Magnusson <ulfalizer@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 8:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> When I tryed to change something, I was often hit by annoying
> shift/reduce conflicts in the parser.
>
> The lexer and parser are too cluttered.
>
> So, I decided to clean-up now.
>
>   - Fix all shift/reduce conflicts in the parser
>
>   - Rewrite the lexer. The linear keyword search was removed.
>     The number of states descreased from 6 to 4.
>
>   - Fix various subtle issues
>
>
>
> Masahiro Yamada (27):
>   kconfig: fix file name and line number of warn_ignored_character()
>   kconfig: fix memory leak when EOF is encountered in quotation
>   kconfig: require T_EOL to reduce visible statement
>   kconfig: remove unneeded pattern matching to whitespaces
>   kconfig: refactor pattern matching in STRING state
>   kconfig: fix ambiguous grammar in terms of new lines
>   kconfig: clean up EOF handling in the lexer
>   kconfig: warn no new line at end of file
>   kconfig: remove grammatically ambiguous "unexpected option" diagnostic
>   kconfig: remove grammatically ambiguous option_error
>   kconfig: remove redundant if_block rule
>   kconfig: remove redundant menu_block rule
>   kconfig: loosen the order of "visible" and "depends on" in menu entry
>   kconfig: rename depends_list to comment_option_list
>   kconfig: remove redundant token defines
>   kconfig: use distinct tokens for type and default properties
>   kconfig: refactor scanning and parsing "option" properties
>   kconfig: use specific tokens instead of T_ASSIGN for assignments
>   kconfig: use T_WORD instead of T_VARIABLE for variables
>   microblaze: surround string default in Kconfig with double quotes
>   treewide: surround file paths in Kconfig files with double quotes
>   kconfig: ban the use of '.' and '/' in unquoted words
>   kconfig: refactor end token rules
>   kconfig: stop associating kconf_id with yylval
>   kconfig: switch to ASSIGN_VAL state in the second lexer
>   kconfig: update current_pos in the second lexer
>   kconfig: remove keyword lookup table entirely


Series, applied to kbuild/kconfig.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
