Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438C5C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:52:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D7620874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cTPzxdFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D7620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6SV7xLg2LDVVLGOhhvHSoLwf3tYjKdrtGw7llQKdDOQ=; b=cTPzxdFk/ep76I
	Fya40nKrQ2jQemV5WJveurwACFVesVlhQMKWsHYW36TOnVrCyaMnjpkECWjKzAZXKaezQgfy0n0gs
	zrYx9ZmMFjVLowNsNHQG1mvI1ENe1FuoS2X7/S4VFgGeBDsjnSvCm+/By0oDBNNOF3K8RJwD1u5pp
	Xd+RNitXSblsrpApyEqdWRf5H/6OYa4HHkT/0Ldqv+N3Ji/13gb+R0rSyJhquTcfUJZ2TS7l7IPav
	OWzRjpZ8srBdxlpnTxtDO3le09sVWisq2y3gK19OTgDe94bFEMISFwAumjmy+LplFVsm5uWoQvaBq
	JoUXfHQRyP7aa1FP9r9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsNO-0003EZ-UF; Mon, 17 Dec 2018 12:52:02 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsNJ-0003Ds-Jd
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 12:52:00 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBHCpair015679; Mon, 17 Dec 2018 13:51:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2pcr8xj0gj-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 17 Dec 2018 13:51:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79C4B31;
 Mon, 17 Dec 2018 12:51:31 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 23FB514CE;
 Mon, 17 Dec 2018 12:51:31 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Dec
 2018 13:51:30 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Mon, 17 Dec 2018 13:51:30 +0100
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: =?utf-8?B?Q2V6YXJ5IEdhcGnFhHNraQ==?= <cezary.gapinski@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Topic: [PATCH 0/5] Add support for STM32F4 SPI
Thread-Index: AQHUj8azLFItfSiuXEO2Jd1SqFlrjaV32geAgABsQQCACpfbgA==
Date: Mon, 17 Dec 2018 12:51:30 +0000
Message-ID: <b7424f2c-a644-fd60-7871-6306d035e688@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
 <1544468722.17722.45.camel@gmail.com>
In-Reply-To: <1544468722.17722.45.camel@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-ID: <425933B326777444BABF246114C5C6E6@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-17_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_045157_939287_C33865C8 
X-CRM114-Status: GOOD (  25.86  )
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
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2V6YXJ5LA0KDQpPbiAxMi8xMC8xOCA4OjA1IFBNLCBDZXphcnkgR2FwacWEc2tpIHdyb3Rl
Og0KPiBIaSBBbWVsaWUsDQo+IA0KPiBPbiBNb24sIDIwMTgtMTItMTAgYXQgMTI6MzcgKzAwMDAs
IEFtZWxpZSBERUxBVU5BWSB3cm90ZToNCj4+IEhpIENlemFyeSwNCj4+DQo+PiBPbiAxMi85LzE4
IDI6NTMgUE0sIGNlemFyeS5nYXBpbnNraUBnbWFpbC5jb20gd3JvdGU6DQo+Pj4NCj4+PiBGcm9t
OiBDZXphcnkgR2FwaW5za2kgPGNlemFyeS5nYXBpbnNraUBnbWFpbC5jb20+DQo+Pj4NCj4+PiBU
aGlzIHNlcmllcyBvZiBwYXRjaGVzIGFkZHMgc3VwcG9ydCBmb3IgZmlyc3QgZ2VuZXJhdGlvbiBv
ZiBTUEkNCj4+PiBpbnRlcmZhY2UNCj4+PiBmb3IgU1RNMzJGNCBmYW1pbHkuDQo+Pj4NCj4+IEZp
cnN0IG9mIGFsbCwgdGhhbmtzIGZvciBhZGRpbmcgU1RNMzJGNCBTUEkgc3VwcG9ydC4NCj4gDQo+
IFRoYW5rcyBmb3IgeW91ciBhbnN3ZXIgYW5kIGhpbnRzIGZvciBjb3JyZWN0IGFwcHJvYWNoIHRv
IHRoaXMgZHJpdmVyLg0KPiANCj4+Pg0KPj4+IFRoaXMgdmVyc2lvbiBvZiBkcml2ZXIgaXMgbW9z
dGx5IGRpZmZlcmVudCB0byBTVE0zMkg3IG9uZS4gQmFzZWQgb24NCj4+PiBsaW51eA0KPj4+IGtl
cm5lbCBJMkMgZHJpdmVycyBmb3IgU1RNMzIgd2hlcmUgZHJpdmVycyB3ZXJlIHNwbGl0ZWQgaW50
bw0KPj4+IFNUTTMyRjQgYW5kDQo+Pj4gU1RNMzJGNyBmYW1pbHkgdGhlIHNhbWUgYXBwcm9hY2gg
c2VlbXMgdG8gYmUgc3VmZmljaWVudCBmb3IgU1BJDQo+Pj4gU1RNMzINCj4+PiBkcml2ZXJzLiBU
aGVyZWZvcmUgU1RNMzJINyBkcml2ZXIgd2FzIG1vdmVkIHRvIHNwaS1zdG0zMmg3LmMgZmlsZQ0K
Pj4+IGFuZA0KPj4+IHJlZ2lzdGVyIGFuZCBmdW5jdGlvbnMgd2VyZSByZW5hbWVkIHRvIGJlIG1v
cmUgc3BlY2lmaWMgdG8gU1RNMzJINy4NCj4+Pg0KPj4gWW91J3JlIHJpZ2h0LCBTVE0zMkY0IFNQ
SSBpcyBzbGlnaHRseSBkaWZmZXJlbnQgZnJvbSBTVE0zMkg3IG9uZToNCj4+IHJlZ2lzdGVyIG1h
cC9iaXRzIG9mZnNldHMgYXJlIGRpZmZlcmVudCBhbmQgU1RNMzJINyBoYXMgYW4gUlggYW5kIFRY
DQo+PiBGSUZPLg0KPj4gQnV0IGlmIHlvdSBoYXZlIGEgbG9vayBvbiBTVE0zMkY3IFNQSSBbMV0s
IHlvdSdsbCBzZWUgdGhhdCBTVE0zMkY3DQo+PiBTUEkNCj4+IGlzIGJhc2VkIG9uIFNUTTMyRjQg
U1BJIHdpdGggbmV3IGZlYXR1cmVzIChkYXRhIGZyYW1lcyAmIEZJRk9zKSBhbHNvDQo+PiBhdmFp
bGFibGUgb24gU1RNMzJINyBTUEkuDQo+Pg0KPj4gVGhhdCdzIHdoeSBTVE0zMkg3IFNQSSBkcml2
ZXIgd2FzIGNhbGxlZCBzcGktc3RtMzIuIFRoZSBnb2FsIHdhcyB0bw0KPj4gdXNlDQo+PiBjb21w
YXRpYmxlICYgbWF0Y2ggZGF0YSB0byBkaWZmZXJlbnRpYXRlIGVhY2ggU1RNMzJGeCBzcGVjaWZp
Y2l0aWVzLg0KPj4NCj4+IFlvdSBjYW4gaGF2ZSBhIGxvb2sgb24gaG93IGl0IGlzIG1hbmFnZWQg
aW4gZHJpdmVycy9ydGMvcnRjLXN0bTMyLmMNCj4+ICh0aGUNCj4+IHNhbWUgZHJpdmVyIGNvdmVy
cyAyIEhXIHZlcnNpb24gb2YgU1RNMzIgUlRDKSwgb3IgaW4NCj4+IGRyaXZlcnMvaWlvL2RhYy9z
dG0zMi1kYWMtY29yZS5jIGFuZCBzdG0zMi1kYWMuYyAodGhlIHNhbWUgZHJpdmVyDQo+PiBhbHNv
DQo+PiBjb3ZlcnMgMiBIVyB2ZXJzaW9uIG9mIFNUTTMyIERBQykuDQo+PiBBcyB5b3VyIHNwaS1z
dG0zMmY0LmMgZmlsZSBpcyBoaWdobHkgYmFzZWQgb24gdGhlIGV4aXN0aW5nIHNwaS0NCj4+IHN0
bTMyLmMNCj4+IGZpbGUsIEkgdGhpbmsgdGhhdCBjb21tb24gY29kZSBjb3VsZCBiZSBmYWN0b3Jl
ZCBhbmQgc3BlY2lmaWNpdGllcw0KPj4gY291bGQNCj4+IGJlIGhhbmRsZWQgd2l0aCBjb21wYXRp
YmxlIGFuZCBtYXRjaCBkYXRhLg0KPiANCj4gSSBoYXZlIHNlZW4gdGhlc2UgZHJpdmVycyBiZWZv
cmUuIEkgaGF2ZSBiZWVuIHRyeWluZyB0byBkbyB0aGlzIGZvciBteQ0KPiBwcmV2aW91cyBhcHBy
b2FjaCBhbmQgaXQgaXMgc3RpbGwgb24gbXkgc2Vjb25kIGJyYW5jaC4gVGhlcmUgd2FzIG5vdA0K
PiB0b28gbXVjaCBjb21tb24gcGFydHMgYW5kIEkgaGF2ZSBzdHVjayB3aXRoIGNvbXBsZXggY29t
cGF0aWJsZSBkYXRhDQo+IGNvbmZpZ3VyYXRpb25zLiBJIHRob3VnaHQgdGhhdCB3YXMgdG9vIHZl
cmJvc2UsIHRoZXJlZm9yZSBJIHJlc2lnbmVkDQo+IGZvciBpdCBhbmQgaGF2ZSBnb25lIGludG8g
aWRlYSB3aXRoIHR3byB0b3RhbGx5IGRpZmZlcmVudCBmaWxlcy4gSQ0KPiB0aGluayBJIG5lZWQg
dG8gZ2V0IGRvd24gYWdhaW4gdG8gaWRlYSB5b3UgcHJvcG9zZWQuDQo+IA0KPiBJdCBzZWVtcyB0
byBiZSBtb3JlIGRpZmZpY3VsdCBhcHByb2FjaCBhbmQgaXQgaXMgZ29ubmEgdGFrZSBhIHdoaWxl
DQo+IGJlZm9yZSBJIHNlbmQgc2Vjb25kIHZlcnNpb24gb2YgdGhlc2UgcGF0Y2hlcy4NCj4gDQo+
IFJlZ2FyZHMsDQo+IENlemFyeQ0KPiANCg0KU3VyZSBpdCBpc24ndCB0aGUgZWFzaWVzdCBhcHBy
b2FjaCBidXQgaXQgd2lsbCBiZSBsZXNzIGRpZmZpY3VsdCB0byBhZGQgDQpTVE0zMkY3IFNQSSBz
dXBwb3J0IHRoZW4hDQoNCkkgY291bGQgdGVzdCB5b3VyIHNlY29uZCB2ZXJzaW9uIHdoZW4gaXQg
d2lsbCBiZSBhdmFpbGFibGUsIG9uIA0KU1RNMzJINzQzaS1ldmFsIGlmIHlvdSBkb24ndCBoYXZl
IG9uZS4NCg0KUmVnYXJkcywNCkFtZWxpZQ0KDQo+PiBSZWdhcmRzLA0KPj4gQW1lbGllDQo+PiBb
MV0NCj4+IGh0dHBzOi8vd3d3LnN0LmNvbS9jb250ZW50L2NjYy9yZXNvdXJjZS90ZWNobmljYWwv
ZG9jdW1lbnQvcmVmZXJlbmNlXw0KPj4gbWFudWFsL2M1L2NmL2VmLzUyL2MwL2YxLzRiL2ZhL0RN
MDAxMjQ4NjUucGRmL2ZpbGVzL0RNMDAxMjQ4NjUucGRmL2pjDQo+PiByOmNvbnRlbnQvdHJhbnNs
YXRpb25zL2VuLkRNMDAxMjQ4NjUucGRmDQo+Pg0KPj4+DQo+Pj4gRm9yIGN1cnJlbnQgdmVyc2lv
biBtYXN0ZXIgbW9kZSB3aXRoIGZ1bGwtZHVwbGV4IGFuZCA4LzE2IGJpdCBkYXRhDQo+Pj4gZnJh
bWUNCj4+PiBmb3JtYXQgYXJlIHN1cHBvcnRlZC4gVGhlcmUgaXMgbm8gVFggYW5kIFJYIEZJRk9z
IGxpa2UgaW4gU1RNMzJINy4NCj4+PiBETUEgY2FwYWJpbGlsaXR5IGlzIHN1cHBvcnRlZCBmb3Ig
bWVzc2FnZXMgbG9uZ2VyIHRoYW4gYXJiaXRyYXJ5DQo+Pj4gbnVtYmVyDQo+Pj4gb2YgYnl0ZXMg
KHRoYXQgaXMgc2V0IGFscmVhZHkgdG8gMTYgYnl0ZXMpIHdoZW4gVFggYW5kIFJYIGNoYW5uZWxz
DQo+Pj4gYXJlDQo+Pj4gc2V0IGF0IHRoZSBzYW1lIHRpbWUuDQo+Pj4NCj4+PiBDZXphcnkgR2Fw
aW5za2kgKDUpOg0KPj4+ICDCoMKgwqBzcGk6IHN0bTMyOiByZW5hbWUgU1RNMzIgU1BJIHJlZ2lz
dGVycyBhbmQgZnVuY3Rpb25zIHRvIFNUTTMySDcNCj4+PiAgwqDCoMKgc3BpOiBzdG0zMjogcmVu
YW1lIHNwaS1zdG0zMiB0byBzcGktc3RtMzJoNw0KPj4+ICDCoMKgwqBzcGk6IHN0bTMyOiBhZGQg
ZHJpdmVyIGZvciBTVE0zMkY0IGNvbnRyb2xsZXINCj4+PiAgwqDCoMKgQVJNOiBkdHM6IHN0bTMy
OiBhZGQgU1BJIHN1cHBvcnQgb24gU1RNMzJGNDI5IFNvQw0KPj4+ICDCoMKgwqBzcGk6IHN0bTMy
OiBhZGQgZGVzY3JpcHRpb24gYWJvdXQgU1RNMzJGNCBiaW5kaW5ncw0KPj4+DQo+Pj4gIMKgIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktc3RtMzIudHh0wqDCoMKgwqDCoMKgwqDCoMKg
wqB8wqDCoMKgwqA5ICstDQo+Pj4gIMKgIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyZjQyOS5kdHNp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgNjAgKw0KPj4+ICDC
oCBkcml2ZXJzL3NwaS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAxOCArLQ0KPj4+ICDCoCBkcml2ZXJz
L3NwaS9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoMKgMyArLQ0KPj4+ICDCoCBkcml2ZXJzL3NwaS9zcGkt
c3RtMzIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfCAxMzIyIC0tLS0tDQo+Pj4gLS0tLS0tLS0tLS0tLS0NCj4+PiAgwqAgZHJpdmVycy9z
cGkvc3BpLXN0bTMyZjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB8IDEwMDINCj4+PiArKysrKysrKysrKysrKysNCj4+PiAgwqAgZHJpdmVycy9z
cGkvc3BpLXN0bTMyaDcuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB8IDEzNDANCj4+PiArKysrKysrKysrKysrKysrKysrKw0KPj4+ICDCoCA3IGZp
bGVzIGNoYW5nZWQsIDI0MjQgaW5zZXJ0aW9ucygrKSwgMTMzMCBkZWxldGlvbnMoLSkNCj4+PiAg
wqAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3BpL3NwaS1zdG0zMi5jDQo+Pj4gIMKgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktc3RtMzJmNC5jDQo+Pj4gIMKgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktc3RtMzJoNy5jCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
