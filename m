Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB3F218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J79UO9vS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mee4RO3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB3F218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gs1CVM1rjarFPfMq4e69/pwF6qYv95GeXJwWFonB9QM=; b=J79UO9vSWLCDrC
	hQj+Tvosb6RqCA/XpdoMZ0pTr5Ou1xAksBvBntSY3uiIzE3qhtaMjbEozCIpDXy965J4wXsKN67gL
	GswcWFcPcQNDq5bfSP/o/SEt4Qm1PStQmEOVoWFlICsZ4hymoVqtUWt5H7SHAA1c+lx9EErSbWH0o
	z79StYCFrXTeLpnK1gWQleglpZEbHWT+dYq4x/+9IrxFAWpVS6TVf+dud+/yshOydsfECmfAzVKJU
	RniIDYryVvnra+VD8p0Oar6XHbVZhl02fW0Lwwvx1W1XEw7vcYkhUbhe+CLxx8LegjZQ5Lg6FC0Tr
	MTxZS/JLd1+MDCm1W/4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyjii-000087-TY; Tue, 26 Feb 2019 20:52:56 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyjif-00007k-1Y
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:52:54 +0000
Received: by mail-it1-x141.google.com with SMTP id v83so6422819itf.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H5CQUZRpETpJgd/qj4sQWah8yYajnATRLgXEBzXN+tE=;
 b=mee4RO3J1VK+UqxetnHiPpgwiWLSTE/apf+oAUN9L+dgeVVaqsk4YNX4136lrMaVgd
 79PxQtbsqvFR+ATtadLHtqhMsOYflBKpZqmP9OZn7v/jAtNPQrZfBomw0ae60Dnm4TLV
 g7J9+Pgyokcw1d+Out3U7IKBF+s9umZZbK3sRZQ/u0nHcftEiVdSiYyXpY4g8mQjRsq6
 tA3ve5YWwbgXFkDcRSyzqi36vwAe+aCJQBoS2rL8FXc/8cmhcR9S+jHOn5YzEy6BL/pj
 4J7yHg5wfvJl/KA23pjCzHZlYRtpV1ElAryyVPqsLcNn+4RmjJAyd2wYp4d74lJX4Vi8
 t6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H5CQUZRpETpJgd/qj4sQWah8yYajnATRLgXEBzXN+tE=;
 b=MDJ53+/T4Z8yBVJ2Qgm35VOweIX5Fw/yvHetcTORi9C7/6OcOEnSfcvbISoxX0H6iM
 RfZqL65pyjJCrxVmgp0Q3XH0cxssm+0DLrZtYOGnv5OiP4lgqYgTIp/qqB9k2HEDXfvT
 GLgoZ8oD1kd2LGBXTG1oFoy8BgHbEgspoX/j8MgyLpY3f1vvYuWdoLgI3Dp4g8N26+wd
 M5j8c5g4+663SFH08D7pSeYUpa8H0LmZ1RUX0bxt2HCSH2M6cXix6OUbQw653yhTL4L7
 BBVWKDkyjr2xpCte0WvH7HqsnA8Z7JtXLErj9+LxYZEDJ91yXjklCgOQdGWaa41DR74y
 KaIg==
X-Gm-Message-State: APjAAAXhel6hfVdiVkHJgn0ol+NV70Et7ULJDWc1rLXP8Bn+ol+NoJLs
 Uu3Kn+pGzH6gmq7wThAeckKfnOp//Q7eU4l1pSC7Fw==
X-Google-Smtp-Source: AHgI3IYt/QyrXb8YEbYqW7hSqmZaIJo7ICA9joT1Z2bqYtuvVwKUpPrkhvgW3RmyrlZ+2bvp6TjXzuolugucs4/JoSk=
X-Received: by 2002:a24:45dd:: with SMTP id c90mr3802493itd.71.1551214371635; 
 Tue, 26 Feb 2019 12:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
 <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
 <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
In-Reply-To: <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Feb 2019 21:52:33 +0100
Message-ID: <CAKv+Gu_TXtSBhTOuucw+6ULEGMkiFS2TBZ7gQ-EJqC7wxC7nrA@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_125253_093231_2646DE1C 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 21:44, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
> > >
> > > Clang warns: vector initializers are not compatible with NEON intrinsics
> > > in big endian mode [-Wnonportable-vector-initialization]
> > >
> > > While this is usually the case, it's not an issue for this case since
> > > we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> > >
> > > Instead, use vdupq_n_u8 which both compilers lower into a single movi
> > > instruction: https://godbolt.org/z/vBrgzt
> > >
> > > This avoids the static storage for a constant value.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/214
> > > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Much better, thanks,
> >
> > Did you double check that the intrinsic exists on 32-bit ARM as well?
> > I assume it does, but please make sure if you haven't yet.
>
> Thanks for the review!

My pleasure.

> Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
> 2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
> __ARM_ARCH >= 8 like some of the other types and functions).
>
> So NEON got some additions in v8?

Basically, yes. One example is right there in the NEON recovery code,
guarded by #ifdef CONFIG_ARM.

New intrinsics were also introduced for the crypto instructions,
although I think those were also added to the 32-bit version of
arm_neon.h

>  Is there a doc that lists them?

Not that I know of.

> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
> is where I found vdupq_n_u8, but it doesn't seem to mention
> compatibility (so I assume it's been around since the introduction of
> NEON?).

Yes, it appears that the 32-bit arm_neon.h header on my box defines
this intrinsic, so this should be fine.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
