Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A51C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:08:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8535221B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dJjDmvE0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6DfEXw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8535221B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCrfFFt35kXg38EneRYi4MR4KD4/I2kDCrmJmrBnAeU=; b=dJjDmvE0Q0+qWc
	UZEMov5ICvyDbzJW/rTJ6DlEGBNr4ytS9zZqnS+1KCuqOLw0zGBBDcnfRpBJHwGrEMK90z8HCfXVm
	yF0izTe6oO/EegLbFG6NURDljCZClxRWiCNwqGaUCxvXeJXLUn6/eo77ZS45HS2Ggy6y2ATiNOqYf
	NoNvdFtFxaI3a52Ow0v+g2pBxu62iw6gW4rh/4Dx/STQ5xYI3neYJqMVNi5ZCUlE4Fijn7ixLcWPw
	/eEE8HhdYudV3M6PpYTA6YVPn8oWt5PVUjZ8+zoJ+yras8msyqpwimE7SJkXH9X/2wkQ4sW4X1GrA
	+v7nTzbUKguPa//giaoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfIT-0002aZ-S0; Tue, 12 Feb 2019 21:08:53 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfIQ-0002a6-TR
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:08:52 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so62108plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+RK1phqmc8ILB4bd9KevGg/iRfPi486tW14SPbKzsLw=;
 b=q6DfEXw5a8MVGSu0N2eRUUoVXGRAd1ckSM9c/WShZxr9TF2x2JsZ9UStRO6RrSzelg
 xZ4QgH24mFmhvothRN5yYOOQftDi8dWbHm9lcOL/VvDbW32gSmtroEPv6NMx2qi6Jd92
 lNSlN3mHcmYMmLAbYRz8hbowouI4Z2Oag6kW4NnrxU6w3SG6jKOEyr1hTMTaW7S9C2HM
 fie5RlGNXjCvJOdoD326NKhjfuzByo0vVkHomKMCabpbu+18uIlTO1ZAV/1sairsi1wr
 KGq5gVEHZxu2TffawFnU+B7zVLCziM5dNlOfEMF+6VzXwPf/c4JCOv/cEZU1pNLVmuob
 wdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+RK1phqmc8ILB4bd9KevGg/iRfPi486tW14SPbKzsLw=;
 b=AeooOHbBVj1YnVftPvWQzUW6/9b4U+3erMf8eqOMCkzPiyOP4/7fk45JYeDlbOac4X
 pbPZKbipuBQ06sSzJ46xHLQ9iiU+gxY5ZmgqqEIJBd3ZFJODZmYSIomO9T3gXkqwsUg/
 EwIp0wi7z9jZltGoSnKLScDFOaBsp2pwlEnsNUn1cNy2n2lTlLYJQxEWoHAD5qNy4KUo
 TcHxx7W0+1mX0QwRF1o1ThAXf232xJVpkqEyiRXpI+mEUIXv1OeydOQtS6WIXXxgpTJN
 3WutWJn65UOZ+54oKi/c/0ild2DR7U8ZeO8AosC16l2Z/TBn2X0ak+fSv2HiZIxVF0PB
 tcug==
X-Gm-Message-State: AHQUAuahJdCGMN9lbVThYYQUuplqb46JgPC3Mxy5Uy+UljEiNwg5YBZb
 odYujzHPwXQlYG/T627oMnZFvBRL8CfOAwql3Vg=
X-Google-Smtp-Source: AHgI3IZ+rW+oHa5PTlDGCOTEMZ4Wf/vdp16QdfUcyfmyGDNWBDcb3vJb6h6BhPGxtZSJuzgKeE0y1AWbvsiO/AkeF/w=
X-Received: by 2002:a17:902:4025:: with SMTP id
 b34mr6026740pld.181.1550005729923; 
 Tue, 12 Feb 2019 13:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
 <1550005119-25750-2-git-send-email-Frank.Li@nxp.com>
 <CAOMZO5AtXz8Gyh6yBzVWWiKfSVVtSAArd52LbW=a3kszZ27iOQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AtXz8Gyh6yBzVWWiKfSVVtSAArd52LbW=a3kszZ27iOQ@mail.gmail.com>
From: Zhi Li <lznuaa@gmail.com>
Date: Tue, 12 Feb 2019 15:08:38 -0600
Message-ID: <CAHrpEqRMyieoSxqLx=R4Vj-LL4+0ZxM_FXeFimd=cgGRJFsbKQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_130850_944165_E0A406F6 
X-CRM114-Status: GOOD (  13.23  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 3:04 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 12, 2019 at 6:59 PM Frank Li <frank.li@nxp.com> wrote:
>
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 4c3dd95..243d7b3 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -79,6 +79,13 @@
> >                 interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >         };
> >
> > +       ddr_pmu0: ddr_pmu@5c020000 {
>
> It seems you ignored the commend I made in the previous version.
>
> Here it goes again:
>
> Underscores should not be used in node names. You could use
> pmu@5c020000 instead.

Sorry, I missed this.
how about ddr-pmu0

pmu is already used by arm pmu

best regards
Frank Li

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
