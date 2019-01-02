Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C727DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:22:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993E8206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DPe5feRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993E8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ms9vWhM4L/p21GCmF3d+rN+25ZAYJaPIChMKCKJYCRc=; b=DPe5feRa5OfNP+
	TXRgefMyyaIN/myIKZyN/ZlOgtE/cXOqf4zunlD5/EFtD82n0aqdxogONLObrPU66kH9M6U0y9/kq
	qgMXHrRneyUjs+8IMtQriO/le05Mc2cecIaRt21hrSTkFZsotJNe76H6jmn8CHqwzRQiYlxdp5UM3
	Z93cr22vhqjMd+eZCV57E3cWby22igJDAoQIJL8tzKK9GNN5icNpZ0533u/YOS070TW33ajDaINvI
	5bbLWmQ4576SUg9JBhW9lmSo4Is08FUrUbOQcbLpo/RUONjKBGtfP24RxZ/4itbQY1mcDbh2AgADU
	AZZTsyq8DwK7j/1oog5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geebp-0003Ve-7v; Wed, 02 Jan 2019 11:22:49 +0000
Received: from ozlabs.org ([203.11.71.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geebk-0003U2-Vc
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 11:22:46 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43V7v05cZMz9s9G;
 Wed,  2 Jan 2019 22:22:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] jump_label: move 'asm goto' support test to Kconfig
In-Reply-To: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
Date: Wed, 02 Jan 2019 22:22:44 +1100
Message-ID: <87imz7xq0r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_032245_203211_CEA957F1 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
 masahiroy@kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Currently, CONFIG_JUMP_LABEL just means "I _want_ to use jump label".
>
> The jump label is controlled by HAVE_JUMP_LABEL, which is defined
> like this:
>
>   #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
>   # define HAVE_JUMP_LABEL
>   #endif
>
> We can improve this by testing 'asm goto' support in Kconfig, then
> make JUMP_LABEL depend on CC_HAS_ASM_GOTO.
>
> Ugly #ifdef HAVE_JUMP_LABEL will go away, and CONFIG_JUMP_LABEL will
> match to the real kernel capability.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> This is a trivial conversion from the build system PoV.
> I want to queue this up to kbuild tree.
>
>
>  Makefile                                          |  7 -------
>  arch/Kconfig                                      |  1 +
>  arch/arm/kernel/jump_label.c                      |  4 ----
>  arch/arm64/kernel/jump_label.c                    |  4 ----
>  arch/mips/kernel/jump_label.c                     |  4 ----
>  arch/powerpc/include/asm/asm-prototypes.h         |  2 +-
>  arch/powerpc/kernel/jump_label.c                  |  2 --
>  arch/powerpc/platforms/powernv/opal-tracepoints.c |  2 +-
>  arch/powerpc/platforms/powernv/opal-wrappers.S    |  2 +-
>  arch/powerpc/platforms/pseries/hvCall.S           |  4 ++--
>  arch/powerpc/platforms/pseries/lpar.c             |  2 +-

Looks OK to me.

If there's any odd build errors they should get caught in linux-next.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
