Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB53120838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A4OHtIrX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SG3Vlzde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB53120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qLDfDxFRIN7cX98ZeSK3HhV8LhNb0num9gaIAKMusHA=; b=A4OHtIrXlGYfcq
	o3ly5gGyVWdeNHgph6wQqSufLlbYk3CL6315Hc9BgF1neUHAGHaOjjn8eT9DOVL7a8/44CHftJfJk
	RMvwKy2WEiAcLM2SYsPEwne6pR5ZGo9fTo2yIgLYcOdXOI+YOzpd/LDAwH8kS2DpsFmBXoQ0L24cs
	19ueXa+OFDALAaYefLzzS4Yz7ZbhsQrqmd5W2Mj1VfFuauHXY0Q/okh5uDKJ3L7zUbgVIXgqJKZXw
	DxvYK4IhC/mO1jzJhvENLUcOW9QYGQD1hbk1bgl+qOqxH4ryrxoU0fT510ZW+8s2vtscO4tr2T6qy
	EvkS1Ui1BnG4ioI46TPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfAe-0005aD-7B; Mon, 18 Feb 2019 09:25:04 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfAS-0005JE-3h
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:24:56 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so16603692wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5qLCNxBv6kqzAGutsIsv0hKoLIqPv4VEyfuIKthbMRA=;
 b=SG3VlzdeI+sOmPn0CNJg9NKwZR4/zQlH01wvrh8YTlAA07Xc4fBZ4kvHSxiMejROod
 fT1kYsCQbn508cCqQnNOA0TSZNWUi2g6b1D0lex6Nj53yaacnVw+R00D2cnXVraSv2hC
 Z5i+N9InXUFfeqos4uWRK6RB5FD0lsONuuaU46y9bh7q37Nd5YUouCm0bkFLhVTy4bW8
 salzcSYQ9g5RmpoYfWFHhSfzraGDO5hRrypwczm7Yk3LCsYRS4jQNiU7Pda/iIQeRXTR
 5gl8pnfYFQqy2+2D7PlXeETXH7+Qci4aeuaV9SsU+Xjt38guQN8o7appq8/3f1rLO8ml
 bN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5qLCNxBv6kqzAGutsIsv0hKoLIqPv4VEyfuIKthbMRA=;
 b=H7+r5d3llXZrjFSzbPS/WhbZPWYlEEhe9DIrjmYbFHTiiCwIadRFHDFYQMHTxP0lpf
 /4jbzwq5DTTMju6ugLr5FUhav/KlSvR76W5DkEKQomoNQSUEh2p3acYGIJezTSVI13s9
 8BkmCiALYaLzl5C2KPQ4HlIck36emi2W1SdN4AB3IoaH5fA07alQ2yNYhiU3rt+IfR9F
 lG7RVtM2+e+oHbc11rkHEWSGJiJS5qAVka22NpTkycQpZi1pg1mb4atuEORSpvcZkk/H
 PJHwnb0gRsuMDdAZt9rg4Eqd4TZiMXGm9r5RjMEPixlG1q0E+MS+Oaq48GLe/JbQ5OmY
 gDuQ==
X-Gm-Message-State: AHQUAuZ7L3yEbJy14tsVM3klZjA0QmldWHe2DIB33XDXUSkzrcy9Qiqb
 bH4W4PMPP6GrAoTMfcuUVmzJdg==
X-Google-Smtp-Source: AHgI3IbaCMn+6uiHegrxY9/9w9agnD15spbDkZ2DSnq27l2UuWISBJDsKztXvo+vPkeoj4Yg5qTj5A==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr4796738wml.4.1550481890108; 
 Mon, 18 Feb 2019 01:24:50 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id y1sm13896867wru.4.2019.02.18.01.24.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 01:24:49 -0800 (PST)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
 <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
 <7b994b86-9a84-39a7-e88d-203c64b30de8@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4b054e7d-5dd5-5796-6c08-22f15060f940@linaro.org>
Date: Mon, 18 Feb 2019 10:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7b994b86-9a84-39a7-e88d-203c64b30de8@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_012452_534599_33163A4B 
X-CRM114-Status: GOOD (  23.12  )
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

T24gMTgvMDIvMjAxOSAwODo0MSwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBIaSBEYW5pZWws
Cj4gCj4gT24gMjAxOS0wMi0xNSAxNzozNSwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDE1
LzAyLzIwMTkgMTM6NTIsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+PiBFeHlub3MgTXVsdGkt
Q29yZSBUaW1lciBkcml2ZXIgKGV4eW5vc19tY3QpIG11c3QgYmUgc3RhcnRlZCBiZWZvcmUgQVJN
Cj4+PiBBcmNoaXRlY3RlZCBUaW1lcnMgKGFyY2hfdGltZXIpLCBiZWNhdXNlIHRoZXkgYm90aCBz
aGFyZSBzb21lIGNvbW1vbgo+Pj4gaGFyZHdhcmUgYmxvY2tzIChnbG9iYWwgc3lzdGVtIGNvdW50
ZXIpIGFuZCB0dXJuaW5nIG9uIE1DVCBpcyBuZWVkZWQKPj4+IHRvIGdldCBBUk0gQXJjaGl0ZWN0
ZWQgVGltZXIgd29ya2luZyBwcm9wZXJseS4gSW5jcmVhc2UgTUNUIHRpbWVyIHJhdGluZwo+Pj4g
YW5kIGhvdHBsdWcgcHJpb3JpdHkgb3ZlciBBUk0gQXJjaGljdGVjdGVkIHRpbWVyIGRyaXZlciB0
byBhY2hpZXZlIHRoYXQuCj4+IFRoaXMgaXMgYSBoYWNrLgo+Pgo+PiBUaGVyZSBhcmUgbWVjaGFu
aXNtcyB0byBoYW5kbGUgdGhpcyBraW5kIG9mIGRlcGVuZGVuY3kuCj4+Cj4+IGVnLiBodHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE1L2RyaXZlci1hcGkvZGV2aWNlX2xpbmsuaHRt
bAo+IAo+IFNvcnJ5LCBidXQgdGhpcyBpcyBub3QgYSBoYWNrLCBidXQgcHJvcGVyIHdheSB0byBo
YW5kbGUgdGhpcyBpbgo+IGNsb2Nrc291cmNlL3RpbWVycyBmcmFtZXdvcmsuIFRoZSByYXRpbmdz
IGFzc2lnbmVkIHRvIGVhY2ggZHJpdmVyIGFuZAo+IGNwdSBob3RwbHVnIHByaW9yaXR5IGxpc3Qg
YXJlIGV4YWN0bHkgZm9yIG1hbmFnaW5nIHRoZSByZXF1ZXN0ZWQgb3JkZXIKPiBvZiBvcGVyYXRp
b25zIGlmIG1vcmUgdGhhbiBvbmUgZHJpdmVyIGhhcyBiZWVuIHJlZ2lzdGVyZWQuCgpBY3R1YWxs
eSwgSSdtIHJlbHVjdGFudCB3aXRoIHRoaXMgY2hhbmdlIChldmVuIGlmIGl0IGlzIGNvcnJlY3Qp
IGJlY2F1c2UKaXQgaW50cm9kdWNlcyBhbiBpbXBsaWNpdCBkZXBlbmRlbmN5IGluIHRoZSBjcHUg
aG90cGx1ZyBlbnVtZXJhdGlvbiBmb3IKdGhlIHRpbWVyIHN1YnN5c3RlbSB3aGlsZSBpdCBtYXkg
YmUgbW9yZSBjb3JyZWN0IHRvIGhhdmUgaXQgZXhwbGljaXRseQp3aXRoIHRoZSBoYXJkd2FyZSBk
ZXNjcmlwdGlvbiAob3Igd2hhdGV2ZXIpLgoKSG93ZXZlciBJIGRvbid0IHNlZSBhIHByb3BlciB3
YXkgdG8gZGVzY3JpYmUgdGhpcyBkZXBlbmRlbmN5IHdpdGhvdXQKdG91Y2hpbmcgdGhlIERUIGFu
ZCBhZGQgYSBwaGFuZGxlIHRvIHRoZSBhcmNoIHRpbWVyIGluIHRoZSBleHlub3NfbWN0CnRpbWVy
IGRlc2NyaXB0aW9uLgoKPiBEZXZpY2UgbGlua3Mgb3BlcmF0ZXMgb24gdGhlICdrZXJuZWwgZGV2
aWNlJyBvYmplY3RzLCB3aGljaCBhcmUgY3JlYXRlZAo+IGFuZCBtYW5hZ2VkIG11Y2ggbGF0ZXIg
dGhhbiBjbG9ja3NvdXJjZS90aW1lcnMgYXJlIGluaXRpYWxpemVkLiBJIHNlZSBubwo+IHVzZSBv
ZiBkZXZpY2UgbGlua3MgaW4gdGhpcyBjb250ZXh0LgoKWWVzLCB0aGF0IHdhcyBqdXN0IGFuIGV4
YW1wbGUgdG8gc2hvdyB0aGVyZSBhcmUgbWVjaGFuaXNtcyB0byBhbGxvdwpwcm9wZXIgb3JkZXJp
bmcuIEFzIHNhaWQgYmVmb3JlLCBub3QgdGhlIGJlc3QgZXhhbXBsZSBmb3IgdGhpcyBzaXR1YXRp
b24uCgo+Pj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNh
bXN1bmcuY29tPgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMg
fCA0ICsrLS0KPj4+ICBpbmNsdWRlL2xpbnV4L2NwdWhvdHBsdWcuaCAgICAgICB8IDIgKy0KPj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMgYi9kcml2ZXJz
L2Nsb2Nrc291cmNlL2V4eW5vc19tY3QuYwo+Pj4gaW5kZXggNDk0MTM5MDBiMjRjLi41ODA5MGY1
N2FkYTMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2V4eW5vc19tY3QuYwo+
Pj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMKPj4+IEBAIC0yMTEsNyAr
MjExLDcgQEAgc3RhdGljIHZvaWQgZXh5bm9zNF9mcmNfcmVzdW1lKHN0cnVjdCBjbG9ja3NvdXJj
ZSAqY3MpCj4+PiAgCj4+PiAgc3RhdGljIHN0cnVjdCBjbG9ja3NvdXJjZSBtY3RfZnJjID0gewo+
Pj4gIAkubmFtZQkJPSAibWN0LWZyYyIsCj4+PiAtCS5yYXRpbmcJCT0gNDAwLAo+Pj4gKwkucmF0
aW5nCQk9IDQ1MCwKPj4+ICAJLnJlYWQJCT0gZXh5bm9zNF9mcmNfcmVhZCwKPj4+ICAJLm1hc2sJ
CT0gQ0xPQ0tTT1VSQ0VfTUFTSygzMiksCj4+PiAgCS5mbGFncwkJPSBDTE9DS19TT1VSQ0VfSVNf
Q09OVElOVU9VUywKPj4+IEBAIC00NjUsNyArNDY1LDcgQEAgc3RhdGljIGludCBleHlub3M0X21j
dF9zdGFydGluZ19jcHUodW5zaWduZWQgaW50IGNwdSkKPj4+ICAJZXZ0LT5zZXRfc3RhdGVfb25l
c2hvdF9zdG9wcGVkID0gc2V0X3N0YXRlX3NodXRkb3duOwo+Pj4gIAlldnQtPnRpY2tfcmVzdW1l
ID0gc2V0X3N0YXRlX3NodXRkb3duOwo+Pj4gIAlldnQtPmZlYXR1cmVzID0gQ0xPQ0tfRVZUX0ZF
QVRfUEVSSU9ESUMgfCBDTE9DS19FVlRfRkVBVF9PTkVTSE9UOwo+Pj4gLQlldnQtPnJhdGluZyA9
IDQ1MDsKPj4+ICsJZXZ0LT5yYXRpbmcgPSA1MDA7Cj4+PiAgCj4+PiAgCWV4eW5vczRfbWN0X3dy
aXRlKFRJQ0tfQkFTRV9DTlQsIG1ldnQtPmJhc2UgKyBNQ1RfTF9UQ05UQl9PRkZTRVQpOwo+Pj4g
IAo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oIGIvaW5jbHVkZS9s
aW51eC9jcHVob3RwbHVnLmgKPj4+IGluZGV4IGZkNTg2ZDAzMDFlNy4uYmRkNTQ0ZjIxMTAyIDEw
MDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgKPj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvY3B1aG90cGx1Zy5oCj4+PiBAQCAtMTE1LDEwICsxMTUsMTAgQEAgZW51bSBjcHVo
cF9zdGF0ZSB7Cj4+PiAgCUNQVUhQX0FQX1BFUkZfQVJNX0FDUElfU1RBUlRJTkcsCj4+PiAgCUNQ
VUhQX0FQX1BFUkZfQVJNX1NUQVJUSU5HLAo+Pj4gIAlDUFVIUF9BUF9BUk1fTDJYMF9TVEFSVElO
RywKPj4+ICsJQ1BVSFBfQVBfRVhZTk9TNF9NQ1RfVElNRVJfU1RBUlRJTkcsCj4+PiAgCUNQVUhQ
X0FQX0FSTV9BUkNIX1RJTUVSX1NUQVJUSU5HLAo+Pj4gIAlDUFVIUF9BUF9BUk1fR0xPQkFMX1RJ
TUVSX1NUQVJUSU5HLAo+Pj4gIAlDUFVIUF9BUF9KQ09SRV9USU1FUl9TVEFSVElORywKPj4+IC0J
Q1BVSFBfQVBfRVhZTk9TNF9NQ1RfVElNRVJfU1RBUlRJTkcsCj4+PiAgCUNQVUhQX0FQX0FSTV9U
V0RfU1RBUlRJTkcsCj4+PiAgCUNQVUhQX0FQX1FDT01fVElNRVJfU1RBUlRJTkcsCj4+PiAgCUNQ
VUhQX0FQX0FSTUFEQV9USU1FUl9TVEFSVElORywKPj4+Cj4+Cj4gQmVzdCByZWdhcmRzCj4gCgoK
LS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJv
b2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xp
bmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBC
bG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
