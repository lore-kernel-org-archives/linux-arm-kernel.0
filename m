Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A891C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:05:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4A1217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPiVJZBu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XMqVGmZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4A1217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hU6kY77NZ2pJAnBJ8iK1tvA++sffyYqCL1qY3MJzWms=; b=dPiVJZBugaKyU4
	oF+orjKJu79nwyfqhuz0/0usWlPP5xWsxT+2dVz6ZzhcildWKP+qNkrz+4fXfe2Mtj2sm8VFZykeY
	2MwNsQof3nnupIzCHDgZriI7udPRRF7cPmQcFq8rZzLBqiRZi5chtuYTbT4fMtKADlBwnvDbuK9Iw
	DCOpFskGr0NJ82QmE3EnViPflMe034vOyzkh5Ti6sHjt8EJxSFI261HHJs7+T/p/Vlr2xWlHwSVeW
	dPWrWbxT25dBGP/s3rqJA77Wsk+BKGeduv9+lkyY6PObWyXEtsL+8B1UnFzjeMhyw+WtiBsBwNbO8
	W5sa6R9e/88Mjo21se0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grPhl-0007HE-3M; Wed, 06 Feb 2019 16:05:41 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grPhh-0007Gs-Uv
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 16:05:39 +0000
Received: by mail-ot1-x341.google.com with SMTP id s5so12725579oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 08:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BRasMPhGGvVcUjviLM/RkN7sAw+YGjuSsPmXk6RADdk=;
 b=XMqVGmZjkdxW0UiqrMch5rN+5dD3JDwYq8fYB5HNVL9wT2BeUVfuKfpgSrqU0VyoZA
 c0p7ZjzudAt2SPBTvYnCfch6nqyATa+Nr9oTpKi5l+Gd1WBHC/8DMF5PDgFEQftVQT2e
 wyb6LPK5HKCXrsQKvUjA/UGiiaayuxewpGp2dWKUXzGpOt6ANKBaiA8D8Yvac5iNszf5
 xL646tjw+v9JsqWyf9x5Y2N+zDqiBgrhoLHnD6smxqeMDdS3xYLawbndB/YBgzHDifKg
 OK1iT99sexw9zQjtgWk/tTemtUX1dfAXI9Gt+kEkQBJpz2bBbBiqRbXf7D9Vj7AyUb6a
 mfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BRasMPhGGvVcUjviLM/RkN7sAw+YGjuSsPmXk6RADdk=;
 b=SAY+n7rz2f+fMcp67zzohV4EBRV8TEfU3gxlzsATvqdoKWhNXds5Q4uHZyVu/ONQ8V
 rFlcDZS8IKosC3N3/I1J3TlA61T8fIcFBjo98bZWIC3ZFgElWeoYXQoroED8v1dqOm0i
 7nXO46Y8nc7D8S33z8ja237eaesutHeODuW6zH67/61ebha2nie+uYw8zkvPTPL0j/sk
 /X7UWGP5dYKJJe+mR0SEzj+p9ef17vJG8hKMhb8y16GK8cMHMz01asGaZWbGeexeK491
 vC0b9w9XpYwD8FCwU8DcBHftq6D5zjaIOPAbhxjawMZrSMQsVDbA2p6t7jFd/b6bHPMo
 /v7A==
X-Gm-Message-State: AHQUAuaquxSgDl8vV9L13CVi1R1Su+HoueSQ8hhVJlnwVB3bT6WFjZRr
 xU3YRBY2CBD7n87NTFRAzIwuD3ptJbR7Q2NiUKSc6g==
X-Google-Smtp-Source: AHgI3IbFsjeiu1240gilRtvcjOMwNsF/WnMINB28oVrlkzVFI2ZEuwbCpeZnZhRRMnguC6bT/wtgitRVYSH8CIvP+eA=
X-Received: by 2002:a54:4491:: with SMTP id v17mr24011oiv.147.1549469136691;
 Wed, 06 Feb 2019 08:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-14-linus.walleij@linaro.org>
In-Reply-To: <20190203214205.13594-14-linus.walleij@linaro.org>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 6 Feb 2019 17:05:25 +0100
Message-ID: <CAMpxmJUNf9WBAaNTdmkps5fMSUbTm3Jzw=NeELim5PFZ-zb0yQ@mail.gmail.com>
Subject: Re: [PATCH 13/17 v1] gpio: ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_080537_995790_2EE720B6 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: linux-devicetree <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Tim Harvey <tharvey@gateworks.com>,
 Krzysztof Halasa <khalasa@piap.pl>, Olof Johansson <olof@lixom.net>,
 Imre Kaloz <kaloz@openwrt.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

bmllZHouLCAzIGx1dCAyMDE5IG8gMjI6NDIgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBs
aW5hcm8ub3JnPiBuYXBpc2HFgihhKToKPgo+IFRoaXMgYWRkcyBEVCBiaW5kaW5ncyBmb3IgdGhl
IElYUDR4eCBHUElPIGNvbnRyb2xsZXIuCj4KPiBDYzogQmFydG9zeiBHb2xhc3pld3NraSA8Ymdv
bGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcK
PiBTaWduZWQtb2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+
Cj4gLS0tCj4gQmFydG9zejogbG9va2luZyBmb3IgeW91ciBBQ0sgb24gdGhpcywgaXQnZCBiZSBn
b29kIGlmCj4gdGhlIG90aGVyIEdQSU8gbWFpbnRhaW5lciBpcyBhbGlnbmVkIHdpdGggbXkgaWRl
YXMgaGVyZS4KPiBJIGludGVuZCB0byBtZXJnZSB0aGlzIHRocm91Z2ggdGhlIEFSTSBTb0MgdHJl
ZS4KPiAtLS0KPiAgLi4uL2JpbmRpbmdzL2dwaW8vaW50ZWwsaXhwNHh4LWdwaW8udHh0ICAgICAg
IHwgMzggKysrKysrKysrKysrKysrKysrKwo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9u
cygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2dwaW8vaW50ZWwsaXhwNHh4LWdwaW8udHh0Cj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vaW50ZWwsaXhwNHh4LWdwaW8udHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vaW50ZWwsaXhwNHh4LWdwaW8udHh0
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMDAuLjhkYzQxZWQ5OTY4
NQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZ3Bpby9pbnRlbCxpeHA0eHgtZ3Bpby50eHQKPiBAQCAtMCwwICsxLDM4IEBACj4gK0ludGVs
IElYUDR4eCBYU2NhbGUgTmV0d29ya2luZyBQcm9jZXNzb3JzIEdQSU8KPiArCj4gK1RoaXMgR1BJ
TyBjb250cm9sbGVyIGlzIGZvdW5kIGluIHRoZSBJbnRlbCBJWFA0eHggcHJvY2Vzc29ycy4KPiAr
SXQgc3VwcG9ydHMgMTYgR1BJTyBsaW5lcy4KPiArCj4gK1RoZSBpbnRlcnJ1cHQgcG9ydGlvbnMg
b2YgdGhlIEdQSU8gY29udHJvbGxlciBpcyBoaWVyYXJjaGljYWw6Cj4gK3RoZSBzeW5jaHJvbm91
cyBlZGdlIGRldGVjdG9yIGlzIHBhcnQgb2YgdGhlIEdQSU8gYmxvY2ssIGJ1dCB0aGUKPiArYWN0
dWFsIGVuYWJsaW5nL2Rpc2FibGluZyBvZiB0aGUgaW50ZXJydXB0IGxpbmUgaXMgZG9uZSBpbiB0
aGUKPiArbWFpbiBJWFA0eHggaW50ZXJydXB0IGNvbnRyb2xsZXIgd2hpY2ggaGFzIGEgMToxIG1h
cHBpbmcgZm9yCj4gK3RoZSBmaXJzdCAxMiBHUElPIGxpbmVzIHRvIDEyIHN5c3RlbSBpbnRlcnJ1
cHRzLgo+ICsKPiArVGhlIHJlbWFpbmluZyA0IEdQSU8gbGluZXMgY2FuIG5vdCBiZSB1c2VkIGZv
ciByZWNlaXZpbmcKPiAraW50ZXJydXB0cy4KPiArCj4gK1RoZSBpbnRlcnJ1cHQgcGFyZW50IG9m
IHRoaXMgR1BJTyBjb250cm9sbGVyIG11c3QgYmUgdGhlCj4gK0lYUDR4eCBpbnRlcnJ1cHQgY29u
dHJvbGxlci4KPiArCj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6Cj4gKwo+ICstIGNvbXBhdGlibGUg
OiBTaG91bGQgYmUKPiArICAiaW50ZWwsaXhwNHh4LWdwaW8iCj4gKy0gcmVnIDogU2hvdWxkIGNv
bnRhaW4gcmVnaXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgKPiArLSBncGlvLWNvbnRyb2xsZXIg
OiBtYXJrcyB0aGlzIGFzIGEgR1BJTyBjb250cm9sbGVyCj4gKy0gI2dwaW8tY2VsbHMgOiBTaG91
bGQgYmUgMiwgc2VlIGdwaW8vZ3Bpby50eHQKPiArLSBpbnRlcnJ1cHQtY29udHJvbGxlciA6IG1h
cmtzIHRoaXMgYXMgYW4gaW50ZXJydXB0IGNvbnRyb2xsZXIKPiArLSAjaW50ZXJydXB0LWNlbGxz
IDogYSBzdGFuZGFyZCB0d28tY2VsbCBpbnRlcnJ1cHQsIHNlZQo+ICsgIGludGVycnVwdC1jb250
cm9sbGVyL2ludGVycnVwdHMudHh0Cj4gKwo+ICtFeGFtcGxlOgo+ICsKPiArZ3BpbzA6IGdwaW9A
YzgwMDQwMDAgewo+ICsgICAgICAgY29tcGF0aWJsZSA9ICJpbnRlbCxpeHA0eHgtZ3BpbyI7Cj4g
KyAgICAgICByZWcgPSA8MHhjODAwNDAwMCAweDEwMDA+Owo+ICsgICAgICAgZ3Bpby1jb250cm9s
bGVyOwo+ICsgICAgICAgI2dwaW8tY2VsbHMgPSA8Mj47Cj4gKyAgICAgICBpbnRlcnJ1cHQtY29u
dHJvbGxlcjsKPiArICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47Cj4gK307Cj4gZGlmZiAt
LWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiBpbmRleCA3NzVhNjIzZGM5MWQuLjU3
ZDA5OGI4NTUyMyAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+ICsrKyBiL01BSU5UQUlORVJT
Cj4gQEAgLTE2NTAsNiArMTY1MCw3IEBAIE06ICAgICAgICBJbXJlIEthbG96IDxrYWxvekBvcGVu
d3J0Lm9yZz4KPiAgTTogICAgIEtyenlzenRvZiBIYWxhc2EgPGtoYWxhc2FAcGlhcC5wbD4KPiAg
TDogICAgIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZv
ciBub24tc3Vic2NyaWJlcnMpCj4gIFM6ICAgICBNYWludGFpbmVkCj4gK0Y6ICAgICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9pbnRlbCxpeHA0eHgtZ3Bpby50eHQKPiAg
RjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9pbnRlbCxpeHA0eHgtaW50ZXJydXB0LnR4dAo+ICBGOiAgICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ludGVsLGl4cDR4eC10aW1lci50eHQKPiAgRjogICAg
IGFyY2gvYXJtL21hY2gtaXhwNHh4Lwo+IC0tCj4gMi4yMC4xCj4KCkxvb2tzIGdvb2QgdG8gbWUu
CgpSZXZpZXdlZC1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJl
LmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
