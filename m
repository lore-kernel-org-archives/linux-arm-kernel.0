Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637AAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF4321736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PTRKEdf8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEWGhR/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF4321736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VHOE9NUgIOT7ZOKOkqFzh+htSCLNv4slqMKIM6z90n8=; b=PTRKEdf8mgD/jd
	DJMHel6xo5PZ4PAPyF1TMSKbTtRKR+1M0hF/RWpel3U/stfFrDGTdP/ow/o3b6Qmgf0cxfEhXK5+i
	kvg/opokDVOeec14x1dt3epJbEQHuLVy0ydhtY1N7/cTc8nqoXccG2zsDDJi276jw3+MkTGOeApYQ
	zruPfHQNt0Zg/tKR1hMAAALdXiPqCGwovPqbJIghMF73anXcu7rC4H4RRTF2B7UXMd3tBGueZbqHp
	E297k0Rs0eM+LyHybjGbP4J538A/JMAtQPksgXKp1yI9VT2xV1uEKOgzKBpLqgc077xkSTboHTVBm
	fDJjAKnS6GQV7+UJFa9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvg3a-00037o-LF; Mon, 18 Feb 2019 10:21:50 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvg3U-00036w-Gh
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:21:48 +0000
Received: by mail-wr1-x442.google.com with SMTP id n2so5537356wrw.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5zQBHYavMvtekGIrhNoD55RZMwqIjQhb/WsOspcKGSo=;
 b=AEWGhR/sDZXSjSpEKIcIlr5h5t13qZr/t4zcMs9UmrT/ym7lG2RtoVtx/J9N0ieuac
 l9r80Et/mkEvKQC+L24ZmzWCiy/d3ya7EAoJ48s8j2oCg2DwmKMvMwj+mJiwUFpsfAlV
 OdC9dOmXQCFI+H2P0KZsOgbT8UU4vaiIhNZNOvWCtYPoWTYBYvL+AR+ba5qvPy4vjSkW
 kZgjUkaLz+DZhal3v9XFIOr4DNI56hGTG1od9lGiMTVU4vOueoapOJj6gDSxl49iItb1
 QMaS2mK4wERqTgf7fNI5dgRwze1JznJ3dqbfYDZ5OnDRKWVYCXyU49sudd5JxksrCLWl
 xiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5zQBHYavMvtekGIrhNoD55RZMwqIjQhb/WsOspcKGSo=;
 b=PFoN/dCQiX3rsMvWD8DoSiZkPOWKLGOoEMopXgo9RfpjqhStVNNcoxgJ1Mv8AtQmh9
 J54LgPvicfnHv6Tm5aM+1ZJRIXwPcQyZZQCTp75dIxch3/uiib+Qv3Bkfl4uojcAykGE
 8FotOXrgQoxf8GUBIUXA/Ctxhcpd095O3/D41SW7jjyI4SiaZUhGbNR8iSqU1yOh0WAX
 cPOi8AIxUX7eeU1VP7BVxZr7TPetG71PwZMfo4E3K7dFUbne2j0Y+UnoZfRY0UNxQyLr
 Dr/fkW1CLCuTFBifeL3atIBf4XhubNx5g0nY6uxJoepnHJd3zSCHoxuTthi0JRO/NMOk
 Gmig==
X-Gm-Message-State: AHQUAuZ8KV6mWNaFhjAwRUqmzqeo7E/ymq/+8aib96aG1v8GxsaiDsrE
 i7if2K4CyrWEZ/awa2hZFSKMcw==
X-Google-Smtp-Source: AHgI3IYoKa8oxIaZUMjEXp1xb0ZXDYuXbnoyXPA8O6x2IZdlXE3P8sTEI7k/1D14IuwJtpBaSdE6cA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr16137559wrp.180.1550485300331; 
 Mon, 18 Feb 2019 02:21:40 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id e9sm16028290wrc.56.2019.02.18.02.21.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 02:21:39 -0800 (PST)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
 <7b994b86-9a84-39a7-e88d-203c64b30de8@samsung.com>
 <4b054e7d-5dd5-5796-6c08-22f15060f940@linaro.org>
 <fd3aac7b-029e-5873-f472-a0c83dda4da5@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <23cb02e1-7728-823c-462a-4a597f1607f9@linaro.org>
Date: Mon, 18 Feb 2019 11:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fd3aac7b-029e-5873-f472-a0c83dda4da5@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_022146_773751_1601AE15 
X-CRM114-Status: GOOD (  23.49  )
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
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAxMDo0OSwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBIaSBEYW5pZWws
Cj4gCj4gT24gMjAxOS0wMi0xOCAxMDoyNCwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDE4
LzAyLzIwMTkgMDg6NDEsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+PiBPbiAyMDE5LTAyLTE1
IDE3OjM1LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToKPj4+PiBPbiAxNS8wMi8yMDE5IDEzOjUyLCBN
YXJlayBTenlwcm93c2tpIHdyb3RlOgo+Pj4+PiBFeHlub3MgTXVsdGktQ29yZSBUaW1lciBkcml2
ZXIgKGV4eW5vc19tY3QpIG11c3QgYmUgc3RhcnRlZCBiZWZvcmUgQVJNCj4+Pj4+IEFyY2hpdGVj
dGVkIFRpbWVycyAoYXJjaF90aW1lciksIGJlY2F1c2UgdGhleSBib3RoIHNoYXJlIHNvbWUgY29t
bW9uCj4+Pj4+IGhhcmR3YXJlIGJsb2NrcyAoZ2xvYmFsIHN5c3RlbSBjb3VudGVyKSBhbmQgdHVy
bmluZyBvbiBNQ1QgaXMgbmVlZGVkCj4+Pj4+IHRvIGdldCBBUk0gQXJjaGl0ZWN0ZWQgVGltZXIg
d29ya2luZyBwcm9wZXJseS4gSW5jcmVhc2UgTUNUIHRpbWVyIHJhdGluZwo+Pj4+PiBhbmQgaG90
cGx1ZyBwcmlvcml0eSBvdmVyIEFSTSBBcmNoaWN0ZWN0ZWQgdGltZXIgZHJpdmVyIHRvIGFjaGll
dmUgdGhhdC4KPj4+PiBUaGlzIGlzIGEgaGFjay4KPj4+Pgo+Pj4+IFRoZXJlIGFyZSBtZWNoYW5p
c21zIHRvIGhhbmRsZSB0aGlzIGtpbmQgb2YgZGVwZW5kZW5jeS4KPj4+Pgo+Pj4+IGVnLiBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE1L2RyaXZlci1hcGkvZGV2aWNlX2xpbmsu
aHRtbAo+Pj4gU29ycnksIGJ1dCB0aGlzIGlzIG5vdCBhIGhhY2ssIGJ1dCBwcm9wZXIgd2F5IHRv
IGhhbmRsZSB0aGlzIGluCj4+PiBjbG9ja3NvdXJjZS90aW1lcnMgZnJhbWV3b3JrLiBUaGUgcmF0
aW5ncyBhc3NpZ25lZCB0byBlYWNoIGRyaXZlciBhbmQKPj4+IGNwdSBob3RwbHVnIHByaW9yaXR5
IGxpc3QgYXJlIGV4YWN0bHkgZm9yIG1hbmFnaW5nIHRoZSByZXF1ZXN0ZWQgb3JkZXIKPj4+IG9m
IG9wZXJhdGlvbnMgaWYgbW9yZSB0aGFuIG9uZSBkcml2ZXIgaGFzIGJlZW4gcmVnaXN0ZXJlZC4K
Pj4gQWN0dWFsbHksIEknbSByZWx1Y3RhbnQgd2l0aCB0aGlzIGNoYW5nZSAoZXZlbiBpZiBpdCBp
cyBjb3JyZWN0KSBiZWNhdXNlCj4+IGl0IGludHJvZHVjZXMgYW4gaW1wbGljaXQgZGVwZW5kZW5j
eSBpbiB0aGUgY3B1IGhvdHBsdWcgZW51bWVyYXRpb24gZm9yCj4+IHRoZSB0aW1lciBzdWJzeXN0
ZW0gd2hpbGUgaXQgbWF5IGJlIG1vcmUgY29ycmVjdCB0byBoYXZlIGl0IGV4cGxpY2l0bHkKPj4g
d2l0aCB0aGUgaGFyZHdhcmUgZGVzY3JpcHRpb24gKG9yIHdoYXRldmVyKS4KPiAKPiBNYXliZSBh
ZGRpdGlvbmFsIGNvbW1lbnQgaW4gdGhlIGNwdSBob3RwbHVnIGxpc3Qgd2lsbCBjb252aW5jZSB5
b3U/IEZvcgo+IHRoZSBjdXJyZW50IGNvZGUgY2hhbmdpbmcgdGhlIG9yZGVyIG9mIGVudW1zIGl0
IGlzIG1vcmUgdGhhbiBlbm91Z2guCj4gVGhlcmUgYXJlIG5vIGR5bmFtaWMgQ1BVIGhvdHBsdWcg
cHJpb3JpdGllcywgc28gTUNUIGRyaXZlciBjYW5ub3QgY2hhbmdlCj4gaXRzIGJlaGF2aW9yIGRl
cGVuZGluZyBvbiBhbnkgZHQtcHJvcGVydHkgb3Igc28uIEluY3JlYXNpbmcgTUNUIHByaW9yaXR5
Cj4gaGFzIG5vIHNpZGUtZWZmZWN0cyBpbiByZWxhdGlvbiB0byBvdGhlciBkcml2ZXJzIChhcyB0
aGV5IGNhbm5vdAo+IGV4aXN0aW5nIG9uIHRoZSBzYW1lIGJvYXJkKS4KCkl0IGlzIFRob21hcydz
IGNhbGwsIEkgd2lsbCBsZXQgaGltIGRlY2lkZSBpZiBpdCBpcyBvayAuCgoKCj4+IEhvd2V2ZXIg
SSBkb24ndCBzZWUgYSBwcm9wZXIgd2F5IHRvIGRlc2NyaWJlIHRoaXMgZGVwZW5kZW5jeSB3aXRo
b3V0Cj4+IHRvdWNoaW5nIHRoZSBEVCBhbmQgYWRkIGEgcGhhbmRsZSB0byB0aGUgYXJjaCB0aW1l
ciBpbiB0aGUgZXh5bm9zX21jdAo+PiB0aW1lciBkZXNjcmlwdGlvbi4KPj4KPj4+IERldmljZSBs
aW5rcyBvcGVyYXRlcyBvbiB0aGUgJ2tlcm5lbCBkZXZpY2UnIG9iamVjdHMsIHdoaWNoIGFyZSBj
cmVhdGVkCj4+PiBhbmQgbWFuYWdlZCBtdWNoIGxhdGVyIHRoYW4gY2xvY2tzb3VyY2UvdGltZXJz
IGFyZSBpbml0aWFsaXplZC4gSSBzZWUgbm8KPj4+IHVzZSBvZiBkZXZpY2UgbGlua3MgaW4gdGhp
cyBjb250ZXh0Lgo+PiBZZXMsIHRoYXQgd2FzIGp1c3QgYW4gZXhhbXBsZSB0byBzaG93IHRoZXJl
IGFyZSBtZWNoYW5pc21zIHRvIGFsbG93Cj4+IHByb3BlciBvcmRlcmluZy4gQXMgc2FpZCBiZWZv
cmUsIG5vdCB0aGUgYmVzdCBleGFtcGxlIGZvciB0aGlzIHNpdHVhdGlvbi4KPj4KPj4+Pj4gU2ln
bmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgo+
Pj4+PiAtLS0KPj4+Pj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvZXh5bm9zX21jdC5jIHwgNCArKy0t
Cj4+Pj4+ICBpbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaCAgICAgICB8IDIgKy0KPj4+Pj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMgYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL2V4eW5vc19tY3QuYwo+Pj4+PiBpbmRleCA0OTQxMzkwMGIyNGMuLjU4MDkw
ZjU3YWRhMyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0
LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMKPj4+Pj4gQEAg
LTIxMSw3ICsyMTEsNyBAQCBzdGF0aWMgdm9pZCBleHlub3M0X2ZyY19yZXN1bWUoc3RydWN0IGNs
b2Nrc291cmNlICpjcykKPj4+Pj4gIAo+Pj4+PiAgc3RhdGljIHN0cnVjdCBjbG9ja3NvdXJjZSBt
Y3RfZnJjID0gewo+Pj4+PiAgCS5uYW1lCQk9ICJtY3QtZnJjIiwKPj4+Pj4gLQkucmF0aW5nCQk9
IDQwMCwKPj4+Pj4gKwkucmF0aW5nCQk9IDQ1MCwKPj4+Pj4gIAkucmVhZAkJPSBleHlub3M0X2Zy
Y19yZWFkLAo+Pj4+PiAgCS5tYXNrCQk9IENMT0NLU09VUkNFX01BU0soMzIpLAo+Pj4+PiAgCS5m
bGFncwkJPSBDTE9DS19TT1VSQ0VfSVNfQ09OVElOVU9VUywKPj4+Pj4gQEAgLTQ2NSw3ICs0NjUs
NyBAQCBzdGF0aWMgaW50IGV4eW5vczRfbWN0X3N0YXJ0aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1
KQo+Pj4+PiAgCWV2dC0+c2V0X3N0YXRlX29uZXNob3Rfc3RvcHBlZCA9IHNldF9zdGF0ZV9zaHV0
ZG93bjsKPj4+Pj4gIAlldnQtPnRpY2tfcmVzdW1lID0gc2V0X3N0YXRlX3NodXRkb3duOwo+Pj4+
PiAgCWV2dC0+ZmVhdHVyZXMgPSBDTE9DS19FVlRfRkVBVF9QRVJJT0RJQyB8IENMT0NLX0VWVF9G
RUFUX09ORVNIT1Q7Cj4+Pj4+IC0JZXZ0LT5yYXRpbmcgPSA0NTA7Cj4+Pj4+ICsJZXZ0LT5yYXRp
bmcgPSA1MDA7Cj4+Pj4+ICAKPj4+Pj4gIAlleHlub3M0X21jdF93cml0ZShUSUNLX0JBU0VfQ05U
LCBtZXZ0LT5iYXNlICsgTUNUX0xfVENOVEJfT0ZGU0VUKTsKPj4+Pj4gIAo+Pj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmggYi9pbmNsdWRlL2xpbnV4L2NwdWhvdHBs
dWcuaAo+Pj4+PiBpbmRleCBmZDU4NmQwMzAxZTcuLmJkZDU0NGYyMTEwMiAxMDA2NDQKPj4+Pj4g
LS0tIGEvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgKPj4+Pj4gKysrIGIvaW5jbHVkZS9saW51
eC9jcHVob3RwbHVnLmgKPj4+Pj4gQEAgLTExNSwxMCArMTE1LDEwIEBAIGVudW0gY3B1aHBfc3Rh
dGUgewo+Pj4+PiAgCUNQVUhQX0FQX1BFUkZfQVJNX0FDUElfU1RBUlRJTkcsCj4+Pj4+ICAJQ1BV
SFBfQVBfUEVSRl9BUk1fU1RBUlRJTkcsCj4+Pj4+ICAJQ1BVSFBfQVBfQVJNX0wyWDBfU1RBUlRJ
TkcsCj4+Pj4+ICsJQ1BVSFBfQVBfRVhZTk9TNF9NQ1RfVElNRVJfU1RBUlRJTkcsCj4+Pj4+ICAJ
Q1BVSFBfQVBfQVJNX0FSQ0hfVElNRVJfU1RBUlRJTkcsCj4+Pj4+ICAJQ1BVSFBfQVBfQVJNX0dM
T0JBTF9USU1FUl9TVEFSVElORywKPj4+Pj4gIAlDUFVIUF9BUF9KQ09SRV9USU1FUl9TVEFSVElO
RywKPj4+Pj4gLQlDUFVIUF9BUF9FWFlOT1M0X01DVF9USU1FUl9TVEFSVElORywKPj4+Pj4gIAlD
UFVIUF9BUF9BUk1fVFdEX1NUQVJUSU5HLAo+Pj4+PiAgCUNQVUhQX0FQX1FDT01fVElNRVJfU1RB
UlRJTkcsCj4+Pj4+ICAJQ1BVSFBfQVBfQVJNQURBX1RJTUVSX1NUQVJUSU5HLAo+Pj4+Pgo+IEJl
c3QgcmVnYXJkcwo+IAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg
4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxo
dHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90
d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3Jn
L2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
