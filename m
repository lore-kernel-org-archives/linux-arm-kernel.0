Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9AEC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C62621874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDMBfft4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmKT9n7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C62621874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2eGuZR43jN9xEk78gtVYaSxW/9SPP5+++0UbX9GaQkY=; b=mDMBfft4mKd8d3
	4OTkjwUvCcw7dIvu4NuwaJA43ify1ekZFS4kZ7ltWj/OID2IHvO6piPtMdK7pnhLiWRnSVCKFmhUS
	HVulZ6v1KXjf0ey5J+4SJs8L24MZPH6WJ/ohQ9HlZFmcrDW+NYD148QrL2B4FxRVNKGTllHanfspU
	9gphy103UF/xfkqjS1u8LzdRprvgyQFz+UuhsbOyLLDX8WgkDk6P4TLohQzaC3Zp2zSLX9eXf8xH2
	U+8JFohMOmjsMaRYSi8GIYvdWv/SEQ0wHB3vpPFTwPgU0s9qHFMPLBCh8jYKb9kfQO0ZzlqXGFhW/
	Xj24QlJrg8vd2xFl9ZyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golrM-000727-Hv; Wed, 30 Jan 2019 09:08:40 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golrJ-00071h-M3
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:08:39 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so20632872wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BSA7YxERtNe2YC7MWj+wV7PgS88YkA2xQTsk66XOsoE=;
 b=BmKT9n7l3o3+rSCnE+mbjXeBa2tqXHxg12FnpYIXCPmKxdrwdelq9E8tHmvsbX9wEV
 Q1mCaFsLpzh2aHBJFIzivbPqWUOyqxigWNtOhyhTpFPcZTEThX9dpePQ+tqXkLf7dhle
 QRFIv7iaGARi6lbOs9cTnxCOHUw/P//R1dX6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BSA7YxERtNe2YC7MWj+wV7PgS88YkA2xQTsk66XOsoE=;
 b=DncUIN0L28qtxGgF1aBFnBFXU1iUrYwmmCD8oHmd+S6O1oFa21+yJ5NQKc4EEZkBjE
 FNfqa4qXxc5uZbMG/UrtDQZkalYBM4WuohmHH5/KZpBj62p5xZkBLzt1nJvb1eCzme5d
 +sygDqYjPpQYpnFCpp8vcA41QBTcVmtSeORECe8KY8gtNA71/9ZMUiQyOdrkIpQVP0R1
 zdXDUWIj+wZYhN43bgF2/bCKI+IMKlJqP8YXdetPRDoYBu7seEieVIM3+9EXgJhPIh58
 1m641wxBW5XBHdrwxBqEoVDhggldxOgxwDS1V1wDiuW//bHbRv3KDnydRkZBRWZt30ge
 TYyw==
X-Gm-Message-State: AJcUukfN5C2QN3aEm2Djsyahyh8pG9PpI8o+Lm5kyqAyNHkV26iscdBE
 X2S/YzHji+h6kkxkKRubhDHf8w==
X-Google-Smtp-Source: ALg8bN6rJAKuW4fF48eWGDBDYGeNSxtSMW8lT/QNYzJS4c9As8gv5Fu0pdGKDeNTFV3vy8xqQMhIMQ==
X-Received: by 2002:a1c:8acf:: with SMTP id
 m198mr25846173wmd.143.1548839315555; 
 Wed, 30 Jan 2019 01:08:35 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id 199sm1133428wmh.21.2019.01.30.01.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 01:08:34 -0800 (PST)
Subject: Re: [PATCH v2 10/14] arm64: dts: qcom: qcs404: Add OPP table
To: Vinod Koul <vkoul@kernel.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130044112.GE4635@vkoul-mobl>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <8b80d10a-3433-4749-4d09-cf71ce799d63@linaro.org>
Date: Wed, 30 Jan 2019 10:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130044112.GE4635@vkoul-mobl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_010837_727764_EE54D909 
X-CRM114-Status: GOOD (  15.09  )
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
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com, sibis@codeaurora.org,
 andy.gross@linaro.org, jagan@amarulasolutions.com, devicetree@vger.kernel.org,
 niklas.cassel@linaro.org, arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 khasim.mohammed@linaro.org, enric.balletbo@collabora.com,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 05:41, Vinod Koul wrote:
> On 28-01-19, 19:32, Jorge Ramirez-Ortiz wrote:
>> Add a CPU OPP table to qcs404
>>
>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> index 9b5c165..4594fea7 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
>> @@ -62,6 +62,21 @@
>>  		};
>>  	};
>>  
>> +	cpu_opp_table: cpu_opp_table {
> 
> This should be:
>         cpu_opp_table: cpu-opp-table

yes. um I thought I fixed this ..sorry about it.

> 
> IIRC node names are not supposed to have _ and tags not supposed to have
> -, please compile with W=12 to trigger these warnings :)
> 
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-1094400000 {
>> +			opp-hz = /bits/ 64 <1094400000>;
>> +		};
>> +		opp-1248000000 {
>> +			opp-hz = /bits/ 64 <1248000000>;
>> +		};

also need to remove the frequency below. I might have sent the wrong
version of this file

>> +		opp-1401600000 {
>> +			opp-hz = /bits/ 64 <1401600000>;
>> +		};
>> +	};
>> +
>>  	firmware {
>>  		scm: scm {
>>  			compatible = "qcom,scm-qcs404", "qcom,scm";
>> -- 
>> 2.7.4
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
