Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F4C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:33:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0815020839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T9SgB+V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0815020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CtrQd6aT4AI9Xm/7Hu4Jr1LM/9YyJyKckC80J+vLzYs=; b=T9SgB+V1jxWjK0
	ycpF9YGI5c04kHma7yt9Zm42b5JmeRGr813KD4HUpsybHB8vkSaICDefST2h4tS9+DjN2hYKQo3WH
	c9c7GYv3eM/YRz4rK3qik+SVM7A6IRuAFd1uVd2e4ZhIw8+tUh/Gn8KnUjbHPyHn/s+uFbbwmJY1F
	ClMPuJ4CfavtprhMAQoNJ6gQD01eproe9tAHiJjBrkxDq+QQ/q6w0+LIF677fG5XsCQquWW6tVFWn
	EcLsz4Jg9uuUrPT0hFilZvrv1gGxUGbtW9hi5CSi4WmlN6He1NrfVcuGR1oMWXUnOP62x1rzqw8Bd
	Wm7okc+SgKURgkJEjO4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0t8-0001aR-9D; Wed, 12 Dec 2018 09:33:06 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0t4-0001YY-J0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:33:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2E2F620763; Wed, 12 Dec 2018 10:32:50 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9525020731;
 Wed, 12 Dec 2018 10:32:39 +0100 (CET)
Date: Wed, 12 Dec 2018 10:32:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: ap806: document the thermal
 interrupt capabilities
Message-ID: <20181212103239.57532f17@xps13>
In-Reply-To: <20181210230354.GA1503@bogus>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
 <20181204190332.10351-4-miquel.raynal@bootlin.com>
 <20181210230354.GA1503@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_013302_899373_B858CFB2 
X-CRM114-Status: GOOD (  19.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Eduardo Valentin <edubezval@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGUgb24gTW9uLCAxMCBE
ZWMgMjAxOCAxNzowMzo1NCAtMDYwMDoKCj4gT24gVHVlLCBEZWMgMDQsIDIwMTggYXQgMDg6MDM6
MjlQTSArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IFRoZSB0aGVybWFsIElQIGNhbiBw
cm9kdWNlIGludGVycnVwdHMgb24gb3ZlcmhlYXQgc2l0dWF0aW9uLgo+ID4gRGVzY3JpYmUgdGhl
bS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBi
b290bGluLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcDgwNi1z
eXN0ZW0tY29udHJvbGxlci50eHQgICAgICB8IDggKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXA4MDYtc3lzdGVtLWNvbnRyb2xsZXIudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FwODA2LXN5
c3RlbS1jb250cm9sbGVyLnR4dAo+ID4gaW5kZXggM2ZkMjFiYjdjYjM3Li4zNWU4ZGQyZWRmZDIg
MTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21h
cnZlbGwvYXA4MDYtc3lzdGVtLWNvbnRyb2xsZXIudHh0Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXA4MDYtc3lzdGVtLWNvbnRyb2xsZXIu
dHh0Cj4gPiBAQCAtMTE0LDEyICsxMTQsMTggQEAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQKPiA+ICBUaGUgdGhlcm1hbCBJUCBjYW4gcHJvYmUg
dGhlIHRlbXBlcmF0dXJlIGFsbCBhcm91bmQgdGhlIHByb2Nlc3Nvci4gSXQKPiA+ICBtYXkgZmVh
dHVyZSBzZXZlcmFsIGNoYW5uZWxzLCBlYWNoIG9mIHRoZW0gd2lyZWQgdG8gb25lIHNlbnNvci4K
PiA+ICAKPiA+ICtJdCBpcyBwb3NzaWJsZSB0byBzZXR1cCBhbiBvdmVyaGVhdCBpbnRlcnJ1cHQg
YnkgZ2l2aW5nIGF0IGxlYXN0IG9uZQo+ID4gK2NyaXRpY2FsIHBvaW50IHRvIGFueSBzdWJub2Rl
IG9mIHRoZSB0aGVybWFsLXpvbmUgbm9kZS4KPiA+ICsKPiA+ICBSZXF1aXJlZCBwcm9wZXJ0aWVz
Ogo+ID4gIC0gY29tcGF0aWJsZTogbXVzdCBiZSBvbmUgb2Y6Cj4gPiAgICAqIG1hcnZlbGwsYXJt
YWRhLWFwODA2LXRoZXJtYWwKPiA+ICAtIHJlZzogcmVnaXN0ZXIgcmFuZ2UgYXNzb2NpYXRlZCB3
aXRoIHRoZSB0aGVybWFsIGZ1bmN0aW9ucy4KPiA+ICAKPiA+ICBPcHRpb25hbCBwcm9wZXJ0aWVz
Ogo+ID4gKy0gaW50ZXJydXB0LXBhcmVudC9pbnRlcnJ1cHRzOiBvdmVyaGVhdCBpbnRlcnJ1cHQg
aGFuZGxlLiBTaG91bGQgcG9pbnQgdG8KPiA+ICsgIGxpbmUgMTggb2YgdGhlIFNFSSBpcnFjaGlw
Lgo+ID4gKyAgU2VlIGludGVycnVwdC1jb250cm9sbGVyL2ludGVycnVwdHMudHh0ICAKPiAKPiBE
b24ndCBkb2N1bWVudCBpbnRlcnJ1cHQtcGFyZW50IGFzIGl0IGlzIGltcGxpZWQgYW5kIG1heSBi
ZSBpbiBhIHBhcmVudCAKPiBub2RlLgoKU3VyZSwgSSB3aWxsIHNlbmQgYSB2NC4KCj4gCj4gPiAg
LSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6IHNoYWxsIGJlIDwxPiB3aGVuIHRoZXJtYWwtem9uZXMg
c3Vibm9kZXMgcmVmZXIKPiA+ICAgIHRvIHRoaXMgSVAgYW5kIHJlcHJlc2VudHMgdGhlIGNoYW5u
ZWwgSUQuIFRoZXJlIGlzIG9uZSBzZW5zb3IgcGVyCj4gPiAgICBjaGFubmVsLiBPIHJlZmVycyB0
byB0aGUgdGhlcm1hbCBJUCBpbnRlcm5hbCBjaGFubmVsLCB3aGlsZSBwb3NpdGl2ZQo+ID4gQEAg
LTEzMyw2ICsxMzksOCBAQCBhcF9zeXNjb24xOiBzeXN0ZW0tY29udHJvbGxlckA2ZjgwMDAgewo+
ID4gIAlhcF90aGVybWFsOiB0aGVybWFsLXNlbnNvckA4MCB7Cj4gPiAgCQljb21wYXRpYmxlID0g
Im1hcnZlbGwsYXJtYWRhLWFwODA2LXRoZXJtYWwiOwo+ID4gIAkJcmVnID0gPDB4ODAgMHgxMD47
Cj4gPiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZzZWk+Owo+ID4gKwkJaW50ZXJydXB0cyA9IDwx
OD47Cj4gPiAgCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47Cj4gPiAgCX07Cj4gPiAgfTsK
PiA+IC0tIAo+ID4gMi4xOS4xCj4gPiAgIAoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
