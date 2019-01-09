Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BCCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BBF20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fJUcJwsl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaOvwmvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BBF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5tHbW/kQr40p+EMuP4nZIEZLAuzcIeRHysaymZnE5hE=; b=fJUcJwslgCyQm3
	ryfY+8HWFZUmPGcUAvvkPF8wKE0ftICm1u2R/8gNlhDNYKc5AGRtixvOV9aum3eVebxRts72wPO+n
	jQAhN4X+PVANDktFZ2BnSOE/2JUmS5wV4WZ2aHB/PYVHP76LFx84zkN2jOcsSidlBnaXNc1O5Xbsg
	MsSYZNAyi+YqaPZxJLCxh2M6TvsTm8XOeTmbyGEOPYHCM/mW0yo6dYREthUNk7MGarIHcSxl2BnO7
	w1En+Yt6liHmKOJjJRpu3I38GtiVsLSH0eT//Gv99+2RRNtULQIcvZ9k3SdkjhN4CzqblgP8I5wO0
	aKqO70ZKe+hOB7zRwTjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHwI-000112-RW; Wed, 09 Jan 2019 17:46:50 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHwF-00010h-3L
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 17:46:48 +0000
Received: by mail-pf1-x443.google.com with SMTP id g62so3977383pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=qZGotQEuburxq/caVANwpowPOBrrJpBXItg5fTWcVUM=;
 b=BaOvwmvlpeNxfJl/gcNzBk0UdXwX4IT5BPd+/j4XyfXL3BOrCkbgG0hYvoItLxmvSS
 +svk8DUmqTS8hDeF6wOuUI3/DO3nwYRz1HgyXUKUHz82H3JwIACmunag8RBzom8YIRMP
 WfvHvO5qe3OIkMwJ2qiiUgf/IqmAzsE7b4GVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=qZGotQEuburxq/caVANwpowPOBrrJpBXItg5fTWcVUM=;
 b=L6Ss1gXF3SRoLu4QOB674e6mSmMc2e7thztMaTvMBT7bq7Alc0sZ1VntflkGOiz/3U
 DngEjVYNOO5pJJfaTYu8ofOW8BLEU2tIvsA04wLMEqJR/3oXxn6VpDBDP7LA3OGc3ZQ8
 cOfykPx+JLp2Jqd8+VwtbOVUN33JMxnPoNzmSoyNphbPYIUSLPp68RjQw5HSdlbTWQm6
 lVzSBwbLMYXbraamU4hLpl3dMUhwQTgup6nuRGYU5DPruz4z/tii14V/PvLw3DSUcVVk
 VAC9x3vmZq78CW3XNwBEw5hRLBvy55jj180fgnHWlC1UQQ+L4Dx2F7Bufy/+qmceM11a
 BMIg==
X-Gm-Message-State: AJcUukeh1iTsOhYQWhtjaQJ4Xwq8SLpIA/7uNm8NgvV5diwWJbQIpAgD
 XH23zroGIVadIHMK446qJE1e7DpbRve9hQ==
X-Google-Smtp-Source: ALg8bN5s5NPz/QOem5vtfETjDtU2kjVoF6MJpAiYyfZUjiRY4yDFaVsmQC5OhMKf4T06+gib54+SPg==
X-Received: by 2002:a62:5910:: with SMTP id n16mr6803283pfb.128.1547056006435; 
 Wed, 09 Jan 2019 09:46:46 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id d3sm93120756pgl.64.2019.01.09.09.46.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 09:46:45 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
In-Reply-To: <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
 <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
 <154655037205.15366.7302521016277534390@swboyd.mtv.corp.google.com>
 <6384bcac-634c-5e7e-b357-93982de6eafb@codeaurora.org>
 <93a4b632-5740-42a9-9552-b46dd599ad68@codeaurora.org>
Message-ID: <154705600478.15366.3563482093409250809@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 09:46:44 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_094647_171947_5DFE38AA 
X-CRM114-Status: GOOD (  26.12  )
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

Quoting Raju P L S S S N (2019-01-08 21:34:32)
> 
> 
> On 1/7/2019 9:47 PM, Raju P L S S S N wrote:
> > 
> > 
> > On 1/4/2019 2:49 AM, Stephen Boyd wrote:
> >>
> >> I'd hope that each RSC's PDC timer wakes up the owner of the RSC so that
> >> we can use the sysreg based timers and ignore the MMIO based timers
> >> here. This isn't a very important distinction to make though, so if you
> >> have to use the MMIO timers then it just means some extra DT things need
> >> to be done to relate the MMIO timers with the RSC that has the timer
> >> that needs to be programmed too.
> > 
> >>
> >> Either way we would need a way to either hook the ARM architected timer
> >> driver in the kernel, or reimplement the bit of code needed to implement
> >> the clockevent based on the ARM architected timer that programs the ARM
> >> timer and the PDC timer together.
> >>
> > 
> > Could you please provide some more details on the implementation?
> 
> Hi Stephen,
> 
> Regardless of implementation options about application processor 
> subsytem PDC timer, I think there is a need to differentiate the fact 
> that for application processor subsystem PDC timer programming is done 
> by SW but not for display processor subsystem as HW sleep solver takes 
> care of PDC timer during sleep entry/exit. How about having a dt 
> property like qcom,pdc-timer-mode = "solver"/"sw" ? The current patch 
> introduced client based model using regmap to achieve this 
> differentiation between these two subsystems. By using the dt property, 
> once rpmh-src driver instance for application subsystem can have PDC 
> timer programing implemented. Let me know if there is another way.
> 
> For implementation of PDC timer, I see the following based on above 
> discussion -
> 1. Take the existing cpu_pm_notify approach and move the current series 
> approach of programing PDC timer registers to RSC driver. This wouldn't 
> involve any changes in clock_event_framework/broadcast framework.
> 
> 2. Add api hooks (like reading the next wake up programmed) to ARM 
> architecture timer driver so that the value is copied to PDC timer using 
> the api with in RSC driver based on cpu_pm_notifications.
> 
> 3. Changes in clockevent to program both ARM mem timer & PDC timer 
> together. Could you please share some more details on this?
> 
> 
> Please let me know if the first approach is ok.
> 

The first approach requires that we expose internals of the clockevent
and broadcast timer information to drivers. From my perspective it looks
like a weird kludge to workaround the fact that the broadcast timer
doesn't actually work on this platform. That's why I'm suggesting that
you fix the broadcast timer on your platform to actually work, and do
that within the clockevent/broadcast layers instead of indirecting that
through cpu_pm notifiers.

That could be done by making a PDC clockevent that has some DT binding
of a property pointing to an MMIO timer frame and then reimplementing
the MMIO timer code in the PDC driver on top of the frame/register
region it pulls out of there. Or it could be written in reverse by
having the generic MMIO timer driver point to the PDC somehow and
implement some platform specific API to pass that information to the
real wakeup programming part in PDC.

I'm leaning toward the first approach where PDC is the clockevent and
that uses the MMIO timer on the backend to do what it needs to program a
wakeup. That way you can mandate the usage of the physical timer and
keep this quirk away from the ARM timer driver. It also makes the idea
of a qcom,pdc-timer-mode sort of useless because the PDC will have a
property that points to the timer frame and that will mean "use this for
broadcast wakeup". I'm not sure how the ARM folks feel about this
though. It would probably require some sort of ARM timer API that lets
us program the MMIO timer frame from the PDC driver. So exporting
arch_timer_reg_write() and making that always inlined to optimize hot
paths would be required.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
