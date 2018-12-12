Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5568C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3CC20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OKwZDLXs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+TpKqvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3CC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YlVs8iw8W1SORU7YrxQGOec4dykAG5hJWrkrTdTptUg=; b=OKwZDLXsjDrw5e
	xfU92nKzeLBG+ezy32W2VX56u0+EvHvpBaqtFQIzmgbd/N4dk1FN0ei8XgnZ142hz9oGWM6LF054t
	dl5lGh3lf8U2mZijd+7sbj+tDPuTus4M4s43vi+1vCCYV/Xh+pFFgl9SL58luAcby4BSSzAyWVTUx
	Nsj+7i2Y7mLMUDpa5TZP/IGmU1QJyurG466xJOWACobVb2Tc11Ram46GMZue93f9xh37eifFebR/Y
	ShRNZjE4HHU/ZnvzORl//Ce6tHE+NuCyrx5ccx+zE+LkiHyWBWAGHJqsbxFko8J+78U34q+7imUUl
	YvqxUBqDMCdDRxVXd+zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX5n5-0000yE-Oy; Wed, 12 Dec 2018 14:47:11 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX5n2-0000wx-Dz
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 14:47:10 +0000
Received: by mail-pf1-x442.google.com with SMTP id z9so8984571pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=sN19sOJAgXqIh/Xw5W4LqYIsDRDpzgbdAarXMCE4msw=;
 b=K+TpKqvLaN7TYP48ABWktdYCk8yn0z/C4SpzNCtNMXAE21zhQliZ+OTANIExTaEKEa
 OxJUrGFfKlYtQQ/vuqgUoadd/8UhrlyGmIsjBmm35iIoUR5/MHKSVJiRujn9rge8hkA+
 OCNXuEa6S1H6CrC38hXN/+vQRi7oxMfakxLik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=sN19sOJAgXqIh/Xw5W4LqYIsDRDpzgbdAarXMCE4msw=;
 b=pumdIYqqmI8JrgFnJDu7gPez+w1oBapuxROgrwHdU9+V/l+FrjkHkgRjg1+qqfsCjR
 8qojKpoukRt9zcButT1vFBPLYkpeklPvyV9EK0zXuLvblBrPkxxlqXJSrsqwCkNgzY7B
 Cyr3fF5DFu3Mx7gTkfDhRYOtsB08B91fqCEG1LGASOggT2Wd5IofSs1sWmLB1NHChm4d
 49q92Y91k2c0YX4BdvqQBtpMV5EJKkMPwc1I2elEQeWi03S3MK+HvUA660DFClVe7Szn
 wZXPyE7GUKyCKBeE9oOuUldgpoVbNZNNxAI2XBIgLoEebYPOkRXh1vfSXCTRXeyQxYxC
 ojgA==
X-Gm-Message-State: AA+aEWblDOdY7WsqgI4k48trhIjCH0SCpWKDRz+KW5Azf+m0jC2lNPcp
 mSFFpmTFZRsB8fizTqyEP59U
X-Google-Smtp-Source: AFSGD/UoCrTMWYmn6BeOk5sdZCPFueZVQZuDIRjIVmrBXFQYy1NL7aZA5Pj4W5OByRjgc+Ug0h2zNQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr18485589pgq.387.1544626017185; 
 Wed, 12 Dec 2018 06:46:57 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e546:e5b2:257b:c83b:98e4])
 by smtp.gmail.com with ESMTPSA id x27sm41958565pfe.178.2018.12.12.06.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 06:46:56 -0800 (PST)
Date: Wed, 12 Dec 2018 20:16:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC
 architecture
Message-ID: <20181212144646.GA27625@Mani-XPS-13-9360>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
 <3e4b7143-6ed8-6006-cb07-d72bca40ce5f@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e4b7143-6ed8-6006-cb07-d72bca40ce5f@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_064708_465855_723EB732 
X-CRM114-Status: GOOD (  18.28  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andreas,

On Wed, Dec 12, 2018 at 02:53:42PM +0100, Andreas F=E4rber wrote:
> Hi Mani,
> =

> Am 10.12.18 um 18:35 schrieb Manivannan Sadhasivam:
> > Add MAINTAINERS entry for RDA Micro SoC architecture with myself
> > and Andreas F=E4rber as the maintainers.
> > =

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > =

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6c3fbbb361f8..6411fb222590 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1945,6 +1945,21 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  =

> > +ARM/RDA MICRO ARCHITECTURE
> > +M:	Andreas F=E4rber <afaerber@suse.de>
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> =

> I'd suggest you swap the two of us here, making you the primary
> maintainer. Or drop me, as I should be copied via linux-unisoc anyway.
> =

> I won't realistically have the bandwidth to drive review and more pull
> requests at the moment, with Realtek already stuck in irqchip regression
> for too long and LoRa making only slow progress.
> =


Okay, no issues. Will drop you from the MAINTAINERS entry so that you
won't get bugged.

Thanks,
Mani

> Regards,
> Andreas
> =

> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm/boot/dts/rda8810pl-*
> > +F:	drivers/clocksource/timer-rda.c
> > +F:	drivers/irqchip/irq-rda-intc.c
> > +F:	drivers/tty/serial/rda-uart.c
> > +F:	Documentation/devicetree/bindings/arm/rda.txt
> > +F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-i=
ntc.txt
> > +F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> > +F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> > +
> >  ARM/REALTEK ARCHITECTURE
> >  M:	Andreas F=E4rber <afaerber@suse.de>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > =

> =

> =

> -- =

> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
