Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB5AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:56:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D781A20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lz0b+mqe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOsEHZ15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D781A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8f9qgK5FrxFpAOd8sMDTs2jJxfSMcmM8HQEfWNa0g/E=; b=Lz0b+mqejZ5k2t
	nfBT0ibWRm1g8dlo4nlSSjI98YFM5QydncnC1xnF4cLbp3Gu5SfYx+ik8xKkY8EMmHCp6VbDRyqAC
	V7GL1flGRUjc5Wj3ACpT+TRoC1GCwsOU5HV4jEq5cfM5jEosbevXyVtb2rR2A4nRf/DoMWPv6H1GP
	s1KhvBazucJNLnUUmvz0/x9HNUDbhyxEDfHoUZRwxINE+vUulVljoGFfOVBbeOppxvhqabkETlmBD
	LWe186SfiW43m8kk2DruPZDckglrl6ghu5ta/uZDtxldy+eEtN+Vj/IVWGx4UJjS7wyVXZ7WTiLfj
	CxtCaxfdk8FLRGrvUfHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvGw-0002SX-3a; Mon, 03 Dec 2018 20:56:54 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvGs-0002S8-EO
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:56:51 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so10869099itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hs+K1yekc2OCPDt29sQZOQ6/Li2bmd7q6ubiokkSzR8=;
 b=OOsEHZ151WfasjPzF9Nwpe0UHfOeOcjaReGp9b34xPSybbm5LOU4oVZnX7uhTMsnKp
 99XIWTd5RQNchyKEGP18ltn83mgoiZ5RxvKLOqoE2Fhs6KfHl77yQx6chQAe8T+FmpO5
 lR58wklqqqfoS0ErnrUHJ49v1IhG1hRq6JB5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hs+K1yekc2OCPDt29sQZOQ6/Li2bmd7q6ubiokkSzR8=;
 b=L/Zh/BguNxDpcXcB8ZzCmXPc8NOzh/xV+f0CiRqGUv9lHrRYT1opzZPtkjRwkYZzb+
 9cwd9tC+TIpBpO/N6A17z925yZ64pMV32R2A0ParWv+UITDsoo/Kj+le5Ut3d69aHGb6
 HxmAdB9io2hL8ww1ztP8YlessJmaikqN4SPBeeLaB8ldqZL6U1Mv7sjDZiIQhFX7uXfj
 vUc/E36msWv474J+0D/o3YFDHthNJ7LOg5NZyt2WkTh+IIaVf+Hq0aZmHMKNxuglP2B5
 UNf9h7QRi7YemA90HMs/fyS9z/PnarbqpKNOEkY7lMSYsOOB8vwY1OcEWGc3TrI0luHG
 vBYA==
X-Gm-Message-State: AA+aEWbcgUzaYZKie81jZSrK3fDMd9p/lUgFiS1MNQDuFaAOlx0rUqLL
 1TW9lr22MMMji2VxbSooD0Cj3/JwGOqIAxjCXsIM/A==
X-Google-Smtp-Source: AFSGD/VMxlnynHDcgddMHSgAu03/Cd1+KIKURAd0rFVU1Y3szXI6GGD6ux+8IWROlLQmzNyYeDwk3AEi4FmICYifPAI=
X-Received: by 2002:a02:183:: with SMTP id 3mr2184693jak.130.1543870599417;
 Mon, 03 Dec 2018 12:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
 <CAGXu5jKfRDZJcWpAb2bqziMLXifcrSeCG+X06P=gg5o0WqKTxw@mail.gmail.com>
In-Reply-To: <CAGXu5jKfRDZJcWpAb2bqziMLXifcrSeCG+X06P=gg5o0WqKTxw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 21:56:26 +0100
Message-ID: <CAKv+Gu_BgGYC3pgTx66g8He6kWUx8sz6rLmupvXNXhDasP79Rw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: enable per-task stack canaries
To: Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_125650_500510_0A7AAE4A 
X-CRM114-Status: GOOD (  17.19  )
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

On Mon, 3 Dec 2018 at 21:54, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Dec 3, 2018 at 9:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > This enables the use of per-task stack canary values if GCC has
> > support for emitting the stack canary reference relative to the
> > value of sp_el0, which holds the task struct pointer in the arm64
> > kernel.
>
> Yay!
>
> (Should we include the gcc plugin version of this too, since it may be
> a while before gcc with this support is available widely?)
>
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > Note that the cc-option invocation below relies on the fact that Ramana's
> > current implementation of the GCC support permits -mstack-protector-guard=sysreg
> > to appear without defining the register name or offset.
> >
> > The $(eval) extends KBUILD_CFLAGS at the moment the make rule is applied,
> > which means asm-offsets.o (which we rely on for the offset value) is built
> > without the arguments, and everything built afterwards has the options set.
>
> Can we detect this from Kconfig instead and then remove the flag for
> the asm-offsets.o build step?
>

We need to know offsetof(struct task_struct, stack_canary) at Kconfig
time, which could be affected by struct randomization as well, I
suppose. So it is not clear to me how we could ever drop this step.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
