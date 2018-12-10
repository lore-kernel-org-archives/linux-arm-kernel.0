Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F6BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D6E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sAkbayeF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT7I4hua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D6E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovK6B0Js0YZKWSzeFEv1yrK+3RssYTm6B2+PTac9TFk=; b=sAkbayeF+PG/mY
	zXKUSv0vz9NHAnUD/1SSyIfyf5PALz0GrXEqmOSvuRnbYnZUuhBbdOGgWrs/j9XM+sw3l9N38K9mL
	ry/l1YykbeNjlYM1eae+vWIOBCs3BCy7w5vs7/weO2SibgCo3J4pqb7+nh2sOUnYID2+JWtYW+GMW
	gShLPeu3vs1vUJ311a95imlMbf++jWLY6dsPl9/GU/FEWlQ3IADDdohhEmjjhZ6avzpySH0ydY7Me
	2gb1g0bM5eGqJ2FBRUQQTJxYN0dLQWMQEMTQSx4bjCKuju3JeF4NzuQQXuCpOfLplE0BGj7ma1Prf
	+IGMopAIui8RBSu6Yx0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQsA-0004vA-3N; Mon, 10 Dec 2018 19:05:42 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQs6-0004gb-0A
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:05:40 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so4691156wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 11:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6u3uYKORfQlqLJiGM74qw/k+wkzZkxkDL0+CkHi7Tx4=;
 b=rT7I4huaVlIFCQmZvQ3Q3qH5s8pFhnSlzaFGjGHNTtc1rmtGf9l6MAyY9i2lxaOmba
 Blvu79rOFkHYl4yHcjpqIfnwIhSO5ffSQz8YZc8cupJPLO8i9D0lKuz43Uccj+RJnk+Z
 d7+O+xf5/FcqzQyymY5xJR/ZuDdRSpaAjZ2MCjEUafpsW6TgZjTuJz1SMmTUknA5rDR1
 bjVKFG9xP8Fj5H0XrxC0e+znDL3snAJ4Ei9VtGOB6jfFbOdegzZWAeiHbF/XVRRH4cIb
 QTJN1iVxKpHMLt5TqUvYxhe6cRRHDcBqah+iVgbBDWJNnyhOp9DMXxqV4LuapyeaShIs
 dPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6u3uYKORfQlqLJiGM74qw/k+wkzZkxkDL0+CkHi7Tx4=;
 b=oiRCa80E7ufR1lEtJzcuuZthZ0NzSOuIB+W0VYTx/fWaY3aoA+J1J3PofNAqOxKSBa
 tzndqg7WqH6fCwBMXFKqTVEAegLMKXG3TQ/Fjn1tua1jaez/F5M1sv1aiadIm534C5VK
 pJPQ8+n/mRkTB+M1O3iPd7D/b+F3prWIwHbslP7G4O7CWslAIJ3NkUTMmi0m8jBIhWuI
 TA7TCh5dRDp+0so7KdxmLyIp0Dkk4WWRd8hB99YM0t2ZFXseJ50sur3sd3Z8ETKt5d+a
 LgLRG9+u4QW7SGxqG/wyjegbRfYqpFuRXKKsk5OXFlZQB9J86Aos/4DzN+1+bxu3H0mU
 Yv1w==
X-Gm-Message-State: AA+aEWaJP8BrnKQes5fGrNzLnqfrfjktph9H5tG7FyZrXmy3S1NjI0f6
 KBDeHAjiuNjpRm+sk7DQTzE=
X-Google-Smtp-Source: AFSGD/X/6bRVvMeax9TAd8Q3h8TDKpkN33A4yUjw3OnFdYeSO5M7KDDQacVr+Sv/B3X49/gV8g+RGg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr12524198wmg.42.1544468725813; 
 Mon, 10 Dec 2018 11:05:25 -0800 (PST)
Received: from gapa-lenovo-ideapad-y580.home (dbq157.neoplus.adsl.tpnet.pl.
 [83.23.42.157])
 by smtp.googlemail.com with ESMTPSA id j8sm15319284wmd.0.2018.12.10.11.05.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 11:05:24 -0800 (PST)
Message-ID: <1544468722.17722.45.camel@gmail.com>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
From: Cezary =?UTF-8?Q?Gapi=C5=84ski?= <cezary.gapinski@gmail.com>
To: Amelie DELAUNAY <amelie.delaunay@st.com>, Mark Brown
 <broonie@kernel.org>,  "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date: Mon, 10 Dec 2018 20:05:22 +0100
In-Reply-To: <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_110538_144735_D5ADC3C7 
X-CRM114-Status: GOOD (  28.78  )
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
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW1lbGllLAoKT24gTW9uLCAyMDE4LTEyLTEwIGF0IDEyOjM3ICswMDAwLCBBbWVsaWUgREVM
QVVOQVkgd3JvdGU6Cj4gSGkgQ2V6YXJ5LAo+IAo+IE9uIDEyLzkvMTggMjo1MyBQTSwgY2V6YXJ5
LmdhcGluc2tpQGdtYWlsLmNvbSB3cm90ZToKPiA+IAo+ID4gRnJvbTogQ2V6YXJ5IEdhcGluc2tp
IDxjZXphcnkuZ2FwaW5za2lAZ21haWwuY29tPgo+ID4gCj4gPiBUaGlzIHNlcmllcyBvZiBwYXRj
aGVzIGFkZHMgc3VwcG9ydCBmb3IgZmlyc3QgZ2VuZXJhdGlvbiBvZiBTUEkKPiA+IGludGVyZmFj
ZQo+ID4gZm9yIFNUTTMyRjQgZmFtaWx5Lgo+ID4gCj4gRmlyc3Qgb2YgYWxsLCB0aGFua3MgZm9y
IGFkZGluZyBTVE0zMkY0IFNQSSBzdXBwb3J0LgoKVGhhbmtzIGZvciB5b3VyIGFuc3dlciBhbmQg
aGludHMgZm9yIGNvcnJlY3QgYXBwcm9hY2ggdG8gdGhpcyBkcml2ZXIuCgo+ID4gCj4gPiBUaGlz
IHZlcnNpb24gb2YgZHJpdmVyIGlzIG1vc3RseSBkaWZmZXJlbnQgdG8gU1RNMzJINyBvbmUuIEJh
c2VkIG9uCj4gPiBsaW51eAo+ID4ga2VybmVsIEkyQyBkcml2ZXJzIGZvciBTVE0zMiB3aGVyZSBk
cml2ZXJzIHdlcmUgc3BsaXRlZCBpbnRvCj4gPiBTVE0zMkY0IGFuZAo+ID4gU1RNMzJGNyBmYW1p
bHkgdGhlIHNhbWUgYXBwcm9hY2ggc2VlbXMgdG8gYmUgc3VmZmljaWVudCBmb3IgU1BJCj4gPiBT
VE0zMgo+ID4gZHJpdmVycy4gVGhlcmVmb3JlIFNUTTMySDcgZHJpdmVyIHdhcyBtb3ZlZCB0byBz
cGktc3RtMzJoNy5jIGZpbGUKPiA+IGFuZAo+ID4gcmVnaXN0ZXIgYW5kIGZ1bmN0aW9ucyB3ZXJl
IHJlbmFtZWQgdG8gYmUgbW9yZSBzcGVjaWZpYyB0byBTVE0zMkg3Lgo+ID4gCj4gWW91J3JlIHJp
Z2h0LCBTVE0zMkY0IFNQSSBpcyBzbGlnaHRseSBkaWZmZXJlbnQgZnJvbSBTVE0zMkg3IG9uZTrC
oAo+IHJlZ2lzdGVyIG1hcC9iaXRzIG9mZnNldHMgYXJlIGRpZmZlcmVudCBhbmQgU1RNMzJINyBo
YXMgYW4gUlggYW5kIFRYCj4gRklGTy4KPiBCdXQgaWYgeW91IGhhdmUgYSBsb29rIG9uIFNUTTMy
RjcgU1BJIFsxXSwgeW91J2xsIHNlZSB0aGF0IFNUTTMyRjcKPiBTUEnCoAo+IGlzIGJhc2VkIG9u
IFNUTTMyRjQgU1BJIHdpdGggbmV3IGZlYXR1cmVzIChkYXRhIGZyYW1lcyAmIEZJRk9zKSBhbHNv
wqAKPiBhdmFpbGFibGUgb24gU1RNMzJINyBTUEkuCj4gCj4gVGhhdCdzIHdoeSBTVE0zMkg3IFNQ
SSBkcml2ZXIgd2FzIGNhbGxlZCBzcGktc3RtMzIuIFRoZSBnb2FsIHdhcyB0bwo+IHVzZcKgCj4g
Y29tcGF0aWJsZSAmIG1hdGNoIGRhdGEgdG8gZGlmZmVyZW50aWF0ZSBlYWNoIFNUTTMyRnggc3Bl
Y2lmaWNpdGllcy4KPiAKPiBZb3UgY2FuIGhhdmUgYSBsb29rIG9uIGhvdyBpdCBpcyBtYW5hZ2Vk
IGluIGRyaXZlcnMvcnRjL3J0Yy1zdG0zMi5jCj4gKHRoZcKgCj4gc2FtZSBkcml2ZXIgY292ZXJz
IDIgSFcgdmVyc2lvbiBvZiBTVE0zMiBSVEMpLCBvciBpbsKgCj4gZHJpdmVycy9paW8vZGFjL3N0
bTMyLWRhYy1jb3JlLmMgYW5kIHN0bTMyLWRhYy5jICh0aGUgc2FtZSBkcml2ZXIKPiBhbHNvwqAK
PiBjb3ZlcnMgMiBIVyB2ZXJzaW9uIG9mIFNUTTMyIERBQykuCj4gQXMgeW91ciBzcGktc3RtMzJm
NC5jIGZpbGUgaXMgaGlnaGx5IGJhc2VkIG9uIHRoZSBleGlzdGluZyBzcGktCj4gc3RtMzIuY8Kg
Cj4gZmlsZSwgSSB0aGluayB0aGF0IGNvbW1vbiBjb2RlIGNvdWxkIGJlIGZhY3RvcmVkIGFuZCBz
cGVjaWZpY2l0aWVzCj4gY291bGTCoAo+IGJlIGhhbmRsZWQgd2l0aCBjb21wYXRpYmxlIGFuZCBt
YXRjaCBkYXRhLgoKSSBoYXZlIHNlZW4gdGhlc2UgZHJpdmVycyBiZWZvcmUuIEkgaGF2ZSBiZWVu
IHRyeWluZyB0byBkbyB0aGlzIGZvciBteQpwcmV2aW91cyBhcHByb2FjaCBhbmQgaXQgaXMgc3Rp
bGwgb24gbXkgc2Vjb25kIGJyYW5jaC4gVGhlcmUgd2FzIG5vdAp0b28gbXVjaCBjb21tb24gcGFy
dHMgYW5kIEkgaGF2ZSBzdHVjayB3aXRoIGNvbXBsZXggY29tcGF0aWJsZSBkYXRhCmNvbmZpZ3Vy
YXRpb25zLiBJIHRob3VnaHQgdGhhdCB3YXMgdG9vIHZlcmJvc2UsIHRoZXJlZm9yZSBJIHJlc2ln
bmVkCmZvciBpdCBhbmQgaGF2ZSBnb25lIGludG8gaWRlYSB3aXRoIHR3byB0b3RhbGx5IGRpZmZl
cmVudCBmaWxlcy4gSQp0aGluayBJIG5lZWQgdG8gZ2V0IGRvd24gYWdhaW4gdG8gaWRlYSB5b3Ug
cHJvcG9zZWQuwqAKCkl0IHNlZW1zIHRvIGJlIG1vcmUgZGlmZmljdWx0IGFwcHJvYWNoIGFuZCBp
dCBpcyBnb25uYSB0YWtlIGEgd2hpbGUKYmVmb3JlIEkgc2VuZCBzZWNvbmQgdmVyc2lvbiBvZiB0
aGVzZSBwYXRjaGVzLgoKUmVnYXJkcywKQ2V6YXJ5Cgo+IFJlZ2FyZHMsCj4gQW1lbGllCj4gWzFd
wqAKPiBodHRwczovL3d3dy5zdC5jb20vY29udGVudC9jY2MvcmVzb3VyY2UvdGVjaG5pY2FsL2Rv
Y3VtZW50L3JlZmVyZW5jZV8KPiBtYW51YWwvYzUvY2YvZWYvNTIvYzAvZjEvNGIvZmEvRE0wMDEy
NDg2NS5wZGYvZmlsZXMvRE0wMDEyNDg2NS5wZGYvamMKPiByOmNvbnRlbnQvdHJhbnNsYXRpb25z
L2VuLkRNMDAxMjQ4NjUucGRmCj4gCj4gPiAKPiA+IEZvciBjdXJyZW50IHZlcnNpb24gbWFzdGVy
IG1vZGUgd2l0aCBmdWxsLWR1cGxleCBhbmQgOC8xNiBiaXQgZGF0YQo+ID4gZnJhbWUKPiA+IGZv
cm1hdCBhcmUgc3VwcG9ydGVkLiBUaGVyZSBpcyBubyBUWCBhbmQgUlggRklGT3MgbGlrZSBpbiBT
VE0zMkg3Lgo+ID4gRE1BIGNhcGFiaWxpbGl0eSBpcyBzdXBwb3J0ZWQgZm9yIG1lc3NhZ2VzIGxv
bmdlciB0aGFuIGFyYml0cmFyeQo+ID4gbnVtYmVyCj4gPiBvZiBieXRlcyAodGhhdCBpcyBzZXQg
YWxyZWFkeSB0byAxNiBieXRlcykgd2hlbiBUWCBhbmQgUlggY2hhbm5lbHMKPiA+IGFyZQo+ID4g
c2V0IGF0IHRoZSBzYW1lIHRpbWUuCj4gPiAKPiA+IENlemFyeSBHYXBpbnNraSAoNSk6Cj4gPiDC
oMKgwqBzcGk6IHN0bTMyOiByZW5hbWUgU1RNMzIgU1BJIHJlZ2lzdGVycyBhbmQgZnVuY3Rpb25z
IHRvIFNUTTMySDcKPiA+IMKgwqDCoHNwaTogc3RtMzI6IHJlbmFtZSBzcGktc3RtMzIgdG8gc3Bp
LXN0bTMyaDcKPiA+IMKgwqDCoHNwaTogc3RtMzI6IGFkZCBkcml2ZXIgZm9yIFNUTTMyRjQgY29u
dHJvbGxlcgo+ID4gwqDCoMKgQVJNOiBkdHM6IHN0bTMyOiBhZGQgU1BJIHN1cHBvcnQgb24gU1RN
MzJGNDI5IFNvQwo+ID4gwqDCoMKgc3BpOiBzdG0zMjogYWRkIGRlc2NyaXB0aW9uIGFib3V0IFNU
TTMyRjQgYmluZGluZ3MKPiA+IAo+ID4gwqAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3Nw
aS1zdG0zMi50eHTCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqDCoDkgKy0KPiA+IMKgIGFyY2gv
YXJtL2Jvb3QvZHRzL3N0bTMyZjQyOS5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB8wqDCoMKgNjAgKwo+ID4gwqAgZHJpdmVycy9zcGkvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDC
oMKgMTggKy0KPiA+IMKgIGRyaXZlcnMvc3BpL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqAzICstCj4g
PiDCoCBkcml2ZXJzL3NwaS9zcGktc3RtMzIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAxMzIyIC0tLS0tCj4gPiAtLS0tLS0tLS0tLS0t
LQo+ID4gwqAgZHJpdmVycy9zcGkvc3BpLXN0bTMyZjQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDEwMDIKPiA+ICsrKysrKysrKysrKysrKwo+
ID4gwqAgZHJpdmVycy9zcGkvc3BpLXN0bTMyaDcuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDEzNDAKPiA+ICsrKysrKysrKysrKysrKysrKysr
Cj4gPiDCoCA3IGZpbGVzIGNoYW5nZWQsIDI0MjQgaW5zZXJ0aW9ucygrKSwgMTMzMCBkZWxldGlv
bnMoLSkKPiA+IMKgIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktc3RtMzIuYwo+
ID4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3BpL3NwaS1zdG0zMmY0LmMKPiA+IMKg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NwaS9zcGktc3RtMzJoNy5jCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
