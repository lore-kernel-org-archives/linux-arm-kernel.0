Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52285C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B7A214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kqby/klj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="II3IEWAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7A214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SYx2BdhlqhhA5Dyg2WVYj7KZz6J/XOwu2Wv+1D2O3hY=; b=Kqby/kljeSXRql
	hEBkTM4il4ozNviAk5bc8xfaM0JvZ1cbg6qxVYUwsdSjC2uJTH2sSdGF3mvfaDFFbndEKREmEWvX1
	lmpsc9kE5c5OvMw92G0/4UghGOAN8/no6BAPxcgy/STLvitf9iOA7eyeIaPEaCJekovhy87QD6NsZ
	Xtj7MsyJBq8NassGr9HLvJdjO2I6/OIMWFU286BVcx79Px447D+jU5VO5APYqbdBK9vTItYTNXCO+
	YY70KPNFfiyAxKeHJ6/8FwP9OQplC3oPo7++L7/4ScZLqGWIIt2XpbVKANLOImFGm5PiGRhAJKfVa
	GS4hoQnf9XjjFQCRT3lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ273-00086S-AH; Mon, 17 Dec 2018 23:15:49 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ26z-00085a-3K
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 23:15:47 +0000
Received: by mail-pf1-x444.google.com with SMTP id r136so61605pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 15:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:subject:to
 :references:message-id:from:user-agent:cc:date;
 bh=ermBk6HU5FiDTzcsG+Kwy9SMlLjeXTpKKltfvBGp/LM=;
 b=II3IEWADcyy9dOwf7fCJwJLVA9b8qtk7nxjtc3tfD4u3gbZyFgukPbDCRZPnXDDuLG
 0pJwIq6AG+frFwcnS5FhTDoxEs1QrC0XUZ6+yRCnEdpwYTAoymchkmxcmp57V43IrIlK
 t0MwGMMgEIJqDkj+eln5P8rcUMNYXjS6v0cUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:subject:to:references:message-id:from:user-agent:cc
 :date;
 bh=ermBk6HU5FiDTzcsG+Kwy9SMlLjeXTpKKltfvBGp/LM=;
 b=pyekMWy6aIyW/sW+YJNyNIxzIYe1JcOhrGl40UsB2beO+w+PMdafraFR1mCFpYVs0j
 xVA0lvt/S4lm5mktWJCuNKn0WOZJh0CQfb43VtrmINop5X9f2cjkbZ5Ppd7B34A5ARWB
 O/l79dGrNnPE9VFndvKIB1OwGBcDt2AW7ULsJJZYHD0yuqq++XjAnirzdI48rzHoMEy6
 7wJmhuSu1oOnRYMquBIlzxAg0sPHQ8qUTURkBFbEAD3Tix4vfglXpf9K8aeMSDMMZ48N
 +pjFsMOxmQq+aOvqJG+X4LxB24a2P0GHMepjn8d/bUBk6bWFjcg3qLlIINDv1Sb4HKag
 XFMg==
X-Gm-Message-State: AA+aEWa213V+F0iLHnxDByefVR4iAQOnL0CSavgZ1YThX8V4jRifrWSV
 Ku9pLQY+rSqvywic0WOLFhWWcQ==
X-Google-Smtp-Source: AFSGD/Wv0aSQjyujH1BN9eNEUfyepsSwhxiytE1uBMlySR9hXl4mgZIEbNr+Dfthd2N+m/lFWyD/4w==
X-Received: by 2002:a63:8742:: with SMTP id i63mr878417pge.298.1545088533555; 
 Mon, 17 Dec 2018 15:15:33 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id e188sm16737612pfg.130.2018.12.17.15.15.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 15:15:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181214053035.GK1578@tuxbook-pro>
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
 <20180719054200.GB30024@minitux>
 <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
 <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
 <154282479571.88331.5041132574563990889@swboyd.mtv.corp.google.com>
 <20181214053035.GK1578@tuxbook-pro>
Message-ID: <154508853143.19322.18196170541201508404@swboyd.mtv.corp.google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Date: Mon, 17 Dec 2018 15:15:31 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_151545_200262_BE4B6243 
X-CRM114-Status: GOOD (  34.01  )
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
Cc: devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Bjorn Andersson (2018-12-13 21:30:35)
> On Wed 21 Nov 10:26 PST 2018, Stephen Boyd wrote:
> 
> > Quoting Stephen Boyd (2018-07-20 10:44:53)
> > > Quoting Rajendra Nayak (2018-07-18 23:59:20)
> > > > On 7/19/2018 11:12 AM, Bjorn Andersson wrote:
> > > > > On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:
> > > > >> diff --git a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > > >> index ce44ad3..9dd489f 100644
> > > > >> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > > >> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > > >> @@ -8,6 +8,9 @@ settings.
> > > > >>   Required Properties:
> > > > >>   -compatible: "qcom,pshold"
> > > > >>   -reg: Specifies the physical address of the ps-hold register
> > > > >> +Optional Properties:
> > > > >> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> > > > >> +             download mode control register
> > > > >>   
> > > > >>   Example:
> > > > >>   
> > > > >> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > > >> index df58fc8..0c97e34 100644
> > > > >> --- a/drivers/power/reset/Kconfig
> > > > >> +++ b/drivers/power/reset/Kconfig
> > > > >> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
> > > > >>      help
> > > > >>        Power off and restart support for Qualcomm boards.
> > > > >>   
> > > > >> +config POWER_RESET_MSM_DOWNLOAD_MODE
> > > > > 
> > > > > How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
> > > > > drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
> > > > > both drivers?
> > > > 
> > > > yes, thats possible, but I am not sure how to make the command line
> > > > option common for both. One other option I thought was if we could handle it
> > > > within the scm driver itself with an additional
> > > > binding to specify the non-secure download mode address.
> > > > something like qcom,dload-mode-ns?
> > > 
> > > Is the SCM device and driver always going to be present though? It may
> > > be better to make a TCSR platform device driver on designs that would
> > > configure the cookie with direct read/writes from Linux to break the
> > > relationship with scm entirely. Then the different configurations could
> > > flow from the DTS file either describing scm that has scm call, a
> > > special scm_writel address for TCSR, or a specific TCSR node with the
> > > address of the download mode cookie that triggers a TCSR driver to probe
> > > and register a reboot handler.
> > > 
> > 
> > Does my proposal work? I haven't seen anything new on the list since
> > this email.
> > 
> 
> Afaiu the SCM device is still there, even though we don't use all the
> usual functionality.

You mean the SCM device is always there even when TCSR is used to lay
down the download mode cookie?

> 
> I tested on qcs404 and sdm845-mtp (LA boot chain), and they both return
> positive on:
> 
>   __qcom_scm_is_call_available(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE)
> 
> So how about we change qcom_scm_set_download_mode() to do:
> 
>   if (scm_call_avail(QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE))
>         __qcom_scm_set_dload_mode()
>   else if (scm_call_avail(QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE) && dload_mode_addr)
>         __qcom_scm_io_writel();
>   else if (dload_mode_addr)
>         writel()
> 
> This would also mean that we can put the dload addr in the sdm845.dtsi
> and share that between LA and ATF.
> 

I'd prefer that any ATF firmware put qcom's download mode behind a
vendor specific SYSTEM_RESET2 PSCI call so that ATF can do the magic to
clear the cookie on normal reboots and shutdowns. Abnormal resets where
we want to enter download mode from some panic or crash handler can be
handled by calling the vendor specific PSCI call. Then the only decision
that needs to be made is this one we're talking about now, where someone
wants a way to express that download mode should be entered when a
hardware event causes a reset (i.e. watchdog bite, thermal restart).

Even that decision could be made statically though, in which case I
don't see why SCM is a dependency. The bootloader or firmware can decide
to always put down the cookie early and clear it when the system is
normally rebooted so that bootloader bugs can be detected. I'll admit
that we lose the ability to disable download mode unless we implement
something to clear the cookie, so on firmwares without SCM I imagine the
cookie could be cleared with the direct writel() code. Long story short,
we need a more generic method than qcom_scm_set_download_mode() to do
that because it doesn't make sense to say there's SCM firmware there
when there isn't any.

So can there be some generic kernel piece of code that looks for the scm
firmware node and a tcsr node and then decides to set or clear the
cookie based on a commandline parameter? It can also look for a PSCI
node and if there's a compatible firmware with the vendor specific reset
call it can use that to know that it shouldn't do anything besides allow
the commandline parameter to clear or set the cookie. All of this
wouldn't actually require to be bound to any sort of device or device
node. It's just looking in DT/firmware tables for various pieces of
information and changing how reset, shutdown and the commandline
parameter is handled for the architecture.

Furthermore, the PSCI style reset handling would need to be plumbed into
the ARM/ARM64 reset hooks, so we would already need to add some panic
crash handler calls into the PSCI layer to handle the vendor specific
cases. Coming up with a more generic commandline parameter like
'panic_mode=<vendor>,type' would be good to express that we want to use
qcom download mode when the system panics and then one place for all the
different reboot logic can be contained to focus other SoC manufacturers
on implementing a PSCI call or flow in a similar way.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
