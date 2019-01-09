Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98922146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kA1E7XD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98922146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hs4t6vYO+ez9rJQJni6Ob52jWp6MnD+ilz2TCtLjFNc=; b=kA1E7XD0ZBpeIw
	Ko1nHd1r40dW/Fy4t/XyMqWh7p0FRCtnLbyX28kSiL+VRIByR7wMvaFNHNUmXvWA+E0a0tom3xdGn
	0D9thRp03E1Xqm8Q98twPKM+/+tA4YDxJqlZichO1b9/rbJBn4wGvgee+6kKv1Ce3WwBqZdddNxxl
	pZj4+jvTIsuY0lR4lXtIRU8zdlbJsTbtIqHOomcheq4Ylwn71aOdhBZniajbh+5kaaxKKCZ7q+Ume
	lkDYrdwNCGrlc4nRTKX7quli4xWR+7He/IND9BbZ/gIDG6qcBeOGIJI03t8jAD926iVbo53GfM3KQ
	Gyz3YVUEWzmm7fLlu6Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh4Eo-0000Gs-Cm; Wed, 09 Jan 2019 03:09:02 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh4Ej-0000FZ-R3; Wed, 09 Jan 2019 03:08:59 +0000
X-UUID: dcb60826c201453ca117b5e05ea67c62-20190108
X-UUID: dcb60826c201453ca117b5e05ea67c62-20190108
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1386863523; Tue, 08 Jan 2019 19:08:51 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 19:08:50 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 11:08:48 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Jan 2019 11:08:48 +0800
Message-ID: <1547003324.6818.156.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From: Henry Chen <henryc.chen@mediatek.com>
To: Georgi Djakov <georgi.djakov@linaro.org>
Date: Wed, 9 Jan 2019 11:08:44 +0800
In-Reply-To: <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
 <1546859080.6818.128.camel@mtksdaap41>
 <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_190857_883054_A8E73050 
X-CRM114-Status: GOOD (  20.39  )
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
 Stephen Boyd <swboyd@chromium.org>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-01-07 at 18:34 +0200, Georgi Djakov wrote:
> Hi Henry,
> 
> On 1/7/19 13:04, Henry Chen wrote:
> > On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
> >> Quoting Henry Chen (2019-01-02 06:09:51)
> >>> The patchsets add support for MediaTek hardware module named DVFSRC
> >>> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> >>> a HW module which is used to collect all the requests from both software
> >>> and hardware and turn into the decision of minimum operating voltage and
> >>> minimum DRAM frequency to fulfill those requests.
> >>>
> >>> So, This series is to implement the dvfsrc driver to collect all the
> >>> requests of operating voltage or DRAM bandwidth from other device drivers
> >>> likes GPU/Camera through 2 frameworks basically:
> >>>
> >>> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >>>    requirements from different clients
> >>
> >> Have you looked at using the interconnect framework for this instead of
> >> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
> >> to do DRAM bandwidth requirement aggregation.
> > 
> > Sorry, I haven't heard that before. Do you mean is following series
> > patch?
> > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775
> > 
> 
> Yes, this one. The idea is that consumer drivers like GPU, camera, video
> encoder etc. report their bandwidth needs by using the interconnect API.
> The framework does the aggregation and configures the hardware. In order
> to use it you need to implement a platform-specific dvfsrc interconnect
> provider driver that understands the SoC topology and knows how to
> configure the hardware. I am not familiar with DVFSRC, but it seems to
> me that it can fit as interconnect provider.
> Does this HW module support any QoS priority/latency configuration or is
> it only bandwidth and voltage?
> 
> Thanks,
> Georgi

Hi Georgi,

Yes, the design is only to support bandwidth and voltage. The one of the
function is to collect the memory bandwidth requirement from consumer
and select the minimum DRAM frequency to fulfill system performance.It
just get the total bandwidth then set it to HW, not involves complex SoC
topology. So we choose to use PM QOS to model that DVFSRC driver can
receive the bandwidth information from consumer driver via
PM_QOS_MEMORY_BANDWIDTH.

Do you have a patch that show how consumer driver used interconnect to
update their requirement.

Thanks,
Henry



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
