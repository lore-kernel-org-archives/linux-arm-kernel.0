Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:37:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0E2217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVlMq6di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0E2217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mQD+t+xZdxZt5knFU2+QZaYXn1XO/VIKOot9A6Etr+E=; b=PVlMq6diu5glk6
	nigkzF0KBYVSc4OHVynKTrWnXjyPJu9RUrGqS1lgKdTOsOmbGxKgTSKns3H8xezpbhpONCr+AamMg
	YEp6geUWS0ca6bh2TdZZYwN/JwDO9ESijgoDdgMI79MmjRqLqWJ2a85awA7TZVK4ADMpQHM6t8Q2+
	v+jwAo8G23+qV/DGJiRRWbxZgslDXW0+LIOPAhH2/FWslkKClsHZooBqONZy1NLYHxtb0Pi1jRdrO
	YsToeRzQhwG96thxWIheXNty/O7jX7d7caFtPH5SQEiZZM3rYf9vsSEXsyEjaM4Uy5/Va9TTalKIe
	5kDtiNYnazyJfdTDeRKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYSrI-0004LX-U8; Sun, 16 Dec 2018 09:37:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYSrF-0004KQ-FA
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 09:37:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8382320BE1; Sun, 16 Dec 2018 10:36:56 +0100 (CET)
Received: from localhost (vfc69-4-88-175-133-2.fbx.proxad.net [88.175.133.2])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4393E206FF;
 Sun, 16 Dec 2018 10:36:46 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/5] Add CPU clock support for Armada 7K/8K
References: <20181206171516.15891-1-gregory.clement@bootlin.com>
 <154482536298.19322.16460657058404864070@swboyd.mtv.corp.google.com>
Date: Sun, 16 Dec 2018 10:36:46 +0100
In-Reply-To: <154482536298.19322.16460657058404864070@swboyd.mtv.corp.google.com>
 (Stephen Boyd's message of "Fri, 14 Dec 2018 14:09:22 -0800")
Message-ID: <87h8fdke35.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_013709_641660_1007312D 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgU3RlcGhlbiwKIAogT24gdmVuLiwgZMOpYy4gMTQgMjAxOCwgU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPiB3cm90ZToKCj4gUXVvdGluZyBHcmVnb3J5IENMRU1FTlQgKDIwMTgtMTIt
MDYgMDk6MTU6MTEpCj4+IEhlbGxvLAo+PiAKPj4gVGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24g
b2YgYSBzZXJpZXMgYWxsb3dpbmcgdG8gbWFuYWdlIHRoZSBjcHUKPj4gY2xvY2sgZm9yIEFybWFk
YSA3Sy84Sy4gRm9yIHRoZXNlIFNvQ3MsIHRoZSBDUFVzIHNoYXJlIHRoZSBzYW1lIGNsb2NrCj4+
IGJ5IGNsdXN0ZXIsIHNvIGFjdHVhbGx5IHRoZSBjbG9jayBtYW5hZ2VtZW50IGlzIGRvbmUgYXQg
Y2x1c3RlciBsZXZlbC4KPj4gCj4+IEFzIGZvciB0aGUgb3RoZXIgQXJtYWRhIDdLLzhLIGNsb2Nr
cyBpdCBpcyBwb3NzaWJsZSB0byBoYXZlIG11bHRpcGxlCj4+IEFQIHNvIGhlcmUgYWdhaW4gd2Ug
bmVlZCB0byBoYXZlIHVuaXF1ZSBuYW1lOiB0aGUgcHVycG9zZSBvZiB0aGUgc2Vjb25kCj4+IHBh
dGNoIGlzIHRvIHNoYXJlIGEgY29tbW9uIGNvZGUgd2hpY2ggd2lsbCBiZSB1c2VkIGluIDMgZHJp
dmVycy4KPj4gCj4+IFRoZSBsYXN0IDIgcGF0Y2ggZW5hYmxlIHRoZSBkcml2ZXIgYXQgZHQgYW5k
IHBsYXRmb3JtIGxldmVsIGFuZCB3aWxsCj4+IGJlIGFwcGxpZWQgdGhyb3VnaCB0aGUgbXZlYnUg
c3Vic3lzdGVtLgo+ICAKPiBUaGUgYmluZGluZyAibWFydmVsbCxhcDgwNi1jcHUtY2xvY2siIGlz
IG5vdCBkb2N1bWVudGVkLiBJdCB3YXMgaW4gdGhlCj4gcHJldmlvdXMgc2VyaWVzIGJ1dCB0aGVu
IGdvdCBkcm9wcGVkIGZyb20gdGhpcyBvbmU/IFdoeT8KCkkgbWFkZSBhIG1pc3Rha2UgYW5kIHN0
YXJ0IG15IGdpdC1mb3JtYXQgb24gdGhlIHdyb25nIGNvbW1pdCwgSSBhbQpzZW5kaW5nIGEgbmV3
IHNlcmllcyByaWdodCBub3cgd2l0aCB0aGlzIG1pc3NpbmcgcGF0Y2guCgpHcmVnb3J5Cgo+Cgot
LSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5n
aW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
