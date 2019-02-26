Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D99C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:28:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8DD2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hffu5Nqu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUk1ImZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8DD2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wygVQhSPabQFVzXLGKzh8SeEQTknOErTu+JU5+DTJA=; b=Hffu5NquBOZCaX
	BKfL0q65j4lVwV3oTdfjz38DxIXzuQwzvHGxfzlYIXQ6nTZKr+JAeDjWfrwaAbaO0sZoPATKfdr93
	F5M1hD9a+4OLTtuNQb8vnFx7F7j02h57tcQ2txwyG21kaSib131KFC9o3gBo5bHAWreqtuwFKqA5P
	E2amna58adi7/L2hktovG1GSabwmYiG3uxavah9KBmj/WXAHNVaUnU6Hwgb70XOFQSbwKojEacRBy
	YPn9jRDEKqdrvbtM0p1eyCXTuMIbOGy5L2gUovZCxhZqDJKrlGa8fKhERSVD0V0vBd2+PmCPtC6K6
	Kzdi18SLpWebDoQFg7jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylCi-0001DG-9F; Tue, 26 Feb 2019 22:28:00 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylCe-0001CO-5A
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:27:58 +0000
Received: by mail-pl1-x643.google.com with SMTP id p19so6924703plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hAsU8UQX3DVaACmBeu4EA5s08dMiJ4hFaMZIG7ClyoI=;
 b=PUk1ImZMGFyrzGO9Q9fC2P4YK/ffSpKobD2kp21P2hlr3b0rdCWcOcZdOxee3YWaY/
 6/3vx/vdlRLtXU+MCfKSQhM5AsWDERIJQoiuOq7UJMUWcik3WpbiLOBAI8dVTV5GO9K2
 Lc+rJ941tawXhzmtU4+wQI1QnvAMf/KURiQUjpokp9+sSMLBTEnyrHqrqvmw2+hjmuQ0
 LfIQDk91P4d/bj5cm4X3E0O+DwUuquSMubSJ2Va14xUPwCiteiCycrBwhhiI1tnco9J6
 AbVkwf0zOD36mLBUKNFDvCO86Ezo9xFRrs7qMhkX9s3zziso0TFBUa7RiTIECd0PFKxz
 y0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=hAsU8UQX3DVaACmBeu4EA5s08dMiJ4hFaMZIG7ClyoI=;
 b=EKjlN3ZIN4v+sftNsYZQo+VaD7LCuQzA/UP73+m8mqHEg7YOyNEB3sKt26Xgvx4xwG
 8LhoeB/1rFiNXQtnRtMjhIrbGGhOS2KB+ppuGBiofLqOfp8CgqTm+0Zeb5n5sEfirtY1
 JPR6Rs2X4NxQnjUDpdOFoopppqFiJjw7d17XpNB8fUuI/JY5K3kJHQ4UsNBxJdGWrntv
 qMnv6p9VpiGuamr1kLYvvAcboA04bOlZHFZ7mrLy02ZksafzCtyOgJt2+UmMjQKhAv0n
 OLHSM/LpN4xxZC55ag5v8QIzJpBflXFygVs//fQmdbSUC6/X6ARjqUljsa6yaPa185sN
 27wA==
X-Gm-Message-State: AHQUAuY22flZKkVVmnYK/c0x2gIxp1E3PEsrLafp4UPiyiTYIHJ6E8z1
 Uzopcv2+XCYnSF8KP31vMTE=
X-Google-Smtp-Source: AHgI3IbTwiFnak3M1I2Lg0X0HrBlCqoWaO/sbk+A5KICHveP7e3Fwu1zQ6GbGDJTk693fFrKto+XdA==
X-Received: by 2002:a17:902:1009:: with SMTP id
 b9mr27573080pla.42.1551220072536; 
 Tue, 26 Feb 2019 14:27:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c18sm4706425pfo.44.2019.02.26.14.27.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 14:27:51 -0800 (PST)
Date: Tue, 26 Feb 2019 14:27:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Message-ID: <20190226222750.GA30985@roeck-us.net>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_142756_201446_1BEA6A99 
X-CRM114-Status: GOOD (  19.09  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>, Anson Huang <anson.huang@nxp.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 03:34:12PM -0600, Rob Herring wrote:
> > >
> > > I think Rob suggested that the SCU parent driver should instantiate the
> > > watchdog without explicit watchdog node. That would be possible, but it
> > > currently uses
> > > devm_of_platform_populate() to do the instantiation, and changing that
> > > would be a mess. Besides, it does sem to me that your suggested node would
> > > describe the hardware, so I am not sure I understand the reasoning.
> 
> It would just be a call to create a platform device instead. How is that a mess?
> 
> It's describing firmware. We have DT for describing h/w we've failed
> to make discoverable. We should not repeat that and just describe
> firmware in DT. Make the firmware discoverable! Though there are cases
> like firmware provided clocks where we still need something in DT, but
> this is not one of them.
> 

It requires extra code where an added DT node would accomplish the same.
It requires a mix of DT nodes for existing devices plus extra code for
newly added devices. To me that looks like a revert to old platform code,
which was replaced with DT descriptions over the last several years.

But then if that is where things are going, who am I to argue.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
