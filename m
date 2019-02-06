Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B649C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:23:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD76C2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OTdwqSpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD76C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gM7N9T4Exgal2O8oWLl7Apaeuvd3CqdKc8LxDtPmt7M=; b=OTdwqSpVKXRRav
	q3/pbR4IgeBbYSvQVQhs0jnUrmnb8CSxzx4GVjxN928aMVSRYFSLB+0qoJzuM6cpOnIeMnLPvmxry
	kP3j6qSwVsR616RQG8gIcRHAu4BUfXFYYS4y42SqvYR8LDZDuygRnJcDQRr6agpGLoVaUktpXcH8K
	T/tnTFi7pdFMODVXKXphEsfPqrtNgMBlN6iXSaQWVSuCcPlHQN8Wc/ZakbE1dMhPYEfJC+kSlH3DR
	jRsyxIo3a2L4+BM1miY++k8DMr/OeI91CLcrESIrvH3qstxoYhN1JlGCSsJpopD4ZunFKc32ZETn2
	XDVG1Jpucd5tq8gJJRGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKMJ-0004bS-3m; Wed, 06 Feb 2019 10:23:11 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKM9-0004aE-8b
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:23:09 +0000
Received: by mail-ed1-f67.google.com with SMTP id f9so5378759eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 02:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mkK/rFiYpvS6KDVcBk/aBDujWnLAQbpRrcx/qdDdK7o=;
 b=uoavLLb5+aA/+EO1RMCVScwOk4Q5HHhCaIHcTd7u6rXv/PRO/d8nCul8SWS9Zh7+LW
 6Qk884pid127a3C04PM3gbcLERGgkRx2X+4yyqXrQSNbJkTZvyUIqrOaPMmss7d8Y25O
 GcsOiIc3M5+Bt0FBVtdmlCXlOGS2qJiPDjp1sn8dy7eDaivVtMFRVNVL5nBAERGI4njB
 NvQrIvv5tQXoeSAeROkudxvVMGdMsJUc3gCArDPr1CNcABPRBXDHPPPxjZLfXqC0Lc7L
 vSJg4U56hCgIulzCLu+9S3E3F6H0q5zblaqn42RhLHdY0y7/Pd+MTLcvtOgY+IaDOzEl
 RDoA==
X-Gm-Message-State: AHQUAub7cVo4Gbt5VGmwbraZA8g50WgZiMYJZiPExDoxzhAJRNnmFg7Z
 YanCILC5ug3Qnc4ZQy8Nwz5HWoZt0k0=
X-Google-Smtp-Source: AHgI3IYcBEefWmoTppWT46BGQuI9xD+P1znkqFV+EXR/CBir2/D9xPdELoq+83qIQ8vKni2M8zXzSw==
X-Received: by 2002:a17:906:1199:: with SMTP id
 n25mr880322eja.120.1549448578849; 
 Wed, 06 Feb 2019 02:22:58 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id i8sm1062985edg.21.2019.02.06.02.22.57
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 02:22:58 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id t200so2038988wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 02:22:57 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr2285328wmf.99.1549448577699;
 Wed, 06 Feb 2019 02:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
 <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
In-Reply-To: <CACRpkda45Zhopkk+P9-poDut-gJdJg5POPGSa_Rt_wqE24GGqg@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Feb 2019 18:22:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67m_yO42VrivTf9x3JvAE3DL4nUZzzXt2BMU_Xb=ZHDtg@mail.gmail.com>
Message-ID: <CAGb2v67m_yO42VrivTf9x3JvAE3DL4nUZzzXt2BMU_Xb=ZHDtg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias
 voltage setting on A80
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_022301_446429_01E54813 
X-CRM114-Status: GOOD (  22.50  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 4:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> > The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> > settings would make the affected peripherals inoperable in some cases,
> > such as Ethernet RGMII signals biased at 2.5V with the settings still
> > at 3.3V. However low speed signals such as MDIO on the same group of
> > pins seem to be unaffected.
> >
> > Previously there was no way to know what the actual voltage used was,
> > short of hard-coding a value in the device tree. With the new pin bank
> > regulator supply support in place, the driver can now query the
> > regulator for its voltage, and if it's valid (as opposed to being the
> > dummy regulator), set the bias voltage setting accordingly.
> >
> > Add a quirk to denote the presence of the configuration registers, and
> > a function to set the correct setting based on the voltage read back
> > from the regulator.
> >
> > This is only done when the regulator is first acquired and enabled.
> > While it would be nice to have a notifier on the regulator so that when
> > the voltage changes, the driver can update the setting, in practice no
> > board currently supports dynamic changing of the I/O voltages.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Hi Chen-Yu,
>
> thanks for the patch! I tried to apply it on the pinctrl devel branch
> (for v5.1) but it failed to apply, I assume because it depends on
> the fixes that I just sent to Torvalds.
>
> Shall we proceed like this that I merge v5.0-rc6 as soon as it is
> out and then try to apply this on top of that instead, so we get
> rid of this conflict?

Sure. That sounds like a good plan.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
