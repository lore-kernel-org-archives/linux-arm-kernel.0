Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3AEC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:16:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F033C21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JXW6eIDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F033C21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h3b3G48UmcKD7G/WmtgQYRZqkvzCTBWQn0NTYRdR2Hs=; b=JXW6eIDk9NPeCT
	PSBfywNs5RUaVnhHmsPJBYXxnToSUp/c9zQqYHKBkJX84YQdIZWmd03/45/t0CLOyMUFsL4fvxHpE
	6NGkfUDgFlUfe1pLmGqvZa/pGmN2rrbh7C4kS16ZTz5Mlu5tGbXrdRBIMfpubDT9witGbyDg+23+v
	2rW2nIq8Met597BckXvFgBH5OwRLhEF6PcTkyakfsDS7MhREP8tkb516Im7XXOzZhyDz/gDYn+K7Y
	AYk8UrLQ2R2jAJTvwpL/uYzLAZmTv8gBMjsPCIiqRYG5t7Nb59HnDDAaQ9f2anTC9vD5mZi4kzGIO
	xqU8CYaiPciMaNK4DozA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWnr-0002td-I5; Fri, 01 Feb 2019 11:16:11 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWnm-0002sc-MX; Fri, 01 Feb 2019 11:16:08 +0000
Received: from [192.168.178.52] ([109.104.54.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkHhB-1ha61119dR-00keUY; Fri, 01 Feb 2019 12:15:58 +0100
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
To: Florian Fainelli <f.fainelli@gmail.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
 <10832eda-69a1-1c47-3fe6-7e8da02884d6@gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4ef803bf-2596-845b-1ebe-942478e94325@i2se.com>
Date: Fri, 1 Feb 2019 12:15:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <10832eda-69a1-1c47-3fe6-7e8da02884d6@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:8KW0CsAmAfCrguBSJl0sp32qXC6Z+oRNjRPGJas5oF3ZTVov/z0
 NCCpelW3qpNx907FsOFjPiw9wLBm/F/Rl0I+rFu/Gmj2eiGZBO/3gDWzrXBBi04x/1aPa6c
 RKvQpNs9FGD8Cat/197kIvcgTFOuDUwKrvaihV+G9YMgXJQtYQuN4AsTYNI67ofRor0zdMG
 seLhd0uFOiT93ZRGwBhBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxCQ3PLQtlY=:gREkCXWROINeTPULsGQMa7
 rqCtZsAr50/U4jsQDdsj68aKXFeZCym/KpdTq5Tp1mrjlLQEPjlE0J5iWzrry5EjJrTg+OJoY
 5b0jSKzNVMY0WhXMdfJ4jcGXNFLUvERaZKa7dhFthAuDTxx41Ogvj5hJSSLvQZJ6mmp02aF4L
 Lq+IXoscN+DlfLpKfAqwoRjUOn4oFcXvPNlM1gCWeKtndvPJMcGpqqFEei7EFkwUy9cyu/FS/
 vM9JLON9AgYKSMrjOdNj5KB8fJnFW+Eogttkv9ytLd3YmUDnK3+sNl2rc5+w/5X6mDZFdRu/J
 nWbMM7Ym2hJPFjobImPOBl5GOtm2OryzRnR5EyR680m7G1oMwQUHnp/n4sOjiEghPD2i8vp2r
 rJgP5ivpoqmTKniUJ+CwgbFHw8Zs7Dq7D0a7xKi5jaJTKIvAKD1I/6veDc6oC4+R9eEg2r+3V
 ACNrA0Tf6CqK78Mja359TGRsQgq5HXmQZ4X9mu9QlB4mLaCZdaNDmCd7W9TjyoIPlHwjbH/lK
 TIT116wvAb+0hnpij8hW7DPjkEUzlOgmc4FXVrBMZTxQLDzQ5BOXPSF2fZP+9tiBd/Ze8f4HX
 J1f+L4wRVcMM5+JKpInkExclzpK0omwEDv+RudC77d35x441JAF2e5GGiT7676BM/HFuSTDhC
 ZZQHEACMiD9Slx8ZAvLdaWJsPldLIq9Qc+zzpeM5JjdzcpTeAnhxkxmKZGW/dPyxDLZx4xDam
 Z1UtSu5PKYdS2LuTiHB6fncbQRGXVbaF+evnSLp2Uuw7ZP+hEWb2Njwcgqw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_031607_043388_F4489EB8 
X-CRM114-Status: GOOD (  22.51  )
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
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRmxvcmlhbiwKCkFtIDAxLjAyLjE5IHVtIDA2OjAyIHNjaHJpZWIgRmxvcmlhbiBGYWluZWxs
aToKPgo+IE9uIDEvMzEvMTkgODoxMCBQTSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPj4KPj4g
T24gMS8yOS8xOSAxMDo1MyBBTSwgU3RlZmFuIFdhaHJlbiB3cm90ZToKPj4+IEhpIEZsb3JpYW4s
Cj4+Pgo+Pj4gc29ycnkgZm9yIGJlaW5nIHRoYXQgbGF0ZSBhbmQgaG9waW5nIGl0J3Mgbm90IHRv
byBsYXRlLgo+Pj4KPj4+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmZlZmZk
MTU1MjgzNzcyYmJlNzhjNmEwNWRlYzdjMDEyOGVlNTAwYzoKPj4+Cj4+PiAgIExpbnV4IDUuMC1y
YzEgKDIwMTktMDEtMDYgMTc6MDg6MjAgLTA4MDApCj4+Pgo+Pj4gYXJlIGF2YWlsYWJsZSBpbiB0
aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6Cj4+Pgo+Pj4gICBnaXQ6Ly9naXRodWIuY29tL2FuaG9sdC9s
aW51eCB0YWdzL2JjbTI4MzUtZHQtbmV4dC0yMDE5LTAxLTI5Cj4+Pgo+Pj4gZm9yIHlvdSB0byBm
ZXRjaCBjaGFuZ2VzIHVwIHRvIDE0MTE3ZTBhZjRhODUzYjJiMzc5MjVmNTI2YjJiZmUxY2ZjN2Iy
ODU6Cj4+Pgo+Pj4gICBBUk06IGR0czogYmNtMjgzNS1ycGktemVyby13OiBEcm9wIHVubmVjZXNz
YXJ5IHBpbmN0cmwgKDIwMTktMDEtMjIgMDc6MjU6NTkgKzAxMDApCj4+Pgo+Pj4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
Pj4gVGhpcyBwdWxsIHJlcXVlc3QgYWRkcyB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMgZm9yIHRoZSBu
ZXcgQkNNMjgzNSBQTSBkcml2ZXIsCj4+PiBzdXBwb3J0IGZvciB0aGUgbmV3IFJhc3BiZXJyeSBQ
aSAzIEErIGFuZCB0aGUgbWlzc2luZyBHUElPIGxhYmVscyBmb3IgUlBpIDIvMy4KPj4+IEFkZGl0
aW9uYWxseSBpdCBjb250YWlucyBzb21lIG1pbm9yIERUIGZpeGVzLgo+Pj4KPj4+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
Pj4gTWVyZ2VkIGludG8gZGV2aWNldHJlZS9uZXh0LCB0aGFua3MgU3RlZmFuIQo+IEFuZCBiYWNr
ZWQgb3V0LCBpbnRlZ3JhdGlvbiBmYWlsZWQgd2l0aCB0aGUgZm9sbG93aW5nIHJlc3VsdHM6Cj4K
PiBbWF0gYWlhaWFpIGJ1aWxkIHJlc3VsdHM6Cj4gVGVzdGVkIHRoZSBwYXRjaChlcykgb24gdG9w
IG9mIHRoZSBmb2xsb3dpbmcgY29tbWl0czoKPiBiZmVmZmQxNTUyODMgTGludXggNS4wLXJjMQo+
IDg1ZTFmZmJkNDJmNiBNZXJnZSB0YWcgJ2tidWlsZC12NC4yMS0zJyBvZgo+IGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tYXNhaGlyb3kvbGludXgta2J1aWxk
Cj4gYWM1ZWVkMmI0MTc3IE1lcmdlIGJyYW5jaCAncGVyZi11cmdlbnQtZm9yLWxpbnVzJyBvZgo+
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlwCj4g
NTc0ODIzYmZhYjgyIENoYW5nZSBtaW5jb3JlKCkgdG8gY291bnQgIm1hcHBlZCIgcGFnZXMgcmF0
aGVyIHRoYW4KPiAiY2FjaGVkIiBwYWdlcwo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBG
YWlsZWQgdG8gYnVpbGQgOiAyMjA2NTU1MGMzOTEgQVJNOiBkdHM6IGJjbTI4MzUtcnBpLXplcm8t
dzogRHJvcAo+IHVubmVjZXNzYXJ5IHBpbmN0cmwKPiBDb25maWd1cmF0aW9uOiAibXVsdGlfdjdf
ZGVmY29uZmlnLCBhcmNoaXRlY3R1cmUgYXJtIi4KPgo+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTI4MzUuZHRzaToyOjAsCj4gICAgICAgICAgICAgICAgICBm
cm9tIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTI4MzUtcnBpLWEuZHRzOjM6Cj4gYXJjaC9hcm0vYm9v
dC9kdHMvYmNtMjgzeC5kdHNpOjY6MTA6IGZhdGFsIGVycm9yOgo+IGR0LWJpbmRpbmdzL3NvYy9i
Y20yODM1LXBtLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKPiAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3NvYy9iY20yODM1LXBtLmg+Cj4gICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fgo+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCj4gbWFrZVsyXTogKioqIFthcmNo
L2FybS9ib290L2R0cy9iY20yODM1LXJwaS1hLmR0Yl0gRXJyb3IgMQo+Cj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiBGYWlsZWQgdG8gYnVpbGQgOiAyMjA2NTU1MGMzOTEgQVJNOiBkdHM6IGJj
bTI4MzUtcnBpLXplcm8tdzogRHJvcAo+IHVubmVjZXNzYXJ5IHBpbmN0cmwKPiBDb25maWd1cmF0
aW9uOiAiYmNtMjgzNV9kZWZjb25maWcsIGFyY2hpdGVjdHVyZSBhcm0iLgo+Cj4gSXQgbG9va3Mg
bGlrZSBjb21taXQgIkFSTTogYmNtMjgzeDogU3dpdGNoIFYzRCBvdmVyIHRvIHVzaW5nIHRoZSBQ
TQo+IGRyaXZlciBpbnN0ZWFkIG9mIGZpcm13YXJlLiIgaXMgZmFpbGluZyBoZXJlIGFuZCB3ZSBz
aG91bGQgYWxzbyBoYXZlCj4gInNvYzogYmNtOiBiY20yODM1LXBtOiBBZGQgc3VwcG9ydCBmb3Ig
cG93ZXIgZG9tYWlucyB1bmRlciBhIG5ldwo+IGJpbmRpbmcuIiBwcmVzZW50IGFzIGEgcHJlcmlx
dWlzaXRlIHRvIGJ1aWxkIHRoaXMgYnJhbmNoLgo+Cj4gQWx0ZXJuYXRpdmVseSwgaWYgeW91IHBy
ZWZlciB0byBwdXQgIkFSTTogYmNtMjgzeDogU3dpdGNoIFYzRCBvdmVyIHRvCj4gdXNpbmcgdGhl
IFBNIGRyaXZlciBpbnN0ZWFkIG9mIGZpcm13YXJlLiIgaW4geW91ciBkcml2ZXJzIHB1bGwgcmVx
dWVzdCwKPiB0aGF0IG1pZ2h0IHdvcmsgdG9vLgo+Cj4gSSBoYXZlIGtlcHQgcHVsbCByZXF1ZXN0
IDIgYW5kIDMgYXBwbGllZCBmb3Igbm93LCBsZXQgbWUga25vdyBob3cgeW91Cj4gd2FudCB0byBw
cm9jZWVkLgoKb2ggZGVhci4gSSBhcG9sb2dpemUgZm9yIHRoaXMgY3JhcC4gSSB0aG91Z2h0IHRo
YXQgaSB0ZXN0ZWQgdGhpcyBiZWZvcmUuCgpVbmZvcnR1bmF0ZWx5IG5vbmUgb2YgeW91ciBzdWdn
ZXN0aW9ucyB3b3JrcyB3aXRob3V0IGNvbmZsaWN0cy4gQWxsIHRoZQpQTSBwYXRjaGVzIGRlcGVu
ZCBvbiBlYWNoIG90aGVyLiBTbyBteSBzdWdnZXN0aW9uIGlzIHRvIG1vdmUgYWxsIFBNIHBhdGNo
ZXMgb3V0IG9mIGJjbTI4MzUtZHQtbmV4dCBhbmQgYXBwbHkgdGhlIGZvbGxvd2luZyBvbiB0b3Ag
b2YgYmNtMjgzNS1kcml2ZXJzLW5leHQ6CgpBUk06IGJjbTI4M3g6IEV4dGVuZCB0aGUgV0RUIERU
IG5vZGUgb3V0IHRvIGNvdmVyIHRoZSB3aG9sZSBQTSBibG9jawpBUk06IGJjbTI4M3g6IFN3aXRj
aCBWM0Qgb3ZlciB0byB1c2luZyB0aGUgUE0gZHJpdmVyIGluc3RlYWQgb2YgZmlybXdhcmUuCgpX
b3VsZCBpdCBiZSBhY2NlcHRhYmxlPwoKVGhhbmtzIFN0ZWZhbgoKwqAKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
