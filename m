Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C18206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARnWqctW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjB9Lp5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C18206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Olm0Eo9JFkUyBI1pEMDGdWrh6YQFbh6Ax6RUVz/DE8=; b=ARnWqctWwi13hP
	v4JOFxokVO4LsbIE1Bo9KJRxPAHsLNFvcF5efWpYG2W6SAU2OJdnFgQMfMezrNiqKE2cW/Fnn2U4m
	q3tCGd2vQcYx86Tpy8/XwqISu46Dif0Do19qLu+pyy4oywq+v3gG4x2VZpaudREFhA56cOicTQMV4
	q8nYEwVzJQ1Z9zH9OHzONrOZspVAO4WX5gpp1x7Nj2r9SCr3uVgef31RYzRvCJO8c9+V4osauoWJL
	bs+a5qhSw66gCt43lL7CZ8yCVQBicUxaDT0OqI5fX8mRQs5stjrnb7TlqVDkvKxm7koqhDZGlZQJa
	3LpHLgFus6kY8pbKxSHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp9G-0001WX-KG; Fri, 14 Dec 2018 15:13:06 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp8H-0000VL-IF
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:12:10 +0000
Received: by mail-lj1-x243.google.com with SMTP id t9-v6so5189243ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gNlPMZAZPIWZF32M/ihviaB8zTluPGCOKOKo+dyUvAM=;
 b=mjB9Lp5kqnsUmxYtQZvb15h9sgkJgy6TZdMsMWHihWgCfSnGDWZFyNXxm0bBHpEHmM
 qy90FSq7ECtt/fKiuZxcCocxA1w3RNY9xWSySOYa9N4j6QonZ6krEgyR3t8Rx9s+cGdp
 qxrSFQIhXCzPz5WlRsNcEmdoyQvqmVZNiYLHjS6zzJ+TRTWTJM20WF6LRWyBYrXEi+eK
 CKTkq8V/8l+BEwM5de3VtyMrM5aWO45saOScV6lYNzRjirNg3FboMV2wzDDD7GDyGGoo
 4mqVVCASE8lqcq/IDxHPyogQufmpDQ5BNldaWxbdH93L9NgD9VORuKfW3gqDwkEjuDqz
 leHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gNlPMZAZPIWZF32M/ihviaB8zTluPGCOKOKo+dyUvAM=;
 b=e66u3gnHxgY/tezWUD1t2kOpr4QW4HsuONqCLQmpoDKlMPzfkTmFph0JT5JgQxzRHq
 GbuSURJDb/PGzhQ1qJBjnqICy8Quf3K3lAtqYS0YUx9itp5Y3FzVZ2Rkl3ag0ZaNsUJt
 ZpfawoTETG7qyzTSfXcWPCa4o7Sacz9QZ3QqoT2fTxAZE4dLmwRWFI516uNgbuGttGVu
 B2zboaeKEtlbIiPD4o/qditABKyWnSUicsSbCySG8+vpA8pSShtImAKyWqQomUxNby18
 b3ChfXNhUxtw3h/VrQDRVyPqbB/u/LhUooUazqOPS/T/QiRCy0CglK4lrYdCJvXdfhb0
 FGCw==
X-Gm-Message-State: AA+aEWbbygXnETQjUCKwVf85OZB1/v2JJ2lOICRCxaE23rYniHIx5M/Z
 cXqxk69tJ7JZdnxc5FpSuzU=
X-Google-Smtp-Source: AFSGD/UCPi2PCZPzq4Z/8nuve/gAAat2LyaniOrBDpViVhgku6aL43hs14TyfMvv+srgWqjFkCJJ7A==
X-Received: by 2002:a2e:197:: with SMTP id
 f23-v6mr2103269lji.144.1544800311896; 
 Fri, 14 Dec 2018 07:11:51 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
 by smtp.gmail.com with ESMTPSA id
 q127-v6sm1021726ljq.45.2018.12.14.07.11.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Dec 2018 07:11:51 -0800 (PST)
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for optional
 regulators
Date: Fri, 14 Dec 2018 16:11:49 +0100
Message-ID: <2132818.BxtBPRaDeS@acerlaptop>
In-Reply-To: <20181209042612.GD211094@dtor-ws>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
 <20181209042612.GD211094@dtor-ws>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071206_053598_80AB5BE8 
X-CRM114-Status: GOOD (  22.09  )
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
 alexandre.belloni@bootlin.com, nick@shmanahar.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5pYSBuaWVkemllbGEsIDkgZ3J1ZG5pYSAyMDE4IDA1OjI2OjEyIENFVCBEbWl0cnkgVG9yb2to
b3YgcGlzemU6Cj4gT24gRnJpLCBEZWMgMDcsIDIwMTggYXQgMDM6Mjg6NTVQTSArMDEwMCwgUGF3
ZcWCIENobWllbCB3cm90ZToKPiA+IFRoaXMgcGF0Y2ggYWRkcyBvcHRpb25hbCByZWd1bGF0b3Jz
LCB3aGljaCBjYW4gYmUgdXNlZCB0byBwb3dlcgo+ID4gdXAgdG91Y2hzY3JlZW4uIEFmdGVyIGVu
YWJsaW5nIHJlZ3VsYXRvcnMsIHdlIG5lZWQgdG8gd2FpdCAxNTBtc2VjLgo+ID4gVGhpcyB2YWx1
ZSBpcyB0YWtlbiBmcm9tIG9mZmljaWFsIGRyaXZlci4KPiA+IAo+ID4gSXQgd2FzIHRlc3RlZCBv
biBTYW1zdW5nIEdhbGF4eSBpOTAwMCAoYmFzZWQgb24gU2Ftc3VuZyBTNVBWMjEwIFNPQykuCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVs
QGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gQ2hhbmdlcyBmcm9tIHYzOgo+ID4gICAtIEZpeCBjaGVj
a3BhdGNoIGlzc3Vlcwo+ID4gICAtIERyb3Agc2VudGVuY2UgcHVuY3R1YXRpb24gZnJvbSBzdWJq
ZWN0IG9mIG9uZSBvZiBwYXRjaGVzCj4gPiAKPiA+IENoYW5nZXMgZnJvbSB2MjoKPiA+ICAgLSBN
b3ZlIGNvZGUgZW5hYmxpbmcgcmVndWxhdG9ycyBpbnRvIHNlcGFyYXRlIG1ldGhvZCwKPiA+ICAg
ICB0byBtYWtlIGNvZGUgbW9yZSByZWFkYWJsZS4KPiA+IAo+ID4gQ2hhbmdlcyBmcm9tIHYxOgo+
ID4gICAtIEVuYWJsZSByZWd1bGF0b3JzIG9ubHkgaWYgcmVzZXRfZ3BpbyBpcyBwcmVzZW50Lgo+
ID4gICAtIFN3aXRjaCBmcm9tIGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25hbCB0byBkZXZtX3Jl
Z3VsYXRvcl9nZXQKPiA+IC0tLQo+ID4gIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxf
bXh0X3RzLmMgfCA2NSArKysrKysrKysrKysrKysrKysrKystLS0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMgYi9kcml2ZXJzL2lucHV0
L3RvdWNoc2NyZWVuL2F0bWVsX214dF90cy5jCj4gPiBpbmRleCBkM2FhY2Q1MzRlOWMuLjFkYzhh
ZDBkYTVhZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxf
bXh0X3RzLmMKPiA+ICsrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3Rz
LmMKPiA+IEBAIC0yNyw2ICsyNyw3IEBACj4gPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pgo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9wcm9wZXJ0
eS5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4KPiA+ICAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+
Cj4gPiAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4KPiA+IEBAIC0xOTQsMTAgKzE5NSwxMCBA
QCBlbnVtIHQxMDBfdHlwZSB7Cj4gPiAgCj4gPiAgLyogRGVsYXkgdGltZXMgKi8KPiA+ICAjZGVm
aW5lIE1YVF9CQUNLVVBfVElNRQkJNTAJLyogbXNlYyAqLwo+ID4gLSNkZWZpbmUgTVhUX1JFU0VU
X0dQSU9fVElNRQkyMAkvKiBtc2VjICovCj4gPiAgI2RlZmluZSBNWFRfUkVTRVRfSU5WQUxJRF9D
SEcJMTAwCS8qIG1zZWMgKi8KPiA+ICAjZGVmaW5lIE1YVF9SRVNFVF9USU1FCQkyMDAJLyogbXNl
YyAqLwo+ID4gICNkZWZpbmUgTVhUX1JFU0VUX1RJTUVPVVQJMzAwMAkvKiBtc2VjICovCj4gPiAr
I2RlZmluZSBNWFRfUkVHVUxBVE9SX0RFTEFZCTE1MAkvKiBtc2VjICovCj4gPiAgI2RlZmluZSBN
WFRfQ1JDX1RJTUVPVVQJCTEwMDAJLyogbXNlYyAqLwo+ID4gICNkZWZpbmUgTVhUX0ZXX1JFU0VU
X1RJTUUJMzAwMAkvKiBtc2VjICovCj4gPiAgI2RlZmluZSBNWFRfRldfQ0hHX1RJTUVPVVQJMzAw
CS8qIG1zZWMgKi8KPiA+IEBAIC0zMjMsNiArMzI0LDggQEAgc3RydWN0IG14dF9kYXRhIHsKPiA+
ICAJc3RydWN0IHQ3X2NvbmZpZyB0N19jZmc7Cj4gPiAgCXN0cnVjdCBteHRfZGJnIGRiZzsKPiA+
ICAJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsKPiA+ICsJc3RydWN0IHJlZ3VsYXRvciAq
dmRkX3JlZzsKPiA+ICsJc3RydWN0IHJlZ3VsYXRvciAqYXZkZF9yZWc7Cj4gPiAgCj4gPiAgCS8q
IENhY2hlZCBwYXJhbWV0ZXJzIGZyb20gb2JqZWN0IHRhYmxlICovCj4gPiAgCXUxNiBUNV9hZGRy
ZXNzOwo+ID4gQEAgLTMwMzgsNiArMzA0MSwzOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9z
eXN0ZW1faWQgY2hyb21lYm9va19UOV9zdXNwZW5kX2RtaVtdID0gewo+ID4gIAl7IH0KPiA+ICB9
Owo+ID4gIAo+ID4gK3N0YXRpYyBpbnQgbXh0X3JlZ3VsYXRvcl9lbmFibGUoc3RydWN0IG14dF9k
YXRhICpkYXRhKQo+ID4gK3sKPiA+ICsJaW50IGVycm9yOwo+ID4gKwo+ID4gKwlpZiAoZGF0YS0+
cmVzZXRfZ3Bpbykgewo+ID4gKwkJZXJyb3IgPSByZWd1bGF0b3JfZW5hYmxlKGRhdGEtPnZkZF9y
ZWcpOwo+ID4gKwkJaWYgKGVycm9yKSB7Cj4gPiArCQkJZGV2X2VycigmZGF0YS0+Y2xpZW50LT5k
ZXYsCj4gPiArCQkJCSJGYWlsZWQgdG8gZW5hYmxlIHZkZCByZWd1bGF0b3I6ICVkXG4iLCBlcnJv
cik7Cj4gPiArCQkJcmV0dXJuIGVycm9yOwo+ID4gKwkJfQo+ID4gKwo+ID4gKwkJZXJyb3IgPSBy
ZWd1bGF0b3JfZW5hYmxlKGRhdGEtPmF2ZGRfcmVnKTsKPiA+ICsJCWlmIChlcnJvcikgewo+ID4g
KwkJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2LAo+ID4gKwkJCQkiRmFpbGVkIHRvIGVuYWJs
ZSBhdmRkIHJlZ3VsYXRvcjogJWRcbiIsIGVycm9yKTsKPiAKPiBUaGlzIGxlYXZlcyB2ZGQgcmVn
dWxhdG9yIGVuYWJsZWQuCldpbGwgYmUgZml4ZWQgaW4gdjUgdmVyc2lvbiAod2lsbCBiZSB0b2Rh
eSkKVGhhbmtzIGZvciByZXZpZXcuCj4gCj4gVGhhbmtzLgo+IAo+IAoKCgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
