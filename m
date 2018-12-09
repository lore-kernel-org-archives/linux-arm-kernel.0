Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88460C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548C820831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ir5ZVueC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlHH1HtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548C820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1z6PkOY8rwrh20/s/VZ96M8IDj81aZ9fAs+R1U8Y7Qk=; b=Ir5ZVueCMg9U7b
	hxZon2yU5XDRhmEr0eEV1SwrkDoy/Y/i0c4aS9n+sLGgG65HabiXpdUIi4gXarnu+MZA6uQZIlQDx
	hzLSd/fRZo2aEtJ5khImakJgFNJYLsBgGw4TtweKg1RvAu9ycFD7peW2W5ewCl1csMOp13ByBrw4G
	hiTFVgMQBJxh6KsYJKpqsfLAXDv3nPUKOsOAnd81mnKeEzArDeuZAiqN7kslMvPJlBiSfkWC7j9zf
	k2nqF1DnUQg1UEMcc7e/mJbHFNkfx7IC/ylGfQEBmbvyQc8LN4nTLIWkm9T/deQhpybcS5n04i80D
	YHynoLVj72T1twNj126w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVqfn-0006iw-Fu; Sun, 09 Dec 2018 04:26:31 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVqfj-0006iD-RP
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 04:26:29 +0000
Received: by mail-pg1-x541.google.com with SMTP id g189so3448046pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=G1PmgWULHeqgE3piJ2tx/wp+P8OL0THtcYt1s2gTQFc=;
 b=FlHH1HtLRX960Xzwz3CbsOKziLm3xPyHpjzinudgzpslgk3/UJ+KBX/qJTSP9SvSGw
 sNfmVKJVVf8IryuSuA+Jv/6aXbu7SzRZCo9YLcJpMfp2j7HUyudLvmA4rWSx7EzJFGrS
 sByvu1uJLhd8d15kNFopu3PYNmY+D8P8sLTy09jQ1Xl9aoz8G0e5XSj5D9AseRDBxMY6
 6ngmMePX5xaorpV+9dLE+dPehdO5rMEqEzMmHBNnS4f5GHLbWtTZHtNy+9mQGiFCUFmK
 x67QqB7hh/NOi6+NFcIF+9c6IU6wLEIFSagKqJbRczKxshOPuJVvHKu6ZOCmefie5bhf
 cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=G1PmgWULHeqgE3piJ2tx/wp+P8OL0THtcYt1s2gTQFc=;
 b=R2KNo2oQiHn7KbnKwucKwCKRL5wbJEUsveEkaAfWfhYd6Imoj+4JMFVYqoqEg5VYks
 8lZ1rL6IyVpnNVzUU8sM6XEUXP+rxrpzB++qSBMz08Eh0qgwrFNU7sfqewlH3YANku6q
 vZZy54HWHfOHmAddnTSJnO9P0U4hibTIso5V2VPuhynEM3ZISJYHtXSe6rxW/h/I9DF0
 6g0Rqd7z3eZIKMZJMy7unj1ms3b/L84dV85nctzTDIel/mCkHQm1eyqRYATDOnF1w3cm
 o9WYawICfeflwmuZpqn/9J0D9isvmroL2sH1QoAQIx1tY+LguBAeK2d9lgwQwx2YtP/y
 8psw==
X-Gm-Message-State: AA+aEWaGUiMsyRp0AwgSob+cx8QS8JBRI1pPIx7QnS8cOeKadKkD9PIP
 +1SH5dFdydCCAhoDvy6OTEk=
X-Google-Smtp-Source: AFSGD/VCLH9luYtFV/clJURCOy5NnMJBSpcox6ONt1E79RY0J8nD21iNwpejVF+HUfyDEqlhrSaJ1g==
X-Received: by 2002:a62:6408:: with SMTP id y8mr7792499pfb.202.1544329576207; 
 Sat, 08 Dec 2018 20:26:16 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id q75sm10363705pfa.38.2018.12.08.20.26.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 20:26:15 -0800 (PST)
Date: Sat, 8 Dec 2018 20:26:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional
 regulators
Message-ID: <20181209042612.GD211094@dtor-ws>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_202627_895980_71B9ACDD 
X-CRM114-Status: GOOD (  21.88  )
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

T24gRnJpLCBEZWMgMDcsIDIwMTggYXQgMDM6Mjg6NTVQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBUaGlzIHBhdGNoIGFkZHMgb3B0aW9uYWwgcmVndWxhdG9ycywgd2hpY2ggY2FuIGJl
IHVzZWQgdG8gcG93ZXIKPiB1cCB0b3VjaHNjcmVlbi4gQWZ0ZXIgZW5hYmxpbmcgcmVndWxhdG9y
cywgd2UgbmVlZCB0byB3YWl0IDE1MG1zZWMuCj4gVGhpcyB2YWx1ZSBpcyB0YWtlbiBmcm9tIG9m
ZmljaWFsIGRyaXZlci4KPiAKPiBJdCB3YXMgdGVzdGVkIG9uIFNhbXN1bmcgR2FsYXh5IGk5MDAw
IChiYXNlZCBvbiBTYW1zdW5nIFM1UFYyMTAgU09DKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQYXdl
xYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4gLS0tCj4gQ2hhbmdl
cyBmcm9tIHYzOgo+ICAgLSBGaXggY2hlY2twYXRjaCBpc3N1ZXMKPiAgIC0gRHJvcCBzZW50ZW5j
ZSBwdW5jdHVhdGlvbiBmcm9tIHN1YmplY3Qgb2Ygb25lIG9mIHBhdGNoZXMKPiAKPiBDaGFuZ2Vz
IGZyb20gdjI6Cj4gICAtIE1vdmUgY29kZSBlbmFibGluZyByZWd1bGF0b3JzIGludG8gc2VwYXJh
dGUgbWV0aG9kLAo+ICAgICB0byBtYWtlIGNvZGUgbW9yZSByZWFkYWJsZS4KPiAKPiBDaGFuZ2Vz
IGZyb20gdjE6Cj4gICAtIEVuYWJsZSByZWd1bGF0b3JzIG9ubHkgaWYgcmVzZXRfZ3BpbyBpcyBw
cmVzZW50Lgo+ICAgLSBTd2l0Y2ggZnJvbSBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwgdG8g
ZGV2bV9yZWd1bGF0b3JfZ2V0Cj4gLS0tCj4gIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRt
ZWxfbXh0X3RzLmMgfCA2NSArKysrKysrKysrKysrKysrKysrKystLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDU5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMgYi9kcml2ZXJzL2lucHV0L3Rv
dWNoc2NyZWVuL2F0bWVsX214dF90cy5jCj4gaW5kZXggZDNhYWNkNTM0ZTljLi4xZGM4YWQwZGE1
YWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMu
Ywo+ICsrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMKPiBAQCAt
MjcsNiArMjcsNyBAQAo+ICAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4gICNpbmNsdWRl
IDxsaW51eC9vZi5oPgo+ICAjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4KPiArI2luY2x1ZGUg
PGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPgo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+
ICAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPgo+ICAjaW5jbHVkZSA8YXNtL3VuYWxp
Z25lZC5oPgo+IEBAIC0xOTQsMTAgKzE5NSwxMCBAQCBlbnVtIHQxMDBfdHlwZSB7Cj4gIAo+ICAv
KiBEZWxheSB0aW1lcyAqLwo+ICAjZGVmaW5lIE1YVF9CQUNLVVBfVElNRQkJNTAJLyogbXNlYyAq
Lwo+IC0jZGVmaW5lIE1YVF9SRVNFVF9HUElPX1RJTUUJMjAJLyogbXNlYyAqLwo+ICAjZGVmaW5l
IE1YVF9SRVNFVF9JTlZBTElEX0NIRwkxMDAJLyogbXNlYyAqLwo+ICAjZGVmaW5lIE1YVF9SRVNF
VF9USU1FCQkyMDAJLyogbXNlYyAqLwo+ICAjZGVmaW5lIE1YVF9SRVNFVF9USU1FT1VUCTMwMDAJ
LyogbXNlYyAqLwo+ICsjZGVmaW5lIE1YVF9SRUdVTEFUT1JfREVMQVkJMTUwCS8qIG1zZWMgKi8K
PiAgI2RlZmluZSBNWFRfQ1JDX1RJTUVPVVQJCTEwMDAJLyogbXNlYyAqLwo+ICAjZGVmaW5lIE1Y
VF9GV19SRVNFVF9USU1FCTMwMDAJLyogbXNlYyAqLwo+ICAjZGVmaW5lIE1YVF9GV19DSEdfVElN
RU9VVAkzMDAJLyogbXNlYyAqLwo+IEBAIC0zMjMsNiArMzI0LDggQEAgc3RydWN0IG14dF9kYXRh
IHsKPiAgCXN0cnVjdCB0N19jb25maWcgdDdfY2ZnOwo+ICAJc3RydWN0IG14dF9kYmcgZGJnOwo+
ICAJc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsKPiArCXN0cnVjdCByZWd1bGF0b3IgKnZk
ZF9yZWc7Cj4gKwlzdHJ1Y3QgcmVndWxhdG9yICphdmRkX3JlZzsKPiAgCj4gIAkvKiBDYWNoZWQg
cGFyYW1ldGVycyBmcm9tIG9iamVjdCB0YWJsZSAqLwo+ICAJdTE2IFQ1X2FkZHJlc3M7Cj4gQEAg
LTMwMzgsNiArMzA0MSwzOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgY2hy
b21lYm9va19UOV9zdXNwZW5kX2RtaVtdID0gewo+ICAJeyB9Cj4gIH07Cj4gIAo+ICtzdGF0aWMg
aW50IG14dF9yZWd1bGF0b3JfZW5hYmxlKHN0cnVjdCBteHRfZGF0YSAqZGF0YSkKPiArewo+ICsJ
aW50IGVycm9yOwo+ICsKPiArCWlmIChkYXRhLT5yZXNldF9ncGlvKSB7Cj4gKwkJZXJyb3IgPSBy
ZWd1bGF0b3JfZW5hYmxlKGRhdGEtPnZkZF9yZWcpOwo+ICsJCWlmIChlcnJvcikgewo+ICsJCQlk
ZXZfZXJyKCZkYXRhLT5jbGllbnQtPmRldiwKPiArCQkJCSJGYWlsZWQgdG8gZW5hYmxlIHZkZCBy
ZWd1bGF0b3I6ICVkXG4iLCBlcnJvcik7Cj4gKwkJCXJldHVybiBlcnJvcjsKPiArCQl9Cj4gKwo+
ICsJCWVycm9yID0gcmVndWxhdG9yX2VuYWJsZShkYXRhLT5hdmRkX3JlZyk7Cj4gKwkJaWYgKGVy
cm9yKSB7Cj4gKwkJCWRldl9lcnIoJmRhdGEtPmNsaWVudC0+ZGV2LAo+ICsJCQkJIkZhaWxlZCB0
byBlbmFibGUgYXZkZCByZWd1bGF0b3I6ICVkXG4iLCBlcnJvcik7CgpUaGlzIGxlYXZlcyB2ZGQg
cmVndWxhdG9yIGVuYWJsZWQuCgpUaGFua3MuCgotLSAKRG1pdHJ5CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
