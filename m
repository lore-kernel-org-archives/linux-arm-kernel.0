Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519E9208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5vmSXPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z+s+Ct3/dz6Jsu17JV73e2J/NUsPX+bRNGCvc6P9jEg=; b=t5vmSXPn1AxXzp
	2gfgPoX5Q42RbbsmO7oU6HM6tfc2ygSmU2HMw4z2R2mLCSE9u2k+DSdCqdLSxsCXOwyZMvcsZzhyh
	s4AGsBSjsup9YR9+OJLFxj1Gb/ZyStf4clI7et6row4E9KijTbeKAYjm4BRxuIeOeQ6eU4sIeBKCf
	Qvt+5mIFHWnJxXzfZp0yhEvsecPv3dPiFb3Tq+nAy/hv9wJLIABCwqemWRWwXDsIXAS61X6I5nJX7
	Ahxx6dZz0xpoiUwAf3wqlGyMsQK1+QvPsFSCqG3gd/p13ranM7NxH3woVlD4+5+cgjlqKxZqdKp0W
	115VjDFcqZOTYnEckVxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf42F-0006YO-G9; Thu, 03 Jan 2019 14:31:47 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf42A-0006XD-BI; Thu, 03 Jan 2019 14:31:43 +0000
X-UUID: 7c76c688c08145c09b359c18125ef941-20190103
X-UUID: 7c76c688c08145c09b359c18125ef941-20190103
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2107920506; Thu, 03 Jan 2019 06:31:39 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 06:31:38 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 22:31:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 22:31:23 +0800
Message-ID: <1546525883.6818.62.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From: Henry Chen <henryc.chen@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 3 Jan 2019 22:31:23 +0800
In-Reply-To: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E3482CD29CEE3943E9B9F88CA41D95B3699B559D4770B3A9DE0F67F5EB47CBC42000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_063142_392003_A28BD07B 
X-CRM114-Status: GOOD (  12.96  )
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
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 10:18 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
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
> > 2. Active state management of power domains[1]: to handle the operating
> >    voltage opp requirement from different power domains
> 
> Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
> feature when I wrote it first and I am quite surprised and happy to see your
> patches.
> 
> They are mostly very neat and clean patches and I don't have complaints with
> most of them. Lets see what comments others provide on them.
> 
> Thanks.
> 

Thanks for your review and the comments.
Henry


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
