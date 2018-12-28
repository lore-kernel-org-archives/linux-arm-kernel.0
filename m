Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF082C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D40F20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zvcjahup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMLKpvwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D40F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7rLCfYDiJIUdm8Cw1ZkqVzNTNvmHzrU6QD9CyymKaRQ=; b=Zvcjahupys+ZT/
	3zxhJvpMgQt1cuh+/ySXjO5BrpRXXQFvpNkfPSbL9L+kRfaNVdztg68GHQ/mL50dM/8g74g9MJSbD
	ME/++zLhTxrtd6aPnkvAr1dnmOW9vIuJNHL7yxzuFSoOrdwgG2Hml9zcazLlBBF8vYKlplMbqpktJ
	wSjN5/AWNS3D3qwJbVDS1uHd1bDEXzKlMT8wbtT4tvz0r3FegRd32v0iThEtXtTrl9Jkhddicn34r
	h5b1hgjPQI0P1pclAYaPFA1R7fLRzshbghCa13HgqOODnU+GIN1UBIjBBSc7+1Y96laSCYj9m2r7L
	SR0kUL6eYkG9VLgvRJBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gczq9-0006Hj-8A; Fri, 28 Dec 2018 21:38:45 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gczq4-0006Gv-Ev
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 21:38:42 +0000
Received: by mail-pg1-x541.google.com with SMTP id y4so10488338pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:to:message-id:references
 :subject:cc:from:user-agent:in-reply-to:date;
 bh=NLDRg8d3P3g0015PxnCaL0q7vIF2U2AakIDHRtQEgcM=;
 b=WMLKpvwMb+vkyQWUm24xoSbGH6GsvRBrNeY4IZ8EJnN2uD4d6jYbV0pfLa57wmO5m5
 hG7vbl8fPOBZbg5fRrysph0bLPC4Gp5js9hpXb/A4KaLiIF/hi/3Z1/mE+fIq3XUoGWz
 RMKaVKDFdRWhVbWYtndw8uO0AJ4SmdVw7/2c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:to
 :message-id:references:subject:cc:from:user-agent:in-reply-to:date;
 bh=NLDRg8d3P3g0015PxnCaL0q7vIF2U2AakIDHRtQEgcM=;
 b=OFH6o1hcDwOJUBcELLg9A21XbBszIoxMP7oirLaiaGORdEy5aN24Sh4JMLa9POxLfH
 AQmfP5ajE88XfQ4QQpaNAF0l0CXzk8DrVt9HwPb7W3xrcREl7GF4tNyE0syL/ZCVO+aF
 rpyBaCvaYhGiIDSxSCnrMo3S+/jurGHUIUVKXXz9JlaokJoeOpgWhTC9P0xnB0vJlFx4
 lhEM5JbsA3LD0gy6xZa8outFIJoDfntC2zXFRGajAVc8PQNU5oov3MUWAuitC+vMuzE8
 Z9p7cnvNmxczzw/oiLTspBE7A1b9jReKmRufczgvzxOBT4FgrcJ8M6CtcnwXu5JE+dFM
 LjPQ==
X-Gm-Message-State: AA+aEWZXFvEV9HDU2VwRIlhvTuLndC5JHK0Vr/3qUmnC+X2DaRuqC6A5
 YskMYPj9hgHsvYAodNj5speB2A==
X-Google-Smtp-Source: AFSGD/XqPjsUb/JfrS+qCKtXNHaLkd+ERTq3bD6qUBzo0Fh7aqQvuKQ+qt2qm3y/fftdftZw605qJw==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr29863361pfd.90.1546033109141; 
 Fri, 28 Dec 2018 13:38:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id s9sm57225203pgl.88.2018.12.28.13.38.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 13:38:28 -0800 (PST)
MIME-Version: 1.0
To: Raju P L S S S N <rplsssn@codeaurora.org>, andy.gross@linaro.org,
 david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-soc@vger.kernel.org
Message-ID: <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
In-Reply-To: <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
Date: Fri, 28 Dec 2018 13:38:27 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_133840_941469_7625CFA8 
X-CRM114-Status: GOOD (  24.84  )
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

Quoting Raju P L S S S N (2018-12-26 01:44:43)
> 
> 
> On 12/22/2018 1:09 PM, Stephen Boyd wrote:
> >> +If an RSC needs to program next wake-up in the PDC timer, it must specify the
> >> +binding as child node with the following properties:
> >> +
> >> +Properties:
> >> +- compatible:
> >> +    Usage: required
> >> +       Value type: <string>
> >> +       Definition: must be "qcom,pdc-timer".
> >> +
> >> +- reg:
> >> +    Usage: required
> >> +       Value type: <prop-encoded-array>
> >> +       Definition: Specifies the offset of the control register.
> >> +
> >>   Example 1:
> >>   
> >>   For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> >> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
> >>                        <0x179d0000 0x10000>,
> >>                        <0x179e0000 0x10000>;
> >>                  reg-names = "drv-0", "drv-1", "drv-2";
> >> +               #address-cells = <1>;
> >> +               #size-cells = <1>;
> >> +               ranges;
> >>                  interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> >>                               <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> >>                               <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
> >>                                    <SLEEP_TCS   3>,
> >>                                    <WAKE_TCS    3>,
> >>                                    <CONTROL_TCS 1>;
> >> +
> >> +               pdc_timer@38 {
> >> +                       compatible = "qcom,pdc-timer";
> >> +                       reg = <0x38 0x1>,
> >> +                             <0x40 0x1>;
> > I don't understand this whole binding. Why can't the pdc timer be
> > programmed within the rpmh driver? This looks like a node is being added
> > as a child just to make a platform driver and device match up in the
> > linux kernel. And that in turn causes a regmap to need to be created?
> > Sorry, it just looks really bad.
> 
> 
> There are two RSC devices in SoC one for application processor subsystem 
> & other display subsystem. Both RSC contain registers for PDC timers 
> (one for each subsystem).

When is the timer programmed on the display subsystem's RSC? It's hard
to give advice without all the information.

> But only for application processor the PDC 
> timer needs to be programmed when application processor enters 
> sleep/suspend. As the driver is common between both RSC devices, this 
> approach is taken. Do you have any other suggestions to distinguish 
> between the two? Perhaps, by additional compatible string?
> 

Maybe compatible? I sort of doubt it though. Do all RSCs have a PDC
timer?

I would think that it would make sense for the application processor's
RSC timer to be programmed from the broadcast timer mechanism in the
kernel so that timers during idle work and suspend turns off the timer
appropriately with a shutdown hook. I guess the PDC can't tell you the
time though? It looks like a shadow (and limited) version of the ARM
architected MMIO timer that we already program for the broadcast timer
mechanism. Is that because even the MMIO timer can't wakeup the system
in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
always be used as the system wide broadcast mechanism because we need to
augment it with the PDC timer to get the actual wakeup.

Maybe we should be adding hooks into the broadcast timer mechanism to
program this wakeup event hardware in addition to the ARM MMIO timer. Or
we should stop using the ARM MMIO timer on these systems and read the
system register based physical time in the RSC timer driver and register
this 64-bit PDC register as the broadcast timer. So the time reading
would be through sysreg and the wakeup programming would be done by
writing the PDC timer. The assumption would be that we have access to
the physical time registers (which sounds like the assumption we have to
make).

Do we get an interrupt somewhere from the RSC hardware when the timer
fires? Or does that just cause a system wakeup event without any pending
irq and then another irq (like the ARM architected timer) just happens
to be pending around the same time? If we get an interrupt somehow then
I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
timer approach.

How the RSC is used in general by other devices, like display, is not
clear to me. We don't have a "wakeup event" framework in the kernel that
device drivers like the display driver can grab a reference to and
program some system wide wakeup for. That sounds like something new that
could be handled entirely in the display driver with direct register
writes, or it could be some qcom specific API/framework that eventually
calls down into the same RSC driver that knows what offsets to write
into in the display RSC's register space, or it could be an entirely
generic framework like clk or regulator frameworks that could be used by
anything. BTW, are we using the display RSC yet?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
