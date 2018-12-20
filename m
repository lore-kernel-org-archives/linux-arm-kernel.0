Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF6F218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p5CqV8n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF6F218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n/Ojn1BkO7PEaCR89wD9INC2AMsoXq/55354dDqWhI4=; b=p5CqV8n/2oAsfs
	fdVWLnFOx1FxbI4sGvmjkxxYBV/lCRWjkeA65W/PjIJEiIegcPIohzd03JIyQavyb8k+iZN5U5qaw
	u2H965d2lJohv3LR3IWxjQ+XmxpfxKPA9Ck4mzGjBus1gDq4qDiSEEv6vb+cec15JO7VR1s7LV9sP
	2xn9qT9FGTSyP/ApOCt9rf8BzLEys5wEI3zBh7CRatSkMn7F71sbJFHo8zCV5SXVpSFvKbq0IkWM3
	Pom8Oo9VL0BPwS3Lh0+w3yUaeiHMk3QY8geTonWzhGGeIV0EKdG49hocvrklqyuVPp44UyKL4eNq4
	3H87ySooqNQ92swmiEtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0OP-0000LB-Fa; Thu, 20 Dec 2018 15:37:45 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0ON-0000D7-13
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:37:44 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so2208995qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kr8LcUPJd0Ipjgj+yK+B08cNBjQa3nqcdZJKjmfyMyA=;
 b=H6BIDh7C1i1ctfvO1+sQM3GACxirssIAcR4VmE1RpJg3MSPigPYEF/5HTswp+eFQyx
 pq1bGkjUR5isea5MITQWA2Beruwa82LTss9AQK1uyA3QNAo5z36fHRE15WotJJvpryfb
 9z9dpZdGCPTdmGc8n54sS184IHxgwgaHvSD7XAYSlTyxKHis0SgZq6kdjHQgR3YDBbls
 ohi9Bv1PoDHa6aTdPjkc5g5lEZwfyClE4Idmwmjoit0F9BsxDPlj6vc7d4TRV6C4njUZ
 mK7DvtmfbAVhOLSlGaqdC90lEa/Z3UW2QNnkhH+nxzKsBrZsxTqP86sFrDONGjjMuhxQ
 K07w==
X-Gm-Message-State: AA+aEWY6xlSmL4gtVzMlQ7DR21TC3CFuIjKAyNBwAengLefqLhm7LGuH
 XQaFbirCHafNuYqnWH1LPaBgiZ/WDZgvDkEnkak=
X-Google-Smtp-Source: AFSGD/WMVFCenM3I0BI4Q6D0EzerdB2pf1qJSaSejagBclkqpmteBxdS+q3au8dNGV9xaxrb4q9gqSIHLBNfhljOwKo=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr26378239qte.212.1545320250452; 
 Thu, 20 Dec 2018 07:37:30 -0800 (PST)
MIME-Version: 1.0
References: <pull-1544723769-214686@atomide.com>
In-Reply-To: <pull-1544723769-214686@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:37:12 +0100
Message-ID: <CAK8P3a1fnreKPkbyEMBgC_ACGCnhJ56bQOad38VfaQcKNnWEeg@mail.gmail.com>
Subject: Re: [GIT PULL] ti-sysc dts changes for omaps for v4.21
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073743_075112_6559C3A0 
X-CRM114-Status: GOOD (  19.69  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 9:25 PM Tony Lindgren <tony@atomide.com> wrote:
>   ARM: dts: Cosmetic fix for omap5 USB node names (2018-12-13 09:08:43 -0800)
>
> ----------------------------------------------------------------
> Add interconnect target module dts data for omaps for v4.21
>
> This big set of changes adds SoC specific l4 interconnect target module
> device tree data for am335x, am437x, omap5 and dra7 SoCs. We also move
> existing devices to the right location in the l4 interconnect hierarcy.
> This is similar to what we've already done for omap4 l4 interconnects
> earlier, and follows what is documented in the ti-sysc driver dts binding
> in Documentation/devicetree/bindings/bus/ti-sysc.txt.
>
> These changes will essentially replace the struct ti_sysc and clock
> entries in the arch/arm/mach-omap2/omap_hwmod_*_data.c files. Then a few
> merge windows later, we can start dropping the built-in platform data
> from the omap_hwmod_*_data.c files in favor of the device tree data only.
> For now, we verify the device tree data module data against the built-in
> data and warn about changes to prevent regressions.
>
> With the device tree data, we are also probing devices with the ti-sysc
> interconnect target module instead of omap_device. This fixes up the
> handling for multiple device instances in a single interconnect target
> module that has caused trouble earlier. A custom wrapper driver has been
> needed earlier for such cases.
>
> And as the device tree data is organized by the l4 interconnect instances,
> we will be able to use genpd later on. This is because each interconnect
> instance is also often also a single power domain.
>
> This series of changes has been brewing for several months now. I did not
> want to send a pull request earlier as people were still seeing device
> specific issues until recently though. However, it turned out that all the
> issues were quite trivial to fix. I had missed adding device tree ranges
> for the l3 data port used on some devices, and I had missed converting the
> device addresses for a few devices. And some devices like needed fixes for
> deferred probe handling such as the EHCI PHY for built-in case on omap5.
>
> Anyways, in case of trouble, we can easily just revert changes for a
> single device if needed.

Thanks a lot for the detailed description and background, that really helps!

Pulled into next/dt now,

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
