Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327842147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Re514mcu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEa7536u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327842147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPgKWBiGEhOdHsiU+oTOEDp6y1fBYOWseLfC+/glKX0=; b=Re514mcurGBFb7
	QMXCMJiDgKoVgTQd354YtvONPNgzFV1QbpPZih3PQqsULeVEpWWA7hJsvfhUNkKpq+FEEjfWs/2RB
	cwkDhINhN4krYEMru4gOcuxX9KMXLB+5CmLZQE6cvn7HHLSiOc7scUUmFRaFLnHDRiZidVml3VImx
	S1PqtRYiNa+TaXqN1A437fc3P6G7kyafi/8cDKWney/vd5veRj2y18FT1RviyY6TRFDiq0yWLd6b+
	9n3IqSJPU76+OWRc6Li15ddNiVNhmZtqzxgIvKZ0ITJ3QMiCY8Hf+OcWzCoUuPACL0H7fHuVWsrLy
	MfHljn6ZC4PG1LmOKWsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobuM-0007hU-TO; Tue, 29 Jan 2019 22:31:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobuJ-0007gk-1w
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 22:31:04 +0000
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com
 [209.85.161.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F37D214D8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548801062;
 bh=8mchtL/kda+QX5rreOUh8RrpnFpvoBbcXfLnACnhg74=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=eEa7536ucEFh2k5Ul7LJ0hYHP6HXe8zryDPiyEvKTt3Zc6NSK69j+CM/EDjgHRGKL
 wBzBh72QsQ4krwy6gq9miA7v0WREbn6759yL1EQfi5YdpZgc9fTiraJg4u+BmgXbmM
 KEELf6bYMjkawB1SY17aJ/hQmYVx+kCmByef6tTE=
Received: by mail-yw1-f48.google.com with SMTP id h193so8868805ywc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 14:31:02 -0800 (PST)
X-Gm-Message-State: AJcUukfRiy9r+Jkuq9X/6KI12ajsgBCYNb4h6Vk13K53M2fl6Sv6RUYZ
 tFznMyUl+zlnv2FX7L0KGLsM+pqe+bhbsErRCgE=
X-Google-Smtp-Source: ALg8bN6GhWFWtesdzm070o/hq2HKx2K6aegmLp5gXPZTHtol0adO1wDQtAS/UqGFgIeAwte4G+Sm2flA7dn1oEJbG48=
X-Received: by 2002:a81:8c1:: with SMTP id 184mr27309701ywi.392.1548801061366; 
 Tue, 29 Jan 2019 14:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de>
In-Reply-To: <20190129200858.19773-1-goldsimon@gmx.de>
From: Alan Tull <atull@kernel.org>
Date: Tue, 29 Jan 2019 16:30:25 -0600
X-Gmail-Original-Message-ID: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
Message-ID: <CANk1AXTcbqgoCYkTY-ssMvpAbdoncrkOxyRfu-piLE2tQ15a2g@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_143103_138956_65A4B8F7 
X-CRM114-Status: GOOD (  13.97  )
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

On Tue, Jan 29, 2019 at 2:09 PM Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:

Hi Simon,

Thanks for submitting.   A couple of things...

> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index f365003f0..8f6c1a5d6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -788,9 +788,9 @@
>                         reg = <0xfffec000 0x100>;
>                 };
>
> -               sdr: sdr@ffc25000 {
> +               sdr: sdr@ffc20000 {
>                         compatible = "altr,sdr-ctl", "syscon";
> -                       reg = <0xffc25000 0x1000>;
> +                       reg = <0xffc20000 0x6000>;

The binding doc will also need this change (in a separate patch)
Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt

> diff --git a/arch/arm/mach-socfpga/self-refresh.S b/arch/arm/mach-socfpga/self-refresh.S
> index f2d7f883e..bd7759357 100644
> --- a/arch/arm/mach-socfpga/self-refresh.S
> +++ b/arch/arm/mach-socfpga/self-refresh.S
> @@ -19,8 +19,8 @@
>  #define MAX_LOOP_COUNT         1000
>
>  /* Register offset */
> -#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x54
> -#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x58
> +#define SDR_CTRLGRP_LOWPWREQ_ADDR       0x5054
> +#define SDR_CTRLGRP_LOWPWRACK_ADDR      0x5058

These offsets are used for ldr/sdr and are limited to 12 bits.  This
won't build if CONFIG_SOCFPGA_SUSPEND is enabled.

/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:
Assembler messages:
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:65:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:67:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:72:
Error: bad immediate value for offset (20568)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:101:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:103:
Error: bad immediate value for offset (20564)
/home/atull/repos/linux-socfpga/arch/arm/mach-socfpga/self-refresh.S:108:
Error: bad immediate value for offset (20568)
/home/atull/repos/linux-socfpga/scripts/Makefile.build:367: recipe for
target 'arch/arm/mach-socfpga/self-refresh.o' failed

Thanks,
Alan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
