Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D645FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:06:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6ED20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oget8NUU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgLLsRdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6ED20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bp/U/eOAEWY5qrO034Ctrn2QGCjAxrHIe8hypcyjvnE=; b=oget8NUU+q5WOI
	ZU3FMHGlxnC8Yh+oSovz5ggZRCAgLUxyceTY6BaryzIfWTcdZn4wU1Fjld00i90nwzSLFOM37YRO+
	Iapt+Ui1oJ8JFPOC+NbI6K+1fUUYcuu9Hee6cpaIauE+A1q1vBrWLmHP3g44Cq52J0AQouLeQKK7a
	C9tsD/ImH/Dl0RG+UAXYEhhB1tEnkP3t5Znodt8PA/qoI99vkiUxjEmWqEditYHVoDqTE0/x3meiq
	dEvxKobzyLtLXoEV38qu07Lj60K4bI5k1g6ds6WyCYMxnXuAGNT+3LaNFbsXpVlGEIvfbeEALPAKW
	l5SKcHsKe5V/nxYv3ESg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVD1s-0002Wu-Uj; Fri, 07 Dec 2018 10:06:40 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVD1q-0002Ur-4r
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:06:39 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so3890053wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kUwCLVhtHzk/2FY1YPtUTTCUBvJxk6qL0FqXIMwaMGE=;
 b=EgLLsRdF0ufehtUkt0d6+MO46jfc6jxP9t7c8y9Us/0lQ+pO1Z3QVuNlMaRI0Rb79G
 hu4NIUruXENdjTcXRezhpT6wsga5iXnCgojo6AzjDGt0dFfzMRjaHfIvpDTcPdeSs/yC
 XtIIWeHSl/z0ZFAX8FAOnI1lcd9BOCBLcsyMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kUwCLVhtHzk/2FY1YPtUTTCUBvJxk6qL0FqXIMwaMGE=;
 b=GvGwdGi6CY1QTkTeNABmSh3TwYHQZPN2cXaKeKG3nuezGZWP3DT3oXT2W2Hjb1caIS
 Z59nWvm/brU5gUSMK3lz8k0WRoFrJsd8BHhdmPs3pbPPgKeaLmtvQe0OnUh4W9vQWACy
 o7+w/GpGjHmoMTQOxUwXcfzm7QBqCzneHbfEhObA75SHaYCMJbxdnEUGHwL/e2Betyok
 wGJ5hGxepBEMSCHj1EfsIQ2XYWLXvvdsNf2Ov7d+HFyALfu7u6t9oy08zB/sRwJfqG1a
 OQF7CSG/5h/t0jcdUP3VQUr/i2yFwPiEvUfFlaBd3Sx0s9RjSIF3/Ia3JmBW0d8P5zp8
 pzjw==
X-Gm-Message-State: AA+aEWaAlH80EIYTNLa8YwwtZnGqDuaC3u14OpZbJPHxIy41DN8HpCsq
 A9nqrKVYiAGN9pkM58FxojQptw==
X-Google-Smtp-Source: AFSGD/UlsM50NUxHuwWMDONeZyXRKXAsqMKVkTVr0RrtmQThCndUvhyJ1U5qwE5su7XgBewMycF4Sg==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr1627453wmk.149.1544177186274; 
 Fri, 07 Dec 2018 02:06:26 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id r69sm5978266wmd.4.2018.12.07.02.06.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 02:06:25 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To: Greg KH <gregkh@linuxfoundation.org>, Evan Green <evgreen@chromium.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <bdc4bad1-d613-4144-2e5b-2657e170affa@linaro.org>
Date: Fri, 7 Dec 2018 12:06:21 +0200
MIME-Version: 1.0
In-Reply-To: <20181206145547.GA7884@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_020638_196815_2AD95B04 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: mark.rutland@arm.com, Doug Anderson <dianders@chromium.org>,
 sanjayc@nvidia.com, maxime.ripard@bootlin.com,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>, lorenzo.pieralisi@arm.com,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 khilman@baylibre.com, ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Greg and Evan,

On 12/6/18 16:55, Greg KH wrote:
> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
>> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>
>>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
>>> graphics, modem). These cores are talking to each other and can generate a
>>> lot of data flowing through the on-chip interconnects. These interconnect
>>> buses could form different topologies such as crossbar, point to point buses,
>>> hierarchical buses or use the network-on-chip concept.
>>>
>>> These buses have been sized usually to handle use cases with high data
>>> throughput but it is not necessary all the time and consume a lot of power.
>>> Furthermore, the priority between masters can vary depending on the running
>>> use case like video playback or CPU intensive tasks.
>>>
>>> Having an API to control the requirement of the system in terms of bandwidth
>>> and QoS, so we can adapt the interconnect configuration to match those by
>>> scaling the frequencies, setting link priority and tuning QoS parameters.
>>> This configuration can be a static, one-time operation done at boot for some
>>> platforms or a dynamic set of operations that happen at run-time.
>>>
>>> This patchset introduce a new API to get the requirement and configure the
>>> interconnect buses across the entire chipset to fit with the current demand.
>>> The API is NOT for changing the performance of the endpoint devices, but only
>>> the interconnect path in between them.
>>
>> For what it's worth, we are ready to land this in Chrome OS. I think
>> this series has been very well discussed and reviewed, hasn't changed
>> much in the last few spins, and is in good enough shape to use as a
>> base for future patches. Georgi's also done a great job reaching out
>> to other SoC vendors, and there appears to be enough consensus that
>> this framework will be usable by more than just Qualcomm. There are
>> also several drivers out on the list trying to add patches to use this
>> framework, with more to come, so it made sense (to us) to get this
>> base framework nailed down. In my experiments this is an important
>> piece of the overall power management story, especially on systems
>> that are mostly idle.
>>
>> I'll continue to track changes to this series and we will ultimately
>> reconcile with whatever happens upstream, but I thought it was worth
>> sending this note to express our "thumbs up" towards this framework.
> 
> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> it to the tree if all looks good.
> 

Yes, it's coming. I will also include an additional fixup patch, as the
sdm845 provider driver will fail to build in linux-next, due to a recent
change in the cmd_db API.

Thanks,
Georgi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
