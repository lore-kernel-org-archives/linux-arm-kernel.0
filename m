Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D93021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SEQSim73";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWHMTnCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D93021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HFbe81kAZbCZS6buHxkomrInTEfvwp3VyIAucUKKHVI=; b=SEQSim73D4ihGW
	RwVkx13KudKI0vreZK1l9fpfI7HlOoB19bxvRD+F7Fy0xbUEY8/q81+5LAezk6zdxvGsw6+coMx6Y
	WWmoWt1W53zWiNX24GDMaJrfMN01TB65zxdAd05SEFVLbI4gRE3c2eIvBsoIR40eI96tNW7s+Ozvc
	ixkzLcFnE6DpRBerLZwhPvtxV8iu3boZYq+WTeXK/fruk3iSR9YxITV8x+ff7Bw8Ydz+LJfkDPekP
	3NZpmTe/yFMVEn72sGEhyW92zXJhd5A0uM81DBWVCMFF6Rrzq+tRbQHGkuWTz10RkVxpJDeEqUn1V
	rwpG4B6X78/eDHSuBFpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfBsC-0005s8-Ie; Thu, 03 Jan 2019 22:53:56 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfBs9-0005rR-PO
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 22:53:55 +0000
Received: by mail-pg1-x542.google.com with SMTP id m1so16606417pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=eKDkodU+bk+UX1mJmQHY5x4ZWScBEWFcctryf+ygKqc=;
 b=bWHMTnCl3K9JhTc2KDOM7bFwiA8OQSdp/WIwCi5WmdzADsf2tzrnbVzj4enGsjtDXf
 PiGgo/tTanO9JYYznwnbQV+KQd8qnnwph5anU/1ZjQM0NR2rvm7ZQl5nS2/eu6fFPHzl
 xmh32/kMxwlpa9HSj8dxThYpRfR4WzE/y/qEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=eKDkodU+bk+UX1mJmQHY5x4ZWScBEWFcctryf+ygKqc=;
 b=paVLGGzIOQv/H3PgFH+vWDenBSuDnD5FrMpcC/eBekzPwig69E2Ch1YloZjIaiSyOR
 0M0oIZ/AdzMkoiK6X4LVgAKCuU1C8ct1IQ43+Hpz8UUzhfFmdFkgMhwK1UCjcGmcI7Et
 ZBKEH4XzqdEudMQ/9wYSsyofqtnORvbghN/Ddjp0sEhcFmv/BgRUwg0RppTFAvG3H2Pv
 W5LvtS4c6pjybwC4dv8jc+ukz17bw0RVII5PRNsHSOcsqSJ5FDUQJ96TpSHDqRrLpYgs
 lFJ4pAsU9K6w7GdjqFxLCEGlkt/iE6ITGTytm/tOtVJTJNdPJUSJAGL/GSXJ+izLZ7lO
 UZuA==
X-Gm-Message-State: AA+aEWbZDV07POSXlvHz2l8lpMsb4JAZ+t88sRMTpE6lTo1HRMCW4y1p
 bwlH2ptFP0slq8GJ7mre0mBEag==
X-Google-Smtp-Source: AFSGD/VhbaBKgVs1eRgvU+zTaRV/g9X7rAPXVRAVbmLWrER2SOl7aWnQaxCCxDZtCkNYAG2dvqHj0Q==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr49790444pfw.256.1546556033327; 
 Thu, 03 Jan 2019 14:53:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id k129sm72651060pgk.29.2019.01.03.14.53.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 14:53:52 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
To: Henry Chen <henryc.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 14:53:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_145353_851869_B8164A77 
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Henry Chen (2019-01-02 06:09:51)
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
> 
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients

Have you looked at using the interconnect framework for this instead of
using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
to do DRAM bandwidth requirement aggregation.

> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Do you have any devices that aren't "OPP-ish" in how they use
frequencies and voltages? What I mean is devices such as i2c, SPI, UART
controllers that don't use the OPP library to set a frequency but want
to affect some voltage of their power domain when clk frequencies
change. The existing code works well for devices that naturally use the
OPP rate changing API, typically multimedia devices that churn through
data like a CPU and don't care about the frequency of their main clk
because it doesn't match physical link bit rates, etc. I haven't seen
any good solution for devices that don't fit well with the OPP API
though so I'm curious if Mediatek needs to solve that problem. 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
