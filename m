Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F597C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:35:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42FD20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gAXsEJAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42FD20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mbiREsZ92yHEUky20pyjzpOcEhRs7ALA5FzrGk27h04=; b=gAXsEJAgmybiseOcKKj41FGFx
	IyZ9CGB9TvjoEykeDnw9pRMUXMGL4pJm9eyvYjVS1o76Tl3MZYfRLNBmTIUtVC8tIVW7qkFlMV4pd
	redLaHXo6lNZWEiCBT66GCdNHXPyt/VIdriwnpq3ZhQqYv9+iadFg/FT0unM3GBDFG/XU5urT7642
	wfxK3xzVcbXo9mIOO6QPaQiE35XQbeaaZBOaTrPf+QLreiKeQCmhx4eluEXR9S3KHj0jthfRVhaCG
	UsqJWMVDO+dSPKcbKr3xy7rKO8XmucEJ6r7eZhY8vEmU/c53FKASZUpqxb/UV379TrF5Cc/ZJXa/O
	R+d37mNtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf0Lr-0005Z2-Ni; Thu, 03 Jan 2019 10:35:47 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf0Lo-0005YY-Od
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:35:46 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x03AVSJ4012790; Thu, 3 Jan 2019 11:35:38 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pp0pm2m19-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 03 Jan 2019 11:35:38 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E54C38;
 Thu,  3 Jan 2019 10:35:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B92F74EB9;
 Thu,  3 Jan 2019 10:35:36 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Jan
 2019 11:35:35 +0100
Subject: Re: [PATCH V3 1/2] mmc: mmci: add variant property to set command
 stop bit
From: Ludovic BARRE <ludovic.barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
 <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
Message-ID: <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Date: Thu, 3 Jan 2019 11:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_023545_091484_31518E47 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

aGkgVWxmCgpoYXBweSBuZXcgeWVhcnMuCgpKdXN0IGEgZ2VudGxlbWFuIHBpbmcgYWJvdXQgcGF0
Y2gyIG9mIHRoaXMgc2VyaWVzCiJtbWM6IG1tY2k6IHNlbmQgc3RvcCBjb21tYW5kIHRvIGNsZWFy
IHRoZSBkcHNtLiIKClJlZ2FyZHMKTHVkbwoKT24gMTIvMTEvMTggMTA6NTMgQU0sIEx1ZG92aWMg
QkFSUkUgd3JvdGU6Cj4gCj4gCj4gT24gMTIvMTEvMTggMTA6NDcgQU0sIFVsZiBIYW5zc29uIHdy
b3RlOgo+PiBPbiBUaHUsIDYgRGVjIDIwMTggYXQgMTY6MTMsIEx1ZG92aWMgQmFycmUgPGx1ZG92
aWMuQmFycmVAc3QuY29tPiB3cm90ZToKPj4+Cj4+PiBGcm9tOiBMdWRvdmljIEJhcnJlIDxsdWRv
dmljLmJhcnJlQHN0LmNvbT4KPj4+Cj4+PiBPbiBjbWQxMiAoU1RPUF9UUkFOU01JU1NJT04pLCBT
VE0zMiBzZG1tYyB2YXJpYW50IG5lZWRzIHRvIHNldAo+Pj4gY21kc3RvcCBiaXQgaW4gY29tbWFu
ZCByZWdpc3Rlci4gVGhlIENQU00gKCJDb21tYW5kIFBhdGggU3RhdGUgTWFjaGluZSIpCj4+PiB0
cmVhdHMgdGhlIGNvbW1hbmQgYXMgYSBTdG9wIFRyYW5zbWlzc2lvbiBjb21tYW5kIGFuZCBzaWdu
YWxzCj4+PiBhYm9ydCB0byB0aGUgRFBTTSAoIkRhdGEgUGF0aCBTdGF0ZSBNYWNoaW5lIikuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTHVkb3ZpYyBCYXJyZSA8bHVkb3ZpYy5iYXJyZUBzdC5jb20+
Cj4+Cj4+IEFwcGxpZWQgZm9yIG5leHQsIHRoYW5rcyEKPiAKPiB0aGFua3MKPiAKPj4KPj4gV2l0
aGhvbGRpbmcgcGF0Y2gyIGZvciBhIHdoaWxlLCBhcyBJIG5lZWQgc29tZSBtb3JlIHRpbWUgdG8g
cmV2aWV3IGl0Lgo+IAo+IE5vIHByb2JsZW0sCj4gCj4gUmVnYXJkcwo+IEx1ZG8KPiAKPj4KPj4g
S2luZCByZWdhcmRzCj4+IFVmZmUKPj4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9tbWMvaG9zdC9t
bWNpLmMgfCA2ICsrKysrKwo+Pj4gwqAgZHJpdmVycy9tbWMvaG9zdC9tbWNpLmggfCAyICsrCj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9ob3N0L21tY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jCj4+PiBp
bmRleCAxM2ZhNjQwLi5lMzUyZjVhIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9t
bWNpLmMKPj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5jCj4+PiBAQCAtMjEsNiArMjEs
NyBAQAo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4
L2hpZ2htZW0uaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9sb2cyLmg+Cj4+PiArI2luY2x1ZGUg
PGxpbnV4L21tYy9tbWMuaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9tbWMvcG0uaD4KPj4+IMKg
ICNpbmNsdWRlIDxsaW51eC9tbWMvaG9zdC5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tYy9j
YXJkLmg+Cj4+PiBAQCAtMjc0LDYgKzI3NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmFyaWFudF9kYXRh
IHZhcmlhbnRfc3RtMzJfc2RtbWMgPSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIC5jbWRyZWdfbHJz
cF9jcmPCoMKgwqDCoMKgwqDCoCA9IE1DSV9DUFNNX1NUTTMyX0xSU1BfQ1JDLAo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCAuY21kcmVnX3Nyc3BfY3JjwqDCoMKgwqDCoMKgwqAgPSBNQ0lfQ1BTTV9TVE0z
Ml9TUlNQX0NSQywKPj4+IMKgwqDCoMKgwqDCoMKgwqAgLmNtZHJlZ19zcnNwwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA9IE1DSV9DUFNNX1NUTTMyX1NSU1AsCj4+PiArwqDCoMKgwqDCoMKgIC5jbWRy
ZWdfc3RvcMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBNQ0lfQ1BTTV9TVE0zMl9DTURTVE9QLAo+
Pj4gwqDCoMKgwqDCoMKgwqDCoCAuZGF0YV9jbWRfZW5hYmxlwqDCoMKgwqDCoMKgwqAgPSBNQ0lf
Q1BTTV9TVE0zMl9DTURUUkFOUywKPj4+IMKgwqDCoMKgwqDCoMKgwqAgLmlycV9waW9fbWFza8Kg
wqDCoMKgwqDCoMKgwqDCoMKgID0gTUNJX0lSUV9QSU9fU1RNMzJfTUFTSywKPj4+IMKgwqDCoMKg
wqDCoMKgwqAgLmRhdGFjdHJsX2ZpcnN0wqDCoMKgwqDCoMKgwqDCoCA9IHRydWUsCj4+PiBAQCAt
MTEwMCw2ICsxMTAyLDEwIEBAIG1tY2lfc3RhcnRfY29tbWFuZChzdHJ1Y3QgbW1jaV9ob3N0ICpo
b3N0LCAKPj4+IHN0cnVjdCBtbWNfY29tbWFuZCAqY21kLCB1MzIgYykKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1tY2lfcmVnX2RlbGF5KGhvc3QpOwo+Pj4gwqDCoMKgwqDC
oMKgwqDCoCB9Cj4+Pgo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoaG9zdC0+dmFyaWFudC0+Y21kcmVn
X3N0b3AgJiYKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQtPm9wY29kZSA9PSBNTUNfU1RP
UF9UUkFOU01JU1NJT04pCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjIHw9IGhv
c3QtPnZhcmlhbnQtPmNtZHJlZ19zdG9wOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBjIHw9
IGNtZC0+b3Bjb2RlIHwgaG9zdC0+dmFyaWFudC0+Y21kcmVnX2Nwc21fZW5hYmxlOwo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCBpZiAoY21kLT5mbGFncyAmIE1NQ19SU1BfUFJFU0VOVCkgewo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNtZC0+ZmxhZ3MgJiBNTUNfUlNQXzEz
NikKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L21tY2kuaCBiL2RyaXZlcnMvbW1j
L2hvc3QvbW1jaS5oCj4+PiBpbmRleCA1NTBkZDM5Li4yNDIyOTA5IDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9tbWNpLmgKPj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5o
Cj4+PiBAQCAtMjY0LDYgKzI2NCw3IEBAIHN0cnVjdCBtbWNpX2hvc3Q7Cj4+PiDCoMKgICogQGNt
ZHJlZ19scnNwX2NyYzogZW5hYmxlIHZhbHVlIGZvciBsb25nIHJlc3BvbnNlIHdpdGggY3JjCj4+
PiDCoMKgICogQGNtZHJlZ19zcnNwX2NyYzogZW5hYmxlIHZhbHVlIGZvciBzaG9ydCByZXNwb25z
ZSB3aXRoIGNyYwo+Pj4gwqDCoCAqIEBjbWRyZWdfc3JzcDogZW5hYmxlIHZhbHVlIGZvciBzaG9y
dCByZXNwb25zZSB3aXRob3V0IGNyYwo+Pj4gKyAqIEBjbWRyZWdfc3RvcDogZW5hYmxlIHZhbHVl
IGZvciBzdG9wIGFuZCBhYm9ydCB0cmFuc21pc3Npb24KPj4+IMKgwqAgKiBAZGF0YWxlbmd0aF9i
aXRzOiBudW1iZXIgb2YgYml0cyBpbiB0aGUgTU1DSURBVEFMRU5HVEggcmVnaXN0ZXIKPj4+IMKg
wqAgKiBAZmlmb3NpemU6IG51bWJlciBvZiBieXRlcyB0aGF0IGNhbiBiZSB3cml0dGVuIHdoZW4g
Cj4+PiBNTUNJX1RYRklGT0VNUFRZCj4+PiDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcyBh
c3NlcnRlZCAobGlrZXdpc2UgZm9yIFJYKQo+Pj4gQEAgLTMxNiw2ICszMTcsNyBAQCBzdHJ1Y3Qg
dmFyaWFudF9kYXRhIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjbWRyZWdfbHJzcF9jcmM7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIHVuc2ln
bmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY21kcmVnX3Nyc3BfY3JjOwo+Pj4gwqDCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNtZHJlZ19zcnNw
Owo+Pj4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNt
ZHJlZ19zdG9wOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRhdGFsZW5ndGhfYml0czsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQg
aW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWZvc2l6ZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqAg
dW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaWZvaGFsZnNpemU7Cj4+PiAtLSAK
Pj4+IDIuNy40Cj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
