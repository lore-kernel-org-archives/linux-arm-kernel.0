Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4838DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0161D20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qUbwV5h9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FGqPIK9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0161D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yp0yWZ9I3L7TMlNqpQ5F4imIaynP6jrUEGkgptDifN8=; b=qUbwV5h966iCJi
	a5CjN7C5Mf/9C4L3yknZSI00PCsxA4zpZaq1GgOoDJpYFnpwSfGRKW7ya5SxM8cCkN452Bv0Zq0S1
	KcAQc5/oxBZUTqhXg1WZ6+VeLo8WBHa1cxPJzOkKhHHPyvSgf7X0H4Zs84txa3adLh/AqdkiqEQ0Z
	oOjYcf88spuFePZizQiRfeWnj17yuj+gillIsjvjn0sKMo7e2qpxFxrhCqhejAcWnrMs+h373mngt
	n89DBETD+KsLYLdvCTfUxBOH4TRxzyqbfRrqOkyVZZaArmshu51du/eXt2M6Xx2kwc2AY8dEQNF4P
	9NH/wYBne3FE+0AcZhWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVsv-0001ZF-P5; Thu, 29 Nov 2018 23:38:17 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVso-0001Ry-6y; Thu, 29 Nov 2018 23:38:12 +0000
Received: by mail-ot1-x342.google.com with SMTP id t5so3520332otk.1;
 Thu, 29 Nov 2018 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eQrn+Srwf0zuHQUeLfDQuJmZiLKRQB0d3wk46MwrBnM=;
 b=FGqPIK9U655mw3w98R+fkmqgdVm92JZ3Cngf0mpMXhzOr5nFwhgG3ldP0z7Rzcu6KV
 xtsJa/A0AsM5XjRg9S5hA9naAVqqx+d2wm12LJPRE3QoDNui4eYPZ0k+c1Jqm80wrgHH
 yxQi8lH3o2v3e8/lgVHt83nNJavX9XVHRr+hqQMwRcz01SuRVwcMpf0vxRve8N8iiMS/
 XFpsZ6WWJBuyEMaUeAu8hdSjjxh+bsNA+iI9H81vne8LYhT4OqMMk5FECZ6sR2Fg4GcV
 3/hOg5vJBRnRIU1FtBV04bT2BpEQWh+cdfCasSv0icmDHxJiihXqvG1R97UOo/k3tVhO
 fJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eQrn+Srwf0zuHQUeLfDQuJmZiLKRQB0d3wk46MwrBnM=;
 b=AbSJfSsYA3XIJ6JBXRVsirgDjZQIZrkDSqRIDJX4EAaV6/dHugFxHTQ76tbyXPUtzG
 ywY8+N8JvGpW9OoXHW06xwjf5ZIDbNZhcTjNb7scga4OIpp7dP2JaturD7AEmRXW+xFw
 83qVBf/IDnsywvdz0FT8mNwm4XQbGrPU1jItIVa9KF5X5nKgxt7ImfdANusEl8zTfHh9
 +2uRSgwIa1OF0jN5pPcLGOX/YE5BhvDK7UcpZDyPTp/x/bmw4wDDaVFzI0XyYTGdCL/R
 2cwwwxtB9YDLD+uXA5kwUWAOfu18233+TLBFVPq/YXjnM5zYOe6PdqkFd0diE8NPXUAc
 hXvQ==
X-Gm-Message-State: AA+aEWb/fK9VIb2bKd5lR2REnnKTd+kYqe1W08/13nHMHwGlXKaTSivW
 dqDSOjphqcBwUqKKVubknwJUGekZJYp7aUqxMiU=
X-Google-Smtp-Source: AFSGD/VZCGMLGl5XAzDB0sU26vZ7NWPkmJVYRT9VDcH0VRYOUcH7uy2vxfgzXJFjh2GgTJP8qxpGUB6Obnq+PyWTTv4=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr2238865otg.308.1543534679125;
 Thu, 29 Nov 2018 15:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
 <7hh8g0d8tg.fsf@baylibre.com>
 <CAFBinCBViZgRrZO16FsRKSGNriSw2_D9+_6ri99_zf++_SuuKg@mail.gmail.com>
 <7hk1kv79at.fsf@baylibre.com>
In-Reply-To: <7hk1kv79at.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 30 Nov 2018 00:37:48 +0100
Message-ID: <CAFBinCB8r+5tGKxfsPMapayxmDuWOi=WihvvdxS=UxcnpeYqdQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to
 built-in
To: khilman@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_153810_337149_020F8A07 
X-CRM114-Status: GOOD (  21.64  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Fri, Nov 30, 2018 at 12:28 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Hi Kevin,
> >
> > On Thu, Nov 29, 2018 at 1:30 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >>
> >> > Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
> >> > voltage supply of the CPU cores (this regulator is typically called
> >> > "VCCK").
> >> > Now that we are preparing support for CPU frequency scaling on Meson8,
> >> > Meson8b and Meson8m2 we should build the pwm-meson driver into the
> >> > kernel so we can configure the CPU voltage early in the boot process.
> >>
> >> Can you explain a little more why the configuration of CPU voltage
> >> cannot wait a bit so this could be properly probed?
> >
> > I was under the impression that cpufreq-dt would still initialize even
> > if the regulator is not ready yet. however (after reading the code
> > again) this is clearly NOT the case.
>
> Hmm, a quick look at cpufreq-dt suggests that it should -EPROBE_DEFER if
> the regulator isn't ready yet.  Why doesn't that work?
sorry for not being clear:
I was under the impression that cpufreq-dt wouldn't handle -EPROBE_DEFER.
I'm not sure why I assumed that. As you already said: deferred probing
of the regulator works fine.

> > there's still a benefit with this change: your Odroid-C1 in your
> > KernelCI lab would also be able to change the CPU frequency (so in
> > case something breaks we could spot it there).
> > will you accept this patch after I updated the description to mention
> > that it's for KernelCI test coverage?
>
> Possibly, but I'd still rather see the dependencies worked out correctly
> so that this can be module, and cpufreq-dt would defer until it's ready.
KernelCI shows multiple "pwm-regulator regulator-vcck: Failed to get
PWM: -517" messages on Odroid-C1.
however, what I failed to notice so far is that there's a
"pwm-regulator: supplied by regulator-dummy" at the end of the boot
process. does this mean that the Odroid-C1 in your KernelCI lab can
load kernel modules? in that case this patch can be ignored.

(I will still send a PWM regulator related patch: that "Failed to get
PWM: -517" message is very noisy and we typically suppress that in
other drivers)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
