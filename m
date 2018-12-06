Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95654C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:31:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6420A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tkys9Dd3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4jc937S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6420A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ark46AN0lU/4wLDqqvD6xYwAX1dNGi5XH/h7l6qL/9Q=; b=Tkys9Dd3uiCEsX
	Xl2nO7XHw7YYQSbULtt1l03/PANy7G9971TfgMRAWdgBdhJjxnRyRRYb631xlyEQi/zBNhmrpE04j
	caZPPS88K+eQWeaLCQEsH08geCbEw8E/V/wUJXw7NaSyyzotMceOUxB1mffQPORNoYMAPjeHqvJAv
	e+qNUAhZ7why5rT60IQRVDAaHroIsLVz17rlAXMooLtUGGYgW/v4OpotwR2HVyR6zq4dmWq2WTlA/
	bpjj92sCvsQV0HtELzbfMwge4z16eqwhgn5Qs/9Sl3LXgsUWytXmeLExFjGnnwipu/Mua1kswFyyn
	+DMAdVyjAiBqbjFHeYUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUugB-0000uk-9o; Thu, 06 Dec 2018 14:31:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUufu-0000fS-6t
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:30:47 +0000
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6EB5E214DE
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544106635;
 bh=RIj4zuLNQjBUDO3Gu1IQ/1ZkhguK3sXWeXl/a0fKPZc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k4jc937SkjUfJdw6NH/Z//WwKULlmWt7IIscDeGaRtaRcmNTR15/Yzl7MQPnkqxDB
 dW1AHk29svSCCMcKERcmwXN+UK3NtWXJSc2N0oE5c2OYfsXnzIMkpJYYUbShA7nTEU
 JmsWfEg+OoXekcCxcefHUZaXx7ZvC3bvUIbRLH/8=
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so584884lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 06:30:35 -0800 (PST)
X-Gm-Message-State: AA+aEWb77dtM/mTS83c/ODdvWbktv7b93RXscp3kTm5HYNJ+PyUMZZ+7
 sosE7OMHGwB1Z46fEvSes+9W99X4mQ7nhF156Is=
X-Google-Smtp-Source: AFSGD/Xpd8Lb0tKASOtPcfTN3SxPisFxZpLkl5eRzPJEkYxeZE7FfdMUzv36tMVlSbR/KdlgQetMfxpWvKJOPYMci/0=
X-Received: by 2002:a2e:5d12:: with SMTP id
 r18-v6mr20360991ljb.89.1544106633546; 
 Thu, 06 Dec 2018 06:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
 <20181206140717.GU30658@n2100.armlinux.org.uk>
In-Reply-To: <20181206140717.GU30658@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 15:30:22 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
Message-ID: <CAJKOXPdUABPbni+1H=tTvA5wKe8Rc8EPTFKtLGMwQ8yLcb3=gg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063046_280530_EDF8AD72 
X-CRM114-Status: GOOD (  28.77  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, Qais.Yousef@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 15:07, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 06, 2018 at 02:54:10PM +0100, Krzysztof Kozlowski wrote:
> > On Thu, 6 Dec 2018 at 13:40, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Dec 06, 2018 at 11:24:27AM +0100, Krzysztof Kozlowski wrote:
> > > > On Thu, 6 Dec 2018 at 11:01, Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > > I've no idea based on what you've supplied given that the SoC
> > > > > maintainers are responsible for writing the code to deal with hotplug
> > > > > etc, and Exynos's code there is something of a maze.  It's not clear
> > > > > which bits are being used.  I think you at the very least need to debug
> > > > > to find out whether the problem is at CPU down or CPU up.
> > > > >
> > > > > From the ARM architecture point of view, for Cortex A9, all the
> > > > > processor function instances should be identical.  The only difference
> > > > > as a result of the patch is that we'll be calling smp_processor_id()
> > > > > early (which should be fine), and indirecting through the cpu_vtable[]
> > > > > array rather than merely dereferencing the processor struct.
> > > > >
> > > > > What about checking dmesg - messages from offline CPUs do not appear
> > > > > on the console(s) but are still logged in the kernel log.
> > > > >
> > > > > You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
> > > > > always access cpu_vtable[0]) to see whether it's the smp_processor_id()
> > > > > that's causing your problem or not.  If it is, then try and work out
> > > > > which of the processor functions is causing it by restoring
> > > > > PROC_VTABLE() and then switching each from PROC_VTABLE() to
> > > > > PROC_TABLE() until it does work.
> > > >
> > > > Thanks for hints!
> > >
> > > So I can plan, how long do you think it will take to get some results
> > > from my suggestions above?
> >
> > For Suspend to RAM, on v4.20-rc3, this warning appears:
> > [   84.046722] WARNING: CPU: 1 PID: 0 at
> > ../arch/arm/include/asm/proc-fns.h:124
> > secondary_start_kernel+0x214/0x26c
> > (difference between dcache_clean_area)
> > The secondary CPUs bringup fails with ETIMEDOUT.
>
> That basically means that the dcache_clean_area method for CPU1
> differs from the dcache_clean_area method for CPU0.  If all your
> CPUs are identical, that definitely should not be happening.
>
> Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.
>
> Please try this patch.

This fixes both hotplug and suspend to RAM. I was trying to narrow why
the pointers to all processor functions differ. During first boot they
were OK but it seems they were changed just before suspend.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
