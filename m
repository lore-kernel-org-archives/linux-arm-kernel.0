Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:21:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40E9222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NhW2PON+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRy3zGKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40E9222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dS2OpcS/pCIJa++63Oyzllu3FgYFd8SdjBLC1e1qcqk=; b=NhW2PON+KhRm3h
	LsT3ich/8HJ3DABJKgciboy+oZUXyjIC4qGd7nZ6ypYkMkdrHAOFK5iiFYDkE8rckTcpsdo+P4+BL
	DMld8WlB3WUgZU4VIayVmMchsjx2lFCspB+iJfU+umI0HbCIzsB8tP5R7eclvTpddD8jZ3l7PAn1T
	6YBt1bCGI3TIQqdk4hzWz3RX5ANC1ceTVLP4VOh2LrFvC7coVXxCVr1pJ1V11Gh0FToOZu9BV9o5Z
	g00RndDlsjj9tbwEvF9TBOsVfpmJBVn3jRqfx6I/kV0X0GH8bxYKZUdd0WPqB2cj2WAph9RPvjb5k
	Th68AURuLeoVDc5L6n7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guE8W-0003W2-GY; Thu, 14 Feb 2019 10:20:56 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guE8S-0003VK-OU
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:20:55 +0000
Received: by mail-pf1-x444.google.com with SMTP id n22so2885531pfa.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 02:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mJzmhAM1KCaDn3qCEzGBUzKFpMm/FqdTAEQEBba9WuU=;
 b=yRy3zGKRhefQGEI45kJzX0CQ0FHy3th966wa8kA5ybqpteqik9foOkZMUnJzktjGl8
 Z2RzVnByybh6/ptEQCjHrsNZMs8IG4ysPbnuAlnL2X0axVRXLIlaz+FxUhw8+dF/Qn1s
 x6JaLP5I+mzTUiD7tt+bfyHxGIljO92FSZIgfAokdZXoBmxO27F9zjoKS0aZoNoHtoUD
 m02bWjnIMQADXjx0O+iLZCrniyxJUcxijwakKoTdQ5Th6e2K/lQjuDGwvWxM/bMnbER/
 i2uQgWsz1WY8N7EovgTIJeB2+a9R+KMMaauJKrjD/8yy5IttUZZB7fOUnxKTf3ZWPno1
 2quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mJzmhAM1KCaDn3qCEzGBUzKFpMm/FqdTAEQEBba9WuU=;
 b=W+8HyaLdcEPCfFsiqAkSsGDG+qXfxBRDQmrGtP/EjYECZoJvkxjd6A026GN3zgPfVa
 kRZwTn5wTCUKZvR4DmZIh2l1+BgVT66XtxNfDErQ5jGR7uPaYJ6+bm807p7vDf+bthhV
 nVTxWVEQdNFejQYPMzIp145VljHIy4TM4/UZ2jEMebI5pW+dsy1BJNdeTpk7DMkthCJz
 FmEQ2J4EOoWmnemGKCJ+xDdc9A+1mHaTmtCxiBsm/YiKcChWLRraS8GsphddwEzdZLqN
 5Q14Q/Nz2MzBOBTrzT3T2BnZf9iaK0aI9GSwSzSuTa7Zt6TuxyIBqLGhYocppTY4XL1i
 1xdg==
X-Gm-Message-State: AHQUAuacwI1b1YRI7rgOe5EwuQ+EV8+x4Wr/babuWNPRzV27TyTMO1Wa
 1aFJfTHYBHu/CEJzs3FYnrY/ag==
X-Google-Smtp-Source: AHgI3Ia4kTM8Lwc2qum7Ad7f9UewW+plRXqPk5ErxDmeO3cNbGl0oMiH1p46WjbMjlZPwhRIL8B9zg==
X-Received: by 2002:a63:be0a:: with SMTP id l10mr3030321pgf.292.1550139651606; 
 Thu, 14 Feb 2019 02:20:51 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id h15sm2616261pfn.9.2019.02.14.02.20.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 02:20:50 -0800 (PST)
Date: Thu, 14 Feb 2019 15:50:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V5 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214102047.giu5lwxw7dtyfdqy@vireshk-i7>
References: <1550131046-2069-1-git-send-email-Anson.Huang@nxp.com>
 <20190214083419.slnuolyy5xhz4szy@vireshk-i7>
 <DB3PR0402MB39163EE75B512102C5FE19E9F5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39163EE75B512102C5FE19E9F5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_022052_825748_76EE867B 
X-CRM114-Status: UNSURE (   8.15  )
X-CRM114-Notice: Please train this message.
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
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-02-19, 09:47, Anson Huang wrote:
> Although all CPUs share same clock and opp table, but OK, I will add clock to
> all CPUs.

Right, but still these must be present for all CPUs as on certain
occasions a CPU other than CPU0 can be used to bring up the cupfreq
policy.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
