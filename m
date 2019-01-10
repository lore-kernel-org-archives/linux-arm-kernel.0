Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:34:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF9720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sxp2Bwr8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAhfecLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF9720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=laNSt7ODw9kHZEiZ/MpnEKzHi+MSKRAeC/fLTEasedI=; b=Sxp2Bwr8YVzLZ/
	msdEeoXq/Va7okL9EzwJ4uK1T3QCNCGL45nMopVg7WbXbAlpqXr/HCz7OgtErZ7aHTUT4i7436Hbg
	sSH4QJRvdp0gKG39ywzg1c7XHGMFxsRD1KgPxDWDKzsvlrBvNOygbEDrLEL4O0dvH7WHJQioHNBLC
	oMsEWWidPbNbdFeXj48rY3P51UxdHqgKZH8lUt0T2tYsTHrGKJzBW6r7vqfiQ6qglgzJbRN6HeCzr
	5D5cKHUUXp4P4pI1vYQUN5kChbrDA/DQG9WTPEK8o6Y+bQhBG1Sa/RtMprk/esBUNC93J0k4ovp5a
	70I432wOKWSQwX7HZObw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdID-00026m-VH; Thu, 10 Jan 2019 16:34:53 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdI9-00026F-7J
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:34:52 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so12655902wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w32hLnAw5bLjWDJ9T8+qGhKha4sKnjjXz6R6e6acIX4=;
 b=QAhfecLQFQMuw408R6wdu7wFUxU09DyOPUJ9LVygjs2aadQbCPUJHyNDHX+KKOniap
 dMAArhSzvv1eeKNynMDzAPBUZiLs1sYaiRrw50xK0bHlq9avMpnlCme043QMKGix8WZS
 dz+nn/ms7ee+iuW3ZeKx5rCJBHTMciOjrIAPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w32hLnAw5bLjWDJ9T8+qGhKha4sKnjjXz6R6e6acIX4=;
 b=S4xOieLijBwEMzMOQcV+jc+zVEkZj0ujKL1i8/qRg/h8UG1A5d9Bn+OoDnNK5kUtXb
 Z7M4B5t0TjHmnaSmGqF6z0e9sbPqpdL24wmDS4A4Gn4jEy11Sr3+Fvx1LiGaoJacAANM
 oGFk9X5Xzwc5vKVN4kBQiQrk5WWedTLoaBEB6BSeZ9ktUkdzz+zWQvt+v7FDVgD/t+c2
 I3Qg7+gvLwhgOmt1HUi+IrA1OciHT6Z/InGEdvq/bYof0Qi+GlHTuBXJFtYKG0H91JKK
 0UJ0/HILGBfIdbd3so1lLsvtjx5hLszPnckMZ8EEabfGdRK3IYRBimHlGu820vXV3pDP
 43Uw==
X-Gm-Message-State: AJcUukc36qi79m/HGW749Hvg53Zv4skXVgkS8njW1Sl1G9EO5FIHNbPY
 SS+RfQnXuMF6vbnUyt1K3xRlGA==
X-Google-Smtp-Source: ALg8bN5aj5as7M96AsGERTcrl249DmAuGIutaCvQjhYPW0GTTPFG1sBE2A4JwnObhzRGytXMT7GSfw==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr10982437wme.106.1547138087097; 
 Thu, 10 Jan 2019 08:34:47 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id m4sm5658204wmi.3.2019.01.10.08.34.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 08:34:46 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com>
 <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
 <6923d6ed-e357-b083-1830-8396d788efe5@linaro.org>
 <CAJZ5v0jZMqFwYgnfRz04ELLRk=0U8Uv=acw0t9Azxk_HYL0gSQ@mail.gmail.com>
 <9a3aae02-c7e0-97e3-2330-af4fccee6c14@linaro.org>
 <20181211065808.GB5161@kroah.com>
 <199be960-032a-d72d-4293-820e23a15b7a@linaro.org>
 <b21d13df-7c0b-4c6d-e3c7-6ab285579ed5@linaro.org>
 <20190110162906.GA19693@kroah.com>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <69f004fa-2705-5cf4-3812-8e7b68a16400@linaro.org>
Date: Thu, 10 Jan 2019 18:34:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190110162906.GA19693@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_083451_173484_CC1EDC57 
X-CRM114-Status: GOOD (  27.48  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>,
 sanjayc@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 maxime.ripard@bootlin.com, Michael Turquette <mturquette@baylibre.com>,
 daidavid1@codeaurora.org, bjorn.andersson@linaro.org,
 Saravana Kannan <skannan@codeaurora.org>, abailon@baylibre.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, evgreen@chromium.org,
 ksitaraman@nvidia.com,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Linux PM <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/10/19 18:29, Greg Kroah-Hartman wrote:
> On Thu, Jan 10, 2019 at 04:19:14PM +0200, Georgi Djakov wrote:
>> Hi Greg,
>>
>> On 12/17/18 13:17, Georgi Djakov wrote:
>>> Hi Greg,
>>>
>>> On 12/11/18 08:58, Greg Kroah-Hartman wrote:
>>>> On Mon, Dec 10, 2018 at 04:50:00PM +0200, Georgi Djakov wrote:
>>>>> On 12/10/18 13:00, Rafael J. Wysocki wrote:
>>>>>> On Mon, Dec 10, 2018 at 11:18 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi Rafael,
>>>>>>>
>>>>>>> On 12/10/18 11:04, Rafael J. Wysocki wrote:
>>>>>>>> On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
>>>>>>>>>> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
>>>>>>>>>>> graphics, modem). These cores are talking to each other and can generate a
>>>>>>>>>>> lot of data flowing through the on-chip interconnects. These interconnect
>>>>>>>>>>> buses could form different topologies such as crossbar, point to point buses,
>>>>>>>>>>> hierarchical buses or use the network-on-chip concept.
>>>>>>>>>>>
>>>>>>>>>>> These buses have been sized usually to handle use cases with high data
>>>>>>>>>>> throughput but it is not necessary all the time and consume a lot of power.
>>>>>>>>>>> Furthermore, the priority between masters can vary depending on the running
>>>>>>>>>>> use case like video playback or CPU intensive tasks.
>>>>>>>>>>>
>>>>>>>>>>> Having an API to control the requirement of the system in terms of bandwidth
>>>>>>>>>>> and QoS, so we can adapt the interconnect configuration to match those by
>>>>>>>>>>> scaling the frequencies, setting link priority and tuning QoS parameters.
>>>>>>>>>>> This configuration can be a static, one-time operation done at boot for some
>>>>>>>>>>> platforms or a dynamic set of operations that happen at run-time.
>>>>>>>>>>>
>>>>>>>>>>> This patchset introduce a new API to get the requirement and configure the
>>>>>>>>>>> interconnect buses across the entire chipset to fit with the current demand.
>>>>>>>>>>> The API is NOT for changing the performance of the endpoint devices, but only
>>>>>>>>>>> the interconnect path in between them.
>>>>>>>>>>
>>>>>>>>>> For what it's worth, we are ready to land this in Chrome OS. I think
>>>>>>>>>> this series has been very well discussed and reviewed, hasn't changed
>>>>>>>>>> much in the last few spins, and is in good enough shape to use as a
>>>>>>>>>> base for future patches. Georgi's also done a great job reaching out
>>>>>>>>>> to other SoC vendors, and there appears to be enough consensus that
>>>>>>>>>> this framework will be usable by more than just Qualcomm. There are
>>>>>>>>>> also several drivers out on the list trying to add patches to use this
>>>>>>>>>> framework, with more to come, so it made sense (to us) to get this
>>>>>>>>>> base framework nailed down. In my experiments this is an important
>>>>>>>>>> piece of the overall power management story, especially on systems
>>>>>>>>>> that are mostly idle.
>>>>>>>>>>
>>>>>>>>>> I'll continue to track changes to this series and we will ultimately
>>>>>>>>>> reconcile with whatever happens upstream, but I thought it was worth
>>>>>>>>>> sending this note to express our "thumbs up" towards this framework.
>>>>>>>>>
>>>>>>>>> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
>>>>>>>>> it to the tree if all looks good.
>>>>>>>>
>>>>>>>> I'm honestly not sure if it is ready yet.
>>>>>>>>
>>>>>>>> New versions are coming on and on, which may make such an impression,
>>>>>>>> but we had some discussion on it at the LPC and some serious questions
>>>>>>>> were asked during it, for instance regarding the DT binding introduced
>>>>>>>> here.  I'm not sure how this particular issue has been addressed here,
>>>>>>>> for example.
>>>>>>>
>>>>>>> There have been no changes in bindings since v4 (other than squashing
>>>>>>> consumer and provider bindings into a single patch and fixing typos).
>>>>>>>
>>>>>>> The last DT comment was on v9 [1] where Rob wanted confirmation from
>>>>>>> other SoC vendors that this works for them too. And now we have that
>>>>>>> confirmation and there are patches posted on the list [2].
>>>>>>
>>>>>> OK
>>>>>>
>>>>>>> The second thing (also discussed at LPC) was about possible cases where
>>>>>>> some consumer drivers can't calculate how much bandwidth they actually
>>>>>>> need and how to address that. The proposal was to extend the OPP
>>>>>>> bindings with one more property, but this is not part of this patchset.
>>>>>>> It is a future step that needs more discussion on the mailing list. If a
>>>>>>> driver really needs some bandwidth data now, it should be put into the
>>>>>>> driver and not in DT. After we have enough consumers, we can discuss
>>>>>>> again if it makes sense to extract something into DT or not.
>>>>>>
>>>>>> That's fine by me.
>>>>>>
>>>>>> Admittedly, I have some reservations regarding the extent to which
>>>>>> this approach will turn out to be useful in practice, but I guess as
>>>>>> long as there is enough traction, the best way to find out it to try
>>>>>> and see. :-)
>>>>>>
>>>>>> From now on I will assume that this series is going to be applied by Greg.
>>>>>
>>>>> That was the initial idea, but the problem is that there is a recent
>>>>> change in the cmd_db API (needed by the sdm845 provider driver), which
>>>>> is going through arm-soc/qcom/drivers. So either Greg pulls also the
>>>>> qcom-drivers-for-4.21 tag from Andy or the whole series goes via Olof
>>>>> and Arnd. Maybe there are other options. I don't have any preference and
>>>>> don't want to put extra burden on any maintainers, so i am ok with what
>>>>> they prefer.
>>>>
>>>> Let me take the time later this week to review the code, which I haven't
>>>> done in a while...
>>>>
>>>
>>> When you get a chance to review, please keep in mind that the latest
>>> version is v12 (from 08.Dec). The same is also available in linux-next
>>> with no reported issues.
>>
>> The dependencies for this patchset have been already merged in v5.0-rc1,
>> so i was wondering if this can still go into -rc2? Various patches that
>> use this API are already posted and having it sooner will make dealing
>> with dependencies and merge paths a bit easier during the next merge
>> window. Or i can just rebase and resend everything targeting v5.1.
> 
> We can't add new features after -rc1, sorry.
> 
> Please rebase and resend to target 5.1

Ok, i was expecting that. Thanks for confirming!

BR,
Georgi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
