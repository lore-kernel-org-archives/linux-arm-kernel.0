Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:11:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD70E20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBOPs0re";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiYH4mem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70E20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W7LT4gRPeE4VqHzjNY580hEcotu1as3zWACIol75trw=; b=eBOPs0reNUWleM
	Sn9Y0zgolYuLiYeFre+4Qn3PrLKGnF9YzAq1e0WxuawhNhSExfApEjjCfw+w+5y8/5ek7dWXZkSF4
	XB9VoTlkiIVRzSuCE8+cQFUHLankc4b9hWmbUkq/xydpSvc4qz5gP06ofKfdscn1Ty+NnbU9yK58y
	DGCp2XUQEpBSKlDrnzptxbmAWVAueKByIXCh5G72iv23x1myiwflfo/Siwawt3ccYNyexZ543WyK1
	pM48Y0Wfvcy2XV2jOHKbwmQgGHaG5Y1BQCgp1ZSn42+2I3PdILs6KHY4HGLTsWMvFNgMsQadyJkfB
	JVgrZ+6E53UyCtsNKjMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQjB-00012S-Fu; Wed, 20 Feb 2019 12:11:53 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQj8-000116-A4
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:11:51 +0000
Received: by mail-it1-x141.google.com with SMTP id f10so14617314ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 04:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dLw4WUelbqeA5gxnBRVLXKdQXBLEm4+dKDfbIGRV0i4=;
 b=fiYH4mem/AEvxzlKK7yL8uEPw0VSQCU5mhgnIzGRDrCIY9DH+My3sXq3ldDGCwJfXB
 3RPFlDBitLlcy99lbnf45HsMTd+TnSKabP0sXuhUL3pFlOQBJ4v5ywjtc+KO8ZGNy/pu
 SsMzm7wInSWVN9LLe23T6Xx6jytEUw5NOdZfv52mBaBLXZdr+ryp2mrZGLWNMQMoJmkv
 MzziBObLFPOLnM3+XCbQdLtxXEe+RJkRRqLPAEj67juuZS43caaVLSt3t+l7BSui2xXS
 fPo+bxrDFFJ/RdCV7D+2aWz5WRxLTONjz7riRHf0wRJ3ofAJlT4MeIsgYTkkjhmsCYSw
 AdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dLw4WUelbqeA5gxnBRVLXKdQXBLEm4+dKDfbIGRV0i4=;
 b=qweSQxPVJz8Iu+WO2yMvUPMYhOcPAHik4nMfB8yvVY+aZs7j/qu5JegIaHmhyl/ASp
 QDJ85/2D0ayEln9lcf6qbCHoMo5fyyxpkyxYk2Jh3ynCJtMHn9GHpCffOwd7JGHZ05Q7
 rWVQad7C40NCEzHLVPZA/jHp0WKfoMO09wRR6LxkidV8pfaO1ATd90if/WRryUi9qOLX
 9VdQHhU4NDIEI7mA9JhF7hVdv0M2tkKyV2DbDJLmRxtDr1xV5S6/2L7hVKW3cGiW1+5v
 g6n6h0dPZ4wvCZJz4yVXibOn8NO7N9pTXCnHsExINqQMZYmOtBxFWFd408bwTPgFGPWq
 LGPA==
X-Gm-Message-State: AHQUAuaQ1JtBK2QZmCmnobTpGqWJUFd+B1D7C/KgAyi+UQgU9a3yaunC
 JdaRMjRCyio7HOtWP7MpZ/z8TGazD+b2GpnRzB4=
X-Google-Smtp-Source: AHgI3IbDS69mZr7hDXSjll5mCC6Ybp6rHPO8ckL+Q6fJNhWjwzYqshJ6sp76AQbkwGdk4tdMq5m6eX8x54L1nc5MnjM=
X-Received: by 2002:a02:187:: with SMTP id 7mr18891910jak.115.1550664709137;
 Wed, 20 Feb 2019 04:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-3-gregory.clement@bootlin.com>
 <8bc7bfcf-ad04-0615-1735-c2bbf20b7861@mleia.com>
 <87o97d2fyg.fsf@FE-laptop>
In-Reply-To: <87o97d2fyg.fsf@FE-laptop>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Date: Wed, 20 Feb 2019 07:11:39 -0500
Message-ID: <CA+rxa6qbk49J8X3Ph81naXEKWWDUH_0h7uJfC0KOFOoTvEW=9w@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: lpc32xx-adc: Document
 vref-supply
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_041150_369136_763E5A22 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCk9uIEZyaSwgRmViIDE1LCAyMDE5IGF0IDExOjA3IEFNIEdyZWdvcnkgQ0xF
TUVOVAo8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPiB3cm90ZToKPgo+IEhpIFZsYWRpbWly
LAo+Cj4gIE9uIHNhbS4sIGbDqXZyLiAwOSAyMDE5LCBWbGFkaW1pciBaYXBvbHNraXkgPHZ6QG1s
ZWlhLmNvbT4gd3JvdGU6Cj4KPiA+IEhpIEdyZWdvcnksCj4gPgo+ID4gT24gMDIvMDgvMjAxOSAw
NjowOSBQTSwgR3JlZ29yeSBDTEVNRU5UIHdyb3RlOgo+ID4+IEFzIG1vc3Qgb2YgdGhlIG90aGVy
IEFEQyB0aGUgbHBjMzJ4eCBvbmUgdXNlIGEgdnJlZi1zdXBwbHkgcHJvcGVydHk6Cj4gPj4gZG9j
dW1lbnQgaXQuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdv
cnkuY2xlbWVudEBib290bGluLmNvbT4KPiA+PiAtLS0KPiA+PiAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbHBjMzJ4eC1hZGMudHh0IHwgNSArKysrKwo+ID4+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPj4KWy4uLl0KPiA+Pgo+ID4KPiA+IEkg
a2luZGx5IGFzayB5b3UgdG8gaW5jbHVkZSBtZSB0byBUbzogbGlzdCwgaWYgeW91IHNlbmQgYW5v
dGhlciBjaGFuZ2VzIGZvcgo+ID4gTlhQIExQQzMyeHggcGxhdGZvcm0uCj4KPiBZZXMgc3VyZSEg
SSB3cm9uZ2x5IG9ubHkgdXNlIHRoZSBmaXJzdCBsaW5lcyBwcm92aWRlZCBieQo+IC4vc2NyaXB0
cy9nZXRfbWFpbnRhaW5lci5wbCwgSSB3aWxsIGluY2x1ZGUgeW91IGluIHRoZSBuZXh0IHZlcnNp
b24uCj4KClBsZWFzZSBhbHNvIGluY2x1ZGUgbXlzZWxmIGluIHRoZSBuZXh0IExQQzMyeHggcmVs
YXRlZCBwYXRjaGVzLgoKUmVnYXJkcywKU3lsdmFpbgo+Cj4gVGhhbmtzLAo+Cj4gR3JlZ29yeQo+
Cj4KPgo+ID4KPiA+IFRoYW5rIHlvdS4KPiA+Cj4gPiAtLQo+ID4gQmVzdCB3aXNoZXMsCj4gPiBW
bGFkaW1pcgo+ID4KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+ID4gbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPgo+IC0tCj4gR3JlZ29yeSBDbGVtZW50
LCBCb290bGluCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwo+IGh0dHA6
Ly9ib290bGluLmNvbQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
