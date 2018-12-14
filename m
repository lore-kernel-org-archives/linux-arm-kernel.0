Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70133C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:37:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D13320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RwSDZPVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D13320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iMvsq7n3TP0PMiv0Tk3Uu/ExakJQXb1bEnOvtfVqzN0=; b=RwSDZPVkerwlDc
	CjbszksBiMe97unOdnSXkpPlYtBJoYIhHH2YccfocYsJGP1F0yPVPHelVrm7MujEm0UQt+3fLzbZS
	yaL1OpkWn66vKHwpNI3e3loAs7TTiwDS8x7CHq2kqOO/WdrnXXnXA4/dd6arqtvdvtwFCFLAViEQc
	sYX2sTqRyMnGYStnhAiJq3yuOeLmNOmYgcNlp98abN4tDnUhE8JDrOshNsDbXbluFMzLNJpxH+vOP
	yJV7BlTxFVejZGEowsmIi6D+/iW33P/and7+IW11nFNfXBlWQRi9dWcAHQOEBYQPzFEm898adtRbd
	TWtYgWqvaJJ6h1K0EpdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcPi-0000cr-D4; Fri, 14 Dec 2018 01:37:14 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcPa-0000Mx-NI; Fri, 14 Dec 2018 01:37:10 +0000
X-UUID: 4e53319cd3b347c6b8a4d4806cbd0fe0-20181214
X-UUID: 4e53319cd3b347c6b8a4d4806cbd0fe0-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <nick.fan@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1151234597; Fri, 14 Dec 2018 09:36:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:36:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:36:49 +0800
Message-ID: <1544751409.6417.22.camel@mtksdaap41>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
From: Nick Fan <nick.fan@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 14 Dec 2018 09:36:49 +0800
In-Reply-To: <20181213104247.kosguuoukoi645pf@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
 <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
 <1544697412.6417.13.camel@mtksdaap41>
 <20181213104247.kosguuoukoi645pf@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D4DF624EBD6D7B04A695D61FDB931F35F20E6E4C300937F86511965A967BB6602000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_173707_297404_5AF84417 
X-CRM114-Status: GOOD (  12.15  )
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

On Thu, 2018-12-13 at 16:12 +0530, Viresh Kumar wrote:
> On 13-12-18, 18:36, Nick Fan wrote:
> > This new API is suitable for the users that required to access for
> > multiple regulators. And I am one of users who uses this API, but I am
> > not able to upstream the GPU kernel driver which uses the new API.
> 
> Look at it from mainline's perspective..
> 
> - We don't (can't) care about non-mainline stuff. Actually we do care,
>   but we can't add code to mainline which is not going to be used by
>   any mainline user.
> 
> - I am fine with introducing the new API, but that will happen only if
>   there is going to be a mainline user as well.
> 
> - As you are going to maintain your GPU driver offline, you can
>   maintain this patch too.
> 
> Sorry Nick.
> 
It's OK.
I got your ideas.
Thanks a lot for the explanation and review on this patch.

--
Nick Fan



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
