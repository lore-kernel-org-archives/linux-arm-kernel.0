Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D84C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:19:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE2A2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAWLzTIg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="elJmfTmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE2A2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=llOlmVTwaXaQIHLpvCRRNQbhEU6h/u7X+Fsg2iZg/nw=; b=OAWLzTIgq+iED2
	BPuNgaEq3SFqJxjX6HVvjFV+Ty7h3d9ED0GWk4BnMfnh6aR+6f5yLXOQD1vjsNPns0xWIFTsxL499
	apz60sqxFkdpiaj8+PcU28X8x2qQbxN/MmqRg/NTeNVFawzZCW8P/NULvCcIKjh0Mhe9R9I+wL1ga
	iM+5MbJWPOLYC/3/Chdpt050bsYmXL7RFUrHGCuuLFYOAeRLF89ZWTh9CRGIU1eF8dRNusPT1PEJO
	HfcqS/eqybaB3MU7pn15VLjeE41PFxfuSa612HU2Z//44GHsGl7RaMzzj5dzmPqoNmQJNZnXOai6N
	Qv9l4KRZwVuJEA3PJIzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geDP2-0006Wj-08; Tue, 01 Jan 2019 06:19:48 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geDOw-0006VE-Vh
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 06:19:45 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so13274904plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 22:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
 :references:message-id:user-agent:subject:date;
 bh=YDMyhkckBPF9ap1EOCmaBF5RyGy54vfKRQ5wQkKQk7Q=;
 b=elJmfTmRWlDewwK3i2jpkvIIedEzaMOSzlR/dOP5MQiF/pRz4lm/1QJPIB4CgoDZGY
 3ZQzDpxEvx3KcrPXEWWU4rlpfFdvKUwZKz/cJ9CjMKLBDU0oHDEbDRKKc86mt8JQT1s7
 IuamQI9dnvYLxsTxfxnjTSnxlTL7gbhx5qFNJPhIlbWsPza2aZv8mhuKsRCXt/DSqh29
 QSvC0uE0PVE/doKI55twekBraUzBtRr0jFydVMAG36G54a89boW9t1urZ6s9J1UVWZG3
 f+HLV4JoOgAhmjaTny5YVLT/d9TUoCSmG/jdt6aVe4Dyy28GRSSZ3/h5jeKjV7KuuBVX
 5fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
 :in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=YDMyhkckBPF9ap1EOCmaBF5RyGy54vfKRQ5wQkKQk7Q=;
 b=Q7rxMiwlJWert7KufQFxc3uN8uHg6ovox8dfxsnEAl8jqy44dGyMbco/s8bcZqf4WN
 D1vqQ6njOy3O4u0Akc5nbzd88aVAdeWU8le/fRvqZAmdYgSKc5i7xlJ5Fnx+lbSEImTf
 Ay/7OTcKjVXTAf8xVg9QTiROqTiOpKJ2dL+eq0Ehh8BHsnwu+6ABXxjCz+dOlrvzbl9A
 9wy9cA2umXXneHVB8W+2ziWbGjutbcpkBHKFcTDYC4CSn8/mQVdwyVAil5Bj5tuqenQg
 HxKwbpJP9JFGwGE55fe+4uzwWZSYILUyMG73ugEVYA4CzZUwQd/cCugb4Z3uLDIklAtU
 nNDg==
X-Gm-Message-State: AJcUukd6IJv0w9bRoLRYx2fktIQeTfV7tCc9M59gMLcxURsjgdVqv6l7
 w9RomdqnUa12blWwB+XV4l94VA==
X-Google-Smtp-Source: ALg8bN7PSCoaM2T52sN5Ln3dXatoiIPOWtcFu3R8L7Kl1vjZk5jowdUO8J4YcbDwY1FNorGJoBV6GQ==
X-Received: by 2002:a17:902:9a41:: with SMTP id
 x1mr39157234plv.126.1546323576222; 
 Mon, 31 Dec 2018 22:19:36 -0800 (PST)
Received: from localhost (cpe-104-32-89-52.socal.res.rr.com. [104.32.89.52])
 by smtp.gmail.com with ESMTPSA id r187sm147197127pfc.63.2018.12.31.22.19.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 22:19:34 -0800 (PST)
MIME-Version: 1.0
To: Georgi Djakov <georgi.djakov@linaro.org>, Olof Johansson <olof@lixom.net>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
 <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
Message-ID: <20181231195820.65829.58455@resonance>
User-Agent: alot/0.7
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
Date: Mon, 31 Dec 2018 11:58:20 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_221943_162348_5DFD5449 
X-CRM114-Status: GOOD (  38.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 Maxime Ripard <maxime.ripard@bootlin.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, evgreen@chromium.org,
 ksitaraman@nvidia.com, DTML <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Georgi,

Happy new year! :-)

Quoting Georgi Djakov (2018-12-08 21:15:35)
> Hi Olof,
> 
> On 9.12.18 2:33, Olof Johansson wrote:
> > Hi Georgi,
> > 
> > On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>
> >> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> >> graphics, modem). These cores are talking to each other and can generate a
> >> lot of data flowing through the on-chip interconnects. These interconnect
> >> buses could form different topologies such as crossbar, point to point buses,
> >> hierarchical buses or use the network-on-chip concept.
> >>
> >> These buses have been sized usually to handle use cases with high data
> >> throughput but it is not necessary all the time and consume a lot of power.
> >> Furthermore, the priority between masters can vary depending on the running
> >> use case like video playback or CPU intensive tasks.
> >>
> >> Having an API to control the requirement of the system in terms of bandwidth
> >> and QoS, so we can adapt the interconnect configuration to match those by
> >> scaling the frequencies, setting link priority and tuning QoS parameters.
> >> This configuration can be a static, one-time operation done at boot for some
> >> platforms or a dynamic set of operations that happen at run-time.
> >>
> >> This patchset introduce a new API to get the requirement and configure the
> >> interconnect buses across the entire chipset to fit with the current demand.
> >> The API is NOT for changing the performance of the endpoint devices, but only
> >> the interconnect path in between them.
> >>
> >> The API is using a consumer/provider-based model, where the providers are
> >> the interconnect buses and the consumers could be various drivers.
> >> The consumers request interconnect resources (path) to an endpoint and set
> >> the desired constraints on this data flow path. The provider(s) receive
> >> requests from consumers and aggregate these requests for all master-slave
> >> pairs on that path. Then the providers configure each participating in the
> >> topology node according to the requested data flow path, physical links and
> >> constraints. The topology could be complicated and multi-tiered and is SoC
> >> specific.
> > 
> > This patch series description fails to describe why you need a brand
> > new subsystem for this instead of either using one of the current
> > ones, or adapting it to fit the needs you have.
> > 
> > Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?
> 
> The devfreq subsystem seems to be more oriented towards a device (like
> GPU or CPU) that controls the power/performance characteristics by
> itself and not the performance of other devices. The main problem of
> using it is that it's using a reactive approach - for example monitor
> some performance counters and then reconfigure bandwidth after some
> bottleneck has already occurred. This is suboptimal and might not work
> well. The new solution does the opposite by allowing drivers to
> express their needs in advance and be proactive. Devfreq also does not
> seem suitable for configuring complex, multi-tiered bus topologies and
> aggregating constraints provided by drivers.

[reflowed Georgi's responses]

Agreed that devfreq is not good for this. Like any good driver
framework, the interconnect framework provides a client/consumer api to
device drivers to express their needs (in this case, throughput over a
bus or interconnect).

On modern SoCs these topologies can be quite complicated, which requires
a provider api.

I think that a dedicated framework makes sense for this.

> 
> > The series also doesn't seem to provide any kind of indication how
> > this will be used by end points. You have one driver for one SoC that
> > just contains large tables that are parsed at probe time, but no
> > driver hooks anywhere that will actually change any settings depending
> > on use cases. Also, the bindings as posted don't seem to include any
> > of this kind of information. So it's hard to get a picture of how this
> > is going to be used in reality, which makes it hard to judge whether
> > it is a good solution or not.
> 
> Here are links to some of the examples that are on the mailing list
> already. I really should have  included them in the cover letter. 
> https://lkml.org/lkml/2018/12/7/584
> https://lkml.org/lkml/2018/10/11/499
> https://lkml.org/lkml/2018/9/20/986
> https://lkml.org/lkml/2018/11/22/772
> 
> Platforms drivers for different SoCs are available:
> https://lkml.org/lkml/2018/11/17/368
> https://lkml.org/lkml/2018/8/10/380
> There is a discussion on linux-pm about supporting also Tegra
> platforms in addition to NXP and Qualcomm.

Just FYI, Alex will renew his efforts to port iMX over to this framework
after the new year.

I honestly don't know if this series is ready to be merged or not. I
stopped reviewing it a long time ago. But there is interest in the need
that it addresses for sure.

> 
> > Overall, exposing all of this to software is obviously a nightmare
> > from a complexity point of view, and one in which it will surely be
> > very very hard to make the system behave properly for generic
> > workloads beyond benchmark tuning.

Detailed SoC glue controlled by Linux is always a nightmare. This typically
falls into the power management bucket: functional clocks and interface clocks,
clock domains, voltage control, scalable power islands (for both idle & active
use cases), master initiators and slave targets across interconnects,
configuring wake-up capable interrupts and handling them, handling dynamic
dependencies such as register spaces that are not clocked/powered and must be
enabled before read/write access, reading eFuses and defining operating points
at runtime, and the inevitable "system controllers" that are a grab bag of
whatever the SoC designers couldn't fit elsewhere...

This stuff is all a nightmare to handle in Linux, and upstream Linux still
lacks the expressiveness to address much of it. Until the SoC designers replace
it all with firmware or a dedicated PM microcontroller or whatever, we'll need
to model it and implement it as driver frameworks. This is an attempt to do so
upstream, which I support.

> 
> It allows the consumer drivers to dynamically express their
> performance needs in the system in a more fine grained way (if they
> want/need to) and this helps the system to keep the lowest power
> profile. This has already been done for a long time in various
> different kernels shipping with Android devices, for example, and
> basically every vendor uses a different custom approach. So I believe
> that this is doing the generalization that was needed.

Correct, everyone does this out of tree. For example:

https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm/mach-imx/busfreq-imx.c?h=imx_4.14.62_1.0.0_beta

See you in 2019,
Mike

> 
> > Having more information about the above would definitely help tell if
> > this whole effort is a step in the right direction, or if it is
> > needless complexity that is better solved in other ways.
> 
> Sure, hope that this answers your questions.
> 
> Thanks,
> Georgi
> 
> > 
> > -Olof
> > 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
