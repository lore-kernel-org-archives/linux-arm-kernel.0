Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5148C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0D320892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lL8OKQ0R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktzVCBJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0D320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inOTnonng5bPIChQwi/HMtXnqJfGgzgEMHTWzf3ECEU=; b=lL8OKQ0RNCGAk2
	ayd6o+pLbHL7Va6LTY8kwIkdncTbPBrdro9RoUBl9vovWqDHNAb+Tcaplk5ol9kgyYO16CBQ72c57
	53SaDU/vcNXIl8MtqtusIpGp7nPFYI6aFoPQyFAlFr+HPyO8U828wdKnqHGkre4idLigC5meJk2UW
	2KvAwdfkMeqLl7pcwVhhLtEOULPytcSG8vzDYc9KCbiFUVf2d4SYRRFLvFYWvjEnlMoN2SSYftQrp
	kpEdGxJCmDrDI+tH7dYuA/861FQe50vQhaCbGZBPq4/nDDGTxQmv/PfmJK3391TL86HHGSIK9sDK4
	Xq1ANM/8Ul6/Mor63F9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHZO-0005wM-DF; Fri, 07 Dec 2018 14:57:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHZK-0005vq-Hp
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:57:31 +0000
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7D2D214DE
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  7 Dec 2018 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544194639;
 bh=8UxRX+JQQrDnYN8DkCVYEUJ2Kyw3EJkZfG/f5O0Yw1A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ktzVCBJrf28V/cSDcW5BaT798QJ/FchLPLWqAdAzsnF9kfDOxT5q8HKYs4s+rZpCB
 x4o6tLG21r9yjM+qjpUWsrM18Lxm9tYO83FBJk0geGqtWDLGLTRl3+g3eYvEovj4PX
 RZCNgY7nxnThAYmj/tSljR6jaw7lRoRF4AYZTIQM=
Received: by mail-qt1-f179.google.com with SMTP id y20so4686508qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:57:19 -0800 (PST)
X-Gm-Message-State: AA+aEWaVDYcX2hTRjCEwPVkrQsLFlOQ7o9gh0HljpXx9UmrDXKlxeuvX
 k47KTwJ35DV1PCOTp2LrRfquk+JU/ZX5I2b2LA==
X-Google-Smtp-Source: AFSGD/WPIyI69ALYxu5jxeXy536teq1lh8pE/F/IKZC+9vSwVS1HIDGGKk4GVJBizYyEjt7zR2d50yCrDyQ8yJ4Zfb0=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr2318520qvb.218.1544194638889; 
 Fri, 07 Dec 2018 06:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
 <20181206200652.GB3084@sirena.org.uk>
In-Reply-To: <20181206200652.GB3084@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Fri, 7 Dec 2018 08:57:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJuH4=Bq9ok3Trz4GgLam7gqWW5-gyHpG1XbShtQQuSJg@mail.gmail.com>
Message-ID: <CAL_JsqJuH4=Bq9ok3Trz4GgLam7gqWW5-gyHpG1XbShtQQuSJg@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065730_620815_5116BD20 
X-CRM114-Status: GOOD (  22.03  )
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
 Liviu Dudau <liviu.dudau@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tom Rini <trini@konsulko.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Alexander Graf <agraf@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCAyOjA3IFBNIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIERlYyAwNiwgMjAxOCBhdCAwMTowNjo0M1BNIC0wNjAw
LCBSb2IgSGVycmluZyB3cm90ZToKPiA+IE9uIFRodSwgRGVjIDYsIDIwMTggYXQgNzozMiBBTSBB
bmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+IHdyb3RlOgo+Cj4gPiA+IEknZCBiZSBv
a2F5IHdpdGggZGlzdGluZ3Vpc2hpbmcgc291cmNlIHZzLiBpbnN0YWxsIGxvY2F0aW9uLiBEdWUg
dG8gdGhlCj4gPiA+IGlzc3VlIEkgbWVudGlvbiBiZWxvdyAoYW5kIG1vcmUpIHdlIGNhbid0IHVz
ZSBpbnN0YWxsX2R0YnMgZm9yIG9wZW5TVVNFCj4gPiA+IGFuZCBoYWQgdG8gcmVpbXBsZW1lbnQg
aXQsIHdoaWNoIHdlJ2QgbmVlZCB0byAoYW5kIGNhbikgYWRqdXN0Lgo+Cj4gPiBXaGF0IHdvdWxk
IGJlIG5lZWRlZCBmb3IgZHRic19pbnN0YWxsIHRvIHdvcms/IGFybTY0IG5lZWRzIHRvIHN1cHBv
cnQKPiA+IGEgZmxhdCBpbnN0YWxsPyBJZiBpdCBkb2Vzbid0IHdvcmsgZm9yIERlYmlhbiBvciBv
cGVuU1VTRSwgSSdtIG5vdAo+ID4gc3VyZSB3aHkgd2UgaGF2ZSBpdC4gU28gSSdkIGxpa2UgdG8g
bWFrZSBpdCB3b3JrLgo+Cj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcgYnV0IGFzIGZhciBhcyB0
aGUgZmxhdCB2cyBkaXJlY3RvcnkgdGhpbmcgZ29lcwo+IGlzbid0IHRoZSBpc3N1ZSB0aGF0IHRo
aXMgd2luZHMgdXAgYmVpbmcgYSByZW5hbWUgZm9yIGFuIGV4aXN0aW5nIDMyIGJpdAo+IHN5c3Rl
bT8gIElmIHlvdSBqdXN0IGluc3RhbGwgdGhlIGR0YnMgaW4gdGhlIGRlZmF1bHQgbG9jYXRpb24g
dGhlbiBhCj4gYm9vdGxvYWRlciBvciB3aGF0ZXZlciB0aGF0IGlzIGhhcmQgY29kZWQgdG8gbG9v
ayBmb3IgZm9vLWJhci5kdGIgd29uJ3QKPiBzZWUgdGhlIG5ldyBmb28vZm9vLWJhci5kdGIgKG9y
IHdoYXRldmVyKSBhbmQgd2lsbCBjb250aW51ZSB0byB1c2UgdGhlCj4gb2xkIGJpbmFyeS4gIEl0
J3Mgbm90IHRoZSBmYWN0IHRoYXQgdGhhdCBpdCdzIGluIGEgZGlyZWN0b3J5LCBpdCdzIHRoZQo+
IGZhY3QgdGhhdCB0aGUgYm9vdGxvYWRlciBzZWVzIHRoZSBuYW1lIGl0IG5lZWRzIHRvIGxvb2sg
Zm9yIGNoYW5nZSAoaWYKPiBpdCdzIGxvb2tpbmcgb24gYSBmaWxlc3lzdGVtIGF0IGFsbCkuCgpD
b3JyZWN0LgoKPiBUaGlzIGlzbid0IGEgcHJvYmxlbSBmb3IgYXJtNjQgYXMKPiB0aGUgbG9jYXRp
b24gaXNuJ3QgY2hhbmdpbmcsIGl0J3MgdXNlZCBkaXJlY3RvcmllcyBmcm9tIGRheSBvbmUuCgpU
aGUga2VybmVsIG1heSBoYXZlIHVzZWQgZGlyZWN0b3JpZXMsIGJ1dCB0aGF0J3Mgbm90IHdoYXQg
dGhlIGRpc3Ryb3MKZGlkIGFjY29yZGluZyB0byBBbmRyZWFzOgoKPiBXZSBhbHJlYWR5IGhhZCB0
aGF0IGRpc2N1c3Npb24gZm9yIGFybTY0IGJlY2F1c2UgRGViaWFuIGNob3NlIHRvIGlnbm9yZQo+
IHRoZSBrZXJuZWwtaW5zdGFsbGVkIHN1YmRpcmVjdG9yaWVzIGFuZCBpbnN0YWxsZWQgLmR0YiBm
aWxlcyBpbnRvIGEgZmxhdAo+IGRpcmVjdG9yeSwgd2hpY2ggY29sbGlkZWQgd2l0aCBvcGVuU1VT
RSBzdGlja2luZyB0byB0aGUga2VybmVsIGNob2ljZS4KClNvIGFyZSB0aGUgZGlzdHJvcyBkaWZm
ZXJlbnQgb3Igd2hvIGNoYW5nZWQgdG8gYWxpZ24/IFRoYXQncyBub3QgY2xlYXIKZnJvbSB0aGlz
IHRocmVhZC4KCj4gVGhlIGlzc3VlcyB3aXRoIHRoZSBleGlzdGluZyBpbnN0YWxsX2R0YnMgc291
bmRlZCB1bnJlbGF0ZWQgdG8gdGhpcy4KCk1heWJlLCB3aGF0IGFyZSB0aGUgaXNzdWVzPyBXZSBj
YW4ndCBjaGFuZ2UgdGhlIHNvdXJjZSBsYXlvdXQKdHJhbnNwYXJlbnRseSBpZiBkdGJzX2luc3Rh
bGwgaXMgbm90IGJlaW5nIHVzZWQuCgpNeSBxdWVzdGlvbiBoZXJlIGlzIHdoZXRoZXIgYSBmbGF0
IGluc3RhbGwgaXMgdXNlZnVsIG9uIGFybTY0LiBXZSBjYW4KZWl0aGVyIGhhdmUgYSBrY29uZmln
IHZhcmlhYmxlIHRoYXQgYXJtMzIgc2V0cyB0byBkbyBmbGF0IGluc3RhbGxzIG9yCml0IGNvdWxk
IGJlIHNvbWUgY29tbWFuZCBsaW5lIG1ha2UgdmFyaWFibGUgYW5kIHRoZW4gYW55IHVzZXIgY2Fu
IHBpY2sKd2hhdCB0aGV5IHdhbnQgZm9yIGFueSBhcmNoLgoKUm9iCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
