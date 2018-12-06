Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53277C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:07:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B4D20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bh4M2YT2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIiKrbGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B4D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=woKCRA/n3f3P/UvNMdofuRmWs/eJTgng3meJ4E34KWc=; b=bh4M2YT2aNdhIJ
	RxRjpBonIjORRAAuOLpEp2d1YbxamzFdDUV+yL6+q/VSkAThwFSivOdru/vnTL2aCaboZaUurTWCP
	iFbnD1yX6atfSijJwEzqHU9NqN8RGLZy6t3V3QNFdgHqcZ2zcxstylXn3PCzZUihOY269+3rn0Wdv
	zjHoyN8kc5fLdNmLLNQtJk1Q048CxMddlL467nclddOg3HipMTWt/1AicDL43Oktn2mfS1lKLehe5
	TWBg7jpWRrTqYJTzKO9JuVOvrkHfNfeR1AS4edwxqIUnyuqreoHdMRYjah8JYKdOBHOI7kvP9+Zt9
	8rSHAxA3cwUp8KVPXFgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyzO-0008Ue-Qz; Thu, 06 Dec 2018 19:07:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyzL-0008Tv-Uh
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:07:09 +0000
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33BAF21582
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544123217;
 bh=X+WmZlDaIHJtwtHuhSJasdmpctzC99f7syC84D314YA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jIiKrbGslOEvLzF/VVf9WE+hlKAOeoK1VQYCDgxFSmoDwxb+3wB8Kqxbs9zvmtADf
 oqSQcOPISJgS76q119pW1XyhGYwTphQCkwKM3RGWV9yL73mzIMRQ9D6R9yhMu+czGX
 MdpLA12HLjrXUUayJbLTbMiIS9nEZIlvW4HH4304=
Received: by mail-qt1-f181.google.com with SMTP id z16so1789639qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 11:06:57 -0800 (PST)
X-Gm-Message-State: AA+aEWYbESFaBSYnM1FghUaI0sx++gop3t7NQ3+x3jxXvBHv2alulNiK
 TV5hfFAwkIBeLIeGORDK9OoHKSHef5o8OC7gmw==
X-Google-Smtp-Source: AFSGD/UAAF+uvrL/8EGbMHe4VFGv08WTU/QP50yomPAVp9+PwuKfy5QhNJYAvaxr4OBhCqBnMxDLD9N1b0aTCJu1Jv4=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr28227754qve.246.1544123216119; 
 Thu, 06 Dec 2018 11:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
In-Reply-To: <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 13:06:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
Message-ID: <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_110708_026865_9AA01FC1 
X-CRM114-Status: GOOD (  39.15  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Alexander Graf <agraf@suse.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tom Rini <trini@konsulko.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCA3OjMyIEFNIEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJA
c3VzZS5kZT4gd3JvdGU6Cj4KPiBBbSAwNS4xMi4xOCB1bSAwNToxNyBzY2hyaWViIFJvYiBIZXJy
aW5nOgo+ID4gT24gVHVlLCBEZWMgNCwgMjAxOCBhdCA3OjIyIFBNIEFuZHJlYXMgRsOkcmJlciA8
YWZhZXJiZXJAc3VzZS5kZT4gd3JvdGU6Cj4gPj4KPiA+PiBSb2IsCj4gPj4KPiA+PiBBbSAwNC4x
Mi4xOCB1bSAxOTozNiBzY2hyaWViIFJvYiBIZXJyaW5nOgo+ID4+PiBJJ3ZlIHB1dCB0b2dldGhl
ciBhIHNjcmlwdCB0byBtb3ZlIHRoZSBkdHMgZmlsZXMgYW5kIHVwZGF0ZSB0aGUKPiA+Pj4gbWFr
ZWZpbGVzLiBJdCBkb2Vzbid0IGhhbmRsZSBmaWxlcyBub3QgZm9sbG93aW5nIGEgY29tbW9uIHBy
ZWZpeCB3aGljaAo+ID4+PiBpc24ndCBtYW55IGFuZCBzb21lIGluY2x1ZGVzIHdpdGhpbiB0aGUg
ZHRzIGZpbGVzIHdpbGwgbmVlZCBzb21lIGZpeHVwcwo+ID4+PiBieSBoYW5kLgo+ID4+Pgo+ID4+
PiBNQUlOVEFJTkVSUyB3aWxsIGFsc28gbmVlZCB1cGRhdGluZy4KPiA+Pj4KPiA+Pj4gQSBmZXcg
cXVlc3Rpb25zOgo+ID4+Pgo+ID4+PiBEbyB3ZSB3YW50IHRvIG1vdmUgYWJzb2x1dGVseSBldmVy
eXRoaW5nIHRvIHN1YmRpcnM/Cj4gPj4KPiA+PiBUaGlzIHJlZmFjdG9yaW5nIGlzIGEgdGVycmli
bGUgaWRlYSEKPiA+Cj4gPiBIb3cgZG8geW91IHJlYWxseSBmZWVsPwo+ID4KPiA+PiBXaGlsZSBp
dCB3b3VsZCd2ZSBiZWVuIG5pY2UgdG8gaGF2ZSBtb3JlIHN0cnVjdHVyZSBmcm9tIHRoZSBzdGFy
dCwKPiA+PiBib290bG9hZGVycyBsaWtlIFUtQm9vdCBleHBlY3QgYSBmbGF0IHN0cnVjdHVyZSBm
b3IgYXJtIC5kdGIgZmlsZXMgbm93Lgo+ID4+IElmIHlvdSBzdGFydCBpbnN0YWxsaW5nIHRoZW0g
aW50byBzdWJkaXJzIGluc3RlYWQsIHRoZXkgd29uJ3QgZmluZCB0aGUKPiA+PiBmaWxlcyBhbnlt
b3JlIHVuZGVyIHRoZSBoYXJkY29kZWQgbmFtZS4KPiA+Pgo+ID4+IERvaW5nIHRoaXMgb25seSBm
b3IgbmV3IHBsYXRmb3JtcyB3b3VsZCBiZSBtdWNoIGxlc3MgaW52YXNpdmUgYW5kIGFsbG93Cj4g
Pj4gdG8gcHJlcGFyZSBib290bG9hZGVycyBhY2NvcmRpbmdseS4KPiA+Cj4gPiBUaGF0IHdhcyBt
eSBzdWdnZXN0aW9uIHdoZXJlIHRoaXMgc3RhcnRlZCBmb3IgdGhlIG5ldyBSREEgcGxhdGZvcm0u
Cj4gPiBPbG9mIHByZWZlcnJlZCB0byBtb3ZlIGV2ZXJ5dGhpbmcgYW5kIHRoYXQncyBteSBkZXNp
cmUgdG9vLgo+ID4KPiA+PiBBbHRlcm5hdGl2ZWx5LCB3aGl0ZS1saXN0IHdoaWNoIG9uZXMKPiA+
PiBhcmUgc2FmZSB0byBtb3ZlIGFyb3VuZC4KPiA+Cj4gPiBJJ2QgcHJlZmVyIHRvIGtub3cgd2hp
Y2ggb25lcyB0aGUgZGlzdHJvcyBkb24ndCB3YW50IG1vdmVkLiBUaGF0Cj4gPiBzaG91bGQgYmUg
ZWFzaWVyIHRvIGZpZ3VyZSBvdXQuIFdlIGFsc28gbmVlZCB0aGF0IGFueXdheXMgaW4gY29udGV4
dAo+ID4gb2Ygd2hhdCBwbGF0Zm9ybXMgd2UgY2FyZSBhYm91dCBjb21wYXRpYmlsaXR5Lgo+ID4K
PiA+IEFub3RoZXIgb3B0aW9uIGlzIGR0YnNfaW5zdGFsbCB0YXJnZXQgY291bGQgZmxhdHRlbiB0
aGUgaW5zdGFsbGVkCj4gPiBkdGJzLiBUaGF0IGlzIHRoZSBvbmx5IHBhcnQgdGhlIGRpc3Ryb3Mg
c2hvdWxkIGRlcGVuZCBvbi4KPgo+IEknZCBiZSBva2F5IHdpdGggZGlzdGluZ3Vpc2hpbmcgc291
cmNlIHZzLiBpbnN0YWxsIGxvY2F0aW9uLiBEdWUgdG8gdGhlCj4gaXNzdWUgSSBtZW50aW9uIGJl
bG93IChhbmQgbW9yZSkgd2UgY2FuJ3QgdXNlIGluc3RhbGxfZHRicyBmb3Igb3BlblNVU0UKPiBh
bmQgaGFkIHRvIHJlaW1wbGVtZW50IGl0LCB3aGljaCB3ZSdkIG5lZWQgdG8gKGFuZCBjYW4pIGFk
anVzdC4KCldoYXQgd291bGQgYmUgbmVlZGVkIGZvciBkdGJzX2luc3RhbGwgdG8gd29yaz8gYXJt
NjQgbmVlZHMgdG8gc3VwcG9ydAphIGZsYXQgaW5zdGFsbD8gSWYgaXQgZG9lc24ndCB3b3JrIGZv
ciBEZWJpYW4gb3Igb3BlblNVU0UsIEknbSBub3QKc3VyZSB3aHkgd2UgaGF2ZSBpdC4gU28gSSdk
IGxpa2UgdG8gbWFrZSBpdCB3b3JrLgoKPiA+PiBCdXQgZG9uJ3QganVzdCBzY3JpcHQgYSByZWZh
Y3RvcmluZyBiZWNhdXNlIGl0Cj4gPj4gbG9va3MgbmljZXIgaW4gdGhlIHNvdXJjZSB0cmVlLCB3
aXRob3V0IHRlc3Rpbmcgd2hhdCBzaWRlIGVmZmVjdHMgdGhpcwo+ID4+IGNhbiBoYXZlIGZvciBi
b2FyZC9kaXN0cm8gdXNlcnMgb2YgdGhlIGNvbXBpbGVkIGZpbGVzIGluIHByYWN0aWNlLgo+ID4+
IFdlIGFscmVhZHkgaGFkIHRoYXQgZGlzY3Vzc2lvbiBmb3IgYXJtNjQgYmVjYXVzZSBEZWJpYW4g
Y2hvc2UgdG8gaWdub3JlCj4gPj4gdGhlIGtlcm5lbC1pbnN0YWxsZWQgc3ViZGlyZWN0b3JpZXMg
YW5kIGluc3RhbGxlZCAuZHRiIGZpbGVzIGludG8gYSBmbGF0Cj4gPj4gZGlyZWN0b3J5LCB3aGlj
aCBjb2xsaWRlZCB3aXRoIG9wZW5TVVNFIHN0aWNraW5nIHRvIHRoZSBrZXJuZWwgY2hvaWNlLgo+
ID4KPiA+IFNvIGV2ZXJ5b25lIGFscmVhZHkgZGVhbHMgd2l0aCBzdWJkaXJzIG9yIG5vdCB3aXRo
IGFybSBhbmQgYXJtNjQKPiA+IGFscmVhZHksIHNlZW1zIGxpa2UgdGhleSBjYW4gZGVhbCB3aXRo
IHRoaXMuIEkgd2lsbCByYWlzZSB0aGUgdG9waWMgb24KPiA+IHRoZSBjcm9zcy1kaXN0cm8gbGlz
dCB0aG91Z2guCj4KPiBTb3VuZHMgbGlrZSB5b3UncmUgdHdpc3Rpbmcgd29yZHMuLi4gVGhlIGtl
eXdvcmQgd2FzICJoYXJkY29kZWQiIHBhdGhzIC0KPiBvbmUgd2F5IG9yIGFub3RoZXIgKG5vdCAi
YW5kIikgZGVwZW5kaW5nIG9uIHRoZSBrZXJuZWwgY2hvaWNlcyBiZWluZwo+IGZsYXQgZm9yIGFy
bSwgdmVuZG9yIHN1YmRpciBmb3IgYXJtNjQuCj4KPiA+PiBUaGlzIHRvcGljIGJlY29tZXMgZXZl
biBtb3JlIGltcG9ydGFudCB3aXRoIEVCQlI6IFRoZXJlIGlzIG5laXRoZXIgYQo+ID4+IG1lY2hh
bmlzbSBpbiBwbGFjZSB0byBzeW5jIC5kdHMgZmlsZXMgaW50byBVLUJvb3Qgb3IgRURLMiBzb3Vy
Y2UgdHJlZXMsCj4gPj4gbm9yIGFyZSBjYXBzdWxlIHVwZGF0ZXMgaW1wbGVtZW50ZWQgaW4gVS1C
b290IGZvciBlYXNpbHkgZGVwbG95aW5nIHN1Y2gKPiA+PiBib290bG9hZGVycyB3aXRoIG5ldyAu
ZHRzIHNvdXJjZXMgb3IgcGF0aHMgeWV0Lgo+ID4KPiA+IEVCQlIgYWN0dWFsbHkgc2F5cyBmaXJt
d2FyZSAoaW5jbHVkaW5nIGR0YnMpIGdvZXMgaW4gZGlyZWN0b3JpZXMgbmFtZWQKPiA+IGJ5IHZl
bmRvci4KPgo+IEZpbmUsIGJ1dCB1bnJlbGF0ZWQuCgpJZiB0aGUgZGlzdHJvcyB3YW50IGR0YnMg
aW4gYSBmbGF0IGRpciBhbmQgRUJCUiBzYXlzIG90aGVyd2lzZSwgdGhlbgppdCBpcyByZWxhdGVk
LgoKPiA+PiBBbmQgSSBjYW4gYXNzdXJlIHlvdQo+ID4+IHRoYXQganVzdCBnZXR0aW5nIHVzZXJz
IHRvIGRkIHRoZSByaWdodCBib290bG9hZGVyIGNhbiBiZSBkaWZmaWN1bHQuLi4KPiA+PiBTaW5j
ZSBEVCBmb3J3YXJkIGFuZCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGlzIG9mdGVuIGJlaW5nIG5l
Z2xlY3RlZCwKPiA+PiBmb3IgZXhhbXBsZSB3aXRoIG9wdGlvbmFsIHByb3BlcnRpZXMgb3IgcmVu
YW1lZCBjb21wYXRpYmxlcyB0aGF0IGJyZWFrCj4gPj4gYm9vdGluZyB3aXRoIHByZXZpb3VzIGRy
aXZlcnMsIG5ldyBrZXJuZWwgdmVyc2lvbnMgb2Z0ZW4gbmVlZCB1cGRhdGVkCj4gPj4gRGV2aWNl
IFRyZWVzIHRvIG1ha2UgdXNlIG9mIG5ldy9lbmhhbmNlZCBkcml2ZXJzLiBUaGVyZWZvcmUgaXQg
aXMKPiA+PiB1bmZvcnR1bmF0ZWx5IG9mdGVuIGVub3VnaCBhIG5lY2Vzc2l0eSB0byBsb2FkIG5l
d2VyIGtlcm5lbC1iYXNlZCAuZHRiCj4gPj4gZmlsZXMgbWF0Y2hpbmcgdGhlIGtlcm5lbCAoYXMg
b3Bwb3NlZCB0byB0aGUgZHJlYW0gb2Yga2VybmVsLWluZGVwZW5kZW50Cj4gPj4gaGFyZHdhcmUg
ZGVzY3JpcHRpb25zKSB3aGVuIHdvcmtpbmcgd2l0aCB0aGUgbGF0ZXN0IC1yYyBvciAtbmV4dCBr
ZXJuZWxzCj4gPj4gYXQgbGVhc3QuIEZvciBleGFtcGxlcyBvZiBEVHMgbmVlZGluZyB1cGRhdGVz
LCBsb29rIG5vIGZ1cnRoZXIgdGhhbgo+ID4+IExpbmFybydzIDk2Ym9hcmRzIC0gaW4gY2FzZSBv
ZiBoaWtleTk2MC9FREsyIEdSVUIgaXMgYW5vdGhlciBsYXllciB3aGVyZQo+ID4+IC5kdGIgcGF0
aHMgbWF5IGJlIGhhcmRjb2RlZCwgZGl0dG8gZm9yIGFybTsgYW5kIEFybWFkYSB3YXMgYW4gZXhh
bXBsZQo+ID4+IHdoZXJlIHRoZSB1cHN0cmVhbSBiaW5kaW5ncyBmb3IgdGhlIG5ldHdvcmsgSVAg
Y2hhbmdlZCBpbmNvbXBhdGlibHkuCj4gPgo+ID4gQ29tcGF0aWJpbGl0eSBpcyBhbiBpc3N1ZSwg
eWVzLCBidXQgdGhhdCByZWFsbHkgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzLgo+ID4KPiA+
PiBEVCBvdmVybGF5cyBhcmUgYW5vdGhlciB0b3BpYyB0aGF0IGlzIG5vdCBtYWtpbmcgYW55IHBy
b2dyZXNzIHVwc3RyZWFtCj4gPj4gYWNjb3JkaW5nIHRvIHRoZSBFTENFIEJvRiwgc28gYmV5b25k
IHRoZSBSYXNwYmVycnkgUGkgdGhlIG9ubHkga25vd24KPiA+PiB3b3JraW5nIHdheSB0byBhcHBs
eSB0aGVtIGlzIHRvIHdyaXRlIGEgVS1Cb290IGJvb3Quc2NyIHNjcmlwdCwgd2hpY2gKPiA+PiBj
YW4gZWl0aGVyIHJldXNlICRmZHRjb250cm9sYWRkciBEVCBvciB1c2UgdGhlIGZpbGVuYW1lICRm
ZHRmaWxlIG9yCj4gPj4gaGFyZGNvZGUgb25lLCB0aGUgbGF0dGVyIHR3byBvZiB3aGljaCB3b3Vs
ZCBicmVhayB3aXRoIHlvdXIgcmVuYW1pbmcuCj4gPgo+ID4gRFQgb3ZlcmxheXMgYWxzbyBoYXZl
IG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzIGFzIHRoZXJlIGFyZW4ndCBhbnkgaW4KPiA+IHRoZSBr
ZXJuZWwuIEknbSBub3QgaW5jbGluZWQgdG8gdGFrZSBhbnkgZWl0aGVyIHdpdGggYSBmbGF0IHRy
ZWUuCj4gPiBXZSdyZSBhbHJlYWR5IGF0IDE4MDArIGZpbGVzLgo+Cj4gUmVhZCBhZ2FpbjogYSkg
QnJlYWtpbmcgRFQgY2hhbmdlcyBhbmQgYikgdGhlIGRlc2lyZSB0byB1c2UgT3ZlcmxheXMKPiBp
bnN0ZWFkIG9mIHJlcGxhY2luZyB0aGUgYm9vdGxvYWRlcnMgZm9yIGVhY2ggY2hhbmdlIGFyZSBf
cmVhc29uc18gd2h5Cj4gcGVvcGxlIGRlcGVuZCBvbiAuZHRiIGZpbGVuYW1lcyBmcm9tIHRoZSBr
ZXJuZWwgc291cmNlIHRyZWUgZm9yIHRoZWlyCj4gYm9vdCBmbG93IHRvZGF5LiBOb3RoaW5nIHRv
IGRvIHdpdGggZG93bnN0cmVhbSAuZHRibyBmaWxlcy4KPgo+IEZvciBleGFtcGxlLCByZW1lbWJl
ciB3aGVuIEkgcmVwb3J0ZWQgdGhhdCB0aGUga2VybmVsIGRpZG4ndCBjb21waWxlIERUcwo+IHdp
dGggLUA/IE5vIHJlYWN0aW9uIGV4Y2VwdCBmb3IgRnJhbmsgYXNraW5nIHRvIGJlIENDJ2VkIC0g
d2FzIGl0IGV2ZXIKPiBmaXhlZD8/PyBEbyBFREsyJ3Mgb3IgVS1Cb290J3MgYnVpbHQtaW4gRFRz
IGNvbXBpbGUgd2l0aCAtQCB0b2RheT8KCklJUkMsIEZyYW5rIG9iamVjdGVkIHRvIGNoYW5naW5n
IHRoaXMgZ2xvYmFsbHkgYmVjYXVzZSBpdCB3aWxsIGJsb2F0CmFsbCBkdGJzLiBBbmQgdGhlbiBu
byBvbmUgZGlkIHRoZSB3b3JrIHRvIG1ha2UgaXQgYSBwZXIgZHRiIG9wdGlvbi4KTWF5YmUgdGhh
dCB3YXMgdGhlIHNhbWUgaXNzdWUgaW4gYW5vdGhlciB0aHJlYWQuCgo+IFJhc3BiZXJyeSBQaSBv
dmVybGF5cyBpbiBVLUJvb3Qgd29yayBiZWNhdXNlIGl0IHN3aXRjaGVkIHRvIHBhc3NpbmcgdGhl
Cj4gRFQgdGhyb3VnaCBmcm9tIHRoZSBwcm9wcmlldGFyeSBmaXJtd2FyZS4KPiBQb2ludCBiZWlu
ZyB0aGF0IHdoaWxlIGl0IHdvdWxkIGJlIG5pY2UgdG8gZ2V0IGEgY3VycmVudCwgY29tcGF0aWJs
ZSBEVAo+IHZpYSBVRUZJIHRhYmxlcyBhbmQgaWdub3JlIC5kdGIgZmlsZW5hbWVzIG91dHNpZGUg
b2YgYSBmZXcgYm9vdGxvYWRlcnMsCj4gaW4gcmVhbGl0eSB3ZSdyZSBub3QgcXVpdGUgdGhlcmUg
eWV0IGZvciBhbGwgcGxhdGZvcm1zLgo+Cj4gSSBzZWUgbm8gcHJvYmxlbSAoZXhjZXB0IGZvciBu
YW1pbmcgY2hvaWNlcykgbW92aW5nIG5ldyB0YXJnZXRzIGxpa2UgUkRBCj4gdG8gc3ViZm9sZGVy
cyBiZWNhdXNlIHdlIGNhbiB0aGVuIGhhcmRjb2RlIGl0IHRoZSBuZXcgd2F5OyBJIGFsc28gYXNz
dW1lCj4gZGVlcGx5IGVtYmVkZGVkIHRhcmdldHMgbGlrZSBzdG0zMmY0IG9yIHRhcmdldHMgd2l0
aCBubyBtYWlubGluZQo+IGJvb3Rsb2FkZXJzIHlldCBsaWtlIG93bC1zNTAwIGNvdWxkIGJlIHJl
ZmFjdG9yZWQuCj4gSSBkbyBzZWUgcHJvYmxlbXMgcmVmYWN0b3Jpbmcgd2lkZWx5IHVzZWQgU0JD
IHRhcmdldHMgbGlrZSBzdW5YaSB0aG91Z2guCj4KPiBSZWdhcmRzLAo+IEFuZHJlYXMKPgo+IC0t
Cj4gU1VTRSBMaW51eCBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1h
bnkKPiBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5lIFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9u
Cj4gSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
