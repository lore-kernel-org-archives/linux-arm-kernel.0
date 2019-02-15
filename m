Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54277C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:35:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2120B21925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kr+7G6rC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGCa0QQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120B21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HCfFEySoABsNQGEe4D2w0XunruhZo5Ma9StaaDMIue0=; b=kr+7G6rCGkJ77n
	6DXuf9+NVwVs1wyzpUuXRXzWN8NhBcEtTkWlEbo9i1bF+/nT28DugryPmHVW2Kw6SoJ6HGxVjetpu
	LPr20x5egSCTxE0slWBZ069vLIg2bho+HjrJF/BQgIlT54Qgm2MR0bpy4vn833Mm+aVc6rWiJuIVR
	d7BOS5tlHrP2lv/694ghH3+IUNldwiTzc+oT8oABr3vYyuNXBolXGh9jw/RG2mMXLQ2Ky8JoFLW3z
	VMda4wc3mGIU75BV6T8N+Q1H67sStTzksKUzdX0RiZGNB/nEXyegL7++FiBonH6JEcdpgY3He9nvw
	p9RIwstDYD1iWA6c675A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugSW-0005x7-TG; Fri, 15 Feb 2019 16:35:28 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugST-0005wn-L6
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:35:27 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so10576547wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+UDDia6G/+DD5/1lIN78ZXaLP8opgCRs0rsSFv7hySU=;
 b=bGCa0QQBVx458PnN96hmlZHW5qiSMfvTlGA4ewU4iYw4VKfmIZujy4nm8CcdzT4iRd
 0s7EGRwd0jP6MciP3LRJ31RaO+JU+zo8OpT0wRDb2Uv6NgG4qJiIL0nctc4Q10/gNxm5
 3sqHKJj/2RUrecVVfF43wEM5FxGWDrR88oDWAK2dzZQ00WC+ctBmFbgL3r80p7S4Ov8Y
 NhEl/vJCQDkxvB/qY3HkROK+SlezWvHiQvuG6eNiG3O/jM2iPPNtx9REs6haBYXv7Tj2
 wKn/XEA5YIImSxTnVqwEmkQWbRRUWZGx+ydZm6f2MxmgmI6C+sAf2u2+odNRdXrJbFrx
 I22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+UDDia6G/+DD5/1lIN78ZXaLP8opgCRs0rsSFv7hySU=;
 b=LAOvaRiCF6KWNL6SCL4g+BbfvedJoTYTGFHV86l5NAsP2ftDWRzvnaWFpaFmi2UdHO
 bSYANx9Pgxpr8rBLZCI/or4kBsltYgDOz4mFyRK/AKsMgmXteHG4EFom6DPu+kiWh/i5
 U+rTdMy6weRTXraemoo54J1Z1/oTmQAYYO9+KRUxY+ay+b0RW60+k0/LSHxsof+CEqSj
 VfHw5yXenjSdyTptCn0xEKN7W2wUB3sgtzM3qbgGHEriNJ+1FAKHpyb7YluuWVf9rIR8
 IOA9xh8QZhdIoZegSpvdT8LU03vw5WwGjVsxdeveZUMDYGkgykISByTubr+7HBOlz2ca
 Kleg==
X-Gm-Message-State: AHQUAuYxYPiqtd3x+l2FpkaO2JaOoxwhHIV8ErsEMN96KmXWadS/oQ+2
 zBxgCwjQwI3D/6cvauQ2PNcyog==
X-Google-Smtp-Source: AHgI3IaPdFOgfAEmk2WHoa0mFBgiamL+R+t4vu89lLeZ/QeI3+zWIYBSL7+i0NKQmVqX2+DTe1HHjQ==
X-Received: by 2002:a1c:3d84:: with SMTP id k126mr5407193wma.60.1550248523577; 
 Fri, 15 Feb 2019 08:35:23 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id z17sm5938023wrs.75.2019.02.15.08.35.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 08:35:22 -0800 (PST)
Subject: Re: [PATCH 3/5] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2d9167af42f2d04e462c56a070c3371c2@eucas1p2.samsung.com>
 <20190215125229.30180-4-m.szyprowski@samsung.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01569ba7-2e3e-5811-81e1-ca51cacbcb95@linaro.org>
Date: Fri, 15 Feb 2019 17:35:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215125229.30180-4-m.szyprowski@samsung.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_083525_698794_7465FA90 
X-CRM114-Status: GOOD (  19.22  )
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

T24gMTUvMDIvMjAxOSAxMzo1MiwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBFeHlub3MgTXVs
dGktQ29yZSBUaW1lciBkcml2ZXIgKGV4eW5vc19tY3QpIG11c3QgYmUgc3RhcnRlZCBiZWZvcmUg
QVJNCj4gQXJjaGl0ZWN0ZWQgVGltZXJzIChhcmNoX3RpbWVyKSwgYmVjYXVzZSB0aGV5IGJvdGgg
c2hhcmUgc29tZSBjb21tb24KPiBoYXJkd2FyZSBibG9ja3MgKGdsb2JhbCBzeXN0ZW0gY291bnRl
cikgYW5kIHR1cm5pbmcgb24gTUNUIGlzIG5lZWRlZAo+IHRvIGdldCBBUk0gQXJjaGl0ZWN0ZWQg
VGltZXIgd29ya2luZyBwcm9wZXJseS4gSW5jcmVhc2UgTUNUIHRpbWVyIHJhdGluZwo+IGFuZCBo
b3RwbHVnIHByaW9yaXR5IG92ZXIgQVJNIEFyY2hpY3RlY3RlZCB0aW1lciBkcml2ZXIgdG8gYWNo
aWV2ZSB0aGF0LgoKVGhpcyBpcyBhIGhhY2suCgpUaGVyZSBhcmUgbWVjaGFuaXNtcyB0byBoYW5k
bGUgdGhpcyBraW5kIG9mIGRlcGVuZGVuY3kuCgplZy4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC92NC4xNS9kcml2ZXItYXBpL2RldmljZV9saW5rLmh0bWwKCgo+IFNpZ25lZC1vZmYt
Ynk6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9jbG9ja3NvdXJjZS9leHlub3NfbWN0LmMgfCA0ICsrLS0KPiAgaW5jbHVkZS9saW51
eC9jcHVob3RwbHVnLmggICAgICAgfCAyICstCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291
cmNlL2V4eW5vc19tY3QuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvZXh5bm9zX21jdC5jCj4gaW5k
ZXggNDk0MTM5MDBiMjRjLi41ODA5MGY1N2FkYTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jbG9j
a3NvdXJjZS9leHlub3NfbWN0LmMKPiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2V4eW5vc19t
Y3QuYwo+IEBAIC0yMTEsNyArMjExLDcgQEAgc3RhdGljIHZvaWQgZXh5bm9zNF9mcmNfcmVzdW1l
KHN0cnVjdCBjbG9ja3NvdXJjZSAqY3MpCj4gIAo+ICBzdGF0aWMgc3RydWN0IGNsb2Nrc291cmNl
IG1jdF9mcmMgPSB7Cj4gIAkubmFtZQkJPSAibWN0LWZyYyIsCj4gLQkucmF0aW5nCQk9IDQwMCwK
PiArCS5yYXRpbmcJCT0gNDUwLAo+ICAJLnJlYWQJCT0gZXh5bm9zNF9mcmNfcmVhZCwKPiAgCS5t
YXNrCQk9IENMT0NLU09VUkNFX01BU0soMzIpLAo+ICAJLmZsYWdzCQk9IENMT0NLX1NPVVJDRV9J
U19DT05USU5VT1VTLAo+IEBAIC00NjUsNyArNDY1LDcgQEAgc3RhdGljIGludCBleHlub3M0X21j
dF9zdGFydGluZ19jcHUodW5zaWduZWQgaW50IGNwdSkKPiAgCWV2dC0+c2V0X3N0YXRlX29uZXNo
b3Rfc3RvcHBlZCA9IHNldF9zdGF0ZV9zaHV0ZG93bjsKPiAgCWV2dC0+dGlja19yZXN1bWUgPSBz
ZXRfc3RhdGVfc2h1dGRvd247Cj4gIAlldnQtPmZlYXR1cmVzID0gQ0xPQ0tfRVZUX0ZFQVRfUEVS
SU9ESUMgfCBDTE9DS19FVlRfRkVBVF9PTkVTSE9UOwo+IC0JZXZ0LT5yYXRpbmcgPSA0NTA7Cj4g
KwlldnQtPnJhdGluZyA9IDUwMDsKPiAgCj4gIAlleHlub3M0X21jdF93cml0ZShUSUNLX0JBU0Vf
Q05ULCBtZXZ0LT5iYXNlICsgTUNUX0xfVENOVEJfT0ZGU0VUKTsKPiAgCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oIGIvaW5jbHVkZS9saW51eC9jcHVob3RwbHVnLmgK
PiBpbmRleCBmZDU4NmQwMzAxZTcuLmJkZDU0NGYyMTEwMiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2NwdWhvdHBsdWcuaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oCj4g
QEAgLTExNSwxMCArMTE1LDEwIEBAIGVudW0gY3B1aHBfc3RhdGUgewo+ICAJQ1BVSFBfQVBfUEVS
Rl9BUk1fQUNQSV9TVEFSVElORywKPiAgCUNQVUhQX0FQX1BFUkZfQVJNX1NUQVJUSU5HLAo+ICAJ
Q1BVSFBfQVBfQVJNX0wyWDBfU1RBUlRJTkcsCj4gKwlDUFVIUF9BUF9FWFlOT1M0X01DVF9USU1F
Ul9TVEFSVElORywKPiAgCUNQVUhQX0FQX0FSTV9BUkNIX1RJTUVSX1NUQVJUSU5HLAo+ICAJQ1BV
SFBfQVBfQVJNX0dMT0JBTF9USU1FUl9TVEFSVElORywKPiAgCUNQVUhQX0FQX0pDT1JFX1RJTUVS
X1NUQVJUSU5HLAo+IC0JQ1BVSFBfQVBfRVhZTk9TNF9NQ1RfVElNRVJfU1RBUlRJTkcsCj4gIAlD
UFVIUF9BUF9BUk1fVFdEX1NUQVJUSU5HLAo+ICAJQ1BVSFBfQVBfUUNPTV9USU1FUl9TVEFSVElO
RywKPiAgCUNQVUhQX0FQX0FSTUFEQV9USU1FUl9TVEFSVElORywKPiAKCgotLSAKIDxodHRwOi8v
d3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3Ig
QVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMv
TGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0
dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
