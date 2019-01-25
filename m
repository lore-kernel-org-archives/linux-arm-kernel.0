Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E8C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4A7218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="maIpvFVg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWzK5ySp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4A7218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTV9rKqkU9ojzqxWK9wbqg7OUcsuJd1gOtrNbjomlB4=; b=maIpvFVgLUMP/Y
	iFigEmTdDcOpwUYrfbOAQJ6tUv8I2Q7nTNBYdwIYMAzCHE1HRQgeTNNRx28Y64FnTXMyku2PAn2dY
	XVcPwWhUeT7T2ezsw0P+OyeMlAnQ4OijHcnHiYF3x2i12L6T/gWd/dFi5rkhS9S0Ktss5lrIxu820
	W7u7TpXIBhAT8Q5lDdQ5aynrwRnzZ02tMtDsR1ahOcQlKnDTFSZOn1wQFigD0tsJOazLVb0u0Bg54
	5vRPKR4ajIwjic8wf5NsLNyLFwNFWfvnjtsMvlTUd+wAM7tKNCuVC8DgF8sBC+AfuwTfoSPefAhsG
	+jgitTOuFauRCi8nWoBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5Cp-000851-9s; Fri, 25 Jan 2019 17:23:51 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5Cl-00084Y-VL
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:23:49 +0000
Received: by mail-wm1-x32b.google.com with SMTP id a62so7523784wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dCxzJV/7/vhu6LFecxpy/4ttxgmBiWtOwJ3/U1G05ok=;
 b=WWzK5ySpsWIKJadTFttaTp24ZXjapUxz1BP56tKo1gM7DP7KB1zRK2FvTbL+CEVzZT
 gHObqgUkVHYl5qciGJYEaoqw4DayFx0EdHT7c4dIfxzUI1i62QAF8hHDZeFn7PbUlJSM
 HXceloy6gXpmzxhZ1zG8us/kGXUcW/w+c6fuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCxzJV/7/vhu6LFecxpy/4ttxgmBiWtOwJ3/U1G05ok=;
 b=lPmCwY68TtpdGtgTC5+uRcSt7YNaFcD3knkkZRPm5/TxAUhbZuIOIfZ6UniZTX5N+A
 H41WrqVyjZQhGt6hejMeggqmQWKscGPpcfMfBxyFzJJ0KkSNyMEW2M/tQiAtko+Ph/8O
 hISrm2jVhJZouiYaCRHbncRGepJoL37jf3RA+W8vnYRRuRbLWyuPtWiqvGAH7vT6l7TF
 rgdOy3yA5EN1Ysw+BqCrsZvo57drfXLsmz6APeqdEOb8YDhZwswT28LPcJFE4JIC/mQa
 VnV2yf+DB9fCyAUF/xa0Ejb7NtzQFG3U5fCUiH+2Or6AruYmkB3ROXxhKFKOK/baWJtC
 Cvag==
X-Gm-Message-State: AJcUukcmeLz+r3TXg/SGB9qlrrFyTQvi9a0GvUPAZJpUFAd3zY9FA5Qs
 4tEe37iIbB3fVZS9yjXytxg9kvtAAMpuF+goPoLDRgUCYL/3Xw==
X-Google-Smtp-Source: ALg8bN5VtfbB6x7F7grXrDN9qJsftykyxjzgRU7O4ADw4sR6henxY12Ueka6kGUm7521TUhQYOUU2rZB/5XmAw+1vqc=
X-Received: by 2002:a1c:4683:: with SMTP id t125mr8021717wma.9.1548437025186; 
 Fri, 25 Jan 2019 09:23:45 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLX0P6P4xnv=HgQsP-Cv4dkGJhkkMRn7jy-sbzZKUa1z4w@mail.gmail.com>
 <CAKv+Gu_OrO1Spx949j9LOUONJZvsnr_XsNxE1QkERTcFxdG0bA@mail.gmail.com>
 <86o9868j68.wl-marc.zyngier@arm.com>
In-Reply-To: <86o9868j68.wl-marc.zyngier@arm.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 25 Jan 2019 09:23:32 -0800
Message-ID: <CALAqxLV5SsFuW+ZSwi6R3YBg5jYWLUeh=NFcc-SxQYQoJX4wyg@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_092348_013826_18183637 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <Will.Deacon@arm.com>,
 Valentin Schneider <Valentin.Schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 2:05 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On Thu, 24 Jan 2019 08:10:53 +0000,
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 24 Jan 2019 at 06:36, John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > Trying to boot hikey960 with v5.0-rc3 (and Valentin's 2 recent lockdep
> > > fixes), with lock debugging enabled, I'm seeing the BUG below.
> > >
> > > Wanted to see if anyone else had seen this or had ideas at what was going on.
> > >
> > > thanks
> > > -john
> > >
> > > [    0.183376] Detected VIPT I-cache on CPU4
> > > [    0.183388] CPU features: SANITY CHECK: Unexpected variation in
> > > SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4:
> > > 0x00000000101122
> > > [    0.183399] CPU features: Unsupported CPU feature variation detected.
> >
> > This means that some CPUs support 16k pages and some don't. This is
> > hardly relevant if you are running with 4k pages, but as Suzuki
> > pointed out (IIRC), it could be relevant for KVM, since you cannot
> > migrate a VM using 16k pages from one CPU to the other.
>
> I think we now have some code to present sanitised ID registers to the
> guest. It won't prevent it from running though. I contend that life is
> too short for caring about these systems.
>
> >
> > Suzuki, has there been any progress since this last came up?
> >
> > The output below is from a separate issue, where it seems that we are
> > enabling a static key from atomic context, which apparently isn't
> > supported.
> >
> > Marc might know more about this.
>
> I thought that what Valentin's fix was addressing. Or was I mistaken?

This is something additional. I've already added Valentin's patches,
which  addresses the separate:
  WARNING: CPU: 4 PID: 0 at kernel/cpu.c:316 lockdep_assert_cpus_held+0x3c/0x48
splat.

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
