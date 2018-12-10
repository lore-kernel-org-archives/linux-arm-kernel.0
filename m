Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B7F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yty18ZeH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pefGxJ1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B7F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jwYeiSle58lg3D7ptQAwd5A5Lc1Uz4iNlJEy/qq6wZ8=; b=Yty18ZeHEJBHL8
	V57BNxLPB6HJ2KtvJYIoNa48mFsqNmaOqo/RQgfwaDSR1Ykz6oExcx2y7qqWafbG0IGfp6uFnr8Dg
	nhzzFeM9eaieu4a+2/JBUkISs3IIgIPY4xKWX+Hn6BIBN5jiwCuoofxBjhg7WHvk7POhxM8DNnTNs
	f/v4fvx2g79bsn3zTWAZlm7xLlr1HvJzyN5UNGcKG0epHKjgorZ9hXWzM9AL5iyKkPRK3u7jubGTt
	wvLf+5srlxy8uGn+XqFn4IzAzmAKbThZkYjTg3l/IpoDzP0iBfhGvu/XRk+efWOq+Xjjf5xx6LTdR
	euQHneKuSDau43xUzwaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOPm-0008Bd-Uf; Mon, 10 Dec 2018 16:28:14 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOPj-0008BB-GL
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:28:13 +0000
Received: by mail-it1-x143.google.com with SMTP id z7so18241821iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rq61FvlLTrrBLq40FzRBJbUAVudtRm7lWLwCmjfQZrk=;
 b=pefGxJ1wdWrCKqMIH/RWxtn6Wuw8rTjsxbi8ePQJjoKwPfNhQt30rxwMys5fbbrQzt
 /ajFJNdFjhSElyNWLLk6n8BB6t1JtPH2O+Pl3oXj+CHp8DzwRhD3935pgN5rhN3DWGFx
 enJxn6GNVqt01Cxv3+VVWKjXpiN8HYmu0YsrYVkTtIQn4yTf46lUmUDP6tJiaHkm3Oe+
 L8lMt5KPaJPlppSkyQlzW6fxi8BJ7cUkEZt9KEiKLmr1+PcJU9D7xc6YNQ2+AGaOd58Q
 HKo3zwlSWCKeN3ZCAs+hHe/cIzkXhwmP7uNmXVI7naqQIHYO1i4YerW2EFL255wZkdI7
 pNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rq61FvlLTrrBLq40FzRBJbUAVudtRm7lWLwCmjfQZrk=;
 b=A/MC96XOxJL3T52761ZBD+MrEdTCEZIbRBwMvZ6qHEX27XZ/pW8glIye8yg0acNp3z
 1xeTf1ymLbX8RRCFLfvvgXovxvLpC1CYUCzgxgmlcPi2iPmTZGJMhijIhWi8bhLEFDQz
 yCXWldbFjjA+L2DwlbPlMTOakyyHwr2+0FMRnCG/IG52ilsbIbRGdF7c3jbHswZlQqUB
 0mlvdoTDeaeydbbbvDb65ZiaAVV0X2k+EOLJ6ewWbaz9XFAYg1OBb+S/6uIkHS9k7p1w
 wpX2xuAHJlnRyQltA+3nW+9gda01qcxT6yA/asbVPtk8oLru86KfeoWZhM6LmhfmO6dv
 xf1g==
X-Gm-Message-State: AA+aEWb66sBFWez71BjqeNdAnukOF2QkBHZ+dvVueSBC3a5ELgK3XADx
 yXXI986PC1yTcYAwLfNoV3d2ARBacTtT9116JVI=
X-Google-Smtp-Source: AFSGD/UtUcvZNe3jXrL9v/Cfw5manMyFZ06OJ6tVFeNwDlyQbE5C7Y2GOKRFKSnIOS8U4jhF/K5TG1d404w+3XLUCGc=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr11958588jab.60.1544459280133; 
 Mon, 10 Dec 2018 08:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
 <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
In-Reply-To: <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Tue, 11 Dec 2018 00:27:49 +0800
Message-ID: <CAEExFWta3+EfvGODb58R8_3-=iMwJet0iGPY9zu8LmWFEMV2Fg@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_082811_549633_A367B942 
X-CRM114-Status: GOOD (  20.10  )
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
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgNzo1OSBQTSBEYW5pZWwgTGV6Y2Fubwo8ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZz4gd3JvdGU6Cj4KPgo+IEhpIFlhbmd0YW8sCj4KPgo+IE9uIDIwLzEx
LzIwMTggMTc6MTQsIFlhbmd0YW8gTGkgd3JvdGU6Cj4gPiBvZl9maW5kX25vZGVfYnlfcGF0aCgp
IGFjcXVpcmVzIGEgcmVmZXJlbmNlIHRvIHRoZSBub2RlCj4gPiByZXR1cm5lZCBieSBpdCBhbmQg
dGhhdCByZWZlcmVuY2UgbmVlZHMgdG8gYmUgZHJvcHBlZCBieSBpdHMgY2FsbGVyLgo+ID4gYmxf
aWRsZV9pbml0KCkgZG9lc24ndCBkbyB0aGF0LCBzbyBmaXggaXQuCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgo+ID4gLS0tCj4gPiBDaGFu
Z2VzIGluIHYzOgo+ID4gLXVwZGF0ZSBjaGFuZ2Vsb2cKPiA+IC0tLQo+ID4gIGRyaXZlcnMvY3B1
aWRsZS9jcHVpZGxlLWJpZ19saXR0bGUuYyB8IDYgKysrKystCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRs
ZS1iaWdfbGl0dGxlLmMKPiA+IGluZGV4IGRiMmVkZTU2NWYxYS4uNjUwZjA2M2VmODA5IDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9jcHVpZGxlL2NwdWlkbGUtYmlnX2xpdHRsZS5jCj4gPiArKysg
Yi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMKPiA+IEBAIC0xNzQsOCArMTc0
LDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGJsX2lkbGVfaW5pdCh2b2lkKQo+ID4gICAgICAgLyoK
PiA+ICAgICAgICAqIEluaXRpYWxpemUgdGhlIGRyaXZlciBqdXN0IGZvciBhIGNvbXBsaWFudCBz
ZXQgb2YgbWFjaGluZXMKPiA+ICAgICAgICAqLwo+ID4gLSAgICAgaWYgKCFvZl9tYXRjaF9ub2Rl
KGNvbXBhdGlibGVfbWFjaGluZV9tYXRjaCwgcm9vdCkpCj4gPiArICAgICBpZiAoIW9mX21hdGNo
X25vZGUoY29tcGF0aWJsZV9tYWNoaW5lX21hdGNoLCByb290KSl7Cj4gPiArICAgICAgICAgICAg
IG9mX25vZGVfcHV0KHJvb3QpOwo+ID4gICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsKPiA+
ICsgICAgIH0KPiA+ICsKPiA+ICsgICAgIG9mX25vZGVfcHV0KHJvb3QpOwo+Cj4gRG9uJ3QgZHVw
bGljYXRlIHRoZSBvZl9ub2RlX3B1dC4KPgo+IEkgc3VnZ2VzdDoKPgo+IGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgKm1hdGNoX2lkOwo+Cj4gWyAuLi4gXQo+Cj4KPiBtYXRjaF9pZCA9IG9mX21h
dGNoX25vZGUoY29tcGF0aWJsZV9tYWNoaW5lX21hdGNoLCByb290KTsKPgo+IG9mX25vZGVfcHV0
KHJvb3QpOwo+Cj4gaWYgKCFtYXRjaF9pZCkKPiAgICAgICAgIHJldHVybiAtRU5PREVWOwo+Cj4K
VGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24sIHRoZSBuZXcgb25lIGhhcyBiZWVuIHNlbnQu
CgpZb3VycywKWWFuZ3Rhbwo+ID4gICAgICAgaWYgKCFtY3BtX2lzX2F2YWlsYWJsZSgpKQo+ID4g
ICAgICAgICAgICAgICByZXR1cm4gLUVVTkFUQ0g7Cj4gPgo+Cj4KPiAtLQo+ICA8aHR0cDovL3d3
dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFS
TSBTb0NzCj4KPiBGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2Vz
L0xpbmFybz4gRmFjZWJvb2sgfAo+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBU
d2l0dGVyIHwKPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
