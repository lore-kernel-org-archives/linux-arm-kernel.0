Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93EEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC3E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ao8a4Rui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC3E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yFx4/r2nMZ+1Ho+bsHoKbA16eQAdU7zecGeLW5hpxsA=; b=ao8a4RuiywKrRz
	uBaDv1v2eIzGrIObmiK5P0dqtoU45NXsFYq91d1ErobThWTSRWurVfNyqWGa4wCxyI1TKXUugBOcI
	hq/pwTg/Cqk0B+j9JkQMEjoxP2Wbf4GGB/aFcGMoQRcghxCWPfC13I0uN1Wk63NcneeZmJA9nYNJv
	VUIdDcVln9oUxf3CRwnY2fQidmcatZEvGg0pBp1WnhkiQ/lU+wJIYXn5h2CPu1pUOO8NIOKFg3TCP
	U7LnTQooAgyN9ZpqYl6Ef8uTDO682nxXXeIh/jE2saMqoYFCmkdf8TBgby1W6edGL7iWnwcln2+y7
	o2iD/VTEchI/+jljflqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfue-0005CP-EM; Tue, 11 Dec 2018 11:09:16 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfua-0005Bo-Ty
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 11:09:14 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBB8wtR108969;
 Tue, 11 Dec 2018 05:08:58 -0600
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBB8wc9038500
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Dec 2018 05:08:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 05:08:58 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 05:08:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBB8ufa008912;
 Tue, 11 Dec 2018 05:08:56 -0600
Subject: Re: [PATCH] ARM: dts: Fix ranges for am335x epwmss
To: Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
References: <20181210221005.24386-1-tony@atomide.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b6f74fe2-6c85-6995-a30c-c0838a127f08@ti.com>
Date: Tue, 11 Dec 2018 13:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210221005.24386-1-tony@atomide.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_030913_049383_EA8E87D8 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: devicetree@vger.kernel.org,
 =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8xMi8yMDE4IDAuMTAsIFRvbnkgTGluZGdyZW4gd3JvdGU6Cj4gTG9va3MgbGlrZSBJ
IG1pc3NlZCB0aGUgcmFuZ2VzIGZvciBhbTMzNXggZXB3bXNzLiBMZXQncyBzZXQgaXQgdXAgdGhl
Cj4gc2FtZSB3YXkgYXMgZm9yIGFtNDM3eCBhbmQgZHJhNy4KPiAKPiBGaXhlczogODdmYzg5Y2Vk
M2E3ICgiQVJNOiBkdHM6IGFtMzM1eDogTW92ZSBsNCBjaGlsZCBkZXZpY2VzIHRvIHByb2JlCj4g
dGhlbSB3aXRoIHRpLXN5c2MiKQo+IENjOiBQZXRlciBVamZhbHVzaSA8cGV0ZXIudWpmYWx1c2lA
dGkuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+
CgpUZXN0ZWQtYnk6IFBldGVyIFVqZmFsdXNpIDxwZXRlci51amZhbHVzaUB0aS5jb20+Cgo+IC0t
LQo+ICBhcmNoL2FybS9ib290L2R0cy9hbTMzNXgtY20tdDMzNS5kdHMgfCAgMiArLQo+ICBhcmNo
L2FybS9ib290L2R0cy9hbTMzNXgtZXZtLmR0cyAgICAgfCAgMiArLQo+ICBhcmNoL2FybS9ib290
L2R0cy9hbTMzNXgtZXZtc2suZHRzICAgfCAgMiArLQo+ICBhcmNoL2FybS9ib290L2R0cy9hbTMz
NXgtc2hjLmR0cyAgICAgfCAgMiArLQo+ICBhcmNoL2FybS9ib290L2R0cy9hbTMzeHgtbDQuZHRz
aSAgICAgfCAzNiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gIDUgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1jbS10MzM1LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2Ft
MzM1eC1jbS10MzM1LmR0cwo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1jbS10MzM1
LmR0cwo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1jbS10MzM1LmR0cwo+IEBAIC0z
OTMsNyArMzkzLDcgQEAgc3RhdHVzID0gIm9rYXkiOwo+ICAmZXB3bXNzMCB7Cj4gIAlzdGF0dXMg
PSAib2theSI7Cj4gIAo+IC0JZWNhcDA6IGVjYXBANDgzMDAxMDAgewo+ICsJZWNhcDA6IGVjYXBA
MTAwIHsKPiAgCQlzdGF0dXMgPSAib2theSI7Cj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsKPiAgCQlwaW5jdHJsLTAgPSA8JmVjYXAwX3BpbnM+Owo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9hbTMzNXgtZXZtLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1ldm0u
ZHRzCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5kdHMKPiArKysgYi9hcmNo
L2FybS9ib290L2R0cy9hbTMzNXgtZXZtLmR0cwo+IEBAIC01MTksNyArNTE5LDcgQEAKPiAgJmVw
d21zczAgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+ICAKPiAtCWVjYXAwOiBlY2FwQDQ4MzAwMTAw
IHsKPiArCWVjYXAwOiBlY2FwQDEwMCB7Cj4gIAkJc3RhdHVzID0gIm9rYXkiOwo+ICAJCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gIAkJcGluY3RybC0wID0gPCZlY2FwMF9waW5zPjsKPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bXNrLmR0cyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2FtMzM1eC1ldm1zay5kdHMKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hbTMz
NXgtZXZtc2suZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bXNrLmR0cwo+
IEBAIC01NDAsNyArNTQwLDcgQEAKPiAgJmVwd21zczIgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+
ICAKPiAtCWVjYXAyOiBlY2FwQDQ4MzA0MTAwIHsKPiArCWVjYXAyOiBlY2FwQDEwMCB7Cj4gIAkJ
c3RhdHVzID0gIm9rYXkiOwo+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gIAkJcGlu
Y3RybC0wID0gPCZlY2FwMl9waW5zPjsKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
YW0zMzV4LXNoYy5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hbTMzNXgtc2hjLmR0cwo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1zaGMuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYW0zMzV4LXNoYy5kdHMKPiBAQCAtMTM4LDcgKzEzOCw3IEBACj4gICZlcHdtc3MxIHsKPiAg
CXN0YXR1cyA9ICJva2F5IjsKPiAgCj4gLQllaHJwd20xOiBwd21ANDgzMDIyMDAgewo+ICsJZWhy
cHdtMTogcHdtQDIwMCB7Cj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiAgCQlwaW5j
dHJsLTAgPSA8JmVocnB3bTFfcGlucz47Cj4gIAkJc3RhdHVzID0gIm9rYXkiOwo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9hbTMzeHgtbDQuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2FtMzN4eC1sNC5kdHNpCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYW0zM3h4LWw0LmR0c2kK
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hbTMzeHgtbDQuZHRzaQo+IEBAIC0xODk5LDE1ICsx
ODk5LDEzIEBACj4gIAkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiAgCQkJCSNzaXplLWNlbGxz
ID0gPDE+Owo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiAtCQkJCXJhbmdlcyA9IDwweDQ4
MzAwMTAwIDB4NDgzMDAxMDAgMHg4MCAgIC8qIEVDQVAgKi8KPiAtCQkJCQkgIDB4NDgzMDAxODAg
MHg0ODMwMDE4MCAweDgwICAgLyogRVFFUCAqLwo+IC0JCQkJCSAgMHg0ODMwMDIwMCAweDQ4MzAw
MjAwIDB4ODA+OyAvKiBFSFJQV00gKi8KPiArCQkJCXJhbmdlcyA9IDwwIDAgMHgxMDAwPjsKPiAg
Cj4gLQkJCQllY2FwMDogZWNhcEA0ODMwMDEwMCB7Cj4gKwkJCQllY2FwMDogZWNhcEAxMDAgewo+
ICAJCQkJCWNvbXBhdGlibGUgPSAidGksYW0zMzUyLWVjYXAiLAo+ICAJCQkJCQkgICAgICJ0aSxh
bTMzeHgtZWNhcCI7Cj4gIAkJCQkJI3B3bS1jZWxscyA9IDwzPjsKPiAtCQkJCQlyZWcgPSA8MHg0
ODMwMDEwMCAweDgwPjsKPiArCQkJCQlyZWcgPSA8MHgxMDAgMHg4MD47Cj4gIAkJCQkJY2xvY2tz
ID0gPCZsNGxzX2djbGs+Owo+ICAJCQkJCWNsb2NrLW5hbWVzID0gImZjayI7Cj4gIAkJCQkJaW50
ZXJydXB0cyA9IDwzMT47Cj4gQEAgLTE5MTUsMTEgKzE5MTMsMTEgQEAKPiAgCQkJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOwo+ICAJCQkJfTsKPiAgCj4gLQkJCQllaHJwd20wOiBwd21ANDgzMDAyMDAg
ewo+ICsJCQkJZWhycHdtMDogcHdtQDIwMCB7Cj4gIAkJCQkJY29tcGF0aWJsZSA9ICJ0aSxhbTMz
NTItZWhycHdtIiwKPiAgCQkJCQkJICAgICAidGksYW0zM3h4LWVocnB3bSI7Cj4gIAkJCQkJI3B3
bS1jZWxscyA9IDwzPjsKPiAtCQkJCQlyZWcgPSA8MHg0ODMwMDIwMCAweDgwPjsKPiArCQkJCQly
ZWcgPSA8MHgyMDAgMHg4MD47Cj4gIAkJCQkJY2xvY2tzID0gPCZlaHJwd20wX3RiY2xrPiwgPCZs
NGxzX2djbGs+Owo+ICAJCQkJCWNsb2NrLW5hbWVzID0gInRiY2xrIiwgImZjayI7Cj4gIAkJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsKPiBAQCAtMTk1NCwxNSArMTk1MiwxMyBAQAo+ICAJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47Cj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsKPiAgCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7Cj4gLQkJCQlyYW5nZXMgPSA8MHg0ODMwMjEwMCAweDQ4MzAyMTAwIDB4
ODAgICAvKiBFQ0FQICovCj4gLQkJCQkJICAweDQ4MzAyMTgwIDB4NDgzMDIxODAgMHg4MCAgIC8q
IEVRRVAgKi8KPiAtCQkJCQkgIDB4NDgzMDIyMDAgMHg0ODMwMjIwMCAweDgwPjsgLyogRUhSUFdN
ICovCj4gKwkJCQlyYW5nZXMgPSA8MCAwIDB4MTAwMD47Cj4gIAo+IC0JCQkJZWNhcDE6IGVjYXBA
NDgzMDIxMDAgewo+ICsJCQkJZWNhcDE6IGVjYXBAMTAwIHsKPiAgCQkJCQljb21wYXRpYmxlID0g
InRpLGFtMzM1Mi1lY2FwIiwKPiAgCQkJCQkJICAgICAidGksYW0zM3h4LWVjYXAiOwo+ICAJCQkJ
CSNwd20tY2VsbHMgPSA8Mz47Cj4gLQkJCQkJcmVnID0gPDB4NDgzMDIxMDAgMHg4MD47Cj4gKwkJ
CQkJcmVnID0gPDB4MTAwIDB4ODA+Owo+ICAJCQkJCWNsb2NrcyA9IDwmbDRsc19nY2xrPjsKPiAg
CQkJCQljbG9jay1uYW1lcyA9ICJmY2siOwo+ICAJCQkJCWludGVycnVwdHMgPSA8NDc+Owo+IEBA
IC0xOTcwLDExICsxOTY2LDExIEBACj4gIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiAgCQkJ
CX07Cj4gIAo+IC0JCQkJZWhycHdtMTogcHdtQDQ4MzAyMjAwIHsKPiArCQkJCWVocnB3bTE6IHB3
bUAyMDAgewo+ICAJCQkJCWNvbXBhdGlibGUgPSAidGksYW0zMzUyLWVocnB3bSIsCj4gIAkJCQkJ
CSAgICAgInRpLGFtMzN4eC1laHJwd20iOwo+ICAJCQkJCSNwd20tY2VsbHMgPSA8Mz47Cj4gLQkJ
CQkJcmVnID0gPDB4NDgzMDIyMDAgMHg4MD47Cj4gKwkJCQkJcmVnID0gPDB4MjAwIDB4ODA+Owo+
ICAJCQkJCWNsb2NrcyA9IDwmZWhycHdtMV90YmNsaz4sIDwmbDRsc19nY2xrPjsKPiAgCQkJCQlj
bG9jay1uYW1lcyA9ICJ0YmNsayIsICJmY2siOwo+ICAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
Cj4gQEAgLTIwMDksMTUgKzIwMDUsMTMgQEAKPiAgCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+
ICAJCQkJI3NpemUtY2VsbHMgPSA8MT47Cj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+IC0J
CQkJcmFuZ2VzID0gPDB4NDgzMDQxMDAgMHg0ODMwNDEwMCAweDgwICAgLyogRUNBUCAqLwo+IC0J
CQkJCSAgMHg0ODMwNDE4MCAweDQ4MzA0MTgwIDB4ODAgICAvKiBFUUVQICovCj4gLQkJCQkJICAw
eDQ4MzA0MjAwIDB4NDgzMDQyMDAgMHg4MD47IC8qIEVIUlBXTSAqLwo+ICsJCQkJcmFuZ2VzID0g
PDAgMCAweDEwMDA+Owo+ICAKPiAtCQkJCWVjYXAyOiBlY2FwQDQ4MzA0MTAwIHsKPiArCQkJCWVj
YXAyOiBlY2FwQDEwMCB7Cj4gIAkJCQkJY29tcGF0aWJsZSA9ICJ0aSxhbTMzNTItZWNhcCIsCj4g
IAkJCQkJCSAgICAgInRpLGFtMzN4eC1lY2FwIjsKPiAgCQkJCQkjcHdtLWNlbGxzID0gPDM+Owo+
IC0JCQkJCXJlZyA9IDwweDQ4MzA0MTAwIDB4ODA+Owo+ICsJCQkJCXJlZyA9IDwweDEwMCAweDgw
PjsKPiAgCQkJCQljbG9ja3MgPSA8Jmw0bHNfZ2Nsaz47Cj4gIAkJCQkJY2xvY2stbmFtZXMgPSAi
ZmNrIjsKPiAgCQkJCQlpbnRlcnJ1cHRzID0gPDYxPjsKPiBAQCAtMjAyNSwxMSArMjAxOSwxMSBA
QAo+ICAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gIAkJCQl9Owo+ICAKPiAtCQkJCWVocnB3
bTI6IHB3bUA0ODMwNDIwMCB7Cj4gKwkJCQllaHJwd20yOiBwd21AMjAwIHsKPiAgCQkJCQljb21w
YXRpYmxlID0gInRpLGFtMzM1Mi1laHJwd20iLAo+ICAJCQkJCQkgICAgICJ0aSxhbTMzeHgtZWhy
cHdtIjsKPiAgCQkJCQkjcHdtLWNlbGxzID0gPDM+Owo+IC0JCQkJCXJlZyA9IDwweDQ4MzA0MjAw
IDB4ODA+Owo+ICsJCQkJCXJlZyA9IDwweDIwMCAweDgwPjsKPiAgCQkJCQljbG9ja3MgPSA8JmVo
cnB3bTJfdGJjbGs+LCA8Jmw0bHNfZ2Nsaz47Cj4gIAkJCQkJY2xvY2stbmFtZXMgPSAidGJjbGsi
LCAiZmNrIjsKPiAgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+IAoKLSBQw6l0ZXIKClRleGFz
IEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtp
LgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBI
ZWxzaW5raQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
