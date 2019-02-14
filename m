Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19A62080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4tVEJxM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWdUKpZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19A62080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=++1a3pMqaeVyk3PAiXujAHzKC3rIiQdNQoeAKF7nUZM=; b=P4tVEJxMcf+YZi
	fGdsm2WnoJqlC7FblWdpwoJsQ0O7pNwiMhR31ghJZ52MWaGThKTLaOHotxrErUV1a3D8qXjMhJrnt
	ECf7tADWHUU6q0HOYXZQatxbxlZBghI1oCYh4o/eQfaez+Bd+8DH6+O2zSpRO10RF5fLazGHLubad
	/DBdRbVG4FlCIr0HBrrisksbt29c3x/dKnnVfH4t0FmyqAGOqzpXfkqhdn1Du+7QzkzhMNrDer1E8
	f40boVQVW6iAG2OQt50vz1KhZICviL+adslC4QhSCwsU4ltSKdpqtmJnpZYOkJoG4SGZwal0tTSw6
	xluCJ/fqoN8CrDfoSS4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHoc-0006dH-KI; Thu, 14 Feb 2019 14:16:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHoX-0006ce-Sx
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:16:36 +0000
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C73B222B6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550153793;
 bh=yI1kE66VpuYQMMEK8/lcyOGgJ4h+beeo2bebLTahaEo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lWdUKpZ5b32vafVlM2ACyug91RHOEP61NQg/CmmJehD7ucGn9dPpQ+ElQXxTge8zj
 VzhEuVph7qY/Nbg+l2FsgLW2X4b+u4UVh0+7yRTOUCyWGdXiQ1GyKvqi6LPeU9MQOR
 Y4Mme7lN81ndam5Ak0ELEg8y2m1o+hJEC3Q9fDbQ=
Received: by mail-qt1-f180.google.com with SMTP id a48so6974697qtb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:16:33 -0800 (PST)
X-Gm-Message-State: AHQUAua5LhXnn2OvbEiFHZr9fNhdkcD+cM2pvJIDS85hCtog2LqRZXV+
 q8bGT55zSQUwlT/swvuysLStr563YAbDkl+38g==
X-Google-Smtp-Source: AHgI3IaY3wfg3Md+1Jr5MIMyVnKv0PcB1DKLA6qjTpequls8S4t1vV/LZF3iBSgJba/tP3oJC5hJw3YQ+h7efOS21HI=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr3043949qve.246.1550153792504; 
 Thu, 14 Feb 2019 06:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com>
 <20190213211651.GA10705@bogus>
 <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
In-Reply-To: <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Feb 2019 08:16:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Message-ID: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
To: Ray Jui <ray.jui@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_061633_970056_E03365DE 
X-CRM114-Status: GOOD (  20.00  )
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
 Wolfram Sang <wsa@the-dreams.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 4:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
> Hi Rob,
>
> On 2/13/2019 1:16 PM, Rob Herring wrote:
> > On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
> >> In prep for the introduction of polling mode into the driver, update the
> >> binding document to make the 'interrupts' property optional
> >>
> >> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >> ---
> >>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> index 81f982ccca31..d3a3620b1f06 100644
> >> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> >> @@ -9,9 +9,6 @@ Required properties:
> >>      Define the base and range of the I/O address space that contain the iProc
> >>      I2C controller registers
> >>
> >> -- interrupts:
> >> -    Should contain the I2C interrupt
> >> -
> >>  - clock-frequency:
> >>      This is the I2C bus clock. Need to be either 100000 or 400000
> >>
> >> @@ -21,6 +18,13 @@ Required properties:
> >>  - #size-cells:
> >>      Always 0
> >>
> >> +Optional properties:
> >> +
> >> +- interrupts:
> >> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
> >> +    polling mode
> >
> > What determines when you want to use polling mode? I'm not sure DT
> > is the best way to control this unless it's really a property of
> > the h/w. Driver behavior is really outside the scope of the DT. u-boot
> > would use polling even if an interrupt is specified, for example.
> >
> It's tied to the particular revision of the I2C controller, i.e., the
> iProc NIC i2c controller does not have interrupt line wired. In this
> case, the behavior is determined by the DT compatible string of the
> iProc I2C device. I thought that it makes sense to now move the
> 'interrupts' property to be under "Optional" than "Required" which is
> basically what this change is.

Okay, please put this detail into the commit msg.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
