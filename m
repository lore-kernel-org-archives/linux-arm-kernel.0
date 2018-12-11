Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0032EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCC820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p6lVT8JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A1eyU3rbRMnoVfUMNZ8ltmX+NWJ452BF1IcIwf7dUp4=; b=p6lVT8JINKzwJW
	GMOLuKXmJGiYLziVyDYuNy382UgY/w1i3PvNXa69egbQV7jWbDeD9+WnyCa5ED+ARPY3tqCy9nK/w
	y1QAG6yazrIZNBUa+8pwrKOps4yWdGTp1ff5nZv3hNbmBAy9pGqy2we1B2Cduhl74LYFwEVu3pOLI
	LHVQH7uI9poVUTI+Ii8Js5tFMdY4ZSdJ//0bpnAdhJPkIAAHGIT1eUlPOWz1igpYMVg60acattAkL
	iE8HRX+IVxNGJZAdmWvUjiJQuiblEG5KPCBNc9HrhTT8VuiZdr918EPsHsAiQyjZCZQkx0F/qWrDV
	qlipv5suB/XHoIiBVrSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWk0b-0002iB-Iq; Tue, 11 Dec 2018 15:31:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWk0X-0002cA-Hs
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:31:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id EC3D4208E3; Tue, 11 Dec 2018 16:31:24 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id B8427206A1;
 Tue, 11 Dec 2018 16:31:14 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] arm64: dts: marvell: mcbin: fix PCIe reset signal
References: <8a9652066a649b5349b76c823bef946024161275.1544441887.git.baruch@tkos.co.il>
Date: Tue, 11 Dec 2018 16:31:15 +0100
In-Reply-To: <8a9652066a649b5349b76c823bef946024161275.1544441887.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Mon, 10 Dec 2018 13:38:07 +0200")
Message-ID: <87efaot70c.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_073137_725542_30DA6858 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAogCiBPbiBsdW4uLCBkw6ljLiAxMCAyMDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVj
aEB0a29zLmNvLmlsPiB3cm90ZToKCj4gVGhlIE1QUDUyIHNpZ25hbCBpcyBvbiB0aGUgc2Vjb25k
cyBHUElPIGluc3RhbmNlIG9mIENQMCwgd2hpY2gKPiBjb3JyZXNwb25kcyB0byB0aGUgJmNwMF9n
cGlvMiBoYW5kbGUuCj4KPiBSZW5hbWUgdGhlIHByb3BlcnR5IG5hbWUgdG8gdGhlIHN0YW5kYXJk
ICctZ3Bpb3MnIHN1ZmZpeCB3aGlsZSBhdCBpdC4KPgo+IEZpeGVzOiBiODNlMTY2OWFkY2U2ICgi
YXJtNjQ6IGR0czogbWFydmVsbDogbWNiaW46IGFkZCBzdXBwb3J0IGZvciBQQ0llIikKPiBTaWdu
ZWQtb2ZmLWJ5OiBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPgoKV2l0aCB0aGUgbGFz
dCBjaGFuZ2UgaW4gYXJtYWRhLTgwNDAtbWNiaW4uZHRzIHRoaXMgcGF0Y2ggbm8gbW9yZSBhcHBs
eQpvbiBtdmVidS9kdDY0LgoKR3JlZ29yeQoKPiAtLS0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0cyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtODA0MC1tY2Jpbi5kdHMKPiBpbmRleCA1NmZhNDQ4NjA5MDkuLjQ2
ZGFjZmMwOGNlYyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJt
YWRhLTgwNDAtbWNiaW4uZHRzCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS04MDQwLW1jYmluLmR0cwo+IEBAIC0xODMsNyArMTgzLDcgQEAKPiAgCXBpbmN0cmwtMCA9
IDwmY3AwX3BjaWVfcGlucz47Cj4gIAludW0tbGFuZXMgPSA8ND47Cj4gIAludW0tdmlld3BvcnQg
PSA8OD47Cj4gLQlyZXNldC1ncGlvID0gPCZjcDBfZ3BpbzEgMjAgR1BJT19BQ1RJVkVfTE9XPjsK
PiArCXJlc2V0LWdwaW9zID0gPCZjcDBfZ3BpbzIgMjAgR1BJT19BQ1RJVkVfTE9XPjsKPiAgCXN0
YXR1cyA9ICJva2F5IjsKPiAgfTsKPiAgCj4gLS0gCj4gMi4xOS4yCj4KCi0tIApHcmVnb3J5IENs
ZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRw
Oi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
