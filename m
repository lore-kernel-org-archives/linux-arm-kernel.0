Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EDC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:09:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E7A21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8eqmL7r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQnOohxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7A21904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CWRzyWqrSXz0AxeWD+oEceRQajiXUU9Sh1RV4ZGMp8I=; b=d8eqmL7rxTfLu+
	DeYj1zBm38X+XEy52lMG4WQ5tPQ89lWVFl7FkUwtmB1OGOfSh50ucH5wR+JFOJtTKIEEZb8y74PKA
	3ODU4tPT9hE+/EY24dO6ieU0fHThLbN5frjeoB7gTBA2iOsR8IeU2pnmZtNbE1yjeG9nd1/KQcSZJ
	sI0mOG1t95vy0aZFy4F1HPBLO22Ey+HDaZKUh+Y/zanX/fP2e8pXxBlKTZ06xE+O0jZ/htXR484PC
	1DMva8a5VgEB7V0up4nZxTii2cQo59FTmdxOfE6wsOuDp0qLVklPwNwqlhV0rvn+tdSfuG9RtdcwP
	U2oz8ceq40Eo/v4sEJ0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtofQ-0004iz-JG; Wed, 13 Feb 2019 07:09:12 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtofN-0004iS-6H
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:09:10 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so756681plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 23:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vykvHra8yq7WQFpSVoMklR3MmMLAQ8rqYPPLApssG0M=;
 b=EQnOohxMtVenP1TgNqecDBgl7ZUw2GguD/DliPNQ/LXbSijsAL5WJFL1LogwX70x8Q
 7Aj7KIOFAOnJrMAzotfhh+ojG1GTWs75ZU4D8T7hwC/IFFr5Z/oS49YmEiABxAhfA/sF
 wGuNfhvfQU1/n4glxLX+/Z69gBfQ0ii8gWhNKkCpj8eherLrr9QfMiU6T/CdZTMzJWRn
 AZ6Q0f7AhaVbvg2cFVuzNOKVQ2eb0IMtYWqrTM/LmlcTrO69Adj7V8+opkobRmYeuwTN
 l6WCThKJ9zdaEYISTF/Cxvk5Br/Y14AElly+gWSbaPl65nRAjEaSv225SYLPBtbTQE/4
 PXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vykvHra8yq7WQFpSVoMklR3MmMLAQ8rqYPPLApssG0M=;
 b=dpxhA7Kel02BCkl9fqCInZ/7AXwNqS07svrBevDUy2ZoQAnxxLlOPclGGjZdGoqzec
 EekJM1iAGvDZp5fkQyQrRsfAVB/xHlfa0gShGHIIdJAis9eBY665npFDsRomPRlVOpCj
 Up3Dr9/yqDM0gHoIlrU3gSMWCIg9b0TxAwCvGKtOiH03qdiihuoJQ/wINCdx5+oOcRdF
 GqapdoYca7PBIP0TUdHSpK9+OgbHd2LPX241aOVfIv38j4CpNhdxpwC3imba5+RKVDX+
 e+R2JKjMA0oQo+VCFrIbVOER6QLu3QskMo9nKV8uJEkR5vjFpz3XrDGYEoskeJt+WocW
 FQkQ==
X-Gm-Message-State: AHQUAuZXxOP9xk5cktY3cp2XnYExtxSuwqkxNwSw7Vm3OWZ24uBLgCf3
 kpn/j2eMJ9Pj/ZTWFxGo2pBSVQ==
X-Google-Smtp-Source: AHgI3IbxbJy3iUVtynJLH70BaBWHG66bzG/Xifqi0gYpqFDzKBcYJwwASXDG3T5cW9S5Z4C9Dz9h1g==
X-Received: by 2002:a17:902:2a69:: with SMTP id
 i96mr8278118plb.58.1550041748336; 
 Tue, 12 Feb 2019 23:09:08 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id b2sm19014678pgg.87.2019.02.12.23.09.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 23:09:06 -0800 (PST)
Date: Wed, 13 Feb 2019 12:39:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Message-ID: <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_230909_355429_41E7B459 
X-CRM114-Status: GOOD (  14.90  )
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
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13-02-19, 03:09, Anson Huang wrote:
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux cpufreq driver has
> to call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
> 
> This patch adds i.MX system controller cpufreq driver support,
> when doing CPU frequency scaling, cpufreq driver will do ARM SMC
> call and trap to ARM-Trusted-Firmware, then SIP(silicon provider)
> service will communicate with system controller for CPU frequenct
> scaling.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/Kconfig.arm      |   9 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/imx-sc-cpufreq.c | 183 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-sc-cpufreq.c

Why can't you use cpufreq-dt driver like everyone else ?

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
