Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:39:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A015214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I2tZvH4i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMzmwei4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A015214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICO9nemxDdRLV2C1jBRrV0W2SONwA+/VjUhWjRC1Qq8=; b=I2tZvH4i0BykSf
	x6ahCmPTuyNlGwHD4dTA2FtJ11MeAG40d2eIrJddh7KmxJT1KAMfMtzvmlKrk3ceLdRUxLFOjTfWB
	cGY8sCIBCFGgH4DDBlEb4BccR6NU75itOo0e97PNqRIleOsrh08ZntYxPqDzZ42X8TTb7bjHq+i/N
	HlxDj//GcdOtseecEG4tYkyuOhzxGhnu8/tp97PqQ0E4c9DomlKlAxF61Ysi+TvG5vfEqn6D25n0u
	6o9sE/5C4crtW0RtVAD1gqApBozyb9agRsvtSbthuVCO8FPExyjK4Q7/XRWwTggvuhj2ykXqTp2RK
	Ij0KfSYtb+cYhx5VjgDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWnx-0007sk-1z; Thu, 10 Jan 2019 09:39:13 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWnt-0007rg-5l
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:39:10 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so10506359wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0TiRv655YIr81mM5pPgI0udJ5j46i3jGyTSi/WvOn44=;
 b=GMzmwei4fvM4VhdiW/jcelXImwAva06CBJeuQzBJtazAwGsFZnlqD0EOgJWR5JZ0Rp
 HDiZuGBa4NcXoxef3N49zYQd+1V8wFcfkJ30xPdwbzxw+qZEi0UezwIksqNUvZhDpwG7
 uDdfbYuex1FvLy1ISY8l2yVwWF8CQ5HFnRhUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0TiRv655YIr81mM5pPgI0udJ5j46i3jGyTSi/WvOn44=;
 b=mK/h+Z2gMU3vjM+cDF3DF+WCw4WZ5gSdrhZolCOmrKIKfVVqsEvSwaZJEXy09MxjsY
 Wm/GBxvo3PStxGIKuEztEszbaWHAMvLOFlpP3yt3vY/XmeOv6altagNiDbjVOt317D6i
 wO9hyCqsG17Pc8k2uFKGwoVyvSF83P2SqV6sZl090vanKbFpNcoFm9joKEe2v987bAfH
 l4y3KMj0OaQH5hCxrI9L9WywuihS9daJp8dxTCOr5G0SM+rle3D0xGRXxYrpTMxrOJlT
 5BqX46qphieQ12xIZ8FDS2XKmQAN8HJ4oh1liptXQLUkXkbtoERs0EV1ftYlvsJSk3dk
 Whrg==
X-Gm-Message-State: AJcUukdRSVkV0k6LablRk7QOCONhG6zWrLJCsxqNelpZ6ZCTmmsV0DjD
 D6fBD4sZYXUAzhyY6RPOyjnGmw==
X-Google-Smtp-Source: ALg8bN4ums7IgDd/dylRPgL3pTUcsWRj+5nHipncKgmxAsmLO/RcVJLloOp35E6SiDTs8ATLLdRviw==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr8687585wrn.171.1547113146996; 
 Thu, 10 Jan 2019 01:39:06 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id
 h131sm21418349wmd.17.2019.01.10.01.39.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 01:39:06 -0800 (PST)
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
To: Henry Chen <henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
 <1546859080.6818.128.camel@mtksdaap41>
 <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
 <1547003324.6818.156.camel@mtksdaap41>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <d03ec933-5fe6-d076-d658-9b966cee9c0f@linaro.org>
Date: Thu, 10 Jan 2019 11:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <1547003324.6818.156.camel@mtksdaap41>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_013909_231843_9437DCAA 
X-CRM114-Status: GOOD (  22.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 1/9/19 05:08, Henry Chen wrote:
> On Mon, 2019-01-07 at 18:34 +0200, Georgi Djakov wrote:
>> Hi Henry,
>>
>> On 1/7/19 13:04, Henry Chen wrote:
>>> On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
>>>> Quoting Henry Chen (2019-01-02 06:09:51)
>>>>> The patchsets add support for MediaTek hardware module named DVFSRC
>>>>> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
>>>>> a HW module which is used to collect all the requests from both software
>>>>> and hardware and turn into the decision of minimum operating voltage and
>>>>> minimum DRAM frequency to fulfill those requests.
>>>>>
>>>>> So, This series is to implement the dvfsrc driver to collect all the
>>>>> requests of operating voltage or DRAM bandwidth from other device drivers
>>>>> likes GPU/Camera through 2 frameworks basically:
>>>>>
>>>>> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>>>>>    requirements from different clients
>>>>
>>>> Have you looked at using the interconnect framework for this instead of
>>>> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
>>>> to do DRAM bandwidth requirement aggregation.
>>>
>>> Sorry, I haven't heard that before. Do you mean is following series
>>> patch?
>>> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775
>>>
>>
>> Yes, this one. The idea is that consumer drivers like GPU, camera, video
>> encoder etc. report their bandwidth needs by using the interconnect API.
>> The framework does the aggregation and configures the hardware. In order
>> to use it you need to implement a platform-specific dvfsrc interconnect
>> provider driver that understands the SoC topology and knows how to
>> configure the hardware. I am not familiar with DVFSRC, but it seems to
>> me that it can fit as interconnect provider.
>> Does this HW module support any QoS priority/latency configuration or is
>> it only bandwidth and voltage?
>>
>> Thanks,
>> Georgi
> 
> Hi Georgi,
> 
> Yes, the design is only to support bandwidth and voltage. The one of the
> function is to collect the memory bandwidth requirement from consumer
> and select the minimum DRAM frequency to fulfill system performance.It
> just get the total bandwidth then set it to HW, not involves complex SoC
> topology. So we choose to use PM QOS to model that DVFSRC driver can
> receive the bandwidth information from consumer driver via
> PM_QOS_MEMORY_BANDWIDTH.

Ok, good. The current patchset supports bandwidth, but there was a
discussion about adding support for latency and priority in the future.
Thanks for the information!

> Do you have a patch that show how consumer driver used interconnect to
> update their requirement.

Here are some examples:
https://lkml.org/lkml/2018/12/7/584
https://lkml.org/lkml/2018/10/11/499
https://lkml.org/lkml/2018/9/20/986
https://lkml.org/lkml/2018/11/22/772

Thanks,
Georgi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
