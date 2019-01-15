Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F50C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3233C20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sLK52LVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Message-Id:References:Subject:In-reply-to:To:From:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VXXE1jfn18qxrS6unQl+bV8HBbsnQb1/tPcacSrRJ7s=; b=sLK52LVsalJAzBSqhxsWGSuZHP
	hsIlOr+CFz7Ot3aCYR8nyTjXJZQsRvntN0Nuk8LuxcfCN8IYncJuAknFgC6JnxB+dUkmcDvOREI/r
	GFSLLYud8vo4xV+V814+LHEYu5FjMg/E936FEH4QngOCaVs3ohR84UlZxKHPWw2bUZAyCNuziT+VG
	3LwZDFOo3TvhnSAwHlQ5CQ4E3A8ZUXCbH0/DH1PTTKkeLIN/W+3qWu2fK4D8wFOVwEfvuFo752iP9
	cOx0JzgKPjsiyuuZGJYqqNT+Zb4WibrrptALgy34DbbUeqOTnMLuExX/yaUuCFnNPl4cHjfEToIYA
	qPyJC3Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjT06-0005Eh-Ky; Tue, 15 Jan 2019 17:59:46 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjT03-0005Dh-2j
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 17:59:45 +0000
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MGBB1-1gUtzO3VeZ-00F8Wp; Tue, 15 Jan 2019 18:59:26 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
 id 01E3C6E85603; Tue, 15 Jan 2019 09:57:48 -0800 (PST)
From: Stefan Schaeckeler <schaecsn@gmx.net>
To: bp@alien8.de
In-reply-to: <20190110095049.GB17621@zn.tnic> (message from Borislav Petkov on
 Thu, 10 Jan 2019 10:50:49 +0100)
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20190110095049.GB17621@zn.tnic>
Message-Id: <20190115175749.01E3C6E85603@corona.crabdance.com>
Date: Tue, 15 Jan 2019 09:57:48 -0800 (PST)
X-Provags-ID: V03:K1:EzR5CvvaIGLH0zWOSwVGWmSucprjb3tra4g1OF2Een2KafAqRjg
 yFqZ849BZBASOjINZxOP/fle2JvDB4Pw96wU0zquP6SYgQxg9B95NfXmxtzomQ3myKJSeEu
 Tn6RXzTte0iOff+hz4q/U1qGwYQLUSEQx/V6g0SM1yQQWvjv98IJ/weYbWsICTgqwI+pBy/
 WbtTSnBLYI30SSq0NoytQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XBytXecmnfY=:kiKrTDa3DWashyjYe5WhLX
 Rpzw/HP/kLoc52zb/FNyUv2ZjNF1BTD5GaJXibn/osDAxbBSHU+Mp1RuvYNtnnCnNawyD4+zt
 U4ehmsQJ7P4w5IPK6TIDEQmXFti9freSPMY4DqZ+LlVCaJkSE6SlyocPZ5uoEpfvuKz9Tk2bB
 xGnXw+/g/oTgJhVdpePgRyVakggcUw4xQG5JWonq9LouJtUStFp/ghrQ4FVgFEjAI+lsS6thd
 SZe00rqVOceztKVgbMNTF/aEqNTcUbtPRfL7HyCgu4k7BrXM+KsfXQgF2VuggyJWOl5OAFdIC
 NhiPzcHhIaypXR5Jq7/D+NdNCJMsairve+J1fKMGVcXiHD0CA4zDJoRyWPvRpFga7/hyC3Q34
 f1RX9Y+Hqu+UqV74uZPDzA9yQTXRVtkOvnV/dGhcqxmZ6iuw48sDpTtZCzj2UAcLfdtLhyejr
 J7+MPC9etjsuA4BqZdrQAE9TriUnXk8q3+o2gK06/IDRM9W1ljGXucTlZguCw9HfY9EEVMBHN
 /PxQpuDA837gfm6amPJI/MjLKV9Vc+nmotZbbir36RN3hPICJK7T83xugdP/rKFSQeITyAAH1
 pcb95zWxivil3PbHVwgX6MmOSRT50vdN9GSGxrz1Htk83x7IFLno+N97FXy6CL5inv2XPzoFS
 hGFX2xizwjwzs2uZznOIKDea/7Uus0naK9AJ6I9JLm4WGhIi4uZ1hzPHqHyji5imTg1g100wY
 Til24Bpo8murnGgl5RBfzsgl6wlbAp0QoKPMTajtf/2Q6MrC4uSo8pFe0Eurh0dbG5H2r26f9
 gO0dVOinRpPUPLMpK4Xa2FRzEVOwvx3ZvrVDSu4SMnlIuRHWlIgWxrrRLpmXNU2PR2k86xzgc
 QJhUFQRcyHUpxtYyX5eV7Sjtwgi7loI4kJ11qV7mj17rEhnWHLd88kzR80m+lS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_095943_497452_94F13AA5 
X-CRM114-Status: GOOD (  16.56  )
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
Reply-To: schaecsn@gmx.net
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, joel@jms.id.au, sschaeck@cisco.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Boris,

Thank you for your feedback.

> From: Borislav Petkov <bp@alien8.de>
> 
> On Sun, Dec 16, 2018 at 10:01:56PM -0800, Stefan Schaeckeler wrote:
> > From: Stefan M Schaeckeler <sschaeck@cisco.com>
> > 
> > Add support for the Aspeed AST2500 SoC EDAC driver.
> > 
> > Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> > ---
> >  MAINTAINERS                      |   6 +
> >  arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
> >  drivers/edac/Kconfig             |   7 +
> >  drivers/edac/Makefile            |   1 +
> >  drivers/edac/aspeed_edac.c       | 457 +++++++++++++++++++++++++++++++
> >  5 files changed, 478 insertions(+)
> >  create mode 100644 drivers/edac/aspeed_edac.c
> 
> I couldn't see anything out of the ordinary - only nitpicks below.

[...]


> > diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> > new file mode 100644
> > index 000000000000..d6ed119909eb
> > --- /dev/null
> > +++ b/drivers/edac/aspeed_edac.c
> > @@ -0,0 +1,457 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 Cisco Systems
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> 
> You have the SPDX license identifier - no need for that text.

That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
identifier.

785 of them have a license text while 16159 don't. I will remove mine.


> > +static int aspeed_edac_regmap_reg_write(void *context, unsigned int reg,
> > +					unsigned int val)
> 
> All the static functions don't need the "aspeed_edac" prefix.

When stripping off aspeed_edac_, some static function names will become quite
"bare-bone":

aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
aspeed_edac_config_irq().


Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
would become quite "bare-bone".

 Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
