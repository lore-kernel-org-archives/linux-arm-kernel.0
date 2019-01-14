Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52860C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:32:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24720206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aqpBP95J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn6tQliK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24720206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VqO7HZ/TgkhtaIPzYzgnqhuJxPVD5Uf37TNWMeWOC5Y=; b=aqpBP95JC0ISr9
	6GDw3XzzJzRbQEoc4oPLCHQPU3mbIHuD6NwwJOgWg+YB20UlPW7fSK+VyRlBYaPEYhvJ7o2VxmEfL
	mjXG19adfk+QB29buNlqt15sjjFvdVF1YLoK2WVnbWxrzACjQqAWXHijmS3N6hCFWkGlwSXVgxTbV
	+pONOpecvjjOfIVOB15+K67QKJp2XRbgPxFleqUXisIMH1C/VjfivrmOrizs8z2MqaFmvNgRUX3/m
	15UGlOM3bHv6CqK6VQklchLK9epNNudiyIMGpcItcshuESLQdMp0ruqJOzGefCebYQ5Y3C7NRnrrq
	6fnM3PAiboRLsMM8hxOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj665-0002ul-Rw; Mon, 14 Jan 2019 17:32:25 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj662-0002uC-EX
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 17:32:24 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so526633itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Lon8tNsCczXJvWjqQHnVoBIEeu+cAbP+MjUAFfIh39c=;
 b=Xn6tQliKGKTyiMW4S56/4bxP0k2GoScUhCKx8uOAaFbqv/e3dP+mYUy8+00SeHNelA
 8sYHbpdVpe8dwb7n0See/lvuudkLCRP26HCJoKM8jmUrbZqc/D1VNeLjxXoRUg4Dlrk0
 RhIPUhbGyiOXF5IAv2V7IPfGV50mTdX4U0pU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Lon8tNsCczXJvWjqQHnVoBIEeu+cAbP+MjUAFfIh39c=;
 b=WR2PAx5CUixZetReP7asrL9TYOS+bhFHGA7ptG7sb5zlZ79ZDQlEBUQtunQ4tnE7Jj
 y/tWRE9NebtbZxnApfbbd0UiBaHTe5vaw6QcCPCr7BMsO5q6za7zEOSXSCDIrnl2gtc7
 55THCV0AqJqK2bNdLs74ChdKYdPkrj+AVk4rvNpsfP9d8VWSZZBVqBtgBiu6Qq5skKcM
 9JAOA8NsRfZzQOTW4ji/87neKoK4bpPOfioyYyZ42/9fc3NT4RqnDOut2zY3MeiiAvFW
 VrT7AJ1vJLmWlxfNTDuKYjuqMOkYbWiZHxKsAzO48/HYiR5Iu5dEbnEW72VOqkgE9Fz5
 htLA==
X-Gm-Message-State: AJcUukfGHB6+BhEAEWQu2+dUZ6aTwGAxuQKu/NSov9KGxpZO974+7UkN
 gj9IQ39dlh4XuhQSYAgL2RRtU3RdGwQZTl1zi4cmgA==
X-Google-Smtp-Source: ALg8bN7LwnhGxjH0IjV02t7n03vg1554jRMyag91Inu77Un7OXoFtC7ntX9sZdZKhima7d8TsTD06wbnH0LXv0NEj5w=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr143075itk.71.1547487141179; 
 Mon, 14 Jan 2019 09:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
In-Reply-To: <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 Jan 2019 18:32:10 +0100
Message-ID: <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_093222_526582_60698C7C 
X-CRM114-Status: GOOD (  35.87  )
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
Cc: Carsten Haitzler <Carsten.Haitzler@arm.com>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxNCBKYW4gMjAxOSBhdCAxMjozOCwgS29lbmlnLCBDaHJpc3RpYW4KPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAxNC4wMS4xOSB1bSAxMTo1MyBzY2hyaWVi
IEFyZCBCaWVzaGV1dmVsOgo+ID4gT24gVGh1LCAxMCBKYW4gMjAxOSBhdCAxMDozNCwgTWljaGVs
IETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4gT24gMjAxOS0wMS0xMCA4
OjI4IGEubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+ID4+PiBBUk0gc3lzdGVtcyBkbyBub3Qg
cGVybWl0IHRoZSB1c2Ugb2YgYW55dGhpbmcgb3RoZXIgdGhhbiBjYWNoZWQKPiA+Pj4gbWFwcGlu
Z3MgZm9yIHN5c3RlbSBtZW1vcnksIHNpbmNlIHRoYXQgbWVtb3J5IG1heSBiZSBtYXBwZWQgaW4g
dGhlCj4gPj4+IGxpbmVhciByZWdpb24gYXMgd2VsbCwgYW5kIHRoZSBhcmNoaXRlY3R1cmUgZG9l
cyBub3QgcGVybWl0IGFsaWFzZXMKPiA+Pj4gd2l0aCBtaXNtYXRjaGVkIGF0dHJpYnV0ZXMuCj4g
Pj4+Cj4gPj4+IFNvIHNob3J0LWNpcmN1aXQgdGhlIGV2YWx1YXRpb24gaW4gdHRtX2lvX3Byb3Qo
KSBpZiB0aGUgZmxhZ3MgaW5jbHVkZQo+ID4+PiBUVE1fUExfU1lTVEVNIHdoZW4gcnVubmluZyBv
biBBUk0gb3IgYXJtNjQsIGFuZCBqdXN0IHJldHVybiBjYWNoZWQKPiA+Pj4gYXR0cmlidXRlcyBp
bW1lZGlhdGVseS4KPiA+Pj4KPiA+Pj4gVGhpcyBmaXhlcyB0aGUgcmFkZW9uIGFuZCBhbWRncHUg
W1RCQ10gZHJpdmVycyB3aGVuIHJ1bm5pbmcgb24gYXJtNjQuCj4gPj4+IFdpdGhvdXQgdGhpcyBj
aGFuZ2UsIGFtZGdwdSBkb2VzIG5vdCBzdGFydCBhdCBhbGwsIGFuZCByYWRlb24gb25seQo+ID4+
PiBwcm9kdWNlcyBjb3JydXB0IGRpc3BsYXkgb3V0cHV0Lgo+ID4+Pgo+ID4+PiBDYzogQ2hyaXN0
aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4+PiBDYzogSHVhbmcgUnVp
IDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+Pj4gQ2M6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdA
YW1kLmNvbT4KPiA+Pj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiA+Pj4g
UmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJAYXJtLmNvbT4K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFy
by5vcmc+Cj4gPj4+IC0tLQo+ID4+PiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwu
YyB8IDUgKysrKysKPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPj4+
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMKPiA+Pj4gaW5kZXggMDQ2YTZkZGE2OTBh
Li4wYzFlZWY1ZjdhZTMgMTAwNjQ0Cj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X2JvX3V0aWwuYwo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMK
PiA+Pj4gQEAgLTUzMCw2ICs1MzAsMTEgQEAgcGdwcm90X3QgdHRtX2lvX3Byb3QodWludDMyX3Qg
Y2FjaGluZ19mbGFncywgcGdwcm90X3QgdG1wKQo+ID4+PiAgICAgICAgaWYgKGNhY2hpbmdfZmxh
Z3MgJiBUVE1fUExfRkxBR19DQUNIRUQpCj4gPj4+ICAgICAgICAgICAgICAgIHJldHVybiB0bXA7
Cj4gPj4+Cj4gPj4+ICsjaWYgZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9f
KQo+ID4+PiArICAgICAvKiBBUk0gb25seSBwZXJtaXRzIGNhY2hlZCBtYXBwaW5ncyBvZiBzeXN0
ZW0gbWVtb3J5ICovCj4gPj4+ICsgICAgIGlmIChjYWNoaW5nX2ZsYWdzICYgVFRNX1BMX1NZU1RF
TSkKPiA+Pj4gKyAgICAgICAgICAgICByZXR1cm4gdG1wOwo+ID4+PiArI2VuZGlmCj4gPj4+ICAg
I2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykKPiA+Pj4gICAgICAg
IGlmIChjYWNoaW5nX2ZsYWdzICYgVFRNX1BMX0ZMQUdfV0MpCj4gPj4+ICAgICAgICAgICAgICAg
IHRtcCA9IHBncHJvdF93cml0ZWNvbWJpbmUodG1wKTsKPiA+Pj4KPiA+PiBBcGFydCBmcm9tIENo
cmlzdGlhbidzIGNvbmNlcm5zLCBJIHRoaW5rIHRoaXMgaXMgdGhlIHdyb25nIHBsYWNlIGZvcgo+
ID4+IHRoaXMsIGJlY2F1c2Ugb3RoZXIgVFRNIC8gZHJpdmVyIGNvZGUgd2lsbCBzdGlsbCBjb25z
aWRlciB0aGUgbWVtb3J5Cj4gPj4gdW5jYWNoZWFibGUuIEUuZy4gdGhlIGFtZGdwdSBkcml2ZXIg
d2lsbCBwcm9ncmFtIHRoZSBHUFUgdG8gdHJlYXQgdGhlCj4gPj4gbWVtb3J5IGFzIHVuY2FjaGVh
YmxlLCBzbyBpdCB3b24ndCBwYXJ0aWNpcGF0ZSBpbiBjYWNoZSBjb2hlcmVuY3kKPiA+PiBwcm90
b2NvbCBmb3IgaXQsIHdoaWNoIGlzIHVubGlrZWx5IHRvIHdvcmsgYXMgZXhwZWN0ZWQgaW4gZ2Vu
ZXJhbCBpZiB0aGUKPiA+PiBDUFUgdHJlYXRzIHRoZSBtZW1vcnkgYXMgY2FjaGVhYmxlLgo+ID4+
Cj4gPiBXaWxsIGFuZCBJIGhhdmUgc3BlbnQgc29tZSB0aW1lIGRpZ2dpbmcgaW50byB0aGlzLCBz
byBhbGxvdyBtZSB0bwo+ID4gc2hhcmUgc29tZSBwcmVsaW1pbmFyeSBmaW5kaW5ncyB3aGlsZSB3
ZSBjYXJyeSBvbiBhbmQgdHJ5IHRvIGZpeCB0aGlzCj4gPiBwcm9wZXJseS4KPiA+Cj4gPiAtIFRo
ZSBwYXRjaCBhYm92ZSBpcyBmbGF3ZWQsIGkuZS4sIGl0IGRvZXNuJ3QgZG8gd2hhdCBpdCBpbnRl
bmRzIHRvCj4gPiBzaW5jZSBpdCB1c2VzIFRUTV9QTF9TWVNURU0gaW5zdGVhZCBvZiBUVE1fUExf
RkxBR19TWVNURU0uIEFwb2xvZ2llcwo+ID4gZm9yIHRoYXQuCj4gPiAtIFRoZSBleGlzdGVuY2Ug
b2YgYSBsaW5lYXIgcmVnaW9uIG1hcHBpbmcgd2l0aCBtaXNtYXRjaGVkIGF0dHJpYnV0ZXMKPiA+
IGlzIGxpa2VseSBub3QgdGhlIGN1bHByaXQgaGVyZS4gKFdlIGRvIHNvbWV0aGluZyBzaW1pbGFy
IHdpdGgKPiA+IG5vbi1jYWNoZSBjb2hlcmVudCBETUEgaW4gb3RoZXIgcGxhY2VzKS4KPgo+IFRo
aXMgaXMgc3RpbGwgcmF0aGVyIHByb2JsZW1hdGljLgo+Cj4gVGhlIGlzc3VlIGlzIHRoYXQgd2Ug
b2Z0ZW4gZG9uJ3QgY3JlYXRlIGEgdm1hcCBmb3IgYSBwYWdlLCBidXQgcmF0aGVyCj4gYWNjZXNz
IHRoZSBwYWdlIGRpcmVjdGx5IHVzaW5nIHRoZSBsaW5lYXIgbWFwcGluZy4KPgo+IFNvIHdlIHdv
dWxkIHVzZSB0aGUgd3JvbmcgYWNjZXNzIHR5cGUgaGVyZS4KPgoKWWVzLiBCdXQgaG93IGFyZSB0
aGVzZSBhY2Nlc3NlcyBkb25lPyBBcmUgdGhleSB3cmFwcGVkIGluIGEga21hcCgpPwoKPiA+IC0g
VGhlIHJlYXNvbiByZW1hcHBpbmcgdGhlIENQVSBzaWRlIGFzIGNhY2hlYWJsZSBkb2VzIHdvcmsg
KHdoaWNoIEkKPiA+IGRpZCB0ZXN0KSBpcyBiZWNhdXNlIHRoZSBHUFUncyB1bmNhY2hlYWJsZSBh
Y2Nlc3NlcyAod2hpY2ggSSBhc3N1bWUKPiA+IGFyZSBtYWRlIHVzaW5nIHRoZSBOb1Nub29wIFBD
SWUgdHJhbnNhY3Rpb24gYXR0cmlidXRlKSBhcmUgYWN0dWFsbHkKPiA+IGVtaXR0ZWQgYXMgY2Fj
aGVhYmxlIGluIHNvbWUgY2FzZXMuCj4gPiAgICAuIE9uIG15IEFNRCBTZWF0dGxlLCB3aXRoIG9y
IHdpdGhvdXQgU01NVSAod2hpY2ggaXMgc3RhZ2UgMiBvbmx5KSwgSQo+ID4gbXVzdCB1c2UgY2Fj
aGVhYmxlIGFjY2Vzc2VzIGZyb20gdGhlIENQVSBzaWRlIG9yIHRoaW5ncyBhcmUgYnJva2VuLgo+
ID4gVGhpcyBtaWdodCBiZSBhIGgvdyBmbGF3LCB0aG91Z2guCj4gPiAgICAuIE9uIHN5c3RlbXMg
d2l0aCBzdGFnZSAxKzIgU01NVXMsIHRoZSBkcml2ZXIgdXNlcyBzdGFnZSAxCj4gPiB0cmFuc2xh
dGlvbnMgd2hpY2ggYWx3YXlzIG92ZXJyaWRlIHRoZSBtZW1vcnkgYXR0cmlidXRlcyB0byBjYWNo
ZWFibGUKPiA+IGZvciBETUEgY29oZXJlbnQgZGV2aWNlcy4gVGhpcyBpcyB3aGF0IGlzIGFmZmVj
dGluZyB0aGUgQ2F2aXVtCj4gPiBUaHVuZGVyWDIgKGFsdGhvdWdoIGl0IGFwcGVhcnMgdGhlIGF0
dHJpYnV0ZXMgZW1pdHRlZCBieSB0aGUgUkMgbWF5IGJlCj4gPiBpbmNvcnJlY3QgYXMgd2VsbC4p
Cj4gPgo+ID4gVGhlIGxhdHRlciBpc3N1ZSBpcyBhIHNob3J0Y29taW5nIGluIHRoZSBTTU1VIGRy
aXZlciB0aGF0IHdlIGhhdmUgdG8KPiA+IGZpeCwgaS5lLiwgaXQgc2hvdWxkIHRha2UgY2FyZSBu
b3QgdG8gbW9kaWZ5IHRoZSBpbmNvbWluZyBhdHRyaWJ1dGVzCj4gPiBvZiBETUEgY29oZXJlbnQg
UENJZSBkZXZpY2VzIGZvciBOb1Nub29wIHRvIGJlIGFibGUgdG8gd29yay4KPiA+Cj4gPiBTbyBp
biBzdW1tYXJ5LCB0aGUgbWlzbWF0Y2ggYXBwZWFycyB0byBiZSBiZXR3ZWVuIHRoZSBDUFUgYWNj
ZXNzaW5nCj4gPiB0aGUgdm1hcCByZWdpb24gd2l0aCBub24tY2FjaGVhYmxlIGF0dHJpYnV0ZXMg
YW5kIHRoZSBHUFUgYWNjZXNzaW5nCj4gPiB0aGUgc2FtZSBtZW1vcnkgd2l0aCBjYWNoZWFibGUg
YXR0cmlidXRlcywgcmVzdWx0aW5nIGluIGEgbG9zcyBvZgo+ID4gY29oZXJlbmN5IGFuZCBsb3Rz
IG9mIHZpc2libGUgY29ycnVwdGlvbi4KPgo+IEFjdHVhbGx5IGl0IGlzIHRoZSBvdGhlciB3YXkg
YXJvdW5kLiBUaGUgQ1BVIHRoaW5rcyBzb21lIGRhdGEgaXMgaW4gdGhlCj4gY2FjaGUgYW5kIHRo
ZSBHUFUgb25seSB1cGRhdGVzIHRoZSBzeXN0ZW0gbWVtb3J5IHZlcnNpb24gYmVjYXVzZSB0aGUK
PiBzbm9vcCBmbGFnIGlzIG5vdCBzZXQuCj4KClRoYXQgZG9lc24ndCBzZWVtIHRvIGJlIHdoYXQg
aXMgaGFwcGVuaW5nLiBBcyBmYXIgYXMgd2UgY2FuIHRlbGwgZnJvbQpvdXIgZXhwZXJpbWVudHMs
IGFsbCBpbmJvdW5kIHRyYW5zYWN0aW9ucyBhcmUgYWx3YXlzIGNhY2hlYWJsZSwgYW5kIHNvCnRo
ZSBvbmx5IHdheSB0byBtYWtlIHRoaW5ncyB3b3JrIGlzIHRvIGVuc3VyZSB0aGF0IHRoZSBDUFUg
dXNlcyB0aGUKc2FtZSBhdHRyaWJ1dGVzLgoKPiA+IFRvIGJlIGFibGUgdG8gZGVidWcgdGhpcyBm
dXJ0aGVyLCBjb3VsZCB5b3UgZWxhYm9yYXRlIGEgYml0IG9uCj4gPiAtIEhvdyBkb2VzIHRoZSBo
YXJkd2FyZSBlbWl0IHRob3NlIHVuY2FjaGVkL3djIGluYm91bmQgYWNjZXNzZXM/IERvCj4gPiB0
aGV5IHJlbHkgb24gTm9Tbm9vcD8KPgo+IFRoZSBHUFUgaGFzIGEgc2VwYXJhdGUgcGFnZSB3YWxr
ZXIgaW4gdGhlIE1DIGFuZCB0aGUgcGFnZSB0YWJsZXMgdGhlcmUKPiBoYXZlIGEgYml0cyBzYXlp
bmcgaWYgdGhlIGFjY2VzcyBzaG91bGQgZ28gdG8gdGhlIFBDSWUgYnVzIGFuZCBpZiB5ZXMgaWYK
PiB0aGUgc25vb3AgYml0IHNob3VsZCBiZSBzZXQuCj4KPiA+IC0gQ2hyaXN0aWFuIHBvaW50ZWQg
b3V0IHRoYXQgc29tZSBhY2Nlc3NlcyBtdXN0IGJlIHVuY2FjaGVkIGV2ZW4gd2hlbgo+ID4gbm90
IHVzaW5nIFdDLiBXaGF0IGtpbmQgb2YgYWNjZXNzZXMgYXJlIHRob3NlPyBBbmQgZG8gdGhleSBh
Y2Nlc3MKPiA+IHN5c3RlbSBSQU0/Cj4KPiBPbiBzb21lIGhhcmR3YXJlIGdlbmVyYXRpb25zIHdl
IGhhdmUgYSBidWdneSBlbmdpbmUgd2hpY2ggZmFpbHMgdG8KPiBmb3J3YXJkIHRoZSBzbm9vcCBi
aXQgYW5kIGJlY2F1c2Ugb2YgdGhpcyB0aGUgc3lzdGVtIG1lbW9yeSBwYWdlIHVzZWQgYnkKPiB0
aGlzIGVuZ2luZSBtdXN0IGJlIHVuY2FjaGVkLiBCdXQgdGhpcyBvbmx5IGFwcGxpZXMgaWYgeW91
IHVzZSBST0NtIGluIGEKPiBzcGVjaWZpYyBjb25maWd1cmF0aW9uLgo+CgpPSy4gSSBkb24ndCBr
bm93IHdoYXQgdGhhdCBtZWFucyB0YmguIERvZXMgdGhpcyBhcHBseSB0byBib3RoIHJhZGVvbiBh
bmQgYW1kZ3B1PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
