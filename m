Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45AC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:58:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFAD20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGch4W7m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q1qpBOc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFAD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zvj7NtRIXDAkvaw6kG3568RRtXY8K9Zz8k37cGOYph0=; b=OGch4W7m42b8Bd
	5PpQK/Hwt/EC/vuNH3vbq4QyEkAMWK5lOJR9PpebJEg+R51SavBZrltc80ioLvxAq147rpC0epElt
	U2zaE4W/Ne9+8WVZB9tkUX4hafWg+3eGhQZDoQgl7UyZrun7HBzxPUQ6x7vJupv2RFtvVrfvPeY3l
	V7lwdhpDMJViLLw44XZ9cn2MGyBArQ6VkYGFevbQO9WlnjvzvAx+dYCo4zzUgU41gMzlSvKJs18+o
	SfTubT4HgBcE2Q1nqSg5BBokzgXHofYp8gc/HUO3QEjx9mmxQp6Yh4n70O0P+EkDb3hyHkCC11F1r
	oCf7hxVCzATcC5w1joIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsmoq-0000nA-74; Sun, 10 Feb 2019 10:58:40 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsmon-0000mS-01
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 10:58:38 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so11434190wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:cc:subject
 :references:in-reply-to:content-transfer-encoding;
 bh=qnM4uoHXmMhXZ2WSd2m5FOB3LMp6OfNKdQlrbW/TTYg=;
 b=q1qpBOc9iq42xCKxoPhadGJE4WlZWXtY37GRCPtarFZEgMbYqwXMTuY9giyQF7JeXi
 7Vu1dx7df40Dv5d8/ivsYI7B6deq2hZ5AY2NBv2txEL2yAWukJwyPzf5JL9R1LObS+s5
 wk/BIcy/xc4+1RRfhfNvvhaACBnxh4ALlc+Nrq9SY+pSF1cg94OcCQ15LL9WvY3UlFgA
 R+obMAEHLPfM8d9fIQtXhNza1TdWvMvJImoTaG9IrGnF1QFR1Su8Ryj/mm7wyG8JTcKB
 TZkFaPdkGu05NbjSN08f8yLOId8Qh09JvZWz8l8brR//cKcPQk32Pv7XgwqIj6LqzuBQ
 Uu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :cc:subject:references:in-reply-to:content-transfer-encoding;
 bh=qnM4uoHXmMhXZ2WSd2m5FOB3LMp6OfNKdQlrbW/TTYg=;
 b=l7Vvu2uaH8qLHz2BMTwkVEGk8UIGXUnw10lSzrh8D9WJQggbXDQnh4TnXddu2eA+Vb
 s5p0M+Tthp2diAvKbuQnLxd5f0pQyH8jwTLx7JkdKqkGip6221wvjpIGdRvPuaDreXWM
 yfSRly+g9KHjKzua8gf6+ovizWctnVUw9pZRrRe2YiLKC59bdc8WS2w8UuLkGTvpQ78Z
 ZG8XHlrZUn6b1vyzwwpx9E2SzEHPNPYSjPYzJv4hqMRGZn2JRwypukcE18QojRCQsnjD
 /SmOK/szye8H1Xu+d++pEIxtrEvjlv7CmG808jl1Fl/M+vb1OvKKQu13VzP5uO4Xi6b5
 ++dA==
X-Gm-Message-State: AHQUAubivcavqzQJMZCMBRV5bEaNxyIcAnlcSqxxD1Fv3lOJvgP+EiIQ
 2dydbakyUtiG3/TB7WkrsOZI8g==
X-Google-Smtp-Source: AHgI3IY8naheJSREpzLbfwCC8Q7sn6SOObGst4S5tOs7vDBl5g/2npVP9CruZZ3USQS6Hk5orRztZg==
X-Received: by 2002:a5d:5101:: with SMTP id s1mr23514233wrt.89.1549796315457; 
 Sun, 10 Feb 2019 02:58:35 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local (176-150-251-154.abo.bbox.fr.
 [176.150.251.154])
 by smtp.gmail.com with ESMTPSA id a144sm13286266wmd.30.2019.02.10.02.58.34
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 10 Feb 2019 02:58:34 -0800 (PST)
Message-ID: <5C6003D9.9090304@baylibre.com>
Date: Sun, 10 Feb 2019 11:58:33 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/2] clk: meson8b: fix typo "ABP" -> "APB"
References: <20190119205121.9621-1-martin.blumenstingl@googlemail.com>
 <095d0dca-f8d5-df7c-dbd0-7c2c50fcab82@baylibre.com>
 <CAFBinCCrYrxnb6Dk-0kGwbk0ttwe+je+wKZqxe6GUASnNdAckQ@mail.gmail.com>
In-Reply-To: <CAFBinCCrYrxnb6Dk-0kGwbk0ttwe+je+wKZqxe6GUASnNdAckQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_025837_042029_3A67D072 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, sboyd@kernel.org,
 mturquette@baylibre.com, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWFydGluLAoKTGUgMDkvMDIvMjAxOSAwMToyNCwgTWFydGluIEJsdW1lbnN0aW5nbCBhIMOp
Y3JpdCA6Cj4gSGkgTmVpbCwKPiAKPiBPbiBNb24sIEphbiAyMSwgMjAxOSBhdCAxMTo0MCBBTSBO
ZWlsIEFybXN0cm9uZyA8bmFybXN0cm9uZ0BiYXlsaWJyZS5jb20+IHdyb3RlOgo+Pgo+PiBPbiAx
OS8wMS8yMDE5IDIxOjUxLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdyb3RlOgo+Pj4gSXQgdHVybnMg
b3V0IHRoYXQgSSdtIG5vdCBnb29kIGF0IHNwZWxsaW5nICJBUEIiLiBVbmZvcnR1bmF0ZWx5IGFu
IEFCUAo+Pj4gKGluc3RlYWQgb2YgQVBCKSB0eXBvIHNudWcgaW50byB0d28gY2xvY2tzIGluIHY1
LjAuCj4+Pgo+Pj4gQ3VycmVudGx5IHRoZXJlIGFyZSBubyB1c2VycyBvZiB0aGF0IGNsb2NrIHll
dCwgc28gZml4IGl0IG5vdwo+Pj4gYmVmb3JlIGl0J3MgdG9vIGxhdGUgKG1lYW5pbmcgYmVmb3Jl
IGl0J3MgdXNlZCBieSA8c29tZXRoaW5nPikuCj4+Pgo+Pj4gSSBkZWNpZGVkIHRvIGdvIHRoZSAi
bm9ybWFsIiByb3V0ZSB3aGVyZSB3ZSBjYW4gaGF2ZSBzZXBhcmF0ZQo+Pj4gYnJhbmNoZXMgZm9y
IHRoZSBkdC1iaW5kaW5ncyBhbmQgdGhlIGRyaXZlcnMgaW4gdGhlIGNsay1tZXNvbgo+Pj4gcmVw
by4gVGhpcyBtZWFuczoKPj4+IC0gbmV3ICh0eXBvLWZyZWUpIGNsb2NrICNkZWZpbmUKPj4+IC0g
Y2hhbmdlIHRoZSBjbG9jayBjb250cm9sbGVyIHRvIHVzZSB0aGUgbmV3ICNkZWZpbmUKPj4+IC0g
KG5leHQgZGV2ZWxvcG1lbnQgY3ljbGUpIGRyb3AgdGhlIG9sZCAjZGVmaW5lCj4+Pgo+Pj4KPj4+
IENoYW5nZXMgc2luY2UgdjEgYXQgWzBdOgo+Pj4gLSBzcGxpdCBpbnRvIGEgZHQtYmluZGluZ3Mg
YW5kIGNsb2NrIGNvbnRyb2xsZXIgZHJpdmVyIHBhdGNoCj4+Pgo+Pj4KPj4+IFswXSBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzEwNzQyMDAxLwo+Pj4KPj4+Cj4+PiBNYXJ0aW4g
Qmx1bWVuc3RpbmdsICgyKToKPj4+ICAgZHQtYmluZGluZ3M6IGNsb2NrOiBtZXNvbjhiOiBhZGQg
QVBCIGNsb2NrIGRlZmluaXRpb24KPj4+ICAgY2xrOiBtZXNvbjogbWVzb244YjogZml4IHRoZSBu
YW1pbmcgb2YgdGhlIEFQQiBjbG9ja3MKPj4+Cj4+PiAgZHJpdmVycy9jbGsvbWVzb24vbWVzb244
Yi5jICAgICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+Pj4gIGRyaXZl
cnMvY2xrL21lc29uL21lc29uOGIuaCAgICAgICAgICAgICAgfCAgMiArLQo+Pj4gIGluY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svbWVzb244Yi1jbGtjLmggfCAgMSArCj4+PiAgMyBmaWxlcyBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPj4+Cj4+Cj4+IE9uY2Ugcm9i
IGFja3MgaXQsIEknbGwgYXBwbHkgYm90aCB0byBuZXh0L2RyaXZlcnMgc2luY2UgaXQncyBub3Qg
dXNlZCAoeWV0ID8pCj4+IGFuZCBub3QgYSBjcml0aWNhbCBmaXguCj4gSSBoYXZlIGp1c3Qgbm90
aWNlZCB0aGF0IEkgZm9yZ290IHRvIENDIFJvYiBhbmQgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcuCj4gZG8geW91IHdhbnQgbWUgdG8gcmUtc2VuZCB0aGlzIHNlcmllcz8KClllcyBwbGVhc2Ug
cmUtc2VuZCAhCgpOZWlsCgo+IAo+IGFzIHlvdSBhbHJlYWR5IG5vdGljZWQgdGhpcyBpcyBub3Qg
Y3JpdGljYWwsIHNvIHRha2luZyB0aGlzIHRocm91Z2gKPiBuZXh0L2RyaXZlcnMgaXMgZmluZSBm
b3IgbWUuCj4gCj4gCj4gUmVnYXJkcwo+IE1hcnRpbgo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
