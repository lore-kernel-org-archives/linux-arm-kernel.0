Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B434C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F5E2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kH4bZrFZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nr1pBAeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F5E2190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jl5LYfV4PMyer6PqI8gQVmas5XyXoL3czDTUrF2ygY4=; b=kH4bZrFZZa9ExE
	Wx+zSKH0Yp4/eoNdiRyWUQmO/DEtqGd6s8nq3UHLMIT35GK4Z+CwkpaemDup/8Tfle5lE8Uj95oiA
	kYBIUmp+37VAATnPHLAccFNAEZhZJe149pUij2GWKNXmKtIAsheHOLy/xcqW03Z/1t2U6l5MTTRfB
	ESdNtS9HRq9gA/ue6HgaXp0XQRjBY21Iwb4FcIJ7+mUVXz41tqrnvedK7wyDp61Le7wAMG+D43CQv
	tbSJAnIf7DHGNiJC3/CwR8n9ZmSYxdnYfRlLYNpm5+QgV5L7+S7O/OonhLTnsnv31hGChWhoCq350
	46Atb72EsZgEN20v2BJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrZN-00024x-9t; Wed, 13 Feb 2019 10:15:09 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrZJ-0001Qy-Kj
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:15:07 +0000
Received: by mail-pl1-x644.google.com with SMTP id w4so959828plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7/wA9bKDbtMGKDL+u8LUnnfnebexOgDkULd9V0FL2tE=;
 b=nr1pBAebs7PLUPoIJO5ok0jnU3a5IsvOFYglsg4W/0KYVH+Vo9r2WOktmoKOys5AAV
 /u5UClC9n8rtV4O/QVQC0ysNeeHXe8oBbsjWWLeVQ722phXkRCJ6Dv4eDNJxvJe4ETUh
 1fdtLGLdOMdhNoUlZ0HkBvCWVYg88ANOCOiJGdqxuPYbL43Q5PsTdwqH067hTrcs/DzJ
 PifGoJWMo9mPxMKPTwRkCBeAkkYUH9u7yPJ1aEs+ML6++uCGMRN5ZOJ5NgP7mPPKpN+C
 iX2AfXhdP5zPIT5AiiIsjDZabOXW+2NZfLLKRpKgewzCNgum/cB4YasqOLsRWQYPw0Zp
 mo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7/wA9bKDbtMGKDL+u8LUnnfnebexOgDkULd9V0FL2tE=;
 b=Y2lphoaiCxr1HFmR1FhiWFlOyvHkCEIdc+NVTjMkrRe9aUnOYz3UGuOCiHhVVQSo6f
 2lbCTpsDeKuQ58MWla4ERupE+vBi4MnANc5MqnEzfkFcvFAEe5UbjsCy5UeVkYmpRqZe
 eJhakK4kN6OysN4Mhr/2AyHx9Zck/3prpcqlcmmDVsFpBBgL4L4JGhJpUgpJvxFT4Vi5
 Ynf2QHNkbUXNcbZ1OUpPOWfIx2sVbi0YuWmFDIRcgNSs7brZRNcp2zrmlFZLn/KN2P5Z
 8Lv1PyiLaCarvXpSs5eE14rIq0Y8rKSJbLZu5oEs28vQLlysBhw8I7Otbpvad8Z2UNM/
 D7JA==
X-Gm-Message-State: AHQUAubwL7b09sNJmHKDPO/TgNc5xg4Kgl/y0HxzJoIzPUtMMQVcyPyd
 btGrXcjoHpSDdjrE+SzKYapcFA==
X-Google-Smtp-Source: AHgI3IbMq0TBtXCQSQVG5XwfPu+5HyxlZKZxxaDLs1fs6Pvm9e+lGh9hi8zup6opQii3SL/3wLu4tw==
X-Received: by 2002:a17:902:f096:: with SMTP id
 go22mr2650457plb.23.1550052904800; 
 Wed, 13 Feb 2019 02:15:04 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id l87sm30819083pfj.35.2019.02.13.02.15.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 02:15:04 -0800 (PST)
Date: Wed, 13 Feb 2019 15:45:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Message-ID: <20190213101502.v75d3nfwctcks2gx@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391662EC01B6160C1AA9A540F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_021505_686884_09650AD9 
X-CRM114-Status: GOOD (  11.92  )
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

On 13-02-19, 08:53, Anson Huang wrote:
> Forgot to mention, i.MX system controller cpufreq actually can NOT do any CPU
> clock/voltage scaling from Linux kernel, they are controlled by system controller
> firmware and ONLY can be requested via RPC with secure mode, so Linux kernel
> has to call SMC and trap to ARM-Trusted-Firmware to do it, in this case, is cpufreq-dt
> still suitable to support it? I saw cpufreq-dt driver will do CPU clock/voltage scaling
> directly.

What about moving those SMC calls to the clk-driver, then it wouldn't
matter to the cpufreq driver on how the clock is getting changed.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
