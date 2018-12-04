Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A108A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4NYHBfw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w29ShF+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bBeShxPCYE8X1uKiMDWXUWIzv9ccBUOMP/o3G7XUsTY=; b=Q4NYHBfw95TxT5
	5k/IxIzVZGlQ7NF+fV++Ewv40i/6wJR+6NVYZ9xYsjbyhArZeuJ8vYLMzFCDuXHm3xCFaLQwXLxPL
	+ma6JZpVLL/qkP5bYLX73ouUYCcRSocSRZqwjP2WiAAPWaWPQGAgpnDrpw08cmcKqCb0a/R4nQxbF
	j8ECArdxAA7ms9SzTbThp2VhTs629opcFcMg5MaHiZNiTgH3oak116M5MOcyxpE1/7tufcz/1k+7d
	hfgEydHBfoQiuf+QPmPxU3mix1eHnigNU/g9tpFwvGIV1aOPgxHQCiA1F3aT5jvUjEhBgQucbE17X
	SKBIaC4oxwspfv4NpETg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJVN-0004ur-T5; Tue, 04 Dec 2018 22:49:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJVJ-0004pf-VB
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:49:23 +0000
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 686CD2241B
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543963751;
 bh=nAJYNF5exn/7MIzDf+gyUHqeEcWC+Frr1x7qmSLYhyw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w29ShF+bdXzVUKOyWvM4TIxOwLG8xXP4CAen4rtuCdJcFedVIUULLN7NU5HV/y5zd
 w5mcA2Ayx6Q3IQYPL4sfET8nG0VH4LeorZR5k4hTtjLUPDA3sVYSgMPDdtDByiHE2n
 QNO7K2fx5b81rE2nLaTfiiyR/QaC2i10vmzx8I4E=
Received: by mail-qt1-f175.google.com with SMTP id i7so20125076qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 14:49:11 -0800 (PST)
X-Gm-Message-State: AA+aEWbwgQt8gOOOGHHPk0a++XmJMmGsBlaPJjc/GSpSFTHgxm51kRBf
 WEmLMdlVt2oogCJ4M7FVm5460QDjwi2JLv9KEw==
X-Google-Smtp-Source: AFSGD/V5FXSz3M1XMujzv3vfX6JjiuiUVj0szW8v6ILDUDw7ehQqjaWH5Tw2r1t6XJQTmzZ0rlxzOodM3Mh8u9BQL08=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr21366933qve.246.1543963750624; 
 Tue, 04 Dec 2018 14:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-16-robh@kernel.org>
 <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
In-Reply-To: <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 16:48:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Message-ID: <CAL_JsqLfZwG6NSs0rq5QYjmOCmYFnMRRA5qz=uT2ER9Q3zLiCw@mail.gmail.com>
Subject: Re: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_144922_041399_5E650FA9 
X-CRM114-Status: GOOD (  19.31  )
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 2:12 AM <Nicolas.Ferre@microchip.com> wrote:
>
> On 03/12/2018 at 22:32, Rob Herring wrote:
> > Convert Atmel SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>
> I'm listed here...
>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Proper email address here...
>
>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
> >   .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
> >   2 files changed, 133 insertions(+), 72 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
> >   create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > deleted file mode 100644
> > index 4bf1b4da7659..000000000000
> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > +++ /dev/null
> > @@ -1,72 +0,0 @@
> > -Atmel AT91 device tree bindings.
> > -================================
>
> [..]
>
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > new file mode 100644
> > index 000000000000..19431f58b906
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel AT91 device tree bindings.
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Ludovic Desroches <ludovic.desroches@atmel.com>
>
> ... and sorry but it's not correct just above ^^^
> - wrong Ludovic's email address
> - wrong Alexander's email address
> - and I'm not part of the game anymore...

Humm, I think get_maintainers.pl says you are as that's where the Cc
list came from. But it could be stale if that changed recently.

>
> So actually our MAINTAINER's entry is up-to-date: please use it.

Sorry, it was generated from git history. Many of cases with
get_maintainers.pl was not correct and ended with me being listed.
Probably should have made the git history a fallback.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
