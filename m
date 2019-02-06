Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F970C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:55:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4DB2073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/0Bnakf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4DB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NbNNIWqffUBaFL24StzlStayVrDmIaVBqhInA7JBU6o=; b=m/0Bnakf7nHq2/
	Nqcu4Qnia16FTrpKjn/PQWd9Hdm3k75sh01h5/NlcU0y4Y1mlsYebqn/5VZBYfkuSCGnJ54J8LTvi
	0srUxWZaUC1P2UoOHY/ZX1NBoZkAwvVUV3XvjFjK5RNTYJiYCiGpFLa1Xm3e5N4+fgFa9Wv99U5p9
	skUvrpU4AmBWfajMvbVjgLl1X6waaiB9eeCWqAGkfZQQ8EaAV67xuJfOnDFvDuQQEvVe7c2PmlIpW
	CjoMmafT5qU594SLssIuU+chTfsY3KK/7sUPIuW3+856+ENC0vF3tqQb8DW55KTAkUR0LRYqReI7V
	/0ZgpcKKGWeWgrKxxPZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grObY-0005H3-Eq; Wed, 06 Feb 2019 14:55:12 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grObU-00041h-67
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:55:10 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16EpNMb001272; Wed, 6 Feb 2019 15:54:53 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qfv9j9k5a-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 06 Feb 2019 15:54:53 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 786D034;
 Wed,  6 Feb 2019 14:54:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 488F52C3C;
 Wed,  6 Feb 2019 14:54:52 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 15:54:51 +0100
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
To: Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
 <20190206125545.GI21676@ulmo>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <ddb93754-2734-e4c2-a209-517984c6d814@st.com>
Date: Wed, 6 Feb 2019 15:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206125545.GI21676@ulmo>
Content-Language: en-US
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_065508_524971_588E1D86 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 Tomasz Duszynski <tduszyns@gmail.com>, linux-kernel@vger.kernel.org,
 vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi82LzE5IDE6NTUgUE0sIFRoaWVycnkgUmVkaW5nIHdyb3RlOgo+IE9uIFdlZCwgRmViIDA2
LCAyMDE5IGF0IDA5OjU0OjA1QU0gKzAxMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+PiBP
biBXZWQsIEZlYiAwNiwgMjAxOSBhdCAwOTo0Mjo0OEFNICswMTAwLCBGYWJyaWNlIEdhc25pZXIg
d3JvdGU6Cj4+PiBJZiB5b3UgYWdyZWUgd2l0aCB0aGUgY3VycmVudCBhcHByb2FjaCwgSSBjYW4g
c2VuZCBhIFYyIHdpdGggVG9tYXN6J3MKPj4+IHN1Z2dlc3Rpb24gdG8gcmVtb3ZlIHRoZSBpZmRl
ZnMgYW5kIHVzZSBfX21heWJlX3VudXNlZCBpbnN0ZWFkLgo+Pgo+PiBJIHRoaW5rIHRoZSBzdXNw
ZW5kIGNhbGxiYWNrIHNob3VsZCBoYXZlIHNvbWV0aGluZyBsaWtlOgo+Pgo+PiAJaWYgKGlzX3N0
aWxsX2VuYWJsZWQpIHsKPj4gCQkvKgo+PiAJCSAqIFRoZSBjb25zdW1lciBkaWRuJ3Qgc3RvcCB1
cywgc28gcmVmdXNlIHRvIHN1c3BlbmQuCj4+IAkJICovCj4+IAkJZGV2X2VycihkZXYsICJUaGUg
Y29uc3VtZXIgZGlkbid0IHN0b3AgdXMsIHNvIHJlZnVzZSB0byBzdXNwZW5kLlxuIik7Cj4+IAkJ
cmV0dXJuIC1FQlVTWTsKPj4gCX0KPj4KPj4gVGhpcyB3YXkgdGhlcmUgYXJlIG5vIGJhZCBzdXJw
cmlzZXMgaWYgdGhlIHB3bSBpcyBzdXNwZW5kZWQgYmVmb3JlIGl0cwo+PiBjb25zdW1lciBhbmQg
aXQncyBvYnZpb3VzIHdoYXQgaXMgbWlzc2luZy4KClRoaWVycnksIFV3ZSwKCldoZW4gdGhlIHB3
bSBpcyBzdXNwZW5kZWQgYmVmb3JlIGl0cyBjb25zdW1lciwgdGhlIGJhZCBzdXJwcmlzZSBpcyB0
aGUKc3VzcGVuZCByZXF1ZXN0IHdpbGwgZmFpbC4uLiBJJ20gbm90IHN1cmUgYSBuZXcgYXR0ZW1w
dCBtYXkgYmUgYmV0dGVyLgpTbywgaXQgbG9va3MgbGlrZSB0aGUgb25seSB3YXkgdG8gaGF2ZSB0
aGlzIGNsZWFuIGlzIGJ5IGltcGxlbWVudGluZyB0aGUKZGV2aWNlIGxpbmsgZS5nLiB2aWEgcHdt
X2dldCgpID8KCj4gCj4gU29tZXRoaW5nIHRoYXQganVzdCBvY2N1cnJlZCB0byBtZTogcGVyaGFw
cyBhcyBwYXJ0IG9mIHB3bV9nZXQoKSB3ZQo+IHNob3VsZCB0cmFjayB3aGVyZSB3ZSB3ZXJlIGJl
aW5nIHJlcXVlc3RlZCBmcm9tIHNvIHRoYXQgd2UgY291bGQgZ2l2ZQo+IGhpbnRzIGluIHNpdHVh
dGlvbnMgbGlrZSB0aGlzIGFzIHRvIHdoZXJlIHRoZSBjb25zdW1lciBpcyB0aGF0IGZvcmdvdAo+
IHRvIHN1c3BlbmQgdGhlIFBXTS4KClRoZSBjdXJyZW50IGFwcHJvYWNoIGhhbmRsZXMgdGhlIHNp
dHVhdGlvbiB3aGVyZSB0aGUgY29uc3VtZXIgZm9yZ290IHRvCnN1c3BlbmQgdGhlIFBXTS4uLiBJ
IGNhbiBhZGQgc29tZSB3YXJuaW5nIGFib3V0IHRoYXQgaW4gdGhlIHN1c3BlbmQKcm91dGluZSwg
aW5jbCB0aGUgbGFiZWwuCgpXaGF0IGRvIHlvdSB0aGluaz8gV2hhdCdzIHRoZSBiZXN0IGFwcHJv
YWNoID8KClBsZWFzZSBhZHZpc2UsCkJSLApGYWJyaWNlCj4gCj4gSSBzdXBwb3NlIHdlIGFscmVh
ZHkgaGF2ZSBwd21fZGV2aWNlLmxhYmVsIHRvIGhlbHAgd2l0aCB0aGlzLCBidXQKPiBwZXJoYXBz
IHdlIGNvdWxkIGltcHJvdmUgdGhpbmdzIGlmIHdlIHN0b3JlZCBfX2J1aWx0aW5fcmV0dXJuX2Fk
ZHJlc3MKPiBkdXJpbmcgcHdtX2dldCgpIHRvIGhlbHAgdXNlcnMgcGlucG9pbnQgd2hlcmUgdGhl
eSBuZWVkIHRvIGxvb2suCj4gCj4gVGhpZXJyeQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
