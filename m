Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682AD218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fJrztrxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682AD218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BjZzq8RMLZrot3vleuLCfE+Y/k0xTvTydO8rWUyxaS0=; b=fJrztrxT8b01PN
	upEqBa7RgGU/dC+eueJ2V/gviVGBUT1qndLGao2vjVD3OeGY8l+GSxgVShwZZ+xOyc/xssBTiQDnb
	NsD3ihEYSZ/2eqx+Jq0NzwTA6H6YtWIfmCYy/qDO8dq1Viaibu1pBj3Mhn/HcEeUFKpcp/iJHhrlB
	jnAkXtBqZV7kNUw0bWKGTzAHZMXtD5noYdOycY/6dfNRVKG6INQ5AnYQ9WPjGBniMWx1HGkgek8Wa
	q7PiR/Me2u5ZGQoQPTJV8KNWlQUFEFMkcVXAubQ7/PiVYWqGAWPkiydOrNaWk/cICnxj7IMG14gOk
	A4n7rsqRuJiND4tynUVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBXQ-0001cY-Fl; Mon, 11 Feb 2019 13:22:20 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBX6-0001Lt-0H; Mon, 11 Feb 2019 13:22:03 +0000
X-UUID: 8c83122d65744ad28a7b54e7ccc68a67-20190211
X-UUID: 8c83122d65744ad28a7b54e7ccc68a67-20190211
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1629819709; Mon, 11 Feb 2019 05:21:50 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 05:21:49 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 21:21:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Feb 2019 21:21:47 +0800
Message-ID: <1549891307.12454.4.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
To: <myungjoo.ham@samsung.com>
Date: Mon, 11 Feb 2019 21:21:47 +0800
In-Reply-To: <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
References: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190129063600epcas2p255b062c64f22555692ff895634ea4eb0@epcms1p4>
 <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_052200_048287_5FC9F3A5 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-29 at 17:17 +0900, MyungJoo Ham wrote:
> >From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> >
> >For big/little cpu cluster architecture,
> >not only CPU frequency, but CCI frequency will also affect performance.
> >
> >Little cores and cci share the same buck in Mediatek mt8183 IC,
> >so we add a CCI devfreq which will get notification when buck voltage
> >is changed, then CCI devfreq can set cci frequency as high as possible.
> >
> >Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> 
> Please correct the coding style first in the .c file.
> 
> - empty last line?
I will modify this in next patch
> - inconsistent indentation (line26? match the first lines for all variable declarations OR don't match them at all)
I will modify this in next patch
> - Need proper boilerplate and try to comply with C89.
I have checked my compile is gnu89 and without build warning.
May you advice where I should modify, or script I can use to check?
> 
> Cheers,
> MyungJoo
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
