Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77884C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:16:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468D720831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWPTbkD1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6ZPR6qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468D720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQ3DAiwr8AK3WH5N6URud3Tu7+eu7eRhxJNe8R5kZWk=; b=EWPTbkD1zzIEMx
	uB8cwClTbVx+eF7h4NGnHjErD2kMLmSyAGPBiTFU6NnQIwp14G2x8rBKJ3Dj+aJdChSQpQOhFnv5a
	Ddr7pdsHOLPOIcP8zFJtEl899z+gbZ2+9qhEZA+Yk7rDuaIHcOOobEzt9dMZBP798M7+LNzC576y5
	NlNEc5rehPfNTOX4MR4YwBdRHSYmmk5gGCbIskaQpBiYjz0tCMFtaUHwYHSISvZ2JS39FOc8q9uIq
	pW9dg8snY4X68VEmg1XxBS/aWHdE4+R874snf3Y+ZvG0QiYFaS9Nko7ofoWp9de55WjaYZ1zfpUaG
	LLrEAcbilq3wPOFwqEJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVrRe-000788-CD; Sun, 09 Dec 2018 05:15:58 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVrRZ-00077F-T5
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 05:15:55 +0000
Received: by mail-wm1-x342.google.com with SMTP id y185so4118988wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 21:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=v0xu1+R6NFUqkJT3afutXkCazmWK14VeE+J0TDJ6T5s=;
 b=h6ZPR6qwVTKR7p1oQdxAo4qfzi61Iq09PhJe9WxyDBhxBacakQPk8xW4wj6Mi88bws
 jMywYApRodJwxxZeczOJwfdw9NCIo3HKFNE7WzCdOmbiU0eKUNh8kcTCMj4SfzDW4Az4
 Y6L+ykVULSfBO0Q2CPSAEP2IJbWaonOVQZoRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v0xu1+R6NFUqkJT3afutXkCazmWK14VeE+J0TDJ6T5s=;
 b=FxLFNvhMne758xo1v+LDyLbUUzcTYQM0MZjCDlLq+Dp+ArZeCSCJZO4YRfx66/O6PL
 S/VzO92K9xvh8IQEKMwEWCtZugtV9HDceFseL5b+chQqMpQpLUN06rdINBHUI1m1RboX
 rSkvXuJv08+VXucDMt9GJrHkJ9KzVvN1IY8rNwAWjWQl2RFrzyjOqRt0gwcO2Vm1mWsR
 qvJZtJB8FgbX22HqTEsICaa17JI7LVrS4O8c3Zs83Q6fXQen84uDYTXVZzwXSsCwtL/E
 JH1Vwk8PUDDf8XPElT1cJFauRT28eoww7ONWSjGPMTnZSBFYpcw6tDlrmv5wipRg060S
 QyGA==
X-Gm-Message-State: AA+aEWa5fcvljzAQmytc7aymkXJVIzGJHBTL/Lpdgwrzh+RWa1lGwBOG
 hKiztntpOmb4HcO7WpGqD0YIxg==
X-Google-Smtp-Source: AFSGD/W4bClQPy9VQHPzn3F5iZXaxqMHJAk6o5a88OOegVLNvMgzAqJSzlKynDBvrTgVupYUpz3PCg==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr7179090wmg.13.1544332541491; 
 Sat, 08 Dec 2018 21:15:41 -0800 (PST)
Received: from macbook.djakov.com ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id h129sm15485147wma.0.2018.12.08.21.15.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 21:15:40 -0800 (PST)
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
To: Olof Johansson <olof@lixom.net>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
 <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
From: Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <19e55a84-08d9-8cfa-02cb-be963f08ca61@linaro.org>
Date: Sun, 9 Dec 2018 07:15:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_211553_943986_133F9B24 
X-CRM114-Status: GOOD (  28.50  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
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

Hi Olof,

On 9.12.18 2:33, Olof Johansson wrote:
> Hi Georgi,
> 
> On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
>> graphics, modem). These cores are talking to each other and can generate a
>> lot of data flowing through the on-chip interconnects. These interconnect
>> buses could form different topologies such as crossbar, point to point buses,
>> hierarchical buses or use the network-on-chip concept.
>>
>> These buses have been sized usually to handle use cases with high data
>> throughput but it is not necessary all the time and consume a lot of power.
>> Furthermore, the priority between masters can vary depending on the running
>> use case like video playback or CPU intensive tasks.
>>
>> Having an API to control the requirement of the system in terms of bandwidth
>> and QoS, so we can adapt the interconnect configuration to match those by
>> scaling the frequencies, setting link priority and tuning QoS parameters.
>> This configuration can be a static, one-time operation done at boot for some
>> platforms or a dynamic set of operations that happen at run-time.
>>
>> This patchset introduce a new API to get the requirement and configure the
>> interconnect buses across the entire chipset to fit with the current demand.
>> The API is NOT for changing the performance of the endpoint devices, but only
>> the interconnect path in between them.
>>
>> The API is using a consumer/provider-based model, where the providers are
>> the interconnect buses and the consumers could be various drivers.
>> The consumers request interconnect resources (path) to an endpoint and set
>> the desired constraints on this data flow path. The provider(s) receive
>> requests from consumers and aggregate these requests for all master-slave
>> pairs on that path. Then the providers configure each participating in the
>> topology node according to the requested data flow path, physical links and
>> constraints. The topology could be complicated and multi-tiered and is SoC
>> specific.
> 
> This patch series description fails to describe why you need a brand
> new subsystem for this instead of either using one of the current
> ones, or adapting it to fit the needs you have.
> 
> Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?

The devfreq subsystem seems to be more oriented towards a device (like GPU or CPU) that controls the power/performance characteristics by itself and not the performance of other devices. The main problem of using it is that it's using a reactive approach - for example monitor some performance counters and then reconfigure bandwidth after some bottleneck has already occurred. This is suboptimal and might not work well. The new solution does the opposite by allowing drivers to express their needs in advance and be proactive. Devfreq also does not seem suitable for configuring complex, multi-tiered bus topologies and aggregating constraints provided by drivers.

> The series also doesn't seem to provide any kind of indication how
> this will be used by end points. You have one driver for one SoC that
> just contains large tables that are parsed at probe time, but no
> driver hooks anywhere that will actually change any settings depending
> on use cases. Also, the bindings as posted don't seem to include any
> of this kind of information. So it's hard to get a picture of how this
> is going to be used in reality, which makes it hard to judge whether
> it is a good solution or not.

Here are links to some of the examples that are on the mailing list already. I really should have  included them in the cover letter. 
https://lkml.org/lkml/2018/12/7/584
https://lkml.org/lkml/2018/10/11/499
https://lkml.org/lkml/2018/9/20/986
https://lkml.org/lkml/2018/11/22/772

Platforms drivers for different SoCs are available:
https://lkml.org/lkml/2018/11/17/368
https://lkml.org/lkml/2018/8/10/380
There is a discussion on linux-pm about supporting also Tegra platforms in addition to NXP and Qualcomm.

> Overall, exposing all of this to software is obviously a nightmare
> from a complexity point of view, and one in which it will surely be
> very very hard to make the system behave properly for generic
> workloads beyond benchmark tuning.

It allows the consumer drivers to dynamically express their performance needs in the system in a more fine grained way (if they want/need to) and this helps the system to keep the lowest power profile. This has already been done for a long time in various different kernels shipping with Android devices, for example, and basically every vendor uses a different custom approach. So I believe that this is doing the generalization that was needed.

> Having more information about the above would definitely help tell if
> this whole effort is a step in the right direction, or if it is
> needless complexity that is better solved in other ways.

Sure, hope that this answers your questions.

Thanks,
Georgi

> 
> -Olof
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
