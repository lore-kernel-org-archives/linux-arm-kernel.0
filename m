Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E363BC282C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:38:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E59217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bmz4I+YQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG7fmttc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E59217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VhuKdWHwjFdzUE9PXLS7q8KiIhmjWA0KWHgiCU9rgZ8=; b=Bmz4I+YQAhjccx
	w95wUdLpTTLx7oEOKggmqa/Ok+qWcU12Zg/vepY1fUV/fo1FXi2mrpVk5LlFdwVzmx+/ANTSfoO7z
	FWM5WVd810ju7Z+3RU2aCnXVRNyIPLh0akJwCONAVsNqWJy6FXa20hUV/+7o7Rx1yBZVtJVWhd/Vj
	ujpZ1pwdrfDoGNm87rwE0Yz0f36Gbw4qXIR7SLM62hr4q4EBzguLo5f6/UfFC7YIXYeuwCAHtknzu
	5ZtmZBglQMRqi+0bMkOGkD1PuoSJQLrYWu0diuizPC9Z9g8wsWdpL/Biop2PFtsnb3ZXTGGQTo0Do
	wGi7852xJ/yq9WamibJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnhpu-0007Kb-8V; Sun, 27 Jan 2019 10:38:46 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnhpr-0007KH-Pb
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 10:38:45 +0000
Received: by mail-it1-x143.google.com with SMTP id p197so15569202itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ybBP+IUw0wA6yvj6uUeWUOT7wvGHqpFpF4qMfyRcWAM=;
 b=bG7fmttcrAu/Ib97423dO1HX/u6b6j2OiH72pNWCm9YsSPr+CkbvNLaO0+qS0NdiWH
 HfFdW3rJnBrpDG6II8cyG/0GS8Ugk4WYPOgCdZX6GVfQsIaK/vivWBNslH+jaiEhnQR6
 f7sE60jq+WEeDxqydzM+HAOVSFy3XOfkadkxnLT5t+U5xQQz43RFKYjx0h6mGN9394Lu
 bzPX2EKfQZ7tL05oRBJtYqNT+q1e21AmnGOLw5bUoACAmhXAeUD2xFtroammMMN710vz
 fBy+yeKZ1COMftUdn7E0nj1C9LY5Z+8pwth2zEnl0RmbyQlSuadtA4eTnyLHX3itaBQk
 Tt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ybBP+IUw0wA6yvj6uUeWUOT7wvGHqpFpF4qMfyRcWAM=;
 b=Q7dZLuzM82+Ca+enkGv9WqviAAQZ/Enk1uAUC07wKEXOXngBk18yWobTXZGUnjISFD
 BUQIuKuoVv4a05lRPmIEIDyjGyAw+RDk1poNg3sSKYIjJVrGniY5+JF+CdkbL5FkAqbf
 59wCOsoPZv4LWa/leIycYZFQy73tmtf9NSU2NYoZz5Or1WhmZiLr5Q9rBNSRsiVYengM
 5GRNDyYT9NlSK6bS1C1BOOIVjoWyILQUqPKb0OVghy58xYWzK18XIUxZCrFcAUfe2klN
 MUiGSy4IFLpbJYPD8r2wILYj59n0GL9hatK7tEl7zyjlBQyHGGnKsGMDPy2MWjXKZcNk
 mhzA==
X-Gm-Message-State: AJcUukcOrkumNPkAtEROdMKnnW7BOPtFA5qVx93f3NGPI/wIrSbm61O/
 2JVYUzsg10OJ2srNS3Ol1+TukrqGXWwJdK/56hCiSqA7
X-Google-Smtp-Source: ALg8bN6auXmMl/eBky+INoX6daFtX2dvE4FectWVTRTKUn3QD9JPQcoJApENBpBky3q1IeDwMvvAWPCFL9rx9wfzzjc=
X-Received: by 2002:a24:80d2:: with SMTP id g201mr8084982itd.63.1548585520921; 
 Sun, 27 Jan 2019 02:38:40 -0800 (PST)
MIME-Version: 1.0
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1547801609.2626.5.camel@pengutronix.de>
 <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1547806960.2626.9.camel@pengutronix.de>
 <AM0PR04MB42111FE266342A2C2EAECC3580980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548154758.2465.20.camel@pengutronix.de>
 <AM0PR04MB4211B9003857795EBC79541480980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548161549.2465.24.camel@pengutronix.de>
 <AM0PR04MB42114F3D625CC48343EA427080980@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <1548412956.28802.41.camel@pengutronix.de>
In-Reply-To: <1548412956.28802.41.camel@pengutronix.de>
From: Dong Aisheng <dongas86@gmail.com>
Date: Sun, 27 Jan 2019 18:38:29 +0800
Message-ID: <CAA+hA=TmBBTaNtmWFEX62LViwPKsBTvv-jWcwU7a7K7yh=JhYQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_023843_857717_2B2D934B 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lucas,

[...]

> > > The fsl,irq-groups property is exactly your NINT32 parameter above. I just
> > > wrongly assumed that it's always in multiples of 64, as that's what the
> > > i.MX8MQ DCSS irqsteer module looks like. We should fix this and be done with
> > > it.
> > >
> >
> > No, not exactly the same thing. Using group will confuse people that the group is 32.
> > However, internally Group is fixed 64 interrupts although it may not use all the
> > 64 interrupts. E.g. 32 interrupts.
> > See CHn_MINTDIS register which is also defined fixed to 64.
> >
> > The two HW parameter for integration is already very clear. We should use interrupts
> > Number for the channel. Not group.
>
> Okay, I see that the name irq-groups is confusing for you. But then I
> find the -per-chan naming confusing.
>
> So given that we seem to agree to split each channel into it's own DT
> node, there is no need to name the property "something-per-chan", as
> it's implied by the split DT nodes that all properties in one node are
> referencing a channel.
>

Double checked with IP module owner by looking into the RTL code,
writes to CHANnCTL registers have no effect.
This register is reserved and the doc will be updated.
Verified on both MX8QXP and MX8MQ.

All channels are isolated and have independent programming model.
So it will be okay to define them separately in device tree.

> May I suggest to name the property "fsl,num-irqs"?

Sounds good to me.

Regards
Dong Aisheng

>
> Regards,
> Lucas
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
