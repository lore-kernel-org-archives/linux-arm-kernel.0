Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8638C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:42:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715C8213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZGFv26ds";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0mgJ4q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r5Lp2Alh5oNYnq1Sc43VdU+uzEwVotAjBB24VhJsw/Q=; b=ZGFv26dsIB+VstzifD/23uGFC
	E2fjp11ThEiapQ7dNOt7xSkBOYUzZSBiAtuPyTYItyRJdJS9E2ar2vtNJsDGdNpWOwN0k/i27Jkhv
	G4ap97+XndLSUq/jWovZCXLXFuI3vTvg4Q86UMh3/4ewbSkWThWCZCfZqhrtVLOq3u3EBs83PrzqZ
	dfiKvC6ycT9w5VKt4R0L4y3HC5F5+tKbLhu0BdyaLZIzAlZcD3MSOrjw1+TeXVLX/uQEuKNitzbq7
	zOaxHcaEaBxB4pUxJZvzeEgqJ8CdBi8QgB+nhesga654FY35IsSNFjuK78Ug6Jk1pRmLbXuaKrb3D
	Oz7Yx8k3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdt9l-0002e3-D3; Mon, 31 Dec 2018 08:42:41 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdt9h-0002dX-UV
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 08:42:39 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so23079031wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=El90UuvXSTwvHkTCycgQ+Zo1FPArY4bUiDSukrnlXpo=;
 b=B0mgJ4q8VvsUUC6I+FZaFu3eQ6CD5FFUjZpzdzCpOem5TjESV0+8tPdYbh849/DRkt
 X4sZo9vftrf83GdHq8pEGjl9JH8SU8JWhofQQtS2LGx97/7fG1VnAsttLZnHV7F87UpA
 d/lC4UMEBTm38vD8QyWYTYVmcEKRVFtUheNf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=El90UuvXSTwvHkTCycgQ+Zo1FPArY4bUiDSukrnlXpo=;
 b=MoFKNwDtQmFKugbjH+PUBQSzHLnQQ42Uv/imckTrH0i8xtbCTfx0yZRYQC4lQPBNHJ
 9vXGmsAoNJ5oyFXPtIyeTGqS2r1exndGoPNU1s3aZUfp6A0l7l7repJa4KftssvbprU8
 MiOJw8pmy++wLqsrgE3lJ8/mQ+rP6+1EBswrSPDZeWYewHW5Umt3qo+YKHw27vu1Av82
 +Ko49RfzN1S5m+Z0r6WXVs13qzwmfifvt+a5EwhSKf7ETSvni7xY1V5MYVUxoUEivT7f
 nj2XYHagtlvN3sbzFNWnDQg4iw7rM2+6Uqk0gz4noLnZ+alPRCLiDo2timdGubLJiYR2
 B5lQ==
X-Gm-Message-State: AA+aEWZ3ND1tBpg+EProJbZPkVLIvYtJIDvpiTgSQbsEwlbhwOKeRZrc
 p+h1cNSv7eRq3/6eEzDiOc8YWw==
X-Google-Smtp-Source: AFSGD/WEKyUwv2tuz8D2f7vDYkbd3Buv/bJHy53tqnckCpIFz1B/AtUQ3hNtKf1utkb9M7je68532g==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr29394245wmc.129.1546245755633; 
 Mon, 31 Dec 2018 00:42:35 -0800 (PST)
Received: from [192.168.1.2] (92.red-83-34-185.dynamicip.rima-tde.net.
 [83.34.185.92])
 by smtp.gmail.com with ESMTPSA id g198sm53816074wmd.23.2018.12.31.00.42.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 00:42:34 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To: Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
 <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
 <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <45a9e033-16e8-e0f9-36cf-3b892af1bd8f@linaro.org>
Date: Mon, 31 Dec 2018 09:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_004238_003856_FED44D9D 
X-CRM114-Status: GOOD (  17.44  )
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
 arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, vkoul@kernel.org, enric.balletbo@collabora.com,
 georgi.djakov@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/28/18 23:28, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2018-12-26 01:20:07)
>> On 12/18/18 15:35, Niklas Cassel wrote:
>>> On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
>>>> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>>>>> Allow accessing the parent clock names required for the driver
>>>>> operation by using the device tree node.
>>>>>
>>>>> This permits extending the driver to other platforms without having to
>>>>> modify its source code.
>>>>>
>>>>> For backwards compatibility leave previous values as default.
>>>>
>>>> Why do we need to maintain backwards compatibility? Isn't is required
>>>> that the nodes have clocks properties?
>>>>
>>>
>>> Hello Stephen,
>>>
>>>
>>> This is the existing DT nodes for msm8916:
>>>
>>>                  a53pll: clock@b016000 {
>>>                           compatible = "qcom,msm8916-a53pll";
>>>                           reg = <0xb016000 0x40>;
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>>                   apcs: mailbox@b011000 {
>>>                           compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>>>                           reg = <0xb011000 0x1000>;
>>>                           #mbox-cells = <1>;
>>>                           clocks = <&a53pll>;
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>>
>>> This is the (suggested) DT nodes for qcs404:
>>>
>>>                   apcs_hfpll: clock-controller@0b016000 {
>>>                           compatible = "qcom,hfpll";
>>>                           reg = <0x0b016000 0x30>;
>>>                           #clock-cells = <0>;
>>>                           clock-output-names = "apcs_hfpll";
>>>                           clocks = <&xo_board>;
>>>                           clock-names = "xo";
>>>                   };
>>>
>>>                   apcs_glb: mailbox@b011000 {
>>>                           compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>>>                           reg = <0x0b011000 0x1000>;
>>>                           #mbox-cells = <1>;
>>>                           clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>>>                           clock-names = "aux", "pll";
>>>                           #clock-cells = <0>;
>>>                   };
>>>
>>> qcs404 specifies two clocks, with an accompanied clock-name for each clock.
>>>
>>> msm8916 specifies a single clock, without an accompanied clock-name.
>>>
>>> It is possible to append clock-names = "pll" for the existing clock,
>>> as well as to define the aux clock in the apcs node in the msm8916 DT:
>>> clocks = <&gcc GPLL0_VOTE>;
>>> clock-names = "aux";
>>>
>>> However, since the DT is treated as an ABI, the existing DT for msm8916 must
>>> still work, so I don't think that it is possible to ignore having backwards
>>> compability in the apcs clock driver.
>>
>>
>> so where are we with this?
>>
>> do we remove backwards compatibility (see below] for v2 or is the DT
>> really an ABI and therefore the patch under review is good as is?
>>
> 
> Breaking compatibility is up to the platform maintainers. If anything, I
> would make the DTS and driver changes in parallel and then remove the
> driver's backwards compatibility logic later on.
> 
> 

I am not completely sure of what you mean. are you saying that the 
original patch is good and we should just provide another patch (not 
part of the current patch series) to remove the compatibility?

TIA


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
