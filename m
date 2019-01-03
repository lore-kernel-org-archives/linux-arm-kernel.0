Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE32821479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SfVuockJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CupanXzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE32821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eHXAdDf9zDhTBfQOsJO5mWc09h8QCM8cnlH6Sjo3MdI=; b=SfVuockJBoRsWD
	Wy7+wuU+5jNgEc+m2m62LCaxCVMzCrcIPBy78klozbKWev6Fz9csy4QtO1moB/jVsuW64EbRJEQSG
	sHFxpyWeHV8Xse8Fe8Kq73HpevB82R8xYTc/7IC4XBo2K/vXzMW+hUwtS1Rul1KK54qPUt/5rvx/q
	C35RpGbCA5dZpcXtW3uM8tt0gzLmxf3QrJQK3vaN8yrqaHz92fIpioPrZBp63+GmZ2ltHc+ZJ4JtS
	BsOFrYwVbZIz5EjvJpNw6/ldXfFSOhl4fyCih827FEtp9FY8DzJsOr/yfLIOg1qLdWRpjXd38Ww69
	5BSQNDO1OTjdcdzwpbSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfAP3-0008VJ-0i; Thu, 03 Jan 2019 21:19:45 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAOs-0008Ju-IH
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:19:39 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so16432467plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=xVgIvqBLxtUuAr9V9fm1GjndM8iSA6uw8jisBjx+3Xs=;
 b=CupanXzSWpE4ukFfspPLI3CpraEG49S19t0LLFt9FzRVAfMl5J39695HowN9GUEFUg
 F/UGn8Xh/My+MN3jfWTdEXwO/qvoE8Ykym5jUxXwBcSgNX+FgWjwMdYh1IMVlrtki4OJ
 mQggz5QSZ8/ogZdmiONlRX55mDx9hMBfK4780=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=xVgIvqBLxtUuAr9V9fm1GjndM8iSA6uw8jisBjx+3Xs=;
 b=eDps9imzth9VepDF/jj/M2t2RaRrc93JD0MCKfrZ1kluhC+1zaHS2d8EI2UBsk4GR8
 e8STDFNkPZziU7wVD1CGCoXB3ZmRfjqmCmPCFo6c15h62MKbW6wFwvOLXnz2VLX4oMP1
 89ZKfXvCyZy2M/XxAmRbnMzaYRHGzn069h/lhamGkipfGiAvrlFIdgCDRZ8yUI6fRxqq
 kPW0U//4HeTCjpItRi+YSErLSggK3+rMkTIGauLd6LOsrrP7XyCWjY/efVN2u7ZZx+Hj
 jeCMHFHolfi+FDf1vMfbGJGbOYY4EAoSl1akXnj2Prr9qMDHdA9HhtRKqiaOcodD6Jy4
 pxWA==
X-Gm-Message-State: AJcUukf8gP7/yRChv/eZvrmqOKd4fOrxA615ILcyygDFDsPNoqt0dLoS
 aGBNYIV6d4rX2VoLpxVW60zTxg==
X-Google-Smtp-Source: ALg8bN6RGw4l6+1tWm+FCG6pwfZEjT3ISR0sX05GZnK7OtvMDF3LqufijEwvyc9VPL8x6L6/5BskCQ==
X-Received: by 2002:a17:902:a83:: with SMTP id
 3mr45750604plp.276.1546550373863; 
 Thu, 03 Jan 2019 13:19:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id g26sm73563691pfh.61.2019.01.03.13.19.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 13:19:33 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
In-Reply-To: <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
Message-ID: <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 13:19:32 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_131934_942289_334CE066 
X-CRM114-Status: GOOD (  31.10  )
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
Cc: devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org,
 dianders@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org,
 mka@chromium.org, ilina@codeaurora.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Raju P L S S S N (2019-01-03 04:22:58)
> 
> On 12/29/2018 3:08 AM, Stephen Boyd wrote:
> > Quoting Raju P L S S S N (2018-12-26 01:44:43)
> >>
> >> There are two RSC devices in SoC one for application processor subsystem
> >> & other display subsystem. Both RSC contain registers for PDC timers
> >> (one for each subsystem).
> > 
> > When is the timer programmed on the display subsystem's RSC? It's hard
> > to give advice without all the information.
> 
> For display subsystem RSC, hardware sleep solver takes care of timer 
> programming for wakeup when the subsystem goes to Power collapse.

So the display subsystem doesn't need to program their PDC in their RSC
from software?

> > 
> > I would think that it would make sense for the application processor's
> > RSC timer to be programmed from the broadcast timer mechanism in the
> > kernel so that timers during idle work and suspend turns off the timer
> > appropriately with a shutdown hook. I guess the PDC can't tell you the
> > time though? It looks like a shadow (and limited) version of the ARM
> > architected MMIO timer that we already program for the broadcast timer
> > mechanism. Is that because even the MMIO timer can't wakeup the system
> > in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
> > always be used as the system wide broadcast mechanism because we need to
> > augment it with the PDC timer to get the actual wakeup.
> > 
> 
> Yes. this is correct.
> 
> > Maybe we should be adding hooks into the broadcast timer mechanism to
> > program this wakeup event hardware in addition to the ARM MMIO timer. Or
> > we should stop using the ARM MMIO timer on these systems and read the
> > system register based physical time in the RSC timer driver and register
> > this 64-bit PDC register as the broadcast timer. So the time reading
> > would be through sysreg and the wakeup programming would be done by
> > writing the PDC timer. The assumption would be that we have access to
> > the physical time registers (which sounds like the assumption we have to
> > make).
> 
> There are no physical timer registers available in RSC for this purpose.
> 
> > 
> > Do we get an interrupt somewhere from the RSC hardware when the timer
> > fires? Or does that just cause a system wakeup event without any pending
> > irq and then another irq (like the ARM architected timer) just happens
> > to be pending around the same time? If we get an interrupt somehow then
> > I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
> > timer approach.
> 
> There is no interrupt for PDC timeout. It just causes system wakeup 
> without a pending irq. ARM MMIO is necessary for irq.

Does that system wakeup cause the CPUs to be enabled? So the sysreg
based timer in the CPU would start working? Or does it only make the
system come out of a deep enough idle state to make an always on domain
work that only contains the MMIO based ARM architected timer?

I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
we can use the sysreg based timers and ignore the MMIO based timers
here. This isn't a very important distinction to make though, so if you
have to use the MMIO timers then it just means some extra DT things need
to be done to relate the MMIO timers with the RSC that has the timer
that needs to be programmed too.

Either way we would need a way to either hook the ARM architected timer
driver in the kernel, or reimplement the bit of code needed to implement
the clockevent based on the ARM architected timer that programs the ARM
timer and the PDC timer together.

> 
> > 
> > How the RSC is used in general by other devices, like display, is not
> > clear to me. We don't have a "wakeup event" framework in the kernel that
> > device drivers like the display driver can grab a reference to and
> > program some system wide wakeup for. That sounds like something new that
> > could be handled entirely in the display driver with direct register
> > writes, or it could be some qcom specific API/framework that eventually
> > calls down into the same RSC driver that knows what offsets to write
> > into in the display RSC's register space, or it could be an entirely
> > generic framework like clk or regulator frameworks that could be used by
> > anything. BTW, are we using the display RSC yet?
> > 
> 
> Only display subsystem RSC is programmed along with CPU RSC in Linux. 
> display RSC instance is not present in upstream but it is present in 
> downstream and used for resource communication purpose only.

From the comment above it sounds like the display RSC handles the wakeup
programming in hardware? So there isn't a need to add a 'wakeup event'
framework or anything like that. Please correct me if I'm wrong.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
