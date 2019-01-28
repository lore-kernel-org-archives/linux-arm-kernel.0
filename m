Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6741BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FDD20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uUDaeRZT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZ+AhGt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FDD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=utbTfDSonJSP2M1wCEtg/uRifAYzS43e7NNJlj3w9hw=; b=uUDaeRZTCJOodj
	Wmd1iiQRkorcaiAx8AtpHS4bsjt10RgsAUEtjcL2TxZ+h2qCsh/SdAYdznvfw8Pm3NW2a7eXbjNjM
	yLp6IhG0M8FWo/9kEEzBVn1LOhYaB5IsSotF9bTbLU2EVW/rHUWtS6n3MkGr7P39n2ohGe7Vz526u
	zc92WlVUak+GkptbQl8h75+X3lF+tk8VHy7VEuQKjA4rL51SryLLUn50znG4wUXTT0AV//JyeshEu
	J533aIUi+KuQrM0Of5iKJ14oIogtKisDzVFoMJdrOK5lhyB4APCjXRujxLUSguZ/FUHntP9sTSXE0
	AzeVO2D76JYsxC/vUbmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goAzu-0006gV-Nm; Mon, 28 Jan 2019 17:47:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goAzq-0006fj-Ny
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 17:47:00 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so19051495wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 09:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ucQoGI6eeDkSCShaaooJTeyuH9/2ggLECWyCdy0UcdE=;
 b=AZ+AhGt3GDIcMDCN1ieBAUHdPcIEf54BWaUxhx8Zh3G8HMNDOOmQLKzhMx3kePnFK7
 ugDXMg51x++zWteWlx6INVaP1eUhiZkNQ/8kzRLOBPwRSbSGuRU6BpoV09f2xnTEj1Po
 GBELGfL6ywrs8GSnUz3MQ8TwsJQqTTEu0Sk/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ucQoGI6eeDkSCShaaooJTeyuH9/2ggLECWyCdy0UcdE=;
 b=CKpg75LDZt8dPh2ZiRDJkQ/QfZawloyUlb9yNf+am6wCoMgW6KiY7cGcqUpLAvXGiT
 30ziamN4jcPKz14JTMNg8YbSG8SmHUxG9D+aFzINAUrtMwdc7TkDtnTQTgnrRh632/3o
 21XV2K6fS6tg3FjrzrQi+rhHRVuhuqm9XT6RF5qHT/n0CDCuIp+gZgrlMAve8ySH33fx
 qMt0eit78uOrXt0d4IwOJNU1XWIxkoFbNr1FVGhp9QUc39b5+O4jpuG1iKUQh8rLbo2Q
 Q3mFxxEWusRNzEYfGA8zG4mkatKIM2FBX7mfSzzy4WKbVmxJFTz0L3Kb0Sm0F2MzJAZa
 hJhQ==
X-Gm-Message-State: AJcUukeCkt+vCXkUxM6cZhvde03nSGxtTRrK0EbjP6YrhcdIL/ZAQuxe
 1XlXL2eq7AAxgIi9Vq/fCqDhHQ==
X-Google-Smtp-Source: ALg8bN5c7UXcptN0BFXX6GWnquBg0Rtoe+FpTxTz8kwdYPBw190i5XL5ybDbrHt2ua8a+GUIQBbQAw==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr23337367wrs.279.1548697616367; 
 Mon, 28 Jan 2019 09:46:56 -0800 (PST)
Received: from [192.168.1.2] (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id c14sm96884wme.13.2019.01.28.09.46.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 09:46:55 -0800 (PST)
Subject: Re: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name optional
 property
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117064411.GK25498@builder>
 <83e77b69-9a22-641f-ada9-7dac565160e1@linaro.org>
Message-ID: <be1a6252-2854-c095-e8aa-05b3e35c83c4@linaro.org>
Date: Mon, 28 Jan 2019 18:46:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <83e77b69-9a22-641f-ada9-7dac565160e1@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_094658_784327_4FF8094F 
X-CRM114-Status: GOOD (  24.20  )
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

On 1/28/19 17:57, Jorge Ramirez wrote:
> On 1/17/19 07:44, Bjorn Andersson wrote:
>> On Mon 17 Dec 01:46 PST 2018, Jorge Ramirez-Ortiz wrote:
>>
>>> When the APCS clock is registered (platform dependent), it retrieves
>>> its parent names from hardcoded values in the driver.
>>>
>>> The following commit allows the DT node to provide such clock names to
>>> the platform data based clock driver therefore avoiding having to
>>> explicitly embed those names in the clock driver source code.
>>>
>>> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>>  .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
>>> index 1232fc9..f252439 100644
>>> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
>>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
>>> @@ -23,6 +23,10 @@ platforms.
>>>  	Value type: <phandle>
>>>  	Definition: phandle to the input PLL, which feeds the APCS mux/divider
>>>  
>>> +       Usage: required if #clock-names property is present
>>> +       Value type: <phandle array>
>>> +	Definition: phandles to the two parent clocks of the clock driver.
>>
>> I presume you meant to replace the existing definition of "clocks"?
> 
> I am sorry didn't reply to this earlier. Yes this is not very clear.
> 
> This is required as an extension to the apcs-msm8916.c driver also used
> on the qcs404; since it is an extension, the previous definition should
> still be applicable.
> 
> In the case of the msm8916 the #clock-names property is NOT necessary
> (it would be ignored by the driver), so having it should not mean that
> we need to have #clocks.
> 
> In the case of the qcs404, having clock-names means that we do need to
> have #clocks (hence the additional if)
> 
> and not quite sure how to word this condition in the bindings..
> 
> I am going to post v2 with some updates and if required will post a v3
> with more clarifications.

In the version that I am about to post I ended up following your
suggestion:  replaced the existing definition (and the apcs mailbox node
msm8916.dts) but  kept bacwards compatibility in the driver (so old
bindings will still work).

That should enable migration to the new bindings -as per the
documentation - for new platforms (something that IIRC sboyd also asked for)

> 
>>
>> I think the purpose of "required if #clock-cells" comes from that
>> meaning that it represents a clock-controller if #clock-cells is
>> specified, in which case it requires the upstream clock(s).
>>
>> Regards,
>> Bjorn
>>
>>> +
>>>  - #mbox-cells:
>>>  	Usage: required
>>>  	Value type: <u32>
>>> @@ -33,6 +37,12 @@ platforms.
>>>  	Value type: <u32>
>>>  	Definition: as described in clock.txt, must be 0
>>>  
>>> +- clock-names:
>>> +	Usage: required if the platform data based clock driver needs to
>>> +	retrieve the parent clock names from device tree.
>>> +	This will requires two mandatory clocks to be defined.
>>> +	Value type: <string-array>
>>> +	Definition: must be "aux" and "pll"
>>>  
>>>  = EXAMPLE
>>>  The following example describes the APCS HMSS found in MSM8996 and part of the
>>> @@ -65,3 +75,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
>>>  		clocks = <&a53pll>;
>>>  		#clock-cells = <0>;
>>>  	};
>>> +
>>> +Below is another example of the APCS binding on QCS404 platforms:
>>> +
>>> +	apcs_glb: mailbox@b011000 {
>>> +		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>>> +		reg = <0x0b011000 0x1000>;
>>> +		#mbox-cells = <1>;
>>> +		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>>> +		clock-names = "aux", "pll";
>>> +		#clock-cells = <0>;
>>> +	};
>>> -- 
>>> 2.7.4
>>>
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
