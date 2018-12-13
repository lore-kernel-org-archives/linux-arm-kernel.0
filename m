Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:37:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A8320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RXBEpw5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A8320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QPSQ9TaLap2xCzbFZQ5P/lX/HtTDJhV1qy1yxMGxCRQ=; b=RXBEpw5ifgZnFF
	cXAER9sDvcgXzEcpwaXopvlMvDZl2vS83Vt4hA3a6CKn58mKwWMIF975KXn5rv/r79/nxvDu1GsRe
	7qJ+Ei4KWwaCDKdXRhFYeNBW4wd3cSf3GJNSFWgV6ldRZuj0zISYNB5rj3d3uhnNYSITxR1YteOzc
	t4dPQDa0sJjZM/8O8slNRR1GygCRBEY2ynx8gIt1bl9xAQKXK6O3BtvQGG6AKqO9xZMqRNQ4ufcbv
	x6lioRwsCxHFeyQwWj4HE3ZEJuB42ZdaORBuvIVSUF7ny1lkstUcA/hFPpFNo2/qqVGN+cVhDTIyj
	QaWgfPpwP0J9fK34GQwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOMq-0005Pp-SL; Thu, 13 Dec 2018 10:37:20 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOMm-0005ON-Ok; Thu, 13 Dec 2018 10:37:18 +0000
X-UUID: c7018cb76d6f456486b61b52de923e7e-20181213
X-UUID: c7018cb76d6f456486b61b52de923e7e-20181213
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <nick.fan@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1319961276; Thu, 13 Dec 2018 18:36:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 18:36:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 18:36:52 +0800
Message-ID: <1544697412.6417.13.camel@mtksdaap41>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
From: Nick Fan <nick.fan@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 13 Dec 2018 18:36:52 +0800
In-Reply-To: <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
 <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 78CCB12E74F777C9693E009A464E04C08DD8F271AD16BE63588021EC15F8549E2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_023716_932240_C612E26D 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Nishanth Menon <nm@ti.com>, Chiawen.Lee@mediatek.com,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, Stephen
 Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 erin.lo@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-13 at 12:08 +0530, Viresh Kumar wrote:
> On 10-12-18, 20:36, Nick Fan wrote:
> > For the users who only use one supply, they can use
> > dev_pm_opp_get_voltage to get the voltage data from an opp.
> > But if the users who use more than one supply, they will need this API
> > to get their voltage data from OPP.
> > The users should know about the supply count while creating opp table by
> > using dev_pm_opp_set_regulators function.
> > By using this API, the users can get the voltages by using index to
> > specify which supplies they want.
> > 
> > The following is a simple example to get multiple regulators by this
> > API.
> > for (i = 0; i < regulator_num; i++)
> > 	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> Fair enough. I couldn't find anything wrong with the patch. Will it be
> possible to send this patch as part of a series which uses the new API
> ? So that we are sure of somebody using it eventually.
> 
This new API is suitable for the users that required to access for
multiple regulators. And I am one of users who uses this API, but I am
not able to upstream the GPU kernel driver which uses the new API.

--
Nick Fan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
