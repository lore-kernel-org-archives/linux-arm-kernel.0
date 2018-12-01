Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C827C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:25:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7C520834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIvmRRrG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PPfR41lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7C520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MNJVO+R73/2NarJtcwuJVBNeu+2lAFXLpcc2akgkq5g=; b=YIvmRRrGoH033V
	Qir3KO10GeifSzTG4IS3Y9eAiyM+rAes35s26K93bz58Ez5AsOQzt/m+ZIG890JzvqRpDSk+TjpO6
	hXLaL82jllSbtSzaB2h79KEaJzdaNhnGbgRR1r62+1HkQ5xBASaAOapm9RgTMrT23h/6D9K+U0jc6
	Rz8n7hkM7e3oafBnbBdtdpaj3c9A56RhuBtofnTRZX6vTh1IQfgq5GBSkVHhDNM7Qg6i95tLO13hH
	8FosDWMnHR2IWzM1QRIKRWXgIzmNn0PZRZmuUEk4uIXtrzU4i2okw9UXmZt02iA20YtB8RGEgexyy
	i1Yx8O1KbDu55di3di4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSt5l-0000H7-Rw; Sat, 01 Dec 2018 00:25:05 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSt5i-0008I0-JW
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:25:04 +0000
Received: by mail-pl1-x641.google.com with SMTP id k8so3554445pls.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ARodUjDQIAu1n8gb1ZRTXEIs0TaLCuLUFVpSRJ1eGI=;
 b=PPfR41lGMAp60tBskpllfE+t7J5LKRkjAPgnNPqGucgvXxJDOlJmQG3vqC7E4Jbkvu
 zjwYCaV7K5Ebor7a3Y2MnylrZwHPGy2LbMpxSKTH7eUGvBOpgxpGPywgkZLCf9PrSybc
 UH7AW+EQC4oT0URHFovWkIOPiG5OJaD0SDm+/MwLr58i1ufK7aUEVyyRlZt53tGp5PQB
 0XWBTpp1r0T61nLHagf7GU2J5LYmpTtNw5z+OdWVchfzEIcENJ0YdGjcmGJcQO140lRQ
 7yMhyqnP0jETYgXSLS71aPVI20pJ1dSSnAESCjtNzsWS3CNRNAh0NyDtlYRXIBaxyN8P
 XY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ARodUjDQIAu1n8gb1ZRTXEIs0TaLCuLUFVpSRJ1eGI=;
 b=YGAhScc4gmqkwg9oBGdholSHZyRBJVIyM267Zw94e0uoePYg5u9ne+zwDslAtr8kVg
 rFJcEb0JOFKqjVIuRJHaPfS77dYQyV2gXqtDxvpUM3fpOLE2iVTzs69muZmBhIj0xmyp
 NJ3Vauoo8/UKuci/CEOClNXsKCYopNjAT1LeP0Dv+4OHM1PuhV35fCq7RFeGE4j6lmtO
 XPh63K59mPEzoBovClpQAMS6B5MR+gzhebiWK4IBzr/jNBr8bzkjh3zcSdvFa85WbVXk
 3Ij9cR8lQycT7Y7Z3zDAz4Ux6AeCn7oZKbtfEeS0/q4DssUv/ZBsZxuM/K/qTAaTgH1n
 SzsQ==
X-Gm-Message-State: AA+aEWbWaDgIC6i0mQg3t8naFUJ9YIFIVA3wSn4sr6PVlZgiR+A22Vz2
 nun5tDsSPOtCI03QgXMByTpLAspu8Mo4sCFPTaFIU/WT8oy0qA==
X-Google-Smtp-Source: AFSGD/UQgsPB+hiAmZJkdZ1wuAFvlvIea00kgT9rP/rsyGCPvyvxEuwqBY4AEojXt+2PsN1TekLN8TN0TlRAVvftKkY=
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr7556799plb.238.1543623891523; 
 Fri, 30 Nov 2018 16:24:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOd=uhn-PUs==kVGnXg4W6UwuGvSn+EWUzK4Q8wMr9mzFpA@mail.gmail.com>
 <CAKv+Gu9OJ_N+mhdUbZ89kQT=-coqmAEWihVziWTQ3uFDOw1zzQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9OJ_N+mhdUbZ89kQT=-coqmAEWihVziWTQ3uFDOw1zzQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 30 Nov 2018 16:24:40 -0800
Message-ID: <CAKwvOdk8a=x945wNecxmoO+kPSmfbAi7Qa8U1RE0RN51eCX2MQ@mail.gmail.com>
Subject: Re: LLD and CONFIG_RELOCATABLE
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_162502_707285_EEE441E0 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 2:18 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 29 Nov 2018 at 21:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Hi Ard,
> > I'm hitting a few different issues trying to link
> > CONFIG_RANDOMIZE_BASE=y (KASLR, selects CONFIG_RELOCATABLE) arm64
> > kernels with LLD (LLVM's linker).  I've filed a bug:
> > https://bugs.llvm.org/show_bug.cgi?id=39810, and am getting feedback
> > from various LLVM folks, but thought you might be able to provide more
> > insights?
> >
>
> The -pie -shared thing can be dropped, I suppose, given that it only
> affects debugging of KASLR kernels, and since the patch in question
> clearly shows that ld.bfd also changed from ET_DYN to ET_EXEC for PIE
> targets, and so it is obviously a gdb issue. So I'll ack a patch that
> reverts that.

Thanks! By https://bugs.llvm.org/show_bug.cgi?id=39810#c15, it seems
that -pie can be dropped.  I'll queue that up for a set of patches for
linking arm64 with CONFIG_RELOCATABLE=y and lld once I have it all
working.  I've added your suggested by to that patch, but will wait to
send a series once we've worked through the 3-4 issues.

> As for the __efistub_ prefixes, I wonder if we still need that after
> 1212f7a16af492d59304ba3abccbcc5b5e41423e ("scripts/kallsyms: filter
> arm64's __efistub_ symbols")

Thanks for the patch in:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/616512.html

This will simplify things (and uncovered another bug in lld).

> So i think discarding sections intended for the loader is the only
> remaining issue, and that is something the LLD people will hopefully
> fix?

The lld devs and I think so.  Thanks for your help, I appreciate it!
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
