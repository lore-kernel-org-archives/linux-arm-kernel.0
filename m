Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:55:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9442082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GyEoxMKd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bCoCVI8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9442082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Nt7e0Zu8bCmZxHHIi4oSC7FYCFTDF+mMicc0BFnRII=; b=GyEoxMKd6U9pgC
	xkwKSMQMB2uvd1h4r6O3lMkKR6ZptaiL15BG8TsP0j6QnI4+bmVhQbR76VOwpm76ni8fLe7KdkLPn
	TbDOCjhpvVFWxL/AooyUUlLfJAn2KDoootkAe8eDl7vZ3WhGTP/IDNyKZ55g8YK1Az17ut7yDFzp3
	FpPsFUKphawDzEj5T0HiT2gS26ACs0R6TYuWLVGB5qMLcS5JqbjzrsdPq4b2d+Z9pJh5lu3FdVxay
	njdpwH4V/YBMHOv4BwfLVv2ohlKyet/x2okL7SmFhed4u2JNGBLuPQiHCAKWvwSL0YOhxm3yCsU33
	nkN6ZBbxfzyQfO/OelpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVWWG-0004WO-Kg; Sat, 08 Dec 2018 06:55:20 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVWWC-0003nx-Kc
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 06:55:18 +0000
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id wB86slTQ023895
 for <linux-arm-kernel@lists.infradead.org>; Sat, 8 Dec 2018 15:54:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wB86slTQ023895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544252088;
 bh=2ukJwhYrmX7g0gk632W513hxxXmi5FDbGjWOPC7DbqE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bCoCVI8H+KSQ9O+fPQ1IdPJ9JyFJZsdxbAoMvAcR5K4e+ZlxXxVMu6POnY15U8CVL
 gR4UefHmoeJH1T67wKoIdzg8Bt1wQftnbNxqubABSP5FgcvbZ5NAibkpk4my6+LNLX
 D7hxcS/KOyBznbN9QaAvho41aDpQ82YX2yScPIZLIKP4biO9QRWqoO8udFLEH4cXdv
 Wya+RKmm++FSBxmRSWW1iviJOtUs79NdAuGNAXM4dD1DR8XOu/FpWMRNUkFyVBG5ot
 jwoQj+4ObyqvHtXinD+IrcWbkjuDg1pi8G64Rf5SbsfytgmLYxYec135BC8uyzC9xD
 8F6YdrR+3Rq4Q==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id v24so2175309uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 22:54:48 -0800 (PST)
X-Gm-Message-State: AA+aEWbI2i0fgaq5MavBq1TMJiUetrf7r5SO1bl1gqtGA/lKICQzfU1G
 FEEuePsmbSz6udaaxb0eHSsanUhvYLWMOlcEVPg=
X-Google-Smtp-Source: AFSGD/ViS16FSR+AOPEQ9IqGkf3DM1SmQCKcOqZLJf9UZnwgXOzRNv7p6z3dnCUiBmGU9C1qmJsCqKMAWGhN2ObsUiY=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr2254831uad.55.1544252087299; 
 Fri, 07 Dec 2018 22:54:47 -0800 (PST)
MIME-Version: 1.0
References: <1543624035-4479-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543624035-4479-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 8 Dec 2018 15:54:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpfmBuNVJMyGin09N8M1CwjsyeDUx3AyYb96GhdvF7FA@mail.gmail.com>
Message-ID: <CAK7LNARpfmBuNVJMyGin09N8M1CwjsyeDUx3AyYb96GhdvF7FA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: move .SECONDARY special target to Kbuild.include
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_225516_926420_B7F645FC 
X-CRM114-Status: GOOD (  19.65  )
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
Cc: Jason@zx2c4.com, Michal Marek <michal.lkml@markovi.net>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 9:29 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> In commit 54a702f70589 ("kbuild: mark $(targets) as .SECONDARY and
> remove .PRECIOUS markers"), I missed one important feature of the
> .SECONDARY target:
>
>   .SECONDARY with no prerequisites causes all targets to be treated
>    as secondary.
>
> Kbuild's policy is, "Do not delete any intermediate files."
> So, just move it to scripts/Kbuild.include, with no prerequisites.
>
> Note:
> If an intermediate file is generated by $(call if_changed,...), you
> still need to add it to "targets" so its .*.cmd file is included.
>
> The arm/arm64 crypto files are generated by $(call cmd,shipped),
> so they do not need to be added to "targets", but need to be added
> to "clean-files" so "make clean" can properly clean them away.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.



>  arch/arm/crypto/Makefile   | 2 +-
>  arch/arm64/crypto/Makefile | 2 +-
>  scripts/Kbuild.include     | 3 +++
>  scripts/Makefile.build     | 4 ----
>  4 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index bd5bcee..89f88ab 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -65,4 +65,4 @@ $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
>         $(call cmd,perl)
>  endif
>
> -targets += sha256-core.S sha512-core.S
> +clean-files += sha256-core.S sha512-core.S
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index f476fed..860d931 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -75,4 +75,4 @@ $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
>  endif
>
> -targets += sha256-core.S sha512-core.S
> +clean-files += sha256-core.S sha512-core.S
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index bb01555..0454916 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -393,3 +393,6 @@ endef
>
>  # delete partially updated (i.e. corrupted) files on error
>  .DELETE_ON_ERROR:
> +
> +# do not delete intermediate files automatically
> +.SECONDARY:
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a8e7ba9..604096a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -546,8 +546,4 @@ $(shell mkdir -p $(obj-dirs))
>  endif
>  endif
>
> -# Some files contained in $(targets) are intermediate artifacts.
> -# We never want them to be removed automatically.
> -.SECONDARY: $(targets)
> -
>  .PHONY: $(PHONY)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
