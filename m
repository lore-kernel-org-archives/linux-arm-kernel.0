Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63415208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T7Rza0Hv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="edYGbBxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63415208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9aa3gZ21CAEmA4Lt/1R+UgNjqnshzeKGWytfrVzkQUg=; b=T7Rza0Hv/3SmXq
	VvLVmDSOcBFGXvfn/uLYEm5b6d7vjt4zfdXkDF3k9A78kG+pDXi7lwKifpM1wpiE4onG1hbXmUyAH
	j67zwjschPosKLD6tx7skRJjCSzdKoVV3osjEBJuPY2DxvklQTDR4iC70ontdfCbx5s8XrUy6Jtwn
	sDYj7n2Ee7wHOMpM7nJN3Y+1GEyg45XhaMfZwIILFhauZiyUp6tgixpslHK1grd03ok8sTmx7LAUf
	sTOEFp1fVqqwLQGZBYsd2SOXiCMqqvndXB2b+13vb+xd66YqEf8u7i570siAjW5P+0RRfqfVM+xUI
	Cq6TbnVjRCaXsNcmgB4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf98c-0003Di-JR; Thu, 03 Jan 2019 19:58:42 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf98Y-0003DJ-Qz
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:58:40 +0000
Received: by mail-ed1-x541.google.com with SMTP id h50so30015185ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mcaOkKaskc6pwuQXJbemK24OWy2Us/5/O+TjG5KW5ms=;
 b=edYGbBxI+LMizHUYdh8fZKynCLVGzV1OSF+8jWzxiXXjFj71lRYLBHOc00m9+XJuCO
 HQFg1gYrklQauyIxTab68Q1Fp06Y721LjkckUusjXgCPeHJv9vj2N//s5xk355QENyB2
 fZC9lzfLX32K4g+kMGIl06WOSj4fTFW+ezgPfQG10eEk6Cj9ybeM4lfcb10X8/PmVclj
 R9X1QDBtTYLUwZnpKtHOmGEd9JZUSM4CC/tlQ63lxHcGlA2e+aBOhTK/hOGD+ZQd7Ox+
 zSg/Ag8tN47GT3TS4JV4rxDj3HfuWl3Vzv1s6oLHejdaavRrHRumYVYBNViRnIin1s/u
 nBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mcaOkKaskc6pwuQXJbemK24OWy2Us/5/O+TjG5KW5ms=;
 b=TKddh9ZWOoNoGCzBqFxqRtobObcl2xgufY/aPSfFvpu+OHIk+qfZUIfT06DWT5WeGc
 8HwE8Fezc9ecc+mGEcRPUOesFhzMiXFtOQkGW5q1YPQAlD9WYX3+f4KogGx5v8VyYtrN
 ZuxlZR6dMiVWcqOMW0tN5tW0d8XDMN8naa9O6MtkhA39d8Q3adbb57SGdvlvcbdm1czT
 7k+Xmq84nG0Dz6zLKYDmcc+fRo3lIkNmbAZHLB8imFzPjY/6IsIWXy9Q60zXvs3vQXy6
 nkHmzyRf5ThEGNiOTIJn0Liu0fQo42vFyhkMZFDQFiSJIDlpUQN3y8GpSC12h2EWxAe1
 +MAg==
X-Gm-Message-State: AA+aEWZERIxXaJdrnsjDDtHi6HuCc6/GlJaqBC8wVB49x+7eldLZGjYe
 DlATFsSMkmPRvnVgJlIXmn43Yf37JljxiYcWS9WwDg==
X-Google-Smtp-Source: AFSGD/UjNghA7YS+jJdakehZdTH9Y+Xlm+kl+Y5hKRMZ9S43IPNy6YGYTOt0AqNUP5ryWeSqY9EWtgeqVaj+n0ILux8=
X-Received: by 2002:a50:9a42:: with SMTP id o60mr44986597edb.180.1546545516064; 
 Thu, 03 Jan 2019 11:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com>
 <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
In-Reply-To: <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 3 Jan 2019 14:58:25 -0500
Message-ID: <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_115839_293970_04412BA2 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: Michal Hocko <mhocko@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 sboyd@kernel.org, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, rppt@linux.vnet.ibm.com,
 james.morse@arm.com, andrew.murray@arm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> I still think this approach is flawed. You provide the kernel with a
> potentially broken sched_clock that may jump back and forth until the
> workaround kicks in. Nobody expects this.
>
> Instead, I'd suggest you allow for a something other than local_clock()
> to be used for the time stamping until a properly working sched_clock
> gets registered.
>
> This way, you'll only impact the timestamps when running on a broken system.

I think, given that on other platforms sched_clock() is already used
early, it is not a good idea to invent a different clock just for time
stamps.

We could limit arm64 approach only for chips where cntvct_el0 is
working: i.e. frequency is known, and the clock is stable, meaning
cannot go backward. Perhaps we would start early clock a little later,
but at least it will be available for the sane chips. The only
question, where during boot time this is known.

Another approach is to modify sched_clock() in
kernel/time/sched_clock.c to never return backward value during boot.

1. Rename  current implementation of sched_clock() to sched_clock_raw()
2. New sched_clock() would look like this:

u64 sched_clock(void)
{
   if (static_branch(early_unstable_clock))
      return sched_clock_unstable();
   else
      return sched_clock_raw();
}

3. sched_clock_unstable() would look like this:

u64 sched_clock_unstable(void)
{
again:
  static u64 old_clock;
  u64 new_clock = sched_clock_raw();
  static u64 old_clock_read =   READ_ONCE(old_clock);
  /* It is ok if time does not progress, but don't allow to go backward */
  if (new_clock < old_clock_read)
    return old_clock_read;
   /* update the old_clock value */
   if (cmpxchg64(&old_clock, old_clock_read, new_clock) != old_clock_read)
      goto again;
   return new_clock;
}

Pasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
