Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF5C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:43:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E6121872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TnIbcgN4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQGPKkhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E6121872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRPcRSUzUtkDwXRp6qbXKOOlZUYaQmQiZARwGyigsUY=; b=TnIbcgN4lRHwvZ
	yUkek25J01QSYH3IJJdgr76j6a39rKG+hgYOunArtGyfQuqhpORmNP8bZQO7X0woMranj2N16gxVg
	uyaj1rK1Jr8nYuWi/W8ptm/tE0i8kWYdgAGO8jLv8E2w2M6pFUdEarCvn2Y5AGCmldEIaMJCcfBBR
	1Ks+TbwNbvjhGcn7KkXMluzoYItRtDXhzVRsA1R9nRIdzo4UqeQESWMXAx8+nD3UTzD3uaAcPx3qM
	vuk0+6ziXkn5YVQsejH57XN8HKr2yYZhKFNnjhiLE9/gofeTFjBG0IOhk4NZjYvg8MUjFbTRIOLzF
	Lte+4BjG5c5ATrwA3C8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpYAF-0005M8-UT; Fri, 01 Feb 2019 12:43:23 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpYAC-0005Lp-BC
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:43:21 +0000
Received: by mail-it1-x143.google.com with SMTP id b5so9556319iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DLqEKDYh+zNHw/1ZKJ7OCvpjKdBaA7p/5n+2KxHYYvU=;
 b=PQGPKkhvTMTyomNdl01gtWVvC0q11l/BK8C5VGK58TMbRLe0g3y4cZA3G/JLJqlUGU
 ejm5KiFaSTAqh/FEXBiY4zNuosDn/uFNZhCozVXozAudsQVctWfxEKGp2RuELBqXVZeb
 nuMHEjtzWQg4zy55yXQHxZrvLHFvlceiMPzo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DLqEKDYh+zNHw/1ZKJ7OCvpjKdBaA7p/5n+2KxHYYvU=;
 b=FuF53QsTieI5b5A5TEQocVXR99xf1vzHs2uehBDe37/evFLrqDKBW/X+IRZEAG22op
 YrGRhxiAcTLUPW1A9lX6vVreWEcs5AuFaYmkEhbnr1ru7QRntdER40Q1NA0Gi+ZOZawo
 nqbcrXABipiLTAukN4NJ0bbH3GTUu1LpqBOzYfyLH9lppUl4djGDkxiw+yQxfQJqW3HF
 WSdHlhsyfDkRyV0DyZOWmjANNJAJoK4z0+cZsbrFpgo6fh0jm4DElvkmpvTJLwKZbWUn
 s0q2VbpHAUo0e0I0dkh6ZjFwA7HdZgOdS9GZJz8ycBU6BNgCHa+jjxyzpUWs4zPW22j+
 3YRA==
X-Gm-Message-State: AHQUAuZx5n0EqM23rp+4maD5lp0qyxfnJTOjOAlYh47O8ERTp+8yf0v4
 IJRqUKLOe04AplTSrvjIdFDMScOjXvqx7TAH+ApDkAGj
X-Google-Smtp-Source: AHgI3IapweaRKvnoXqMlZ/aYPh/3KS64eNquJ32FRGSZKEvq01CCZriVhwpeup0WfiApy0sJkF0Lk/WvowZ9wRbvgPM=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr1370140itk.71.1549024997216; 
 Fri, 01 Feb 2019 04:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20190201111917.y6vv6ouh7esf5uiw@e5254000004ec.dyn.armlinux.org.uk>
 <20190201114552.GA29903@fuggles.cambridge.arm.com>
In-Reply-To: <20190201114552.GA29903@fuggles.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 1 Feb 2019 13:43:05 +0100
Message-ID: <CAKv+Gu8SnO-XBKxVV0V3cR5PM1bEa4WCd4w1A3QqzCq8g1QjkQ@mail.gmail.com>
Subject: Re: ARM64 boot failure on Macchiatobin with Marvell 18.12 firmware
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_044320_386414_9DBA90F8 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 12:46, Will Deacon <will.deacon@arm.com> wrote:
>
> [+Ard]
>
> On Fri, Feb 01, 2019 at 11:19:18AM +0000, Russell King - ARM Linux admin wrote:
> > I've updated the ATF, DDR and Marvell binaries firmware from 17.10
> > to 18.12 on a Macchiatobin Single-shot board, while keeping u-boot
> > the same version (17.10).
> >
> > When booting a previously working 4.20 kernel, I now get:
> >
> > Booting Linux on physical CPU 0x0000000000 [0x410fd081]
> > Linux version 4.20.0+ (rmk@rmk-PC.armlinux.org.uk) (gcc version 4.9.2
> > (GCC)) #212 SMP PREEMPT Thu Jan 31 15:33:31 GMT 2019
> > Machine model: Marvell 8040 MACCHIATOBin Single-shot
> > earlycon: uart0 at MMIO 0x00000000f0512000 (options '115200n8')
> > printk: bootconsole [uart0] enabled
> > SError Interrupt on CPU0, code 0xbf000002 -- SError
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.20.0+ #212
> > Hardware name: Marvell 8040 MACCHIATOBin Single-shot (DT)
> > pstate: 00400085 (nzcv daIf +PAN -UAO)
> > pc : setup_arch+0xe8/0x56c
> > lr : setup_arch+0xe0/0x56c
> > sp : ffffff8008b03f10
> > x29: ffffff8008b03f10 x28: 0000000000a50018
> > x27: 0000000000000000 x26: 000000007ffa2e88
> > x25: 000000007f7a2c68 x24: 0000000000000003
> > x23: 0000000000000000 x22: ffffffbefe90005c
> > x21: 0000000000000001 x20: ffffff8008b46000
> > x19: ffffff8008080000 x18: 00000000000000ff
> > x17: 0000000000001000 x16: 0000000000001000
> > x15: 446e1c00644a0615 x14: 2e392e34206e6f69
> > x13: 7372657620636367 x12: 0000000000000008
> > x11: 0000000000000007 x10: 0101010101010101
> > x9 : fffffffffffffffb x8 : 0000000000000008
> > x7 : 0000000000000003 x6 : 0080000000008080
> > x5 : 000000000000005f x4 : 000000000000006c
> > x3 : 0000000000000063 x2 : 000000000000006c
> > x1 : ffffff8008961ff9 x0 : 0000000000000080
> > Kernel panic - not syncing: Asynchronous SError Interrupt
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.20.0+ #212
> > Hardware name: Marvell 8040 MACCHIATOBin Single-shot (DT)
> > Call trace:
> >  dump_backtrace+0x0/0x158
> >  show_stack+0x14/0x1c
> >  dump_stack+0x90/0xb0
> >  panic+0x148/0x2b8
> >  print_tainted+0x0/0xa8
> >  arm64_serror_panic+0x74/0x80
> >  do_serror+0x5c/0xb8
> >  el1_error+0xb4/0x144
> >  setup_arch+0xe8/0x56c
> >  start_kernel+0x64/0x408
> >
> > If I'm reading the Cortex-A72 ESR information correctly, this is a
> > Slave Error SError interrupt.
> >
> > The failing code sequence appears to be:
> >
> > ffffff8008a53098:       9401506a        bl      ffffff8008aa7240 <dump_stack_set_arch_desc>
> > ffffff8008a5309c:       97fff636        bl      ffffff8008a50974 <parse_early_param>
> > ffffff8008a530a0:       d2801000        mov     x0, #0x80
> > // #128
> > ffffff8008a530a4:       d51b4220        msr     daif, x0
> > ffffff8008a530a8:       d0fffcdb        adrp    x27, ffffff80089ed000 <kallsyms_token_index+0x8b300>
> >
> > If I downgrade the firmware back to 17.10, the kernel boots fine again.
> >
> > Any ideas what's going on here?
>
> Looks like you're taking the SError as soon as we unmask them, so it
> could've been pending for ages. It would be interesting to see if it's
> actually caused by the kernel, or if the firmware triggers it beforehand.
>


AIUI, they switched from giving the non-secure world access to all the
SoC config registers to exposing this as SIP services in ARM-TF. So
the SErrors are likely the result of MMIO accesses by U-Boot to
regions that are now configured as secure-only.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
