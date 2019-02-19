Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9666DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E472147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYzZkdjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E472147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VoFvpBCD2w8eyNuUVtDP0L4cPAdfU02/WIaJQIQAaEU=; b=eYzZkdjTIKgnPS
	Gy9yjUdWSP4OQjl5IAE9zb4Mc5Qi3TyV5aE49/54MSgalGj3Esy8SpenozRhB1mOvom5JZE7vW/iO
	tvQjJewGJv2apUYiDSUQf0GVOfvxvwuYhjNVG/yguovGQIyHa3GLFNvxGFVn3jLUQNixfLvo/ku0F
	YxoKv1LObahskjSnnHwH8XuyhYSlsPK5BJ1r7YiNSycr8lj05o1sMb47IX/petesEyrYoXFHtn/Gi
	8DYQZzQyQqYPvhMOQNJBonmmGu0vhfwJS+HXZ4FjhZiZucQLquWeUjO7EyjJgSFia74TIVrYf/kya
	p5qsWsLnZ692Y1XYRqWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwC17-0004EX-MC; Tue, 19 Feb 2019 20:29:25 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwC14-0004Az-SC; Tue, 19 Feb 2019 20:29:24 +0000
Received: by mail-qk1-f196.google.com with SMTP id p15so535995qkl.5;
 Tue, 19 Feb 2019 12:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bPY1f5W3M3S0pVQ+klaobPrfxSm2NF3tA5R2/oioi8Y=;
 b=ai3KIQjaEb0tppyln54ZvSPgT+UVUk+zWOQ+BxabH0LDCK6EEojgeREg7kO82jFD3Y
 YicoceCNBTUjgMqsZVPxlL81o/Jr15iPjVo97iQwg+t7iHjp6htwB/ill4ip6f685MvY
 p8uqUIH9jV0Kym7iSlfUbNn0Q8GCRXTuTd2PtvgX1mK8ljkXqojh6gfLdc4fJ6FOsCKN
 p9ThcBq2KwTliTIIUx/ihYngIU8BFCeV90TLSkCRBCufd8cfeTImtrALZZYF1WMefq8U
 GHyocase4eTiL/EN+kzjBevVF44AWpRy+OJYDC50c6L1kvbMtwMDDuLLOD+s703eB2fN
 H60Q==
X-Gm-Message-State: AHQUAuavDS+k2Eq0QgHoJAi1NkfDfeTHZMeJTKhr+E7nK3FivsFYfBKb
 dZ/VqToZG8UMdmTY/82VnE4esXCpe+siJxA3ohk=
X-Google-Smtp-Source: AHgI3IZWyX/lVaQAvClHL38keads40kOoUMMxm2i4x66H1BX9+lk6NC00fUlkEoemnqJp2fXcbm2Hb1h0YEdHgBZwpY=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr22351671qki.291.1550608158219; 
 Tue, 19 Feb 2019 12:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20190218210712.3503891-1-arnd@arndb.de>
 <20190218210712.3503891-5-arnd@arndb.de>
 <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
In-Reply-To: <CAMuHMdVbz=_GFMnKx4PuxpmG9jpdA=Do2XnR3bY5wRZPM3G+Gw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 21:29:01 +0100
Message-ID: <CAK8P3a0UD7_omc4=o7VLaLKUX4Z1eWXU15TeqgvjXfhyv+7xCA@mail.gmail.com>
Subject: Re: [PATCH 4/8] asm-generic: Make time32 syscall numbers optional
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_122922_912415_A613B9B9 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "moderated list:H8/300 ARCHITECTURE"
 <uclinux-h8-devel@lists.sourceforge.jp>, Yury Norov <yury.norov@gmail.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 Stafford Horne <shorne@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 9:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Tue, Feb 19, 2019 at 3:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > We don't want new architectures to even provide the old 32-bit time_t
> > based system calls any more, or define the syscall number macros.
> >
> > Add a new __ARCH_WANT_TIME32_SYSCALLS macro that gets enabled for all
> > existing 32-bit architectures so we don't change any current behavior.
>
> ... (only) 32-bit architectures using the generic syscall list, right?

Correct, I've added a clarification in the commit text in my git tree now,
thanks for the proofreading!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
