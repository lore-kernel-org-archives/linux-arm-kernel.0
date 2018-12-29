Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:06:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0B12184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k0zyp9gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B12184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnG5g5ydW90eNKKzVyVxw85jXKvXgUiFAFRmS5CnWrg=; b=k0zyp9gx1SsXsP
	f7O/oMqRVtC5ZxDuj5L5cKU/Hn2xt8MCc8MAUy14zgm5IW9HSxXdgWjE8wgJ6ISK+eBkaLR1aEpbn
	kVUuZL+vaBM+257sNmjtShMJA3IUbLZGM7fg7DVAgD2/gqRG5QrLcDOLJzJXxvPcJtpemHm/0yM60
	bjJaFlC5d5b53T890o4NAnRGf4bo3PfgUWpxUxT7CtZWzDMqXsmDLEvGXjey6mCIoaMIvXx16Y5+e
	N90044GTTsoXjpq39JbTzNx4nmjdmrACpgm8f/hCK+NzOf0//OK+wv9A62VYH8iWhi817PXq6JIMC
	QW1tWnvQUj7j163IZajw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd28k-0003Lu-R9; Sat, 29 Dec 2018 00:06:06 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd28g-0003L9-2f; Sat, 29 Dec 2018 00:06:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 32A2FAF3F;
 Sat, 29 Dec 2018 00:05:47 +0000 (UTC)
Subject: Re: [PATCH RFC lora-next 1/4] net: lora: sx125x sx1301: correct style
 warnings
To: Ben Whitten <ben.whitten@gmail.com>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-2-ben.whitten@lairdtech.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <62a3e030-98eb-3e63-d193-092b319bd4b1@suse.de>
Date: Sat, 29 Dec 2018 01:05:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181219155616.9547-2-ben.whitten@lairdtech.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_160602_419311_121ABF99 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: jiri@resnulli.us, Ben Whitten <ben.whitten@lairdtech.com>,
 netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
 linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmVuLAoKQW0gMTkuMTIuMTggdW0gMTY6NTYgc2NocmllYiBCZW4gV2hpdHRlbjoKPiBDaGVj
a3BhdGNoIGhpZ2hsaWdodHMgc29tZSBzdHlsZSBpc3N1ZXMgd2hpY2ggbmVlZCB0byBiZSBhZGRy
ZXNzZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQmVuIFdoaXR0ZW4gPGJlbi53aGl0dGVuQGxhaXJk
dGVjaC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L2xvcmEvc3gxMjV4LmMgfCAyMCArKysrKysr
KystLS0tLS0KPiAgZHJpdmVycy9uZXQvbG9yYS9zeDEzMDEuYyB8IDUyICsrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+ICBkcml2ZXJzL25ldC9sb3JhL3N4MTMwMS5oIHwg
IDcgKysrLS0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRp
b25zKC0pCgpUaGFua3MgZm9yIHNwbGl0dGluZyB0aGlzIG9mZiBmcm9tIHRoZSBmdW5jdGlvbmFs
IGNoYW5nZXMuIFRoaXMgd2lsbApuZWVkIHNvbWUgbW9yZSBleHBsYW5hdGlvbnMgYW5kIGRpc2N1
c3Npb24uIEluIHBhcnRpY3VsYXIgdGhlIGNvbW1lbnQKY2hhbmdlcyBsb29rIHdyb25nIHRvIG1l
LiBBbHNvIHBsZWFzZSBkb24ndCBidXRjaGVyIGNvZGUganVzdCBiZWNhdXNlCmNoZWNrcGF0Y2gu
cGwgbWF5IHdhcm4gYWJvdXQgbGluZSBsZW5ndGggYXQgdGhpcyBlYXJseSBzdGFnZS4KCkEgZ29v
ZCBjYXRjaCBpbiB0aGVyZSB3YXMgdGhlIHVuc2lnbmVkIGNhc3RzLCB3aGljaCBhcmUgbm8gbG9u
Z2VyCm5lY2Vzc2FyeSBzaW5jZSB0aGUgcmVnbWFwIGNvbnZlcnNpb24sIHNvIHdlIHNob3VsZCBq
dXN0IHNxdWFzaCB0aGF0CmludG8gdGhlIGVhcmxpZXIgY29tbWl0cy4KCk5vdGUgdGhhdCBJIHVz
ZWQgdG8gcnVuIGNoZWNrcGF0Y2gucGwgYXMgZ2l0IGNvbW1pdCBob29rOgpodHRwOi8vYmxvZy52
bXNwbGljZS5uZXQvMjAxMS8wMy9ob3ctdG8tYXV0b21hdGljYWxseS1ydW4tY2hlY2twYXRjaHBs
Lmh0bWwKQnV0IHNpbmNlIHNvbWUgZ2l0IHVwZGF0ZSB0aGF0IHN0YXJ0ZWQgdG8gYnJlYWsgZ2l0
IHJlYmFzZSAtaSBpbiBjYXNlIG9mCmZhbHNlIHBvc2l0aXZlcyAod2l0aCByZWJhc2Ugc3RvcHBp
bmcgYW5kIG9uIHRyeWluZyB0byBjb250aW51ZSBjb21taXRzCnVuaW50ZW50aW9uYWxseSBnZXR0
aW5nIHNxdWFzaGVkKSwgc28gSSBkZWFjdGl2YXRlZCBpdCBhZ2FpbiBhbmQgZG9uJ3QKbWFudWFs
bHkgY2hlY2sgZWFjaCBjb21taXQgSSBzdGFnZSBhbnltb3JlLCBpbiBmYXZvciBvZiBzbG93bHkK
Y29tcGxldGluZyBpbXBsZW1lbnRhdGlvbnMgdG8gYSB3b3JraW5nIHBvaW50LgoKUmVnYXJkcywK
QW5kcmVhcwoKLS0gClNVU0UgTGludXggR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnLCBHZXJtYW55CkdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhh
bSBOb3J0b24KSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
