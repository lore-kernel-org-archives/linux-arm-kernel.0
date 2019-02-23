Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:08:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD77320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HY9ns2iZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUID6WCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD77320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QB6qWq7U9VrVQL5hwpOTbJ4j5VX2Fd0qvY1mNlNuxvU=; b=HY9ns2iZdpWDaG/B4tgWHjyqC
	zE0tevwhbiHVCZDhinVL4hnt9mGR5aMw9XjT1rqBgQ3/LnYMYkDwK+orqdO7Fd/UEFgRX8chDUAzP
	pGgsIZuj39fXwxl5Y0y52cIjl5yi236uVPSUZx0aKJRMPHM7CAmD5f7fxzjIiPZ73WbpFeP1YyM5t
	2/Ws9vzlCQjY3mbdGgOw/yVIG71PVt/2ncj/w9KMA3VDBKJ8KAHYTIJu667MLeOP6gFgzrbdnCpSX
	ryHhvmsJlZOmMXR+j57NPQnxO0uxcZ1bh3pA5eZQCPpf6pzso+ZJIBy0RtFn2NChAcB0UtkbSsxuK
	OFh2CdOjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxamh-0004NC-KY; Sat, 23 Feb 2019 17:08:19 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxamc-0004Ml-NQ
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 17:08:16 +0000
Received: by mail-pl1-x642.google.com with SMTP id e5so2528073plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P9zrcJ5ZVjiahSM/zDa8W1CZlUjkwmjyOeaNOp58rtA=;
 b=RUID6WCQvqT7YEb3Z3huI+Ac/gFHoNsWLepWDXdTvYyXGa3R2i/ZDZyeATz3zHE3fo
 M9iZCc3sWeERV27+sc/zgbvTVrxvuqTEKE3faZTIw62ZC4lm9hPwEICgzPlPcGsS8Vga
 hPspYRVIOMoeHbQLvzBnlIKhO1ZTziTPOTrF4gWRRAgJiJOkpLAWLyHsaVV1Fy34nucd
 +D6vRp5C2jzjBU58rlyY7cZnguqS7uJzNp9+AoMZftVe4yz95we8WqHEsjjLZwDnbo6I
 e4FloBI/UF7egCxqJEban8kTTM8knnhChWybCb1mnF7OOK1E/VFfawQrlFFMLIQrn7S7
 PKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P9zrcJ5ZVjiahSM/zDa8W1CZlUjkwmjyOeaNOp58rtA=;
 b=nebV6YtTh+93BWPZQxSnxSvnx8vcDlTby9eaz09rmztOnHdT96LkUZ2Sr74NoTU8z3
 ICThx//vdErpL5LASNkztx8Lye5G5lxDbPrG1THmSrB/xebx6FB8TNLs9Pq/YJq36D/t
 s894OHRZ370p5iLnw9OpVs1/5W6O4clb5seE5dQk5xGCRqCiGLxMqKQXjqZMoDMkudcB
 1ZCi1GM1lz1pStCfPST7DFqd3Ad7eNQU7/H/a3hjvOT+JXvVw7EUNmkXAkaU6E+JwGxz
 Jr9MrVO8qWdfabZRn9H15RN0yHUjylSMIkuCuv69Hydiek5yWVMweedpgZKMhCNOVH6S
 NVZg==
X-Gm-Message-State: AHQUAuZGt7flOji+pwfs8HCLZ6fy1hsqZcT2fu/hhWHxXB+qE0T6WYjK
 7LuzT3+6fTNWNabBUX6GQkU=
X-Google-Smtp-Source: AHgI3IZHgbp9uHcUuzMyBu17th+hht94AVajiXej7g2jrqtrJfnUr7Pfw+r2+DDKiHZ3wpWtfb/4Pw==
X-Received: by 2002:a17:902:8697:: with SMTP id
 g23mr10451224plo.30.1550941693427; 
 Sat, 23 Feb 2019 09:08:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 u66sm17146417pfi.115.2019.02.23.09.08.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 09:08:12 -0800 (PST)
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To: Rob Herring <robh@kernel.org>, Anson Huang <anson.huang@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
Date: Sat, 23 Feb 2019 09:08:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222195217.GA22194@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_090814_789948_3368B140 
X-CRM114-Status: GOOD (  17.79  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/22/19 11:52 AM, Rob Herring wrote:
> On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
>> Add i.MX8QXP system controller watchdog binding.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> Changes since V1:
>> 	- update dts node name to "watchdog";
>> ---
>>   Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> index 4b79751..f388ec6 100644
>> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> @@ -136,6 +136,12 @@ Required properties:
>>   			   resource id for thermal driver to get temperature via
>>   			   SCU IPC.
>>   
>> +Watchdog bindings based on SCU Message Protocol
>> +------------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "fsl,imx8qxp-sc-wdt";
>> +
>>   Example (imx8qxp):
>>   -------------
>>   lsio_mu1: mailbox@5d1c0000 {
>> @@ -188,6 +194,10 @@ firmware {
>>   			tsens-num = <1>;
>>   			#thermal-sensor-cells = <1>;
>>   		};
>> +
>> +		watchdog: watchdog {
>> +			compatible = "fsl,imx8qxp-sc-wdt";
> 
> As-is, there's no reason for this to be in DT. The parent node's driver
> can instantiate the wdog.
> 

As the driver is currently written, you are correct, since it doesn't accept
watchdog timeout configuration through devicetree.

Question is if that is intended. Is it ?

Thanks,
Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
