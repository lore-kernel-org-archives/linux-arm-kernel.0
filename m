Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB30C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:36:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D26B2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzBolEVa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aYdOGeSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D26B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZ+NudXTV4tuLL0g5smZn4zOmXS706QO641oN1CM9t8=; b=MzBolEValg5iR+
	Z199BUzeWuJFlLf6FNx09z2NuGn0utdNDGble6BvjTt0n19TdIP4ZWt8zfyetaH42D2pHvKc/mbDh
	eIwaIUumcKtOgdK5ISoY5A2jyz+f/wgooWHNGfhow7mOf8N1RQR4VmiR1QW3IMYS6sw2m53jHckF5
	NKiFJ263kd4t7zcKdQqPgA3NbzTu6ptplzN3vOSNe6oDPmqX3BHR1KMtUsFcbYd2DYUMgppWD/ioS
	yrDb/NSGmjsa2lIpQuiIKYXUN+BbZENtRZ1Dq8CteT2EWNIkxsnlf/cD091rDon0yr85fsMFiyxtL
	YczaH2ymm/MVoZFSDhOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1q3-0006T0-EO; Tue, 22 Jan 2019 19:35:59 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1pz-0006Se-Ih
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:35:57 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so28832022wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 11:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tRJsa09xm5VgkkRKpiXzMXtNZ4IuWnoYtrD79ZJjKyM=;
 b=aYdOGeSxYb6EgYiJjYM3xMjjqx383yaSYPXElTvOyHBuB5oRkLCx1JsrfAA9OdboOn
 OMtZr7PejcJ1g1ZQZSY3aolib8OGpd6rMt21yH4TSuhk4wHjS81nZG9sv8eorsD29mdC
 4W5Z3im7ubSScOn1ZN82aUh4RAMk5kOtkN7tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tRJsa09xm5VgkkRKpiXzMXtNZ4IuWnoYtrD79ZJjKyM=;
 b=MW9etZ0B2ToyNHVSAI4E8tVDMh7hmQxkHBxZEnFvsA2Z1Vm8aIAJsGAEVywOgWWiB9
 NwKyIVW6YnzazP+zqRw5IQz5KXjmAyYskZxO7RPb46eWwRPLxBESqmoObpFXMfHEpVXU
 2mg/+uzUFSru9FNhvyFL/ej2Gq7u2CKWOzVYuXQfQesxQK6zbza7At3a3U1gSqP5dZ2S
 eejMATyc/marMAmbNI6+HWE/+qbn4kW+3T7cI6ntMzTdCNrQGqDsTP08DV6R6iZ1cyo7
 j/qon1FbzH3SL6lswL8PayrvblR9KwkpNqQVhbwDGRYiPpFlIfUfkWbFbY0zFP4Ua+6W
 yuTg==
X-Gm-Message-State: AJcUukcwdRN8eYPmXyH46xkiU90HX3hZXSobRRV6T5m20Ucv/VI6mXQz
 cRIt0FUTcyni5jbQydfkaABDBw==
X-Google-Smtp-Source: ALg8bN6jMUXSPhssGVxvXuXyM3eh9MIbLvsAUqJhuxMyFGI3KZkY+gsWJBz0thl0QEU68N2zVVoLaA==
X-Received: by 2002:a05:6000:120a:: with SMTP id
 e10mr34485511wrx.85.1548185752852; 
 Tue, 22 Jan 2019 11:35:52 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net.
 [83.34.185.92])
 by smtp.gmail.com with ESMTPSA id e16sm168281100wrn.72.2019.01.22.11.35.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 11:35:52 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To: Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
 <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
 <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
 <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <3ffe45a8-401d-37f6-4368-f14e2f2e5392@linaro.org>
Date: Tue, 22 Jan 2019 20:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_113555_642633_F0B23ABA 
X-CRM114-Status: GOOD (  19.60  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/22/19 19:47, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2019-01-17 02:46:21)
>> On 1/17/19 11:08, Viresh Kumar wrote:
>>> On 17-01-19, 09:38, Jorge Ramirez wrote:
>>>> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
>>>> to disable the clocks that were enabled by the firwmare and not by the
>>>> drivers.
>>>>
>>>> the cpufreq driver does not enable the cpu clock.
>>>>
>>>> so when clk_change_rate is called, the enable_count counter is not
>>>> incremented and therefore it just remains null since this was enabled by
>>>> the firmware.
>>>>
>>>> I tried doing:
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>>>> index e58bfcb..5a9f83e 100644
>>>> --- a/drivers/cpufreq/cpufreq-dt.c
>>>> +++ b/drivers/cpufreq/cpufreq-dt.c
>>>> @@ -124,6 +124,10 @@ static int resources_available(void)
>>>>                 return ret;
>>>>         }
>>>>
>>>> + ret = clk_prepare_enable(cpu_clk);
>>>> + if (ret)
>>>> +         return ret;
>>>> +
>>>>         clk_put(cpu_clk);
>>>>
>>>>         name = find_supply_name(cpu_dev);
>>>>
>>>>
>>>> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
>>>> the system wide consequences of that change to cpufreq.
>>>
>>> If the cpufreq driver enables it then it should disable it on exit as
>>> well, right ? And in that case if you unload your driver's module, you
>>> will hang the system as the clock will get disabled :)
>>
>> ah, of course, sorry was over-thinking this thing :)
>>
>>>
>>> Every other platform must either be marking it with CLK_IGNORE_UNUSED
>>> or they must be doing clk_enable from somewhere, maybe the CPU online
>>> path, not sure though.
>>>
>>
>> since this clock is enabled by the firmware, it seems to me that using
>> CLK_IGNORE_UNUSED remains the best option.
>>
> 
> What do you do about CPUs being offlined? Presumably when the CPU is
> gone the system doesn't need to keep the clk enabled anymore.
> 
> 

the kernel does not take any action - it is under firmware control; and
since the clock is shared between all cores I there will have to be some
involvement not only at TF-A/firmware level but also at the TrustedOS
level for when the last core is offlined.

I dont have visibility on either of those projects though.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
