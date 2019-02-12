Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FB9C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:57:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEFD222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T7iVwZb0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZ/xQS8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEFD222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fxw2lO1rkExtX2kBl5nzEHbO1QMaT8z3tcNJLXSStgM=; b=T7iVwZb0sreIrH
	cFQwaqI9YHI1iXZpj44n/pokwFEFinxsrtscDSvfj8x8VllX6mvICQtxhb1TwHFNwlrWH1coMGhaD
	PyZPbfoMXD1O+Jni1z5Y3dU79/Fk+SBNOdKiQsWY0dtF2NqCwLO6JXGz2X4B2196AGWX7k871AsGX
	cGXzMXGAsU3jU0nDU3W7NiQbcA1HiDHiek9n8xYcu9QVyEkDVTqSpQKvTY0r4ZykpYZBWNu4kNjd7
	qTurA8JAIMOzPEwZiInxv8/W5nF9OCT93zHuNQ5DNr6+/E9TcHwTGale4cu1kiufGxqNY+AvGndhC
	B9HA0zwJWmU+nCDYRilA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdFG-0003nm-S6; Tue, 12 Feb 2019 18:57:26 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdFD-0003nP-MO
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 18:57:25 +0000
Received: by mail-vs1-xe44.google.com with SMTP id e7so2283451vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IUNHmrobcIG4oQzAePQtOJCStl1TB5+6T++n6rptimE=;
 b=YZ/xQS8cjOe6q/iuleVhRh0H4H8n53DKDBqLuDCCoxatodAYzBqq1D8ATipqwRI68y
 AJlpOEioy8+mU7ZK8IwGhbauz4zAqw8nV5FhyMBIv/vgoc2TUvHBwFovDZYw2I7IYX5E
 +UMbveXkGwJLvA7jKW1pAFyaHUoOROSndT9qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IUNHmrobcIG4oQzAePQtOJCStl1TB5+6T++n6rptimE=;
 b=JSfq3srFBlt9IjetER9tmPPBG+1Us1Wkrf6N+3g2Qv/F5oIyw9lizjFOJ6KAa/edQs
 2lzQP9ux2L96pVXMwwMjAknI/5Ir/PI3xFfdEMAEPCymitG5OYdWyB5CqM5YJETusmKL
 Ttcizyk7KvXOAFUGGeCeCE9KiB8ofSDicvkkpuXNAmHxXkwo7Neii1i72erACZLT3gyu
 yVgNYfSZd2Pw/f8C2GEBPkv6PS5/Q2tAW96+o/E3Rr2nJe5x10d9VFmpld/85GqdEtfu
 Ff4uuIAke+pIvPMuNfMzNTMkjxFKmGihA3cSj4sATyMDq+TLzJWR66hM7rOUHnWZuHwU
 Jy4A==
X-Gm-Message-State: AHQUAub9q10RCn5e+PRL72g4nx5ony2ua1l0K2OEkZQKjTtYWUGO/bWD
 NMZETRl3tyT8bORCShIYiQBytL5nVes=
X-Google-Smtp-Source: AHgI3Ia/kRJHsFhVBp4eiUblruvf7znBCKbZkjxgxqWrjO232OXbquMabpmhC0+iGvAUwCB/X9kh+Q==
X-Received: by 2002:a67:8b01:: with SMTP id n1mr2142537vsd.168.1549997840544; 
 Tue, 12 Feb 2019 10:57:20 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51])
 by smtp.gmail.com with ESMTPSA id x185sm12213940vkd.27.2019.02.12.10.57.18
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 10:57:19 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id z18so2254483vso.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 10:57:18 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr2127227vsd.222.1549997838512; 
 Tue, 12 Feb 2019 10:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor>
 <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
In-Reply-To: <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 12 Feb 2019 10:57:05 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
Message-ID: <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_105723_785228_4123E67D 
X-CRM114-Status: GOOD (  18.41  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMTE6NDEgUE0gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIE1vbiwgMTEgRmViIDIwMTkgYXQgMTk6NDAsIEd1
c3Rhdm8gQS4gUi4gU2lsdmEKPiA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4gd3JvdGU6Cj4gPgo+
ID4gSW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFy
ayBzd2l0Y2gKPiA+IGNhc2VzIHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdo
Lgo+ID4KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nczoKPiA+Cj4g
PiBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQzLmM6IEluIGZ1bmN0aW9uIOKAmHMzYzI0
NDNfY29tbW9uX2Nsa19pbml04oCZOgo+ID4gZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0
My5jOjM5MDozOiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2lt
cGxpY2l0LWZhbGx0aHJvdWdoPV0KPiA+ICAgIHNhbXN1bmdfY2xrX3JlZ2lzdGVyX2FsaWFzKGN0
eCwgczNjMjQ1MF9hbGlhc2VzLAo+ID4gICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgICAgIEFSUkFZX1NJWkUoczNjMjQ1MF9hbGlhc2VzKSk7
Cj4gPiAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiA+IGRyaXZlcnMvY2xrL3Nh
bXN1bmcvY2xrLXMzYzI0NDMuYzozOTM6Mjogbm90ZTogaGVyZQo+ID4gICBjYXNlIFMzQzI0MTY6
Cj4gPiAgIF5+fn4KPiA+Cj4gPiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQt
ZmFsbHRocm91Z2g9Mwo+ID4KPiA+IE5vdGljZSB0aGF0LCBpbiB0aGlzIHBhcnRpY3VsYXIgY2Fz
ZSwgIHRoZSBjb2RlIGNvbW1lbnQgaXMgbW9kaWZpZWQKPiA+IGluIGFjY29yZGFuY2Ugd2l0aCB3
aGF0IEdDQyBpcyBleHBlY3RpbmcgdG8gZmluZC4KPiA+Cj4gPiBUaGlzIHBhdGNoIGlzIHBhcnQg
b2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUKPiA+IC1XaW1wbGljaXQtZmFsbHRocm91
Z2guCj4KPiBJIHNhdyB0aGlzIGluIG11bHRpcGxlIHBsYWNlcyBhbHJlYWR5IGFuZCBJIHRoaW5r
IGZpeCBpcyB3cm9uZy4gVGhlCj4gcG9pbnQgaXMgdGhhdCB0aGUgY29kZSBpcyBjb3JyZWN0IC0g
dGhlIGZhbGwgdGhyb3VnaCBpcyBtYXJrZWQKPiBwcm9wZXJseS4KPgo+IEl0IGlzIGp1c3QgdGhl
IEdDQyB3aGljaCBoYXMgdG8gYmUgZml4ZWQgbm90IHRoZSBjb2RlLiBZb3Ugd2FudCB0bwo+IGFk
anVzdCB0aGUgY29kZSBmb3Igc3BlY2lmaWMgdmVyc2lvbiBvZiBHQ0MgYW5kIHdoYXQgaWYgR0ND
IGNoYW5nZXMKPiBpdHMgd2FybmluZz8gRm9yIGV4YW1wbGUgR0NDIG1pZ2h0IHJlcXVpcmUgImZh
bGwgdGhyb3VnaDogIi4uLiBvciBhbnkKPiBvdGhlciBzeW50YXguIEFub3RoZXIgcG9pbnQgLSB3
aGF0IGFib3V0IGNsYW5nJ3Mgc3ludGF4PwoKLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zIGlzIHN0
cmljdGVyIGFuZCBtYXBzIHRvIC1XZXh0cmEsIGhlbmNlIGl0cwpjaG9pY2UuIEdDQydzIGxldmVs
cyB3ZXJlIGNob3NlbiBiYXNlZCBvbiB0aGUgZXhpc3RpbmcgbGludGVycywgc3RhdGljCmFuYWx5
emVycywgZXRjLiBUaGUgcGF0dGVybnMgYXJlIHVubGlrZWx5IHRvIGNoYW5nZSAoc2VlIHRoZSBn
Y2MKbWFuLXBhZ2UpLgoKQ2xhbmcgZG9lc24ndCByZWNvZ25pemUgYW55dGhpbmcgaW4gQyBtb2Rl
IChob3BlZnVsbHkgdGhpcyB3aWxsIGJlCmZpeGVkIGluIHRoZSBmdXR1cmVbMV0pLgoKQXMgbG9u
ZyBhcyBvbmUgb2YgdGhlIGNvbXBpbGVycyBpcyBhYmxlIHRvIGNoZWNrIHRoaXMsIHdlJ2xsIGF2
b2lkIHRoZQpidWdzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIG1pcy1wYXR0ZXJuLiBHdXN0YXZvJ3Mg
ZWZmb3J0cyBoZXJlIGhhdmUKZm91bmQga2luZCBvZiBhIGxvdCBvZiBidWdzLCBzbyBJIHRoaW5r
IGl0J3Mgd29ydGggYSBsaXR0bGUgY2h1cm4gdG8KYWRkIHRoZXNlIChhbmQgbWFrZSBtaW5vciBh
ZGp1c3RtZW50cyB0byBleGlzdGluZyBjb21tZW50cykuCgpbMV0gaHR0cHM6Ly9idWdzLmxsdm0u
b3JnL3Nob3dfYnVnLmNnaT9pZD0zNzEzNQoKLS0gCktlZXMgQ29vawoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
