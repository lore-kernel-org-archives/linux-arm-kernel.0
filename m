Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA020C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7378420868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTZxx3E2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xzKkLNSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cR3oNUD1wfFCSnJf/Y1VYuOkK7vsqZQ4ZZ/P2EWjaO4=; b=tTZxx3E2mBDS/V
	2NcsBjep8SWMaQ9myBDs62Doi72tc2/WuVlPUtW/2au0cw6WpwxO7/TCZo8+NVqscpoGvTmCIkhNl
	iqGFxa7nuPSSUGhYM1TEx2fmuumTXwUathI7F+U+FWysGCx14fPVvjJkno1tYzwdsnUv5bcdqwOrA
	5TczbWc0I6pVX7CNzsrSA5UYyaBNZH0e2lTNLuydeuTsBM4jMAo2uxT6txy5PZ7xk12aMm/dMf2we
	scXtnEOKWmemxvYCKYy+TKUzOTb9CJsCbZN/nCiLjLi8fDvk7e+MD5lduXpBsg7DY14f2ZhmG6Wbz
	0KOKg3QyoL9LW+Y1gGTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSXCH-0006Ng-CI; Fri, 30 Nov 2018 01:02:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSXCE-0006Ma-IO; Fri, 30 Nov 2018 01:02:19 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 673A72146D;
 Fri, 30 Nov 2018 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543539727;
 bh=KK5k0pzTObpUzakdBmfER3QGnjqssQrfk33KN4O3inQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xzKkLNSmukAla+88rHZKmE9E9a5zQjmrR8tYLKMW5kZ/7MED1cPChm2mVFe2vSJKP
 KSBR5L9uZQAYSa+7myQwmEsG4pxKpRNRdNkbVBIJ/QzH04S+nvus99Ghmptzs8zuVf
 10UVArGMwCbWI7Rh83mOt2jFJpbEh34pZBw+DYrU=
Received: by mail-qt1-f182.google.com with SMTP id z16so4251847qtq.4;
 Thu, 29 Nov 2018 17:02:07 -0800 (PST)
X-Gm-Message-State: AA+aEWZoD3PgjJhEuMI9YfdFpmn3OXIoi/NcQlYlACJnPfjqfGe+Em5A
 MGtfeXGpMzdWzw5w7IU1uQBht7uLak/vl/7rTQ==
X-Google-Smtp-Source: AFSGD/W4VOgcKPF/a6OCA+UTYMqM4yLrPXG5MeJ/ZLol2DMMUoCzh2YzzYeIybG+ZCUNMgCpofrw+HdO5X8RLw6T/+8=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr3723310qvb.218.1543539726606; 
 Thu, 29 Nov 2018 17:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
 <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
In-Reply-To: <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 29 Nov 2018 19:01:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Message-ID: <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_170218_634973_29D3C8A9 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 6:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Stephen Boyd (2018-11-07 10:37:31)
> > appropriate structure with to_platform_device() or to_i2c_client()?
> >
> > So the example would become
> >
> >   struct of_driver_probe_func {
> >         int (*probe)(struct device *dev);
> >   };
> >
> >   struct of_driver_probe_func mtk_probes[] = {
> >         mtk_probe1,
> >         mtk_probe2,
> >         mtk_probe3,
> >   };
> >
> >   struct platform_driver mtk_driver = {
> >         .driver = {
> >                 .name = "mtk-foo";
> >                 .of_match_table = mtk_match_table,
> >                 .of_probes = &mtk_probes;
> >         },
> >   };
> >
> > And the probe functions might need to container_of() the device pointer
> > to get the struct they know they need. The probe function could also be
> > added to of_device_id and then we would have to look and see if that
> > pointer is populated when the device is matched in generic device code.
> >
>
> I guess I'll go down the path of extending the of_device_id structure?

Unfortunately, I don't think you can change of_device_id as it's part
of the kernel ABI.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
