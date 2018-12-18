Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58762C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:26:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FA2217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u+f3TS6a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gb1U9vXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FA2217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7TwmfgtmbjHjeNdhU6WB8XmCjwUK/zZjXYjrVJukaWg=; b=u+f3TS6ap8xASc
	wlQ3iHy6mIG7UvveNffTHiszWSRSKmbnKwhJhyBeuJK4tkrgObU5ky0A2ctVExTEgpT9Tv5NVX2v1
	WxPELjEOhhma43J+WJNS7DaVWEdVQeBuFxZ3O1cZdLdD0T6HSt691E+ASLmNXjlJjca91qesyOWV1
	gfYhOlHriOIhcMoOMROQIRtr7RUbBEziNuN5QksE8hO30vnR3rT/yJvrj1rxQlsEkBszn/XqWCFca
	bEmWtDAF51nqAF2lDC9btlZSX+4ofngg4F7dFS6OLTkj5YeE581Fqg60Lc6ZqLZ3tIQRp33g+6+GA
	uaFjgTuxqiKwy7c7rPpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCaK-0002s9-QP; Tue, 18 Dec 2018 10:26:44 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCaH-0002rU-Tg
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:26:43 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBIAQL0u037793;
 Tue, 18 Dec 2018 04:26:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545128781;
 bh=3OlllmI6kJsbU1z+oQJEJsMqFVGMIiN3FYCuM4n0N9g=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Gb1U9vXpUIr2x/+2GiB7FcaObD22JdXku9EXzdrnM8Au4HZ5/gSeUxIeMtwu89SI/
 PRVlQbrTM81TZwhMAVzVyZVdhMOUadGfW4eG0w5W9JnrtMYAK75G/Mk0rtvdNvxYWL
 TCc0vWaCf8HQdjEj1hUxT6vJqMRi/6tNYwW2PT+k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBIAQLKV113811
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Dec 2018 04:26:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 18
 Dec 2018 04:26:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 18 Dec 2018 04:26:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBIAQJ9U030158;
 Tue, 18 Dec 2018 04:26:20 -0600
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if booted
 with latest u-boot
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213155054.GK9507@n2100.armlinux.org.uk>
 <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
 <20181214131616.GM9507@n2100.armlinux.org.uk>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <409dc60a-8b92-02c0-8c53-fbeaea8a1d17@ti.com>
Date: Tue, 18 Dec 2018 12:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214131616.GM9507@n2100.armlinux.org.uk>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_022642_039909_FA0B18DA 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxNC8xMi8yMDE4IDE1LjE2LCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6Cj4g
T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMDM6MDg6MDlQTSArMDIwMCwgUGV0ZXIgVWpmYWx1c2kg
d3JvdGU6Cj4+IEkgY2VydGFpbmx5IGhhdmUgdGhlIHZlcnNpb24gb2YgdS1ib290IHdoaWNoIGNh
biBkbyBvbmx5IG9uZSB0ZnRwIGxvYWQKPj4gKG9yIGRoY3AgcmVxdWVzdCkuCj4gCj4gVGhhdCds
bCBiZSBiZWNhdXNlIG9mIHRoZSBidWdneSBLUzg4NTEgZHJpdmVyLiAgVGhpcyBpcyB0aGUgcGF0
Y2ggSQo+IGhhdmUgb24gdG9wIG9mIG15IDIwMTQgdmVyc2lvbiBvZiBOaXNoYW50aCdzIHRyZWUu
CgpUaGFua3MhCgpDYW4geW91IHRlc3QgdGhlIHBhdGNoIHRvIHNlZSBpZiBpdCBpcyBub3QgYnJl
YWtpbmcgdGhpbmdzPwpJIGJlbGlldmUgdGhlIHBhdGNoIGlzIGNvcnJlY3QgYXMgd2UgY2xlYXJs
eSBtaXNzaW5nIHBpbm11eApjb25maWd1cmF0aW9uIGZyb20gdGhlIERUIGZvciBwaW5zLgoKPiAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQva3M4ODUxLmMgYi9kcml2ZXJzL25ldC9rczg4NTEu
Ywo+IGluZGV4IDY0NjdkZGU3ZWJmNi4uZjg4OGY0M2FkOTM3IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvbmV0L2tzODg1MS5jCj4gKysrIGIvZHJpdmVycy9uZXQva3M4ODUxLmMKPiBAQCAtMjcsNiAr
MjcsMjcgQEAKPiAgCj4gICNpbmNsdWRlICJrczg4NTEuaCIKPiAgI2RlZmluZSBLUzg4NTFfU05M
CQkxCj4gKyN1bmRlZiBERUJVRwo+ICsKPiArc3RhdGljIHZvaWQgZHVtcF9tZW0oY29uc3QgY2hh
ciAqc3RyLCBjb25zdCB2b2lkICpiYXNlLCB1bnNpZ25lZCBvcmlnLCB1bnNpZ25lZCBsZW4pCj4g
K3sKPiArI2lmZGVmIERFQlVHCj4gKwljb25zdCB1bnNpZ25lZCBjaGFyICpwID0gYmFzZTsKPiAr
CXVuc2lnbmVkIGksIGo7Cj4gKwo+ICsJcHJpbnRmKCIlczoiLCBzdHIpOwo+ICsJCj4gKwlmb3Ig
KGogPSAwOyBqIDwgbGVuOyBqICs9IDMyKSB7Cj4gKwkJcHJpbnRmKCJcbiUwNHg6Iiwgaik7Cj4g
KwkJZm9yIChpID0gajsgaSA8IGogKyAzMiAmJiBpIDwgbGVuOyBpKyspCj4gKwkJCXByaW50Zigi
JXMlcyUwMngiLAo+ICsJCQkJKGkgPT0gaiArIDE2KSA/ICIgIiA6ICIiLAo+ICsJCQkJaSA9PSBv
cmlnID8gInwiIDogIiAiLAo+ICsJCQkJcFtpXSk7Cj4gKwl9Cj4gKwlwcmludGYoIlxuIik7Cj4g
KyNlbmRpZgo+ICt9Cj4gIAo+ICAvKgo+ICAgKiBHRVRfS1M4ODUxU05MX1JXV09SRF9DTUQKPiBA
QCAtMzI0LDYgKzM0NSw3IEBAIHZvaWQgS1M4ODUxU05MX1JFQURfQlVGRkVSKHZvaWQgKnBIYXJk
d2FyZSwKPiAgCQlwZHcrKzsKPiAgCQkqcHVSZWFkTGVuID0gKHUxNikoKCpwZHcpID4+IDE2KTsK
PiAgCQkqcHBPdXQgPSBwSW4gKyA4Owo+ICtkdW1wX21lbSgiUlgiLCBwTW92ZSwgc3BpQnVyc3RM
ZW4gKyA4LCBzcGlCdXJzdExlbiArIDgpOwo+ICAJfQo+ICAKPiAgCWlmIChzcGlCdXJzdEZsYWcg
IT0gU1BJX1JFQURfQlVSU1RfQUxMKSB7Cj4gQEAgLTYyNiw2ICs2NDgsNyBAQCBzdGF0aWMgaW50
IGtzODg1MV9ldGhfcmVjdihzdHJ1Y3QgZXRoX2RldmljZSAqZGV2KQo+ICAJCQlwcmludGYoImZy
YW1lIGNvdW50ID0gJWRcbiIsIHJ4RnJhbWVDb3VudCk7Cj4gICNlbmRpZgo+ICAKPiArCQkJcEhh
cmR3YXJlLT5tX3VDdXJGcmFtZUluZGV4ID0gMDsKPiAgCQkJcEhhcmR3YXJlLT5tX3VGcmFtZXNS
ZW1haW5lZCA9IHJ4RnJhbWVDb3VudDsKPiAgCj4gIAkJCWlmIChyeEZyYW1lQ291bnQgPT0gMCkK
PiBAQCAtNjk3LDcgKzcyMCw3IEBAIHN0YXRpYyBpbnQga3M4ODUxX2V0aF9zZW5kKHN0cnVjdCBl
dGhfZGV2aWNlICpkZXYsCj4gIAl1aVBhY2tldExlbmd0aCA9IGxlbmd0aDsKPiAgCUdFVF9EQVRB
X0FMSUdOTUVOVChsZW5ndGgsICZ1aVBhY2tldExlbmd0aCk7Cj4gIAlIV19XUklURV9TVEFSVChw
SGFyZHdhcmUpOwo+IC0KPiArZHVtcF9tZW0oIlRYIiwgcGFja2V0LCBsZW5ndGgsIHVpUGFja2V0
TGVuZ3RoKTsKPiAgI2lmZGVmIEtTODg1MV9TTkwKPiAgCUtTODg1MVNOTF9EQVRBX1dSSVRFKCh1
OCAqKXBhY2tldCwgbGVuZ3RoLCB1aVBhY2tldExlbmd0aCwgJmZSZXR1cm4pOwo+ICAjZWxzZQo+
IEBAIC03MjIsMTIgKzc0NSwxOSBAQCBzdGF0aWMgaW50IGtzODg1MV9ldGhfc2VuZChzdHJ1Y3Qg
ZXRoX2RldmljZSAqZGV2LAo+ICAJcmV0dXJuIDE7Cj4gIH0KPiAgCj4gK3N0YXRpYyBpbnQga3M4
ODUxX2V0aF9pbml0MihzdHJ1Y3QgZXRoX2RldmljZSAqZGV2LCBiZF90ICpiZCkKPiArewo+ICsJ
cmV0dXJuIDA7Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQga3M4ODUxX2V0aF9pbml0KHN0cnVjdCBl
dGhfZGV2aWNlICpkZXYsIGJkX3QgKmJkKQo+ICB7Cj4gIAo+ICAJdTE2IHR4Q250bCwgcnhDbnRs
LCB3LCBpbnRNYXNrOwo+ICAJUEhBUkRXQVJFIHBIYXJkd2FyZSA9ICZnSGFyZHdhcmU7Cj4gIAo+
ICsJZGV2LT5pbml0ID0ga3M4ODUxX2V0aF9pbml0MjsKPiArCj4gIAlwSGFyZHdhcmUtPm1fdUN1
ckZyYW1lSW5kZXggPSAwOwo+ICAJcEhhcmR3YXJlLT5tX3VGcmFtZXNSZW1haW5lZCA9IDA7Cj4g
IAlwSGFyZHdhcmUtPm1fdUN1clJlY3ZGcmFtcyA9IE1BWF9SRUNWX0ZSQU1FUzsKPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9jb25maWdzL29tYXA0X3NkcDQ0MzAuaCBiL2luY2x1ZGUvY29uZmlncy9v
bWFwNF9zZHA0NDMwLmgKPiBpbmRleCAwZDljMTZlYTlmMDQuLmFlOTRkZDg1MmYzZCAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3Mvb21hcDRfc2RwNDQzMC5oCj4gKysrIGIvaW5jbHVkZS9j
b25maWdzL29tYXA0X3NkcDQ0MzAuaAo+IEBAIC0yMSw2ICsyMSw5IEBACj4gIAo+ICAjaW5jbHVk
ZSA8Y29uZmlncy9vbWFwNF9jb21tb24uaD4KPiAgCj4gKyN1bmRlZiBDT05GSUdfU1lTX1BST01Q
VAo+ICsjZGVmaW5lIENPTkZJR19TWVNfUFJPTVBUICAgICAgICAgICAgICJPTUFQNDRYWCBTRFAg
IyAiCj4gKwo+ICAjaWZuZGVmIENPTkZJR19TUExfQlVJTEQKPiAgLyogQmF0dGVyeSBDaGFyZ2Vy
ICovCj4gICNkZWZpbmUgQ09ORklHX0NNRF9CQVQJCQkxCj4gCj4gCgotIFDDqXRlcgoKVGV4YXMg
SW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2ku
ClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhl
bHNpbmtpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
