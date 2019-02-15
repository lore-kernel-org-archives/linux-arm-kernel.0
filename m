Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54866C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:24:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248752192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nQ4iskXn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWOLwK4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248752192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PEY32xTy/+Czn35Pt6S6RYC649EVC6jL23vgJDSC+28=; b=nQ4iskXnRr1rC8
	b6AosbtA0NQ9jsq/UGohdpzfgCY/J5gN05ch+ZssF+2qmjBOA+/4x94rtX9owiRiLnsLMKWiu1NKU
	w5ydinZ3iTKu7MMYwtADAJXS1o7JR3Xcx12sYbSXE/fR+4Hvom4tsWLnnOhGNgmIqVkPEC9hWUcDE
	VXP4Oh2ddDLPa289bt7FK1fOiytmsKUY36hObr6zvPr0dXgoPSp/UF8dyk5PJM7xRKC3p+/s1N/ku
	6svKlBkZIMSywVLfbVswr4e91Z+C9vFvXqdjmHPkzUItAYR26BU/umYQl2tFbjWCjc6OWNF66ILHo
	+rB8byCq4XAVnmZcFIgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gui9X-00006j-NG; Fri, 15 Feb 2019 18:23:59 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gui9T-00006B-Ha
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:23:57 +0000
Received: by mail-ua1-x92a.google.com with SMTP id d2so3535442ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76cIHW+3JOpk7bD22++rTXJr2gNVP13OIa9U+LuZfQo=;
 b=gWOLwK4E437YcnGWtAb5EG0Yl3jaqlccHvUuEqGOa3EUbpNmUtLFqIbECZqY90PhE5
 x/DZ0guv3m8oaJ1C72fZJ+2gW1aTEyAlUQmFVBo5Vu7Hu2KqxB1iPAoVYNNqoI0Fl5lW
 cyDVqB+Zw6wBA4BCIdiG79/U0SG3Tlm36FcRx3LIlKfVO8k6Ud88A7YiDlSioT2EDQ1g
 CgFZopVgQEqyf+n2/aEDvHdZhgjfm3FJioQ0knwZCA64isZSqL3mLj8mJ1VNP+UPez8R
 BUylN8EZ1vju2Cb6rinpLiOw7gBj4ibdjyYf85VUsvR1VJhiDtK3kkCalJ2+4dAFg8Ji
 4SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76cIHW+3JOpk7bD22++rTXJr2gNVP13OIa9U+LuZfQo=;
 b=qn3wwxB/6H37KAp9ns/TnhfMz0g0iLYkMIyMdVc0tgEl3qO5CtJ3RRKQdp56RmmAjx
 +IEmx7y4NMObnm6S+oDodrqeTQxlvz0BI+tPAM8LMP/uG53tDn845BSBtnqQeIYw/seK
 8QFrgQHZuohCXtKXcsFipOAHkLXUUBeIbQp6Ls0ALVg6KGSx5V0Zehf0tIq6+OYEaGC5
 DbpvcjB8Eu3CTA8QUCyKPb85gy/3r7ROotl7OMwH4qCTEMIn8i8OfZ/sW/WbUErGJOW7
 aiCvWgBV9AHAgymIEXI1OIcS0c9BzzFxDNnuXwTC9rgxLWFgstzz9qDN4UHB03N9yD8R
 SNCw==
X-Gm-Message-State: AHQUAubEOJ0rBSuG42yLxXRWskNivsK5Wmc1tGtYkVOQ/nXdHaICrO4n
 d5bqf51ZzQnY9pnbBqJXMPt3GTq9x1A/7bL1/z9POQ==
X-Google-Smtp-Source: AHgI3Ia2xULfXmEj1hVX33kYIXvohTCjee76YE1bRyXUVIWcxCSemrbwJLIvXGPDWMJv998EDJU7g1LPtxUxcZfZFRs=
X-Received: by 2002:ab0:5942:: with SMTP id o2mr5701790uad.53.1550255033277;
 Fri, 15 Feb 2019 10:23:53 -0800 (PST)
MIME-Version: 1.0
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
 <CAK8P3a1K+oUTrq903=8zfguJRXCQDvaXLT+TY-u6P8Obpr3myw@mail.gmail.com>
 <CAK8P3a1opCPaXD=8NwR6ZdJUHAKTC+0iOJTuq7g33J-=ryWUuw@mail.gmail.com>
In-Reply-To: <CAK8P3a1opCPaXD=8NwR6ZdJUHAKTC+0iOJTuq7g33J-=ryWUuw@mail.gmail.com>
From: Andy Gross <andy.gross@linaro.org>
Date: Fri, 15 Feb 2019 12:23:42 -0600
Message-ID: <CAPBZ5Qc=keE4e1ykbrLcq4UNxnZji=qnFsG_BdumGLD4KHvcOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 5.1
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_102355_584261_46B95436 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, arm-soc <arm@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 09:36, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 15, 2019 at 3:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Feb 4, 2019 at 5:31 AM Andy Gross <andy.gross@linaro.org> wrote:
> > > ----------------------------------------------------------------
> > > Qualcomm ARM64 Updates for v5.1
> > >
> > > * Add MSM8998 RPMCC, I2C, and USB related nodes
> > > * Add MSM8996 rpmpd node
> > > * Fix typo in MSM8996 pin definitions
> > > * Disable MSM8996 VFE smmu to fix security violation
> > > * Add I2C, SPI, rpmcc, uart, and WCN3990 wlan nodes on QCS404
> > > * Enable SDCC1 HS400 support on QCS404
> > > * Add a multitude of nodes on SDM845:
> > >   SD, UFS, USB, LPASS, SCM, QSPI, PDC, DPU, videocc, GPU, RPMh
> > >   bus interconnect, WCN3990 WLAN
> > > * Add gpio ranges to SDM845 TLMM
> > > * Fix regulator load on sdcard on MSM8998-mtp board
> >
> >
> > Pulled into arm/dt, thanks!
>
> I took it out again after running into build breakage:
>
> In file included from ../arch/arm64/boot/dts/qcom/sdm845-mtp.dts:12:
> ../arch/arm64/boot/dts/qcom/sdm845.dtsi:16:10: fatal error:
> dt-bindings/power/qcom-rpmpd.h: No such file or directory
>  #include <dt-bindings/power/qcom-rpmpd.h>
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> scripts/Makefile.lib:297: recipe for target
> 'arch/arm64/boot/dts/qcom/sdm845-mtp.dtb' failed
>
> Please fix and resend.

I failed to disclose that this depends on the drivers pull request I
sent in.  How would you like to resolve this?


Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
