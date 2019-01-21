Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54132C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:21:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA4520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bnl7P4qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA4520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzXLVxoju7Ywapeto3erGQlpxee+pQ0oKcS8+FQtaAI=; b=bnl7P4qX2z5exc
	XifI6zUjfl3JC+QmHDB6hrOUuCnc4scTl/fUVNUVMq7r0sS0qYDJ2jN+NeZhW2JtbeY/neqBS7qQu
	FBSrKpdYWsJ/Y1UPkQBIyfXXpkcmTfCYLRbCypti2u++zSI7yv7W7qJ5+xf4A4WuohUpNEFRcK+mg
	9AX3rHJv7vQPejK6IhL60k5t9hD01wKB7YSfRGwX8HQ47xrPGKfCAYq/2171Ckt+p0cDZqY2Bd8Bj
	WCuM7uP3mruCpsg7IBBxuYW5aqNnNcP5IbZp0o3rqJqc0b0jQuLgONX1pL1FtLlBnSHcYQxoDmtYl
	KLR2/N320Dzz7qDQB+Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldFv-0004oD-IH; Mon, 21 Jan 2019 17:21:03 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldFr-0004ns-9R
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:21:01 +0000
Received: by mail-ed1-f48.google.com with SMTP id x30so17204710edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FUKD+1guFUm6DCBdVTwWkKjFm2YNCLJAdTI9du0QQ1I=;
 b=XGCB3s9tYvOYi4pOvBURLm7som5iAzhevzstvPBLs0uly59XZB7wQt3L3gCO+9OyN0
 CvwNwRHtpeSo/wkowxcDTxULIP5lfgF4ram/35kRBWqWj4USzpelgmZyMHRiNTwy9fMc
 XCvVqzDZu+8ExhpC3U9ErCE7+HuRTA8rLw9D0dTdarCpEg/O4romk0RckffFa234Lzt4
 8Of1mLslBoWLwS2bCs403qXl8j0t8vdq72ARseS7z+F+BcgERYVqWX99/ai2LRVYnRSF
 jHhY37OJSI8pLFcwL8AZgUq6mkeokFZQNer4UN86VuHtIm+PhU8gjvGli7S1xjCN7KH2
 IcvA==
X-Gm-Message-State: AJcUukceohaXkOX1QnrfjlGWxlo1pLvL9YJ0qfiYqRmXacPQMknO4d0r
 Gnu78wj+Y5mjtpLSRlflqK/TNQMEWT8=
X-Google-Smtp-Source: ALg8bN6XfPGaCct8cMiaF4PvH7Rtyktm+EoFjVUjz4cJxaE61yjDSuiD8IsU1xuuB1nKg/bByAjemA==
X-Received: by 2002:a17:906:7c42:: with SMTP id
 g2mr2038643ejp.212.1548091256991; 
 Mon, 21 Jan 2019 09:20:56 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44])
 by smtp.gmail.com with ESMTPSA id e35sm9188742eda.13.2019.01.21.09.20.56
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 09:20:56 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id q18so24267836wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:20:56 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr27670155wrv.87.1548091256030; 
 Mon, 21 Jan 2019 09:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190121132517.iv2v3hug4uihefnk@flea>
 <20190121150728.tw4ryjgzzbxh7qmc@plaes.org> <3373528.ybUWJjoEmk@jernej-laptop>
In-Reply-To: <3373528.ybUWJjoEmk@jernej-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 22 Jan 2019 01:20:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66k25gPDK8y77UZiUWG6N3TBgbX3j8gdwGfGKxSWv-rOw@mail.gmail.com>
Message-ID: <CAGb2v66k25gPDK8y77UZiUWG6N3TBgbX3j8gdwGfGKxSWv-rOw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
 Priit Laes <plaes@plaes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_092059_338010_1D978A9C 
X-CRM114-Status: GOOD (  30.66  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Jonathan Liu <net147@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgMToxOCBBTSBKZXJuZWogxaBrcmFiZWMgPGplcm5lai5z
a3JhYmVjQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBEbmUgcG9uZWRlbGplaywgMjEuIGphbnVhciAy
MDE5IG9iIDE2OjA3OjI4IENFVCBqZSBQcmlpdCBMYWVzIG5hcGlzYWwoYSk6Cj4gPiBPbiBNb24s
IEphbiAyMSwgMjAxOSBhdCAwMjoyNToxN1BNICswMTAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOgo+
ID4gPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwMjo1MToyNlBNICswMDAwLCBQcmlpdCBMYWVz
IHdyb3RlOgo+ID4gPiA+IE9uIEZyaSwgSmFuIDE4LCAyMDE5IGF0IDAzOjA0OjE4UE0gKzAxMDAs
IE1heGltZSBSaXBhcmQgd3JvdGU6Cj4gPiA+ID4gPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAx
MDoxMDo1M0FNICswMDAwLCBQcmlpdCBMYWVzIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
SXQgZG9lc24ndCBsb29rIHJlbGF0ZWQgdG8gdGhlIGNsb2NrIHJhdGUgaXRzZWxmLCBzaW5jZSBp
dAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZG9lc24ndAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2hh
bmdlIGJldHdlZW4gdGhlIHR3byBjYXNlcy4gSG93ZXZlciwgaW4gb25lIGNhc2UgdGhlIEREQwo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2xvY2sgaXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGVuYWJs
ZWQgYW5kIGluIHRoZSBvdGhlciBpdCdzIGRpc2FibGVkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdhcyBpdCB0YWtlbiBhdCB0aGUgc2FtZSB0aW1lPyBNYXli
ZSB5b3UgY2FuIHRyeSB3aXRoIHRoYXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHBhdGNoPwo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gaHR0cDovL2NvZGUuYnVsaXgub3JnL3o3am1rbS01NTUzNDQ/cmF3
Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MsIGFmdGVyIGRv
aW5nIH41MCsgYm9vdHMgSSBoYXZlbid0IHNlZW4gYSBzaW5nbGUKPiA+ID4gPiA+ID4gPiA+ID4g
PiBmYWlsdXJlLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gUHJldmlv
dXNseSBJIGhhZCBmb2xsb3dpbmcgZmFpbHVyZSBjYXNlcyB3aGljaCBhcmUgbm93IGJvdGgKPiA+
ID4gPiA+ID4gPiA+ID4gPiBmaXhlZDoKPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+IGEpIExpbnV4IHdpdGhvdXQgdS1ib290IEhETUksIHdoZXJlIG9uZSBpbiBldmVyeSA2
LTcgYm9vdHMKPiA+ID4gPiA+ID4gPiA+ID4gPiBmYWlsZWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4g
YikgdS0tYm9vdCB3aXRoIGhkbWkgZW5hYmxlZCBzd2l0Y2hpbmcgdG8gc2ltcGxlZmIgYW5kIHRo
ZW4KPiA+ID4gPiA+ID4gPiA+ID4gPiBzd2l0Y2hpbmcKPiA+ID4gPiA+ID4gPiA+ID4gPiB0byBr
bXMsIHdoZXJlIHByZXZpb3VzbHkgYWxsIGJvb3RzIGVuZGVkIHVwIHdpdGggZ2FyYmxlZAo+ID4g
PiA+ID4gPiA+ID4gPiA+IHNjcmVlbi4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gU28gaXQncyBub3QgcmVhbGx5IGEgZml4LCBidXQgaXQgcmVhbGx5IGxvb2tzIGxpa2UgdGhl
IGNsb2NrCj4gPiA+ID4gPiA+ID4gPiA+IGlzIG5vdAo+ID4gPiA+ID4gPiA+ID4gPiBlbmFibGVk
IHdoZW4gaXQgc2hvdWxkLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBDYW4g
eW91IGRlc2NyaWJlIHlvdXIgdGVzdCBzY2VuYXJpbyBhIGJpdCBtb3JlPyBXaGF0IGFyZSB5b3UK
PiA+ID4gPiA+ID4gPiA+ID4gZG9pbmcKPiA+ID4gPiA+ID4gPiA+ID4gZXhhY3RseSwganVzdCBi
b290aW5nPyBXaGVuIGRvIHlvdSBzdGFydCB1c2luZyB0aGUgZGlzcGxheT8KPiA+ID4gPiA+ID4g
PiA+ID4gV2hlbiBkaWQKPiA+ID4gPiA+ID4gPiA+ID4geW91IGNhcHR1cmUgdGhlIGRlYnVnZnMg
b3V0cHV0IHRoYXQgeW91IHBhc3RlZD8KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBE
aXNwbGF5IGlzIGFscmVhZHkgY29ubmVjdGVkIHZpYSBIRE1JIHRvIHRoZSBib2FyZC4gSSBkb24n
dAo+ID4gPiA+ID4gPiA+ID4gcmVhbGx5Cj4gPiA+ID4gPiA+ID4gPiByZW1vdmUgaXQsIEkganVz
dCBib290IHRoZSBkZXZpY2UgYW5kIGxldCBpdCBzdGFydCBYb3JnLgo+ID4gPiA+ID4gPiA+ID4g
TWVhbndoaWxlIEkganVzdCBzc2ggaW50byB0aGUgZGV2aWNlIGFuZCBjYXB0dXJlIGRlYnVnZnMg
b3V0cHV0Lgo+ID4gPiA+ID4gPiA+ID4gU2VlIG15IDMgdGVzdGluZyBzY2VuYXJpb3MgYmVsb3cu
Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gS2VybmVsIGFsc28gaW5jbHVkZXMgb25l
IGV4dHJhIHBhdGNoIHRvIGZhbGwgYmFjayB0byBEREMsIGluCj4gPiA+ID4gPiA+ID4gPiBjYXNl
IEhQRAo+ID4gPiA+ID4gPiA+ID4gZmFpbHMuIE1vc3RseSB0aGUgc2FtZSBJIGFscmVhZHkgc3Vi
bWl0dGVkIGxhc3QgTm92ZW1iZXIgWzFdLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRG8g
eW91IGhhdmUgdGhlIHNhbWUgaXNzdWUgd2l0aG91dCB0aGF0IHBhdGNoPwo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBDYW4ndCByZWFsbHkgdGVzdCB0aGlzIGRpc3BsYXkgd2l0aG91dCB0aGlzIHBh
dGNoIGFuZCBJIGRvIG5vdCBoYXZlCj4gPiA+ID4gPiA+IG90aGVyCj4gPiA+ID4gPiA+IEhETUkv
RFZJIHNjcmVlbnMuIEFuZCB0aGlzIGlzc3VlIGRvZXMgbm90IGhhcHBlbiB3aXRoIG90aGVyIEhE
TUkKPiA+ID4gPiA+ID4gZGlzcGxheXMKPiA+ID4gPiA+ID4gdGhhdCBJIGhhdmUgaGVyZS4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBDYW4ndCB5b3UganVzdCBmb3JjZSB0aGUgbW9uaXRvciB0byBiZSBy
ZXBvcnRlZCBhcyBwcmVzZW50PyBJdCdzIG5vdAo+ID4gPiA+ID4gZ3JlYXQgYW5kIHdlIGRvbid0
IHdhbnQgdG8gbWVyZ2UgaXQsIGJ1dCB0aGF0IHdvdWxkIGFsbG93IHlvdSB0byB0ZXN0Cj4gPiA+
ID4gPiB0aGF0IHNldHVwIHdpdGhvdXQgdG9vIG1hbnkgaW50ZXJmZXJlbmNlcy4KPiA+ID4gPgo+
ID4gPiA+IEJhc2VsaW5lIGlzIGNsZWFuIHUtYm9vdCAvIGxpbnV4LiBVLWJvb3QgZG9lcyBub3Qg
ZGV0ZWN0L2VuYWJsZSBkaXNwbGF5Lgo+ID4gPiA+Cj4gPiA+ID4gMSkgQm9vdGluZyBMaW51eCB3
aXRoIGRybS5kZWJ1Zz0weGUKPiA+ID4gPgo+ID4gPiA+ICogTGludXggZG9lcyBub3QgZGV0ZWN0
L2VuYWJsZSBkaXNwbGF5Cj4gPiA+ID4KPiA+ID4gPiAyKSBCb290aW5nIHdpdGggZHJtLmRlYnVn
PTB4ZSB2aWRlbz1IRE1JLUEtMTo2NDB4NDgwQDYwZQo+ID4gPiA+Cj4gPiA+ID4gKiBMaW51eCBk
ZXRlY3RzIGRpc3BsYXksIGJ1dCBkaXNwbGF5IGlzIGdhcmJsZWQsIGFuZCBwcm9wZXIgZWRpZCBk
YXRhIGlzCj4gPiA+ID4gZGV0ZWN0ZWQ6Cj4gPiA+ID4KPiA+ID4gPiBbc25pcF0KPiA+ID4gPiBw
bGwtdmlkZW8xICAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgIDMyNzAw
MDAwMAo+ID4gPiA+IDAgICAgIDAgIDUwMDAwPiA+Cj4gPiA+ID4gICAgcGxsLXZpZGVvMS0yeCAg
ICAgICAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAgICA2NTQwMDAwMDAKPiA+ID4gPiAgICAw
ICAgICAwICA1MDAwMD4gPgo+ID4gPiA+ICAgICAgIGhkbWktdG1kcyAgICAgICAgICAgICAgICAw
ICAgICAgICAwICAgICAgICAwICAgIDI1MTUzODQ2Cj4gPiA+ID4gICAgICAgMCAgICAgMCAgNTAw
MDA+ID4KPiA+ID4gPiAgICAgICAgICBoZG1pLWRkYyAgICAgICAgICAgICAgMCAgICAgICAgMCAg
ICAgICAgMCAgICAgICA4OTgzNQo+ID4gPiA+ICAgICAgICAgIDAgICAgIDAgIDUwMDAwPiA+Cj4g
PiA+ID4gWy9zbmlwXQo+ID4gPiA+Cj4gPiA+ID4gMykgQm9vdGluZyB3aXRoIGRybS5kZWJ1Zz0w
eGUgdmlkZW89SERNSS1BLTE6NjQweDQ4MEA2MGUKPiA+ID4gPiBBbmQgYWxzbyBvbmUgZXh0cmEg
cGF0Y2ggZm9yIExpbnV4IHdoZXJlIEhETUkgRERDIGNsb2NrIG1hcmtlZCBhcwo+ID4gPiA+IGNy
aXRpY2FsCj4gPiA+ID4KPiA+ID4gPiBMaW51eCBkZXRlY3RzIGFuZCBpbml0aWFsaXplcyBkaXNw
bGF5IHByb3Blcmx5Ogo+ID4gPiA+IFtzbmlwXQo+ID4gPiA+IHBsbC12aWRlbzEgICAgICAgICAg
ICAgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAgMzI3MDAwMDAwCj4gPiA+ID4gMCAgICAg
MCAgNTAwMDA+ID4KPiA+ID4gPiAgICBwbGwtdmlkZW8xLTJ4ICAgICAgICAgICAgICAgMSAgICAg
ICAgMSAgICAgICAgMCAgIDY1NDAwMDAwMAo+ID4gPiA+ICAgIDAgICAgIDAgIDUwMDAwPiA+Cj4g
PiA+ID4gICAgICAgaGRtaS10bWRzICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDAg
ICAgMjUxNTM4NDYKPiA+ID4gPiAgICAgICAwICAgICAwICA1MDAwMD4gPgo+ID4gPiA+ICAgICAg
ICAgIGhkbWktZGRjICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAwICAgICAgIDg5ODM1
Cj4gPiA+ID4gICAgICAgICAgMCAgICAgMCAgNTAwMDA+ID4KPiA+ID4gPiBbL3NuaXBdCj4gPiA+
Cj4gPiA+IEkgZ3Vlc3MgeW91J2xsIG5lZWQgdG8gdHJhY2sgZG93biB3aGVuIHRoZSBoZG1pLXRt
ZHMgYW5kIGhkbWktZGRjIGFyZQo+ID4gPiBlbmFibGVkIGFuZCBkaXNhYmxlZCwgYW5kIGlmIGl0
IG1ha2VzIHNlbnNlIDovCj4gPgo+ID4gT0ssIGZpZ3VyZWQgb3V0IHRoZSBjYXVzZS4KPiA+Cj4g
PiBBcHBhcmVudGx5LCBmb3IgZWFjaCBkZGMgcG9sbCB3ZSBlbmFibGUgZGRjIGNsb2NrIHdoaWNo
IGlzIGEgY2hpbGQgb2YgVE1EUwo+ID4gY2xvY2suIEFmdGVyIHRyYW5zZmVyIGlzIGRvbmUsIHdl
IGRpc2FibGUgdGhlIGNsb2NrIGFuZCB0aGlzIGFsc28gdGVhcnMgZG93bgo+ID4gdGhlIHBhcmVu
dCBiZWNhdXNlIGl0cyBvbmx5IHVzZXIgaGFzIGdvbmUgbWlzc2luZy4uIDooCj4gPgo+ID4KPiA+
IFNvIGJhc2ljYWxseSwgcGF0Y2ggYmVsb3cgYWxzbyB3b3JrcywgYnV0IEkgZ3Vlc3Mgd2Ugc2hv
dWxkIG92ZXJyaWRlCj4gPiB0aGUgc3VuNGlfdG1kc19vcHMuZGlzYWJsZSB0byBwcm9wZXJseSBh
Y2NvdW50IGZvciB0bWRzIGNsb2NrIHVzZS4KPiA+Cj4KPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBu
b2JvZHkgY2FsbGVkIGNsa19wcmVwYXJlX2VuYWJsZSgpIG9uIHRtZHMgY2xvY2suIEkgaGFkCj4g
c2ltaWxhciBpc3N1ZSB3aXRoIFRNRFMgY2xvY2sgZm9yIEgzLCBzaW5jZSBJIGJhc2VkIGNvZGUg
b24gc3VuNGkgdG1kcyBjbGsKPiBkcml2ZXIuIEFsdGhvdWdoIGNsb2NrIGRvZXNuJ3QgaGF2ZSBl
bmFibGUgYml0LCBpdCBzdGlsbCBoYXMgdG8gYmUgZG9uZSB0bwo+IGhhdmUgcHJvcGVyIHJlZmVy
ZW5jZSBjb3VudCBhbmQgdG8gcHJldmVudCBpc3N1ZXMgbGlrZSB0aGlzLgoKSUlSQyBJIGhhZCB0
aGUgc2FtZSBndXQgZmVlbGluZyBhdCB0aGUgdGltZSwgYnV0IG90aGVyIHN0dWZmIGhhcHBlbmVk
LiA6KAoKUHJpaXQsIGNvdWxkIHlvdSBzZW5kIGEgcHJvcGVyIHBhdGNoIGVuYWJsaW5nIGFuZCBk
aXNhYmxpbmcgdGhlIFRNRFMgY2xvY2s/Ckl0IHNob3VsZCBiZSBkb25lIGFzIHBhcnQgb2Ygc3Vu
NGlfaGRtaV9lbmFibGUgYW5kIHN1bjRpX2hkbWlfZGlzYWJsZS4KCkNoZW5ZdQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
