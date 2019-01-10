Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA579206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e04W5h6F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+y9FrIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA579206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ARtP5tbDCVOlSbX9ACzgdAmOrPcAts/Mp7ayNIikNQ=; b=e04W5h6FQ8BgGo
	GFlg4cQuM7EhVJYYyZYL1ESRmjfKQ8lTrGf88tKw2jC8+SOurzrl/3yBQW6rHjtI82VmwzoFour3W
	CJ8YosXOultOgQ2xSgQDMuIo+KyZfqMyMFj19JKQMQ/gaBZEhcUtcespUOn19iuvfrE6xMcOOi1Tb
	Sd+S2VpehwR2rRuw3X13s7XgSzIuK7FEdprlbN3ZvYg+BRBj62rabmGXFT3oCiiHvyolhcplz3kFS
	kmScXC+66bC2Zw0ZhpsM22VW5fttyZ4kkSI8mWUkajl1lcjXD90boZg2bi3jKkPmEXRQ0GuxaTw8e
	BRT6Ynx1YiuexE0S0y9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVJf-0007Np-I8; Thu, 10 Jan 2019 08:03:51 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVJa-0007JS-2u
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 08:03:48 +0000
Received: by mail-it1-x144.google.com with SMTP id m8so14793308itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 00:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D1GLZJ7izl6n7wousL+JuQK/SWu+qMmRURLM0AUj8aA=;
 b=G+y9FrIpld9R3OnBXxn3iPO98OsU3GT+vhXjY5k716N8Jc3rE+mPcQ3AfSJl94w9cZ
 xxFigV54SUbFJYBTz12egg/6TBq2meysXnm6sm7mAiw8+AdRtizI+v07PPbjp2FnpP05
 8qoljIzbgy49fW5Nb2gCo3bkCoFr7M/pADsv1xurDvni7R7R1qjadXoSKREfbtlfztcs
 Olgh74tjw7m3/ogT2otkuHfaFTxJfKJhP3NOQweoXQbf769AcKHaOaTB9Qx41kSvfzMR
 akkh78RJeufC3qfPSNwS7WGxEvaI5m/CIdasK/fH4/fMCLf1BtE8+/YxImTm9zXLVU62
 RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D1GLZJ7izl6n7wousL+JuQK/SWu+qMmRURLM0AUj8aA=;
 b=sL0Jew/FKDiJNR3jhzTEcy4tf/hphbvUb8mCKRts5lObDQXIeyjuCY8rRMBQn+N40v
 W/HS7Bnk3r6SAXPGNf5z8Qx8VsWcg4S/NrdMOsOnrNPr8sc+1acxJSV9qolcAX7QbxBC
 2p3O3ABlUMwFKcS15Yix436TgMxabx8gJh8yrZA5LEgYUV9VhvyleOvtUHYM8BRRfIQq
 E5+qYj1hd63iuBMIi+Z/1WrmdFWKfzQd4yQ+vcrsFCBJpUrIb7xahMuqqgrx8CmS0yxs
 QLGfhUO5PnxB9pluE6GfND5bNA3eX8NhBU0Hmm/yeC+E1meILFIcctAmJNbu67FravPM
 9aeg==
X-Gm-Message-State: AJcUukeH5ASRsu8+DOEdQ2UvrLzpzR6WsAl80X0FGIC0GBSm4Ra3jHsw
 tW6PAi6/LZ30OLUR1LRmXOIP33f7yVF8iYRe/rM=
X-Google-Smtp-Source: ALg8bN7yX4GRuF4bu+joz4mWwSnF+YRtqun4NIUT1+jpOmUrspGUTUe6oEZ1eb8a8nXgluEpTKmiObwd3lgYTPbKxwA=
X-Received: by 2002:a02:89dd:: with SMTP id e29mr6665653jak.21.1547107425038; 
 Thu, 10 Jan 2019 00:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
 <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
In-Reply-To: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date: Thu, 10 Jan 2019 09:03:34 +0100
Message-ID: <CAKpie0RE=F04JB+_G2K4P4d-5OLB8mvK8P0Q-+DKjwxj7aeA_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_000346_246226_F52BB2CC 
X-CRM114-Status: GOOD (  21.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 "moderated list:SAMSUNG SOC CLOCK DRIVERS"
 <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
 rjw@rjwysocki.net, linux@armlinux.org.uk,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Y3p3LiwgMTAgc3R5IDIwMTkgbyAwODowMSBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnPiBuYXBpc2HFgihhKToKPgo+IE9uIDA4LTAxLTE5LCAyMTowNSwgUGF3ZcWCIENobWll
bCB3cm90ZToKPiA+IFRoZXJlIGlzIHBvc3NpYmlsaXR5LCB0aGF0IHdoZW4gcHJvYmluZyBkcml2
ZXIsIHJlZ3VsYXRvcnMgYXJlIG5vdCB5ZXQKPiA+IGluaXRpYWxpemVkLiBJbiB0aGlzIGNhc2Ug
d2Ugc2hvdWxkIHJldHVybiBFUFJPQkVfREVGRVIgYW5kIHdhaXQgdGlsbAo+ID4gdGhleSdyZSBp
bml0aWFsaXplZCwgc2luY2UgdGhleSdyZSByZXF1aXJlZCBjdXJyZW50bHkgZm9yIGNwdWZyZXEg
ZHJpdmVyCj4gPiB0byB3b3JrLiBBbHNvIG1vdmUgcmVndWxhdG9yIGluaXRpYWxpemF0aW9uIGNv
ZGUgYXQgYmVnaW5uaW5nIG9mIHByb2JlLAo+ID4gc28gd2UgY2FuIGRlZmVyIGFzIGZhc3QgYXMg
cG9zaWJibGUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlr
b2xhai5jaG1pZWxAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9jcHVmcmVxL3M1cHYy
MTAtY3B1ZnJlcS5jIHwgMzMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIGIvZHJpdmVycy9j
cHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gPiBpbmRleCBmNTE2OTdmMWUwYjMuLjJkMGU0ZGM3
ZWRlNyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYwo+
ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gPiBAQCAtNTk0LDYg
KzU5NCwyNiBAQCBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQo+ID4gICAgICAgICogdGhpcyB3aG9sZSBkcml2ZXIgYXMgc29vbiBh
cyBTNVBWMjEwIGdldHMgbWlncmF0ZWQgdG8gdXNlCj4gPiAgICAgICAgKiBjcHVmcmVxLWR0IGRy
aXZlci4KPiA+ICAgICAgICAqLwo+ID4gKyAgICAgYXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9n
ZXQoTlVMTCwgInZkZGFybSIpOwo+ID4gKyAgICAgaWYgKFBUUl9FUlIoYXJtX3JlZ3VsYXRvcikg
PT0gLUVQUk9CRV9ERUZFUikgewo+ID4gKyAgICAgICAgICAgICBwcl9kYmcoInZkZGFybSByZWd1
bGF0b3Igbm90IHJlYWR5LCBkZWZlclxuIik7Cj4gPiArICAgICAgICAgICAgIHJldHVybiAtRVBS
T0JFX0RFRkVSOwo+ID4gKyAgICAgfSBlbHNlIGlmIChJU19FUlIoYXJtX3JlZ3VsYXRvcikpIHsK
PiA+ICsgICAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRvciB2ZGRhcm1c
biIpOwo+ID4gKyAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihhcm1fcmVndWxhdG9yKTsKPiA+
ICsgICAgIH0KPgo+IFRoZSBvbmx5IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvIGNhc2VzIGlz
IHByX2RiZyB2cyBwcl9lcnIsIGl0cwo+IHVnbHkgdGhhdCB3ZSBoYXZlIHRvIGFkZCBzcGVjaWFs
IGNvZGUgZm9yIHRoYXQgOigKPgo+IE1heWJlIHdyaXRlIGl0IGFzOgo+Cj4gICAgICAgICBpZiAo
SVNfRVJSKGFybV9yZWd1bGF0b3IpKSB7Cj4gICAgICAgICAgICAgICAgIGlmIChQVFJfRVJSKGFy
bV9yZWd1bGF0b3IpID09IC1FUFJPQkVfREVGRVIpCj4gICAgICAgICAgICAgICAgICAgICAgICAg
cHJfZGJnLi4uCj4gICAgICAgICAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBwcl9lcnIKPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXJtX3JlZ3VsYXRvcik7
Cj4gICAgICAgICB9Cj4KPiA+ICsKPiA+ICsgICAgIGludF9yZWd1bGF0b3IgPSByZWd1bGF0b3Jf
Z2V0KE5VTEwsICJ2ZGRpbnQiKTsKPiA+ICsgICAgIGlmIChQVFJfRVJSKGludF9yZWd1bGF0b3Ig
PT0gLUVQUk9CRV9ERUZFUikgewo+Cj4gRG9lcyB0aGlzIGV2ZW4gY29tcGlsZSA/Ckxvb2tzIGxp
a2UgaSBicm9rZSBpdCBhZnRlciB0ZXN0aW5nICh3aGVyZSBpdCB3YXMgd29ya2luZyBmaW5lIC0g
d2FzCmFibGUgdG8gY2hhbmdlIGZyZXEgYW5kIGdvdiksCmFuZCBkaWRuJ3QgY2F0Y2ggdGhpcyBi
ZWZvcmUgc2VuZGluZyBwYXRjaCBmb3IgcmV2aWV3IDovLgpTb3JyeSwgdGhpcyAoYW5kIGZpcnN0
IGlzc3VlKSB3aWxsIGJlIGZpeGVkIGluIHYyLgoKVGhhbmtzIGZvciByZXZpZXcKPgo+ID4gKyAg
ICAgICAgICAgICByZWd1bGF0b3JfcHV0KGFybV9yZWd1bGF0b3IpOwo+ID4gKyAgICAgICAgICAg
ICBwcl9kYmcoInZkZGludCByZWd1bGF0b3Igbm90IHJlYWR5LCBkZWZlclxuIik7Cj4gPiArICAg
ICAgICAgICAgIHJldHVybiAtRVBST0JFX0RFRkVSOwo+ID4gKyAgICAgfSBlbHNlIGlmIChJU19F
UlIoaW50X3JlZ3VsYXRvcikpIHsKPiA+ICsgICAgICAgICAgICAgcmVndWxhdG9yX3B1dChhcm1f
cmVndWxhdG9yKTsKPiA+ICsgICAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3Vs
YXRvciB2ZGRpbnRcbiIpOwo+ID4gKyAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihpbnRfcmVn
dWxhdG9yKTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICAgICAgIG5wID0gb2ZfZmluZF9jb21wYXRp
YmxlX25vZGUoTlVMTCwgTlVMTCwgInNhbXN1bmcsczVwdjIxMC1jbG9jayIpOwo+ID4gICAgICAg
aWYgKCFucCkgewo+ID4gICAgICAgICAgICAgICBwcl9lcnIoIiVzOiBmYWlsZWQgdG8gZmluZCBj
bG9jayBjb250cm9sbGVyIERUIG5vZGVcbiIsCj4gPiBAQCAtNjMzLDE5ICs2NTMsNiBAQCBzdGF0
aWMgaW50IHM1cHYyMTBfY3B1ZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQo+ID4gICAgICAgICAgICAgICB9Cj4gPiAgICAgICB9Cj4gPgo+ID4gLSAgICAgYXJtX3JlZ3Vs
YXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGFybSIpOwo+ID4gLSAgICAgaWYgKElTX0VS
Uihhcm1fcmVndWxhdG9yKSkgewo+ID4gLSAgICAgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBn
ZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Cj4gPiAtICAgICAgICAgICAgIHJldHVybiBQVFJfRVJS
KGFybV9yZWd1bGF0b3IpOwo+ID4gLSAgICAgfQo+ID4gLQo+ID4gLSAgICAgaW50X3JlZ3VsYXRv
ciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGludCIpOwo+ID4gLSAgICAgaWYgKElTX0VSUihp
bnRfcmVndWxhdG9yKSkgewo+ID4gLSAgICAgICAgICAgICBwcl9lcnIoImZhaWxlZCB0byBnZXQg
cmVndWxhdG9yIHZkZGludFxuIik7Cj4gPiAtICAgICAgICAgICAgIHJlZ3VsYXRvcl9wdXQoYXJt
X3JlZ3VsYXRvcik7Cj4gPiAtICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGludF9yZWd1bGF0
b3IpOwo+ID4gLSAgICAgfQo+ID4gLQo+ID4gICAgICAgcmVnaXN0ZXJfcmVib290X25vdGlmaWVy
KCZzNXB2MjEwX2NwdWZyZXFfcmVib290X25vdGlmaWVyKTsKPiA+Cj4gPiAgICAgICByZXR1cm4g
Y3B1ZnJlcV9yZWdpc3Rlcl9kcml2ZXIoJnM1cHYyMTBfZHJpdmVyKTsKPiA+IC0tCj4gPiAyLjE3
LjEKPgo+IC0tCj4gdmlyZXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
