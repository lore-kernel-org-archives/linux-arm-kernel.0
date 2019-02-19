Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD5FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06962146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uKX8usTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06962146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OAbBrCA1W4ouiBq4gGFoLhi7lzpoGP8UlHSwkYMj8PM=; b=uKX8usTifDnUtF
	+xmkM+6Q4OFxaqfZPrf5jGnftb+337c3njUo4+dBYkFr6Kzid0T/XkECPYE9yWg55liVBKMcLiOjS
	oH8oqYlakXHigcWQv7Dkf89+s3ei3Y6RBDsGKpJAs6y1tkll5ghEV9TI3Vnjq0JsxT0Zkwba7l2pw
	dmRMQwlAK45R3VC2+MjUfzIwk8lWMO1+Yho9MnIu1GbtdhvSVFLgFt4XCQKKoSBS1dIQ/V137x1Jo
	zGEDNnc9c0StwV6myotVVuBULY72zFP7HJte3sV2n5I2NP8cPJI9O6Vy7N/bruyVQylnA9dVgaXhj
	MBZrI60ckStB/n2o4Lcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1KP-0001Gh-E7; Tue, 19 Feb 2019 09:04:37 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1K3-0000yP-Sk; Tue, 19 Feb 2019 09:04:19 +0000
Received: by mail-qt1-f193.google.com with SMTP id v10so22293168qtp.8;
 Tue, 19 Feb 2019 01:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=duVmfkmCaKyI9suah2ZRlGhjzmTZPtPlQOQquFJ631U=;
 b=WU12qNlN1SeyyckLKRcYhAjfrXMw6vimRvVIUrqXIgKxzGtH4zb/cRl6hTY3xeSewB
 GksM8bFjsETPLWNpoBjUvoE5gpVfuiuG3SNPQTn5DDkqmTZULRXoH8kv36qzj6lhTO42
 vCzUDJnnek9sSUC/cH5KZk0KZnv7H24CfLMaJ9EvlsKf75nsYqcGlvnhWUfMqOmSK6sF
 GvW9XNrJ/lcgUObVA7KgpEHUk7VNaOeKRMsMYH9cSVTDemchOWDXc6MGyPWhncSxeigL
 s4x3xs8rKIWdKXiblzlsxtoldEzp4v0YtW+rcUWzihu8Q7zl80YFF4sIycD1/LmzIQBe
 crZQ==
X-Gm-Message-State: AHQUAubedfBJuV3fcmdrYoSjkDzoexjSgWrTXX4FdEkVu13B9gDij5JB
 tkQbgq4amfkrcJoM+oRyyi3vW+a27zVEICMinn0=
X-Google-Smtp-Source: AHgI3IYg19qI+e8SxIgEcwghsNphBBbOMbd8JoAMf2bRV3g+BmWK61s3iETvwplmqz4xYFhpqC5f1IE2GTFoPjzowzg=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr20909616qvn.115.1550567054789; 
 Tue, 19 Feb 2019 01:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de>
 <20190218210712.3503891-8-arnd@arndb.de>
 <20190219021834.GA4495@guoren-Inspiron-7460>
In-Reply-To: <20190219021834.GA4495@guoren-Inspiron-7460>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 10:03:57 +0100
Message-ID: <CAK8P3a0c6sNAPb_t2H9DbOi_antu4p5ncY76Vc6cFRZc=ZtiBg@mail.gmail.com>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
To: Guo Ren <guoren@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_010416_180339_13970982 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 "moderated list:H8/300 ARCHITECTURE"
 <uclinux-h8-devel@lists.sourceforge.jp>, Yury Norov <yury.norov@gmail.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>, Joseph Myers <joseph@codesourcery.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 Stafford Horne <shorne@gmail.com>, Mao Han <han_mao@c-sky.com>,
 Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 11:40 PM Joseph Myers <joseph@codesourcery.com> wrote:
>
> On Mon, 18 Feb 2019, Arnd Bergmann wrote:
>
> > We don't yet have an upstream glibc port for csky, so there is no user
>
> We do.  It's in 2.29.
...
On Tue, Feb 19, 2019 at 3:18 AM Guo Ren <guoren@kernel.org> wrote:
>
> Mao Han has merged csky port into glibc 2.29, so we should keep the
> __ARCH_WANT_TIME32_SYSCALLS.

My mistake. I've dropped patch 7/8 from this series now.

> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 6959e0b1e956..398113c845f5 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -1,6 +1,5 @@
> >  config CSKY
> >       def_bool y
> > -     select ARCH_32BIT_OFF_T
> >       select ARCH_HAS_SYNC_DMA_FOR_CPU
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >       select ARCH_USE_BUILTIN_BSWAP
> > diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
> > index ec60e49cea66..224c9a9ab45b 100644
> > --- a/arch/csky/include/uapi/asm/unistd.h
> > +++ b/arch/csky/include/uapi/asm/unistd.h
> > @@ -2,8 +2,6 @@
> >  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >  #define __ARCH_WANT_SYS_CLONE
> > -#define __ARCH_WANT_SET_GET_RLIMIT
> Seems it's not related to y2038 issue. Is __ARCH_WANT_SET_GET_RLIMIT no
> use ?

In new architectures, we do not need to set CONFIG_ARCH_32BIT_OFF_T
or __ARCH_WANT_SET_GET_RLIMIT, since we can assume that user
space always uses a 64-bit off_t and a 'struct rlimit' matching the
kernel's rlimit64, with the prlimit64() system call replacing both getrlimit
and setrlimit on the kernel/user ABI side.

I don't know if glibc still uses the 32-bit off_t behavior or the old
getrlimit/setrlimit, but if we're not also changing the time32 interfaces,
the safest option seems to be to leave all three in place.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
