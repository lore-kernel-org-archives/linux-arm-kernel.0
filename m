Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FADCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:30:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EECE208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sqQUlnW7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhfwsS3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EECE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hChJLPwiozqlDdcb7TjrrQGOrFTPTyGLRWPEpxXlQss=; b=sqQUlnW7ItD2q+
	vRfTXoQ+LZAKmnJi/L7utrrlFRaIFZR/BWINBUnGF2tfQIugiNedbEn/61AR8ziJs3+xtQjrBPCpY
	DMVVrj6frqfiFSWyw2lA4uGGOaxOfm4iDNm1Z9gf8Z4yy46Ok14Xk58qekrJUghkrE9jbinaYCCbO
	qk6JRKt1pg1+25pmhAVsErjqet1p+YpTK3eFFf24x8odOHcssl1KRVSx2VhebAJAs9cdbm8FCjDYj
	YHRjvdw7qZZVFZ+HjeyZgLMV3fz5xdkyUGKm0A6I0lAzfOG/WHe1x102j1xoX7OBrroVGQuw9zMox
	lPHV4dDgjH3bEn94/BQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUufw-0000g8-90; Thu, 06 Dec 2018 14:30:48 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUufq-0000fR-Or
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:30:46 +0000
Received: by mail-lj1-x235.google.com with SMTP id x85-v6so616021ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N1TYAEaOY4onzGNwWbKmSn2lNhyvTSA8DYZ/t5KZb10=;
 b=JhfwsS3NFQ8zynIoEZSAD0sgPKQXu4iPgjHKg11jtPd6MNk2Cw3Rm0ZrVu6tjL2TLX
 u1YT+b4diHOXh6PvEA2zep0MHjJyxNGQUxgop8ZXnonhu50UQz1P9DAYwWHsvBh780gR
 SZX1PN7xeFYgOA0BVqwPb9DqKZQMd6pbtti4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N1TYAEaOY4onzGNwWbKmSn2lNhyvTSA8DYZ/t5KZb10=;
 b=Fw2BQyLZusNMxX6yvd8IGx+UV7/B6O1nxThr7bCFrsnGi19XyjpeA6jlHyvJNlBhaT
 YCCGzCAiXAiczaZy7Erxzky5PutRcDJz2LlHfJG3kMifTorgngiPQ8x5//T06Rl5lJiD
 VMCNieQGW0rAyBmT9yf5A0ABm53xQPlCCymQ9Qu7dSN6AwhNQLS4iipBgQ//G7Qh3NyY
 0O/qSfTcypi8FMEQNju389SHmZ+Phn+Kknh2yGTAlM72WlEIAXT+8ydo7MaCwDGYSdJO
 vWhA2F2tGhudMgk8OTXfgcOmoWX3SijaEjDl+TVbmHEyl0lebHr+bR6quIFr3mQcy64T
 r7AA==
X-Gm-Message-State: AA+aEWa7VbyUGe3G41FcNf7xNBQTXKHth4mvpKsYL3W3OGh8m0FA3zyZ
 00fSsXMCFrl89C/CaOXDagkX+h70sj7kwLXdNRVUXQ==
X-Google-Smtp-Source: AFSGD/UF65KPB7ECitEnEWYrCYRYH9y6gmt8lbEG68uYzOWW/Cmz5rAb+cvPQXZvwRVPTQ7TxzEE9JAe56D6TAIFRCY=
X-Received: by 2002:a2e:710a:: with SMTP id
 m10-v6mr18455969ljc.66.1544106627378; 
 Thu, 06 Dec 2018 06:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
 <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
 <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
 <20181206140531.GX8952@piout.net>
In-Reply-To: <20181206140531.GX8952@piout.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 15:30:14 +0100
Message-ID: <CACRpkdbzyZD23JapAxEKc24jSwmZws5LqWS8O2Y4-VA3smgYyQ@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063042_802034_E381E1B5 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, ext Tony Lindgren <tony@atomide.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCAzOjA1IFBNIEFsZXhhbmRyZSBCZWxsb25pCjxhbGV4YW5k
cmUuYmVsbG9uaUBib290bGluLmNvbT4gd3JvdGU6Cj4gT24gMDYvMTIvMjAxOCAwNzo1ODoyNC0w
NjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiA+IE9uIFRodSwgRGVjIDYsIDIwMTggYXQgNzozOSBB
TSBVd2UgS2xlaW5lLUvDtm5pZwo+ID4gPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4g
d3JvdGU6Cj4gPiA+Cj4gPiA+IEhlbGxvLAo+ID4gPgo+ID4gPiBPbiBXZWQsIERlYyAwNSwgMjAx
OCBhdCAwOTowMTo1OUFNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiA+ID4gPiBpLk1YMjMg
aXMgYSBTaWdtYXRlbCBjaGlwIFNUTVA/Pwo+ID4gPgo+ID4gPiBJIHRoaW5rIHRoZSBGcmVlc2Nh
bGUgaS5NWDIzIGRpZG4ndCBleGlzdCBhdCBTaWdtYXRlbCBiYWNrIHRoZW4uIEFGQUlLCj4gPiA+
IHRoaXMgaXMgYSBuZXcgZGVzaWduIHVzaW5nIElQIGZyb20gU2lnbWF0ZWwgYWZ0ZXIgdGhlIGFx
dWlzaXRpb24uCj4gPgo+ID4gSXQgaXMgbm90LiBJIHdhcyBpbiB0aGUgaS5NWCBncm91cCB3aGlj
aCBTaWdtYXRlbCB3YXMgbWVyZ2VkIGludG8gYXQKPiA+IHRoZSB0aW1lLiBQdXJlbHkgbWFya2V0
aW5nIHJlYnJhbmRpbmcuCj4gPgo+Cj4gV291bGRuJ3QgaXQgYmUgZWFzaWVyIHRvIG5hbWUgdGhl
IGRpcmVjdG9yeSB0byB0aGUgY29ycmVzcG9uZGluZyBtYWNoLSoKPiBlbnRyeT8KPgo+IFNvLCBp
bXgyMyBhbmQgaW14Mjggd291bGQgZ28gdG8gbXhzLywgb3RoZXIgaW14IGluIGlteC8uIEFuZCB0
aGlzIGFsc28KPiBzb2x2ZXMgdGhlIE1hcnZlbGwgbWVzcyB3aXRoIHRoZSBTeW5hcHRpY3MgU29j
cyBnb2luZyBpbiBiZXJsaW4vIGFuZCB0aGUKPiBvdGhlciBvbmVzIGluIG12ZWJ1Ly4KCkkgbGlr
ZSB0aGlzIGlkZWEuCgpXZSBkaXNjdXNzZWQgbWVyZ2luZyBhbGwgQVJNIHJlZmVyZW5jZSBkZXNp
Z24gbWFjaC0qIHRvIG9uZSBkaXIKaWYgSSBqdXN0IG5hbWUgdGhhdCBtYWNoLWFybSB0aGVuIHdl
IGdldCBhIGNvbnZlcmdlbmNlIHRvIHRoZQp2ZW5kb3IgbmFtZSBpbiBzb21lIG9yZ2FuaWMgd2F5
LgoKWW91cnMsCkxpbnVzIFdhbGxlaWoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
