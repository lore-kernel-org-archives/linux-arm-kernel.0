Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E012C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:50:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BD4218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gowf1fmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BD4218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LygC0DcSKWrtfvdKYiGz3DZL4750FuOOXn7gqePcoMI=; b=gowf1fmvg79Amx
	tgODwLnBKqSIvMp6Wk18nuLBN/9W0YAd6bFcCvilUTQfW9GqVCWfbHUM9LM6BcvxdLM9uXp3NCWVr
	tRtViqSX4WlHFGkHFRgvlzFc6vKQg4DPtm5+kSFTufY4W7CZOkBuXkJTk+0Eis03dKb0uP75J3sBC
	68uH1hWj3bMKud4KSarOWbi9tA9v9AM8anGjQGoC3gNRvzwuKFf27k0ApSvHldgKbdkp/3HWLuR69
	xgbaO8ncUUqWw0InxrrzUDhkKdt9e0vvXpxQUf1A6CbIlxVA3+87ipCkDJL+TVG/fHb2HwprLHM40
	hRDDo8bXO3I9w5+LoZhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmrZS-0003jT-9D; Fri, 25 Jan 2019 02:50:18 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrZO-0003jA-Uy
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 02:50:16 +0000
Received: by mail-ed1-f42.google.com with SMTP id o10so6198229edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 18:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P1zzXln1riUs/zkYl5yWs+M8mhcZVCnbTojUF9bsN5Y=;
 b=BUsiyaNVZMeJCBN6R95cRBZMmkYPJYEgjx8i1KaC46P+peYooNUc6gn0rASGoJRTGJ
 VS4LA1a5sA13DXACbK9Gzk8THAulBv5UycUSbi/8NQTJ+Gbew45hX0CHH+jmAuUfV1rN
 QjfKx9cCc99Nok7hJgVegmqo5FsJ2xR9HOYavd+Zw0BM1z2Sed1Ai/c79uP75+A88lN2
 os57q28PSEcmUCM2ioq0Klg6WMGX12CVmSmUXM0gyyZQQGnzfUSqG8E17CepEwkw32ZC
 +UcJyiwCHbcCffTA4LdMqXcOcccojwwi2lg7lcEbGIbSFnzHlMctn+xyHULGCFqFOlDl
 FHVg==
X-Gm-Message-State: AJcUukfrq+1Gb1PEQSU6odIS/XsfU2bPBoBnFgsoIZYoNMUdUQMChjut
 ccfOvq3EvOjViknGUj4H2xrbL7hTVRs=
X-Google-Smtp-Source: ALg8bN5mLnpI8NZdPr+E8ObChJTWo0xoC6XVC613t+WzyIbIOPZQWoeWuDg4QpbjlYB+StqtZDm/zA==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr8687549edc.5.1548384612992;
 Thu, 24 Jan 2019 18:50:12 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id by5-v6sm6516838ejb.7.2019.01.24.18.50.12
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 18:50:12 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id 96so8711403wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 18:50:12 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr9414215wrs.44.1548384611813; 
 Thu, 24 Jan 2019 18:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <2800701.S2xdS7azMu@jernej-laptop>
In-Reply-To: <2800701.S2xdS7azMu@jernej-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 25 Jan 2019 10:49:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wm3ZVjHxqBvU1EgBjj3Dn9keyG8jGrdiiXEFa_HD2kg@mail.gmail.com>
Message-ID: <CAGb2v66wm3ZVjHxqBvU1EgBjj3Dn9keyG8jGrdiiXEFa_HD2kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>, 
 Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_185015_001707_D28020B4 
X-CRM114-Status: GOOD (  33.31  )
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
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMjUsIDIwMTkgYXQgMjo1NyBBTSBKZXJuZWogxaBrcmFiZWMgPGplcm5lai5z
a3JhYmVjQHNpb2wubmV0PiB3cm90ZToKPgo+IERuZSBwb25lZGVsamVrLCAyMS4gamFudWFyIDIw
MTkgb2IgMTA6NTc6NTcgQ0VUIGplIENoZW4tWXUgVHNhaSBuYXBpc2FsKGEpOgo+ID4gT24gTW9u
LCBKYW4gMjEsIDIwMTkgYXQgNTo1MCBQTSBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJv
b3RsaW4uY29tPgo+IHdyb3RlOgo+ID4gPiBIaSwKPiA+ID4KPiA+ID4gSSdtIGEgYml0IGxhdGUg
dG8gdGhlIHBhcnR5LCBzb3JyeSBmb3IgdGhhdC4KPiA+ID4KPiA+ID4gT24gU2F0LCBKYW4gMTIs
IDIwMTkgYXQgMDk6NTY6MTFBTSArMDgwMCwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgo+ID4gPiA+IE9u
IFNhdCwgSmFuIDEyLCAyMDE5IGF0IDE6MzAgQU0gSmVybmVqIFNrcmFiZWMgPGplcm5lai5za3Jh
YmVjQHNpb2wubmV0Pgo+IHdyb3RlOgo+ID4gPiA+ID4gQTY0IElSIGlzIGNvbXBhdGlibGUgd2l0
aCBBMTMsIHNvIGFkZCBBNjQgY29tcGF0aWJsZSB3aXRoIEExMyBhcyBhCj4gPiA+ID4gPiBmYWxs
YmFjay4KPiA+ID4gPgo+ID4gPiA+IFdlIGFzayBwZW9wbGUgdG8gYWRkIHRoZSBTb0Mtc3BlY2lm
aWMgY29tcGF0aWJsZSBhcyBhIGNvbnRpZ2VuY3ksCj4gPiA+ID4gaW4gY2FzZSB0aGluZ3MgdHVy
biBvdXQgdG8gYmUgbm90IHNvICJjb21wYXRpYmxlIi4KPiA+ID4gPgo+ID4gPiA+IFRvIGJlIGNv
bnNpc3RlbnQgd2l0aCBhbGwgdGhlIG90aGVyIFNvQ3MgYW5kIG90aGVyIHBlcmlwaGVyYWxzLAo+
ID4gPiA+IHVubGVzcyB5b3UgYWxyZWFkeSBzcG90dGVkIGEgImNvbXBhdGlibGUiIGRpZmZlcmVu
Y2UgaW4gdGhlCj4gPiA+ID4gaGFyZHdhcmUsIGkuZS4gdGhlIGhhcmR3YXJlIGlzbid0IGNvbXBs
ZXRlbHkgdGhlIHNhbWUsIHRoaXMKPiA+ID4gPiBwYXRjaCBpc24ndCBuZWVkZWQuIE9uIHRoZSBv
dGhlciBoYW5kLCBpZiB5b3UgZGlkLCBwbGVhc2UgbWVudGlvbgo+ID4gPiA+IHRoZSBkaWZmZXJl
bmNlcyBpbiB0aGUgY29tbWl0IGxvZy4KPiA+ID4KPiA+ID4gRXZlbiBpZiB3ZSBkb24ndCBzcG90
IHRoaW5ncywgc2luY2Ugd2UgaGF2ZSB0aGUgc3RhYmxlIERUIG5vdywgaWYgd2UKPiA+ID4gZXZl
ciBoYWQgdGhhdCBjb21wYXRpYmxlIGluIHRoZSBEVCBmcm9tIGRheSAxLCBpdCdzIG11Y2ggZWFz
aWVyIHRvCj4gPiA+IGRlYWwgd2l0aC4KPiA+ID4KPiA+ID4gSSdkIHJlYWxseSBsaWtlIHRvIGhh
dmUgdGhhdCBwYXR0ZXJuIGZvciBhbGwgdGhlIElQcyBldmVuIGlmIHdlIGRpZG4ndAo+ID4gPiBz
cG90IGFueSBpc3N1ZSwgc2luY2Ugd2UgY2FuJ3QgcmVhbGx5IHNheSB0aGF0IHRoZSBkYXRhc2hl
ZXQgYXJlCj4gPiA+IGNvbXBsZXRlLCBhbmQgb25lIGNhbiBhbHdheXMgbWFrZSBhIG1pc3Rha2Ug
YW5kIG92ZXJsb29rIHNvbWV0aGluZy4KPiA+ID4KPiA+ID4gSSdtIGZpbmUgd2l0aCB0aGlzIHZl
cnNpb24sIGFuZCBjYW4gYXBwbHkgaXQgYXMgaXMgaWYgd2UgYWxsIGFncmVlLgo+ID4KPiA+IEkn
bSBPSyB3aXRoIGhhdmluZyB0aGUgZmFsbGJhY2sgY29tcGF0aWJsZS4gSSdtIGp1c3QgcG9pbnRp
bmcgb3V0Cj4gPiB0aGF0IHRoZXJlIGFyZSBhbmQgd2lsbCBiZSBhIHdob2xlIGJ1bmNoIG9mIHRo
ZW0sIGFuZCB3ZSBkb24ndCBuZWVkCj4gPiB0byBkb2N1bWVudCBhbGwgb2YgdGhlbSB1bmxlc3Mg
d2UgYXJlIGFjdHVhbGx5IGRvaW5nIHNvbWV0aGluZyB0bwo+ID4gc3VwcG9ydCB0aGVtLgo+ID4K
PiA+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgc2l0dWF0aW9uIGZv
ciBJUiBuZWVkcyBhCj4gPiBiaXQgb2YgY2xlYW5pbmcgdXAgYXQgdGhlIG1vbWVudC4gUmlnaHQg
bm93IHdlIGhhdmUgc3VuNGktYTEwIGFuZAo+ID4gc3VuNWktYTEzLiBBcyBKZXJuZWogcG9pbnRl
ZCBvdXQsIHRoZSBBMTMncyByZWdpc3RlciBkZWZpbml0aW9uIGlzCj4gPiBkaWZmZXJlbnQgZnJv
bSBBNjQgKG9yIGFueSBvdGhlciBTb0NzIGxhdGVyIHRoYW4gc3VuNmkpLiBTbyB3ZSBuZWVkCj4g
PiBzb21lb25lIHdpdGggYW4gQTEwcy9BMTMgZGV2aWNlIHRoYXQgaGFzIElSIHRvIHRlc3QgaXQg
YW5kIHNlZSBpZgo+ID4gdGhlIGRyaXZlciBvciB0aGUgbWFudWFsIGlzIHdyb25nLCBhbmQgd2Un
ZCBsaWtlbHkgYWRkIGEgY29tcGF0aWJsZQo+ID4gZm9yIHRoZSBBMjAuCj4gPgo+ID4gQWxzbywg
dGhlIGVhcmxpZXIgU29DcyAoQTEwL3N1bjVpL0EyMCkgaGF2ZSBJUiBUWCBjYXBhYmlsaXR5LiBU
aGlzCj4gPiB3YXMgbG9zdCBpbiBBMzEsIGFuZCBhbHNvIGFsbCBvZiBzdW44aSAvIHN1bjUwaS4g
U28gd2UncmUgZ29pbmcgdG8KPiA+IG5lZWQgdG8gYWRkIGFuIEEzMSBjb21wYXRpYmxlIHRoYXQg
YWxsIGxhdGVyIHBsYXRmb3JtcyB3b3VsZCBuZWVkCj4gPiB0byBzd2l0Y2ggdG8uCj4KPiBBY3R1
YWxseSwgQTEzIGFsc28gZG9lc24ndCBoYXZlIElSIFRYIGNhcGFiaWxpdHkuIFNvIEkgc3RpbGwg
dGhpbmsgaXQncyBiZXN0Cj4gaGF2aW5nIEExMyBjb21wYXRpYmxlIGFzIGEgZmFsbGJhY2sgYW5k
IG5vdCBBMzEuIFVubGVzcyBBMzEgd2FzIHJlbGVhc2VkCj4gYmVmb3JlIEExMz8KCk5vLCBidXQg
dGhlIEEzMSBJUiByZWNlaXZlciBoYXMgc29tZSBhZGRpdGlvbmFsIGJpdHMgaW4gdGhlIEZJRk8g
Y29udHJvbAphbmQgc3RhdHVzIHJlZ2lzdGVycywgYXMgd2VsbCBhcyB0aGUgY29uZmlnIHJlZ2lz
dGVyICh3aGljaCBjb250cm9scwpzYW1wbGluZyBwYXJhbWV0ZXJzKS4gTG9va3MgbGlrZSB0aGUg
QTMxIGhhcyBhbiBpbXByb3ZlZCB2ZXJzaW9uLiBUaGF0CndvdWxkIG1ha2UgaXQgYmFja3dhcmQg
Y29tcGF0aWJsZSwgaWYgbm90IGZvciB0aGUgZmFjdCB0aGF0IHRoZSBGSUZPCmxldmVsIGJpdHMg
YXJlIGF0IGEgZGlmZmVyZW50IG9mZnNldCwgd2hpY2ggbWlnaHQgaGF2ZSBiZWVuIG1vdmVkIHRv
Cm1ha2Ugd2F5IGZvciB0aGUgZXh0cmEgYml0cy4gVGhhdCB3b3VsZCBtYWtlIHRoZW0gaW5jb21w
YXRpYmxlLiBCdXQKdGhpcyBzaG91bGQgcmVhbGx5IGJlIHRlc3RlZC4KClNvIHRoZSBmYWxsYmFj
ayBjb21wYXRpYmxlIHNob3VsZCBiZSB0aGUgQTMxJ3MsIG5vdCB0aGUgQTEzJ3MuCgpUaGUgQTY0
J3MgbG9va3MgbGlrZSB0aGUgc2FtZSBoYXJkd2FyZSBhcyB0aGUgQTMxLCB3aXRoIHR3byBleHRy
YSBiaXRzOgoKICAtIENHUE86IHJlZ2lzdGVyIDB4MDAsIGJpdCBvZmZzZXQgOC4gQ29udHJvbHMg
b3V0cHV0IGxldmVsIG9mCiAgICAgICAgICAibm9uLWV4aXN0aW5nIiBUWCBwaW4KCiAgLSBEUlFf
RU46IHJlZ2lzdGVyIDB4MmMsIGJpdCBvZmZzZXQgNS4gQ29udHJvbHMgRFJRIHVzYWdlIGZvciBE
TUEuCiAgICAgICAgICAgIE5vdCByZWFsbHkgdXNlZnVsIGFzIHRoZXJlIGlzbid0IGEgRE1BIHJl
cXVlc3QgbGluZSBmb3IKICAgICAgICAgICAgdGhlIGhhcmR3YXJlLgoKQm90aCBiaXRzIGFyZSBh
bHNvIHRvZ2dsYWJsZSBvbiB0aGUgQTMxLCBidXQgc2luY2UgYWN0dWFsIGhhcmR3YXJlCmRvbid0
IHN1cHBvcnQgdGhlc2UgdHdvIGZlYXR1cmVzLCBJIHRoaW5rIHdlIGNhbiBpZ25vcmUgdGhlbS4K
ClNvIGl0IGxvb2tzIGxpa2UgZm9yIHRoZSBBNjQgaGFzIHRoZSBzYW1lIElQIGJsb2NrIGFzIHRo
ZSBBMzEsIGluCndoaWNoIGNhc2Ugd2Ugd29uJ3QgbmVlZCB0aGUgcGVyLVNvQyBjb21wYXRpYmxl
IGFzIHdlJ3ZlIGRvbmUgdGhlCndvcmsgdG8gY29tcGFyZSB0aGVtLgoKTWF4aW1lLCB3aGF0IGRv
IHlvdSB0aGluaz8gQW5kIGRvIHlvdSBndXlzIGhhdmUgYW55IEExMHMvQTEzIGhhcmR3YXJlCnRv
IHRlc3QgdGhlIEZJRk8gbGV2ZWwgYml0cz8KCgpSZWdhcmRzCkNoZW5ZdQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
