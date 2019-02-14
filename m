Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA738C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF3B2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6FlfTAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF3B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cy6p18rvWbPDW9JFeRV7qtTySvZNKQSokFGF/y1hsnA=; b=q6FlfTArFg68gS
	GBC8CwVG0EJYz1/SmvBEFyze/OoNysqpJGYoaQZcWkj1rnUAmeZ9aWPR0WU0NdwOMIfDnYwCd7utZ
	l152VpZtPuF2aJIhvMXBgcfsESSX13LCdHuvbDC3/nUeavdurUh4zbiDXlr8HHQqqEYvq4RDvtX8m
	0brbPFV39wnskYXBrmTk8uLOS6bI+hLGzA0Kh3MFTH5o8t3Nkk6cRY+CxMH2d4ULq2MUu3+KyyaXY
	rUICJisbr29IOuloDBDiTyeIS6uJJtGgfYA5Tvf+lAjZEvK4qd24PjYmpupOHfqV85sVKr8ZOFmU7
	SLibkL3Istgb+mkIEhKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guInF-0007KL-M7; Thu, 14 Feb 2019 15:19:17 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guInB-0007Jz-CP
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:19:16 +0000
Received: by mail-qt1-f195.google.com with SMTP id z39so7269141qtz.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 07:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L2jDvgeYI07tNG5Owhw2pu2NCO5S1JykUibenL/XOXU=;
 b=ty3ReEc8DwENoQEkcn/egiTb/C2kKyNfSm2jgkGWaS6Z6g3mJwNJKd4JTCnQrGdViW
 WEw6Izlhtu6LqwiQiT2TJ4XODC3mh7NoXZd8cnhX7HMLIQ0FPbBE+12YcjRq7HcOU5CS
 CtAFTbTOYZ5MLTkImMNU0nDNZPO6AAoaJwAujyas3COK3594y6WKqA3lEJV5ziWdQYyi
 bWY72mAJtoG4XspORGagxFr/RCUo8fP4McoQgFLz997iMiXR4m2Jh3QwPQnSsm2uBN6b
 aEFdIM1aLkuZGcU78SxjgAPf9Ko7+2xT+KFTQFbH/3H/Vnjksx9higdMBkk1mmjbeES+
 S9RA==
X-Gm-Message-State: AHQUAuajsCgJtV2AG1RLvZMWIMM4w4KgWWyr6mYxie5YEpm6oQF7tIkU
 Fkfbpl9XNfhmkIWLjJ/TKm05FOr7zpn5ea/HpIw=
X-Google-Smtp-Source: AHgI3IbJ5kqd7VYoE4Ijv0+wjKEkrfbslEv9L8SgDohBSE1FjjnstcYOPqInxE79z/H/vHEVCdciN0a77rNt50kK7cs=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr3543474qta.152.1550157551498; 
 Thu, 14 Feb 2019 07:19:11 -0800 (PST)
MIME-Version: 1.0
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
In-Reply-To: <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Feb 2019 16:18:53 +0100
Message-ID: <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_071913_421116_D032AFA1 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, "Sugaya,
 Taichi" <sugaya.taichi@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Arnd Bergmann <arnd.bergmann@linaro.org>, linux-soc@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/02/2019 11:34, Sugaya, Taichi wrote:
> > Hi,
> >
> > On 2019/02/12 18:06, Daniel Lezcano wrote:
> >> On 08/02/2019 13:26, Sugaya Taichi wrote:
> >>> Add timer driver for Milbeaut SoCs series.
> >>>
> >>> The timer has two 32-bit width down counters, one of which is configured
> >>> as a clockevent device and the other is configured as a clock source.
> >>>
> >>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> >>
> >> Do want me to take it through my tree?
> >>
> >
> > Yes, please.
> >
> > By the way, the patch series includes other sub-system drivers, so
> > should it be splitted into each driver patch ?
>
> Well usually changes are per sub-systems but in case of first submission
> you may ask linux-soc@ team to take all the patches together with the
> acked-by tags from those subsystems maintainer.
>
> Added in Cc: Arnd@ and linux-soc@
>
> I'll wait a bit before applying the patch you clarify this.

Yes, I think merging them all together is best here.

I saw the patches fly past but did not do a complete review,
but if all other review comments are addressed, I'd suggest
sending the entire series for inclusion to linux-soc@vger.kernel.org
with the Acked-by/Reviewed-by tags from subsystem maintainers
added in.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
