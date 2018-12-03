Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2E720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aCo9DlcV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIHDC1mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2E720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MAfBQd9jLxS4c/DBiG/IjrHxdyvpu4VGluk6eJMw3L0=; b=aCo9DlcV/gFJw8
	nsKL9lAPtx4uVb5g3KFB5yE/nD/xqNUJBQE9S5CKFew2RtTOqPMsOFJ1PpwkZXB3TPQuEgIbcwYFv
	NlHPmWya/ABNhXbNlcxyjwgCdDLl3mO1TT/sdIl4SamDtSpMwXfA+Ig7YQ3VJUkbFHT+zhytMhZxT
	aaE2jPHnfwIiX1M4e217EVN+wYio1UuDSqy6248jWkJNgWjr9rzlogLGEzsjJmZXBPSdntCaKAzEe
	pAncR4NcQXZ3WnN+BNGVLmIOEeOfBoVgfE+6yqa3+wIfjn13uxwpJDd1Q+UY+AJxD+YbEhZo6h16Q
	PS946c7WjBOIQ0ZJcVzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvIY-0002wH-HU; Mon, 03 Dec 2018 20:58:34 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvIV-0002vr-W4
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:58:33 +0000
Received: by mail-it1-x142.google.com with SMTP id m8so9438838itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gQ/LOBLKLQNjqRAmRFB6PVrQ87aA/P3RCJ0OetIavkE=;
 b=VIHDC1mV33CyFNHeUL0eFvjM+E1/YgBsRH8H30bUPYIFvGx8UW/3gSyuhvJgqX84VZ
 V4qgJFR8GJJMDJrxXdr0xYzH/ngeD3W0AzQ1sJs9HeQTHfYqRvrTho3QGH9rjQFhxRrF
 xEdQ+koNX0WzYNFuWgBaeZgNW2AW+thrqylbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gQ/LOBLKLQNjqRAmRFB6PVrQ87aA/P3RCJ0OetIavkE=;
 b=lpxGmt7+NiZaN98i13FPMhAXgVDXRdvA2y9gcBICrajw4tCgRlZ4nqkH2w33uUiDnF
 rCEXdQw0XoYX0Kgv0UwtN+uc1e8KQtGZJxQiRlvUWc05xtdGvxTEWUDFEPMpzq8fh5IF
 30lfZ1H+8VXTR4L98/rn/N4A0U5vCm8cX0fIBJ4BVt+pARIBbC8ajVthypXaS5BsR11j
 nHDXL3eowzsbpn+7ccKSWcs6SfzzdVhqOpbrL7V9uYrY13i74JLA7YVQsBZ0ZnepE3fT
 8gPdIKPpi96wb9jp49jeyl/wUWR1ZUSWuxKX9upDtG6wb4P/uFz3ClnrWQ0zzE+AoEXt
 dnqQ==
X-Gm-Message-State: AA+aEWZsJWOMC/oBFKze3W02TNgsPNREJEmW+eT6P0X2t3G1RhjO2XBD
 NCfmoOmOhaDDIhEitkX6YickVWyFFwxBGtNl85THZQ==
X-Google-Smtp-Source: AFSGD/W745/qCYzabdK/bv8nMYJi4rNEGXKWdw5ngajbD7KP2IugBqUqWccgLXs1beWQKbZN7r+fmX8ptg9x+BYu3dw=
X-Received: by 2002:a24:710:: with SMTP id f16mr8342197itf.121.1543870700985; 
 Mon, 03 Dec 2018 12:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
 <CAGXu5jKfRDZJcWpAb2bqziMLXifcrSeCG+X06P=gg5o0WqKTxw@mail.gmail.com>
 <CAKv+Gu_BgGYC3pgTx66g8He6kWUx8sz6rLmupvXNXhDasP79Rw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_BgGYC3pgTx66g8He6kWUx8sz6rLmupvXNXhDasP79Rw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 21:58:09 +0100
Message-ID: <CAKv+Gu8XKFVS4CRZMM5L9_dsAWcKJWNdK8rXQSQy=OLtaPaV1Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: enable per-task stack canaries
To: Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_125832_071053_ED79C6EE 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-hardened@lists.openwall.com,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Laura Abbott <labbott@fedoraproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 21:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 3 Dec 2018 at 21:54, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 9:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > This enables the use of per-task stack canary values if GCC has
> > > support for emitting the stack canary reference relative to the
> > > value of sp_el0, which holds the task struct pointer in the arm64
> > > kernel.
> >
> > Yay!
> >
> > (Should we include the gcc plugin version of this too, since it may be
> > a while before gcc with this support is available widely?)
> >
> > >
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > ---
> > > Note that the cc-option invocation below relies on the fact that Ramana's
> > > current implementation of the GCC support permits -mstack-protector-guard=sysreg
> > > to appear without defining the register name or offset.
> > >
> > > The $(eval) extends KBUILD_CFLAGS at the moment the make rule is applied,
> > > which means asm-offsets.o (which we rely on for the offset value) is built
> > > without the arguments, and everything built afterwards has the options set.
> >
> > Can we detect this from Kconfig instead and then remove the flag for
> > the asm-offsets.o build step?
> >
>
> We need to know offsetof(struct task_struct, stack_canary) at Kconfig
> time, which could be affected by struct randomization as well, I
> suppose. So it is not clear to me how we could ever drop this step.

Ah never mind. I see what you mean now.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
