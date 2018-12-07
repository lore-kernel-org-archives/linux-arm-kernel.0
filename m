Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A345EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7430820661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MBKuSjwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7430820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8Mw3wjpul1D/WiHZn3BxvhzOSQ88O2UfLdLnZwmhI5c=; b=MBKuSjwo/zA3ISK6X5bg8odHG
	MOMmit68dxtk4oTYQebyfcFsbsuQ+r/8YI63rOEC4hOnLPEwk8ItefaUtjn5SJGGhHfPaiy6VpeUL
	tBkz09NdNiyThkaymGNl8xfWdXdxcTclaXVFqw3+T6qawHANnX9AG/c8Pie29qnFU42Oi7hEMGln1
	imLhed6zzB1AaFBxmkqLiH0XvQFyESAPCNbkU4UZMUJoyFxeZBfru2pL3iDnZJ2NgEvoR9RUtTfWk
	29XKZuSa9memEHu/Rdsyw/nmIgsxzBcad44dplVcovasTVyaceHp5kleVnJ1A2KewgbwEJWkoGaX1
	CU+5D5MUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDZu-00024q-SX; Fri, 07 Dec 2018 10:41:50 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDZf-0001sa-Vl; Fri, 07 Dec 2018 10:41:37 +0000
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 7 Dec 2018
 18:41:39 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To: Miquel Raynal <miquel.raynal@bootlin.com>, Jianxin Pan
 <jianxin.pan@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13> <20181207104254.0ecfc1e5@xps13>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <ac486ae7-7997-6f35-f29c-267c9c6f0f8c@amlogic.com>
Date: Fri, 7 Dec 2018 18:41:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181207104254.0ecfc1e5@xps13>
Content-Language: en-US
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_024136_215815_D710D5E8 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAoKQXBwcmVjaWF0ZSB5b3VyIHRpbWUuCkkgd2lsbCBmb2xsb3cgdGhlIG5hbmQv
bmV4dCBhbmQgcmV3b3JrIHNvbWUgbmV4dCB3ZWVrIGFzIHNvb24gYXMgcG9zc2libGUuCgpPbiAy
MDE4LzEyLzcgMTc6NDIsIE1pcXVlbCBSYXluYWwgd3JvdGU6Cj4gSGkgSmlhbnhpbiwKPiAKPiBN
aXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZSBvbiBGcmksIDcg
RGVjIDIwMTgKPiAxMDoyNDo1NiArMDEwMDoKPiAKPj4gSGkgSmlhbnhpbiwKPj4KPj4gTG9va3Mg
Z29vZCB0byBtZSBvdmVyYWxsLCBhIGZldyBjb21tZW50cyBpbmxpbmUuCj4+Cj4+IEppYW54aW4g
UGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gd3JvdGUgb24gU2F0LCAxNyBOb3YgMjAxOAo+
PiAwMDo0MDozOCArMDgwMDoKPj4KPj4+IEZyb206IExpYW5nIFlhbmcgPGxpYW5nLnlhbmdAYW1s
b2dpYy5jb20+Cj4+Pgo+Pj4gQWRkIGluaXRpYWwgc3VwcG9ydCBmb3IgdGhlIEFtbG9naWMgTkFO
RCBmbGFzaCBjb250cm9sbGVyIHdoaWNoIGZvdW5kCj4+PiBpbiB0aGUgTWVzb24tR1hCQi9HWEwv
QVhHIFNvQ3MuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTGlhbmcgWWFuZyA8bGlhbmcueWFuZ0Bh
bWxvZ2ljLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IFlpeHVuIExhbiA8eWl4dW4ubGFuQGFtbG9n
aWMuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9n
aWMuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcgICAgICB8
ICAgMTAgKwo+Pj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZSAgICAgfCAgICAxICsK
Pj4+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbWVzb25fbmFuZC5jIHwgMTQxNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQyOCBp
bnNlcnRpb25zKCspCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC9uYW5kL3Jh
dy9tZXNvbl9uYW5kLmMKPj4+Cj4gCj4gSSBmb3Jnb3QgdG8gbWVudGlvbiwgQm9yaXMgaGFzIGRv
bmUgbW9yZSBjbGVhbnVwIHdoaWNoIGJyZWFrcyB5b3VyCj4gcGF0Y2hlcywgcGxlYXNlIGhhdmUg
YSBsb29rIGF0IHRoZSBmb2xsb3dpbmcgY29tbWl0cyBpbiB0aGUgbmFuZC9uZXh0Cj4gYnJhbmNo
LCB0aGV5IHdpbGwgZm9yY2UgeW91IHRvIGRvIHNvbWUgbGlnaHQgcmV3b3JrIHRvIGdldCB0aGUg
ZHJpdmVyCj4gYnVpbGRpbmcgKGVzcGVjaWFsbHksIHlvdSBzaG91bGQgbm90IGV4cG9ydCB0aGUg
LT5zZWxlY3RfY2hpcCBob29rIGFueW1vcmUpOgo+IAo+IDdhMDhkYmFlZGQzNiBtdGQ6IHJhd25h
bmQ6IE1vdmUgLT5zZXR1cF9kYXRhX2ludGVyZmFjZSgpIHRvIG5hbmRfY29udHJvbGxlcl9vcHMK
PiBmMmFiZmViMjA3OGIgbXRkOiByYXduYW5kOiBNb3ZlIHRoZSAtPmV4ZWNfb3AoKSBtZXRob2Qg
dG8gbmFuZF9jb250cm9sbGVyX29wcwo+IDdkNmMzN2U5MGNmOSBtdGQ6IHJhd25hbmQ6IERlcHJl
Y2F0ZSB0aGUgLT5zZWxlY3RfY2hpcCgpIGhvb2sKPiAxNzcwMDIyZmZhODUgbXRkOiByYXduYW5k
OiBhbXMtZGVsdGE6IFN0b3AgaW1wbGVtZW50aW5nIC0+c2VsZWN0X2NoaXAoKQo+IDY1M2M1N2M3
ZGEwOCBtdGQ6IHJhd25hbmQ6IHZmNjEwOiBTdG9wIGltcGxlbWVudGluZyAtPnNlbGVjdF9jaGlw
KCkKPiAyYWNlNDUxY2FlMjIgbXRkOiByYXduYW5kOiB0ZWdyYTogU3RvcCBpbXBsZW1lbnRpbmcg
LT5zZWxlY3RfY2hpcCgpCj4gYjI1MjUxNDE0ZjZlIG10ZDogcmF3bmFuZDogbWFydmVsbDogU3Rv
cCBpbXBsZW1lbnRpbmcgLT5zZWxlY3RfY2hpcCgpCj4gNTUwYjlmYzRlM2FmIG10ZDogcmF3bmFu
ZDogZnNtYzogU3RvcCBpbXBsZW1lbnRpbmcgLT5zZWxlY3RfY2hpcCgpCj4gMDJiNGE1MjYwNGE0
IG10ZDogcmF3bmFuZDogTWFrZSAtPnNlbGVjdF9jaGlwKCkgb3B0aW9uYWwgd2hlbiAtPmV4ZWNf
b3AoKSBpcyBpbXBsZW1lbnRlZAo+IGFlMjI5NGIxMGIwZiBtdGQ6IHJhd25hbmQ6IFBhc3MgdGhl
IENTIGxpbmUgdG8gYmUgc2VsZWN0ZWQgaW4gc3RydWN0IG5hbmRfb3BlcmF0aW9uCj4gMWQwMTc4
NTkzZDE0IG10ZDogcmF3bmFuZDogQWRkIG5hbmRfW2RlXXNlbGVjdF90YXJnZXQoKSBoZWxwZXJz
Cj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwKPiAKPiAuCj4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
