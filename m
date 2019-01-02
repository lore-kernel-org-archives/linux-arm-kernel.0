Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04034C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:09:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C366620656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GMOohQPk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="NKDXpZgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C366620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjQmsNHz6mdVAPcBBHHeuXh+LtT51keSLJlwUmQVWtM=; b=GMOohQPkli2kRE
	8l/zfByvvhcUXA+WJu+ai6la0t5VbpgW1+PCnuRC7y9Bv8QuOsN93v1+tIGgUPf2Y7Jt55OgnwZ+H
	2GgXfwn+TxfLd+8ScjJaBnC36Id+7CTPY0vuOps+vErPo2DYTJ1g7OFIaKCUlvoFYYsxT039ORUxt
	wu8OTU04w/aNpPY6y+REWShwUfWfqETmD76mONfNs3WGoI0i8gDhOiCcCqzzRMChVH69OvSomhftl
	nBUQcUxmll7rK/BSaFSrh0xNv9C7PJitNBK2LQuNMimUOS07Zxv6N9Ts8nydjsvp+E000+zWTPW00
	HxC+Hjktn0RMOSHy99nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gei91-0004Fp-8d; Wed, 02 Jan 2019 15:09:19 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gei8v-0004BZ-Ld
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 15:09:16 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id ABC385C0249;
 Wed,  2 Jan 2019 16:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546441744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyQmrlVqjJYGuohv6QITgAdpSPw6RbmaPhZKcGEJjR0=;
 b=NKDXpZgGGHPbTlJ6ALc6nwnci2LvUkYVEoQ+ywMeylHCJC99U+G+XZuARBPYMaNY8Gtvla
 7kMmY/dlDjRxXB/+LxZYCcqih1RfYnBSCoC7ye5j+Cu9CJ3ofQeaJvLajviIPXWI/hvZFb
 bN5QCwklQaHhZAqjDZR4bHagVEzvjQ0=
MIME-Version: 1.0
Date: Wed, 02 Jan 2019 16:09:04 +0100
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: Re: [PATCH 2/3] ARM: uaccess: use unified assembler language syntax
In-Reply-To: <201812310309.fFJTFUuf%fengguang.wu@intel.com>
References: <8190fb3605e863295bdb6311b1966b69d4fa9e73.1546185298.git.stefan@agner.ch>
 <201812310309.fFJTFUuf%fengguang.wu@intel.com>
Message-ID: <8f6aeb56adcb7a937c834ee24b654805@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_070914_188926_06063522 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com,
 kbuild test robot <lkp@intel.com>, arnd@arndb.de, ard.biesheuvel@linaro.org,
 peterz@infradead.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 kbuild-all@01.org, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30.12.2018 20:12, kbuild test robot wrote:
> Hi Stefan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on arm/for-next]
> [also build test ERROR on v4.20 next-20181224]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stefan-Agner/ARM-fix-argument-count-to-match-macro-definition/20181231-001137
> base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> config: arm-ebsa110_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    /tmp/ccfKN3IW.s: Assembler messages:
>    /tmp/ccfKN3IW.s:26: Error: bad instruction `sbcscc r1,r1,r3'
>>> /tmp/ccfKN3IW.s:94: Error: bad instruction `sbcscc r8,r8,r0'
>    /tmp/ccfKN3IW.s:104: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/ccfKN3IW.s:155: Error: bad instruction `sbcscc lr,lr,r2'
>    /tmp/ccfKN3IW.s:630: Error: bad instruction `sbcscc r1,r1,r2'

Hm, it seems that gcc always assumes inline assembly is in non-unified
syntax when compiling using -marm:

        .syntax divided
@ 244 "arch/arm/kernel/signal.c" 1
        adds ip, r1, #760; sbcscc ip, ip, r3; movcc r3, #0
@ 0 "" 2

It seems that gcc would have an option to force unified syntax when
generating code for ARM state (-marm) using -masm-syntax-unified.
However, unfortunately, this seems currently broken. I created a bug in
the gcc bug tracker:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

The only solution I found is using ".syntax unified" in inline assembly,
not pretty but seems to do the job... Will send a v2.

--
Stefan



> --
>    /tmp/cc9oa73P.s: Assembler messages:
>    /tmp/cc9oa73P.s:2036: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:3325: Error: bad instruction `sbcscc r3,r3,r0'
>    /tmp/cc9oa73P.s:3724: Error: bad instruction `sbcscc r2,r2,r3'
>    /tmp/cc9oa73P.s:4242: Error: bad instruction `sbcscc r1,r1,r3'
>>> /tmp/cc9oa73P.s:4304: Error: bad instruction `sbcscc r10,r10,r2'
>    /tmp/cc9oa73P.s:4831: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:4973: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/cc9oa73P.s:5059: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/cc9oa73P.s:5076: Error: bad instruction `sbcscc r0,r0,r2'
>    /tmp/cc9oa73P.s:5120: Error: bad instruction `sbcscc r1,r1,r3'
> --
>    /tmp/ccnaC92i.s: Assembler messages:
>>> /tmp/ccnaC92i.s:133: Error: bad instruction `sbcscc r7,r7,r1'
>    /tmp/ccnaC92i.s:225: Error: bad instruction `sbcscc r1,r1,r3'
>    /tmp/ccnaC92i.s:631: Error: bad instruction `sbcscc ip,ip,r3'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
