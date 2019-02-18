Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E218C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF754218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgd/StUC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsXI8gY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF754218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cfJGZjPBqrZss3pHdcmPqAcD3ieKJ/aN7ZhbkQyQilQ=; b=lgd/StUC2Jz6hQ32eazMTx3Aj
	xSsUjEDqv8KUPLsbAo6EWnyvxf4COIbHcWMDmLckbDMemzeCYCk3nZ1N3lNbgNF9qj/yA2RZwJoz0
	WW54uDcq2m4yPo3R11a60pyE4W/aZlggW6CQXM1jYxzwNhBc/GNKaPoZkCpymq0oxiorWhA39zlxU
	OGSc6GV4dlUi1q1AHCpUA8CqH6M96WEkO56CLqCjMv1KbAxoWGNYoxY60dXyl0injXKaxdSaidJrs
	b59KDUijehLJBu1YVVGyisN2QGs4UQo61KeU5aEXdn8lYMNI/LgG827TGGwkbzBudWYVDGxPCSWP9
	LKckgLpow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbIi-00021a-K2; Mon, 18 Feb 2019 05:17:08 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbI3-0001JX-IR
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 05:16:50 +0000
Received: by mail-pl1-x643.google.com with SMTP id f90so8147047plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 21:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PKFECZ5umUjSMFwIhtRIzVOdsQXCiPiFeK7HIxsdO6k=;
 b=MsXI8gY+iTZ3qCuJ/nuqpcZOdxp2PCJu16sooVcW/D/krbvTMeurpqvoxu2Kdt9Mv1
 qdNTzwJjROOV0fErfPrEe/R/KW3d+NQ3uC5MAc+I0OFu0Z2yOnzsH2pdNB8YT8m2hIJ2
 MtxRzXX6Rxnv8VkXSovZaYOpOqut+YcGNWVN1UGf0bA9qtDPC2fl6MegqvzjuBxfddns
 ZJRhBYvStQfbTM82jZi/Cj6XINbwF1ZStDKHj8OHaFp7Q29+Gs6/9oSuSyN541b9uBW4
 S0m8zQrZx0Ub8qM2gZB3RhqrrY+J9CNfzk1tSLI5hvoxvLMc60FruKes+/k+3myomGbM
 Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PKFECZ5umUjSMFwIhtRIzVOdsQXCiPiFeK7HIxsdO6k=;
 b=JABnzBwZQ0mhRDODP5WMzh/0XtDb7cwjhk9hHyFQhwLt3xHC0pDBWDCKbg8KGjMwNn
 z4l22po6JPB/kC9eVOfLfy2dmgQesCxCcB23CKuhmrhBNGx2piRnS547tsOcvLa+SbBM
 i+H5TpZV2DW/MJloCqXsnMzpzYeeoAaLQXBch+WQAndtlL/MVuVsPXnAOev2OkVrttCM
 LQrK2k9Zjkbl3qrnuMN4+Gs8G0hT+XyTpKvoh9lTfsBUo0k9yEc8pgEsGoW/6lNxWxrn
 7dNxybKeEhOog45RRqJAOFcd/kIznvXYD91BjmCMvr54fpJnX/XERP7FUcMaZnyXD/sV
 Dtcg==
X-Gm-Message-State: AHQUAuZh5wzTdxZp1pLei/KP/HDt7Azg8DH7x57S7Epx0JjOMIx5mv3N
 Y56hp1gxxz9FGIbdx3ttS88=
X-Google-Smtp-Source: AHgI3IZa5g0R8s8ePeEkeeZhbgbIEELaMO+L2D9JgIb4Pf658PwM9TXCuj9dau+3137ZkVwxGg5cig==
X-Received: by 2002:a17:902:9008:: with SMTP id
 a8mr23586735plp.38.1550466986589; 
 Sun, 17 Feb 2019 21:16:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 e7sm13447966pgv.6.2019.02.17.21.16.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 21:16:25 -0800 (PST)
Subject: Re: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
To: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "heiko@sntech.de" <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "olof@lixom.net" <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <02ea476f-d055-ac12-d1b6-c6caffb14614@roeck-us.net>
Date: Sun, 17 Feb 2019 21:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_211628_085748_887AF034 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/17/19 6:01 PM, Anson Huang wrote:
> i.MX8QXP is an ARMv8 Cortex-A35 SoC with a Cortex-M4 system controller inside,
> the system controller manages overall power, clock, secure RTC and watchdog
> etc., so Linux kernel running on A35 needs to communicate with system
> controller for watchdog operation, this system controller watchdog will
> call SMC to trap to EL3 secure world ARM-Trusted-Firmware and then it will
> request system controller to do the watchdog operation via IPC.
> 
> 
And you expect I'll spend the time comparing this version of the patch
series against version 1 and figure out myself what exactly changed ?

Guenter

Below are the patch dependency:
> 
> The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series as below:
> https://patchwork.kernel.org/patch/10800699/
> 
> Anson Huang (4):
>    dt-bindings: fsl: scu: add watchdog binding
>    watchdog: imx_sc: Add i.MX system controller watchdog support
>    arm64: defconfig: add support for i.MX system controller watchdog
>    arm64: dts: freescale: imx8qxp: add watchdog support
> 
>   .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 +
>   arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
>   arch/arm64/configs/defconfig                       |   1 +
>   drivers/watchdog/Kconfig                           |  13 ++
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/imx_sc_wdt.c                      | 210 +++++++++++++++++++++
>   6 files changed, 239 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
