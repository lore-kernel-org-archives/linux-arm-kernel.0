Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B54C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E7D2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZ4776b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E7D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y50MwyDhOtkxda9orNusrwQXaSZC8/UDxxvYOo9HxaA=; b=DZ4776b18dknv3
	Ka9shCCFC/SZYxPQMtzfilrcjUZe6KEF8gYWNyO269X3h4y3LGrZ8P+b/xvj3VffGBv5YUppvHTyo
	xdPnE/8MLIHIlSd/u+APpli7W1w/OYjqZAX3hg+oDHUItlxJmJSZtgpnGmz9tjURAx2xp5wgLKMFi
	QqRnPFHfsqc2pVlk1ncUttsSb66mSwftk9IeJfAg//evQuVhcktQkJEdU3cMVg6j99L30DWVa0lgz
	56As5b72DjRAvY2i/mT9p0yOGJ9pX7jkGChGYmTvaoQZkCBBkFNz1s9OayW9R/P+oU1My3ppPHlRJ
	DLIP7mzat9oAey7NWXCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygm4-00080B-71; Tue, 26 Feb 2019 17:44:12 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygm1-0007zS-5g
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:44:10 +0000
Received: by mail-oi1-f195.google.com with SMTP id z14so11087652oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 09:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z1OS+Lzpj3DeHAi3lqfkSXwSW4LD8wDRWAjP9wzKHak=;
 b=BsYdLS3+qTrmc+meXUkMpyC5gZywXJOlifUD7md/ykFMgcaUegFsbLM53DVFzH3rlv
 XydySSO62IOjGjxYtzFZhyIPr+LxUTE3Lofka3dovpzkxKZzPReQCCNjujXYxrvmO/7Q
 ylbkLJ7XCXVgk7w41hf9IZb1eGshAW9XTXARpcaoVyN2X5vBCZAJhMj2/TS6p3btdFPa
 bFBwth58eTB3IZ0ak9TJGIMnF4mxPDFdtPzhAnnU4dHnTaG/fuVxTZO/NnzH3Tjqzh1V
 rE+ZVe1LZ+7w8M0L2Rzbg36sClYpf4Yipnd+2iQwZzMoeQdn7WwwAvs3xDWZxiF47QfZ
 AKTA==
X-Gm-Message-State: AHQUAubDATjDCdSIcIkubd01P/okb1lUdgTABb8FD8ZMtEHxlcygqD8n
 t1Fn16AT7MzToieq39TSg9oKjNvt
X-Google-Smtp-Source: AHgI3IarP/IlbgQrKbGjq3q0YFcT+tIGwUpbqGL0UBSFGtaUeIE1D3+MoUof/dGEEoLFCa/DZxB9ww==
X-Received: by 2002:aca:f5d7:: with SMTP id t206mr2942355oih.141.1551203047317; 
 Tue, 26 Feb 2019 09:44:07 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id h25sm3679827otl.29.2019.02.26.09.44.06
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id t7so11800352otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
X-Received: by 2002:a9d:4708:: with SMTP id a8mr15251874otf.51.1551203046342; 
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221103731.28978-1-horia.geanta@nxp.com>
 <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 26 Feb 2019 11:43:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
To: "Y.b. Lu" <yangbo.lu@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_094409_215572_0FA532ED 
X-CRM114-Status: GOOD (  17.30  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Horia Geanta <horia.geanta@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMjIsIDIwMTkgYXQgMjowOSBBTSBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNv
bT4gd3JvdGU6Cj4KPgo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gRnJvbTog
SG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+Cj4gPiBTZW50OiBUaHVyc2RheSwg
RmVicnVhcnkgMjEsIDIwMTkgNjozOCBQTQo+ID4gVG86IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPgo+ID4gQ2M6IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPjsgbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmc7Cj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiA+IFN1YmplY3Q6IFtQQVRDSF0gc29jOiBm
c2w6IGd1dHM6IG1ha2UgZnNsX2d1dHNfZ2V0X3N2cigpIHN0YXRpYwo+ID4KPiA+IFRoZSBleHBv
cnQgb2YgZnNsX2d1dHNfZ2V0X3N2cigpIGlzIGEgbGVmdC1vdmVyLCBpdCdzIGN1cnJlbnRseSB1
c2VkIG9ubHkgaW50ZXJuYWxseQo+ID4gYW5kIHVzZXJzIG5lZWRpbmcgU29DIGluZm9ybWF0aW9u
IHNob3VsZCB1c2UgdGhlIGdlbmVyaWMgc29jX2RldmljZQo+ID4gaW5mcmFzdHJ1Y3R1cmUuCj4g
Pgo+Cj4gW1kuYi4gTHVdIEFja2VkLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPgoK
QXBwbGllZCBmb3IgbmV4dC4gIFRoYW5rcy4KCj4KPiA+IFNpZ25lZC1vZmYtYnk6IEhvcmlhIEdl
YW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9zb2MvZnNs
L2d1dHMuYyAgIHwgMyArLS0KPiA+ICBpbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmggfCAyIC0tCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL2d1dHMuYyBiL2RyaXZlcnMvc29jL2ZzbC9n
dXRzLmMgaW5kZXgKPiA+IDRmOTY1NTA4N2JkNy4uNjNmNmRmODZmOWU1IDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9zb2MvZnNsL2d1dHMuYwo+ID4gKysrIGIvZHJpdmVycy9zb2MvZnNsL2d1dHMu
Ywo+ID4gQEAgLTExNSw3ICsxMTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9zb2NfZGll
X2F0dHIKPiA+ICpmc2xfc29jX2RpZV9tYXRjaCgKPiA+ICAgICAgIHJldHVybiBOVUxMOwo+ID4g
IH0KPiA+Cj4gPiAtdTMyIGZzbF9ndXRzX2dldF9zdnIodm9pZCkKPiA+ICtzdGF0aWMgdTMyIGZz
bF9ndXRzX2dldF9zdnIodm9pZCkKPiA+ICB7Cj4gPiAgICAgICB1MzIgc3ZyID0gMDsKPiA+Cj4g
PiBAQCAtMTI5LDcgKzEyOSw2IEBAIHUzMiBmc2xfZ3V0c19nZXRfc3ZyKHZvaWQpCj4gPgo+ID4g
ICAgICAgcmV0dXJuIHN2cjsKPiA+ICB9Cj4gPiAtRVhQT1JUX1NZTUJPTChmc2xfZ3V0c19nZXRf
c3ZyKTsKPiA+Cj4gPiAgc3RhdGljIGludCBmc2xfZ3V0c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KSAgeyBkaWZmIC0tZ2l0Cj4gPiBhL2luY2x1ZGUvbGludXgvZnNsL2d1dHMu
aCBiL2luY2x1ZGUvbGludXgvZnNsL2d1dHMuaCBpbmRleAo+ID4gOTQxYjExODExZjg1Li4xZmMw
ZWRkNzFjNTIgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmgKPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvZnNsL2d1dHMuaAo+ID4gQEAgLTEzNSw4ICsxMzUsNiBAQCBzdHJ1
Y3QgY2Nzcl9ndXRzIHsKPiA+ICAgICAgIHUzMiAgICAgc3JkczJjcjE7ICAgICAgIC8qIDB4LjBm
NDQgLSBTZXJEZXMyIENvbnRyb2wgUmVnaXN0ZXIgMCAqLwo+ID4gIH0gX19hdHRyaWJ1dGVfXyAo
KHBhY2tlZCkpOwo+ID4KPiA+IC11MzIgZnNsX2d1dHNfZ2V0X3N2cih2b2lkKTsKPiA+IC0KPiA+
ICAvKiBBbHRlcm5hdGUgZnVuY3Rpb24gc2lnbmFsIG11bHRpcGxleCBjb250cm9sICovICAjZGVm
aW5lCj4gPiBNUEM4NXh4X1BNVVhDUl9RRSh4KSAoMHg4MDAwID4+ICh4KSkKPiA+Cj4gPiAtLQo+
ID4gMi4xNi4yCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
