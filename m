Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10194C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C9E222CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rEKqvZ54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C9E222CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XFeZFqnduCN93mnRPR5cwF5Pep/zi22GykDi7BopKEM=; b=rEKqvZ54WMY0Ke
	2exOskh721J7L8MpQjCIzDTeMd6dp49LHp0I5eDM+7QUJzVBJsXxRL0HOOdNf+I2GWU/yVwv9iY4G
	iQ5PcRh/81iFbME1EtWYIoZme1XWw5IX3gn60a2Nlg4XZrqBeNTKGn0/Gvj0sX9fbnBLsVmYx1wFt
	R/npnJue9BHsBCRQFZGTxj1jTDkKr0fvgizQ93tTCJNMnd0/4YFtKSeUYszmuR/tnQ2fCjG7LGNoc
	NvzSiyCyIWB3egGNe9qhnJszyaKLtpSjfFevV8Kv6YJa8BMomlUhq12qnM/4exFcg9oYyRwIi7zKn
	7i0ZYmyldaDmif2YsPGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gts9Q-0003iF-Rl; Wed, 13 Feb 2019 10:52:24 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gts8v-000378-Tl
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:52:21 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1DAg5d6024997; Wed, 13 Feb 2019 11:51:48 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qhv0m6nkc-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 13 Feb 2019 11:51:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85E553D;
 Wed, 13 Feb 2019 10:51:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F67C4EE6;
 Wed, 13 Feb 2019 10:51:46 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 13 Feb
 2019 11:51:45 +0100
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
 <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <72cab2a3-976a-44c6-5596-fd4e443ff2e8@st.com>
Date: Wed, 13 Feb 2019 11:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-13_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025154_720502_CF78F6F4 
X-CRM114-Status: GOOD (  12.87  )
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
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xMi8xOSAxMDowMyBBTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gSGVsbG8gRmFi
cmljZSwKPiAKPiBPbiBUdWUsIEZlYiAxMiwgMjAxOSBhdCAwOTozMTozN0FNICswMTAwLCBGYWJy
aWNlIEdhc25pZXIgd3JvdGU6Cj4+IE9uIDIvMTEvMTkgODowNiBQTSwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAxMSwgMjAxOSBhdCAwNToxMjowMlBNICswMTAwLCBG
YWJyaWNlIEdhc25pZXIgd3JvdGU6Cj4+Pj4gQEAgLTk0Myw2ICs5NTAsOCBAQCBzdHJ1Y3QgcHdt
X2RldmljZSAqZGV2bV9vZl9wd21fZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmlj
ZV9ub2RlICpucCwKPj4+PiAgCWlmICghSVNfRVJSKHB3bSkpIHsKPj4+PiAgCQkqcHRyID0gcHdt
Owo+Pj4+ICAJCWRldnJlc19hZGQoZGV2LCBwdHIpOwo+Pj4+ICsJCWRldmljZV9saW5rX2FkZChk
ZXYsIHB3bS0+Y2hpcC0+ZGV2LAo+Pj4+ICsJCQkJRExfRkxBR19BVVRPUkVNT1ZFX0NPTlNVTUVS
KTsKPj4+Cj4+PiBJTUhPIGl0J3Mgc3VycHJpc2luZyB0aGF0IGRldm1fb2ZfcHdtX2dldCgpIGRv
ZXMgbW9yZSB0aGFuIG9mX3B3bV9nZXQoKQo+Pj4gKyBkZXZyZXMgc3R1ZmYuIEknZCBwdXQgZGV2
aWNlX2xpbmtfYWRkKCkgaW50byBvZl9wd21fZ2V0KCkuCj4+Cj4+IEhpIFV3ZSwKPj4KPj4gSSBh
bHNvIGFncmVlIHdpdGggdGhpcy4gQnV0IEkgdGhpbmsgdGhpcyBpbXBsaWVzIG1vZGlmeWluZyB0
aGUgQVBJIGZvcgo+PiBvZl9wd21fZ2V0KCk6Cj4+ICAvKioKPj4gICAqIG9mX3B3bV9nZXQoKSAt
IHJlcXVlc3QgYSBQV00gdmlhIHRoZSBQV00gZnJhbWV3b3JrCj4+ICsgKiBAZGV2OiBkZXZpY2Ug
Zm9yIFBXTSBjb25zdW1lcgo+PiAgICogQG5wOiBkZXZpY2Ugbm9kZSB0byBnZXQgdGhlIFBXTSBm
cm9tCj4+ICAgKiBAY29uX2lkOiBjb25zdW1lciBuYW1lCj4+Cj4+IEl0IHNlZW1zIHRoZXJlIGFy
ZW4ndCBtdWNoIG9mX3B3bV9nZXQoKSB1c2VycyBjdXJyZW50bHkuCj4+IERvZXMgdGhpcyBsb29r
IHNlbnNpYmxlID8KPiAKPiBJbiBteSBleWVzIHRoaXMgbG9va3Mgc2Vuc2libGUsIHllcy4KCkhl
bGxvIFV3ZSwKCkkganVzdCBzZW50IGEgdjMgd2l0aCB0aGF0IGNoYW5nZSwKClRoYW5rcwpGYWJy
aWNlCj4gCj4gQmVzdCByZWdhcmRzCj4gVXdlCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
