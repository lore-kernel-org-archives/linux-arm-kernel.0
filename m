Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD567C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A924F2192C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DeAWegrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A924F2192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FV0rUsUvGbLKaU6HvXf4qvoYcRBfWUBT+AbsPBdkcn0=; b=DeAWegrHjVnA5+
	oD/HwHUtyTBfZ2oqjJYp65haYYKZHdubqUUX5tN0pxK6FfLoVMW1ry7rRgYIgDlXtP+WsrN+1PTwZ
	nQ+mn3/CEe6/jSPn3sj6lrnbEvitXGzNR+tAESel/v9tCmwg1pHsi3u/NPekErFBUwr41C/cmQ1or
	lq5QdTlU2HQNx7+wRbhSE70k68+gW716xom6mEog7jZhhBdNVLtOhR0nTOPwIhNpEv3RpDxKvr488
	kKP3BC3BoNRNefCf48TKhEPA/EnMIeyqz6eaBz4VjV+pLweiRfJB5/Ah7+SaHCSK4seNyOPJb/st9
	j8OiutEaL1XrsccOcB1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZTp-0004rh-Jc; Fri, 15 Feb 2019 09:08:21 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZTm-0004rK-Az
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:08:19 +0000
Received: by mail-qk1-f195.google.com with SMTP id y140so5265363qkb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 01:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MPIreRSK6DmJz2mRCl9JZ2OSVv/7y/pNHnE2xSh7A+k=;
 b=G31HqkeA27wAK/VbRKLrxjiJG3mEW9TdNV+HGcdMh+Qgq9NNHswEmWSiA4ySi1d1/7
 Gv5TFp+Bo75qO2SZd/YhLjmE7YvRvHCixsDg8pPn/7NYo1Ty0AwfqOz06nwV5FADw1Sf
 oEIXT/SuH9zR1XszF2+SJsoBEqmyJNV05b8Jx4/0JjIt/tKXPWOqlb2gM8slXqiNcBtV
 pHkSCkSNTQXj7Egeavk2DaqBCB8GLTdLNgPQaO3u2FtCcLkWzeX8cCFYM1dtJiRGrHCH
 UpUBKkJHL5rOplO47AVX1ffHdaFbNkRqnEutquyE4OEdbb8t9PFmFFGiO8QV7Ap9yQxa
 sx3Q==
X-Gm-Message-State: AHQUAubbVfhJFXtqHfPk/fUDDKzNy8NXijGUwk3Yn6n/2oAhtQTXu5Fu
 THnWDCp72QFuYFdgivJYJf73n8+7CZynfW4BxtQ=
X-Google-Smtp-Source: AHgI3IbGeCS/DN1/wfaWNlS89+qz/pOl2ntww4TalN+INxV1984XJ0/oeJNSvNX68+DCwtroRcSap38Lcm/FfhvqKnc=
X-Received: by 2002:a37:d492:: with SMTP id s18mr5876769qks.343.1550221697225; 
 Fri, 15 Feb 2019 01:08:17 -0800 (PST)
MIME-Version: 1.0
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
 <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
 <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
In-Reply-To: <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 10:07:59 +0100
Message-ID: <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_010818_372058_CAB512D7 
X-CRM114-Status: GOOD (  19.40  )
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
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Fri, Feb 15, 2019 at 3:25 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
> On 2019/02/15 0:18, Arnd Bergmann wrote:
> > On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 13/02/2019 11:34, Sugaya, Taichi wrote:
> >>> Hi,
> >>>
> >>> On 2019/02/12 18:06, Daniel Lezcano wrote:
> >>>> On 08/02/2019 13:26, Sugaya Taichi wrote:
> >>>>> Add timer driver for Milbeaut SoCs series.
> >>>>>
> >>>>> The timer has two 32-bit width down counters, one of which is configured
> >>>>> as a clockevent device and the other is configured as a clock source.
> >>>>>
> >>>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> >>>>
> >>>> Do want me to take it through my tree?
> >>>>
> >>>
> >>> Yes, please.
> >>>
> >>> By the way, the patch series includes other sub-system drivers, so
> >>> should it be splitted into each driver patch ?
> >>
> >> Well usually changes are per sub-systems but in case of first submission
> >> you may ask linux-soc@ team to take all the patches together with the
> >> acked-by tags from those subsystems maintainer.
> >>
> >> Added in Cc: Arnd@ and linux-soc@
> >>
> >> I'll wait a bit before applying the patch you clarify this.
> >
> > Yes, I think merging them all together is best here.
> >
> > I saw the patches fly past but did not do a complete review,
> > but if all other review comments are addressed, I'd suggest
> > sending the entire series for inclusion to linux-soc@vger.kernel.org
> > with the Acked-by/Reviewed-by tags from subsystem maintainers
> > added in.
>
> Thank you for suggestion.
> OK. I will send the series to the ML with the Acked-by/Reviewed-by tags.

One correction: please send the patches to address "soc@kernel.org"
for inclusion.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
