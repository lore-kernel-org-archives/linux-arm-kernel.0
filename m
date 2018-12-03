Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:46:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7426A20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irG65i5K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4U6i47j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7426A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7fSSMELFp68a66wZgBycoQRv70y63I2mQ0sp4UPUy1o=; b=irG65i5KUnDqhx
	/eQYZCTQomsw9XqrRfHryMaIaYpwI2FnKz9dlHKC/snKRJRcSkuWlbfcyAulrDhMLW9ArsIRMz6aj
	YfrIiG8FjYjX12Ih7z3VkVLw8nW3P0hliqMNyqWftQuZ5tu93JkSNAHg2vdqwJfqewZ8Q1L2ZMI6+
	zOWxmn9c+XFED0bvA0JHMxY9MYEIUb68bLcMjowIuVXVoj/ijcn0GC7Fh1myAjakavLDLoLX9UXpP
	hFx5IjLIhcfoZjX0gpTnJFMyHQe1tBcVUCUlBYqdbhd6vcH1OOIb0JkOopcdp+t5ZUf9fgDg+2C2J
	8N0rKc+rvFJf/ZkjR/0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrMy-0004U1-JS; Mon, 03 Dec 2018 16:46:52 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrMv-0004Tg-DH
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:46:50 +0000
Received: by mail-it1-x141.google.com with SMTP id i7so10327357iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BqVBCeapcVZRq9QX2NBc1mHeDnDlCOkpXFVFoRy+0MU=;
 b=D4U6i47j5kGS5Yy9vX2R2c9KGI1D9xoXrFjP3aUu9gYshZ9nLYlHv8SJdvroIajetr
 0JRBrGXVAPn8navewVH4tKLYHbXUOTrg+yZ9OCIlu0+/XHoX3ZIsoIKXBTbECmlzsMih
 JqrG6RSGHZg9rfV7UgVIohRi/JrMSV6pVH1yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BqVBCeapcVZRq9QX2NBc1mHeDnDlCOkpXFVFoRy+0MU=;
 b=D3oAv0XKCViKtkoJMdcak50xv4vWxCvH/xkOIYHqTjuB0+5P0k1IjGbgMeRR9I2IaU
 iig3EuSFGCmGqwDjrLWNWLa38sw8Z6I7agqPabFsnwjbHi1AU3wCZf5RtY+qNWsMmc96
 YrGWN+IMVUkhPZKddfVqSn2tRyEQHAVDJtR1SgPtiGa3QJmggFoVNocR/FUd5LeWEkZ7
 /tqxSQAGaugIimhWWEpuBJUlhmiBvIlR/sp2hJJkuxWmL5HMFVrXWZ7feTN1nZmvbH0D
 FQlOz6+bJXiav5+AEAUflD5goc8V0kNGXqpmX7LlG2AQH3mMbn3sna8TxSff9SDzssvc
 jUnQ==
X-Gm-Message-State: AA+aEWZVP9W/vZDYOSovXqkgX9l/w+OGU/9G5+wMalORfHBhKeDupQYM
 BXgNJPkKq4GsNJ3oLZAWsvGaUoVWlc2EdrwPBtFXSg==
X-Google-Smtp-Source: AFSGD/VXHN+OUPz72CnxX9oDaoUEtn9i6k7oDowHklOhGjgt1ALnkBnPz93EC433xCvvZ3c1I0nPxnSDm07peb7Phyk=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr9316459ith.158.1543855597715; 
 Mon, 03 Dec 2018 08:46:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
 <20180213180436.GA21758@arm.com>
 <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
 <20181030103502.GD19955@arm.com>
 <CAKv+Gu96pRfneQ-SLL3a9d-uLAqOPvkLcB25Md=f+z9f5Yg+fg@mail.gmail.com>
 <9f84b541-1d23-5143-70e3-f42bef3c8e1a@arm.com>
 <CAKv+Gu-UodqRkpK3jVgkgVos=+U5RuBpsPVj5H3CwbzUUPQzKg@mail.gmail.com>
 <CAKv+Gu9Px=RKue=6DT3y+GYZ3vehYs+B6nfVYjtWjjfJpHk4dg@mail.gmail.com>
 <3f863978-a755-e366-2067-135781547b85@arm.com>
In-Reply-To: <3f863978-a755-e366-2067-135781547b85@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 17:46:25 +0100
Message-ID: <CAKv+Gu_9keHrpE5KyDQ0LsZDwsba=kN3LOwAgnpR86Snjf48oA@mail.gmail.com>
Subject: Re: revisit arm64 per-task stack canaries
To: Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_084649_465905_DE149325 
X-CRM114-Status: GOOD (  18.39  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, linux-hardened@lists.openwall.com,
 nd <nd@arm.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>,
 uros@gcc.gnu.org, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 11:16, Ramana Radhakrishnan
<Ramana.Radhakrishnan@arm.com> wrote:
>
>
> > Just building the defconfig with a compiler that implements this
> > should be sufficient, like below:
> >
> > export ARCH=arm64
> > export CROSS_COMPILE=[/path/to/]aarch64-linux-gnu-
> > make defconfig
> > make Image modules
> >
>
> You probably need this patch on top of my patchset to GCC this morning.
>
>
> regards
> Ramana
>
>
> This is a tiny patch to add the -mstack-protector-guard=sysreg to
> indicate the type of the stack protector guard to the compiler.
>
> Signed-off-by:  Ramana Radhakrishnan  <ramana.radhakrishnan@arm.com>
> ---
>   arch/arm64/Kconfig  | 2 +-
>   arch/arm64/Makefile | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index faab97226dbb..6151327cfa16 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1250,7 +1250,7 @@ config RANDOMIZE_MODULE_REGION_FULL
>   config STACKPROTECTOR_PER_TASK
>         def_bool y
>         depends on STACKPROTECTOR
> -       depends on $(cc-option,-mstack-protector-guard-reg=sp_el0)
> +       depends on
> $(cc-option,-mstack-protector-guard=sysreg,-mstack-protector-guard-reg=sp_el0)
>
>   endmenu
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index e1494ba5d0e7..be60d64afae6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -63,7 +63,8 @@ stack_protector_prepare: prepare0
>                         awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
>                                 include/generated/asm-offsets.h))
>
> -KBUILD_CFLAGS  += -mstack-protector-guard-reg=sp_el0
> +KBUILD_CFLAGS  += -mstack-protector-guard-reg=sp_el0 \
> +       -mstack-protector-guard=sysreg
>   endif
>
>   ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
> --
> 2.17.1

This isn't quite right. I will send out an update, but note that it
depends on the logic as to which arguments may/must appear in which
combination.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
