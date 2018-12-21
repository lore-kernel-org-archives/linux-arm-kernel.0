Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE16C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABEC218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KX7Xp5Ba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGjDQnP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABEC218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEtMP1Cl9UwXW1AFvgANGw400T1Q1P0oTt+7G1R+3WI=; b=KX7Xp5BaGwwZm7
	8/CBDy6s9yEkpA5Z6/4l/WOiIoVCuQqJJ5sM39evnpfzCFOsBf5I3tt5Ta4APb0pAXmHpCfRguhqD
	kmqsb8TaDbwkFUJvnelNssJ8CdpnzGFXC/zg1CKH9tZ+643Cc3mj2lPM0wuN1hd4F8dOoMozJYon4
	w/qZb/MUTsQBc+A7B0APkAWxz0wf8otSejHL7Fer8AOl+4KizEnr2E/ckjFZ3eCSBQamsLrUP251A
	7pCsqed8u78W16rebK11j1PoXtJbZiAUml78eFAa/Jq5jawrNiNiHUiE+BEC795qfPNMIMKbKSisf
	pJOquY1J5tjgrNAxNxFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaH5P-0001ao-Mw; Fri, 21 Dec 2018 09:27:15 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaH5N-0001Zm-6k
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:27:14 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so4611211wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 01:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=bIkpx3d0jT0gZmqfZ9C/hqI/Rmmvfn2emL3mxbUxJms=;
 b=BGjDQnP/v/l4Nf1mI1ZV5c7V6b2v4K4ElI5jbiBOiIkk2/yHTv0LyzgKkV0KEKstoN
 E6W5T0G7FKRFUNLUIsiI7dOpqfTm4FrpCh1mO4lt5MLKSbZt0LKxRp/P9hSGG5p+Zciu
 QxVmF6WiuRhFUEzFR4WguDOlcGeyhED3StjHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=bIkpx3d0jT0gZmqfZ9C/hqI/Rmmvfn2emL3mxbUxJms=;
 b=XLSOF50rmK+SSaNHNPJ7K5UFo0pqGkEBre+SE0x9KeetmWsMdHJO7gqEjQX4e3MT3T
 Zz27Bdg8nSHVMSSFQ3y0dED2nRYTXf4B8/JlYLiGcsiv6Dz2MldPCgFcd9PBdP00qey3
 oy0LSHG4Ce580sP+uAvdiUKimO/wgcvFcb8Ec1nXtpzJhpbDH4iWeovPnG1cprTiuRg9
 OPMnjd+2NVto30Yg94pKvLFKW12YWrPkSOb7X6JOWkYtsOcDmtLPW1qzvVpBRMvLCtzn
 QJKZ28x4vwxYGTTKB8vDPYHJvORwqDtLFOeOd1oQRGsjE6g1vpjyQbAfYt+ppWqFova0
 mNXw==
X-Gm-Message-State: AA+aEWbAx9y+1J/5UzRR8qK7dJohtnDH03Ic9DW6BDz1cGa31TCkq66B
 hYpVmoaD8HB7U1FOdtWS/ARWiw==
X-Google-Smtp-Source: AFSGD/VZ28A7uEqB515CFVQRUKLayev3Hpp7QcdWYdsW5uMJYolZOb9ZiM7u71IrsCqMP6DE0iMmpA==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr2010592wmi.24.1545384421312; 
 Fri, 21 Dec 2018 01:27:01 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id l20sm23189477wrb.93.2018.12.21.01.26.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 01:27:00 -0800 (PST)
Date: Fri, 21 Dec 2018 09:26:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221092658.GB13248@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221084246.myrtv6n4jrv6lajl@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_012713_246606_DE840F9C 
X-CRM114-Status: GOOD (  20.60  )
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
IDIwMTggYXQgMDg6Mzk6MjdBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gVHVlLCAx
MSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKPiA+IAo+ID4gPiBGcm9tOiBPbGxpdmVyIFNj
aGluYWdsIDxvbGl2ZXJAc2NoaW5hZ2wubmw+Cj4gPiA+IAo+ID4gPiBUaGUgY3VycmVudCBheHAy
MHggbmFtZXMgdGhlIHJhbXBpbmcgcmVnaXN0ZXIgJ3NjYWwnIHdoaWNoIHByb2JhYmx5Cj4gPiA+
IG1lYW5zIHNjYWxpbmcuIFNpbmNlIHRoZSByZWdpc3RlciByZWFsbHkgaGFzIG5vdGhpbmcgdG8g
ZG8gd2l0aAo+ID4gPiBzY2FsaW5nLCBidXQgcmVhbGx5IGlzIHRoZSB2b2x0YWdlIHJhbXAgd2Ug
cmVuYW1lIGl0IGFwcHJvcHJpYXRlbHkuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGxp
dmVyIFNjaGluYWdsIDxvbGl2ZXJAc2NoaW5hZ2wubmw+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBy
aWl0IExhZXMgPHBsYWVzQHBsYWVzLm9yZz4KPiA+ID4gQWNrZWQtZm9yLU1GRC1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+ID4gLS0tCj4gPiA+ICBpbmNsdWRlL2xpbnV4
L21mZC9heHAyMHguaCB8IDQgKystLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gSSd2ZSBsb3N0IHRyYWNrIG9mIHdoYXQncyBo
YXBwZW5pbmcgd2l0aCB0aGlzIHNldCBub3cuCj4gPiAKPiA+IE1hcmssCj4gPiAKPiA+IERpZCB5
b3UgdGFrZSB0aGlzIHBhdGNoIGluIHRoZSBlbmQ/Cj4gCj4gWWVzLCB0aGlzIGlzIGluIGxpbnV4
LW5leHQuCgpJIGhhdmUgbm8gaWRlYSB3aHkgTWFyaydzIHRyYWNrZXIgaXNuJ3QgbWFpbGluZyBt
ZSAodGhpcyBpcyBub3QgdGhlCmZpcnN0IHRpbWUgdGhpcyBoYXMgaGFwcGVuZWQpLgoKQ291bGQg
eW91IHBsZWFzZSByZWJhc2UgdGhpcyBzZXQgYW5kIHJlc3VibWl0IGFsbCBvZiB0aGUgcGF0Y2hl
cyB3aGljaApoYXZlIG5vdCB5ZXQgYmVlbiBhcHBsaWVkPwoKVGhhbmsgeW91LgoKPiA+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL2F4cDIweC5oIGIvaW5jbHVkZS9saW51eC9tZmQv
YXhwMjB4LmgKPiA+ID4gaW5kZXggMjMwMmI2Mi4uYTM1M2NkMiAxMDA2NDQKPiA+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmgKPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQv
YXhwMjB4LmgKPiA+ID4gQEAgLTM1LDcgKzM1LDcgQEAgZW51bSBheHAyMHhfdmFyaWFudHMgewo+
ID4gPiAgI2RlZmluZSBBWFAxNTJfQUxET19PUF9NT0RFCQkweDEzCj4gPiA+ICAjZGVmaW5lIEFY
UDE1Ml9MRE8wX0NUUkwJCTB4MTUKPiA+ID4gICNkZWZpbmUgQVhQMTUyX0RDREMyX1ZfT1VUCQkw
eDIzCj4gPiA+IC0jZGVmaW5lIEFYUDE1Ml9EQ0RDMl9WX1NDQUwJCTB4MjUKPiA+ID4gKyNkZWZp
bmUgQVhQMTUyX0RDREMyX1ZfUkFNUAkJMHgyNQo+ID4gPiAgI2RlZmluZSBBWFAxNTJfRENEQzFf
Vl9PVVQJCTB4MjYKPiA+ID4gICNkZWZpbmUgQVhQMTUyX0RDREMzX1ZfT1VUCQkweDI3Cj4gPiA+
ICAjZGVmaW5lIEFYUDE1Ml9BTERPMTJfVl9PVVQJCTB4MjgKPiA+ID4gQEAgLTUzLDcgKzUzLDcg
QEAgZW51bSBheHAyMHhfdmFyaWFudHMgewo+ID4gPiAgI2RlZmluZSBBWFAyMFhfVVNCX09UR19T
VEFUVVMJCTB4MDIKPiA+ID4gICNkZWZpbmUgQVhQMjBYX1BXUl9PVVRfQ1RSTAkJMHgxMgo+ID4g
PiAgI2RlZmluZSBBWFAyMFhfRENEQzJfVl9PVVQJCTB4MjMKPiA+ID4gLSNkZWZpbmUgQVhQMjBY
X0RDREMyX0xETzNfVl9TQ0FMCTB4MjUKPiA+ID4gKyNkZWZpbmUgQVhQMjBYX0RDREMyX0xETzNf
Vl9SQU1QCTB4MjUKPiA+ID4gICNkZWZpbmUgQVhQMjBYX0RDREMzX1ZfT1VUCQkweDI3Cj4gPiA+
ICAjZGVmaW5lIEFYUDIwWF9MRE8yNF9WX09VVAkJMHgyOAo+ID4gPiAgI2RlZmluZSBBWFAyMFhf
TERPM19WX09VVAkJMHgyOQo+ID4gCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBT
ZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2Fy
ZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
