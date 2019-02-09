Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5400C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9E2217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QmVSS150"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9E2217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5+cgJ+R0cxyLhkaytCIDZJErJkMwX1N4ahvkW6AofVY=; b=QmVSS150TSLNU+
	dE0wv0yVjLCAxlUxf5EaHhJOPjF8D13O3wr06OgoksE0UrRXgae5XGRgyB15+TbafIjzb5OGCKEJj
	focbauqO4S+d2Gs4hroishmMr/PyGCQlJoVmlG5aXv8SzW8Dw2/eqj0ZSSOGJPbYwZnxinrN9b41f
	fTMzZiSHZPUyVmshX4R9zTBUyex3HzrSpLMqGf3UE8x/577oMwi/28cOveewrXbLrZw/O9m77/V5Y
	WjDJv6qAf1CPDrOl9V/F6zzQzTnJPJyrUKRoffgTwgKKajUZzK+S8b6tFb9UOpAd0mfHgN6Pvwt+g
	WtPnGRFooYKYIumgYgAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsJ81-0004mu-F6; Sat, 09 Feb 2019 03:16:29 +0000
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsJ7y-0004mZ-Tx; Sat, 09 Feb 2019 03:16:27 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -mmotm/-next] pinctrl: fix pxa2xx.c build warnings
Message-ID: <0024542e-cba9-8f13-6c18-32d0050a6007@infradead.org>
Date: Fri, 8 Feb 2019 19:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Language: en-US
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
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CgpBZGQgI2luY2x1ZGUg
b2YgPGxpbnV4L3BpbmN0cmwvbWFjaGluZS5oPiB0byBmaXggYnVpbGQKd2FybmluZ3MgaW4gcGlu
Y3RybC1weGEyeHguYy4gIEZpeGVzIHRoZXNlIHdhcm5pbmdzOgoKSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC4uL2RyaXZlcnMvcGluY3RybC9weGEvcGluY3RybC1weGEyeHguYzoyNDowOgouLi9kcml2
ZXJzL3BpbmN0cmwvcHhhLy4uL3BpbmN0cmwtdXRpbHMuaDozNjo4OiB3YXJuaW5nOiDigJhlbnVt
IHBpbmN0cmxfbWFwX3R5cGXigJkgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IFtlbmFi
bGVkIGJ5IGRlZmF1bHRdCiAgIGVudW0gcGluY3RybF9tYXBfdHlwZSB0eXBlKTsKICAgICAgICBe
Ci4uL2RyaXZlcnMvcGluY3RybC9weGEvLi4vcGluY3RybC11dGlscy5oOjM2Ojg6IHdhcm5pbmc6
IGl0cyBzY29wZSBpcyBvbmx5IHRoaXMgZGVmaW5pdGlvbiBvciBkZWNsYXJhdGlvbiwgd2hpY2gg
aXMgcHJvYmFibHkgbm90IHdoYXQgeW91IHdhbnQgW2VuYWJsZWQgYnkgZGVmYXVsdF0KClNpZ25l
ZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgpDYzogUm9iZXJ0
IEphcnptaWsgPHJvYmVydC5qYXJ6bWlrQGZyZWUuZnI+CkNjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKLS0tClNlZW4gaW4gbGludXgtbmV4dCBhbmQgbW1vdG0uCgogZHJp
dmVycy9waW5jdHJsL3B4YS9waW5jdHJsLXB4YTJ4eC5jIHwgICAgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCi0tLSBtbW90bS0yMDE5LTAyMDgtMTYzMy5vcmlnL2RyaXZlcnMv
cGluY3RybC9weGEvcGluY3RybC1weGEyeHguYworKysgbW1vdG0tMjAxOS0wMjA4LTE2MzMvZHJp
dmVycy9waW5jdHJsL3B4YS9waW5jdHJsLXB4YTJ4eC5jCkBAIC0xNCw2ICsxNCw3IEBACiAjaW5j
bHVkZSA8bGludXgvb2YuaD4KICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+CiAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvcGluY3RybC9tYWNoaW5lLmg+CiAj
aW5jbHVkZSA8bGludXgvcGluY3RybC9waW5jb25mLmg+CiAjaW5jbHVkZSA8bGludXgvcGluY3Ry
bC9waW5jb25mLWdlbmVyaWMuaD4KICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL3Bpbm11eC5oPgoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
