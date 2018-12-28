Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798972146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="toNCvIhv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="UY0MB+Cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798972146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WTwyej5/JCjNF7gIelHN/YHL7Ku8RIvf16Lupv1qc0s=; b=toNCvIhvo/KUjw
	KcoHZA2m6l5SYqyNkHmjjo4NRGfMlcCNP0lUMjuZQjHaILaEqgk0AKcI4WxOdenDAk5T5gh7r7u5x
	Y7/1h073nEQkGRQHbHtK2HG51jnMPcBXgxkV71yTC/BLavDSgCwHOb6W2bqo/nE/XbTkZkduGC5X4
	68iNmYH+4PaMEjhqgF81DSpD9ydwDqLGIM/cJjLnBW4CH1E672IVeJSyegR+UyMeRbpIxIxBWompP
	r/61RDqPUhNREiFaxXfMMZtlWEA6UMTPDZyrQJy9JZkIhrDyQfAz9BhO/6KzB/YLti7WJoJ75u/aE
	+ovQRL7H+GvmUUXIQK5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuIV-0001EI-Nm; Fri, 28 Dec 2018 15:43:39 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuIR-0001D0-Ls
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 15:43:37 +0000
Received: by mail-it1-x141.google.com with SMTP id z7so28810674iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=jByY46wNFvE4E4rauyf9hkYWJfsbk11FBUlYHXn28d4=;
 b=UY0MB+CpsBZkEwKYdlIyeoUtQhxbA7gRPtwr4cQyt19Hwq9g6SX6VqsLo9lCbiP4aZ
 3dt1wH17fl+iF4k3qrXqPMYJb/CQdsmNcamg8d2ApqbKcJFHeHItqjrfffUQPdxJ3Odz
 2N6iKZrmM+5tLe+AXj0biZEBHEjzwDvCvZI5JoJjTXjwwf7ZpzrIeus3MfOLtIqi9rUl
 Na2OoDk6dj3BnIcBVW9e4LujA9imyLK6kfbvmuiJIrto603RTU89623TGiE8fT9woDII
 UUFjxhIu/X/kmIDF4msJRqrBNgKh8CnRU34OH2sbbgE4W4LgIzHPVRaGuNUp+zbG6lf0
 C4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=jByY46wNFvE4E4rauyf9hkYWJfsbk11FBUlYHXn28d4=;
 b=cNiNxpyOXpZh3q/tapm6kUifuvK1cdTgZjnvn3zdY4UWXT/kmP/qBnJ2tukxbWea7Q
 robbM4RyuLQ6hJoB4PcXGUi2nQxpjmsmxLgG0Bw7S9bhll+19KL8cRuQh5IMUcQGjT26
 qX+n0qI1TnPdoNQR8K/qyo6yeVi/H3a205F2N0vTVcGQaQ9zdjfclo3zlc60ayOGCQBZ
 u7GrlR/T6Wy6mxqSpOcQV6nN6B8L3aQDNnhFk2W/oUkXkDuPOda0M9wPFeZVqBi7e6Mu
 IaLAzvAVE2J7GVD/mDNotFBOk6RpqDFV66XdqTg1RpP4Mu4WFD+CmKKFEFgrI029R9RD
 OUqg==
X-Gm-Message-State: AA+aEWYgKT/D1Ss4a/B3OHT8eTkXBy613j+ZMya60uVunEBtgpmWY1GV
 1mLOBRL3ZMPPIHphk8gnohfVZA==
X-Google-Smtp-Source: AFSGD/V4ZKvW86qBczs2oX2LerHoE1te6rX1BUiOAFJ2nQjOqzoCmEGsFSCi8EXHjGyxFQ4XqubXIw==
X-Received: by 2002:a24:c8d7:: with SMTP id w206mr18528163itf.56.1546011803431; 
 Fri, 28 Dec 2018 07:43:23 -0800 (PST)
Received: from x220t ([64.26.149.125])
 by smtp.gmail.com with ESMTPSA id y5sm17954494itb.42.2018.12.28.07.43.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 07:43:22 -0800 (PST)
Date: Fri, 28 Dec 2018 10:43:16 -0500
From: Alexander Aring <aring@mojatatu.com>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Message-ID: <20181228154316.2x2tyfzidnb4emqo@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
 <20181224153205.ycr2zdrjbyklulfh@x220t>
 <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_074335_717540_00648B43 
X-CRM114-Status: GOOD (  28.25  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Xue Liu <liuxuenetmail@gmail.com>,
 netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Dollar Chen <dollar.chen@wtmec.com>, linux-lpwan@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDU6NTc6NTNBTSArMDEwMCwgQW5kcmVhcyBGw6RyYmVy
IHdyb3RlOgo+IEhpIEFsZXhhbmRlciBhbmQgWHVlIExpdSwKPiAKPiBBbSAyNC4xMi4xOCB1bSAx
NjozMiBzY2hyaWViIEFsZXhhbmRlciBBcmluZzoKPiA+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0
IDAyOjUwOjU4UE0gKzAxMDAsIFh1ZSBMaXUgd3JvdGU6Cj4gPj4gT24gTW9uLCAxNyBEZWMgMjAx
OCBhdCAxNToxOSwgQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPiB3cm90ZToKPiA+
Pj4gQW0gMTcuMTIuMTggdW0gMDk6NTAgc2NocmllYiBYdWUgTGl1Ogo+ID4+Pj4gSSBoYXZlIGEg
cXVlc3Rpb24gYWJvdXQgdGhlIGFyY2hpdGVjdHVyZSBvZiB5b3VyIG1vZHVsZS4gQUZBSUsgTG9S
YVdBTgo+ID4+Pj4gaXMgYWxyZWFkeSB0aGUgTUFDIExheWVyIGFib3ZlIHRoZSBMb1JhIHRlY2hu
b2xvZ3kuIFdoeSBkbyB5b3Ugd2FudCB0bwo+ID4+Pj4gbWFrZSBhIG5ldyBsYXllciBjYWxsZWQg
Im1hY2xvcmF3YW4iID8KPiA+Pj4KPiA+Pj4gSSBoYWQgYXNrZWQgSmlhbi1Ib25nIHRvIHNlcGFy
YXRlIGJldHdlZW4gaGlzIHNvZnQtTUFDIGltcGxlbWVudGF0aW9uCj4gPj4+IGFuZCB0aGUgY29t
bW9uIGJpdHMgbmVlZGVkIHRvIGRyaXZlIGhhcmQtTUFDIGltcGxlbWVudGF0aW9ucyBmb3VuZCBv
bgo+ID4+PiBzZXZlcmFsIG9mIHRoZSBoYXJkd2FyZSBtb2R1bGVzIG1hZGUgYXZhaWxhYmxlIHRv
IG1lLgo+ID4+Pgo+ID4+IEFzIGEgcmVmZXJlbmNlIExpbnV4IDgwMi4xMSB1c2VzIGNmZzgwMjEx
IHRvIHRhbGsgd2l0aCBoYXJkLU1BQyBkZXZpY2VzLgo+ID4+IFdlIG1heSBhbHNvIHVzZSB0aGUg
bmFtZSDigJxjZmdsb3Jh4oCdIGZvciBoYXJkLU1BQyBpbXBsZW1lbnRhdGlvbi4KPiA+IAo+ID4g
VGhlcmUgZXhpc3RzIGFsc28gYSBjZmc4MDIxNTQuIDotKQo+ID4gCj4gPiBOb3RlIHRoYXQgY2Zn
ODAyMTEgaXMgYWxzbyBmb3IgcHJvdmlkaW5nIGEgYmFja3dhcmRzY29tcGF0aWJpbGl0eSB0byB0
aGUKPiA+IHdpcmVsZXNzIGlvY3RsKCkgaW50ZXJmYWNlLgo+ID4gCj4gPiBJbiB0aGVvcnkgaXQn
cyBzaW1wbGU6Cj4gPiAKPiA+IG5ldGxpbmsgQVBJIC0+IFNvZnRNQUMgKG1hY0ZPT0JBUiBsYXll
cikgLT4gY2ZnRk9PQkFSIGltcGxlbWVudGF0aW9uIC0+IGRyaXZlciBsYXllcgo+ID4gICAgICAg
ICAgICAgXC0+IEhhcmRNQUMgKGRyaXZlciBsYXllcikgLT4gY2ZnRk9PQkFSIGltcGxlbWVudGF0
aW9uCj4gCj4gU28gaG93IGRvZXMgY2ZnRk9PQkFSIHJlbGF0ZSB0byBubEZPT0JBUiBub3c/IEdp
dmVuIHRoYXQgd2Ugd2VyZSB0b2xkIHRvCj4gdXNlIG5ldGxpbmsgYW5kIHBvaW50ZWQgdG8gc29t
ZSBubDgwMndoYXRldmVyLCBJIGFtIGNvbmZ1c2VkIGFib3V0IHR3bwo+IHBlb3BsZSBub3cgY2Fs
bGluZyBmb3IgY2ZnLiBXZSBoYXZlIGFuIG5sbG9yYSBzdHViYmVkIGluIGxpbnV4LWxvcmEuZ2l0
LAo+IGFuZCBJIHdhcyBleHBlY3RpbmcgdG8gc2VlIGFuIG5sbG9yYXdhbsK5IGVpdGhlciBpbiB0
aGlzIHNlcmllcyBvciBvbgoKV2h5IHRoZXJlIGlzIGEgZGlmZmVyZW50IGJldHdlZW4gdHdvIGxv
cmEgdGVjaG5vbG9naWVzPyBUaGlzIHNvdW5kcyB5b3UKZHJpdmluZyBpbnRvIHR3byBsb3JhIHN1
YnN5c3RlbXMgd2l0aG91dCBvbmUgdXNlcnNwYWNlIGFwaSB0byBhY2Nlc3MgdGhlbSwKdGhpcyBn
ZXR0aW5nIHdvcnNlLgoKPiB0b3AuIElmIHlvdSdyZSBzdWdnZXN0aW5nIHRvIHJlbmFtZSB0aGVt
IHRlY2hub2xvZ3ktbmV1dHJhbCwgdGhlbiBwbGVhc2UKCkkgYW0gc29ycnksIEkgYWN0dWFsbHkg
bWVhbnQgdGhhdC4uLiBQZW9wbGUgdGVsbCBtZSB0aGF0IEkgY2FuJ3QgZXhwbGFpbgp0aGluZ3Mg
YWxsIHRoZSB0aW1lLgoKPiBzYXkgc28gY2xlYXJseSAtIG90aGVyd2lzZSBpdCBzb3VuZHMgdG8g
bWUgbGlrZSB5b3UgZGlkbid0IGFjdHVhbGx5IGxvb2sKPiBhdCB0aGUgc3RhZ2VkIGNvZGUgeWV0
IG9yIGRpZG4ndCByZWFkIG91ciBwcmV2aW91cyBkaXNjdXNzaW9ucyBhbmQgbGVhZAo+IG91ciBj
b250cmlidXRvcnMgdG8gcmVpbnZlbnQgdGhpbmdzIHdlIGFscmVhZHkgaGF2ZS4uLgo+IAoKQXMg
ZXhhbXBsZSBmb3IgODAyLjE1LjQ6CgpubDgwMjE1NCAod2hpY2ggaXMgb25lIG5ldGxpbmsgaW50
ZXJmYWNlIGZvciBkb2Vzbid0IG1hdHRlciB3aGF0CmtpbmQgODAyLjE1LjQgZGV2aWNlIGlzIGJl
aGluZCkgLT4gY2FsbGJhY2sgc3RydWN0dXJlIG9mIGNmZzgwMjE1NCB3aGljaApnb2VzIHRvIGEg
c29tZWhvdyA4MDIuMTUuNCBkZXZpY2UgYXMgU29mdE1BQyBsYXllciBvciBIYXJkTUFDIGRyaXZl
ci4KCj4gV2UgcmVhbGx5IG5lZWQgdG8gY29tcGxldGUgdGhlIGxheWVycyBmcm9tIHRoZSBncm91
bmQgdXAgYmVmb3JlIHdlIGdldAo+IGxvc3QgaW4gbW9yZSBuaWNlLXRvLWhhdmUgdXBwZXIgbGF5
ZXJzOiBGb3IgTG9SYVdBTiB0aGF0IG1lYW5zIHdlIG5lZWQKPiB0byBoYXZlIFRYIGFuZCBSWCB3
b3JraW5nIGZvciBMb1JhIF9hbmRfIEZTSy4gc3gxMjc2IHN0aWxsIGhhcyBsb3RzIG9mCj4gaGFy
ZGNvZGVkIHN0dWZmIGZyb20gbXkgb3duIHRlc3RpbmcgdGhhdCBuZWVkcyB0byBob29rIGludG8g
bmxsb3JhLCBhbmQKPiBGU0sgZXhpc3RzIG9ubHkgYXMgRVRIX1BfRlNLIGNvbnN0YW50IHNvIGZh
ciwgd2l0aCBubyBjb25jZXB0IGZvcgo+IHN3aXRjaGluZyBtb2RlcyB5ZXQgKHdoaWNoIGFzIG1l
bnRpb25lZCBpbiBteSBwcmVzZW50YXRpb27CuSBuZWVkcyB0byBnbwo+IHZpYSBzbGVlcCBtb2Rl
LCBsb3NpbmcgbW9zdCByZWdpc3RlciBzZXR0aW5ncykgbm9yIGFueSBuZXRsaW5rIHN1cHBvcnQu
Cj4gTm90IGFsbCBkcml2ZXJzIG5lZWQgdG8gYmUgYXQgdGhlIHNhbWUgaW1wbGVtZW50YXRpb24g
bGV2ZWwsIG9mIGNvdXJzZSwKPiBidXQgd2UgbmVlZCBhdCBsZWFzdCBvbmUgdGhhdCdzIGZhciBl
bm91Z2ggdG8gdmFsaWRhdGUgc3VjaCBwYXRjaGVzLgo+IAoKWW91ciByZWdpc3RlciBiZWhhdmlv
dXIgc291bmRzIGZvciBtZSBsaWtlIGEgZmVhdHVyZSBmb3IgcmVnbWFwLiBPcgplaXRoZXIgYSBm
ZWF0dXJlIHRvIGhhbmRsZSBpbiB5b3VyIHN1YnN5c3RlbS4KCj4gQW5kIHNlZWluZyB0aGF0IEkg
anVzdCBmb3VuZCBhIG1ham9yIGJ1ZyBpbiBzeDEyNzYgZHJpdmVyJ3MgVFggcGF0aCwKPiBhcHBh
cmVudGx5IG5vIG9uZSBhcGFydCBmcm9tIG1lIGlzIHRlc3RpbmcgdGhhdCBkcml2ZXIgLSBzeDEy
OHggYW5kCj4gc3gxMzAxIHdlcmUgbm90IHlldCBjb21wbGV0ZSBlbm91Z2ggdG8gdHJhbnNtaXQs
IGFuZCBkdWUgdG8gdGhlIG9wZW4KPiBzb2NrZXQgYWRkcmVzcy9wcm90b2NvbCBkaXNjdXNzaW9u
cyBub25lIGNhbiByZWNlaXZlIHlldCwgc28gYXMgSmlyaQo+IGhpbnRlZCwgdGhpcyBMb1JhV0FO
IHNvZnQtTUFDIHBhdGNoIHNlcmllcyBjYW4ndCBoYXZlIGJlZW4KPiBydW50aW1lLXRlc3RlZCBh
Z2FpbnN0IGFueSBzdGFnZWQgZHJpdmVyIGF0IGFsbCEgID0+IFtSRkMgbG9yYS1uZXh0IHY1IDYv
Nl0KPiAKCmFoYS4gV2hlbiBJIHN0YXJ0ZWQgd29ya2luZyBvbiBpZWVlODAyMTU0IG1hbnkgdGlt
ZXMgSSB0aG91Z2h0IG5vYm9keQpoYWQgcmVhbGx5IHRlc3RlZCBpdC4gVGhhdCdzIHNvbWVob3cg
dGhlIHByb2Nlc3Mgb2YgdXBzdHJlYW0KcHJvZ3JhbW1pbmcsIGl0J3MgZ3Jvd2luZyBvdmVyIHRo
ZSB0aW1lLiBUaGUgZmlyc3QgaW1wbGVtZW50YXRpb24gaXMKYWx3YXlzIHNvbWVob3cgY3JhcHB5
LCBidXQgcGVvcGxlIHdvcmtpbmcgb24gaXQgYW5kIGdldCBleHBlcmllbmNlIG92ZXIKdGhlIHRp
bWUsIHlvdSBjYW5ub3QgaGF2ZSBwZXJmZWN0IGNvZGUuCgo+IFRoZXJlZm9yZSBJIHRob3VnaHQg
aW4gb3VyIGNhc2Ugc29tZSBoYXJkLU1BQyBtYXkgYmUgZWFzaWVyIHRvIHZhbGlkYXRlCj4gTG9S
YVdBTiBzb2NrZXRzIChwYXRjaCAxLzYpLCB0byBhdm9pZCBhIGRlcGVuZGVuY3kgb24gY29tcGxl
dGluZyB0aGUgTUFDCj4gaW1wbGVtZW50YXRpb24gZmlyc3QuIEZvciBleGFtcGxlLCBpTTg4MCwg
UkYxMjc2VFMgYW5kIDMyMDAxMzUzIGFyZSBwdXJlCj4gTG9SYVdBTiBtb2R1bGVzIHdpdGhvdXQg
cmF3IExvUmEgc3VwcG9ydC4gKFdoZXJlYXMgbWFueSBvdGhlcnMgc3VwcG9ydAo+IGJvdGggYW5k
IEknbSBzdGlsbCBsb29raW5nIGZvciBpbnB1dCBvbiBob3cgdG8gYmVzdCBkZWFsIHdpdGggdGhh
dCAtCj4gY3VycmVudGx5IGV4cG9zaW5nIHRoZW0gYXMgTG9SYSBkZXZpY2VzIGZvciBtYXhpbWFs
IGZsZXhpYmlsaXR5LikKPiAKClNvIHRoYXQgbWVhbnMgeW91IGlnbm9yZSBTb2Z0TUFDIGJlY2F1
c2UgSGFyZE1BQyBpcyBlYXNpZXI/IFdlIGFjdHVhbGx5CmdvIHRoZSBvcHBvc2l0ZSB3YXkgdG8g
c2F5IFNvZnRNQUMgaW50cm9kdWNlIHRoZSBtb3N0IGluZnJhc3RydWN0dXJlIGFuZAp0aGVuIHNh
eSB0aGF0IHdlIHdpbGwgYmluZCBIYXJkTUFDIHRvIGl0LgoKT2YgY291cnNlIGJpbmRpbmcgYSBz
b2NrZXQgaW50ZXJmYWNlIHRvIGEgZGF0YXBhdGggaXMgZWFzeS4KCi0gQWxleAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
