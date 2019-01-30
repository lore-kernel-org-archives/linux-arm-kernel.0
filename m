Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E5C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:01:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778F62184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="il4yt9u5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOXAuruu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778F62184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DAO/mpGAy7w9Y7Y+h1CnXaA/RQ0dyNwvAa8S/1W+Rc=; b=il4yt9u5RcxFQz
	dZZvlQbtno0cyvzkl9YTeyDpPQJ00vY5cZflXHxS93xPAUKn3xpuKqT+BvgHj6d6Tnk8knXWyM0vO
	o1LbPFdZJYbEDHSJCN0ibFnYSrja9jzUQhykdCYEsFvSFG4PbTw/BaDPyD/SOKQwwerGtXI+Fs5hv
	/MNpQ9Zdbf16b1Gm9O+pqLAXhHkFfemPDgE46Yfz2Na+zT7SoEcl/4ruXIlvYG8gbCzdAsa2hZ7gQ
	2BVfUjSnhod6bCChkgNShlT3QyiEITICxdthG1gGARqukn6Faw+G2WR0RUNaGeryp2EGOQbBjlGyk
	hxmEo3oAisxQJnHJB6UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowyw-0000H8-KH; Wed, 30 Jan 2019 21:01:14 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowys-0000G5-T4
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:01:12 +0000
Received: by mail-it1-x143.google.com with SMTP id z20so566435itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wjMxvtUGyvdMJmKFM2cu9vVa62OCkGlFeyT+Eg545qY=;
 b=VOXAuruuzM3naeCYrXul79K0++MGWQ7Ek+8Tx1+CDYjY+Bt3Fl8gfnOo19hYuopXya
 pjceY3vPn8V04CnBFf5ZDmksWxBAmd1dyYlD1r7NijuIWHmKDhdZlFbCR/R+HoTrxt0h
 Hv4/xl9goSaPBL30oPhgMLsOJHwhbudn4QPkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wjMxvtUGyvdMJmKFM2cu9vVa62OCkGlFeyT+Eg545qY=;
 b=bQywLLX3Y13V5Uz8URTVzEqlGmN3HdKz0nkRaZ9M+W1CPKNhbYQyI2L1v3UKaGPr1Q
 DWWasdlwdemZb1xLL4XbW2acWJsMTPnrjLOfdlXsvyOt01SE4JSBI3w25XjjXXqTTAeI
 MvzplWn0Pi5Q9JcmIzGKkuMwki/XOegarMlzJeyzW7Lx7Qx1lbgxBrncQR3v0uhyCDZY
 Nz5UygpHWwRU6D5nSeIQiPluLTjJ04Ru/6qX5MD/+qPM1REvNMCebB1r45PjWZuR5Sfd
 XK3W90C7j1uxtq+NkSHJfIjohL5KQ8nG9RV5k9kP+5XuOaYetCLp/aSmX+H8bPdtAyEZ
 xtdw==
X-Gm-Message-State: AJcUukd1gtuO1ZlgLnlyKyKwH4e/b8hZKCC08oCUL1lmdDjRL3v0vZBi
 sDjl23sUk+7y11KRuDDggLCpikml11U4Dsvvu0AuUg==
X-Google-Smtp-Source: ALg8bN7I73utdrxejqKmM9oYGl/sbIkFhFJbv1GG96aFFZ7+kloiyRhPMwxJQTCZFoKJ8oIWx4ogUyGjjoXFk0Ra/f0=
X-Received: by 2002:a02:734b:: with SMTP id a11mr18399958jae.62.1548882067736; 
 Wed, 30 Jan 2019 13:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <20190130031444.28935-3-ebiggers@kernel.org>
 <20190130205553.GA231835@gmail.com>
In-Reply-To: <20190130205553.GA231835@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Jan 2019 22:00:53 +0100
Message-ID: <CAKv+Gu95XurUKRqV7VR5X1ECfDqDEw78qS_ggn9pcG30S-6zFg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] crypto: arm/crct10dif-ce - cleanup and
 optimizations
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_130110_964363_BA967456 
X-CRM114-Status: GOOD (  11.67  )
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
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 21:55, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jan 29, 2019 at 07:14:43PM -0800, Eric Biggers wrote:
> > +     .macro          __adrl, out, sym
> > +     movw            \out, #:lower16:\sym
> > +     movt            \out, #:upper16:\sym
> > +     .endm
>
> Hi Ard, it seems we need the __LINUX_ARM_ARCH__ < 7 case after all?
> The kbuild test robot reported a build error, which can be reproduced with:
>
> ( cat arch/arm/configs/multi_v7_defconfig;
>   echo CONFIG_ARCH_MULTI_V6=y;
>   echo CONFIG_CRC_T10DIF=y;
>   echo CONFIG_CRYPTO_CRCT10DIF_ARM_CE=y ) > .config
> make olddefconfig
> make arch/arm/crypto/crct10dif-ce-core.o
>
>
>   AS      arch/arm/crypto/crct10dif-ce-core.o
> arch/arm/crypto/crct10dif-ce-core.S: Assembler messages:
> arch/arm/crypto/crct10dif-ce-core.S:165: Error: .err encountered
> arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_128_bytes_consts' in ARM mode
> arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_128_bytes_consts' in ARM mode
> arch/arm/crypto/crct10dif-ce-core.S:267: Error: .err encountered
> arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movw r3,#:lower16:.Lbyteshift_table+16' in ARM mode
> arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movt r3,#:upper16:.Lbyteshift_table+16' in ARM mode
> arch/arm/crypto/crct10dif-ce-core.S:329: Error: .err encountered
> arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_16_bytes_consts' in ARM mode
> arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_16_bytes_consts' in ARM mode
> scripts/Makefile.build:367: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
> make[1]: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 1
> Makefile:1709: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
> make: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 2
>

That does not make sense. That code can only execute on a NEON capable
CPU, which is guaranteed to support movw/movt as well. So I'd prefer
solving this by adding '.arch armv7-a' to this .S file.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
