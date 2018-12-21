Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:08:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F2721908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i4v3l3yJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPKl4n9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F2721908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L56IDOMhlJORLtiEa3obw8bGpJo1qq7h+pRFPOJr/Og=; b=i4v3l3yJaa0i9L
	JX5yl8vyuEsfrPZktFsEmX3LXz81ILlRAielyFqMAVBKXKDE3MA0wi2HnAHnn0xRJBYaQfIkJa1P6
	aw/H6gqytu2FSSKW1Ebq/NISSW2/A93pLZ7XuGgOkXPR1MIfzGmt3YhFrIJXy/WXxJUcOff2Ef8v/
	ZBWAEJqeMuLCU9NS9zyMS50ZtjLwIubLC655Kx9P+AAhL+bQIsDXjHLUZ3pL040j+PBrFDyRISB1D
	eidxgOFRZmVm4FzXbF26+ysVxdfGsxqlGaESZxU3aDesLL0+Ue9UPQsdqRGsATnYUF/1gMggdlfxa
	PXk997M7swP88h5Ny2jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIfG-00060y-H4; Fri, 21 Dec 2018 11:08:22 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIfD-000606-Lq
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:08:21 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so4934543wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1jp1Ws1IdkETdpE/4LoStqL7EzwAyXIkAS6IH/WY904=;
 b=dPKl4n9Ym1z/DKrnolMo6TH4L5qUcxWk14B4fGQOT0qbyAZ/0EP4g8ygZdJvxIsZ2X
 39Fom4RPTACmi6hUqvt32F8W1dOO/pWHZCZRMaNBN8ReKgmYwD6Rsryav9cGRkHF8eu7
 3BLdpKtTgiLDu/xMrYYnvJeLZvNN7l7XLK2H4AVqle7GFhPtQtxR+aHZrpMmInGNVcY8
 tlo7Co5Y0fYpuVQ8C0jbMtjKsQfRKLYyssvR32S2lquuSAbVGF1GfEC8KqH2ejn0Qt9u
 Fl4dWTX74oUGNVqsda24aevM7UwbXWbB1kpi5DVv2A1n7qTbmUlsiUj6Llex3FE4rFp2
 SeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1jp1Ws1IdkETdpE/4LoStqL7EzwAyXIkAS6IH/WY904=;
 b=hXPg5U+9cU/HFfMq8nnrQRBk0M9Rcnxuj5l25vR3dmfj/2MqbInva8LDFQdTJNOUu1
 5MfKR/lrscAvtONKsyBkWJO3uk1Ax9sS8wiHbQyWLqVCS2fLBw2YZP/6QUreb6wfx2tV
 s9GVxvI7jd1LS7C644HAbeKd5Ar44KfjTuE8DgCGBR7wq860xpQvYj3Vr5RV3PY3Jw2s
 e6rt5LB/XO+3LpyumDMltr/uWyu2q+ltN6+loFyQG9uTK2f4YAid1N6b/3C1HJEbB0tr
 Nv3v4HuaHHQguJZVZjPnG2Ji5sR2FqDM9o3TjIgn/gnZ60ALI6Qx9rhZgpcvKrZ9oiss
 5jLw==
X-Gm-Message-State: AA+aEWaz6J4lY4g/jnvrjR716T1fEHTMDrrpFTjC0Y9OL1HbZH/3Klms
 lckAOZJni4TX4o/8KDlAl6jjWIArPlf5RaTHmgs=
X-Google-Smtp-Source: ALg8bN50JfP05o9cFE3J91DIAmFWjbKKszSug5hSTZJTaexe8QXkBkeNsnkoZL5JdgDopHvId7z1mpmo7uxDmujYyho=
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr2409108wmf.3.1545390487407; 
 Fri, 21 Dec 2018 03:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20181218155744.19409-1-zajec5@gmail.com>
 <CACRpkdYoZtZci3BJ=-2AGr4vz7-OVJ9UwppYviMAiotBn2EU6Q@mail.gmail.com>
In-Reply-To: <CACRpkdYoZtZci3BJ=-2AGr4vz7-OVJ9UwppYviMAiotBn2EU6Q@mail.gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 21 Dec 2018 12:07:56 +0100
Message-ID: <CACna6rx2P3ncP6ekksxGVZGBJ6YQtsOFkv6eK0BTxvMDRHZHxg@mail.gmail.com>
Subject: Re: [PATCH fixes 4.20] dt-bindings: pinctrl: bcm4708-pinmux: rework
 binding to use syscon
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_030819_736143_0BEEBC6F 
X-CRM114-Status: GOOD (  22.13  )
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
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMSBEZWMgMjAxOCBhdCAxMTo0NSwgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPiB3cm90ZToKPiBPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCA0OjU4IFBNIFJh
ZmHFgiBNacWCZWNraSA8emFqZWM1QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiA+IEZyb206IFJhZmHF
giBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KPiA+Cj4gPiBBcyBwb2ludGVkIGJ5IFJvYiwg
Q1JVIGlzIGEga2luZCBvZiBibG9jayB0aGF0IGNhbid0IGJlIGd1YXJhbnRlZWQgdG8KPiA+IGhh
dmUgZXZlcnl0aGluZyBleHBvc2VkIGFzIHN1Ym5vZGVzLiBJdCdzIGEgc2V0IG9mIHZhcmlvdXMg
cmVnaXN0ZXJzCj4gPiB0aGF0IGFyZW4ndCB0aWVkIHRvIGFueSBzaW5nbGUgZGV2aWNlLiBJdCBj
b3VsZCBiZSBkZXNjcmliZWQgbXVjaCBtb3JlCj4gPiBhY2N1cmF0ZWx5IGFzIE1GRCAoTXVsdGkt
RnVuY3Rpb24gRGV2aWNlKS4KPiA+Cj4gPiBTb21lIGhhcmR3YXJlIGJsb2NrcyBtYXkgaW5kZWVk
IHdhbnQgdG8gYWNjZXNzIGEgcmVnaXN0ZXIgb3IgdHdvIG9mIHRoZQo+ID4gQ1JVIHdoaWNoIHJl
cXVpcmVzIGRlc2NyaWJpbmcgaXQgYXMgdGhlICJzeXNjb24iLgo+ID4KPiA+IFdoaWxlIGF0IGl0
IHJlcGxhY2UgZXhtcGxlIG5vZGUgbmFtZSB3aXRoIHRoZSBzdGFuZGFyZCAicGluY3RybCIgKGFs
c28KPiA+IHBvaW50ZWQgb3V0IGJ5IFJvYikuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUmFmYcWC
IE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgo+ID4gLS0tCj4gPiBIaSBMaW51cywKPiA+Cj4g
PiBBZnRlciBiZWluZyBwaW5nZWQgYWJvdXQgdGhlIHBpbmN0cmwgZHJpdmVyIEkgcmVhbGl6ZWQg
SSBuZXZlciBhZGRyZXNzZWQKPiA+IFJvYidzIGNvbW1lbnRzIGZyb20gdGhlIGUtbWFpbCB0aHJl
YWQ6Cj4gPgo+ID4gW1BBVENIXSBkdC1iaW5kaW5nczogcGluY3RybDogYmNtNDcwOC1waW5tdXg6
IGltcHJvdmUgZXhhbXBsZSBiaW5kaW5nCj4gPiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0
cy9hcm0ta2VybmVsL21zZzY4MjgzOC5odG1sCj4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzk4NDAyNC8KPiA+Cj4gPiBSb2IgaGFzIHBvaW50ZWQgY29ycmVjdGx5IChhcyBh
bHdheXMpIHRoYXQgZGVzY3JpYmluZyBDUlUgdXNpbmcKPiA+ICJzaW1wbGUtYnVzIiBoYXMgaXRz
IGltcGxpY2F0aW9ucyBhbmQgbWF5IGh1bnQgdXMgYmFjayBpZiB3ZSBldmVyCj4gPiByZWFsaXpl
IHdlIHdpbGwgd2FudCB0byByZWZlcmVuY2UgaXQgYXMgInN5c2NvbiIuIFRoYXQgaXMgcHJldHR5
IGxpa2VseQo+ID4gYWN0dWFsbHkuCj4gPgo+ID4gVG8gZml4IHRoYXQgd2hpbGUgc3RpbGwgcG9z
c2libGUgKGJlZm9yZSBoYXZpbmcgdGhhdCBEb2N1bWVudGF0aW9uIGluCj4gPiBhbnkgc3RhYmxl
IHJlbGVhc2UpIEknZCBsaWtlIHlvdSB0byBjb25zaWRlciB0YWtpbmcgdGhpcyBwYXRjaCBmb3Ig
dGhlCj4gPiA0LjIwIHJlbGVhc2UgaWYgeW91IGZpbmQgaXQgcG9zc2libGUuCj4gPgo+ID4gSSdt
IHdlbGwgYXdhcmUgaXQncyBkYW1uIGxhdGUuIEknbSBhd2FyZSBJJ3ZlIHNjcmV3ZWQgdXAuIEkn
bSBzb3JyeS4KPiA+Cj4gPiBJJ20gYWZyYWlkIEkgY2Fubm90IGZpeCBpdCBhbnlob3cuIEp1c3Qg
dGFrZSBhIGxvb2sgYXQgdGhhdCBwYXRjaCBhbmQKPiA+IGZlZWwgZnJlZSB0byBzYXkgSSdtIGNy
YXp5IGNvbWluZyB3aXRoIGl0IHNvIGxhdGUuCj4KPiBJIGp1c3QgYXBwbGllZCBpdC4gSXQncyBu
b3QgbGlrZSBpdCdzIGV0Y2hlZCBpbiBzdG9uZSB0aG91Z2ggc29tZQo+IHBlb3BsZSBtYXkgaGF2
ZSB0aGF0IG1lbnRhbCBtb2RlbC4KPgo+IElmIHRoZSBEVCBtYWludGFpbmVycyBoYXZlIGZ1cnRo
ZXIgY29uY2VybnMgd2UgY2FuIHBhdGNoIGl0Cj4gYWdhaW4uCj4KPiBSb3VnaCBjb25zZW5zdXMg
YW5kIHJ1bm5pbmcgY29kZS4KClRoYW5rIHlvdSwgSSBhcHByZWNpYXRlIGl0IQoKLS0gClJhZmHF
ggoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
