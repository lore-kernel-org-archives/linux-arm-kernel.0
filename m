Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:54:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FB9217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5udC4bO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w9XKxGaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FB9217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4jfRIXuAa2t8qT8Cb2nxnoBgZvYExaw2ZlGqp58qVRE=; b=u5udC4bONXlLcG
	nVQNDPlHUuFRdlW4lwBNYBXlA06zC6NrWDC4leKe6i2+6PrmuI1Q05cIQVUgYBokFOUqVEOihDo49
	qznvUy1iCwolYRSzdIlp/hbx9gh+v0peEyhqxLBQ/z2spHDKZrYyxVlAMVwD7pKITOfL7jw8YsJxj
	JkN1RY1HXz4W146fj2Jzq/4HK2zrDBXceDk+WJc/+0iLfeU9eShH7OhmnmrE1tmnZHXTX0/Y74Y5u
	UH29X2mCnhfXd7fW07k6PL1Ww+vXDxj28YWj0xzkTQJK5RgvHXXku2eJES11hbafsMKFl83KBnleZ
	ZC0oZ1WtUJumEYMjJTXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm6nz-0005pY-98; Wed, 23 Jan 2019 00:54:11 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm6ny-0005pR-0k
 for linux-arm-kernel@bombadil.infradead.org; Wed, 23 Jan 2019 00:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+wHWJ8Pi/bvCNMQAVt4/uCsC0HDgIz53EhRRXVc5iR4=; b=w9XKxGaXB3C8U9R23MoDmSMTeT
 gCe/TdUNJCCXNYGJ6FMYIB7k0U/B4hueV95Jh5F2H5helZj7zQQBrT4DAy7t8s+QVwK32+7FZ9Fei
 TpMD6v4ItPkyYx+XMDXA4gMvdJjN2NcD6inDJmVvG9YfL+dDV1ye+HwTsZLYg9RnvHz1NIEK3PZAA
 21yUjN6ajqrV6MQxYjMzETfERUE/GwrNWrHn+7U1YuJfEXofNJfS+311eiuvAaeRFzfaOyFwl6Hm7
 tHwdAbHdMfbeTTm4OtbT2anKEga/fhXNbAP7lCDhER0qreNJWQRQVLkkMUybvbBVRJO1d0hdZ6mRK
 Y+15Ty0g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm6nq-0008Cb-Pp; Wed, 23 Jan 2019 00:54:02 +0000
Subject: Re: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
References: <20190123003345.13750-1-f.fainelli@gmail.com>
 <20190123003345.13750-3-f.fainelli@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c64196a-b23c-efae-b449-a62981d44a26@infradead.org>
Date: Tue, 22 Jan 2019 16:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190123003345.13750-3-f.fainelli@gmail.com>
Content-Language: en-US
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 sfr@canb.auug.org.au, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS8yMi8xOSA0OjMzIFBNLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+IE9uIDMyLWJpdCBh
cmNoaXRlY3R1cmVzIGRlZmluaW5nIHJlc291cmNlX3NpemVfdCBhcyA2NC1iaXQgKGJlY2F1c2Ug
b2YKPiBQQUUpLCB3ZSBjYW4gcnVuIGludG8gYSBsaW5rZXIgZmFpbHVyZSBiZWNhdXNlIG9mIHRo
ZSBtb2R1bG8gYW5kIHRoZQo+IGRpdmlzaW9uIGFnYWluc3QgcmVzb3VyY2Vfc2l6ZSgpLCByZXBs
YWNlIHRoZSB0d28gcHJvYmxlbWF0aWMgb3BlcmF0aW9ucwo+IHdpdGggYW4gYWxpZ25tZW50IGNo
ZWNrIG9uIHRoZSByZWdpc3RlciByZXNvdXJjZSAoaW5zdGVhZCBvZiBtb2R1bG8pLAo+IGFuZCB0
aGUgZGl2aXNpb24gd2l0aCBESVZfUk9VTkRfQ0xPU0VTVF9VTEwoKS4KPiAKPiBSZXBvcnRlZC1i
eTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gRml4ZXM6IGMxOTZjZGM3
NjU5ZCAoInJlc2V0OiBBZGQgQnJvYWRjb20gU1RCIFNXX0lOSVQgcmVzZXQgY29udHJvbGxlciBk
cml2ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21h
aWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWJyY21zdGIuYyB8IDYgKysrKy0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtYnJjbXN0Yi5jIGIvZHJpdmVycy9yZXNl
dC9yZXNldC1icmNtc3RiLmMKPiBpbmRleCAwMWFiMWY3MTUxOGIuLmM0Y2FiOGI1MDUyZCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3Jlc2V0L3Jlc2V0LWJyY21zdGIuYwo+ICsrKyBiL2RyaXZlcnMv
cmVzZXQvcmVzZXQtYnJjbXN0Yi5jCj4gQEAgLTkxLDcgKzkxLDggQEAgc3RhdGljIGludCBicmNt
c3RiX3Jlc2V0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkJcmV0dXJu
IC1FTk9NRU07Cj4gIAo+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCAwKTsKPiAtCWlmIChyZXNvdXJjZV9zaXplKHJlcykgJSBTV19JTklUX0JBTktf
U0laRSkgewo+ICsJaWYgKCFJU19BTElHTkVEKHJlcy0+c3RhcnQsIFNXX0lOSVRfQkFOS19TSVpF
KSB8fAo+ICsJICAgICFJU19BR0xJTkVEKHJlc291cmNlX3NpemUocmVzKSwgU1dfSU5JVF9CQU5L
X1NJWkUpKSB7Cj4gIAkJZGV2X2VycihrZGV2LCAiaW5jb3JyZWN0IHJlZ2lzdGVyIHJhbmdlXG4i
KTsKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCX0KPiBAQCAtMTAzLDcgKzEwNCw4IEBAIHN0YXRp
YyBpbnQgYnJjbXN0Yl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+
ICAJZGV2X3NldF9kcnZkYXRhKGtkZXYsIHByaXYpOwo+ICAKPiAgCXByaXYtPnJjZGV2Lm93bmVy
ID0gVEhJU19NT0RVTEU7Cj4gLQlwcml2LT5yY2Rldi5ucl9yZXNldHMgPSAocmVzb3VyY2Vfc2l6
ZShyZXMpIC8gU1dfSU5JVF9CQU5LX1NJWkUpICogMzI7Cj4gKwlwcml2LT5yY2Rldi5ucl9yZXNl
dHMgPSBESVZfUk9VTkRfQ0xPU0VTVF9VTEwocmVzb3VyY2Vfc2l6ZShyZXMpLAo+ICsJCQkJCQkg
ICAgICBTV19JTklUX0JBTktfU0laRSkgKiAzMjsKPiAgCXByaXYtPnJjZGV2Lm9wcyA9ICZicmNt
c3RiX3Jlc2V0X29wczsKPiAgCXByaXYtPnJjZGV2Lm9mX25vZGUgPSBrZGV2LT5vZl9ub2RlOwo+
ICAJLyogVXNlIGRlZmF1bHRzOiAxIGNlbGwgYW5kIHNpbXBsZSB4bGF0ZSBmdW5jdGlvbiAqLwo+
IAoKSGkgRmxvcmlhbiwKClRoaXMgZ2l2ZXMgbWU6CgogIENDICAgICAgZHJpdmVycy9yZXNldC9y
ZXNldC1icmNtc3RiLm8KLi4vZHJpdmVycy9yZXNldC9yZXNldC1icmNtc3RiLmM6IEluIGZ1bmN0
aW9uIOKAmGJyY21zdGJfcmVzZXRfcHJvYmXigJk6Ci4uL2RyaXZlcnMvcmVzZXQvcmVzZXQtYnJj
bXN0Yi5jOjk1OjY6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhJ
U19BR0xJTkVE4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAg
ICAhSVNfQUdMSU5FRChyZXNvdXJjZV9zaXplKHJlcyksIFNXX0lOSVRfQkFOS19TSVpFKSkgewog
ICAgICBeCgoKYnV0IGlmIHRoZSB0eXBvIGlzIGZpeGVkLCBpdCBpcyBmaW5lIDopIHRoZW4geW91
IGNhbiBhZGRlZDoKCkFja2VkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz4KClRoYW5rcy4KCi0tIAp+UmFuZHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
