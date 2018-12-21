Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FDCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376F221908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgPMlnKk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="brq2M/bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376F221908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3lIYyJtE9TI2+HdRkKKr4Br00ehNUvGQnrZXAHO/juk=; b=YgPMlnKkG5iPne
	q14p4s/07qR8/nRjbCI1R5z/uAoonO/DPb5UTV5GD1gHe3EMRyzv8TowvxE9D4EwWe7JkWZx5vzc2
	DmttvkuLGqBKwRf3x/HlT/OSCQYOKnJbA40cK8GrwY4McAhGChQN6rDeKR/WifJAwP5IUaKviU3j/
	f/5t3C4TT+kjON688sTOeJi/yNo2or3a1xaed1lw4PgAK2Q72AUcPusO0JhgFJB8aQn1RK6oGFmTc
	OA/h6mzQLRtVgesZEqLYvzDlVh810qkLsszsfnuUi/ZMU8BUgnLUbG23C7Vs1Jcf+DO+lL40PQ357
	Pg6570bSAlJzOKPv7NnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHZ9-0005i2-6N; Fri, 21 Dec 2018 09:57:59 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHZ4-0005eb-6Y
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:57:57 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so4557899wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 01:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Sz0lxES7TaheVKAL2ppstqONJM4+9+minfzfMKS9Y9g=;
 b=brq2M/bFEyL07SlcTy+1qRY7AJvyEg7vsOCWwzb4fxCoD5W7INij/AJRBId1DEDL7S
 GnN/n6gq5vL7mlDbs0HY0n5Co8VWAq2HZRibvEYpW2g5N1T6nZnzJuiFWGBth9SBJPLr
 EjIlh/2TeS5Xjd9/+EooCT1TaJUaap0Y09s6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Sz0lxES7TaheVKAL2ppstqONJM4+9+minfzfMKS9Y9g=;
 b=s3en/PHE3/3ehUxWkVMllnDaMG24EoUBHz9xsmKO350eZhT20qTWHVSf6qJ9Iri+c/
 +waZcmaAqgzgOhST863hDX56zqzG5+nU/i7qpRMdoCrM0D9a+oy+TrxEmbIvvvNficPN
 sxY+hr9VZPsOpvO1T6JvGnV1Eq7xdFBS4tdA5lqKOm4gP8VyshVO4SeaNG56S7H3TsJm
 tLz3jC2A50EK47pmL0OaFEUYynL0Y+FBwUv9sP0ZgeiYc1FDhidED8Okl8I+EzasLooZ
 A2TVg7rQkv1mhmj3wctl2EpkTU953fIumgUHSoulKlm2ZlLD+j0fdCFWL5UI4qrJ3jol
 +cfA==
X-Gm-Message-State: AJcUukflOOM2M8xsI0l1XAflzy4nbVrhEVdHl/E6SbQ/s02HiZp11jHC
 fo8U+rp/u9/Fklouesy6ci5YgA==
X-Google-Smtp-Source: ALg8bN4YUleL4n7dqCj5bUduXwKyUJS9FQ2QiVECC3o0StfxEq7v0376pnoFSKuzhKTarLb3XAOZlw==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr1874763wrm.115.1545386262356; 
 Fri, 21 Dec 2018 01:57:42 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id d4sm7997626wmb.25.2018.12.21.01.57.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 01:57:41 -0800 (PST)
Date: Fri, 21 Dec 2018 09:57:40 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221095740.GF13248@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
 <20181221092658.GB13248@dell>
 <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_015754_241737_B73B0A9E 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKCj4gT24gRnJpLCBEZWMgMjEs
IDIwMTggYXQgMDk6MjY6NThBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gRnJpLCAy
MSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKPiA+IAo+ID4gPiBPbiBGcmksIERlYyAyMSwg
MjAxOCBhdCAwODozOToyN0FNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+ID4gT24gVHVl
LCAxMSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiA+IEZyb206
IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBzY2hpbmFnbC5ubD4KPiA+ID4gPiA+IAo+ID4gPiA+
ID4gVGhlIGN1cnJlbnQgYXhwMjB4IG5hbWVzIHRoZSByYW1waW5nIHJlZ2lzdGVyICdzY2FsJyB3
aGljaCBwcm9iYWJseQo+ID4gPiA+ID4gbWVhbnMgc2NhbGluZy4gU2luY2UgdGhlIHJlZ2lzdGVy
IHJlYWxseSBoYXMgbm90aGluZyB0byBkbyB3aXRoCj4gPiA+ID4gPiBzY2FsaW5nLCBidXQgcmVh
bGx5IGlzIHRoZSB2b2x0YWdlIHJhbXAgd2UgcmVuYW1lIGl0IGFwcHJvcHJpYXRlbHkuCj4gPiA+
ID4gPiAKPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBz
Y2hpbmFnbC5ubD4KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFByaWl0IExhZXMgPHBsYWVzQHBs
YWVzLm9yZz4KPiA+ID4gPiA+IEFja2VkLWZvci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9h
eHAyMHguaCB8IDQgKystLQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gSSd2ZSBsb3N0IHRyYWNrIG9mIHdo
YXQncyBoYXBwZW5pbmcgd2l0aCB0aGlzIHNldCBub3cuCj4gPiA+ID4gCj4gPiA+ID4gTWFyaywK
PiA+ID4gPiAKPiA+ID4gPiBEaWQgeW91IHRha2UgdGhpcyBwYXRjaCBpbiB0aGUgZW5kPwo+ID4g
PiAKPiA+ID4gWWVzLCB0aGlzIGlzIGluIGxpbnV4LW5leHQuCj4gPiAKPiA+IEkgaGF2ZSBubyBp
ZGVhIHdoeSBNYXJrJ3MgdHJhY2tlciBpc24ndCBtYWlsaW5nIG1lICh0aGlzIGlzIG5vdCB0aGUK
PiA+IGZpcnN0IHRpbWUgdGhpcyBoYXMgaGFwcGVuZWQpLgo+ID4gCj4gPiBDb3VsZCB5b3UgcGxl
YXNlIHJlYmFzZSB0aGlzIHNldCBhbmQgcmVzdWJtaXQgYWxsIG9mIHRoZSBwYXRjaGVzIHdoaWNo
Cj4gPiBoYXZlIG5vdCB5ZXQgYmVlbiBhcHBsaWVkPwo+IAo+IFdob2xlIHNlcmllIGhhcyBiZWVu
IGFwcGxpZWQuCgpXZWxsIHRoYXQgc2F2ZXMgbWUgYSBqb2IuICBUaGFua3MuICA9Oi0pCgotLSAK
TGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5h
cm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFy
bzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
