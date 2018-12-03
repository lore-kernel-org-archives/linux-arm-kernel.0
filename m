Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D7C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:58:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AD220645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="buFUZAhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RIF6AvKkxPDw4VDEGuIHxRV+eCKUCPKfOlgEMrN5Eiw=; b=buFUZAhBZUhsjE9lg1qihQYU3
	JpPFLBZotG/z2y/z8moj5wbBs//MdicIhEtw0fQmvlNLBEktQbTPAFf5oeykSNYkj7LAxSeZjhmQ+
	kXkyCb8tduGSqlzlGjefi0wp8JCdIQCEKZa1hwxbc/W5csbU6iDmxomxYTXpwhMBq5XJ3kkpzjswV
	vrK3qU0VeD+/5PtWwkJmtsOzzBL3BnZnO2Iwu19R67f4pJMgk2ktoW12wVuvb6tgz5MVYNimjh5yz
	AwNOKFYWqL+dWwOfV6MRSPrf1jOFWM9t+ZjsJppWwKDwU46lj9KwJSRtzf++N1/QFrgF0KYsujMqn
	x/JxNIZ0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTk3h-0001JT-Le; Mon, 03 Dec 2018 08:58:29 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTk3d-0001Ii-RW
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:58:27 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB38phgI001173; Mon, 3 Dec 2018 09:58:09 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3wt67ykg-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 03 Dec 2018 09:58:09 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2AB931;
 Mon,  3 Dec 2018 08:58:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 822061066;
 Mon,  3 Dec 2018 08:58:08 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec
 2018 09:58:08 +0100
Subject: Re: [PATCH 0/3] CAN fix for stm32mp157c
To: Bich HEMON <bich.hemon@st.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <ccc28b23-ce6d-41a9-74ea-2f7c85f69c84@st.com>
Date: Mon, 3 Dec 2018 09:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_005826_171149_B33C4B2C 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmljaCwKCk9uIDExLzE1LzE4IDk6NTIgQU0sIEJpY2ggSEVNT04gd3JvdGU6Cj4gVGhpcyBw
YXRjaHNldCBjaGFuZ2VzIHRoZSBDQU4gUkFNIG1hcHBpbmcgYW5kIGFkZHMgQ0FOIHNsZWVwIHBp
bnMuCj4gCj4gQmljaCBIZW1vbiAoMyk6Cj4gIMKgIEFSTTogZHRzOiBzdG0zMjogY2hhbmdlIENB
TiBSQU0gbWFwcGluZyBvbiBzdG0zMm1wMTU3Ywo+ICDCoCBBUk06IGR0czogc3RtMzI6IGFkZCBj
YW4xIHNsZWVwIHBpbnMgbXV4aW5nCj4gIMKgIEFSTTogZHRzOiBzdG0zMjogYWRkIGNhbjEgc2xl
ZXAgcGlucyBtdXhpbmcgb24gc3RtMzJtcDE1N2MtZXYxIGJvYXJkCj4gCj4gIMKgYXJjaC9hcm0v
Ym9vdC9kdHMvc3RtMzJtcDE1Ny1waW5jdHJsLmR0c2kgfCA3ICsrKysrKysKPiAgwqBhcmNoL2Fy
bS9ib290L2R0cy9zdG0zMm1wMTU3Yy1ldjEuZHRzwqDCoMKgwqAgfCAzICsrLQo+ICDCoGFyY2gv
YXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2nCoMKgwqDCoMKgwqDCoCB8IDQgKystLQo+ICDC
oDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiAt
LSAKPiAxLjkuMQoKU2VyaWVzIGFwcGxpZWQgb24gc3RtMzItbmV4dC4KClJlZ2FyZHMKQWxleAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
