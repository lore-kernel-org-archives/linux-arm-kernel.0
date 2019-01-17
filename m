Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D3F20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDHSereY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqMWms08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D3F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxagrPFXqBg8rEW3cZNoL8Qu2q1srGGKGBiTnL+FV5Q=; b=gDHSereYsepjTK
	ppLZl9GmPoDUvtXLRSfbluX5zHbFQhqNnuQgXRo/xQZeOBYxrqtuf24N2VtNNKPRmka4nUXQsysCL
	MNfI+4iHSm5Ede60zBdQxDYTElka9K4iTq7ro+i3NYJvTTJ815lGlVyd7IS/VxnZs9PdEzuv6xC/Q
	PWOqfAQ0HxW+rn8jR1zBwQiBQCimuwquJihkMLJHUlOIp32ngR1dKxq37PZMtZOBxKu/tKNAFyyGF
	jg5EWjTHe0hhupoNLGV6wyLMLy+rdBEZbLssnBljgNfBgHjeXpKu8z5L9A4W2xAfyQjBUJI6hN42R
	Iv8DTWmdLlh6I+2mO5ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3Bw-0006WF-Uq; Thu, 17 Jan 2019 08:38:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3Bt-0006Vt-5J
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 08:38:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id j2so10040277wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TUa7v44EgL51hqJdpJbqu9DZEckjKML/2Dfdppi/ENE=;
 b=fqMWms08tAtamGiiA6y4t6ZIt2keKs81seHvpVhDYMWC3D4WpnFk1qAK5yikFmIBFf
 LwiNIQQuXhwhJHNB75wRiva9svb11nqKl2KE3szXtl2xomYQkjQrp3RcW2nPAJG+Iyur
 EqIfK8caZ3jtTiiVu4/TPv3MxJrENPrRz7dpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TUa7v44EgL51hqJdpJbqu9DZEckjKML/2Dfdppi/ENE=;
 b=tHskVqig8IDXMXSqgzZDSV9qhlUQZTYMembUQ9rxVSWkXTwjD3RbTwyAg2c+gWXZPM
 GR+h5iZGVmqEbs4MUnz/ifrAIVMSIWgC9x+rUz01BEiCzzrx6KseWHqutUf6fnY6yTxg
 8NQ1qlMikohbv9S93/q1LziG2aHCUQycI63ogRE88tNOqoAWry+m/hsRPcXpEBsJgH62
 Bd5E5I2zLpTdL0r+xHFfWqHGjWb0c2FRZ3lSIAyzVdhEM9Z2SF/0ZiBI0izhb6dinTyD
 27xwfhDuLM2iUWZ8Dt+lN+UdV0MyteD/sTUXSFauP2DEs4Qsv6iS3clM0Sc9g4dP18Cl
 4dPA==
X-Gm-Message-State: AJcUukdS5V76DLC1nvy/wAELclMjwoaHLSUg1O5xf+JPhwwpud5Ix7dX
 nTFS5CzBhwd/v064oMp4qBv1pg==
X-Google-Smtp-Source: ALg8bN6+5FHCyE61OT0u4whQA+qc0ReIsDotQjaFj3HTMiktBe1MtVo8XThYvV3D2lTGfHLjIyvnZQ==
X-Received: by 2002:adf:b102:: with SMTP id l2mr10609682wra.296.1547714298758; 
 Thu, 17 Jan 2019 00:38:18 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net.
 [83.34.185.92])
 by smtp.gmail.com with ESMTPSA id f2sm94297783wre.34.2019.01.17.00.38.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 00:38:18 -0800 (PST)
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
Date: Thu, 17 Jan 2019 09:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117063312.GE25498@builder>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_003821_213519_D1FC201C 
X-CRM114-Status: GOOD (  23.86  )
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
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/17/19 07:33, Bjorn Andersson wrote:
> On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:
> 
>> When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
>> to keep the software model of the clock in line with reality, the
>> framework transverses the clock tree and disables those clocks that
>> were enabled by the firmware but have not been enabled by any device
>> driver.
>>
>> If CPUFREQ is enabled, early during the system boot, it might attempt
>> to change the CPU frequency ("set_rate"). If the HFPLL is selected as
>> a provider, it will then change the rate for this clock.
>>
>> As boot continues, clk_disable_unused_subtree will run. Since it wont
>> find a valid counter (enable_count) for a clock that is actually
>> enabled it will attempt to disable it which will cause the CPU to
>> stop. Notice that in this driver, calls to check whether the clock is
>> enabled are routed via the is_enabled callback which queries the
>> hardware.
>>
> 
> With the CPUFREQ referencing the CPU clock driver, that has decided to
> run off this clock, why is it not refcounted?

COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
to disable the clocks that were enabled by the firwmare and not by the
drivers.

the cpufreq driver does not enable the cpu clock.

so when clk_change_rate is called, the enable_count counter is not
incremented and therefore it just remains null since this was enabled by
the firmware.

I tried doing:

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb..5a9f83e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -124,6 +124,10 @@ static int resources_available(void)
                return ret;
        }

+ ret = clk_prepare_enable(cpu_clk);
+ if (ret)
+         return ret;
+
        clk_put(cpu_clk);

        name = find_supply_name(cpu_dev);


and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
the system wide consequences of that change to cpufreq.

maybe Viresh can comment?

> 
> Regards,
> Bjorn
> 
>> The following commit, rather than marking the clock critical and
>> forcing the clock to be always enabled, addresses the above scenario
>> making sure the clock is not disabled but it continues to rely on the
>> firmware to enable the clock.
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  drivers/clk/qcom/hfpll.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
>> index 0ffed0d..9d92f5d 100644
>> --- a/drivers/clk/qcom/hfpll.c
>> +++ b/drivers/clk/qcom/hfpll.c
>> @@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
>>  		.parent_names = (const char *[]){ "xo" },
>>  		.num_parents = 1,
>>  		.ops = &clk_ops_hfpll,
>> +		.flags = CLK_IGNORE_UNUSED,
>>  	};
>>  
>>  	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
>> -- 
>> 2.7.4
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
