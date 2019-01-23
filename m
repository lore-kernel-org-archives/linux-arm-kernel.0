Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF60C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:16:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C49120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5UEeXv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C49120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9ohiOqDsDPD3qL3v8l/PZ83xBQmG8zaaYMxUpY4jdjw=; b=u5UEeXv7grGvHq
	ZrA065sWgY/FhZsxIImz1rOtKtwxh4BFLXypKMoF2+q8tMIq3p+cBl9mVAB5uHt4lh/EiM4+QZG77
	56M9OWKqZo/C7WMdBHYqd5mEmcKiCZ0ptfN/hW0Tu6zSp2q19diQy6Kt1SZ0ee/mCw1HfLWOqUXuJ
	Qq+Z3TqRqvMReqV99oqErMoFuBquhrw8ydhvbG0U7+oOX9komqqsS1pyKcFGf+PufIMtQ578058MC
	hrBvWHt6exUKYHfGTyAznWssAfHr5fUYOwtJwZpguUkPPNSLNqe6ZgdhcF5gWusYpuF8yo1LBLKRI
	ZLwxaw70QQ0/wYqR8VJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmGVt-0002EE-1V; Wed, 23 Jan 2019 11:16:09 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmGVp-0002Ds-HR
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 11:16:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B836FB03E;
 Wed, 23 Jan 2019 11:16:01 +0000 (UTC)
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: [5.0-rc3] arm64: sun50i: h6: Pine H64 uart2 vs. emac
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <09bd31e2-afb7-98ae-9c77-96380ec18de0@suse.de>
Date: Wed, 23 Jan 2019 12:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_031605_718203_D0E2CCA3 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgZ3V5cywKCkluIDUuMCB0aGUgUGluZSBINjQncyBFdGhlcm5ldCBoYXMgYmVjb21lIHVzYWJs
ZSAodGhhbmtzIGZvciB5b3VyIHdvcmspLgoKSSdtIG5vdyB0cnlpbmcgdG8gdXNlIHRoZSBQaS0y
IFVBUlQgcGlucyAoc3VwcG9zZWRseSBQRDE5L1BEMjAgVUFSVDIpOwpob3dldmVyIHRoZSBINiAu
ZHRzaSByZXNlcnZlcyB0aG9zZSBwaW5zIGluIGV4dF9yZ21paV9waW5zLCBjYXVzaW5nIGFuCmVy
cm9yLiBJZiBJIG92ZXJ3cml0ZSBpdHMgcGlucyBwcm9wZXJ0eSAod2hpY2ggaXMgYSBsaXR0bGUg
Y3VtYmVyc29tZSwKYW55IGNoYW5jZSB3ZSBjYW4gc3BsaXQgdGhlbSBvZmYgaW50byBhIHNlcGFy
YXRlIG5vZGU/KSBFdGhlcm5ldCBpcyBubwpsb25nZXIgd29ya2luZy4gSSdtIGd1ZXNzaW5nIHRo
YXQncyByZWxhdGVkIHRvIE1ESU8vUEhZLCBhcyB0aGUKaW50ZXJmYWNlIGRvZXMgc2hvdyB1cCwg
anVzdCBkb2Vzbid0IGdldCB0aGUgbGluayB1cC4KCklzIGl0IG5vdCBwb3NzaWJsZSB0byB1c2Ug
RXRoZXJuZXQgYW5kIEdQSU8gaGVhZGVyIGF0IHRoZSBzYW1lIHRpbWUsCnVubGlrZSB0aGUgb3Jp
Z2luYWwgUGluZTY0Kywgb3IgYW0gSSBtaXNzaW5nIHNvbWUgcmVxdWlyZWQgRFQgY2hhbmdlPwoK
VGhhbmtzLApBbmRyZWFzCgoKICAgICAgICBmcmFnbWVudEAwIHsKICAgICAgICAgICAgICAgIHJl
ZyA9IDwwPjsKCiAgICAgICAgICAgICAgICB0YXJnZXQgPSA8JnBpbz47CgogICAgICAgICAgICAg
ICAgX19vdmVybGF5X18gewogICAgICAgICAgICAgICAgICAgICAgICB1YXJ0Ml9waW5zOiB1YXJ0
Mi1waW5zIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5zID0gIlBEMTkiLCAi
UEQyMCI7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnVuY3Rpb24gPSAidWFydDIi
OwogICAgICAgICAgICAgICAgICAgICAgICB9OwogICAgICAgICAgICAgICAgfTsKICAgICAgICB9
OwoKICAgICAgICBmcmFnbWVudEAxIHsKICAgICAgICAgICAgICAgIHJlZyA9IDwxPjsKCiAgICAg
ICAgICAgICAgICB0YXJnZXQgPSA8JmV4dF9yZ21paV9waW5zPjsKCiAgICAgICAgICAgICAgICBf
X292ZXJsYXlfXyB7CiAgICAgICAgICAgICAgICAgICAgICAgIHBpbnMgPSAiUEQwIiwgIlBEMSIs
ICJQRDIiLCAiUEQzIiwgIlBENCIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiUEQ1
IiwgIlBENyIsICJQRDgiLCAiUEQ5IiwgIlBEMTAiLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIlBEMTEiLCAiUEQxMiIsICJQRDEzIi8qLCAiUEQxOSIsICJQRDIwIiovOwogICAgICAg
ICAgICAgICAgfTsKICAgICAgICB9OwoKICAgICAgICBmcmFnbWVudEAyIHsKICAgICAgICAgICAg
ICAgIHJlZyA9IDwyPjsKCiAgICAgICAgICAgICAgICB0YXJnZXQgPSA8JnVhcnQyPjsKCiAgICAg
ICAgICAgICAgICBfX292ZXJsYXlfXyB7CiAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9
ICJva2F5IjsKICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsKICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC0wID0gPCZ1YXJ0Ml9waW5zPjsKICAg
ICAgICAgICAgICAgIH07CiAgICAgICAgfTsKCgotLSAKU1VTRSBMaW51eCBHbWJILCBNYXhmZWxk
c3RyLiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwg
SmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
