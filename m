Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED61AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A767214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hag18AjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A767214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PCipEG8uQKS3qiUcNGCny0wwRBVmgYzToZL7nY7eHsM=; b=hag18AjBDSFwq0
	9ks7zfYVmXSMqwB/BKWmLJWR16d7g6CEfLiiYGDvw6N3Lam0xyQGncduACtYoTQTn+03owluRoF0D
	z3Ba0IarNQX0q7x37WEY0Q+epSpbgs66nV65K1pFx6dO1cn+SawzSGunRzFmWvQS8qGdmkp9ScAe9
	tM5EAoOr3SqwpQYzlexd53Eop2Ojpsw69DANtE8j2yBgQ3fjqmUFLmtwZ5xX5L0RF4GLavsyElUbH
	vgItzZfssU4N/ygpcSej1Hprg2U5ePApnqB0WBifdRUkmJ3U1dr13u5Ixcj0gD6XPLS/MhZj6YCzY
	5J8srMNPoHcoeztSEfEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghYNo-0001TJ-7Y; Thu, 10 Jan 2019 11:20:20 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghYNj-0001Ss-Uw
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 11:20:17 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DD02F209D7; Thu, 10 Jan 2019 12:20:09 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr
 [109.213.84.72])
 by mail.bootlin.com (Postfix) with ESMTPSA id A3FDF206DC;
 Thu, 10 Jan 2019 12:19:59 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2] arm64: dts: marvell: mcbin: fix PCIe reset signal
References: <2e9292493b5bb9811870adba3e43b2866c65169c.1544597006.git.baruch@tkos.co.il>
Date: Thu, 10 Jan 2019 12:19:59 +0100
In-Reply-To: <2e9292493b5bb9811870adba3e43b2866c65169c.1544597006.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Wed, 12 Dec 2018 08:43:26 +0200")
Message-ID: <87zhs8oj34.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_032016_146036_1FA5E642 
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAogCiBPbiBtZXIuLCBkw6ljLiAxMiAyMDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVj
aEB0a29zLmNvLmlsPiB3cm90ZToKCj4gVGhlIE1QUDUyIHNpZ25hbCBpcyBvbiB0aGUgc2Vjb25k
cyBHUElPIGluc3RhbmNlIG9mIENQMCwgd2hpY2gKPiBjb3JyZXNwb25kcyB0byB0aGUgJmNwMF9n
cGlvMiBoYW5kbGUuCj4KPiBSZW5hbWUgdGhlIHByb3BlcnR5IG5hbWUgdG8gdGhlIHN0YW5kYXJk
ICctZ3Bpb3MnIHN1ZmZpeCB3aGlsZSBhdCBpdC4KPgo+IEZpeGVzOiBiODNlMTY2OWFkY2U2ICgi
YXJtNjQ6IGR0czogbWFydmVsbDogbWNiaW46IGFkZCBzdXBwb3J0IGZvciBQQ0llIikKPiBTaWdu
ZWQtb2ZmLWJ5OiBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPgoKCkFwcGxpZWQgb24g
bXZlYnUvZml4ZXMKClRoYW5rcywKCkdyZWdvcnkKCgo+IC0tLQo+IHYyOiByZWJhc2VkIG9uIHRv
cCBvZiBtdmVidS9kdDY0IChHcmVnb3J5KQo+IC0tLQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21h
cnZlbGwvYXJtYWRhLTgwNDAtbWNiaW4uZHRzaSB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAtbWNiaW4uZHRzaQo+IGluZGV4IDI5ZWE3ZTgxZWM0Yy4u
MzI5ZjhjZWVlYmVhIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtODA0MC1tY2Jpbi5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS04MDQwLW1jYmluLmR0c2kKPiBAQCAtMTgzLDcgKzE4Myw3IEBACj4gIAlwaW5jdHJs
LTAgPSA8JmNwMF9wY2llX3BpbnM+Owo+ICAJbnVtLWxhbmVzID0gPDQ+Owo+ICAJbnVtLXZpZXdw
b3J0ID0gPDg+Owo+IC0JcmVzZXQtZ3BpbyA9IDwmY3AwX2dwaW8xIDIwIEdQSU9fQUNUSVZFX0xP
Vz47Cj4gKwlyZXNldC1ncGlvcyA9IDwmY3AwX2dwaW8yIDIwIEdQSU9fQUNUSVZFX0xPVz47Cj4g
IAlzdGF0dXMgPSAib2theSI7Cj4gIH07Cj4gIAo+IC0tIAo+IDIuMTkuMgo+CgotLSAKR3JlZ29y
eSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcK
aHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
