Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795B820665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rXGidUJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795B820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TGoRLPct5+R5Kcp9CmFcLj6BxbP3tTPi+zsj/P8OB14=; b=rXGidUJ/JPcN+0
	ewZn2hLoH+MdC+DA3KXngqUOOAtxadEKf3v9iMxBqnqSPYtaUceE8FY3LyR2BMjyQ+c7S5hlwPeoH
	f341BBA9UOH91UyzD+cEFC9lX89hOdrDcO8FTiA/RltlTLLBG9dVtQ0qM4tyIR19+CSK2RXWWZ0b4
	tDvI0yjppBEl6BDARLRHeK9+m7SZ1d9zG9EQaH9p8b3gRUzce42gyfQDS66yxuKiZ9j/+QnJ5YeTq
	7ouiDXxty9wYpxYrRjddHtLLPMs+Hi1hLVOMGfGWu/BUejag5OaTteAVv3+GZhfF1iUnMpx4hKczN
	4JW7GBerAL+TGHxQjGow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw75d-0004Ph-SQ; Tue, 19 Feb 2019 15:13:45 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw75Z-0004PG-Rk
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 15:13:43 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 83AB81BF207;
 Tue, 19 Feb 2019 15:13:34 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal
In-Reply-To: <611c942e1da6404d47cf3ff4a6bd33d7bdab4e13.1550427700.git.baruch@tkos.co.il>
References: <611c942e1da6404d47cf3ff4a6bd33d7bdab4e13.1550427700.git.baruch@tkos.co.il>
Date: Tue, 19 Feb 2019 16:13:33 +0100
Message-ID: <874l8z3j6q.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_071342_048628_2B799189 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, Denis Odintsov <oversun@me.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAogCiBPbiBkaW0uLCBmw6l2ci4gMTcgMjAxOSwgQmFydWNoIFNpYWNoIDxiYXJ1
Y2hAdGtvcy5jby5pbD4gd3JvdGU6Cgo+IFRoZSBQSFkgcmVzZXQgc2lnbmFsIGdvZXMgdG8gbXBw
NDMgb24gQ1AwLgo+CgoKQXBwbGllZCBvbiBtdmVidS9maXhlcyB3aXRoIHRoZSBGaXhlcyB0YWcg
cG9pbnRlZCBieSBBbmRyZXcuCgpUaGFua3MsCgpHcmVnb3J5CgoKPiBSZXBvcnRlZC1ieTogRGVu
aXMgT2RpbnRzb3YgPG92ZXJzdW5AbWUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEJhcnVjaCBTaWFj
aCA8YmFydWNoQHRrb3MuY28uaWw+Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04ay5kdHMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04ay5kdHMgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtY2xlYXJmb2ctZ3QtOGsuZHRzCj4g
aW5kZXggNWI0YTk2MDllMzFmLi4yNDY4NzYyMjgzYTUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cwo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04ay5k
dHMKPiBAQCAtMzUxLDcgKzM1MSw3IEBACj4gIAkJcmVnID0gPDA+Owo+ICAJCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7Cj4gIAkJcGluY3RybC0wID0gPCZjcDBfY29wcGVyX2V0aF9waHlfcmVz
ZXQ+Owo+IC0JCXJlc2V0LWdwaW9zID0gPCZjcDFfZ3BpbzEgMTEgR1BJT19BQ1RJVkVfTE9XPjsK
PiArCQlyZXNldC1ncGlvcyA9IDwmY3AwX2dwaW8yIDExIEdQSU9fQUNUSVZFX0xPVz47Cj4gIAkJ
cmVzZXQtYXNzZXJ0LXVzID0gPDEwMDAwPjsKPiAgCX07Cj4gIAo+IC0tIAo+IDIuMjAuMQo+Cgot
LSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5n
aW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
