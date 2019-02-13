Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA7C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:22:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8347A21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sNKXWKx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347A21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l1NgVCjkAk/68eb0b0J8T3kMWA9KMQF+YGvRIM2jwh8=; b=sNKXWKx/rrJ7tb
	FeZCqlcU40ffzWpgkLNV+33ytCFckwXdKswxNG4hKg67dAay0n97i2bDdxZr0k3iRXycIDSlyotO+
	swf6SyBqX1pXHjMlEfjshIgWsDT8p0caJqmUa9nnFVUioh/FHNA9yY0dDmvwmQhr0+CtGILfkdGw2
	tn1R6Dyr+eOVIh3Sx23Ytd3AdD2Epj3wxqOh/mBABiB0j8PoBT5dYezcyJ/AOxyrw+GVvYa0aAibE
	PlPt0aVShTeIGt2bzBy1xpab01rFxoGd435KuwajmQS7JlqzCnSQ6CHYq0rDO9goPkPDC2jo3pSDI
	scPf9TK04z5r5Be7KEIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtl8M-0002i7-EK; Wed, 13 Feb 2019 03:22:50 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtl8I-0002he-LX
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:22:48 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2019 19:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; d="scan'208";a="126026862"
Received: from pgsmsx102.gar.corp.intel.com ([10.221.44.80])
 by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 19:22:43 -0800
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 PGSMSX102.gar.corp.intel.com (10.221.44.80) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 11:22:42 +0800
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.233]) by
 PGSMSX110.gar.corp.intel.com ([169.254.13.64]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 11:22:42 +0800
From: "Ooi, Joyce" <joyce.ooi@intel.com>
To: "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>, "Giuseppe
 Cavallaro" <peppe.cavallaro@st.com>, Alexandre Torgue
 <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: RE: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Topic: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
 register
Thread-Index: AQHUwu+UOCpTiEkLQkC84M7CF1vk+KXcHcYAgADu6wA=
Date: Wed, 13 Feb 2019 03:22:40 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C04507764FAE@PGSMSX101.gar.corp.intel.com>
References: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
 <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
In-Reply-To: <0c93846a-48ab-5cde-6d27-291606dd8c31@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTQ1NzNjZGMtNjE5Mi00NTliLTgxNTctZWZkNDZiNTI0MGExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGs0RVwvWUFocCtObXJ2TWxFcHQ2ZlZ5Uk5RSjhNNU9jV2VRRmZMR0tHaGhMQXpUUVRPcmVJNk5lWk5BdXlqZ1MifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_192246_755600_CD81CF10 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "See,
 Chin Liang" <chin.liang.see@intel.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Thor Thayer [mailto:thor.thayer@linux.intel.com]
> Sent: Wednesday, February 13, 2019 4:53 AM
> To: Ooi, Joyce <joyce.ooi@intel.com>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@st.com>;
> Jose Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; See, Chin
> Liang <chin.liang.see@intel.com>
> Subject: Re: [PATCH] net: stmmac: Add SMC support for EMAC System Manager
> register
> 
> Hi Joyce,
> 
> On 2/12/19 10:24 AM, Ooi, Joyce wrote:
> > As there is restriction to access to EMAC System Manager registers in
> > the kernel for Intel Stratix10, the use of SMC calls are required and
> > added in dwmac-socfpga driver.
> >
> > Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> 
> <snip>
> 
> I have a pending patchset[1] that addresses this but can be used by other drivers
> as well.
> 
> [1] https://patchwork.kernel.org/cover/10612891/[] 
Oh, didn't realize your patchset. I guess my patch can be ignored then. Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
