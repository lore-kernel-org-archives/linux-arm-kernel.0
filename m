Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC5AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7CF2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ho/IOmVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7CF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A8CY1Hze6/0gwBUFR1VdNoVXLfJNdvKuY0NmyBDh1jE=; b=Ho/IOmVzAE/fK9
	q0/c8kd8O01DTVLW20buLxKsV92obgfd6Q5bkY07XP9U5UkBuVohZFpEzqEi4SH59jS1NXPMYfNvQ
	sKGFzFzJnzQvBDrAkQz7RqAGDslcbL39HA2L2ThLHYVQhPG2DUmSUIEZMU263hj03BkZHrT47OBSn
	8HcxtXjE8TCud7IfWNyIUJkGNZNv17/63lrUH6V01fxwEftIrgYiZDU7tQnnhXhSZOmuYQ5b7lIMc
	GdpyBLJOXBInPc7uzVsBHJiJfYsFrI1HC08kzzpWuWAQGby5HzL9wLGr+dEF++ostaCNP7uO4pCkt
	wX413h7bo2Y0egZixQiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grItA-0006kb-HG; Wed, 06 Feb 2019 08:49:00 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grIt5-0006jx-TO
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 08:48:57 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x168fNlG019552; Wed, 6 Feb 2019 09:48:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qfv9n8100-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 06 Feb 2019 09:48:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E6C7231;
 Wed,  6 Feb 2019 08:42:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E711169B;
 Wed,  6 Feb 2019 08:42:50 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:42:48 +0100
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
To: Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
Date: Wed, 6 Feb 2019 09:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205222522.GB1372@mithrandir>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_004856_239992_A9F5AED7 
X-CRM114-Status: GOOD (  23.08  )
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

T24gMi81LzE5IDExOjI1IFBNLCBUaGllcnJ5IFJlZGluZyB3cm90ZToKPiBPbiBUdWUsIEZlYiAw
NSwgMjAxOSBhdCAwOTo0NzozMlBNICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPj4g
SGVsbG8sCj4+Cj4+IE9uIFR1ZSwgRmViIDA1LCAyMDE5IGF0IDAxOjQwOjI3UE0gKzAxMDAsIEZh
YnJpY2UgR2FzbmllciB3cm90ZToKPj4+IEFkZCBzdXNwZW5kL3Jlc3VtZSBQTSBzbGVlcCBvcHMu
IFdoZW4gZ29pbmcgdG8gbG93IHBvd2VyLCBkaXNhYmxlCj4+PiBhY3RpdmUgUFdNIGNoYW5uZWwu
IEFjdGl2ZSBQV00gY2hhbm5lbCBpcyByZXN1bWVkLCBieSBjYWxsaW5nCj4+PiBwd21fYXBwbHlf
c3RhdGUoKS4gVGhpcyBpcyBpbnNwaXJlZCBieSBUaGllcnJ5J3MgY29tbWVudCBpbiBbMV0uCj4+
PiBEb24ndCB0b3VjaCBpbmFjdGl2ZSBjaGFubmVscywgYXMgaXQgbWF5IGJlIHVzZWQgYnkgb3Ro
ZXIgTFBUaW1lciBNRkQKPj4+IGNoaWxkIGRyaXZlci4KPj4+IFsxXWh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDE3LzEyLzUvMTc1Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBHYXNuaWVy
IDxmYWJyaWNlLmdhc25pZXJAc3QuY29tPgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9wd20vcHdtLXN0
bTMyLWxwLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4g
IDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcHdtL3B3bS1zdG0zMi1scC5jIGIvZHJpdmVycy9wd20vcHdtLXN0bTMyLWxwLmMKPj4+
IGluZGV4IDAwNTliMjRjLi4wYzQwZDQ4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9wd20vcHdt
LXN0bTMyLWxwLmMKPj4+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1zdG0zMi1scC5jCj4+PiBAQCAt
MTMsNiArMTMsNyBAQAo+Pj4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3RtMzItbHB0aW1lci5oPgo+
Pj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPj4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4K
Pj4+ICsjaW5jbHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPgo+Pj4gICNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KPj4+ICAjaW5jbHVkZSA8bGludXgvcHdtLmg+Cj4+PiAg
Cj4+PiBAQCAtMjAsNiArMjEsOCBAQCBzdHJ1Y3Qgc3RtMzJfcHdtX2xwIHsKPj4+ICAJc3RydWN0
IHB3bV9jaGlwIGNoaXA7Cj4+PiAgCXN0cnVjdCBjbGsgKmNsazsKPj4+ICAJc3RydWN0IHJlZ21h
cCAqcmVnbWFwOwo+Pj4gKwlzdHJ1Y3QgcHdtX3N0YXRlIHN1c3BlbmQ7Cj4+PiArCWJvb2wgc3Vz
cGVuZGVkOwo+Pj4gIH07Cj4+PiAgCj4+PiAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc3RtMzJfcHdt
X2xwICp0b19zdG0zMl9wd21fbHAoc3RydWN0IHB3bV9jaGlwICpjaGlwKQo+Pj4gQEAgLTIyMyw2
ICsyMjYsNDAgQEAgc3RhdGljIGludCBzdG0zMl9wd21fbHBfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCj4+PiAgCXJldHVybiBwd21jaGlwX3JlbW92ZSgmcHJpdi0+Y2hpcCk7
Cj4+PiAgfQo+Pj4gIAo+Pj4gKyNpZmRlZiBDT05GSUdfUE1fU0xFRVAKPj4+ICtzdGF0aWMgaW50
IHN0bTMyX3B3bV9scF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+ICt7Cj4+PiArCXN0
cnVjdCBzdG0zMl9wd21fbHAgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKPj4+ICsKPj4+
ICsJcHdtX2dldF9zdGF0ZSgmcHJpdi0+Y2hpcC5wd21zWzBdLCAmcHJpdi0+c3VzcGVuZCk7Cj4+
PiArCXByaXYtPnN1c3BlbmRlZCA9IHByaXYtPnN1c3BlbmQuZW5hYmxlZDsKPj4+ICsKPj4+ICsJ
Lyogc2FmZSB0byBjYWxsIHB3bV9kaXNhYmxlKCkgZm9yIGFscmVhZHkgZGlzYWJsZWQgcHdtICov
Cj4+PiArCXB3bV9kaXNhYmxlKCZwcml2LT5jaGlwLnB3bXNbMF0pOwo+Pj4gKwo+Pj4gKwlyZXR1
cm4gcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoZGV2KTsKPj4KPj4gSU1ITyBhIFBXTSBz
aG91bGQgbm90IHN0b3AgaWYgdGhlIFBXTSB1c2VyIGRpZG4ndCBjYWxsIHB3bV9kaXNhYmxlKCkg
KG9yCj4+IHB3bV9hcHBseV9zdGF0ZSgpIHdpdGggLmVuYWJsZWQgPSBmYWxzZSkuCj4+Cj4+IEkg
ZG9uJ3QgdW5kZXJzdGFuZCBhbGwgdGhlIFBNIGRldGFpbHMsIGJ1dCBJIHRoaW5rIHRoZXJlIGlz
IG5vIGRlZmluZWQKPj4gb3JkZXIgaW4gd2hpY2ggZGV2aWNlcyBhcmUgc2lnbmFsbGVkIHRvIHN1
c3BlbmQuIElmIHNvIHRoZSBQV00gbWlnaHQgYmUKPj4gc3RvcHBlZCBiZWZvcmUgaXRzIGNvbnN1
bWVyLiBUaGVuIHRoZSBQV00gY2hhbmdlcyBzdGF0ZSB3aXRob3V0IHRoZQo+PiBjb25zdW1lciBi
ZWluZyBhd2FyZSBvZiB0aGF0Lgo+Pgo+PiBJIHVuZGVyc3RhbmQgVGhpZXJyeSdzIHBvc2l0aW9u
IGluIHRoZSBsaW5rIHlvdSBwcm92aWRlZCBpbiB0aGUgY29tbWl0Cj4+IGxvZyBjb25zaXN0YW50
IHdpdGggbXkgcG9zaXRpb24gaGVyZS4KPiAKPiBBZ3JlZWQsIHdlIHNob3VsZCBsZXQgdXNlcnMg
b2YgdGhlIFBXTSB0YWtlIGNhcmUgb2YgcmVzdW1pbmcgdGhlIFBXTSBpbgo+IHRoZSBzdGF0ZSBh
bmQgYXQgdGhlIHBvaW50IGluIHRpbWUgdGhhdCB0aGV5IHJlcXVpcmUgc28uIFBXTSB1c2VycyB3
aWxsCj4gYWxzbyBsaWtlbHkgZG8gYSBwd21fZGlzYWJsZSgpIGR1cmluZyB0aGVpciBzdXNwZW5k
IGltcGxlbWVudGF0aW9uLCBzbwo+IGRvaW5nIHRoaXMgYWdhaW4gaW4gYSBQV00gLT5zdXNwZW5k
KCkgaXMgbm90IG5lY2Vzc2FyeSwgZXZlbiBpZiBwZXJoYXBzCj4gaGFybWxlc3MuCj4gCj4gU28g
dGhpcyBsZWF2ZXMgb25seSB0aGUgcGluY3RybF9wbV9zZWxlY3Rfc2xlZXBfc3RhdGUoKSBjYWxs
LiBUaGF0IHNlZW1zCj4gZmluZSwgYnV0IEknbSBub3Qgc3VyZSB0aGF0IHRoYXQncyBjdXJyZW50
bHkgZ3VhcmFudGVlZCB0byB3b3JrLiBJIHRoaW5rCj4gd2UgbWF5IG5lZWQgdG8gaW1wbGVtZW50
IGRldmljZSBsaW5rIHN1cHBvcnQgaW4gdGhlIFBXTSBmcmFtZXdvcmsgdG8KPiBndWFyYW50ZWUg
dGhlIHByb3BlciBzdXNwZW5kL3Jlc3VtZSBzZXF1ZW5jaW5nLiBPdGhlcndpc2UgeW91IG1heSBl
bmQgdXAKPiBpbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGUgUFdNIGlzIGFjdHVhbGx5IHN1c3BlbmRl
ZCBiZWZvcmUgdGhlIHVzZXIgYW5kCj4gZ2xpdGNoIHRoZSBwaW5zIGJlZm9yZSB0aGUgdXNlciBo
YXMgYSBjaGFuY2UgdG8gZGlzYWJsZSB0aGUgUFdNLgoKSGkgVXdlLCBUaGllcnJ5LAoKSSBhZ3Jl
ZSB3aXRoIGJvdGggb2YgeW91IG9uIHRoZSBhbmFseXNpcy4KCj4gCj4gSSB0aGluayBpdCdkIGJl
IGZpbmUgdG8gbWVyZ2UgdGhlIGRyaXZlciBjaGFuZ2UgaGVyZSBmaXJzdCBiZWZvcmUgd2UgYWRk
Cj4gZGV2aWNlIGxpbmsgc3VwcG9ydCBpZiB0aGlzIHdvcmtzIGZvciB5b3UuIEp1c3QgbWVudGlv
bmluZyB0aGUgaXNzdWUKPiBoZXJlIGluIGNhc2UgeW91IGV2ZXIgcnVuIGludG8gaXQuCgpJZiB5
b3UgYWdyZWUgd2l0aCB0aGUgY3VycmVudCBhcHByb2FjaCwgSSBjYW4gc2VuZCBhIFYyIHdpdGgg
VG9tYXN6J3MKc3VnZ2VzdGlvbiB0byByZW1vdmUgdGhlIGlmZGVmcyBhbmQgdXNlIF9fbWF5YmVf
dW51c2VkIGluc3RlYWQuCgpUaGFua3MgZm9yIHJldmlld2luZywKQmVzdCBSZWdhcmRzLApGYWJy
aWNlCj4gCj4gVGhpZXJyeQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
