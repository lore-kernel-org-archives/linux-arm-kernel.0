Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B8C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:16:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CB82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TS1TWY/n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ct1Q7AGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CB82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jmq4cHVh4DII7gjICQ4o/HV+6t8UlRaokSKlzce4ymg=; b=TS1TWY/n1/MybE
	6b+QqITi8KV3U7EMu58Qsn4IRrVmb2C6/USad4G2FXo76ANB5WFWliEeBssCWJJNnJHTMaLTnOiZn
	42e2KcNcIJnQGH82KS42C39gvy3jTm9hhLIAZmyZwdPZ/PymvC9AiLzup8W9aufRlsiirnmEbkssx
	4snivfCLx1C8Y0tDqckj7vz0E+AJGiGxXsP1kX60l086oYqeP4TkPbB+VDUpaB+szoEwjS9+OC9c9
	T8S9W2jhRyq88il+mH01G1fj0OH3z1hYrx5hOgJyarNDM55/behiBrr030yJ0yMkeq0bPB2PSdCS3
	sVBbBjQcvYUNRYD2OCaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVWt-0007RY-G8; Thu, 13 Dec 2018 18:16:11 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVWq-0007Qc-Ea
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:16:09 +0000
Received: by mail-it1-x143.google.com with SMTP id g85so5072915ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jetzu+LmyuhNP24jLyn9ZDS6DIpioEtZ8VCdsw+GJp0=;
 b=ct1Q7AGY6IwhPHqOYTKglRnpj651ELLful6lDbHfk+KpW9heTdPSvnmuizaVQmvXac
 iehMr4FEaxwzdLa6ELHAJC/X2wO/EEBUM/qHDe65ElhwGpsTd772XVwyJ03qG2JldT6S
 ced1xpxA4sQ7rGJJdNDlTOE25eXcw0kLz9WJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jetzu+LmyuhNP24jLyn9ZDS6DIpioEtZ8VCdsw+GJp0=;
 b=TCNJOuXVoORjPGntg3tSQ6HiNEBHw1n3YDQo6waHXPD/DkKRZz0kk2QYOq+dN850xs
 ysaOfuKIyGUsveAS+j7Mi7lcgzkCOnJcTst8v6J45n0WRIWM1pvIBKj3ae2BZ+wZcMfb
 jBBJeKuK0FXYXKndtuwDZ4fOExDv+IjYFVml9n41OBfJh6CQ6TOjHI9NPrwxGw4upXMV
 cMrQwFpPmUHYg82rJ5reQ67MFFqi5z6uIjbl31Wx3xTW9AmJ3wlBx5We292kRg9+2gD0
 ABhxOG2CWJDqsO4Dg+GbcHM7iIj/4XQerKzWxNQRAfltzpAbK8C55Wat24BscrjTkcDp
 TWdg==
X-Gm-Message-State: AA+aEWZeZRI5vEAU25AmnUX3LFsxDPN2XSNktZwmyWPmlH+3YOlN5aCO
 9bEzBi46nrCfdc/fXgUjgdDuJb0BEYabbl4wlr/uig==
X-Google-Smtp-Source: AFSGD/XYXxOncnYj23T+mXnL15S7NTjOEh+U2xrb+DnRjGIM9mM+RxWtNB13y6mOqadMs1rfxTmzpqWoWLYTCdADI44=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr23695567jab.2.1544724957185;
 Thu, 13 Dec 2018 10:15:57 -0800 (PST)
MIME-Version: 1.0
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
 <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 13 Dec 2018 19:15:45 +0100
Message-ID: <CAKv+Gu_40M=JO+P3GOJogXfm=x0JXYjHs=rHWAtR-6QNxjSYvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_101608_497363_54BEB8DF 
X-CRM114-Status: GOOD (  18.00  )
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
Cc: wsd_upstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Miles Chen <miles.chen@mediatek.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 19:12, Will Deacon <will.deacon@arm.com> wrote:
>
> [+Ard because I'll basically go with his preference on this one]
>
> On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> > When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> > perform linear virtual address to physical address translation.
> > Sometimes we're debugging with only few information such as a kernel log
> > and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> >
> > Tested by:
> > echo c > /proc/sysrq-trigger
> > [   11.996161] SMP: stopping secondary CPUs
> > [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> > [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> >
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > Tested-by: Miles Chen <miles.chen@mediatek.com>

Fine with me, but I would like to see an ack from Miles Chen :-)

> > ---
> >  arch/arm64/kernel/setup.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index f4fc1e0544b7..4b0e1231625c 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
> >       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
> >               pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
> >                        offset, KIMAGE_VADDR);
> > +             pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
> >       } else {
> >               pr_emerg("Kernel Offset: disabled\n");
> >       }
> > --
> > 2.18.0
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
