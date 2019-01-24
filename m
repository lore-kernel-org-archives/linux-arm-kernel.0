Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14983C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB53321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h3WDv3bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB53321872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G8HM3pCrl7sfFU44JgsKl6ff/V2EDSgIkE92H9/xJIw=; b=h3WDv3bh9xPp4g0fbTUCeT6t3
	zkP8WIZozj3CSphyJrDhUiegmUiRtw+pZUqYzrt5LeEp3xeA6E/lCyMSvXjDaTpFYhjMRzkKboeWe
	EiEGFo/jY4UlWo2KJrhtQTAqgixfbg28GiGPsnzxyuLs/PTbSPydZzUQt9ALYQhdtg/6mSmix/lbd
	7s1M9WUvxp41c8PmQKyVqHcp1TOqTMDNm0mk0Rh68PC+noa6OkFiBwE0SdctW4FEIx6jT8gTWnYqJ
	sz2bUPd2qys720ebH1qn7xCbG91PLHyHfPyXiuEK2z0P2/JdsNMZc12xwunVi3ljR1Fv7yGw7H2eU
	ov15xRgbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgY5-0004ll-2T; Thu, 24 Jan 2019 15:04:09 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgXq-0004jF-6T
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:03:57 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0OF1L0L027236; Thu, 24 Jan 2019 16:03:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q3wv45bt4-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 24 Jan 2019 16:03:42 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C481331;
 Thu, 24 Jan 2019 15:03:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9B8294FEB;
 Thu, 24 Jan 2019 15:03:39 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.44) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 24 Jan
 2019 16:03:39 +0100
Subject: Re: [Linux-stm32] [PATCH V3 1/2] mmc: mmci: add variant property to
 set command stop bit
From: Ludovic BARRE <ludovic.barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
 <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com>
 <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Message-ID: <ab4cae87-0a5a-fe22-08ab-7c7661be7c8c@st.com>
Date: Thu, 24 Jan 2019 16:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-24_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_070354_530850_F7D4E496 
X-CRM114-Status: GOOD (  17.18  )
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

aGkgVWxmCgpJIGRvbid0IHRoaW5rIHlvdSd2ZSBzZWVuIG15IHByZXZpb3VzIG1haWwgOi0oCndo
YXQgaXMgeW91ciBmZWVsaW5nIGFib3V0ICJtbWM6IG1tY2k6IHNlbmQgc3RvcCBjb21tYW5kIHRv
IGNsZWFyIHRoZSBkcHNtIgoKUmVnYXJkcwpMdWRvCgpPbiAxLzMvMTkgMTE6MzUgQU0sIEx1ZG92
aWMgQkFSUkUgd3JvdGU6Cj4gaGkgVWxmCj4gCj4gaGFwcHkgbmV3IHllYXJzLgo+IAo+IEp1c3Qg
YSBnZW50bGVtYW4gcGluZyBhYm91dCBwYXRjaDIgb2YgdGhpcyBzZXJpZXMKPiAibW1jOiBtbWNp
OiBzZW5kIHN0b3AgY29tbWFuZCB0byBjbGVhciB0aGUgZHBzbS4iCj4gCj4gUmVnYXJkcwo+IEx1
ZG8KPiAKPiBPbiAxMi8xMS8xOCAxMDo1MyBBTSwgTHVkb3ZpYyBCQVJSRSB3cm90ZToKPj4KPj4K
Pj4gT24gMTIvMTEvMTggMTA6NDcgQU0sIFVsZiBIYW5zc29uIHdyb3RlOgo+Pj4gT24gVGh1LCA2
IERlYyAyMDE4IGF0IDE2OjEzLCBMdWRvdmljIEJhcnJlIDxsdWRvdmljLkJhcnJlQHN0LmNvbT4g
d3JvdGU6Cj4+Pj4KPj4+PiBGcm9tOiBMdWRvdmljIEJhcnJlIDxsdWRvdmljLmJhcnJlQHN0LmNv
bT4KPj4+Pgo+Pj4+IE9uIGNtZDEyIChTVE9QX1RSQU5TTUlTU0lPTiksIFNUTTMyIHNkbW1jIHZh
cmlhbnQgbmVlZHMgdG8gc2V0Cj4+Pj4gY21kc3RvcCBiaXQgaW4gY29tbWFuZCByZWdpc3Rlci4g
VGhlIENQU00gKCJDb21tYW5kIFBhdGggU3RhdGUgCj4+Pj4gTWFjaGluZSIpCj4+Pj4gdHJlYXRz
IHRoZSBjb21tYW5kIGFzIGEgU3RvcCBUcmFuc21pc3Npb24gY29tbWFuZCBhbmQgc2lnbmFscwo+
Pj4+IGFib3J0IHRvIHRoZSBEUFNNICgiRGF0YSBQYXRoIFN0YXRlIE1hY2hpbmUiKS4KPj4+Pgo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEx1ZG92aWMgQmFycmUgPGx1ZG92aWMuYmFycmVAc3QuY29tPgo+
Pj4KPj4+IEFwcGxpZWQgZm9yIG5leHQsIHRoYW5rcyEKPj4KPj4gdGhhbmtzCj4+Cj4+Pgo+Pj4g
V2l0aGhvbGRpbmcgcGF0Y2gyIGZvciBhIHdoaWxlLCBhcyBJIG5lZWQgc29tZSBtb3JlIHRpbWUg
dG8gcmV2aWV3IGl0Lgo+Pgo+PiBObyBwcm9ibGVtLAo+Pgo+PiBSZWdhcmRzCj4+IEx1ZG8KPj4K
Pj4+Cj4+PiBLaW5kIHJlZ2FyZHMKPj4+IFVmZmUKPj4+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVy
cy9tbWMvaG9zdC9tbWNpLmMgfCA2ICsrKysrKwo+Pj4+IMKgIGRyaXZlcnMvbW1jL2hvc3QvbW1j
aS5oIHwgMiArKwo+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4+Pj4K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMgYi9kcml2ZXJzL21tYy9o
b3N0L21tY2kuYwo+Pj4+IGluZGV4IDEzZmE2NDAuLmUzNTJmNWEgMTAwNjQ0Cj4+Pj4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMKPj4+PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L21tY2ku
Ywo+Pj4+IEBAIC0yMSw2ICsyMSw3IEBACj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgo+
Pj4+IMKgICNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+Cj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4
L2xvZzIuaD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L21tYy9tbWMuaD4KPj4+PiDCoCAjaW5jbHVk
ZSA8bGludXgvbW1jL3BtLmg+Cj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tYy9ob3N0Lmg+Cj4+
Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tYy9jYXJkLmg+Cj4+Pj4gQEAgLTI3NCw2ICsyNzUsNyBA
QCBzdGF0aWMgc3RydWN0IHZhcmlhbnRfZGF0YSB2YXJpYW50X3N0bTMyX3NkbW1jID0gewo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqAgLmNtZHJlZ19scnNwX2NyY8KgwqDCoMKgwqDCoMKgID0gTUNJX0NQ
U01fU1RNMzJfTFJTUF9DUkMsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAuY21kcmVnX3Nyc3BfY3Jj
wqDCoMKgwqDCoMKgwqAgPSBNQ0lfQ1BTTV9TVE0zMl9TUlNQX0NSQywKPj4+PiDCoMKgwqDCoMKg
wqDCoMKgIC5jbWRyZWdfc3JzcMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBNQ0lfQ1BTTV9TVE0z
Ml9TUlNQLAo+Pj4+ICvCoMKgwqDCoMKgwqAgLmNtZHJlZ19zdG9wwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA9IE1DSV9DUFNNX1NUTTMyX0NNRFNUT1AsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAuZGF0
YV9jbWRfZW5hYmxlwqDCoMKgwqDCoMKgwqAgPSBNQ0lfQ1BTTV9TVE0zMl9DTURUUkFOUywKPj4+
PiDCoMKgwqDCoMKgwqDCoMKgIC5pcnFfcGlvX21hc2vCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IE1D
SV9JUlFfUElPX1NUTTMyX01BU0ssCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAuZGF0YWN0cmxfZmly
c3TCoMKgwqDCoMKgwqDCoMKgID0gdHJ1ZSwKPj4+PiBAQCAtMTEwMCw2ICsxMTAyLDEwIEBAIG1t
Y2lfc3RhcnRfY29tbWFuZChzdHJ1Y3QgbW1jaV9ob3N0ICpob3N0LCAKPj4+PiBzdHJ1Y3QgbW1j
X2NvbW1hbmQgKmNtZCwgdTMyIGMpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbW1jaV9yZWdfZGVsYXkoaG9zdCk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4KPj4+
PiArwqDCoMKgwqDCoMKgIGlmIChob3N0LT52YXJpYW50LT5jbWRyZWdfc3RvcCAmJgo+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQtPm9wY29kZSA9PSBNTUNfU1RPUF9UUkFOU01JU1NJT04p
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYyB8PSBob3N0LT52YXJpYW50LT5j
bWRyZWdfc3RvcDsKPj4+PiArCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBjIHw9IGNtZC0+b3Bjb2Rl
IHwgaG9zdC0+dmFyaWFudC0+Y21kcmVnX2Nwc21fZW5hYmxlOwo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGNtZC0+ZmxhZ3MgJiBNTUNfUlNQX1BSRVNFTlQpIHsKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoY21kLT5mbGFncyAmIE1NQ19SU1BfMTM2KQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L21tY2kuaCBiL2RyaXZlcnMvbW1jL2hvc3QvbW1j
aS5oCj4+Pj4gaW5kZXggNTUwZGQzOS4uMjQyMjkwOSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJz
L21tYy9ob3N0L21tY2kuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbW1jaS5oCj4+Pj4g
QEAgLTI2NCw2ICsyNjQsNyBAQCBzdHJ1Y3QgbW1jaV9ob3N0Owo+Pj4+IMKgwqAgKiBAY21kcmVn
X2xyc3BfY3JjOiBlbmFibGUgdmFsdWUgZm9yIGxvbmcgcmVzcG9uc2Ugd2l0aCBjcmMKPj4+PiDC
oMKgICogQGNtZHJlZ19zcnNwX2NyYzogZW5hYmxlIHZhbHVlIGZvciBzaG9ydCByZXNwb25zZSB3
aXRoIGNyYwo+Pj4+IMKgwqAgKiBAY21kcmVnX3Nyc3A6IGVuYWJsZSB2YWx1ZSBmb3Igc2hvcnQg
cmVzcG9uc2Ugd2l0aG91dCBjcmMKPj4+PiArICogQGNtZHJlZ19zdG9wOiBlbmFibGUgdmFsdWUg
Zm9yIHN0b3AgYW5kIGFib3J0IHRyYW5zbWlzc2lvbgo+Pj4+IMKgwqAgKiBAZGF0YWxlbmd0aF9i
aXRzOiBudW1iZXIgb2YgYml0cyBpbiB0aGUgTU1DSURBVEFMRU5HVEggcmVnaXN0ZXIKPj4+PiDC
oMKgICogQGZpZm9zaXplOiBudW1iZXIgb2YgYnl0ZXMgdGhhdCBjYW4gYmUgd3JpdHRlbiB3aGVu
IAo+Pj4+IE1NQ0lfVFhGSUZPRU1QVFkKPj4+PiDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
cyBhc3NlcnRlZCAobGlrZXdpc2UgZm9yIFJYKQo+Pj4+IEBAIC0zMTYsNiArMzE3LDcgQEAgc3Ry
dWN0IHZhcmlhbnRfZGF0YSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNtZHJlZ19scnNwX2NyYzsKPj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY21kcmVnX3Nyc3BfY3JjOwo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbWRy
ZWdfc3JzcDsKPj4+PiArwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY21kcmVnX3N0b3A7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRhdGFsZW5ndGhfYml0czsKPj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlmb3NpemU7Cj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpZm9oYWxmc2l6
ZTsKPj4+PiAtLSAKPj4+PiAyLjcuNAo+Pj4+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1zdG0zMiBtYWlsaW5nIGxpc3QKPiBMaW51eC1z
dG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tCj4gaHR0cHM6Ly9zdC1tZC1tYWlsbWFu
LnN0b3JtcmVwbHkuY29tL21haWxtYW4vbGlzdGluZm8vbGludXgtc3RtMzIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
