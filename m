Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48133C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143BE2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j+wbzkIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143BE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eDkFhmbE/+ud82apCpJnlyecoIYs+wI8IbKrM0KYroA=; b=j+wbzkIT0I44vf
	hNtlgDPvBk1ZgTvCXDNadd0mfKEQtGeI9zFMtLX/Nam3lu8aLw/K3akNDvQ+wELed9WT8RvsS1KAU
	EwJajMF4dm8cL1thRDbeeDQtu8+zwhIveAGIFSkvJUQrM0R1hqii1W5LFFnfhvhHmTYPppcde8FOu
	+T0Tj2rEm2obEBMFN0b7zFk9v80UeP1491USdMzc0oW6mpwCLp9hNRsU3HRQ3kV3X1d/EUGcA/ccj
	jDt0chRY42BC6a3tLO0G+6+fJKdXlG6uKDgnadr9YOrFTk7eCXnhmIhbNfjeQx/oCVG2MjFq69ob5
	lX6OTI2mpcjyvWwdJodw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTwS-0000vt-3z; Mon, 10 Dec 2018 22:22:20 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTwO-0000v2-EV
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:22:17 +0000
Received: by mail-ot1-f66.google.com with SMTP id t5so12109160otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mD3hTgKG+kAzWU2qpeROvIPDZyqqXzsIxk4QtDaleJU=;
 b=jJt1XzTKNrACb0fMKb70mBnHL0MauIWjVbxP8PJZN6rGa1L4Br0hxUJnbXjJXVIRb6
 Ttdn/2g6hhXISIfozekmkxvbjgYJlMenf1s7lBoHjxMXgy6L8za+/u6Fag2UPn/55O3H
 KKBTgGgGmlL3a1ICcvHYIeGj8c4PKKpou1Fghiua6ok9hQ4EuwNN+fZWJTzvBAJJ9T5l
 flb0MgheyU91SjBVIQUz46FxCrFR3U9zz1ycgOpMyTxRASD0gB4D3sYiy/Lugl09P3gI
 Wyl5J30x8r+brP/Thba5Eos1GN1CMiovQ0ucF6iYEkrZlw3NHpRVYAv2xmjlZFqfeDfe
 vAvw==
X-Gm-Message-State: AA+aEWbqKKUAVugWUHK/WUwozea7W3H/oa+As/vrXEr2xsP0Kts4YKNb
 FUkh33BIyN7xbw5Mgjpmtw==
X-Google-Smtp-Source: AFSGD/UhRTCXzAAO/kNvwXMfrZe77bXgksUPeiSME1jKSBsVFLZNatFVX1D8vobzfdbjZ1cpXaKHMg==
X-Received: by 2002:a9d:2da2:: with SMTP id g31mr10228310otb.310.1544480525256; 
 Mon, 10 Dec 2018 14:22:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s186sm6021009oif.0.2018.12.10.14.22.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:22:04 -0800 (PST)
Date: Mon, 10 Dec 2018 16:22:03 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-bindings: fsl: scu: add rtc binding
Message-ID: <20181210222203.GA27927@bogus>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543455856-18021-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_142216_491760_5F9D16B6 
X-CRM114-Status: GOOD (  14.91  )
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
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng DONG <aisheng.dong@nxp.com>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 01:50:04 +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and secure RTC etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to do RTC operation, this patch adds binding doc for i.MX
> system controller RTC driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move rtc binding doc to scu binding doc since it is belonging to SCU.
>   *change compatible name to start with "fsl" instead of "nxp" to align with other nodes in dtsi.
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
