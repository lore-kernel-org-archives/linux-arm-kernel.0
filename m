Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83258C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5DF20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EEmpdsYQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5wDxUb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5DF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xpcdNUsoh3U6mRBbX5qkR3nTcLn61by5bVNu76ziGII=; b=EEmpdsYQt+MvNw
	Ng0AgVfgjZ/D8GdANA1oTFyDbidYZ5WqYTw/6V2NzyljU95PNRqGpH9drrocmM87SNPmZbgRl48u0
	u7Hhpla5EJAbWH4o1dKtlG7W4A1NVvee+pvNwlmLacY0by/QVqOZFoZ0kRdgcajOO9I/dEr/cDC/m
	WTdjt/n4mmQFvPjBZt2v8ukZ6E9zfnBNxVMGWEYxxxVfqOpyXZCmfJEsPl/KllFP1O1OFXHZl3emL
	Pb+XLip/YLBOdYnEV0eU9sWy5AKJiMi9Rur51uGiJUV+HMqr19+RCN183o8+NrewNttOsgRmTHMmr
	5YAFXxmFv94M59oz0mqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gilps-0004g4-HV; Sun, 13 Jan 2019 19:54:20 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gilpn-0004fF-7O
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 19:54:17 +0000
Received: by mail-lf1-x144.google.com with SMTP id c16so14161877lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kl1n9kZMLL/pR3MDgjhXjOfYdfrbv9pfFnnpNgvzosQ=;
 b=Y5wDxUb+hnFON5VKKhFQpIFWP/qOHXfkKEEFqZh4/9CWFz7ZODcXt3+V5BgQ2K8Tvb
 XLOHhd3+4rcnVxURGg8kb8UwSuol9iTal1rpzjtsDtPrLCPi1cMe5B8jPDaTtZtp3jvU
 RL0zT7W4r4s6e50dEoDUUqnTMJufsiTbCKM3joo5yxlw71O+Pok0ZXmOq7/DHnsMWb9M
 ZG0g8JTM7Ruau1t2XwKMoqe5mtGICPnzjp60IUFmpP+/rCGSeClcoXDfaRWrOrTXDcIS
 L21+p/KEC63zrip3EvLsKG6QOAOwk3R0BWtSMQgLctNv4aHEvnAE1znrTI8SOj/5Ap7k
 N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kl1n9kZMLL/pR3MDgjhXjOfYdfrbv9pfFnnpNgvzosQ=;
 b=l7yyAGaneyUTIdnhMJF2ssDyNUzCgcuPYGYOLeKpqWk4e0UM7QziOZGQ32P2OdSh4/
 Gy0TYyru4QR1NNhKcuhduYvDyQYsV6Ie/TMvJtbypCy6QXSfPGSlokrDBNZqMNCxYli2
 /h9hE5kAgzpoBgGGHuJGsxI8ovOAu4Kk8D30I2JCc7d59Y6zCxWcbxOMUeQqckinBXeR
 X3+OhIaUES4i1gp9zdr0dKw+zE3CfI4VL2jyXMLoApiYIJ2FnOFzFny1GoEHvnJzDYyk
 dWT9BEhXNN1VHEiyYAChLa+h9mwupIxyEMa/4uK1RLRPLAdE/B7Atd1bXpiZx7NMej0L
 RmyA==
X-Gm-Message-State: AJcUukdGzV8508xeiY3owmyCNs0P+9p005giiqb+IhpHs7KoxIzm35v+
 izLhsVFZJcoNSKtvWGPSyOA=
X-Google-Smtp-Source: ALg8bN6AvzUBiExKCOkspyMUff6jH4rSRk/E5vby/ZYRsetyxU6aI4TSTmlQGZeyunMdHarDkd1fCA==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr11721242lfa.40.1547409250359; 
 Sun, 13 Jan 2019 11:54:10 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:607a:1b80:a32f:5413])
 by smtp.gmail.com with ESMTPSA id
 18-v6sm2212778ljg.83.2019.01.13.11.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Jan 2019 11:54:09 -0800 (PST)
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Date: Sun, 13 Jan 2019 20:54:08 +0100
Message-ID: <2003903.RuZpVZK7nJ@acerlaptop>
In-Reply-To: <20190113131624.GA2672@kozik-lap>
References: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
 <20190113131624.GA2672@kozik-lap>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_115415_300908_3623FEC1 
X-CRM114-Status: GOOD (  24.26  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gbmllZHppZWxhLCAxMyBzdHljem5pYSAyMDE5IDE0OjE2OjI0IENFVCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOgo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDA4OjQyOjQ0UE0gKzAxMDAs
IFBhd2XFgiBDaG1pZWwgd3JvdGU6Cj4gPiBUaGVyZSBpcyBwb3NzaWJpbGl0eSwgdGhhdCB3aGVu
IHByb2JpbmcgZHJpdmVyLCByZWd1bGF0b3JzIGFyZSBub3QgeWV0Cj4gPiBpbml0aWFsaXplZC4g
SW4gdGhpcyBjYXNlIHdlIHNob3VsZCByZXR1cm4gRVBST0JFX0RFRkVSIGFuZCB3YWl0IHRpbGwK
PiA+IHRoZXkncmUgaW5pdGlhbGl6ZWQsIHNpbmNlIHRoZXkncmUgcmVxdWlyZWQgY3VycmVudGx5
IGZvciBjcHVmcmVxIGRyaXZlcgo+ID4gdG8gd29yay4gQWxzbyBtb3ZlIHJlZ3VsYXRvciBpbml0
aWFsaXphdGlvbiBjb2RlIGF0IGJlZ2lubmluZyBvZiBwcm9iZSwKPiA+IHNvIHdlIGNhbiBkZWZl
ciBhcyBmYXN0IGFzIHBvc2liYmxlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2ht
aWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+IENoYW5nZXMg
ZnJvbSB2MjoKPiA+ICAgLSBIYW5kbGUgYWxsIGVycm9yIHBhdGhzIGluIHByb2JlCj4gPiAKPiA+
IENoYW5nZXMgZnJvbSB2MToKPiA+ICAgLSBGaXggY29tcGlsYXRpb24gZXJyb3IKPiA+ICAgLSBS
ZW9yZ2FuaXplIGNvZGUgc28gaXQncyBzbWFsbGVyCj4gPiAtLS0KPiA+ICBkcml2ZXJzL2NwdWZy
ZXEvczVwdjIxMC1jcHVmcmVxLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+
ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jIGIv
ZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gPiBpbmRleCBmNTE2OTdmMWUwYjMu
LjYyN2IxMzJlM2U2MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNw
dWZyZXEuYwo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gPiBA
QCAtNTg0LDcgKzU4NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgczVwdjIxMF9j
cHVmcmVxX3JlYm9vdF9ub3RpZmllciA9IHsKPiA+ICBzdGF0aWMgaW50IHM1cHYyMTBfY3B1ZnJl
cV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gIHsKPiA+ICAJc3RydWN0
IGRldmljZV9ub2RlICpucDsKPiA+IC0JaW50IGlkOwo+ID4gKwlpbnQgaWQsIHJlc3VsdCA9IDA7
Cj4gPiAgCj4gPiAgCS8qCj4gPiAgCSAqIEhBQ0s6IFRoaXMgaXMgYSB0ZW1wb3Jhcnkgd29ya2Fy
b3VuZCB0byBnZXQgYWNjZXNzIHRvIGNsb2NrCj4gPiBAQCAtNTk0LDE4ICs1OTQsNDAgQEAgc3Rh
dGljIGludCBzNXB2MjEwX2NwdWZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKPiA+ICAJICogdGhpcyB3aG9sZSBkcml2ZXIgYXMgc29vbiBhcyBTNVBWMjEwIGdldHMgbWln
cmF0ZWQgdG8gdXNlCj4gPiAgCSAqIGNwdWZyZXEtZHQgZHJpdmVyLgo+ID4gIAkgKi8KPiA+ICsJ
YXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGFybSIpOwo+ID4gKwlpZiAo
SVNfRVJSKGFybV9yZWd1bGF0b3IpKSB7Cj4gPiArCQlpZiAoUFRSX0VSUihhcm1fcmVndWxhdG9y
KSA9PSAtRVBST0JFX0RFRkVSKQo+ID4gKwkJCXByX2RlYnVnKCJ2ZGRhcm0gcmVndWxhdG9yIG5v
dCByZWFkeSwgZGVmZXJcbiIpOwo+ID4gKwkJZWxzZQo+ID4gKwkJCXByX2VycigiZmFpbGVkIHRv
IGdldCByZWd1bGF0b3IgdmRkYXJtXG4iKTsKPiA+ICsJCXJlc3VsdCA9IFBUUl9FUlIoYXJtX3Jl
Z3VsYXRvcik7Cj4gPiArCQlnb3RvIGVycl9hcm1fcmVndWxhdG9yOwo+IAo+IEp1c3QgcmV0dXJu
IGhlcmUuCkZpeGVkLgo+IAo+ID4gKwl9Cj4gPiArCj4gPiArCWludF9yZWd1bGF0b3IgPSByZWd1
bGF0b3JfZ2V0KE5VTEwsICJ2ZGRpbnQiKTsKPiA+ICsJaWYgKElTX0VSUihpbnRfcmVndWxhdG9y
KSkgewo+ID4gKwkJaWYgKFBUUl9FUlIoaW50X3JlZ3VsYXRvcikgPT0gLUVQUk9CRV9ERUZFUikK
PiA+ICsJCQlwcl9kZWJ1ZygidmRkaW50IHJlZ3VsYXRvciBub3QgcmVhZHksIGRlZmVyXG4iKTsK
PiA+ICsJCWVsc2UKPiA+ICsJCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGlu
dFxuIik7Cj4gPiArCQlyZXN1bHQgPSBQVFJfRVJSKGludF9yZWd1bGF0b3IpOwo+ID4gKwkJZ290
byBlcnJfaW50X3JlZ3VsYXRvcjsKPiA+ICsJfQo+ID4gKwo+ID4gIAlucCA9IG9mX2ZpbmRfY29t
cGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJzYW1zdW5nLHM1cHYyMTAtY2xvY2siKTsKPiA+ICAJ
aWYgKCFucCkgewo+ID4gIAkJcHJfZXJyKCIlczogZmFpbGVkIHRvIGZpbmQgY2xvY2sgY29udHJv
bGxlciBEVCBub2RlXG4iLAo+ID4gIAkJCV9fZnVuY19fKTsKPiA+IC0JCXJldHVybiAtRU5PREVW
Owo+ID4gKwkJcmVzdWx0ID0gLUVOT0RFVjsKPiA+ICsJCWdvdG8gZXJyX2Nsb2NrOwo+ID4gIAl9
Cj4gPiAgCj4gPiAgCWNsa19iYXNlID0gb2ZfaW9tYXAobnAsIDApOwo+ID4gIAlvZl9ub2RlX3B1
dChucCk7Cj4gPiAgCWlmICghY2xrX2Jhc2UpIHsKPiA+ICAJCXByX2VycigiJXM6IGZhaWxlZCB0
byBtYXAgY2xvY2sgcmVnaXN0ZXJzXG4iLCBfX2Z1bmNfXyk7Cj4gPiAtCQlyZXR1cm4gLUVGQVVM
VDsKPiA+ICsJCXJlc3VsdCA9IC1FRkFVTFQ7Cj4gPiArCQlnb3RvIGVycl9jbG9jazsKPiA+ICAJ
fQo+ID4gIAo+ID4gIAlmb3JfZWFjaF9jb21wYXRpYmxlX25vZGUobnAsIE5VTEwsICJzYW1zdW5n
LHM1cHYyMTAtZG1jIikgewo+ID4gQEAgLTYxNCw3ICs2MzYsOCBAQCBzdGF0aWMgaW50IHM1cHYy
MTBfY3B1ZnJlcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gIAkJCXBy
X2VycigiJXM6IGZhaWxlZCB0byBnZXQgYWxpYXMgb2YgZG1jIG5vZGUgJyVwT0ZuJ1xuIiwKPiA+
ICAJCQkJX19mdW5jX18sIG5wKTsKPiA+ICAJCQlvZl9ub2RlX3B1dChucCk7Cj4gPiAtCQkJcmV0
dXJuIGlkOwo+ID4gKwkJCXJlc3VsdCA9IGlkOwo+ID4gKwkJCWdvdG8gZXJyX2Nsa19iYXNlOwo+
ID4gIAkJfQo+ID4gIAo+ID4gIAkJZG1jX2Jhc2VbaWRdID0gb2ZfaW9tYXAobnAsIDApOwo+ID4g
QEAgLTYyMiwzMyArNjQ1LDQwIEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgCQkJcHJfZXJyKCIlczogZmFpbGVkIHRv
IG1hcCBkbWMlZCByZWdpc3RlcnNcbiIsCj4gPiAgCQkJCV9fZnVuY19fLCBpZCk7Cj4gPiAgCQkJ
b2Zfbm9kZV9wdXQobnApOwo+ID4gLQkJCXJldHVybiAtRUZBVUxUOwo+ID4gKwkJCXJlc3VsdCA9
IC1FRkFVTFQ7Cj4gPiArCQkJZ290byBlcnJfZG1jOwo+ID4gIAkJfQo+ID4gIAl9Cj4gPiAgCj4g
PiAgCWZvciAoaWQgPSAwOyBpZCA8IEFSUkFZX1NJWkUoZG1jX2Jhc2UpOyArK2lkKSB7Cj4gPiAg
CQlpZiAoIWRtY19iYXNlW2lkXSkgewo+ID4gIAkJCXByX2VycigiJXM6IGZhaWxlZCB0byBmaW5k
IGRtYyVkIG5vZGVcbiIsIF9fZnVuY19fLCBpZCk7Cj4gPiAtCQkJcmV0dXJuIC1FTk9ERVY7Cj4g
PiArCQkJcmVzdWx0ID0gLUVOT0RFVjsKPiA+ICsJCQlnb3RvIGVycl9kbWM7Cj4gPiAgCQl9Cj4g
PiAgCX0KPiA+ICAKPiA+IC0JYXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZk
ZGFybSIpOwo+ID4gLQlpZiAoSVNfRVJSKGFybV9yZWd1bGF0b3IpKSB7Cj4gPiAtCQlwcl9lcnIo
ImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Cj4gPiAtCQlyZXR1cm4gUFRSX0VS
Uihhcm1fcmVndWxhdG9yKTsKPiA+IC0JfQo+ID4gLQo+ID4gLQlpbnRfcmVndWxhdG9yID0gcmVn
dWxhdG9yX2dldChOVUxMLCAidmRkaW50Iik7Cj4gPiAtCWlmIChJU19FUlIoaW50X3JlZ3VsYXRv
cikpIHsKPiA+IC0JCXByX2VycigiZmFpbGVkIHRvIGdldCByZWd1bGF0b3IgdmRkaW50XG4iKTsK
PiA+IC0JCXJlZ3VsYXRvcl9wdXQoYXJtX3JlZ3VsYXRvcik7Cj4gPiAtCQlyZXR1cm4gUFRSX0VS
UihpbnRfcmVndWxhdG9yKTsKPiA+IC0JfQo+ID4gLQo+ID4gIAlyZWdpc3Rlcl9yZWJvb3Rfbm90
aWZpZXIoJnM1cHYyMTBfY3B1ZnJlcV9yZWJvb3Rfbm90aWZpZXIpOwo+ID4gIAo+ID4gIAlyZXR1
cm4gY3B1ZnJlcV9yZWdpc3Rlcl9kcml2ZXIoJnM1cHYyMTBfZHJpdmVyKTsKPiA+ICsKPiA+ICtl
cnJfZG1jOgo+ID4gKwlmb3IgKGlkID0gMDsgaWQgPCBBUlJBWV9TSVpFKGRtY19iYXNlKTsgKytp
ZCkKPiA+ICsJCWlmIChkbWNfYmFzZVtpZF0pCj4gPiArCQkJaW91bm1hcChkbWNfYmFzZVtpZF0p
Owo+IAo+IFlvdSB3aWxsIGlvdW5tYXAgdGhlIHNhbWUgcG9pbnRlciB0d2ljZSwgaWYgZmlyc3Qg
ZGV2aWNlIGJpbmQgZmFpbGVkCj4gd2hpbGUgZm9sbG93aW5nIHRoaXMgZXJyb3IgcGF0aCBhbmQg
c29tZW9uZSB0cmllcyB0byBiaW5kIHNlY29uZCB0aW1lCj4gKGFnYWluIHdpdGggZXJyb3IgbGVh
ZGluZyB0byB0aGlzIGVycm9yIHBhdGgpLiBZb3UgemVybyB0aGUgcG9pbnRlcgo+IGVpdGhlciBh
dCBiZWdpbm5pbmcgb2YgcHJvYmUgb3IgYWZ0ZXIgaW91bm1hcHBpbmcuCkdvb2QgY2F0Y2gsIGFs
c28gZml4ZWQgaW4gdjQuClRoYW5rcwo+IAo+IEJlc3QgcmVnYXJkcywKPiBLcnp5c3p0b2YKPiAK
PiAKPiA+ICsKPiA+ICtlcnJfY2xrX2Jhc2U6Cj4gPiArCWlvdW5tYXAoY2xrX2Jhc2UpOwo+ID4g
Kwo+ID4gK2Vycl9jbG9jazoKPiA+ICsJcmVndWxhdG9yX3B1dChpbnRfcmVndWxhdG9yKTsKPiA+
ICsKPiA+ICtlcnJfaW50X3JlZ3VsYXRvcjoKPiA+ICsJcmVndWxhdG9yX3B1dChhcm1fcmVndWxh
dG9yKTsKPiA+ICsKPiA+ICtlcnJfYXJtX3JlZ3VsYXRvcjoKPiA+ICsKPiA+ICsJcmV0dXJuIHJl
c3VsdDsKPiA+ICB9Cj4gPiAgCj4gPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgczVw
djIxMF9jcHVmcmVxX3BsYXRkcnYgPSB7Cj4gCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
