Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C528EC5ACD3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964EE20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="biNteros"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964EE20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+IG/E5pC/h3F6C+uFnumJftPiZIYhZZ+iJYnzfeCw4=; b=biNteros6kjurH
	YSVQ0LrM8pxfMdeqYuZf8GQFu/lxlqHx85FuKvjQEo3vsJxDFOmHjuQjQo7gqfA3xuPOWnHi/Jfgj
	MW40z/sgRTQeyQ05tqvcqqWfu4X/G5JbPlvBVyA0H0FiJ9Vu4uHipNB/V45gDYdZTOYJGC5ZQDXgr
	izdM8mTAAwaTckuCGyscKzxcbW9KSXB2pn73pIgGYI/hQRinAYMUulrkHHRr9jhECFBnIwm+eEm/W
	UM8+ZitsYVEaYnAYDNMznppRGMT1GV+YibqF8wpgIB4XkjIL/m4d9Aq1UQuyYUyxZ93NCODqW+YZh
	3gyl9Hqj05ZZF247fmRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYbv-0008KR-4s; Fri, 18 Jan 2019 18:11:19 +0000
Received: from mail-sh.amlogic.com ([58.32.228.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYbf-00088h-Ek; Fri, 18 Jan 2019 18:11:04 +0000
Received: from [192.168.0.111] (223.166.104.240) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Sat, 19 Jan
 2019 02:11:45 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v9 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com>
 <20190115175232.3d82d4a9@xps13>
Message-ID: <487cf528-fe4a-ec9c-754a-9e9188f16495@amlogic.com>
Date: Sat, 19 Jan 2019 02:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190115175232.3d82d4a9@xps13>
Content-Language: en-US
X-Originating-IP: [223.166.104.240]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_101103_515929_15F05EB5 
X-CRM114-Status: GOOD (  12.13  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAoKT24gMjAxOS8xLzE2IDA6NTIsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gSGkg
SmlhbnhpbiwKPiAKPiBKaWFueGluIFBhbiA8amlhbnhpbi5wYW5AYW1sb2dpYy5jb20+IHdyb3Rl
IG9uIFR1ZSwgMTUgSmFuIDIwMTkKPiAyMzozODowMiArMDgwMDoKPiAKPj4gVGhlc2UgdHdvIHBh
dGNoZXMgdHJ5IHRvIGFkZCBpbml0aWFsIE5BTkQgZHJpdmVyIHN1cHBvcnQgZm9yIEFtbG9naWMg
TWVzb24KPj4gU29DcywgY3VycmVudCBpdCBoYXMgYmVlbiB0ZXN0ZWQgb24gR1hMKHAyMTIpIGFu
ZCBBWEcoczQwMCkgcGxhdGZvcm0uCj4+Cj4+IENoYW5nZXMgc2luY2UgVjggYXQgWzldCj4+ICAt
IGZpeCBidWlsZCBmYWlscmUgYXQgb2JqZWN0X2lzX29uX3N0YWNrCj4+ICAtIHVwZGF0ZSBLY29u
ZmlnIGFzIE1hcnRpbidzIHN1Z2dlc3RlZAo+IAo+IFRoYW5rcyBmb3IgdGhpcyBsYXN0IHZlcnNp
b24sIGxvb2tzIGdvb2QgdG8gbWUuIENvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhCj4gcGF0Y2ggdG8g
YWRkIGEgTUFJTlRBSU5FUlMgZW50cnk/Cj4KT0suCj4gQWxzbywgY2FuIHdlIGZhY2UgYW55IGRl
YWRseSBmYWlsdXJlIGlmIHNvbWVvbmUgY29tcGlsZXMgdGhpcyBkcml2ZXIKPiB3aXRob3V0IHRo
ZSBNTUMgY2xvY2sgZHJpdmVyIHVwZGF0ZWQ/Cj4KV2l0aG91dCB0aGUgTU1DIGNsb2NrIGRyaXZl
cgoxKSBUaGlzIGRyaXZlciBjYW4gYmUgYnVpbHQgc3VjY2Vzc2Z1bGx5LgoyKSBUaGUgcHJvYmUg
d2lsbCBmYWlsIHdoZW4gZ2V0IGNsb2NrcyBkZWZpbmVkIGluIE1NQyBjbG9jayBkcml2ZXIuIAoK
PiBUaGFua3MsCj4gTWlxdcOobAo+IAo+IC4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
