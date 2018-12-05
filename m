Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:17:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3B020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rBXIojCr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQQ4C/Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3B020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aI/bAUDWy4WDdhmm/BOMm9Rg5q5hN0XDlbxqdNFXYrM=; b=rBXIojCrS/s7Nk
	SXN1sS+rRRD5f2ZHpPwT5y94IbeKysgj+1njlwxodW907YZFLmbjoVFBGM6Era/r1r2eMIfD0XThf
	LUvUP0d7TT7TVk2ZuOqtcxK22V+Aoanpk2rFD6JGdghcq5cJRdFpfbnmom2LfXX1zZkrXZohMV01p
	cVC+fzh/gC65EoWA15aDPIsH+us9M1RZmeAaeLaRz2RVtzZ1taKC8JuQvXLbhsdNW+WHTmNb8IwLt
	dnPoPRYvHHUspgHa6NNgEeDJRUMQFOYQgETACBHgyj/q1Jh9c+cMXxBXmP2fySqK0S5gFpb3hGiID
	8e604AN7bi1IYc6LQa7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUOd5-0000Ys-HN; Wed, 05 Dec 2018 04:17:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUOd2-0000YK-8f
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 04:17:42 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7119214C1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 04:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543983448;
 bh=s63fYt1pdr0YsjaJdopdT8IzNYSHvV4HqMOXUmJDoF8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YQQ4C/Vjun4OffZkzuMf7dAjf9zlBlvhs5miz+YQEC9gP6ny/uxsbsEMfAnr5UhMv
 Wc1wHv2IdGUA/kznWJ55tF5UGNYIPBSZPebG1APy8U8068z3xSLZPa9JiW1/+z1AdJ
 khKhP42sqJf76qwEEbe+boeCVFZ1Q1P3V+K/shuc=
Received: by mail-qt1-f173.google.com with SMTP id y20so20822259qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 20:17:28 -0800 (PST)
X-Gm-Message-State: AA+aEWa2NWCJoBD0kuZd2sCADGfAThwHw/TqOWG0Ul72NzEfKdxb/XtY
 g72AqTK6AOd5HvJI6wE7BWJ0V5OtbrE9xS15yA==
X-Google-Smtp-Source: AFSGD/XT/miOPEjAMhZ3LfOUvBfz/b7vigJLCWACSc5sP3pSak5s6V7ajvqXdgzGS7zXthp2E9MaON5cpinfEyF99Ys=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr21225232qta.38.1543983447789; 
 Tue, 04 Dec 2018 20:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
In-Reply-To: <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 22:17:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
Message-ID: <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_201740_624326_F9AF28CD 
X-CRM114-Status: GOOD (  27.04  )
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
 Thierry Reding <thierry.reding@gmail.com>,
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

T24gVHVlLCBEZWMgNCwgMjAxOCBhdCA3OjIyIFBNIEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJA
c3VzZS5kZT4gd3JvdGU6Cj4KPiBSb2IsCj4KPiBBbSAwNC4xMi4xOCB1bSAxOTozNiBzY2hyaWVi
IFJvYiBIZXJyaW5nOgo+ID4gSSd2ZSBwdXQgdG9nZXRoZXIgYSBzY3JpcHQgdG8gbW92ZSB0aGUg
ZHRzIGZpbGVzIGFuZCB1cGRhdGUgdGhlCj4gPiBtYWtlZmlsZXMuIEl0IGRvZXNuJ3QgaGFuZGxl
IGZpbGVzIG5vdCBmb2xsb3dpbmcgYSBjb21tb24gcHJlZml4IHdoaWNoCj4gPiBpc24ndCBtYW55
IGFuZCBzb21lIGluY2x1ZGVzIHdpdGhpbiB0aGUgZHRzIGZpbGVzIHdpbGwgbmVlZCBzb21lIGZp
eHVwcwo+ID4gYnkgaGFuZC4KPiA+Cj4gPiBNQUlOVEFJTkVSUyB3aWxsIGFsc28gbmVlZCB1cGRh
dGluZy4KPiA+Cj4gPiBBIGZldyBxdWVzdGlvbnM6Cj4gPgo+ID4gRG8gd2Ugd2FudCB0byBtb3Zl
IGFic29sdXRlbHkgZXZlcnl0aGluZyB0byBzdWJkaXJzPwo+Cj4gVGhpcyByZWZhY3RvcmluZyBp
cyBhIHRlcnJpYmxlIGlkZWEhCgpIb3cgZG8geW91IHJlYWxseSBmZWVsPwoKPiBXaGlsZSBpdCB3
b3VsZCd2ZSBiZWVuIG5pY2UgdG8gaGF2ZSBtb3JlIHN0cnVjdHVyZSBmcm9tIHRoZSBzdGFydCwK
PiBib290bG9hZGVycyBsaWtlIFUtQm9vdCBleHBlY3QgYSBmbGF0IHN0cnVjdHVyZSBmb3IgYXJt
IC5kdGIgZmlsZXMgbm93Lgo+IElmIHlvdSBzdGFydCBpbnN0YWxsaW5nIHRoZW0gaW50byBzdWJk
aXJzIGluc3RlYWQsIHRoZXkgd29uJ3QgZmluZCB0aGUKPiBmaWxlcyBhbnltb3JlIHVuZGVyIHRo
ZSBoYXJkY29kZWQgbmFtZS4KPgo+IERvaW5nIHRoaXMgb25seSBmb3IgbmV3IHBsYXRmb3JtcyB3
b3VsZCBiZSBtdWNoIGxlc3MgaW52YXNpdmUgYW5kIGFsbG93Cj4gdG8gcHJlcGFyZSBib290bG9h
ZGVycyBhY2NvcmRpbmdseS4KClRoYXQgd2FzIG15IHN1Z2dlc3Rpb24gd2hlcmUgdGhpcyBzdGFy
dGVkIGZvciB0aGUgbmV3IFJEQSBwbGF0Zm9ybS4KT2xvZiBwcmVmZXJyZWQgdG8gbW92ZSBldmVy
eXRoaW5nIGFuZCB0aGF0J3MgbXkgZGVzaXJlIHRvby4KCj4gQWx0ZXJuYXRpdmVseSwgd2hpdGUt
bGlzdCB3aGljaCBvbmVzCj4gYXJlIHNhZmUgdG8gbW92ZSBhcm91bmQuCgpJJ2QgcHJlZmVyIHRv
IGtub3cgd2hpY2ggb25lcyB0aGUgZGlzdHJvcyBkb24ndCB3YW50IG1vdmVkLiBUaGF0CnNob3Vs
ZCBiZSBlYXNpZXIgdG8gZmlndXJlIG91dC4gV2UgYWxzbyBuZWVkIHRoYXQgYW55d2F5cyBpbiBj
b250ZXh0Cm9mIHdoYXQgcGxhdGZvcm1zIHdlIGNhcmUgYWJvdXQgY29tcGF0aWJpbGl0eS4KCkFu
b3RoZXIgb3B0aW9uIGlzIGR0YnNfaW5zdGFsbCB0YXJnZXQgY291bGQgZmxhdHRlbiB0aGUgaW5z
dGFsbGVkCmR0YnMuIFRoYXQgaXMgdGhlIG9ubHkgcGFydCB0aGUgZGlzdHJvcyBzaG91bGQgZGVw
ZW5kIG9uLgoKPiBCdXQgZG9uJ3QganVzdCBzY3JpcHQgYSByZWZhY3RvcmluZyBiZWNhdXNlIGl0
Cj4gbG9va3MgbmljZXIgaW4gdGhlIHNvdXJjZSB0cmVlLCB3aXRob3V0IHRlc3Rpbmcgd2hhdCBz
aWRlIGVmZmVjdHMgdGhpcwo+IGNhbiBoYXZlIGZvciBib2FyZC9kaXN0cm8gdXNlcnMgb2YgdGhl
IGNvbXBpbGVkIGZpbGVzIGluIHByYWN0aWNlLgo+IFdlIGFscmVhZHkgaGFkIHRoYXQgZGlzY3Vz
c2lvbiBmb3IgYXJtNjQgYmVjYXVzZSBEZWJpYW4gY2hvc2UgdG8gaWdub3JlCj4gdGhlIGtlcm5l
bC1pbnN0YWxsZWQgc3ViZGlyZWN0b3JpZXMgYW5kIGluc3RhbGxlZCAuZHRiIGZpbGVzIGludG8g
YSBmbGF0Cj4gZGlyZWN0b3J5LCB3aGljaCBjb2xsaWRlZCB3aXRoIG9wZW5TVVNFIHN0aWNraW5n
IHRvIHRoZSBrZXJuZWwgY2hvaWNlLgoKU28gZXZlcnlvbmUgYWxyZWFkeSBkZWFscyB3aXRoIHN1
YmRpcnMgb3Igbm90IHdpdGggYXJtIGFuZCBhcm02NAphbHJlYWR5LCBzZWVtcyBsaWtlIHRoZXkg
Y2FuIGRlYWwgd2l0aCB0aGlzLiBJIHdpbGwgcmFpc2UgdGhlIHRvcGljIG9uCnRoZSBjcm9zcy1k
aXN0cm8gbGlzdCB0aG91Z2guCgo+IFRoaXMgdG9waWMgYmVjb21lcyBldmVuIG1vcmUgaW1wb3J0
YW50IHdpdGggRUJCUjogVGhlcmUgaXMgbmVpdGhlciBhCj4gbWVjaGFuaXNtIGluIHBsYWNlIHRv
IHN5bmMgLmR0cyBmaWxlcyBpbnRvIFUtQm9vdCBvciBFREsyIHNvdXJjZSB0cmVlcywKPiBub3Ig
YXJlIGNhcHN1bGUgdXBkYXRlcyBpbXBsZW1lbnRlZCBpbiBVLUJvb3QgZm9yIGVhc2lseSBkZXBs
b3lpbmcgc3VjaAo+IGJvb3Rsb2FkZXJzIHdpdGggbmV3IC5kdHMgc291cmNlcyBvciBwYXRocyB5
ZXQuCgpFQkJSIGFjdHVhbGx5IHNheXMgZmlybXdhcmUgKGluY2x1ZGluZyBkdGJzKSBnb2VzIGlu
IGRpcmVjdG9yaWVzIG5hbWVkCmJ5IHZlbmRvci4KCj4gQW5kIEkgY2FuIGFzc3VyZSB5b3UKPiB0
aGF0IGp1c3QgZ2V0dGluZyB1c2VycyB0byBkZCB0aGUgcmlnaHQgYm9vdGxvYWRlciBjYW4gYmUg
ZGlmZmljdWx0Li4uCj4gU2luY2UgRFQgZm9yd2FyZCBhbmQgYmFja3dhcmQgY29tcGF0aWJpbGl0
eSBpcyBvZnRlbiBiZWluZyBuZWdsZWN0ZWQsCj4gZm9yIGV4YW1wbGUgd2l0aCBvcHRpb25hbCBw
cm9wZXJ0aWVzIG9yIHJlbmFtZWQgY29tcGF0aWJsZXMgdGhhdCBicmVhawo+IGJvb3Rpbmcgd2l0
aCBwcmV2aW91cyBkcml2ZXJzLCBuZXcga2VybmVsIHZlcnNpb25zIG9mdGVuIG5lZWQgdXBkYXRl
ZAo+IERldmljZSBUcmVlcyB0byBtYWtlIHVzZSBvZiBuZXcvZW5oYW5jZWQgZHJpdmVycy4gVGhl
cmVmb3JlIGl0IGlzCj4gdW5mb3J0dW5hdGVseSBvZnRlbiBlbm91Z2ggYSBuZWNlc3NpdHkgdG8g
bG9hZCBuZXdlciBrZXJuZWwtYmFzZWQgLmR0Ygo+IGZpbGVzIG1hdGNoaW5nIHRoZSBrZXJuZWwg
KGFzIG9wcG9zZWQgdG8gdGhlIGRyZWFtIG9mIGtlcm5lbC1pbmRlcGVuZGVudAo+IGhhcmR3YXJl
IGRlc2NyaXB0aW9ucykgd2hlbiB3b3JraW5nIHdpdGggdGhlIGxhdGVzdCAtcmMgb3IgLW5leHQg
a2VybmVscwo+IGF0IGxlYXN0LiBGb3IgZXhhbXBsZXMgb2YgRFRzIG5lZWRpbmcgdXBkYXRlcywg
bG9vayBubyBmdXJ0aGVyIHRoYW4KPiBMaW5hcm8ncyA5NmJvYXJkcyAtIGluIGNhc2Ugb2YgaGlr
ZXk5NjAvRURLMiBHUlVCIGlzIGFub3RoZXIgbGF5ZXIgd2hlcmUKPiAuZHRiIHBhdGhzIG1heSBi
ZSBoYXJkY29kZWQsIGRpdHRvIGZvciBhcm07IGFuZCBBcm1hZGEgd2FzIGFuIGV4YW1wbGUKPiB3
aGVyZSB0aGUgdXBzdHJlYW0gYmluZGluZ3MgZm9yIHRoZSBuZXR3b3JrIElQIGNoYW5nZWQgaW5j
b21wYXRpYmx5LgoKQ29tcGF0aWJpbGl0eSBpcyBhbiBpc3N1ZSwgeWVzLCBidXQgdGhhdCByZWFs
bHkgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzLgoKPiBEVCBvdmVybGF5cyBhcmUgYW5vdGhl
ciB0b3BpYyB0aGF0IGlzIG5vdCBtYWtpbmcgYW55IHByb2dyZXNzIHVwc3RyZWFtCj4gYWNjb3Jk
aW5nIHRvIHRoZSBFTENFIEJvRiwgc28gYmV5b25kIHRoZSBSYXNwYmVycnkgUGkgdGhlIG9ubHkg
a25vd24KPiB3b3JraW5nIHdheSB0byBhcHBseSB0aGVtIGlzIHRvIHdyaXRlIGEgVS1Cb290IGJv
b3Quc2NyIHNjcmlwdCwgd2hpY2gKPiBjYW4gZWl0aGVyIHJldXNlICRmZHRjb250cm9sYWRkciBE
VCBvciB1c2UgdGhlIGZpbGVuYW1lICRmZHRmaWxlIG9yCj4gaGFyZGNvZGUgb25lLCB0aGUgbGF0
dGVyIHR3byBvZiB3aGljaCB3b3VsZCBicmVhayB3aXRoIHlvdXIgcmVuYW1pbmcuCgpEVCBvdmVy
bGF5cyBhbHNvIGhhdmUgbm90aGluZyB0byBkbyB3aXRoIHRoaXMgYXMgdGhlcmUgYXJlbid0IGFu
eSBpbgp0aGUga2VybmVsLiBJJ20gbm90IGluY2xpbmVkIHRvIHRha2UgYW55IGVpdGhlciB3aXRo
IGEgZmxhdCB0cmVlLgpXZSdyZSBhbHJlYWR5IGF0IDE4MDArIGZpbGVzLgoKUm9iCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
