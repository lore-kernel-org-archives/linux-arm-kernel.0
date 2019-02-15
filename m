Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2699C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:14:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E244218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2+5M7Ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E244218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kkVv+LEAJyN/DFDoBkBC87Sc+Y2xvXZumnaiAITuFYY=; b=d2+5M7Abd2FP0S
	eld9/9OtJN/fRurH5uoMjDQSvfqBkmMTBPfvA1u+BKSrtz+6w0QNVHWRHADvOs3ADHJTp3f4ytxPK
	Dg21Kyd+/iZy/IleVMqasUwTUfBqe+HImjK+dL4wfLuEUDWvddNSONVw9T+EwAljItwcdUYrG8eHi
	RYXP53tCpaLnhPr+fCcvg7ogOeQSja4oD623AQ4++UUiwnwwQxIYeAt7SuWJf8UC85hRXSlUMKVQT
	GDysSHGgUBvgpdQnk8DhsFw4xVO+SsHvPIsrhaCzOuLoKmg2joTaPWgjYbNvznuzVck3XCDRdHAfq
	l94JZmExS28lpSYdDZTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudK8-00080d-AD; Fri, 15 Feb 2019 13:14:36 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudK3-0007zM-PJ
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:14:34 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 15 Feb 2019 22:14:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B60016117D;
 Fri, 15 Feb 2019 22:14:28 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP;
 Fri, 15 Feb 2019 22:14:28 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Fri, 15 Feb 2019 22:14:28 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Fri, 15 Feb 2019 22:14:28 +0900
From: <sugaya.taichi@socionext.com>
To: <arnd@arndb.de>
Subject: RE: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
Thread-Topic: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
Thread-Index: AQHUv6l5WxG4u1Q7vEyLFPML69i0XKXbTjSAgAGq3YCAAdg9gIAACa+AgAC6TYCAAHBngIAA24mg
Date: Fri, 15 Feb 2019 13:14:27 +0000
Message-ID: <9b1543a25ce34affa8f0301a7505196a@SOC-EX02V.e01.socionext.com>
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
 <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
 <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
 <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
In-Reply-To: <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.3.2
x-shieldmailcheckerpolicyversion: POLICY180220
x-originating-ip: [10.213.24.1]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_051432_172243_86D870E7 
X-CRM114-Status: GOOD (  23.90  )
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
Cc: kanematsu.shinji@socionext.com, masami.hiramatsu@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 jaswinder.singh@linaro.org, tglx@linutronix.de, orito.takao@socionext.com,
 arnd.bergmann@linaro.org, linux-soc@vger.kernel.org,
 kasai.kazuhiro@socionext.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Arnd Bergmann
> Sent: Friday, February 15, 2019 6:08 PM
> To: Sugaya, Taichi/菅谷 太一
> Cc: Kanematsu, Shinji/兼松 伸次; Masami Hiramatsu; Daniel Lezcano;
> Linux Kernel Mailing List; Kasai, Kazuhiro/笠井 一洋; Jassi Brar; Orito,
> Takao/織戸 誉生; Arnd Bergmann; linux-soc@vger.kernel.org; Thomas
> Gleixner; Linux ARM
> Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut:
> Introduce timer for Milbeaut SoCs
> 
> On Fri, Feb 15, 2019 at 3:25 AM Sugaya, Taichi
> <sugaya.taichi@socionext.com> wrote:
> > On 2019/02/15 0:18, Arnd Bergmann wrote:
> > > On Thu, Feb 14, 2019 at 3:44 PM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 13/02/2019 11:34, Sugaya, Taichi wrote:
> > >>> Hi,
> > >>>
> > >>> On 2019/02/12 18:06, Daniel Lezcano wrote:
> > >>>> On 08/02/2019 13:26, Sugaya Taichi wrote:
> > >>>>> Add timer driver for Milbeaut SoCs series.
> > >>>>>
> > >>>>> The timer has two 32-bit width down counters, one of which is
> configured
> > >>>>> as a clockevent device and the other is configured as a clock
> source.
> > >>>>>
> > >>>>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> > >>>>
> > >>>> Do want me to take it through my tree?
> > >>>>
> > >>>
> > >>> Yes, please.
> > >>>
> > >>> By the way, the patch series includes other sub-system drivers,
> so
> > >>> should it be splitted into each driver patch ?
> > >>
> > >> Well usually changes are per sub-systems but in case of first
> submission
> > >> you may ask linux-soc@ team to take all the patches together with
> the
> > >> acked-by tags from those subsystems maintainer.
> > >>
> > >> Added in Cc: Arnd@ and linux-soc@
> > >>
> > >> I'll wait a bit before applying the patch you clarify this.
> > >
> > > Yes, I think merging them all together is best here.
> > >
> > > I saw the patches fly past but did not do a complete review,
> > > but if all other review comments are addressed, I'd suggest
> > > sending the entire series for inclusion to linux-soc@vger.kernel.org
> > > with the Acked-by/Reviewed-by tags from subsystem maintainers
> > > added in.
> >
> > Thank you for suggestion.
> > OK. I will send the series to the ML with the Acked-by/Reviewed-by tags.
> 
> One correction: please send the patches to address "soc@kernel.org"
> for inclusion.
>

I got it!

Thanks,
Sugaya Taichi

 
>       Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
