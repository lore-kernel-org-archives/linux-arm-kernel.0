Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:50:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F79521479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDCjp3Xh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vXON49a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cA023BBi35NmJM/22wKJ6x6fN0lDLIt8qDMVXmKCavM=; b=dDCjp3XhaFK3Wr
	Aqjo1AFdRsjqMfBLUlOfjdzB7qd2jP1KHdVyWBbKbipz/h3QLiDmFrrt7D/gF/4sDCJ5akIjTxk4/
	S114ZojmS2YiAJYObaawYYdhRPH7OmL19CL3sswCAaHxfBvvC6funlJEOe8Xm3UrkItoW8WGJXbQq
	tIC4fqQ372kqI4C2u5lS9U7IbCNOaaMhm+VrWy2mMbhXJZzjISYt5J31CSa285iDZd2sIpJRM8siD
	86FCn70mz6QUd+NIrdjBGXIG9WE8bA8Tpr/vFCpNcL9BioeP8gR3qyhvfz09810OwFEQyJbOW1gki
	bhglSImSd+IRwpnM7JSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV0b3-0007jL-RY; Thu, 06 Dec 2018 20:50:09 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV0b1-0006Pk-0k
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:50:08 +0000
Received: by mail-it1-x142.google.com with SMTP id x19so3638516itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GJlzeACOyNk0ZjUq57/gCxHaNGTkVu+E0zkuExB1J68=;
 b=vXON49a584G74EDzHuK6mSHfZqQO1+yR9bxwntV8Aloxijuley0lpaaoGRdzSTlRQd
 J7Esds/bS3zKFLCkwgt1H74R1t19mlxZ1WPGz/vBcD8wlBDn87Rpjqe5zappXitG56Xj
 lMzyHxkGxepyXV1rPzplJIuwkBgSt69i6nSVbZ6Qr+K3yVZNJUnbepm5uwb9tkzR7PDF
 pNomzlgEo9Lv8yfy3IhupYWFZXeWAw0B8fcIJSNDrsE87puHF661PnTaREsJtk5ZduGE
 JKVul6gD/2+QB671tuc0nZ8Iq7fWj7B+z02PMdTKeW0zy6w+MFjr1Uxb/ZyqqgqgE56G
 dX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GJlzeACOyNk0ZjUq57/gCxHaNGTkVu+E0zkuExB1J68=;
 b=sLomzv66gD0Q/oobNOWEVfZXf0DMY/BNDis/I7p0O03YOOscMBbGFoG3zt9bCxOG2f
 ifGmJ1hB4cbNIgrMs9HqCWlT2yy5uQSk6RKkcDhmmrU3QuPC9PBKQXu7aKf1aFT8Hwda
 LGhCHitLJH6QHJ16tIrOeL6/UfWOYWRdu94fWdDoL21SHlPlaJK2zPudn6lWh6QTo9hM
 BU+HNi8YdO5/5rEssRv/Ehg6lGffieBMBPlqeHaI41vzgIrjWJjLiwWtAfZ733QxR8Wg
 cqYEV4tK7D6iHuJEE1PcvEKPFDBvcTpl8RMDEQQEbU8VMNJlzhYnqo1Rl0fSmlAoKsEY
 DkMA==
X-Gm-Message-State: AA+aEWbyy4oc29yWjrvAJIRvIChWNc74f0ay77EygMTdYfW581oqwFUg
 iIjXpKlZfxYJSr//+c7TfcbcH7GGjd2tJ8A80/apGQ==
X-Google-Smtp-Source: AFSGD/W12l6MSja3XlBy2odOPPnAWV2eo9Dt+FnBWKdxulIUkGvRj5s76wjWwMc28yCJ/DIsyZjgYu/vYA9+p2hpy/4=
X-Received: by 2002:a24:2104:: with SMTP id e4mr19376370ita.59.1544129394630; 
 Thu, 06 Dec 2018 12:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
 <20181206200652.GB3084@sirena.org.uk>
In-Reply-To: <20181206200652.GB3084@sirena.org.uk>
From: Olof Johansson <olof@lixom.net>
Date: Thu, 6 Dec 2018 12:49:42 -0800
Message-ID: <CAOesGMgTVHakL+m004Wu2gtHETAXuO8kV9jByaX4XQq_W3QAxA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_125007_132857_CE6B6993 
X-CRM114-Status: GOOD (  17.79  )
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
 Tony Lindgren <tony@atomide.com>, LinusW <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Alexander Graf <agraf@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 DTML <devicetree@vger.kernel.org>,
 Boot Architecture <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Tom Rini <trini@konsulko.com>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCAxMjowNyBQTSBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCBEZWMgMDYsIDIwMTggYXQgMDE6MDY6NDNQTSAtMDYw
MCwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDc6MzIgQU0g
QW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPiB3cm90ZToKPgo+ID4gPiBJJ2QgYmUg
b2theSB3aXRoIGRpc3Rpbmd1aXNoaW5nIHNvdXJjZSB2cy4gaW5zdGFsbCBsb2NhdGlvbi4gRHVl
IHRvIHRoZQo+ID4gPiBpc3N1ZSBJIG1lbnRpb24gYmVsb3cgKGFuZCBtb3JlKSB3ZSBjYW4ndCB1
c2UgaW5zdGFsbF9kdGJzIGZvciBvcGVuU1VTRQo+ID4gPiBhbmQgaGFkIHRvIHJlaW1wbGVtZW50
IGl0LCB3aGljaCB3ZSdkIG5lZWQgdG8gKGFuZCBjYW4pIGFkanVzdC4KPgo+ID4gV2hhdCB3b3Vs
ZCBiZSBuZWVkZWQgZm9yIGR0YnNfaW5zdGFsbCB0byB3b3JrPyBhcm02NCBuZWVkcyB0byBzdXBw
b3J0Cj4gPiBhIGZsYXQgaW5zdGFsbD8gSWYgaXQgZG9lc24ndCB3b3JrIGZvciBEZWJpYW4gb3Ig
b3BlblNVU0UsIEknbSBub3QKPiA+IHN1cmUgd2h5IHdlIGhhdmUgaXQuIFNvIEknZCBsaWtlIHRv
IG1ha2UgaXQgd29yay4KPgo+IENvcnJlY3QgbWUgaWYgSSdtIHdyb25nIGJ1dCBhcyBmYXIgYXMg
dGhlIGZsYXQgdnMgZGlyZWN0b3J5IHRoaW5nIGdvZXMKPiBpc24ndCB0aGUgaXNzdWUgdGhhdCB0
aGlzIHdpbmRzIHVwIGJlaW5nIGEgcmVuYW1lIGZvciBhbiBleGlzdGluZyAzMiBiaXQKPiBzeXN0
ZW0/ICBJZiB5b3UganVzdCBpbnN0YWxsIHRoZSBkdGJzIGluIHRoZSBkZWZhdWx0IGxvY2F0aW9u
IHRoZW4gYQo+IGJvb3Rsb2FkZXIgb3Igd2hhdGV2ZXIgdGhhdCBpcyBoYXJkIGNvZGVkIHRvIGxv
b2sgZm9yIGZvby1iYXIuZHRiIHdvbid0Cj4gc2VlIHRoZSBuZXcgZm9vL2Zvby1iYXIuZHRiIChv
ciB3aGF0ZXZlcikgYW5kIHdpbGwgY29udGludWUgdG8gdXNlIHRoZQo+IG9sZCBiaW5hcnkuICBJ
dCdzIG5vdCB0aGUgZmFjdCB0aGF0IHRoYXQgaXQncyBpbiBhIGRpcmVjdG9yeSwgaXQncyB0aGUK
PiBmYWN0IHRoYXQgdGhlIGJvb3Rsb2FkZXIgc2VlcyB0aGUgbmFtZSBpdCBuZWVkcyB0byBsb29r
IGZvciBjaGFuZ2UgKGlmCj4gaXQncyBsb29raW5nIG9uIGEgZmlsZXN5c3RlbSBhdCBhbGwpLiAg
VGhpcyBpc24ndCBhIHByb2JsZW0gZm9yIGFybTY0IGFzCj4gdGhlIGxvY2F0aW9uIGlzbid0IGNo
YW5naW5nLCBpdCdzIHVzZWQgZGlyZWN0b3JpZXMgZnJvbSBkYXkgb25lLgoKWWVhaCwgaW5zdGFs
bCBuZWVkcyB0byByZW1haW4gZmxhdCBldmVuIGlmIHRoZSBkdHMgZmlsZXMgbW92ZSBpbnRvCnN1
YmRpcmVjdG9yaWVzLiBJdCB3aWxsIGJlIHBhaW5mdWwgZm9yIGV2ZXJ5Ym9keSBpZiB0aGUgaW5z
dGFsbApsb2NhdGlvbiBtb3Zlcy4KCj4gVGhlIGlzc3VlcyB3aXRoIHRoZSBleGlzdGluZyBpbnN0
YWxsX2R0YnMgc291bmRlZCB1bnJlbGF0ZWQgdG8gdGhpcy4KCkFncmVlZC4KCgotT2xvZgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
