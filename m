Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A190C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFD72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SinrqhLU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AoxSd5vy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gv7sAfQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFD72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uek6qWmuVBfszZJDwyR9ledacahN7hQcDfoPj9ZP9wc=; b=SinrqhLU/jtVIo
	0p+YD3Jz1VGWXgExk1Gy+pZODDHkQxJXJHDn85uJXxapAHA32O8VB3TW1qukNagjTZ9iSo+mi4VBU
	gUZz5DnvKhq29pkSd9svWST9f9VKYMwiKQwhqWWv6I/hmkSaFz6vQYdPIOzDt7INUQmXi+PQkD+5z
	494phwMvaXgOvTPMjzvcdR5WeJdIXnr2e9O/8ohT2I5Q8+fOWgISgHXc2+ACu4rrlcarXoNYnwo1J
	9PTiCvVPcJKV12TA6WdFQEvToSBz6mwZ2/YxZBdJjOEJ/olzt5Wg99DHN0LIo6dlKGR7qeCoY8uFD
	IUDgJcHjdODReHDqPU4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt3g-0006SM-6a; Mon, 03 Dec 2018 18:35:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt2E-0004zp-2C
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dvjK7K6E4lkyY8U/ePGWSco68F2gwbHCWAXN7u7wuZ0=; b=AoxSd5vyYl5vefXtxYw0fdy6E
 IrQVNGaBq6HIKx5jrsfvCfNCYHyVRBWsZmYgRhExiQCOmRPdpu9DBxD+FhNMElD0x+TDcW9xAo1KJ
 JlkhsPlOM048gB7T+WCTpCbrfcucDhABuBn7B5rCj/hXlbCzKXmLEC6H+TyzvOiGkRZdh0Ijg/aD/
 PncJ+sx2iNOPt7H4LrHKGOw1XmB4DKx4ZI7eOA7dj2+u8Asq7uuV1p9yUD6qMJSmUhomAoHsDViyx
 m8yRcdlC20nQ7Yl6/5hhA9+2J/QfEKXC1AnJi+sBGo6eyxixRTtmRZo+9S6waXIe6ZrjhEi2/oHLP
 SpC/YOuKA==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt2A-0002OL-Vz
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:33:32 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so6817690pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dvjK7K6E4lkyY8U/ePGWSco68F2gwbHCWAXN7u7wuZ0=;
 b=gv7sAfQFsccP/RIiqqygcebOVgBpL9ylbFOPf9oACU+0HELSf5+xo2/qNdYXZfGoue
 msNEQZUoH8FDsXkIjZYJJz2kfr9lqWQ19sOSHvMYF1JKtGrqDA+kthRoYih9aE7RwJqt
 gm83KQaxf6mCCoS61Ca0xUNoO/+AXPQcx7KVY36FoAeGGAFhCVsCSRtm2BF/JKNJsgBf
 PalMrJYcVrv/61lKgdoMUVGw09Qyc/wgbLenUcGBQBRqTDU5ZSGMz6j9z83Jse9zMKYk
 DWcOJClSE3r7AwHfwS+dI/kcSSDtD+eNW6BS9+tyM5Gd5bBwe6BkV8agKwrIG1D2IoBP
 l/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dvjK7K6E4lkyY8U/ePGWSco68F2gwbHCWAXN7u7wuZ0=;
 b=BM1HRbG/t1qP0tvsfXW9xxQBhgdw1O6RqV8BtYaf1pAn72Z3oNxjJjl19jnQ48o2ej
 FJgHdFuqK80rXyE9aWOXfsC0MQ/TC31jkW0dIVvX4wGjmrforGHf6zLJPGFkSfFiztbq
 82wTPj+1B6eC1GnOU4uOrH22D7gept/PN13bCLl5N//67aL0UlEkEbGDZxFk1SGbYAxi
 7HS/ikxsnATBNIKZ1gmtN5vSCF7cWWnb5K+oxecBx/crxtzeTV9ZmGnT91VH2CZvi2y3
 2exHZQIXZ8giLBOsYILkv4y8XgcdaSf8joAk+Cs0yUzqv1xDdgqk+jnnnDFDwCrKM1Ve
 D1bg==
X-Gm-Message-State: AA+aEWbLVDybXDccjNjPSTZlvi0xxbgS4tbcJteDT/JUlH4B/Fh4BFae
 LaVZgZrYcbDdsnVmhQ/ew1uEJN2PV+ZBuAKL/3FolA==
X-Google-Smtp-Source: AFSGD/VAy3/+vVperXglWyl3KCyAzVE+LOvQduM/6XsymC4lMe1CmgW2gEacRNOsZ096vLLRcJEuWpwSJVbRG+9ct4I=
X-Received: by 2002:a63:a064:: with SMTP id u36mr13106303pgn.145.1543861998074; 
 Mon, 03 Dec 2018 10:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20181201135734.10060-1-ard.biesheuvel@linaro.org>
 <20181203165852.GD27796@arm.com>
In-Reply-To: <20181203165852.GD27796@arm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Dec 2018 10:33:06 -0800
Message-ID: <CAKwvOd=mDNKhWxS8RtX5oTh0fmorfTayiD3+dGyPU5NOcROSuA@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: add support for building the KASLR kernel with
 LLVM lld
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_183331_038134_CCAB83E0 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, peter.smith@linaro.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 8:58 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Sat, Dec 01, 2018 at 02:57:34PM +0100, Ard Biesheuvel wrote:
> > Work around some differences in the behavior of ld.lld as compared
> > to lb.bfd:
> > - pass the -z notext and -z norelro options to convince the linker to
> >   permit text relocations, and relro sections that are non-adjacent
> >   (both of which are irrelevant for bare metal executables such as the
> >   kernel)
> > - move the definition of some __efistub_ decorated section markers to
> >   the linker script, which permits us to assign them as relative
> >   quantities (since using an intermediate assignment loses the section
> >   relative property when using ld.lld)
>
> I'd prefer not to work around a linker bug in today's lld just for KASLR
> if it's anything more than passing a funny set of linker options.

Filed https://bugs.llvm.org/show_bug.cgi?id=39857 to follow up. Peter
has narrowed down a straightforward reproducer.

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
