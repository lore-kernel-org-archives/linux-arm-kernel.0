Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9F8222DC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hp7a8GcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9F8222DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fkAND4wTe4LYgBuysC6l+Jga3icnbIZ9f3b78FksyCo=; b=Hp7a8GcHvIO4Cq
	9/BrWUM/XH1+DIXhIO2ZITupuhf+xV+7fZfK9fsUk//RQU/yWPKoWTKwmc8nUkyfAKY3MMjC3uSaw
	6S5rYN3j9llzWD8TVnPgNUouN0nv3hP3KxfCegz455A1AVoiFKQX2OKt9jiOwOfO0uyho1xtz+JRm
	dFVKWEqHLz9Sph+UaSAhPgWv3SkJORyL/fZj7eE0feVGWqWJ0nW0lBKvx6QDvUO2xGwuUnAuaqD5Z
	qu8vONSVmzQkj8JOUWKK34F4K+LUJYHkjpn2YA1qexT0Oyc7U57/dPjmdr+BB93XPf0If5uT0JFa5
	sgu8bSCRO9U3MO1W6b8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guLU0-0007lh-U4; Thu, 14 Feb 2019 18:11:36 +0000
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]
 helo=torfep02.bell.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guLTx-0007l3-BM
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 18:11:35 +0000
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
 with ESMTP
 id <20190214181130.VRVW12500.torfep02.bell.net@torspm01.bell.net>
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 13:11:30 -0500
Received: from [192.168.0.138] (really [64.231.92.241])
 by torspm01.bell.net with ESMTP
 id <20190214181130.BYNG10318.torspm01.bell.net@[192.168.0.138]>;
 Thu, 14 Feb 2019 13:11:30 -0500
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
 (1f947a7a011fcceb14cb912f5481a53b18f1879a)
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
 <6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com> <20190214173642.GA2704@lst.de>
 <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
From: John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Message-ID: <5d42366f-5610-5f7c-a463-fe71135b173d@bell.net>
Date: Thu, 14 Feb 2019 13:11:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
Content-Language: en-US
X-Cloudmark-Analysis: v=2.2 cv=IPLtMknG c=1 sm=0 tr=0
 a=jJmVOGxBrKxWvcjqaG+oVg==:17 a=IkcTkHD0fZMA:10 a=CFTnQlWoA9kA:10
 a=FBHGMhGWAAAA:8 a=6wQkT1U7qmRKs2KMrwMA:9 a=QEXdDO2ut3YA:10 a=ATlVsGG5QSsA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_101133_525731_66DFEE84 
X-CRM114-Status: UNSURE (   5.35  )
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
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMi0xNCAxMjo1OCBwLm0uLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gSG1tLCBoYXZp
bmcgZmVsdCBicmF2ZSBlbm91Z2ggdG8gdGFrZSBhIGNsb3NlciBsb29rLCBpdCBtaWdodCBhY3R1
YWxseSBiZcKgYXPCoHNpbXBsZcKgYXPCoHRoaXPCoC3CoERhdmUswqBhcmXCoHlvdcKgYWJsZcKg
dG/CoGdpdmXCoHRoZcKgZGlmZsKgYmVsb3fCoGHCoHNwaW4/Clllcy4KCi0tIApKb2huIERhdmlk
IEFuZ2xpbiAgZGF2ZS5hbmdsaW5AYmVsbC5uZXQKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
