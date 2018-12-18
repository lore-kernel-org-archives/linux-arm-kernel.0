Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146CA217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aH3nTy3J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSNgGK/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146CA217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aMkqL4K/S0wtyeL5h62TPT4SZ52jrHn5CNowTFOvwVs=; b=aH3nTy3JXlwmSm
	7U/7HV9CJn2Ns4U5vNBxi476HwFJCxDErEnEK+w0bMhTBSFJUu7frKdeqvjkHQK7xJY9/1ITiX78a
	Eca5W/aBbJbl1FYJCV4W3mikGPbmfZXg+vP9wOBKuJmEjSnYUH1wsu6qMHHroWlHPIol8AL/osjFo
	WKiHytsWeCGoqE7ku3nqO9DnYwZT+U8P55UnoEfkrqh/FQeKuMkccUgx/5eOFhQqKWPRZ1tiYiuge
	e0Do7jzb21pX1alGhmNxR0VahFyRkvpaiB0Odue40ez3Gx2yBRjUSb6jR+4d5sTsuyQsZyKsfF6Aj
	12qt/UZ6wwL7UeQcFlIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZArj-0007nX-Uw; Tue, 18 Dec 2018 08:36:35 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZArb-0007f5-5f
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:36:33 +0000
Received: by mail-qt1-x843.google.com with SMTP id t13so17287653qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7oGO02NfXnOUS1mE9pnrgbEYKMKIhHruFOd1QdgfDaM=;
 b=NSNgGK/C/Ggq+r3M51s89bHkI0u/cuppvBzSqGDH/3gxTm4VfmBOKr2tu1MwGSnlqI
 dqmAtGg0cMzOPRGXTme9WArbcaBQpB/aGLbo7YonBKHaLn+qCuAc+/O6GInl1Cc7WoXu
 KTr1a6y1FxjCUd6cizqIWBPM4y8Abkb2fxK3CBsCos6R8bZFt1WlAKGa473TwkWJIxqX
 XN01kGVA+g7uOsaafigRKu9YGbvn8PWjp/rdOU0nVY1P41xLOaGUeX2q63TXOAfJAgBA
 TqyC22OU1szq6x2L+SSX8rg1KdIsw3VYFDS83EsT/62aBWc7WUEKkz+lbb0E3nlBFPSk
 5HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7oGO02NfXnOUS1mE9pnrgbEYKMKIhHruFOd1QdgfDaM=;
 b=j9d7WM0wImB62RjGvpWTGdIuheDZoygeybLkIqovhDqiY7BxJO5w4e7RMA63BtlTFg
 lrW/hhetkhoYO/LSTS/m1G7wVIkeCMfWCGB/yJteOe3sLRhlaMVl1LriZoCzBeH27M4k
 0lqUxgb6dolcopoXreaJxGZykprbUuVeIhPCqb4rRM6FiMRsv/PRxzLI3gIR0dENHDuF
 sCEnCH9vxjusHp3nY6Xfhj+XNF0fVW9WL02eQQRhBi+N26tOkEqoNfbPhymr3KP+Qqkq
 geA9FrjRw2A7UruOImLTLTe/h1aKlEPBMOqluNreCrTfoh9XBo42BiuVnMgF4Fhe29nu
 ksjg==
X-Gm-Message-State: AA+aEWZTeblTlpK1y/QhDzwdIeBMJRi9jUeUZocw32+qSQA8oFx6bQLZ
 52rwiKO40YT1GIo/JIgySXnLvrpEOXIJDYSJNSs=
X-Google-Smtp-Source: AFSGD/VMjleKU65Vsl8+ibMX+Xrcg+yzmWxkgGKFN48rA9HApIfCa96GpiC53/tu9zn0zkUK6m2tU3bd1ISpMRmQJSA=
X-Received: by 2002:ac8:1308:: with SMTP id e8mr16828130qtj.201.1545122175482; 
 Tue, 18 Dec 2018 00:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20181216144715.7486-1-lecopzer@gmail.com>
 <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
In-Reply-To: <e69be9ad-fcda-fa8d-1844-ad0decffb876@arm.com>
From: Jian-Lin Chen <lecopzer@gmail.com>
Date: Tue, 18 Dec 2018 16:36:04 +0800
Message-ID: <CANr2M18RppcS2o0cSb7Ze7tVGSCWq-rPSDQFoVfp_zgrT1HD_Q@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Julien Thierry <julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_003627_219612_0334F4F9 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: mark.rutland@arm.com, Daniel Thompson <daniel.thompson@linaro.org>,
 Jian-Lin Chen <lecopzer.chen@mediatek.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SEkgSnVsaWVuLAoKVGhhbmtzIGEgbG90IGZvciB5b3VyIHJlcGx5LCBzaW5jZSBJJ20gd29ya2lu
ZyBvbiB0aGlzIHBhdGNoIGluIEFSTQooMzIgYml0cyksIHNvIEkgaGF2ZSB0byBkaWcgaW50byB0
aGUgZGV0YWlscy4KCkp1bGllbiBUaGllcnJ5IDxqdWxpZW4udGhpZXJyeUBhcm0uY29tPiDmlrwg
MjAxOOW5tDEy5pyIMTfml6Ug6YCx5LiAIOS4i+WNiDU6Mjblr6vpgZPvvJoKPgo+IEhpIEppYW4t
TGluLAo+Cj4gVGhhbmtzIGZvciBsb29raW5nIGF0IHRoaXMuCj4KPiBPbiAxNi8xMi8yMDE4IDE0
OjQ3LCBKaWFuLUxpbiBDaGVuIHdyb3RlOgo+ID4gRnJvbTogSmlhbi1MaW4gQ2hlbiA8bGVjb3B6
ZXIuY2hlbkBtZWRpYXRlay5jb20+Cj4gPgo+ID4KPiA+IE9uIFdlZCwgMTIgRGVjIDIwMTggYXQg
MTc6NDgsIEp1bGllbiBUaGllcnJ5IDxqdWxpZW4udGhpZXJyeUBhcm0uY29tPiB3cm90ZToKPiA+
PiAgc3RhdGljIGlubGluZSB2b2lkIGFyY2hfbG9jYWxfaXJxX2VuYWJsZSh2b2lkKQo+ID4+ICB7
Cj4gPj4gLSAgICAgICBhc20gdm9sYXRpbGUoCj4gPj4gLSAgICAgICAgICAgICAgICJtc3IgICAg
ZGFpZmNsciwgIzIgICAgICAgICAgICAgLy8gYXJjaF9sb2NhbF9pcnFfZW5hYmxlIgo+ID4+IC0g
ICAgICAgICAgICAgICA6Cj4gPj4gKyAgICAgICB1bnNpZ25lZCBsb25nIHVubWFza2VkID0gR0lD
X1BSSU9fSVJRT047Cj4gPj4gKwo+ID4KPiA+IFNob3VsZCB3ZSBuZWVkIGEgV0FSTl9PTigpIHRv
IGNoZWNrIGlmIHRoZSBkYWlmX0kgYml0IGlzIG1hc2tlZCwgb3IKPiA+IGV4cGxpY2l0bHkgdW5t
YXNrZWQgSSBiaXQgaGVyZT8KPiA+Cj4KPiBXaGlsZSBJIHdvdWxkIGFncmVlLCBhZGRpbmcgdGhl
IFdBUk5fT04oKSB3aWxsIGFkZCBzb21lIG5vbi1uZWdsaWdpYmxlCj4gb3ZlcmhlYWQsIGVzcGVj
aWFsbHkgaWYgd2UgbmVlZCB0byByZWFkIHRoZSBkYWlmIGZsYWdzIHRvIGNoZWNrIGl0Lgo+Cj4g
U2luY2UgdGhlc2UgZnVuY3Rpb25zIGFyZSBjYWxsZWQgb2Z0ZW4gaW4gdGhlIHdob2xlIHN5c3Rl
bSBhbmQgdXNpbmcgUE1SCj4gYWxyZWFkeSBtYWtlcyB0aGluZ3MgYSBiaXQgc2xvd2VyLCBJJ2Qg
cHJlZmVyIHRvIGF2b2lkIGNoZWNrcyBpbiBoZXJlLgoKT2ssIHNvIHdlIGhhdmUgdG8gZmluZCBh
IGJldHRlciBwbGFjZSB0byBjaGVjayBpdC4KSSBoYXZlIG5vIGlkZWEgc28gZmFyLi4uCgoKPgo+
ID4gSWYgSSBiaXQgd2FzIG1hc2tlZCBhbmQgc29tZW9uZSBjYWxscyBhcmNoX2xvY2FsX2lycV9l
bmFibGUoKSwgdGhleSBzdGlsbAo+ID4gY291bGRuJ3QgcmVjaWV2ZSBhbnkgaW50ZXJydXB0Lgo+
ID4KPiA+Cj4gPj4gKyAgICAgICBhc20gdm9sYXRpbGUoQUxURVJOQVRJVkUoCj4gPj4gKyAgICAg
ICAgICAgICAgICJtc3IgICAgZGFpZmNsciwgIzIgICAgICAgICAgICAgLy8gYXJjaF9sb2NhbF9p
cnFfZW5hYmxlXG4iCj4gPj4gKyAgICAgICAgICAgICAgICJub3AiLAo+ID4+ICsgICAgICAgICAg
ICAgICAibXNyX3MgICIgX19zdHJpbmdpZnkoU1lTX0lDQ19QTVJfRUwxKSAiLCUwXG4iCj4gPj4g
KyAgICAgICAgICAgICAgICJkc2IgICAgc3kiLAo+ID4+ICsgICAgICAgICAgICAgICBBUk02NF9I
QVNfSVJRX1BSSU9fTUFTS0lORykKPiA+PiAgICAgICAgICAgICAgICAgOgo+ID4+ICsgICAgICAg
ICAgICAgICA6ICJyIiAodW5tYXNrZWQpCj4gPj4gICAgICAgICAgICAgICAgIDogIm1lbW9yeSIp
Owo+ID4+ICB9Cj4gPj4KPiA+PiAgc3RhdGljIGlubGluZSB2b2lkIGFyY2hfbG9jYWxfaXJxX2Rp
c2FibGUodm9pZCkKPiA+PiAgewo+ID4+IC0gICAgICAgYXNtIHZvbGF0aWxlKAo+ID4+IC0gICAg
ICAgICAgICAgICAibXNyICAgIGRhaWZzZXQsICMyICAgICAgICAgICAgIC8vIGFyY2hfbG9jYWxf
aXJxX2Rpc2FibGUiCj4gPj4gLSAgICAgICAgICAgICAgIDoKPiA+PiArICAgICAgIHVuc2lnbmVk
IGxvbmcgbWFza2VkID0gR0lDX1BSSU9fSVJRT0ZGOwo+ID4+ICsKPiA+PiArICAgICAgIGFzbSB2
b2xhdGlsZShBTFRFUk5BVElWRSgKPiA+PiArICAgICAgICAgICAgICAgIm1zciAgICBkYWlmc2V0
LCAjMiAgICAgICAgICAgICAvLyBhcmNoX2xvY2FsX2lycV9kaXNhYmxlIiwKPiA+PiArICAgICAg
ICAgICAgICAgIm1zcl9zICAiIF9fc3RyaW5naWZ5KFNZU19JQ0NfUE1SX0VMMSkgIiwgJTAiLAo+
ID4KPiA+IE1heSBiZSBhICJkc2Igc3kiIGhlcmU/Cj4KPiBTbywgd2UgbmVlZCBhICJkc2Igc3ki
IHdoZW4gdW5tYXNraW5nIGludGVycnVwdHMgYmVjYXVzZSB0aGlzIGVuc3VyZXMKPiB0aGUgcmVk
aXN0cmlidXRvciBzZWVzIHRoZSBsYXRlc3QgUE1SIHZhbHVlIGFuZCBzdGFydHMgZm9yd2FyZGlu
ZyBsb3dlcgo+IHByaW9yaXR5IGludGVycnVwdHMgYWdhaW4uCj4KPiBXaGVuIHdlIGRpc2FibGUg
aW50ZXJydXB0cyBob3dldmVyLCB0aGUgR0lDIENQVSBpbnRlcmZhY2UgZ3VhcmFudGVlcwo+IHRo
YXQgbm8gaW50ZXJydXB0cyBvZiBsb3dlciBwcmlvcml0eSB0aGFuIHRoZSBjdXJyZW50IHZhbHVl
IG9mIFBNUiB3aWxsCj4gYmUgdGFrZW4uIFNvIHdlIGRvbid0IHJlYWxseSBuZWVkIHRoZSByZWRp
c3RyaWJ1dG9yIHRvIGltbWVkaWF0ZWx5IHNlZQo+IHRoZSBuZXcgdmFsdWUgb2YgUE1SIGFzIHRo
ZSBsb2dpYyBpbiB0aGUgR0lDIENQVSBpbnRlcmZhY2UgaXMgZ29vZAo+IGVub3VnaCBmb3Igb3Vy
IGdvYWwuCj4KCkdvdCBpdCwgdGhhbmtzIGZvciB0aGUgZGV0YWlsIQoKCgo+IFRoYW5rcywKPgo+
IC0tCj4gSnVsaWVuIFRoaWVycnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
