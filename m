Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3232AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:24:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18B820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MJV9xBc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18B820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kP5KckPnghbol52Z5A7YtnJ6yuolMgCRXTl2t+b0DzU=; b=MJV9xBc+jZAcTFclky6jMIc5y
	G9YIjF+6ovn462x+ARzksle8M+GoNIqRheTrOoWL03iEurw/eFhYj7E/XZWxkEEzsfjVBiNNGBKPU
	miyEZD+qjM8yHsNY7fc4x1Rw2li7Pm1aRmW8i6SAt/MDj5TqJIy0SlPiqQecyW+IFHpLPP9hmxfC6
	fMzmpSVbyrxhbBIHoJaXZnXMfTsxdTcB7uS7NKH+LjNcHlOGdAKCXdgA8b1hxqnWOCasIbY8y/4ZI
	sgZnonQZwp47oDvo0TWHia0ZCNscjRL3hxjTycqi/5mYnSyMnLtFGOJqa8Xjh5KL2EHewVM4SEWmK
	eHOiRz0TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZYG-0004x8-Ud; Mon, 04 Feb 2019 08:24:24 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZXu-0004d3-QO
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:24:08 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x148NAQL030703; Mon, 4 Feb 2019 09:23:56 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qd17bghj6-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 04 Feb 2019 09:23:56 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A936138;
 Mon,  4 Feb 2019 08:23:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B7CC2452;
 Mon,  4 Feb 2019 08:23:55 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Feb
 2019 09:23:54 +0100
Subject: Re: [PATCH] ARM: dts: stm32: Enable thermal sensor support on
 STM32MP157c-ed1
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
References: <1544178482-30494-1-git-send-email-david.hernandezsanchez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c9a95fd1-3875-117c-d1b4-d9567da6e561@st.com>
Date: Mon, 4 Feb 2019 09:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544178482-30494-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-04_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_002403_647632_B13A02AD 
X-CRM114-Status: GOOD (  14.16  )
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
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRGF2aWQKCk9uIDEyLzcvMTggMTE6MjggQU0sIERhdmlkIEhFUk5BTkRFWiBTQU5DSEVaIHdy
b3RlOgo+IEVuYWJsZSBTVE0zMiBEaWdpdGFsIFRoZXJtYWwgU2Vuc29yIChkdHMpIGRyaXZlciBm
b3IKPiBTVE0zMk1QMTU3Yy1lZDEgYm9hcmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGVy
bmFuZGV6IFNhbmNoZXogPGRhdmlkLmhlcm5hbmRlenNhbmNoZXpAc3QuY29tPgo+IAo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1lZDEuZHRzIAo+IGIvYXJjaC9h
cm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZWQxLmR0cwo+IGluZGV4IGMzZWNiMWUuLjk4ZWY3YTAg
MTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZWQxLmR0cwo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLWVkMS5kdHMKPiBAQCAtNDksNiArNDks
MTAgQEAKPiAgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ICDCoH07Cj4gCj4gKyZkdHMgewo+ICvCoMKg
wqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOwo+ICt9Owo+ICsKPiAgwqAmaTJjNCB7Cj4gIMKgwqDC
oMKgwqDCoMKgwqAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiAgwqDCoMKgwqDCoMKgwqDC
oCBwaW5jdHJsLTAgPSA8JmkyYzRfcGluc19hPjsKPiAtLSAKPiAyLjcuNAoKQXBwbGllZCBvbiBz
dG0zMi1uZXh0LgoKVGhhbmtzLgpBbGV4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
