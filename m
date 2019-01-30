Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0EDC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDAA20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTpmrodi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS7aNf51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDAA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LmYgyB6GS2wfLgmceRmqyEOzC/ibMSX9KN4MeBN6kd8=; b=LTpmrodiPEVzqZ
	QDOW6usT9Da5psYtzK6yVnA3USwqByT1WNm4+k9yTGfRcUq9fKkk4iwxm1TCeY1niPtXlq/VWfCB9
	kiT/nSYlYlrOKTpdyaM5KE5vsiLUm3KyjytC6E2knGoDckCmONlu/+KhZ7NfIYUZYzeO8xIn3X4Lr
	3htMrl2x3VwgoY50wgf8lvFZ7XM5dJXFh9Gyd2Dpu/K6TIhYdiz7jec9uh4Trhv56f8Q5Zr6bOyqv
	6jMyDZGqJ7rZncvl4CtOSclpGIj+ag88SfmMS8my+KuY6+rgILjaQIny+i4DHf65NEPmSx4V3Yo4b
	hoUGpGC4gtRuEjPIadJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goivJ-0003hL-M8; Wed, 30 Jan 2019 06:00:33 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goivG-0003h0-Gv
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:00:32 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so19675103ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZbbuPOyYWoYzUMDSQIZUlEIAOQeW3QT0SpIPcdLMkEw=;
 b=sS7aNf51WECmPlAMT0ufK6LKnnfj0Pc6W8uetZJrXsKet7jXPFN/wYtWgciVTTIgT8
 lGoUWWSec6oYxHAG8hFVbAztnRVB/4tjKarv1yPYivt/sH5TudXacvWgnxFsw7VBaDbZ
 mHmIrMZfLTt/CDv+Hx3yoTbiv3RnqVyhA+TT2FmqwSeAXWUs+eV/hs3fRPdJFvfqsx04
 nxsFQFxbkjIMYjQRpHWalGT+B1i5RFEaKIHDe+8J5WqdQcA0YqhB9tvO/8r+LHQMfTjs
 uYk6wc3uQYZ6Cjbhy5+o2IjS0DjWEj9C/36FpD9a0NGvB+u0Se1cJhKaPncYKb/jDfJh
 I/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZbbuPOyYWoYzUMDSQIZUlEIAOQeW3QT0SpIPcdLMkEw=;
 b=mKtd+E8nW1Ypfwdnnm35kQOUz9GrCXXUhW2xvT4qb7xqIHjNWaCVgTzu5mwxkvm/Qt
 czmJAfKRPX4js6/mmAPKKc+YSmcPCiohfyVuSq9ysiMrEIRA1quRuV4EFSNNKbbsKhUO
 agCeHflGgQ67PZtjP1EOQBwqJV/jOxtlD+KUAq48aSiK3x2w7UaHujcfMRmTHRljAnr3
 iJexFaE5WGMAHzByLhMQ4iE+3R6JLt3fVaqzfIC5NSxpIyI+dXWyEtjQs8nnIuOQf38w
 xI3tUagTlmhZ2VBzpjeqgx8Poo65dbRsOnGCK9KJiL36I1DNOxVQHQzcZWbCqIQeHUCW
 FF8A==
X-Gm-Message-State: AJcUukewTx72LnOyMD8tb8hHy5qm3FzUtq5E152BnjE1VZvfV4g/98ux
 f8SD7j8xTCSOwZNS9KtJYlYZlf4cqk3wu3DCnKA=
X-Google-Smtp-Source: ALg8bN6OclMqIGJu/ivhcmkSwwd8PYB1hwo1RxBbf8K7TccRwIq6njYcK1+kXlrDQsuWZF1OnnNLdpRtAw9tLQ5xRE4=
X-Received: by 2002:a2e:9356:: with SMTP id
 m22-v6mr23013163ljh.135.1548828028406; 
 Tue, 29 Jan 2019 22:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de>
 <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
In-Reply-To: <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date: Wed, 30 Jan 2019 07:00:17 +0100
Message-ID: <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_220030_612232_7FE66904 
X-CRM114-Status: GOOD (  30.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ Marek (as I really want to keep the dts in Linux and U-Boot in sync)
On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
> > From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> >
> > The documentation for socfpga gen5 says the base address of the sdram
> > controller is 0xffc20000, while the current devicetree says it is at
> > 0xffc25000.
> >
> > While this is not a problem for Linux, as it only accesses the registers
> > above 0xffc25000, it *is* a problem for U-Boot because the lower registers
> > are used during DDR calibration (up to now, the U-Boot driver does not use
> > the dts address, but that should change).
> >
> > To keep Linux and U-Boot devicetrees in sync, this patch changes the base
> > address to 0xffc20000 and adapts the 2 files where it is currently used.
> >
> > This patch changes the dts and 2 drivers with one commit to prevent
> > breaking the code if dts change and driver change would be split.
> >
> > Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > ---
> >
> >  arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
> >  arch/arm/mach-socfpga/self-refresh.S | 4 ++--
> >  drivers/fpga/altera-fpga2sdram.c     | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f365003f0..8f6c1a5d6 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -788,9 +788,9 @@
> >                       reg = <0xfffec000 0x100>;
> >               };
> >
> > -             sdr: sdr@ffc25000 {
> > +             sdr: sdr@ffc20000 {
> >                       compatible = "altr,sdr-ctl", "syscon";
> > -                     reg = <0xffc25000 0x1000>;
> > +                     reg = <0xffc20000 0x6000>;
>
> I don't see the U-Boot device tree having this change. Yes, the
> documentation does state that the SDR address starts at 0xffc20000, but
> all of the pertinent registers start at 0x5000 offset. Thus, the
> starting address should be 0xffc25000.[1]

You don't see it in U-Boot as I'm working on a patch for that.
As I wrote in the commit message, U-Boot currently does not use the
devicetree for the SDR driver, but I want to convert it to do that.

But before converting, I need to find a clean way to provide the
register addresses to the driver. That doesn't work with the current dts.

>
> [1]
> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917

Well, in [2], you see that the peripheral's address range actually starts
at 0xffc20000. It's only the public documented registers that start at
0xffc25000. I don't know why the lower address range is undocumented.
Maybe you can help me here?

But U-Boot needs to use the undocumented registers to bring up the DDR-RAM.
Even if the registers for that are not (clearly?) documented, I think the
devicetree should still reflect the correct address range.

The U-Boot driver is made up of 2 files (in drivers/ddr/altera):
- sdram_gen5.c [3]: using the documented registers from 0xffc25000
- sequencer.c [4]: using the (undocumented?) registers from 0xffc20000

In both files, you can see the register addresses they use by checking the
static variables at the top of the file. And for convenience, use [5] to
search for the values of defines.

[2]
https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html
[3]
https://github.com/u-boot/u-boot/blob/master/drivers/ddr/altera/sdram_gen5.c
[4]
https://github.com/u-boot/u-boot/blob/master/drivers/ddr/altera/sequencer.c
[5]
https://elixir.bootlin.com/u-boot/latest/source

Regards,
Simon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
