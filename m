Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911DD2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lryq8lWc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDQ2RJFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911DD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sibaK9NH7wrjOnnOMc5spDn9gwhHL1cH80qZDvEfqe4=; b=Lryq8lWcTDpx3w
	XfWvkYIh0WSysInT3vCzKpolNslPTjrkCILztHY3DAXcnx2YpzgcIRbeQbqSFtg34KEC8x+EsBXaR
	DrCU3bPqRkUxxSKnuTSZfLEsn9pPkRKV1theZth6kK1TuVdoPvvngqwG1SoJf/9MOxnYfVkFWdSDx
	83rx+vaDGYLxPrmXXQ1/P9ET60ORwFnwtQ6Q4ljARKdGRUqWugYveFXv0kVWlUJhfktXoUwkQdrim
	ZwvUiA3kvsG3A9RLNbkDXoD3y5jzP6OThEwfwi9lbcW8EbzsyUuZDbF9fOdJUUsRYJuZhgJbGV1RH
	igDobQuMTqZkkm50V1EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4de-0003Ju-HA; Wed, 12 Dec 2018 13:33:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4dX-0003Hv-Ft
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:33:20 +0000
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D4302086D
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544621584;
 bh=5ChCtH3Tc+O6CY4zHCh78LRvo9uIS0nX7aBcIemIIio=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IDQ2RJFbU/lMBsN0UCXLyu8ClKDJhpEFNcqYrHkIsEhToc+y9pRHJcFcUyLvaE8mx
 WAPE7q1OVQ5zU14pJzw1TC2Vf9bCCBgDjp60EsMdYIYhtXe3JL+9+f5U76YDW7ICoN
 cjBpLQyPMrOYgZZlJYiR2vz/NvpnQiYxwrsTRdJY=
Received: by mail-qk1-f169.google.com with SMTP id y16so10703338qki.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 05:33:04 -0800 (PST)
X-Gm-Message-State: AA+aEWbirsBOro3UA05xRLuIaDa5yteqH4VNzD8VRn5A9o/xpRpHwwQu
 6nGzvuHDX1KnpyuF2M7qqpGGMzy6Gk9CnBC2xA==
X-Google-Smtp-Source: AFSGD/VWPmfMJsZnvIrZRTIrLzNJoeSuct9pEZVkSFdyZBMCcJICWHsQ+1bNMnqVlVogBRZUC7SPyYiw1pEFluN9JUI=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18472219qkg.147.1544621583631; 
 Wed, 12 Dec 2018 05:33:03 -0800 (PST)
MIME-Version: 1.0
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus>
 <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
In-Reply-To: <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 12 Dec 2018 07:32:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Message-ID: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_053315_564125_68AB45F7 
X-CRM114-Status: GOOD (  20.17  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ludovic Desroches <Ludovic.Desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 3:13 AM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 12.12.2018 00:13, Rob Herring wrote:
> > On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Add documentation for regulator modes and suspend states.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> index ac955dea00d1..4017527619ab 100644
> >> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> >> @@ -15,11 +15,17 @@ Optional input supply properties:
> >>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
> >>
> >>  Any standard regulator properties can be used to configure the single regulator.
> >> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
> >> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
> >> +file.
> >>
> >>  The valid names for regulators are:
> >>      REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
> >>
> >>  Example:
> >> +
> >> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
> >
> > This file belongs in this patch.
>
> I'm using the defines in this file also in driver. I was thinking that if I
> would include this file in this patch the driver compilation would fail if
> the patches would be accepted via different trees.

They won't be.

> Would you like me to have different defines in driver and this new header
> or could happen that these patches to be included in the main tree via the
> same tree (e.g. regulator tree)?

No need for different defines. The subsystem maintainer will take
everything in this case.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
