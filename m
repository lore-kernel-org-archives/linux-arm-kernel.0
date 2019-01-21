Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5A3C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F64720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t7WabWGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F64720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2MDZeEzjvgSWgO2Ntlk+8Xfe4kbi1YXFoWW4trkpR9c=; b=t7WabWGu5do8HX
	EavLKbAl5qNgCsRVmhtd8SZ5bBpV6U+sQTxsezcpllIY9m4dw6mI/3n3ARNVRpSpTGpA+o0/zGql/
	cfrpuQPOjp5P3BZ42WeMc/e23pJ5CQExCFlCDsD2yE20Yf+EV64AGr4wvqt6bZdN8bEkdrhudazCv
	0HHiGMuuy5oh0pwMcMqctRfmosxjUjRorQxnhYp6OtkywXWEVcNdgjfm1VTEtYW/C9+0uRyAnr2IS
	PweOfDqC7taheU8hsAaGg+qFvccWzzcGvmccgG90p9bpUTddRvmHeRPMpvxI719lOLe9z9QdSg0+u
	klv1DIc50CpEtqVuJWmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldY3-0004Ie-39; Mon, 21 Jan 2019 17:39:47 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldXz-0004Hy-SV
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:39:45 +0000
Received: by mail-ed1-f66.google.com with SMTP id f9so17194700eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wtKWupWOVAPiWJSuxk5cYsPaqbkthRI/t7KdeUs+oa8=;
 b=QL8BhPES8E+O9Mf8IHPfFINDhOquDWTgZuM0Eb2jSWT3iwI3bt7eFsDNirYtaK4jha
 TzQCu5f74hUQwXBYkfnnzv/HgA3NhfeIhSYXovbePLo/fZwwLjVvqOTm07maaejKSwHv
 WHTkfORD674pDNwzma/0YQKKWjb1uOOdS7jxvCmlguGPLr3t6VlTAn33udUgozwobeqO
 H5jAO3bjpLWB3hAa47nmH5m3Era59w+qTtzRvSfJfJ/jcd5vpCun3CtLbrVVioBuK1rT
 jMyEXnj6t3xFj2/Im0H+eKdNGuEUF3VmZ5sN5YSCiqrDE6udHlBUVEttEpmoPJhCPk2b
 8I4A==
X-Gm-Message-State: AJcUukdbY8X1beZ/skuG1xGWwmdJO69DuxO6/NZ58GEH3OkjBVIsOTim
 Yc/APxvMEcwOJN9Q2XnpDqJxmfnth4k=
X-Google-Smtp-Source: ALg8bN6xC8xi47A+MiNBJZ4biJkiFpqLgHl2RgCSwpkTyi3iDs7c3P9LZ1jOdzrg51n6+q2b00bsKg==
X-Received: by 2002:aa7:ccc8:: with SMTP id y8mr26303271edt.118.1548092379030; 
 Mon, 21 Jan 2019 09:39:39 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id g5-v6sm4931758ejm.15.2019.01.21.09.39.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 09:39:38 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id b11so11653608wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:39:38 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr367501wmj.14.1548092378363; 
 Mon, 21 Jan 2019 09:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
 <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
 <3128239.8RYQUhiYef@jernej-laptop>
In-Reply-To: <3128239.8RYQUhiYef@jernej-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 22 Jan 2019 01:39:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65t6kO9HfSTuXZsBu6Pyc+mueLq-5tsYsw9vxwg5o=v4A@mail.gmail.com>
Message-ID: <CAGb2v65t6kO9HfSTuXZsBu6Pyc+mueLq-5tsYsw9vxwg5o=v4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_093943_933858_A0C98EBC 
X-CRM114-Status: GOOD (  31.86  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMTozMyBBTSBKZXJuZWogxaBrcmFiZWMgPGplcm5lai5z
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
d2UgYXJlIGFjdHVhbGx5IGRvaW5nIHNvbWV0aGluZyB0bwo+ID4gc3VwcG9ydCB0aGVtLgo+Cj4g
SWYgeW91IGRvbid0IGRvY3VtZW50IHRoZW0sIGNoZWNrcGF0Y2ggd2lsbCBjb21wbGFpbi4gQnV0
IGlmIHlvdSBjYW4gbGl2ZSB3aXRoCj4gdGhpcyB3YXJuaW5nLCB0aGF0J3MgZmluZSBieSBtZS4K
Pgo+ID4KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgc2l0dWF0
aW9uIGZvciBJUiBuZWVkcyBhCj4gPiBiaXQgb2YgY2xlYW5pbmcgdXAgYXQgdGhlIG1vbWVudC4g
UmlnaHQgbm93IHdlIGhhdmUgc3VuNGktYTEwIGFuZAo+ID4gc3VuNWktYTEzLiBBcyBKZXJuZWog
cG9pbnRlZCBvdXQsIHRoZSBBMTMncyByZWdpc3RlciBkZWZpbml0aW9uIGlzCj4gPiBkaWZmZXJl
bnQgZnJvbSBBNjQgKG9yIGFueSBvdGhlciBTb0NzIGxhdGVyIHRoYW4gc3VuNmkpLiBTbyB3ZSBu
ZWVkCj4gPiBzb21lb25lIHdpdGggYW4gQTEwcy9BMTMgZGV2aWNlIHRoYXQgaGFzIElSIHRvIHRl
c3QgaXQgYW5kIHNlZSBpZgo+ID4gdGhlIGRyaXZlciBvciB0aGUgbWFudWFsIGlzIHdyb25nLCBh
bmQgd2UnZCBsaWtlbHkgYWRkIGEgY29tcGF0aWJsZQo+ID4gZm9yIHRoZSBBMjAuCj4gPgo+ID4g
QWxzbywgdGhlIGVhcmxpZXIgU29DcyAoQTEwL3N1bjVpL0EyMCkgaGF2ZSBJUiBUWCBjYXBhYmls
aXR5LiBUaGlzCj4gPiB3YXMgbG9zdCBpbiBBMzEsIGFuZCBhbHNvIGFsbCBvZiBzdW44aSAvIHN1
bjUwaS4gU28gd2UncmUgZ29pbmcgdG8KPiA+IG5lZWQgdG8gYWRkIGFuIEEzMSBjb21wYXRpYmxl
IHRoYXQgYWxsIGxhdGVyIHBsYXRmb3JtcyB3b3VsZCBuZWVkCj4gPiB0byBzd2l0Y2ggdG8uCj4g
Pgo+Cj4gSDYgaGFzIElSIFRYIHBlcmlwaGVyYWwgdG9vLCBidXQgaXQncyBkaWZmZXJlbnQgSVAg
YmxvY2suLi4KPgo+IERvIHlvdSB3YW50IG1lIHRvIHN3aXRjaCBhbGwgQTMxIGFuZCBuZXdlciB0
byBkaWZmZXJlbnQgY29tcGF0aWJsZSBpbiB0aGlzCj4gc2VyaWVzPyBJIGNhbiBkbyB0aGlzLCBi
dXQgSSBoYXZlbid0IGFueSBBMTMgZGV2aWNlIHRvIHRlc3QgaWYgdGhpcyBpcyByZWFsbHkKPiBu
ZWVkZWQuIE9yIHlvdSBjYW4gYXJndWUgdGhhdCB0aGlzIGlzIG5lZWRlZCBhbnl3YXkgZHVlIHRv
IG1pc3NpbmcgVFgKPiBjYXBhYmlsaXR5LgoKVGhlIGxhY2sgb2YgVFggY2FwYWJpbGl0eSBkb2Vz
IG5lY2Vzc2l0YXRlIHN3aXRjaGluZyB0byBhbiBBMzEgY29tcGF0aWJsZS4KU28geWVzLCBwbGVh
c2Ugc3dpdGNoLiBMZXRzIGxlYXZlIHRoZSBBMTBzL0ExMyBhbG9uZSBmb3Igbm93LCB1bmxlc3MK
c29tZW9uZSBjb21wbGFpbnMuIEkgdGhpbmsgdGhpcyB3YXMgZG9uZSBmcm9tIGluY2VwdGlvbiwg
c28gaWYgaXQgd2FzCmJyb2tlbiwgc29tZW9uZSBzaG91bGQndmUgY29tcGxhaW5lZCBhIGxvbmcg
dGltZSBhZ28uIEkganVzdCB3YW50IHRvCmJlIHN1cmUgd2hlcmUgdGhlIGVycm9yIGlzLCBhbmQg
cHV0IGluIGEgY29tbWVudCBleHBsYWluaW5nIGl0LiBIb3dldmVyCkkgZG9uJ3QgaGF2ZSB0aGUg
aGFyZHdhcmUgZWl0aGVyLgoKQ2hlbll1CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
