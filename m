Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7982F20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWAk6Aib";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nh97rH3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HbWqW/O2UTkqn/zaQVl6lt0eiuT3mwEMOg1/wyCsH5c=; b=dWAk6AibSQaUgx
	fU1nLlU/y8NojflWhBM7Y4x6xXAk99XoStPxVWXCjU9cxfhijV/49KF123wf1azz+KLM1tq6jm6Kb
	1umx0sjYlZ1kZAv8SuRidP69Aha5l6JpRki/xzZMgk931ZqdpTHA0Dhkf+8gqeBBks2J3PRjoIZXg
	v9rajc5Y6hqMJowV8sG1vVUxQgeMjbm7qfNNQbpP2Ho33RGSKS5QYW4SY4eJvaXGXDzj3q+stSBHL
	BWYz5yvfweGiW9favKGdXJOunGqCEfaiCfB4KH19ThbCAXrMCXWIZupc0/YUmafHHx4LqDrhZfp1k
	fvafTlMkSs66fJbUuFbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5Bs-0005K1-LL; Thu, 17 Jan 2019 10:46:28 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5Bp-0005Jh-PM
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:46:27 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so10499882wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 02:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4wjGNMQ1Xyj/2nk4iZvOiwJXuhvRb1mvppAMZfhe2UI=;
 b=Nh97rH3g4xO4yRnaRfwnZCtw8lMhWS5ifN3UoStuXWV8XreZpBgNFP6v513+F830R7
 1A8fkYGpSLFmKF9JquRLeWu5RmELG9dEJ1uV4op58lJzDxaQpVOpCbmoNPe4RJPQq4et
 daBtCall7K34uaGZbsbxhJ6Jx0tpmnDM2vNXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4wjGNMQ1Xyj/2nk4iZvOiwJXuhvRb1mvppAMZfhe2UI=;
 b=pM1IXutR8BNsJdGcskzfTfsgKG7Kcw0iKaNiiWr2aHTLkrQ+9KvCyQjtTmESrb07Qd
 tsSnFHV0jPx2Qp6CVL9+FaxyjuSyiQ4mChZXdHt1cigOAxMQkB9vAemkTqAewBiROaeW
 p0bcbVkn8+TwSQcVjZcS+NbHQksbOHxvTQ7ljuVQkalOHLeZxDs4x8DAg2iP4ozv2u4s
 sv19sJJ663idwjGKgMj7KXqzJEhv5Mh4bBB4RQGSiewpaLQsOTmfROhaUSj4TuseDlgN
 l1CavU6uD71Dpp+jXVijb98O1Ynnn329yfA2MhAhAX52n6TweuJUJjS6Bgf4LLsxAQ3C
 QSQg==
X-Gm-Message-State: AJcUuke3DdOmr+8Drf3u5PotyykN43QeSiB1frQVZHkUoMlC8toVs+0P
 9iMWrTbkvMFGn2GZIGl3G5g5PQ==
X-Google-Smtp-Source: ALg8bN4kXbu2kYK3OAMDoQUbHMGQHEGK66MunwyJ6kotzGX991Pg8Wz+m63sdFhnFmh4HpAV3QAiXg==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr12345067wru.154.1547721984108; 
 Thu, 17 Jan 2019 02:46:24 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net.
 [83.34.185.92])
 by smtp.gmail.com with ESMTPSA id s16sm63932643wrt.77.2019.01.17.02.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 02:46:23 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
 <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
Date: Thu, 17 Jan 2019 11:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_024625_830939_43FCE005 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
 david.brown@linaro.org, linux-clk@vger.kernel.org, jassisinghbrar@gmail.com,
 jagan@amarulasolutions.com, andy.gross@linaro.org, sibis@codeaurora.org,
 devicetree@vger.kernel.org, arnd@arndb.de, niklas.cassel@linaro.org,
 robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/19 11:08, Viresh Kumar wrote:
> On 17-01-19, 09:38, Jorge Ramirez wrote:
>> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
>> to disable the clocks that were enabled by the firwmare and not by the
>> drivers.
>>
>> the cpufreq driver does not enable the cpu clock.
>>
>> so when clk_change_rate is called, the enable_count counter is not
>> incremented and therefore it just remains null since this was enabled by
>> the firmware.
>>
>> I tried doing:
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
>> index e58bfcb..5a9f83e 100644
>> --- a/drivers/cpufreq/cpufreq-dt.c
>> +++ b/drivers/cpufreq/cpufreq-dt.c
>> @@ -124,6 +124,10 @@ static int resources_available(void)
>>                 return ret;
>>         }
>>
>> + ret = clk_prepare_enable(cpu_clk);
>> + if (ret)
>> +         return ret;
>> +
>>         clk_put(cpu_clk);
>>
>>         name = find_supply_name(cpu_dev);
>>
>>
>> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
>> the system wide consequences of that change to cpufreq.
> 
> If the cpufreq driver enables it then it should disable it on exit as
> well, right ? And in that case if you unload your driver's module, you
> will hang the system as the clock will get disabled :)

ah, of course, sorry was over-thinking this thing :)

> 
> Every other platform must either be marking it with CLK_IGNORE_UNUSED
> or they must be doing clk_enable from somewhere, maybe the CPU online
> path, not sure though.
> 

since this clock is enabled by the firmware, it seems to me that using
CLK_IGNORE_UNUSED remains the best option.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
