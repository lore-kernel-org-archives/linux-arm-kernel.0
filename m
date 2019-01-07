Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29099C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB972147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MAT2Hrrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB972147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vyQ6VaQismDJcex9ispX/gG4X0C4DKtcHAKSmcoa1EI=; b=MAT2HrrxIonTYP
	L2fbyREY5wXk3nVkNUwS/xVwoxPmqebpIuEfNUf3+ltDsMYvFs8fyEsIDyBlM0bc4qX1xi9PEODGL
	8pYa0IXX+V2i8qmPDMx6H0bRcVcBgTQoZ8tRAUvVluI1oIuQo8OW9BojbpYeDN4KStuP0g90KfOCu
	nIQL0UPC6GJgCgx2t9rXsFkMXR03gHUQ52LIRsRlH3z1K5WXLl36nyf/bpuP/Giv9qBxoFU3ESG60
	jzRbw+DblCxjgpX7o6mEuYCGcxO+MYLvy2Wf6F1qwwI8hyb7wouXJr9ANW3VH5jfBbeAVVs7Ik3L8
	OexFECyChb5G6+U+//Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggSj1-0003SB-Oo; Mon, 07 Jan 2019 11:05:43 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggSiq-0003EK-L2; Mon, 07 Jan 2019 11:05:39 +0000
X-UUID: fa76b83719634e79afb31c3b48d711f7-20190107
X-UUID: fa76b83719634e79afb31c3b48d711f7-20190107
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 442247870; Mon, 07 Jan 2019 03:05:02 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 03:05:00 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:04:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:04:40 +0800
Message-ID: <1546859080.6818.128.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From: Henry Chen <henryc.chen@mediatek.com>
To: Stephen Boyd <swboyd@chromium.org>
Date: Mon, 7 Jan 2019 19:04:40 +0800
In-Reply-To: <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_030533_149553_31C48968 
X-CRM114-Status: GOOD (  16.45  )
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
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
> Quoting Henry Chen (2019-01-02 06:09:51)
> > The patchsets add support for MediaTek hardware module named DVFSRC
> > (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> > a HW module which is used to collect all the requests from both software
> > and hardware and turn into the decision of minimum operating voltage and
> > minimum DRAM frequency to fulfill those requests.
> > 
> > So, This series is to implement the dvfsrc driver to collect all the
> > requests of operating voltage or DRAM bandwidth from other device drivers
> > likes GPU/Camera through 2 frameworks basically:
> > 
> > 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >    requirements from different clients
> 
> Have you looked at using the interconnect framework for this instead of
> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
> to do DRAM bandwidth requirement aggregation.

Sorry, I haven't heard that before. Do you mean is following series
patch?
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775


> > 2. Active state management of power domains[1]: to handle the operating
> >    voltage opp requirement from different power domains
> 
> Do you have any devices that aren't "OPP-ish" in how they use
> frequencies and voltages? What I mean is devices such as i2c, SPI, UART
> controllers that don't use the OPP library to set a frequency but want
> to affect some voltage of their power domain when clk frequencies
> change. The existing code works well for devices that naturally use the
> OPP rate changing API, typically multimedia devices that churn through
> data like a CPU and don't care about the frequency of their main clk
> because it doesn't match physical link bit rates, etc. I haven't seen
> any good solution for devices that don't fit well with the OPP API
> though so I'm curious if Mediatek needs to solve that problem. 

As I know, we don't have such device that need change clk and voltage
together without used OPP API.We suppose that user driver will call opp
library and performance state of power domain is combined into opp
table.

Thanks.
Henry


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
