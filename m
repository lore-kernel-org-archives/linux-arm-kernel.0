Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E638DC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B506F21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sg92xaeY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5OdNA/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B506F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ylAI6d0Zx/VZQ50TXo48mHKr3Wo7s0eoznn4DWMmXCE=; b=Sg92xaeY7h91Z0
	sni2DtXE8mTt7SM/jELy6lvQs9jq+NA2vMtlGWmeBx3iW7UAMfxUDEhtcl+IFRnecRAMugPTrpBTo
	MTlLdKxNxsCSfVnvNrQ6twunS0w89HL4An/Mq/QIAchhc8PelLSzrGNlVv0a0MSQbhJ3whJVfRUws
	+r7caajMviOP7r22LgBGgjVBAQfB7yMq+YVpwKcCw8GTsSchiOZW8xjF2DSgX+vETqCYfK02j/2xr
	fJ9BV62ZpUulEsy439WHwoUcPMrWdZ/z75rsSGw3x+HMgc/5Jnym8ETJEJlIgJC7xK5RCh8R9A4Zz
	YIQEIBfPP3s+TQjqZf1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goj3H-0006ew-MU; Wed, 30 Jan 2019 06:08:47 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goj3E-0006eX-7X
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:08:45 +0000
Received: by mail-lj1-x241.google.com with SMTP id k15-v6so19637298ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tK9mSywMDOVGyM/DNFGFSATJj9vh7JMH2LOwZoMxCSU=;
 b=C5OdNA/dZVLi++NRbdwbRb/GMtJvl/Xicn6gxjRWYNRcF3TmontlmU1lTiQEmkwqoB
 BhTTgGNx1w7iLP3IdZFH1owU2nUGy9gHn8zJo8hlPydipnQxMkhYFrwRLqRWJv8agl5+
 krCF7oMQHMd4FSwPyuMQzmwT5jyyuPPDnyaM1IO1UTp1zqdyQZ0RZrqdrqR7xX5YsCeK
 kgHcAS7wC11OFPgUsjaE/XYl1xwrzjRn9V4ETMdTtSt/e8gvJ0tVgykOTsXTjb9xZQyA
 G7LUQ4BJh4vRXV/j7hgb+/N9PvFzZQhImxtWIHw1VUkAgPTkJ9Jj/fXlOvlvCdhM26RR
 RdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tK9mSywMDOVGyM/DNFGFSATJj9vh7JMH2LOwZoMxCSU=;
 b=KmHMBDCkj3wXi38Nib6RbNhLE0b8bt8jkKDlQaIWUyPv1DFbpndoQF1l7GM2LdAuhu
 /6ybyNuJIgMkFIJu2A8QdXMmSucu7TR+AmgGazV8+ELmErKZfQxbYgHkBDQYZUfknEav
 Q8SUkqK+kfMeePoURrMBrwQ9rtaE95VBGdIdufXqlvwyAqtoNbH2U1m1V7IScAFUwkRC
 dnIyW9NxdSohagM0aGwLzVUHfV7wKk3OKjbziWysMetimpG+gSKob4YhBwKI+eeaNTzQ
 shDhsdPVTXLpL23Rj486Rzbq/MhcbrqaETziSYc8FKYDLymvm1hhAdLaqYAdFBazr4dR
 MIEQ==
X-Gm-Message-State: AJcUukcrnknAeUFShKXncym/fBdxpBciCINle6gi8i0dyFg6X5ai3xA7
 QdWlgL/ymvGD5VVO9r/xMYnbNIoc8nmvobSaTXReIhdv
X-Google-Smtp-Source: ALg8bN7iYMwPXszwp3vtyKv8V/4Hnn2sE0fNEzApNWxJGKodCBxAAidMGvxSKGF41DyvRdXfoPvYYDgtGnKnLob34/4=
X-Received: by 2002:a2e:9c87:: with SMTP id
 x7-v6mr22035012lji.196.1548828522133; 
 Tue, 29 Jan 2019 22:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
In-Reply-To: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date: Wed, 30 Jan 2019 07:08:30 +0100
Message-ID: <CAAh8qsz9g-20ZOZpT2Fh5003ZkH=HQ9sUBVHWqooB2Pt-OXA4Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To: Alan Tull <atull@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_220844_274257_6E062B14 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 11:31 PM Alan Tull <atull@kernel.org> wrote:
>
> On Tue, Jan 29, 2019 at 2:09 PM Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com> wrote:
>
> Hi Simon,
>
> Thanks for submitting.   A couple of things...
>
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f365003f0..8f6c1a5d6 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -788,9 +788,9 @@
> >                         reg = <0xfffec000 0x100>;
> >                 };
> >
> > -               sdr: sdr@ffc25000 {
> > +               sdr: sdr@ffc20000 {
> >                         compatible = "altr,sdr-ctl", "syscon";
> > -                       reg = <0xffc25000 0x1000>;
> > +                       reg = <0xffc20000 0x6000>;
>
> The binding doc will also need this change (in a separate patch)
> Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

Right. I didn't realise there is an actual address in that file as it says
"Example"...

But I'll make sure to change that if this patch is accepted.

>
> > diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
> > index f2d7f883e..bd7759357 100644
> > --- a/arch/arm/mach-socfpga/self-refresh.S
> > +++ b/arch/arm/mach-socfpga/self-refresh.S
> > @@ -19,8 +19,8 @@
> >  #define MAX_LOOP_COUNT         1000
> >
> >  /* Register offset */
> > -#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
> > -#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
> > +#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
> > +#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058
>
> These offsets are used for ldr/sdr and are limited to 12 bits.  This
> won't build if CONFIG_SOCFPGA_SUSPEND is enabled.
>
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:
> Assembler messages:
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:65:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:67:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:72:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:101:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:103:
> Error: bad immediate value for offset (20564)
> /home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:108:
> Error: bad immediate value for offset (20568)
> /home/atull/repos/linux-socfpga/scripts/Makefile.build:367: recipe for
> target 'arch/arm/mach-socfpga/self-refresh.o' failed

Oops, you're right. Sorry for that. I just saw now that socfpga_defconfig
leaves CONFIG_SOCFPGA_SUSPEND inactive. I'll make sure to test that if it
comes to v2 (depending on the discussion).

Thanks,
Simon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
