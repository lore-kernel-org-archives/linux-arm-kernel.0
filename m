Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46C82084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Chr7G5Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46C82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rnehI/Mm6Rhqrds8AbDRfMcyv9k6k//Ly5NZ+E0jtlQ=; b=Chr7G5Wi2MtE23
	+9xhtaOcWCaBgSfPO3vWpLPhqjQ3JwaJfScp97YvORLKM7qS7W3lFGg8D7Frtts+ttIFZmk8u8i+T
	4MM/XJIEWc11IPpGwWoK5tl91ABE3OTDd7paVDzQZxWPNNSPdUheaV2MiTgb7AMQjPIWMNV9DhAff
	StnA3eu2b2DdReiPKPo9oAVUCebpXEsxbm/nbLIt5zKIJq+lZOBGNcxlT3nDMn6S4C+0noqHkMw9A
	p8qt2JUwfBSc32oAi19kOqmYvC17nqV8f1PZ56BZVmqPErQoO4E/FJX7Da1Ff1Gb0cRBmQhbxL4Gw
	ZIAgh7RwxwnzgLk/kYRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWzap-0006TS-R1; Wed, 12 Dec 2018 08:10:07 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWzah-0006Ce-HH
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 08:10:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BE45E2073D; Wed, 12 Dec 2018 09:09:47 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 886C220733;
 Wed, 12 Dec 2018 09:09:37 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] arm64: dts: marvell: mcbin: fix PCIe reset signal
References: <8a9652066a649b5349b76c823bef946024161275.1544441887.git.baruch@tkos.co.il>
 <87efaot70c.fsf@bootlin.com> <87bm5s6le6.fsf@tkos.co.il>
Date: Wed, 12 Dec 2018 09:09:38 +0100
In-Reply-To: <87bm5s6le6.fsf@tkos.co.il> (Baruch Siach's message of "Tue, 11
 Dec 2018 19:09:05 +0200")
Message-ID: <87sgz3rwsd.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_000959_703869_5F1D4A02 
X-CRM114-Status: GOOD (  19.00  )
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

SGkgQmFydWNoLAoKKGFkZGluZyBBcm5kIGFuZCBPbG9mKQogCiBPbiBtYXIuLCBkw6ljLiAxMSAy
MDE4LCBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPiB3cm90ZToKCj4gSGkgR3JlZ29y
eSwKPgo+IEdyZWdvcnkgQ0xFTUVOVCB3cml0ZXM6Cj4+ICBPbiBsdW4uLCBkw6ljLiAxMCAyMDE4
LCBCYXJ1Y2ggU2lhY2ggPGJhcnVjaEB0a29zLmNvLmlsPiB3cm90ZToKPj4KPj4+IFRoZSBNUFA1
MiBzaWduYWwgaXMgb24gdGhlIHNlY29uZHMgR1BJTyBpbnN0YW5jZSBvZiBDUDAsIHdoaWNoCj4+
PiBjb3JyZXNwb25kcyB0byB0aGUgJmNwMF9ncGlvMiBoYW5kbGUuCj4+Pgo+Pj4gUmVuYW1lIHRo
ZSBwcm9wZXJ0eSBuYW1lIHRvIHRoZSBzdGFuZGFyZCAnLWdwaW9zJyBzdWZmaXggd2hpbGUgYXQg
aXQuCj4+Pgo+Pj4gRml4ZXM6IGI4M2UxNjY5YWRjZTYgKCJhcm02NDogZHRzOiBtYXJ2ZWxsOiBt
Y2JpbjogYWRkIHN1cHBvcnQgZm9yIFBDSWUiKQo+Pj4gU2lnbmVkLW9mZi1ieTogQmFydWNoIFNp
YWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4KPj4KPj4gV2l0aCB0aGUgbGFzdCBjaGFuZ2UgaW4gYXJt
YWRhLTgwNDAtbWNiaW4uZHRzIHRoaXMgcGF0Y2ggbm8gbW9yZSBhcHBseQo+PiBvbiBtdmVidS9k
dDY0Lgo+Cj4gSSB0aG91Z2h0IHRoYXQgdGhpcyBmaXggc2hvdWxkIGdvIHRvIDQuMjAuIEkgd2ls
bCBnZW5lcmF0ZSBhIHBhdGNoIGFnYWluc3QKPiBtdmVidS9kdDY0IGlmIHlvdSBwcmVmZXIuCgpB
Y3R1YWxseSBJIGNhbiBhcHBseSBpdCBvbiBtdmVidS9maXhlcyBidXQgbGF0ZXIgd2hlbiBhbGwg
dGhlIG12ZWJ1IHdpbGwKYmUgbWVyZ2VkIGluIHRoZSBMaW51cyBUb3J2YWxkJ3MgdHJlZSB0aHJv
dWdoIHRoZSBhcm0tc29jIHRyZWUgdGhlcmUKd2lsbCBiZSBhIGNvbmZsaWN0LgoKQXJuZCwgT2xv
ZiwKCkhvdyBzaG91bGQgSSBoYW5kbGUgdGhpcyBzaXR1YXRpb24/CgpJcyBpdCBhY2NlcHRhYmxl
IHRvIGRvIGEgcHVsbCByZXF1ZXN0IG9mIGFuIG12ZWJ1L2R0NjQgYnJhbmNoIGJhc2VkIG9uCnRo
ZSBtdmVidS9maXhlcyBicmFuY2g/CgpJbiB0aGlzIGNhc2UgSSBjb3VsZCBhbWVuZCB0aGUgY29t
bWl0IGluIG12ZWJ1L2R0NjQgdG8gZml4IHRoZSBjb25mbGljdC4KCkdyZWdvcnkKCj4KPiBiYXJ1
Y2gKPgo+Pj4gLS0tCj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQw
LW1jYmluLmR0cyB8IDIgKy0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2
ZWxsL2FybWFkYS04MDQwLW1jYmluLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtODA0MC1tY2Jpbi5kdHMKPj4+IGluZGV4IDU2ZmE0NDg2MDkwOS4uNDZkYWNmYzA4Y2Vj
IDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQw
LW1jYmluLmR0cwo+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04
MDQwLW1jYmluLmR0cwo+Pj4gQEAgLTE4Myw3ICsxODMsNyBAQAo+Pj4gIAlwaW5jdHJsLTAgPSA8
JmNwMF9wY2llX3BpbnM+Owo+Pj4gIAludW0tbGFuZXMgPSA8ND47Cj4+PiAgCW51bS12aWV3cG9y
dCA9IDw4PjsKPj4+IC0JcmVzZXQtZ3BpbyA9IDwmY3AwX2dwaW8xIDIwIEdQSU9fQUNUSVZFX0xP
Vz47Cj4+PiArCXJlc2V0LWdwaW9zID0gPCZjcDBfZ3BpbzIgMjAgR1BJT19BQ1RJVkVfTE9XPjsK
Pj4+ICAJc3RhdHVzID0gIm9rYXkiOwo+Pj4gIH07Cj4KPiAtLSAKPiAgICAgIGh0dHA6Ly9iYXJ1
Y2guc2lhY2gubmFtZS9ibG9nLyAgICAgICAgICAgICAgICAgIH4uIC5+ICAgVGsgT3BlbiBTeXN0
ZW1zCj4gPX0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1v
b08tLVUtLU9vby0tLS0tLS0tLS0tLXs9Cj4gICAgLSBiYXJ1Y2hAdGtvcy5jby5pbCAtIHRlbDog
Kzk3Mi41Mi4zNjguNDY1NiwgaHR0cDovL3d3dy50a29zLmNvLmlsIC0KCi0tIApHcmVnb3J5IENs
ZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRw
Oi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
