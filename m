Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D155C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:53:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CF620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OzbVtY+G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUwKQM/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CF620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=McV19LmPCK0PQeEVcBPySYTlBVMfyR6peEZf9Tv/EDo=; b=OzbVtY+Gnhh2lR
	+qj0a0GcsrmpNGZQ+xhXcJ6nJ/zXuEyHUWbwwabGwTBdj+BpabIsRbKlZOt8H6qfDVP1rykOleUW+
	f9L8D2K1qaemi5L28OXyzeCGm04wvV7k6shPvD02n63v8PNuVwA6HlpTcGO/RSeMPI9bOikifdsd5
	bbfnf7bHGEENaWdRMj8QYAo9fOS91fBHWHFx51uQS25kQFEf98BNaAD/tQO8eAWFmbrPjgsoV3+0P
	bDoBrpsKdxaO6WwCXI2nQMavBE7W+Otswdb11NvGHcdcU3M445jUbiTb3guXHht4OEuemX6ifmnO6
	fOZl1yvtPoTQMr0psgUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggucv-00018R-JA; Tue, 08 Jan 2019 16:53:17 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggucs-00017i-1P
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:53:15 +0000
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so4004103ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fLC8xP95XjKGKpur7tchfnAoZqhWli1WpKDNedamUH0=;
 b=mUwKQM/t9UWAJrx0/NjmVv6wD6xEDFa8v9So03SgRKTJcNyLnQpD8I/EmTE+iwr/wV
 /Sd1dGMzpiq+YYRl82wEtHRN8w5ZqRkudSxGB5Q5zmWl/MtfslerlffPJKBmKe/G0e7g
 w6d/HUVWFHLGlIY6k2mUlTVsIcB1GTf1i4K+3TKaSvEskTCveFXLgfxk37foqhQfDQGX
 Z/BbJu5XT32QzNspceDyXErg7L3v62WUdUffJUHarBcVB9M8PRDSwFJSCKQHWdwJ5vk+
 qBsQUDpuvoIt8dg8jaKfB2iJ6fvfypENjNr7DTTNlGnsmWqA2yWuVVTNvmydAe2H35Io
 rXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fLC8xP95XjKGKpur7tchfnAoZqhWli1WpKDNedamUH0=;
 b=VWUWjWuKDtLTYAvB3Fal2iXAtqDvMiI5mj17zZobnQK+iSzX27S0YtcDYxa1ISilYp
 GPQFCpjHtbxXvpQAaUpSEU9GODBFuOYnGyUURknrZJq8G75sCNzbGyO9Ak2pgcxuw/Ki
 7dNi3i11uejGjQNr1oJOmVPd3ejanlv8KEzE59sO80w9JKWx04I8PXi/n2NM3exmGWtV
 Rzej4gi+eSzu1oJ6JNKWARC+4FSGJfhyQB80S8b0k/g1B5w6WX+VTGnB+AhqJz9eN0+R
 FlwBhpJkeTEIrwUzs9oQcDFBQgK+RwFppdjsotZudDZtXLT0COgpZgdrw7cFxF5Frquy
 31eA==
X-Gm-Message-State: AJcUukd9J1pj4Sxm/En4YaMdKEHwDbHN1d3dCPGzD6ZyHy2HHFfEahVj
 0+yKbdUT2nqqHv6DvtsvwJs=
X-Google-Smtp-Source: ALg8bN58gxOsEGjGm2+0wNnx47qrnBxpebtsrC6ucTdhFNjQXeOGnerFIliO8eDpl/Qmnavo9Tyvbw==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1514187ljj.9.1546966391546; 
 Tue, 08 Jan 2019 08:53:11 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.gmail.com with ESMTPSA id
 k21-v6sm14229459ljc.15.2019.01.08.08.53.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Jan 2019 08:53:10 -0800 (PST)
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
Date: Tue, 08 Jan 2019 17:53:09 +0100
Message-ID: <2674227.8dsLnzbNuO@acerlaptop>
In-Reply-To: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085314_105741_8D609E59 
X-CRM114-Status: GOOD (  16.37  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5pYSBwb25pZWR6aWHFgmVrLCAzMSBncnVkbmlhIDIwMTggMTQ6MzU6NTUgQ0VUIEtyenlzenRv
ZiBLb3psb3dza2kgcGlzemU6Cj4gT24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNzoxOCwgUGF3ZcWC
IENobWllbAo+IDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+
IEZyb206IEpvbmF0aGFuIEJha2tlciA8eGMtcmFjZXIyQGxpdmUuY2E+Cj4gPgo+ID4gVGhpcyBj
b21taXQgZW5hYmxlcyBmb2xsb3dpbmcgZGV2aWNlcyBwcmVzZW50IG9uIEFyaWVzIGJhc2VkIHBo
b25lczoKPiA+IC0gcHdtLXZpYnJhdG9yIGF0dGFjaGVkIHRvIFBXTSAxCj4gPiAtIHBvd2Vyb2Zm
IHN1cHBvcnQKPiA+IC0gQXRtZWwgbWFYVG91Y2ggdG91Y2hzY3JlZW4uIEl0J3MgY29ubmVjdGVk
IHRvIGkyYzIKPiA+IC0gQnJvYWRjb20gQkNNNDMyOSBibHVldG9vdGggb3ZlciB1YXJ0MAo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEJha2tlciA8eGMtcmFjZXIyQGxpdmUuY2E+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFp
bC5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kg
fCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY4
IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvczVw
djIxMC1hcmllcy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmllcy5kdHNpCj4g
PiBpbmRleCAzNWJhMDA5YTFhMzMuLmI3MjQ2Zjg3OTY0OCAxMDA2NDQKPiA+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvczVwdjIxMC1hcmllcy5kdHNpCj4gPiBAQCAtNDEsNiArNDEsMTMgQEAKPiA+ICAgICAgICAg
ICAgICAgICB9Owo+ID4gICAgICAgICB9Owo+ID4KPiA+ICsgICAgICAgdmlicmF0b3JfcHdyOiBy
ZWd1bGF0b3ItZml4ZWQtMCB7Cj4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJyZWd1
bGF0b3ItZml4ZWQiOwo+ID4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gInZpYnJh
dG9yLWVuIjsKPiA+ICsgICAgICAgICAgICAgICBlbmFibGUtYWN0aXZlLWhpZ2g7Cj4gPiArICAg
ICAgICAgICAgICAgZ3BpbyA9IDwmZ3BqMSAxIEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gKyAgICAg
ICB9Owo+ID4gKwo+ID4gICAgICAgICB3aWZpX3B3cnNlcTogd2lmaS1wd3JzZXEgewo+ID4gICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibW1jLXB3cnNlcS1zaW1wbGUiOwo+ID4gICAgICAg
ICAgICAgICAgIHJlc2V0LWdwaW9zID0gPCZncGcxIDIgR1BJT19BQ1RJVkVfTE9XPjsKPiA+IEBA
IC0zMTQsNiArMzIxLDIyIEBACj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgz
Nj47Cj4gPiAgICAgICAgICAgICAgICAgfTsKPiA+ICAgICAgICAgfTsKPiA+ICsKPiA+ICsgICAg
ICAgdmlicmF0b3I6IHB3bS12aWJyYXRvciB7Cj4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJwd20tdmlicmF0b3IiOwo+ID4gKyAgICAgICAgICAgICAgIHB3bXMgPSA8JnB3bSAxIDQ0
NjQyIDA+Owo+ID4gKyAgICAgICAgICAgICAgIHB3bS1uYW1lcyA9ICJlbmFibGUiOwo+ID4gKyAg
ICAgICAgICAgICAgIHZjYy1zdXBwbHkgPSA8JnZpYnJhdG9yX3B3cj47Cj4gPiArICAgICAgICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiA+ICsgICAgICAgICAgICAgICBwaW5j
dHJsLTAgPSA8JnB3bTFfb3V0PjsKPiA+ICsgICAgICAgfTsKPiA+ICsKPiA+ICsgICAgICAgcG93
ZXJvZmY6IHN5c2Nvbi1wb3dlcm9mZiB7Cj4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJzeXNjb24tcG93ZXJvZmYiOwo+ID4gKyAgICAgICAgICAgICAgIHJlZ21hcCA9IDwmcG11X3N5
c2Nvbj47Cj4gPiArICAgICAgICAgICAgICAgb2Zmc2V0ID0gPDB4NjgxYz47IC8qIFBTX0hPTERf
Q09OVFJPTCAqLwo+ID4gKyAgICAgICAgICAgICAgIHZhbHVlID0gPDB4NTIwMD47Cj4gPiArICAg
ICAgIH07Cj4gPiAgfTsKPiA+Cj4gPiAgJmZpbWQgewo+ID4gQEAgLTM0Nyw2ICszNzAsMjMgQEAK
PiA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOwo+ID4gIH07Cj4gPgo+ID4gKyZpMmMyIHsKPiA+
ICsgICAgICAgc2Ftc3VuZyxpMmMtc2RhLWRlbGF5ID0gPDEwMD47Cj4gPiArICAgICAgIHNhbXN1
bmcsaTJjLW1heC1idXMtZnJlcSA9IDw0MDAwMDA+Owo+ID4gKyAgICAgICBzYW1zdW5nLGkyYy1z
bGF2ZS1hZGRyID0gPDB4MTA+Owo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7Cj4gPiArCj4g
PiArICAgICAgIHRvdWNoc2NyZWVuQDRhIHsKPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImF0bWVsLG1heHRvdWNoIjsKPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHg0YT47Cj4g
PiArICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BqMD47Cj4gPiArICAgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDw1IElSUV9UWVBFX0xFVkVMX0xPVz47Cj4gPiArICAgICAg
ICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiA+ICsgICAgICAgICAgICAgICBw
aW5jdHJsLTAgPSA8JnRzX2lycT47Cj4gPiArICAgICAgICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8
JmdwajEgMyBHUElPX0FDVElWRV9ISUdIPjsKPiA+ICsgICAgICAgfTsKPiA+ICt9Owo+ID4gKwo+
ID4gICZtZmMgewo+ID4gICAgICAgICBtZW1vcnktcmVnaW9uID0gPCZtZmNfbGVmdD4sIDwmbWZj
X3JpZ2h0PjsKPiA+ICB9Owo+ID4gQEAgLTM3Miw2ICs0MTIsMTMgQEAKPiA+ICAgICAgICAgICAg
ICAgICBzYW1zdW5nLHBpbi1kcnYgPSA8RVhZTk9TNF9QSU5fRFJWX0xWMT47Cj4gPiAgICAgICAg
IH07Cj4gPgo+ID4gKyAgICAgICBidF9ob3N0X3dha2U6IGJ0LWhvc3Qtd2FrZSB7Cj4gPiArICAg
ICAgICAgICAgICAgc2Ftc3VuZyxwaW5zID0gImdwaDItNSI7Cj4gPiArICAgICAgICAgICAgICAg
c2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJTl9GVU5DX0lOUFVUPjsKPiA+ICsgICAg
ICAgICAgICAgICBzYW1zdW5nLHBpbi1wdWQgPSA8UzNDNjRYWF9QSU5fUFVMTF9ET1dOPjsKPiA+
ICsgICAgICAgICAgICAgICBzYW1zdW5nLHBpbi1kcnYgPSA8RVhZTk9TNF9QSU5fRFJWX0xWMT47
Cj4gPiArICAgICAgIH07Cj4gPiArCj4gPiAgICAgICAgIHRmX2RldGVjdDogdGYtZGV0ZWN0IHsK
PiA+ICAgICAgICAgICAgICAgICBzYW1zdW5nLHBpbnMgPSAiZ3BoMy00IjsKPiA+ICAgICAgICAg
ICAgICAgICBzYW1zdW5nLHBpbi1mdW5jdGlvbiA9IDxFWFlOT1NfUElOX0ZVTkNfSU5QVVQ+Owo+
ID4gQEAgLTM4NCw2ICs0MzEsMTcgQEAKPiA+ICAgICAgICAgICAgICAgICBzYW1zdW5nLHBpbi1m
dW5jdGlvbiA9IDxFWFlOT1NfUElOX0ZVTkNfT1VUUFVUPjsKPiA+ICAgICAgICAgICAgICAgICBz
YW1zdW5nLHBpbi1wdWQgPSA8UzNDNjRYWF9QSU5fUFVMTF9OT05FPjsKPiA+ICAgICAgICAgfTsK
PiA+ICsKPiA+ICsgICAgICAgdHNfaXJxOiB0cy1pcnEgewo+ID4gKyAgICAgICAgICAgICAgIHNh
bXN1bmcscGlucyA9ICJncGowLTUiOwo+ID4gKyAgICAgICAgICAgICAgIHNhbXN1bmcscGluLWZ1
bmN0aW9uID0gPEVYWU5PU19QSU5fRlVOQ19JTlBVVD47Cj4gPiArICAgICAgICAgICAgICAgc2Ft
c3VuZyxwaW4tcHVkID0gPFMzQzY0WFhfUElOX1BVTExfVVA+Owo+IAo+IEl0IHNlZW1zIHRoZXJl
IGlzIGEgZGlmZmVyZW5jZSBoZXJlIGJldHdlZW4gQXJpZXMgYW5kIEZhc2NpbmF0ZS4gQXQKPiBs
ZWFzdCBpbiB2ZW5kb3Iga2VybmVsLiBPbmUgZGlzYWJsZXMgcHVsbCBhbmQgc2Vjb25kIHB1bGxz
IGRvd24uCj4gQW55d2F5IG5laXRoZXIgb2YgdGhlbSBwdWxscyBpdCB1cC4KRml4ZWQgd2l0aCBh
bGwgb3RoZXIgaXNzdWVzIGluIHYyLgpUaGFua3MKCj4gCj4gQmVzdCByZWdhcmRzLAo+IEtyenlz
enRvZgoKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
