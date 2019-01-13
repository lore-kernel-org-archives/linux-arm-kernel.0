Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA782C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92079206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqUEFe//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92079206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0QxfFotWIKzO5pg2rvHoSqNUsXbTnfyppqsECEZeJRo=; b=fqUEFe//fFC9D3
	u4x4Tm5IhWDRo0kHa64u2P7O17WL3/Kh8uw2ZU1WjKB18Gpb11mlVLGw74drvsrh3AMYTjTHVCspR
	dGCEnp/UEi4g/5Fga4rTXYNOUrhWXbtAaQ+lxnTF+kMzw+ishdbOincX+cQonTOqosD9he6q2gCn+
	jhW9qtKg1WYx4iyNSniztTjj9xT0WXUHfZGhVShIPSfxrDp48Jt/wSglbWm1FiFP/1Lzan5O4+CTr
	+Hok72YgtWUfyq873FqM8RPr518CQreWZp+o43aUIxodiZjbkFLwEEEUENwPb0eZ05j1evS6x23M4
	zd92Bg43EDMsLcxfOJTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gifcw-0005ih-OZ; Sun, 13 Jan 2019 13:16:34 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gifcu-0005i3-1a
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 13:16:33 +0000
Received: by mail-ed1-f68.google.com with SMTP id g22so16565440edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 05:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=JjL7eeMXMIM7Zm7I/VKfxBqNJX9ibDYcknfQzbkZmdU=;
 b=smp90vHvdLGx/yYE6+AUF8jRpJL+BCXhhN97odlWbwyFJyk9R8GQZzthy5fxe/8Y9m
 FbBWvclQIgyHgi+DCHmM35QB7mp2YJ8Hjx2zavi1xi3lGRwpoCjz0IqaSHjwkt6+WSBT
 FlD9d9/QXu1H0O1DDs4y61eM5s7bR73LggMYgWXSlhWr32+CKAStZWSw4OTTggPf/Jrf
 6XOxyHV+M6pzqtOq4F4lSTwEsvvkH4MO80/Wra6z8N0ja5sETV2jn/62chPLXhTVC6R+
 r+Y3PYajunvIWGALVgcLECs5ObafDfBd7VTXU8iE1bu+ILiawTut8ju1kNoNnR2iEDJ5
 I6rw==
X-Gm-Message-State: AJcUukeGtJMXOI4i24mb6dqRFmSnFD7FVF/jHFT4dM+LTvScmOveayCR
 5ucYExjuRoMFCyGczv0cnVo=
X-Google-Smtp-Source: ALg8bN4AhWRlVq2e00OHUqq/4NiwdIBYhW53zhdRdTpopKhwHnKaKA0AgrlFKP8yxWZTUBnrRz+2Gw==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr20083256edb.238.1547385387362; 
 Sun, 13 Jan 2019 05:16:27 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id
 r18-v6sm2065927ejz.22.2019.01.13.05.16.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Jan 2019 05:16:26 -0800 (PST)
Date: Sun, 13 Jan 2019 14:16:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190113131624.GA2672@kozik-lap>
References: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_051632_090590_CDCA3AEA 
X-CRM114-Status: GOOD (  21.63  )
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

T24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgMDg6NDI6NDRQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBUaGVyZSBpcyBwb3NzaWJpbGl0eSwgdGhhdCB3aGVuIHByb2JpbmcgZHJpdmVyLCBy
ZWd1bGF0b3JzIGFyZSBub3QgeWV0Cj4gaW5pdGlhbGl6ZWQuIEluIHRoaXMgY2FzZSB3ZSBzaG91
bGQgcmV0dXJuIEVQUk9CRV9ERUZFUiBhbmQgd2FpdCB0aWxsCj4gdGhleSdyZSBpbml0aWFsaXpl
ZCwgc2luY2UgdGhleSdyZSByZXF1aXJlZCBjdXJyZW50bHkgZm9yIGNwdWZyZXEgZHJpdmVyCj4g
dG8gd29yay4gQWxzbyBtb3ZlIHJlZ3VsYXRvciBpbml0aWFsaXphdGlvbiBjb2RlIGF0IGJlZ2lu
bmluZyBvZiBwcm9iZSwKPiBzbyB3ZSBjYW4gZGVmZXIgYXMgZmFzdCBhcyBwb3NpYmJsZS4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFp
bC5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBmcm9tIHYyOgo+ICAgLSBIYW5kbGUgYWxsIGVycm9yIHBh
dGhzIGluIHByb2JlCj4gCj4gQ2hhbmdlcyBmcm9tIHYxOgo+ICAgLSBGaXggY29tcGlsYXRpb24g
ZXJyb3IKPiAgIC0gUmVvcmdhbml6ZSBjb2RlIHNvIGl0J3Mgc21hbGxlcgo+IC0tLQo+ICBkcml2
ZXJzL2NwdWZyZXEvczVwdjIxMC1jcHVmcmVxLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5j
IGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gaW5kZXggZjUxNjk3ZjFlMGIz
Li42MjdiMTMyZTNlNjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1
ZnJlcS5jCj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL3M1cHYyMTAtY3B1ZnJlcS5jCj4gQEAgLTU4
NCw3ICs1ODQsNyBAQCBzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHM1cHYyMTBfY3B1ZnJl
cV9yZWJvb3Rfbm90aWZpZXIgPSB7Cj4gIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVxX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIHsKPiAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnA7Cj4gLQlpbnQgaWQ7Cj4gKwlpbnQgaWQsIHJlc3VsdCA9IDA7Cj4gIAo+ICAJLyoKPiAg
CSAqIEhBQ0s6IFRoaXMgaXMgYSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCB0byBnZXQgYWNjZXNzIHRv
IGNsb2NrCj4gQEAgLTU5NCwxOCArNTk0LDQwIEBAIHN0YXRpYyBpbnQgczVwdjIxMF9jcHVmcmVx
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkgKiB0aGlzIHdob2xlIGRy
aXZlciBhcyBzb29uIGFzIFM1UFYyMTAgZ2V0cyBtaWdyYXRlZCB0byB1c2UKPiAgCSAqIGNwdWZy
ZXEtZHQgZHJpdmVyLgo+ICAJICovCj4gKwlhcm1fcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChO
VUxMLCAidmRkYXJtIik7Cj4gKwlpZiAoSVNfRVJSKGFybV9yZWd1bGF0b3IpKSB7Cj4gKwkJaWYg
KFBUUl9FUlIoYXJtX3JlZ3VsYXRvcikgPT0gLUVQUk9CRV9ERUZFUikKPiArCQkJcHJfZGVidWco
InZkZGFybSByZWd1bGF0b3Igbm90IHJlYWR5LCBkZWZlclxuIik7Cj4gKwkJZWxzZQo+ICsJCQlw
cl9lcnIoImZhaWxlZCB0byBnZXQgcmVndWxhdG9yIHZkZGFybVxuIik7Cj4gKwkJcmVzdWx0ID0g
UFRSX0VSUihhcm1fcmVndWxhdG9yKTsKPiArCQlnb3RvIGVycl9hcm1fcmVndWxhdG9yOwoKSnVz
dCByZXR1cm4gaGVyZS4KCj4gKwl9Cj4gKwo+ICsJaW50X3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9n
ZXQoTlVMTCwgInZkZGludCIpOwo+ICsJaWYgKElTX0VSUihpbnRfcmVndWxhdG9yKSkgewo+ICsJ
CWlmIChQVFJfRVJSKGludF9yZWd1bGF0b3IpID09IC1FUFJPQkVfREVGRVIpCj4gKwkJCXByX2Rl
YnVnKCJ2ZGRpbnQgcmVndWxhdG9yIG5vdCByZWFkeSwgZGVmZXJcbiIpOwo+ICsJCWVsc2UKPiAr
CQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHJlZ3VsYXRvciB2ZGRpbnRcbiIpOwo+ICsJCXJlc3Vs
dCA9IFBUUl9FUlIoaW50X3JlZ3VsYXRvcik7Cj4gKwkJZ290byBlcnJfaW50X3JlZ3VsYXRvcjsK
PiArCX0KPiArCj4gIAlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJz
YW1zdW5nLHM1cHYyMTAtY2xvY2siKTsKPiAgCWlmICghbnApIHsKPiAgCQlwcl9lcnIoIiVzOiBm
YWlsZWQgdG8gZmluZCBjbG9jayBjb250cm9sbGVyIERUIG5vZGVcbiIsCj4gIAkJCV9fZnVuY19f
KTsKPiAtCQlyZXR1cm4gLUVOT0RFVjsKPiArCQlyZXN1bHQgPSAtRU5PREVWOwo+ICsJCWdvdG8g
ZXJyX2Nsb2NrOwo+ICAJfQo+ICAKPiAgCWNsa19iYXNlID0gb2ZfaW9tYXAobnAsIDApOwo+ICAJ
b2Zfbm9kZV9wdXQobnApOwo+ICAJaWYgKCFjbGtfYmFzZSkgewo+ICAJCXByX2VycigiJXM6IGZh
aWxlZCB0byBtYXAgY2xvY2sgcmVnaXN0ZXJzXG4iLCBfX2Z1bmNfXyk7Cj4gLQkJcmV0dXJuIC1F
RkFVTFQ7Cj4gKwkJcmVzdWx0ID0gLUVGQVVMVDsKPiArCQlnb3RvIGVycl9jbG9jazsKPiAgCX0K
PiAgCj4gIAlmb3JfZWFjaF9jb21wYXRpYmxlX25vZGUobnAsIE5VTEwsICJzYW1zdW5nLHM1cHYy
MTAtZG1jIikgewo+IEBAIC02MTQsNyArNjM2LDggQEAgc3RhdGljIGludCBzNXB2MjEwX2NwdWZy
ZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCQkJcHJfZXJyKCIlczog
ZmFpbGVkIHRvIGdldCBhbGlhcyBvZiBkbWMgbm9kZSAnJXBPRm4nXG4iLAo+ICAJCQkJX19mdW5j
X18sIG5wKTsKPiAgCQkJb2Zfbm9kZV9wdXQobnApOwo+IC0JCQlyZXR1cm4gaWQ7Cj4gKwkJCXJl
c3VsdCA9IGlkOwo+ICsJCQlnb3RvIGVycl9jbGtfYmFzZTsKPiAgCQl9Cj4gIAo+ICAJCWRtY19i
YXNlW2lkXSA9IG9mX2lvbWFwKG5wLCAwKTsKPiBAQCAtNjIyLDMzICs2NDUsNDAgQEAgc3RhdGlj
IGludCBzNXB2MjEwX2NwdWZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
PiAgCQkJcHJfZXJyKCIlczogZmFpbGVkIHRvIG1hcCBkbWMlZCByZWdpc3RlcnNcbiIsCj4gIAkJ
CQlfX2Z1bmNfXywgaWQpOwo+ICAJCQlvZl9ub2RlX3B1dChucCk7Cj4gLQkJCXJldHVybiAtRUZB
VUxUOwo+ICsJCQlyZXN1bHQgPSAtRUZBVUxUOwo+ICsJCQlnb3RvIGVycl9kbWM7Cj4gIAkJfQo+
ICAJfQo+ICAKPiAgCWZvciAoaWQgPSAwOyBpZCA8IEFSUkFZX1NJWkUoZG1jX2Jhc2UpOyArK2lk
KSB7Cj4gIAkJaWYgKCFkbWNfYmFzZVtpZF0pIHsKPiAgCQkJcHJfZXJyKCIlczogZmFpbGVkIHRv
IGZpbmQgZG1jJWQgbm9kZVxuIiwgX19mdW5jX18sIGlkKTsKPiAtCQkJcmV0dXJuIC1FTk9ERVY7
Cj4gKwkJCXJlc3VsdCA9IC1FTk9ERVY7Cj4gKwkJCWdvdG8gZXJyX2RtYzsKPiAgCQl9Cj4gIAl9
Cj4gIAo+IC0JYXJtX3JlZ3VsYXRvciA9IHJlZ3VsYXRvcl9nZXQoTlVMTCwgInZkZGFybSIpOwo+
IC0JaWYgKElTX0VSUihhcm1fcmVndWxhdG9yKSkgewo+IC0JCXByX2VycigiZmFpbGVkIHRvIGdl
dCByZWd1bGF0b3IgdmRkYXJtXG4iKTsKPiAtCQlyZXR1cm4gUFRSX0VSUihhcm1fcmVndWxhdG9y
KTsKPiAtCX0KPiAtCj4gLQlpbnRfcmVndWxhdG9yID0gcmVndWxhdG9yX2dldChOVUxMLCAidmRk
aW50Iik7Cj4gLQlpZiAoSVNfRVJSKGludF9yZWd1bGF0b3IpKSB7Cj4gLQkJcHJfZXJyKCJmYWls
ZWQgdG8gZ2V0IHJlZ3VsYXRvciB2ZGRpbnRcbiIpOwo+IC0JCXJlZ3VsYXRvcl9wdXQoYXJtX3Jl
Z3VsYXRvcik7Cj4gLQkJcmV0dXJuIFBUUl9FUlIoaW50X3JlZ3VsYXRvcik7Cj4gLQl9Cj4gLQo+
ICAJcmVnaXN0ZXJfcmVib290X25vdGlmaWVyKCZzNXB2MjEwX2NwdWZyZXFfcmVib290X25vdGlm
aWVyKTsKPiAgCj4gIAlyZXR1cm4gY3B1ZnJlcV9yZWdpc3Rlcl9kcml2ZXIoJnM1cHYyMTBfZHJp
dmVyKTsKPiArCj4gK2Vycl9kbWM6Cj4gKwlmb3IgKGlkID0gMDsgaWQgPCBBUlJBWV9TSVpFKGRt
Y19iYXNlKTsgKytpZCkKPiArCQlpZiAoZG1jX2Jhc2VbaWRdKQo+ICsJCQlpb3VubWFwKGRtY19i
YXNlW2lkXSk7CgpZb3Ugd2lsbCBpb3VubWFwIHRoZSBzYW1lIHBvaW50ZXIgdHdpY2UsIGlmIGZp
cnN0IGRldmljZSBiaW5kIGZhaWxlZAp3aGlsZSBmb2xsb3dpbmcgdGhpcyBlcnJvciBwYXRoIGFu
ZCBzb21lb25lIHRyaWVzIHRvIGJpbmQgc2Vjb25kIHRpbWUKKGFnYWluIHdpdGggZXJyb3IgbGVh
ZGluZyB0byB0aGlzIGVycm9yIHBhdGgpLiBZb3UgemVybyB0aGUgcG9pbnRlcgplaXRoZXIgYXQg
YmVnaW5uaW5nIG9mIHByb2JlIG9yIGFmdGVyIGlvdW5tYXBwaW5nLgoKQmVzdCByZWdhcmRzLApL
cnp5c3p0b2YKCgo+ICsKPiArZXJyX2Nsa19iYXNlOgo+ICsJaW91bm1hcChjbGtfYmFzZSk7Cj4g
Kwo+ICtlcnJfY2xvY2s6Cj4gKwlyZWd1bGF0b3JfcHV0KGludF9yZWd1bGF0b3IpOwo+ICsKPiAr
ZXJyX2ludF9yZWd1bGF0b3I6Cj4gKwlyZWd1bGF0b3JfcHV0KGFybV9yZWd1bGF0b3IpOwo+ICsK
PiArZXJyX2FybV9yZWd1bGF0b3I6Cj4gKwo+ICsJcmV0dXJuIHJlc3VsdDsKPiAgfQo+ICAKPiAg
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgczVwdjIxMF9jcHVmcmVxX3BsYXRkcnYgPSB7
Cj4gLS0gCj4gMi4xNy4xCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
