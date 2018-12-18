Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FAB217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvgCVCfZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHYnOjjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FAB217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DIXyfSQMTeRN+mIcg+J6NCqDrqWv3ndtCqACseOf5Vs=; b=QvgCVCfZgSPk5QO4fshyekvKu
	cMVNAEA8c73L+waSS1xn/9tHzw2yrWTQsgsJJ7vbg2OhUcPccydPN6lMaz/O29DhuxyN/dcHMwYW6
	1xMFv7NbTFL/dCtU+ImPy81LLnwwjj10MOf227V0PyEk4s6rqYaEOK9rppOsJr/79O+dlWxihw296
	il6WE/T4YnZwHUOc6dTYocqYJrkJ8QnrqAWTVMQIRrpwc6MoTYwCfWnAI+G599al0SrXKqORWEvzH
	eQ22dU6sJiHFVCVOjXn+QglwsPv8nvBQL+2+FfuMD16jY6MVN8312aRRuX86qKR9l6x2YeGElLEyS
	1plwAoMCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAst-0000AY-Ra; Tue, 18 Dec 2018 08:37:47 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAsq-00009h-3U
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:37:45 +0000
Received: by mail-wm1-x343.google.com with SMTP id c126so1831112wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vqzAn8YdXf7bnKbmiNaQpJRP/lxpkAy0aohkam2JcmM=;
 b=bHYnOjjn2s3GTiS7z+a5A7Yju2c7cNxMykNvVEZUM04K2uMYWNV8/JDXs0SKhjj27H
 FtZ0G1fVVDeuGAWbJKiqO8JTiwKEHCFTnOWDt59CxF1UXJyQ/vK5eFots9L5AMC7pioz
 nRPm5g9R65iyLhFKnjDU1a6FqqcqeCZ0mPGHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=vqzAn8YdXf7bnKbmiNaQpJRP/lxpkAy0aohkam2JcmM=;
 b=Bn6m899t49mSsvTSL9yazZsLZYqUUg/9Uw2OvamyTap7ml67XC68gIx/eKH4Hnh8nn
 8TzzwA8QuzYPnn2g0dYDfRWyPANlPYIzpKWYf5a03pEZNnFn+dVl/Ko5LYOHdOYChgxq
 ARQ900Mi9CEoWYyt/vyym2zKXfXXU8UY2BpIkEUavTyPMEcxF+ZBh04eVCNgd2x+i1aR
 /hK+RitRCrYZX55GY3b2ky1JKEyjFqBPEzhyWy3AWYfMCsnquAT5RQR9+KS0YJumekFe
 xSCb6tY8VPqIcpaoUZ4Yzo2EIohyQhgfRmto9apLZarE6pgi8MsXr/cubInHgi0p7rUN
 DY1g==
X-Gm-Message-State: AA+aEWaBleGuLpYvvR5wLAREQr+0ub31mGfw24MoUzFp5hICx3ZYrOIq
 AC9oPMgteTiHSStN07thG61Mhg==
X-Google-Smtp-Source: AFSGD/VQdMEMYeOxmFC4VnfdFgbB1mb+XZpzdiJP/7dmVGSKr7jNqCPUjEQu+aLI+vs13q3qjAtVoA==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr2135630wmj.147.1545122252603; 
 Tue, 18 Dec 2018 00:37:32 -0800 (PST)
Received: from [192.168.1.2] (74.red-95-121-88.dynamicip.rima-tde.net.
 [95.121.88.74])
 by smtp.gmail.com with ESMTPSA id j33sm3629702wre.91.2018.12.18.00.37.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 00:37:31 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To: Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
 david.brown@linaro.org, jassisinghbrar@gmail.com, mark.rutland@arm.com,
 mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <57ef23b0-9c6b-cdd4-9a1a-41c6d5b3aa93@linaro.org>
Date: Tue, 18 Dec 2018 09:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_003744_143660_04737019 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 jagan@amarulasolutions.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/18/18 00:37, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>> Allow accessing the parent clock names required for the driver
>> operation by using the device tree node.
>>
>> This permits extending the driver to other platforms without having to
>> modify its source code.
>>
>> For backwards compatibility leave previous values as default.
> Why do we need to maintain backwards compatibility? Isn't is required
> that the nodes have clocks properties?
>
>

this driver -apcs clock controller- uses platform data (not DT) and 
therefore it uses the DT from the parent node (mailbox).
And for the mailbox the clock property is optional.

So the APCS clock controller requires that the parent provides at least 
one clock but the clock is not mandatory in the parent DT node.
For instance in the case of the msm8916, the parent only provides one 
clock, just the pll.

am I required to modify that platform instead of maintaining backwards 
compatibility?






_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
