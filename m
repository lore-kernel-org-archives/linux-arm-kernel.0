Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B702C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:43:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B030214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="loababk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B030214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fT2Zv5z6JMlT3kgr6FnE/QwQobf8zWK6gU0eYAtNYAE=; b=loababk8gIOa6A
	3d4zM02zoSGmasQoB08z75xIILtxRJWwURZOrKp/LivKLlL8zmbNxvCibf+iAOQa4lRK1FJ/BYmtf
	NY6zQtTfIOevv2I0FBNIh48A5qi3a79TEZG1NFiIp5Jye1ooC3RkE+9QHxdXMKKK63KmS74v5h7pH
	gpDSSKBr9Ijsln8IzqiQNaE01qPveJNYBBzPpnOAXTAkA/sY9vv11n2aPL5y6ZULHCqyqg+nBwuJh
	bvresPeFhUmKom+znrcwOE4mC8MIk20qFWZ/SOlazIEhZjhIQL1U816tu5HlZFrHEp/Bbao8VFDU1
	jlFhqoqHPEK8OOT8xwcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWrf-0001ZI-M8; Thu, 10 Jan 2019 09:43:03 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWrY-0001Qh-32
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:43:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4AE732A605C;
 Thu, 10 Jan 2019 10:34:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BNYCLC4Bhzyw; Thu, 10 Jan 2019 10:34:29 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 46A492A6059;
 Thu, 10 Jan 2019 10:34:29 +0100 (CET)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1ghWjM-0001mb-Rw; Thu, 10 Jan 2019 10:34:28 +0100
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
Date: Thu, 10 Jan 2019 10:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_014256_789627_F2CFF4B4 
X-CRM114-Status: GOOD (  18.15  )
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
Cc: Carsten.Haitzler@arm.com, David Airlie <airlied@linux.ie>,
 will.deacon@arm.com, dri-devel@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org, Bernhard.Rosenkranzer@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0xMCA4OjI4IGEubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IEFSTSBzeXN0
ZW1zIGRvIG5vdCBwZXJtaXQgdGhlIHVzZSBvZiBhbnl0aGluZyBvdGhlciB0aGFuIGNhY2hlZAo+
IG1hcHBpbmdzIGZvciBzeXN0ZW0gbWVtb3J5LCBzaW5jZSB0aGF0IG1lbW9yeSBtYXkgYmUgbWFw
cGVkIGluIHRoZQo+IGxpbmVhciByZWdpb24gYXMgd2VsbCwgYW5kIHRoZSBhcmNoaXRlY3R1cmUg
ZG9lcyBub3QgcGVybWl0IGFsaWFzZXMKPiB3aXRoIG1pc21hdGNoZWQgYXR0cmlidXRlcy4KPiAK
PiBTbyBzaG9ydC1jaXJjdWl0IHRoZSBldmFsdWF0aW9uIGluIHR0bV9pb19wcm90KCkgaWYgdGhl
IGZsYWdzIGluY2x1ZGUKPiBUVE1fUExfU1lTVEVNIHdoZW4gcnVubmluZyBvbiBBUk0gb3IgYXJt
NjQsIGFuZCBqdXN0IHJldHVybiBjYWNoZWQKPiBhdHRyaWJ1dGVzIGltbWVkaWF0ZWx5Lgo+IAo+
IFRoaXMgZml4ZXMgdGhlIHJhZGVvbiBhbmQgYW1kZ3B1IFtUQkNdIGRyaXZlcnMgd2hlbiBydW5u
aW5nIG9uIGFybTY0Lgo+IFdpdGhvdXQgdGhpcyBjaGFuZ2UsIGFtZGdwdSBkb2VzIG5vdCBzdGFy
dCBhdCBhbGwsIGFuZCByYWRlb24gb25seQo+IHByb2R1Y2VzIGNvcnJ1cHQgZGlzcGxheSBvdXRw
dXQuCj4gCj4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
PiBDYzogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiBDYzogSnVud2VpIFpoYW5nIDxK
ZXJyeS5aaGFuZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
Cj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJAYXJtLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJv
Lm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jIHwgNSArKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X2JvX3V0aWwuYwo+IGluZGV4IDA0NmE2ZGRhNjkwYS4uMGMxZWVmNWY3YWUzIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvX3V0aWwuYwo+IEBAIC01MzAsNiArNTMwLDExIEBAIHBncHJvdF90IHR0
bV9pb19wcm90KHVpbnQzMl90IGNhY2hpbmdfZmxhZ3MsIHBncHJvdF90IHRtcCkKPiAgCWlmIChj
YWNoaW5nX2ZsYWdzICYgVFRNX1BMX0ZMQUdfQ0FDSEVEKQo+ICAJCXJldHVybiB0bXA7Cj4gIAo+
ICsjaWYgZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQo+ICsJLyogQVJN
IG9ubHkgcGVybWl0cyBjYWNoZWQgbWFwcGluZ3Mgb2Ygc3lzdGVtIG1lbW9yeSAqLwo+ICsJaWYg
KGNhY2hpbmdfZmxhZ3MgJiBUVE1fUExfU1lTVEVNKQo+ICsJCXJldHVybiB0bXA7Cj4gKyNlbmRp
Zgo+ICAjaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChfX3g4Nl82NF9fKQo+ICAJaWYg
KGNhY2hpbmdfZmxhZ3MgJiBUVE1fUExfRkxBR19XQykKPiAgCQl0bXAgPSBwZ3Byb3Rfd3JpdGVj
b21iaW5lKHRtcCk7Cj4gCgpBcGFydCBmcm9tIENocmlzdGlhbidzIGNvbmNlcm5zLCBJIHRoaW5r
IHRoaXMgaXMgdGhlIHdyb25nIHBsYWNlIGZvcgp0aGlzLCBiZWNhdXNlIG90aGVyIFRUTSAvIGRy
aXZlciBjb2RlIHdpbGwgc3RpbGwgY29uc2lkZXIgdGhlIG1lbW9yeQp1bmNhY2hlYWJsZS4gRS5n
LiB0aGUgYW1kZ3B1IGRyaXZlciB3aWxsIHByb2dyYW0gdGhlIEdQVSB0byB0cmVhdCB0aGUKbWVt
b3J5IGFzIHVuY2FjaGVhYmxlLCBzbyBpdCB3b24ndCBwYXJ0aWNpcGF0ZSBpbiBjYWNoZSBjb2hl
cmVuY3kKcHJvdG9jb2wgZm9yIGl0LCB3aGljaCBpcyB1bmxpa2VseSB0byB3b3JrIGFzIGV4cGVj
dGVkIGluIGdlbmVyYWwgaWYgdGhlCkNQVSB0cmVhdHMgdGhlIG1lbW9yeSBhcyBjYWNoZWFibGUu
CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
