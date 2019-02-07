Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9649C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:49:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2DE218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iDTnGJvk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="biERTSTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2DE218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WZXFmpw5MUJqbUuH+ByOvV5nf1tRPFeqPwfjiQ91ePY=; b=iDTnGJvk3+e89r
	l6hDkCGoblsHht72ZiTvxeA6zmHkB0VklOZ1uhuTTPRyjvKW2P0uDAxFTjuHLpF/Ea4tlgKpp9hIe
	PqbKYfwqhQIfA0JTK2NFoZjqUUX2E540A22JgVHcg+zBkXgaarshBL5tUc6HmxmJIG1+KDhIPlf9I
	FnYhkB2UsW1eG5lFXZ1NsV3rz+Zi3Z7IWsNxdF/a5IkunIk9J4GIncpbvvI1sgsI97Hg2qnuHCYin
	SVsAizncrso6sJQw6CATMMfCcRAdZatA+gAIC9pzI/Pi5ge0kQPjecJ5UL3+1JjtpdvW8480HpcGn
	Sta8nsIahOVLINSpbftQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlvp-0003wJ-ON; Thu, 07 Feb 2019 15:49:41 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlvm-0003v9-Oa
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:49:40 +0000
Received: by mail-it1-x141.google.com with SMTP id z20so795772itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UR8a1Ehz6ohzX06Q4NxlU9SbkeWbimRQ+O5ooyRfagw=;
 b=biERTSTP9OFBh7kox/lqYBoN2fRT7L9N74deC0E9eOqXW4iepSibfP9A2MlU79BLtG
 tHzj380gYXqk0W2gMXH80D/peQmFbH/MEUE/6vmSWSTa4V3jmzvwaXi8LNpKMKiyL9o4
 rP13nt291ukskzOqAocadS1SMWkBuxa8I5PmIrPn28ukNP8gZi0MWkb3BklrJ3phd339
 f+qvPeloMiDvJvALH5efK5bVInXIJUvLlRNOohy53Nfgp8WBBXUsdN3GadXrgAbYlC3N
 morhdSeuwi/zOCg5DnzOsFbKAIXDdPPpNxG5qIT0JqdGUi98KAPmcJKX2iKs7q5mta+E
 vBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UR8a1Ehz6ohzX06Q4NxlU9SbkeWbimRQ+O5ooyRfagw=;
 b=WEbngh9cY63sHJIPFv4UVXriHYf/+fSDCmjuoNLHtYJ6krKMUziaqsdUFo0UEM2AGb
 pd2PFc3UIkUohB1Bym6t98A/zC3fOy4dooPcVdhI+36gHpw7HLstSRGJq55s6fr/22s/
 Eq2HoZhU0NcqhOhAJg2f2rsYnbwfdwHzqkyjC1pH37WOT81GckoBbNeMenCNOJNCciRS
 NQYoFDhuuGaLiJnPBQwlNrN4bnw9dHymOcNCVbNEvaPI1Nqs4IcxoESW3Swb3o1UqQg6
 tn4SLcHNCgn2KE74Q8WtpWkuANd6OIjGYX3Cohj5hNz2jcNbfiX4EPlsG2U0NQnyVCZZ
 pDZw==
X-Gm-Message-State: AHQUAuZJMzQn7mmue0Pov/CiMWks0Zp7uuDAMU/O3aFDHYGULHTFansG
 ub0vdpbc2m1rqmNIXyRzxH1AqUcHaH0f5WeTn0RwGqQ2jHI=
X-Google-Smtp-Source: AHgI3IZW6DSydt7iXZqbioV9Cyh5ArByqWSgu0UjiF9m+iVNpmfHIifEApd2QeJmdJ811DgVpeTv83zMiSI9i4+LaIY=
X-Received: by 2002:a24:5d94:: with SMTP id w142mr4275426ita.74.1549554576631; 
 Thu, 07 Feb 2019 07:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-3-brgl@bgdev.pl>
 <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
In-Reply-To: <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 7 Feb 2019 16:49:25 +0100
Message-ID: <CAMRc=Me9gqfN6WuWPZ61M2pNC+ZrhxAX_=BzAr4_zxnfdL4G7Q@mail.gmail.com>
Subject: Re: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_074938_848948_07CE93D5 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

xZtyLiwgNiBsdXQgMjAxOSBvIDEzOjM5IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFw
aXNhxYIoYSk6Cj4KPiBPbiAzMS8wMS8xOSA3OjA4IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2NwX2ludGMuYyBi
L2FyY2gvYXJtL21hY2gtZGF2aW5jaS9jcF9pbnRjLmMKPiA+IGluZGV4IDY3ODA1Y2E3NGZmOC4u
YjlhZWMzYzQ4YTZhIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2NwX2lu
dGMuYwo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2NwX2ludGMuYwo+ID4gQEAgLTE5
LDYgKzE5LDcgQEAKPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPgo+ID4gICNpbmNs
dWRlIDxsaW51eC9vZl9pcnEuaD4KPiA+Cj4gPiArI2luY2x1ZGUgPGFzbS9leGNlcHRpb24uaD4K
PiA+ICAjaW5jbHVkZSA8bWFjaC9jb21tb24uaD4KPiA+ICAjaW5jbHVkZSAiY3BfaW50Yy5oIgo+
ID4KPiA+IEBAIC05Nyw2ICs5OCwxNiBAQCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIGNwX2ludGNf
aXJxX2NoaXAgPSB7Cj4gPgo+ID4gIHN0YXRpYyBzdHJ1Y3QgaXJxX2RvbWFpbiAqY3BfaW50Y19k
b21haW47Cj4gPgo+ID4gK3N0YXRpYyBhc21saW5rYWdlIHZvaWQgX19leGNlcHRpb25faXJxX2Vu
dHJ5Cj4gPiArY3BfaW50Y19oYW5kbGVfaXJxKHN0cnVjdCBwdF9yZWdzICpyZWdzKQo+ID4gK3sK
PiA+ICsgICAgIGludCBpcnFuciA9IGNwX2ludGNfcmVhZChDUF9JTlRDX1BSSU9fSURYKTsKPiA+
ICsKPiA+ICsgICAgIGlycW5yICY9IDB4ZmY7Cj4gPiArCj4gPiArICAgICBoYW5kbGVfZG9tYWlu
X2lycShjcF9pbnRjX2RvbWFpbiwgaXJxbnIsIHJlZ3MpOwo+Cj4gVGhpcyBsZWF2ZXMgb3V0IHNw
dXJpb3VzIGludGVycnVwdCBoYW5kbGluZyBwcmVzZW50IGluIGV4aXN0aW5nIGFzc2VtYmx5Cj4g
Y29kZS4gQ2FuIHlvdSBhZGQgaXQgYmFjay4gTWF5IGJlIHVzZSBvbWFwX2ludGNfaGFuZGxlX2ly
cSgpIGFzIGFuCj4gZXhhbXBsZSBmb3IgaGFuZGxpbmcgc3B1cmlvdXMgSVJRcy4KPgoKSGkgU2Vr
aGFyLAoKSSBzdGFydGVkIGxvb2tpbmcgYXQgdGhpcyBvbmUgYW5kIG5vdGljZWQgdGhhdCB0aGUg
bWFudWFsIHNheXMKUFJJX0lORFggZmllbGQgaW4gdGhlIEdQSVIgcmVnaXN0ZXIgaXMgaW4gYml0
cyAwLTkgKG1hc2sgMHgzZmYpIHdoaWxlCnRoZSBhc3NlbWJseSBsb2dpY2FsbHkgQU5EcyBpdCB3
aXRoIDB4ZmYuIEkgZ3Vlc3MgaXQncyBiZWNhdXNlIHRoZXJlCmNhbiBiZSBubyBtb3JlIGludGVy
cnVwdHMgdGhhbiAyNTUgYnV0IEknZCBhdCBsZWFzdCBleHBsYWluIGl0IGluIGEKY29tbWVudC4g
T3Igc2hvdWxkIHdlIHVzZSB0aGUgcHJvcGVyIG1hc2s/IFdoYXQgZG8geW91IHRoaW5rPwoKQmFy
dAoKPiA+ICt9Cj4gPiArCj4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWRhdmluY2kv
aXJxLmMgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvaXJxLmMKPiA+IGluZGV4IDk1MmRjMTI2YzM5
MC4uM2JiYmVmNzhkOWFjIDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2ly
cS5jCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLWRhdmluY2kvaXJxLmMKPiA+IEBAIC0yOCwxMSAr
MjgsMTMgQEAKPiA+ICAjaW5jbHVkZSA8bWFjaC9jcHV0eXBlLmg+Cj4gPiAgI2luY2x1ZGUgPG1h
Y2gvY29tbW9uLmg+Cj4gPiAgI2luY2x1ZGUgPGFzbS9tYWNoL2lycS5oPgo+ID4gKyNpbmNsdWRl
IDxhc20vZXhjZXB0aW9uLmg+Cj4gPgo+ID4gICNkZWZpbmUgRklRX1JFRzBfT0ZGU0VUICAgICAg
ICAgICAgICAweDAwMDAKPiA+ICAjZGVmaW5lIEZJUV9SRUcxX09GRlNFVCAgICAgICAgICAgICAg
MHgwMDA0Cj4gPiAgI2RlZmluZSBJUlFfUkVHMF9PRkZTRVQgICAgICAgICAgICAgIDB4MDAwOAo+
ID4gICNkZWZpbmUgSVJRX1JFRzFfT0ZGU0VUICAgICAgICAgICAgICAweDAwMEMKPiA+ICsjZGVm
aW5lIElSUV9JUlFFTlRSWV9PRkZTRVQgIDB4MDAxNAo+ID4gICNkZWZpbmUgSVJRX0VOVF9SRUcw
X09GRlNFVCAgMHgwMDE4Cj4gPiAgI2RlZmluZSBJUlFfRU5UX1JFRzFfT0ZGU0VUICAweDAwMUMK
PiA+ICAjZGVmaW5lIElSUV9JTkNUTF9SRUdfT0ZGU0VUIDB4MDAyMAo+ID4gQEAgLTQ1LDYgKzQ3
LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkYXZpbmNpX2lycV93cml0ZWwodW5zaWduZWQgbG9u
ZyB2YWx1ZSwgaW50IG9mZnNldCkKPiA+ICAgICAgIF9fcmF3X3dyaXRlbCh2YWx1ZSwgZGF2aW5j
aV9pbnRjX2Jhc2UgKyBvZmZzZXQpOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIGlubGluZSB1bnNp
Z25lZCBsb25nIGRhdmluY2lfaXJxX3JlYWRsKGludCBvZmZzZXQpCj4gPiArewo+ID4gKyAgICAg
cmV0dXJuIF9fcmF3X3JlYWRsKGRhdmluY2lfaW50Y19iYXNlICsgb2Zmc2V0KTsKPiA+ICt9Cj4K
PiBDYW4gd2UgdXNlIHJlYWRsX3JlbGF4ZWQoKSBoZXJlPyBJIGtub3cgdGhlcmUgaXMgZXhpc3Rp
bmcgX19yYXdfd3JpdGVsKCkKPiB1c2FnZS4gTWF5IGJlIGFkZCBhIHBhdGNoIHRvIGZpeCB0aGUg
ZXhpc3RpbmcgY29kZSBmaXJzdC4KPgo+IFRoYW5rcywKPiBTZWtoYXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
