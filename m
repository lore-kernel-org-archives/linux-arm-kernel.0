Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EDA2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PYwSR/yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EDA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gV+0Oubv78DiLWk9Ullm/jKRtm1yOG/Bjzs0purOyeE=; b=PYwSR/ygzulZgP
	ausB0MWuv6O3z3LtVM0lj7LeMxJM7FTg0DiIZBRlFWOwN4Ul9ULoWbvKJ2tVEYJb3ZQk6o9C0X4KN
	ZXIv9pUPKp132xTbKZh9u9kbO65GtJ8tzZnIcPlI73mfRvsvkuWaLLjwlvrhOAZ8soudvn8BzWRM0
	cgSU9gbWOdgH+Ir3T3HIcRghl3NSHUgdvvJ/dq6e4RCQM7GrtIehKKZkW+nLmL0shrQilp6Y+bs1V
	vn8IcHkYl7E9jAbcjgYgbtDjWzRApuzN8RA+MoJ2XS3IErNdcstbWGreWJFp7COxt6y8RkrpqaEQ7
	wN3lc/Y/sPMgKtBL9Aqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTTu-0003G0-0g; Tue, 12 Feb 2019 08:31:54 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTTp-0003FB-F5
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:31:51 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1C8VOwd016393; Tue, 12 Feb 2019 09:31:40 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qjfy63dwg-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 12 Feb 2019 09:31:40 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CAFFE38;
 Tue, 12 Feb 2019 08:31:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8468A2449;
 Tue, 12 Feb 2019 08:31:38 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 12 Feb
 2019 09:31:37 +0100
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
Date: Tue, 12 Feb 2019 09:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-12_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_003149_785652_DAFF275D 
X-CRM114-Status: GOOD (  16.09  )
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

T24gMi8xMS8xOSA4OjA2IFBNLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPiBIZWxsbyBGYWJy
aWNlLAo+IAo+IE9uIE1vbiwgRmViIDExLCAyMDE5IGF0IDA1OjEyOjAyUE0gKzAxMDAsIEZhYnJp
Y2UgR2FzbmllciB3cm90ZToKPj4gQWRkIGEgZGV2aWNlIGxpbmsgYmV0d2VlbiB0aGUgUFdNIGNv
bnN1bWVyIGFuZCB0aGUgUFdNIHByb3ZpZGVyLiBUaGlzCj4+IGVuZm9yY2VzIHRoZSBQV00gdXNl
ciB0byBnZXQgc3VzcGVuZGVkIGJlZm9yZSB0aGUgUFdNIHByb3ZpZGVyLiBJdAo+PiBhbGxvd3Mg
cHJvcGVyIHN5bmNocm9uaXphdGlvbiBvZiBzdXNwZW5kL3Jlc3VtZSBzZXF1ZW5jZXM6IHRoZSBQ
V00gdXNlcgo+PiBpcyByZXNwb25zaWJsZSBmb3IgcHJvcGVybHkgc3RvcHBpbmcgUFdNLCBiZWZv
cmUgdGhlIHByb3ZpZGVyIGdldHMKPj4gc3VzcGVuZGVkOiBzZWUgWzFdLiBBZGQgdGhlIGRldmlj
ZSBsaW5rIGluOgo+PiAtIHB3bV9nZXQoKQo+PiAtIGRldm1fcHdtX2dldCgpCj4+IC0gZGV2bV9v
Zl9wd21fZ2V0KCkKPj4gYXMgaXQgcmVxdWlyZXMgYSByZWZlcmVuY2UgdG8gdGhlIGRldmljZSBm
b3IgdGhlIFBXTSBjb25zdW1lci4KPj4KPj4gWzFdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5
LzIvNS83NzAKPj4KPj4gU3VnZ2VzdGVkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRp
bmdAZ21haWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBGYWJyaWNlIEdhc25pZXIgPGZhYnJpY2Uu
Z2FzbmllckBzdC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9wd20vY29yZS5jIHwgMTMgKysrKysr
KysrKystLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9jb3JlLmMgYi9kcml2ZXJzL3B3bS9j
b3JlLmMKPj4gaW5kZXggMTU4MWY2YS4uMjgzNWUyNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9w
d20vY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMvcHdtL2NvcmUuYwo+PiBAQCAtNzcwLDggKzc3MCwx
MyBAQCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IGNoYXIgKmNvbl9pZCkKPj4gIAlpbnQgZXJyOwo+PiAgCj4+ICAJLyogbG9vayB1cCB2aWEgRFQg
Zmlyc3QgKi8KPj4gLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfT0YpICYmIGRldiAmJiBkZXYtPm9m
X25vZGUpCj4+IC0JCXJldHVybiBvZl9wd21fZ2V0KGRldi0+b2Zfbm9kZSwgY29uX2lkKTsKPj4g
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfT0YpICYmIGRldiAmJiBkZXYtPm9mX25vZGUpIHsKPj4g
KwkJcHdtID0gb2ZfcHdtX2dldChkZXYtPm9mX25vZGUsIGNvbl9pZCk7Cj4+ICsJCWlmICghSVNf
RVJSKHB3bSkpCj4+ICsJCQlkZXZpY2VfbGlua19hZGQoZGV2LCBwd20tPmNoaXAtPmRldiwKPj4g
KwkJCQkJRExfRkxBR19BVVRPUkVNT1ZFX0NPTlNVTUVSKTsKPj4gKwkJcmV0dXJuIHB3bTsKPj4g
Kwl9Cj4+ICAKPj4gIAkvKgo+PiAgCSAqIFdlIGxvb2sgdXAgdGhlIHByb3ZpZGVyIGluIHRoZSBz
dGF0aWMgdGFibGUgdHlwaWNhbGx5IHByb3ZpZGVkIGJ5Cj4+IEBAIC04NTEsNiArODU2LDggQEAg
c3RydWN0IHB3bV9kZXZpY2UgKnB3bV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFy
ICpjb25faWQpCj4+ICAJcHdtLT5hcmdzLnBlcmlvZCA9IGNob3Nlbi0+cGVyaW9kOwo+PiAgCXB3
bS0+YXJncy5wb2xhcml0eSA9IGNob3Nlbi0+cG9sYXJpdHk7Cj4+ICAKPj4gKwlkZXZpY2VfbGlu
a19hZGQoZGV2LCBwd20tPmNoaXAtPmRldiwgRExfRkxBR19BVVRPUkVNT1ZFX0NPTlNVTUVSKTsK
Pj4gKwo+PiAgCXJldHVybiBwd207Cj4+ICB9Cj4+ICBFWFBPUlRfU1lNQk9MX0dQTChwd21fZ2V0
KTsKPj4gQEAgLTk0Myw2ICs5NTAsOCBAQCBzdHJ1Y3QgcHdtX2RldmljZSAqZGV2bV9vZl9wd21f
Z2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpucCwKPj4gIAlpZiAo
IUlTX0VSUihwd20pKSB7Cj4+ICAJCSpwdHIgPSBwd207Cj4+ICAJCWRldnJlc19hZGQoZGV2LCBw
dHIpOwo+PiArCQlkZXZpY2VfbGlua19hZGQoZGV2LCBwd20tPmNoaXAtPmRldiwKPj4gKwkJCQlE
TF9GTEFHX0FVVE9SRU1PVkVfQ09OU1VNRVIpOwo+IAo+IElNSE8gaXQncyBzdXJwcmlzaW5nIHRo
YXQgZGV2bV9vZl9wd21fZ2V0KCkgZG9lcyBtb3JlIHRoYW4gb2ZfcHdtX2dldCgpCj4gKyBkZXZy
ZXMgc3R1ZmYuIEknZCBwdXQgZGV2aWNlX2xpbmtfYWRkKCkgaW50byBvZl9wd21fZ2V0KCkuCgpI
aSBVd2UsCgpJIGFsc28gYWdyZWUgd2l0aCB0aGlzLiBCdXQgSSB0aGluayB0aGlzIGltcGxpZXMg
bW9kaWZ5aW5nIHRoZSBBUEkgZm9yCm9mX3B3bV9nZXQoKToKIC8qKgogICogb2ZfcHdtX2dldCgp
IC0gcmVxdWVzdCBhIFBXTSB2aWEgdGhlIFBXTSBmcmFtZXdvcmsKKyAqIEBkZXY6IGRldmljZSBm
b3IgUFdNIGNvbnN1bWVyCiAgKiBAbnA6IGRldmljZSBub2RlIHRvIGdldCB0aGUgUFdNIGZyb20K
ICAqIEBjb25faWQ6IGNvbnN1bWVyIG5hbWUKCkl0IHNlZW1zIHRoZXJlIGFyZW4ndCBtdWNoIG9m
X3B3bV9nZXQoKSB1c2VycyBjdXJyZW50bHkuCkRvZXMgdGhpcyBsb29rIHNlbnNpYmxlID8KCkJl
c3QgcmVnYXJkcywKRmFicmljZQoKPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
