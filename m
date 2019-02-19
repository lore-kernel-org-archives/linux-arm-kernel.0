Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984FC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169BB2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q3EhenuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169BB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uvW0A9BXGESxO4wf4HViergy8sp2wlQGT01rItZ9IdY=; b=Q3EhenuCvCbsv6
	GMSwmYkUqjGEqQnIwE6cf+nDt2B1HtT+lxY3Fe9E9G+9Qq9pExN/VrFPOacvF8apCj9eMCW8Vq73b
	B1a86dm1n7RIO3RD2lGlgM4eLUgakVJxUy4mEGAzudE9IbHPm4ER7WtfdHDKZXNJoCqIhmw4vpKjw
	ATm4FzdYLHHzpQd9+4JADcQOCzXb+IUbuZxx8bCxMQavwBrRJ5Rs/X3H1its+h2fa8slH7nDOgdkk
	Qhjua1wOFKRJhEOjZKBHOhCZSE/ImhLdlZsvuv+nGLdx7DM7vJpYJwfoYI0mmKSLbq8Wox6q+hYNH
	jsDmnWpIX0OFLXIozGSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw26l-0007Xs-Ad; Tue, 19 Feb 2019 09:54:35 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw26h-0007Ww-BT
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:54:33 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1J9pPpe027674; Tue, 19 Feb 2019 10:54:22 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qr6x5jjsk-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 19 Feb 2019 10:54:22 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2EAA34;
 Tue, 19 Feb 2019 09:54:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AF822750;
 Tue, 19 Feb 2019 09:54:21 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 10:54:20 +0100
Subject: Re: [PATCH v4 3/3] pwm: core: add consumer device link
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
 <20190218172223.lw3e5tn5hzsow6tg@pengutronix.de>
 <53bc3d80-8732-46be-caef-015998c9ad0e@st.com>
 <20190219085516.dz5ux37kdszqkisy@pengutronix.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b4f42c35-df0e-8b61-6132-39a453a3b11c@st.com>
Date: Tue, 19 Feb 2019 10:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219085516.dz5ux37kdszqkisy@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-19_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_015431_698323_909A9A6C 
X-CRM114-Status: GOOD (  19.35  )
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

T24gMi8xOS8xOSA5OjU1IEFNLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPiBPbiBUdWUsIEZl
YiAxOSwgMjAxOSBhdCAwOTo0NjozMkFNICswMTAwLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6Cj4+
IE9uIDIvMTgvMTkgNjoyMiBQTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4+PiBIZWxsbywK
Pj4+Cj4+PiBPbiBUaHUsIEZlYiAxNCwgMjAxOSBhdCAxMToyNTo1MUFNICswMTAwLCBGYWJyaWNl
IEdhc25pZXIgd3JvdGU6Cj4+Pj4gQWRkIGEgZGV2aWNlIGxpbmsgYmV0d2VlbiB0aGUgUFdNIGNv
bnN1bWVyIGFuZCB0aGUgUFdNIHByb3ZpZGVyLiBUaGlzCj4+Pj4gZW5mb3JjZXMgdGhlIFBXTSB1
c2VyIHRvIGdldCBzdXNwZW5kZWQgYmVmb3JlIHRoZSBQV00gcHJvdmlkZXIuIEl0Cj4+Pj4gYWxs
b3dzIHByb3BlciBzeW5jaHJvbml6YXRpb24gb2Ygc3VzcGVuZC9yZXN1bWUgc2VxdWVuY2VzOiB0
aGUgUFdNIHVzZXIKPj4+PiBpcyByZXNwb25zaWJsZSBmb3IgcHJvcGVybHkgc3RvcHBpbmcgUFdN
LCBiZWZvcmUgdGhlIHByb3ZpZGVyIGdldHMKPj4+PiBzdXNwZW5kZWQ6IHNlZSBbMV0uIEFkZCB0
aGUgZGV2aWNlIGxpbmsgaW46Cj4+Pj4gLSBvZl9wd21fZ2V0KCkKPj4+PiAtIHB3bV9nZXQoKQo+
Pj4+IC0gZGV2bV8qcHdtX2dldCgpIHZhcmlhbnRzCj4+Pj4gYXMgaXQgcmVxdWlyZXMgYSByZWZl
cmVuY2UgdG8gdGhlIGRldmljZSBmb3IgdGhlIFBXTSBjb25zdW1lci4KPj4+Pgo+Pj4+IFsxXSBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8yLzUvNzcwCj4+Pj4KPj4+PiBTdWdnZXN0ZWQtYnk6
IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+Cj4+Pj4gU2lnbmVkLW9m
Zi1ieTogRmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAc3QuY29tPgo+Pj4+IC0tLQo+
Pj4+IENoYW5nZXMgaW4gdjQ6Cj4+Pj4gLSByZXdvcmsgZXJyb3IgaGFuZGxpbmcgZm9sbG93aW5n
IFRoaWVycnkncyBjb21tZW50cwo+Pj4+IC0gdHVybi9zcGxpdCBwcl9kZWJ1ZygpIGludG8gZGV2
X2VycigpL3ByX3dhcm4oKS4KPj4+Pgo+Pj4+IENoYW5nZXMgaW4gdjM6Cj4+Pj4gLSBhZGQgc3Ry
dWN0IGRldmljZSB0byBvZl9nZXRfcHdtKCkgYXJndW1lbnRzIHRvIGhhbmRsZSBkZXZpY2UgbGlu
ayBmcm9tCj4+Pj4gICB0aGVyZSBhcyBkaXNjdXNzZWQgd2l0aCBVd2UuCj4+Pj4gLS0tCj4+Pj4g
IGRyaXZlcnMvcHdtL2NvcmUuYyAgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLQo+Pj4+ICBpbmNsdWRlL2xpbnV4L3B3bS5oIHwgIDYgKysrKy0t
Cj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkK
Pj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9jb3JlLmMgYi9kcml2ZXJzL3B3bS9j
b3JlLmMKPj4+PiBpbmRleCAxNTgxZjZhLi42NGUxMGE2IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvcHdtL2NvcmUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvcHdtL2NvcmUuYwo+Pj4+IEBAIC02MzYs
OCArNjM2LDM1IEBAIHN0YXRpYyBzdHJ1Y3QgcHdtX2NoaXAgKm9mX25vZGVfdG9fcHdtY2hpcChz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+Pj4+ICAJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZF
Uik7Cj4+Pj4gIH0KPj4+PiAgCj4+Pj4gK3N0YXRpYyBzdHJ1Y3QgZGV2aWNlX2xpbmsgKnB3bV9k
ZXZpY2VfbGlua19hZGQoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4+ICsJCQkJCSAgICAgICBzdHJ1
Y3QgcHdtX2RldmljZSAqcHdtKQo+Pj4+ICt7Cj4+Pj4gKwlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmRs
Owo+Pj4+ICsKPj4+PiArCWlmICghZGV2KSB7Cj4+Pj4gKwkJLyoKPj4+PiArCQkgKiBObyBkZXZp
Y2UgZm9yIHRoZSBQV00gY29uc3VtZXIgaGFzIGJlZW4gcHJvdmlkZWQuIEl0IG1heQo+Pj4+ICsJ
CSAqIGltcGFjdCB0aGUgUE0gc2VxdWVuY2Ugb3JkZXJpbmc6IHRoZSBQV00gc3VwcGxpZXIgbWF5
IGdldAo+Pj4+ICsJCSAqIHN1c3BlbmRlZCBiZWZvcmUgdGhlIGNvbnN1bWVyLgo+Pj4+ICsJCSAq
Lwo+Pj4+ICsJCXByX3dhcm4oIm5vIGNvbnN1bWVyIGRldiwgY2FuJ3QgY3JlYXRlIGRldmljZSBs
aW5rIHRvICVzXG4iLAo+Pj4+ICsJCQlkZXZfbmFtZShwd20tPmNoaXAtPmRldikpOwo+Pj4KPj4+
IE1heWJlIHVzZSBkZXZfd2Fybihwd20tPmNoaXAtPmRldiwgLi4uKSA/Cj4+Cj4+IEhpIFV3ZSwK
Pj4KPj4gSSdtIHdvbmRlcmluZyBhIGJpdCBhYm91dCB0aGlzOiBJbiB0aGlzIGNhc2UsIHRoZSBj
YWxsZXIgdGhhdCBkb2Vzbid0Cj4+IHByb3ZpZGUgYSBzdHJ1Y3QgZGV2aWNlICosIFBXTSBwcm92
aWRlciBpc24ndCByZXNwb25zaWJsZSBmb3IgdGhhdC4gU28gSQo+PiBqdXN0IGhvcGUgdGhpcyB3
b3VsZG4ndCBiZSBtaXNzLWxlYWRpbmcgPwo+IAo+IElNSE8gaXQncyBtb3JlIHRoZSB3b3JkaW5n
IHRoYXQgbWlnaHQgbWFrZSB0aGUgbWVzc2FnZSBtaXNsZWFkaW5nLiBJZgo+IHlvdSB1c2UKPiAK
PiAJZGV2X3dhcm4ocHdtLT5jaGlwLT5kZXYsICJObyBjb25zdW1lciBkZXZpY2Ugc3BlY2lmaWVk
IHRvIGNyZWF0ZSBhIGRldmljZSBsaW5rIHRvXG4iKTsKPiAKPiB0aGF0J3MgY29tcGxldGVseSBm
aW5lIGluIG15IGV5ZXMuCgpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBJJ2xsIHVwZGF0ZSB0
aGlzIGFzIHdlbGwgaW4gdjUuCgpCZXN0IHJlZ2FyZHMsCkZhYnJpY2UKPiAgCj4gQmVzdCByZWdh
cmRzCj4gVXdlCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
