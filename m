Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D45C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223EF20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AQ7mcoJW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByRE0rSG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="yJC2B/5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223EF20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O1zfe5I7tTt+JRS3vGB6pIf2eKVgE0M3ZgE/XQQO0YQ=; b=AQ7mcoJWqlJtwv
	Vw0hEXBcwCFwml8bQ1hh+Ceq9yQMbCB5fCzGM6SnHzi9dEWgD61g5PJ6fGmuJjkCl4ufpxT2bJ/No
	6CO3EWhSqxfVsxw5ua91q2Ui3y2whyGH8HHh8MwCkSttbGXcRd5md2ZeziQolju6FbfNZavBTnPjM
	bSxSUME6qqkcGXAxKAmcRtat1tUEy6ZVh62oQSOqaipxMxDX8OZf7syRPqxO+9TBhwefQqkdQTXML
	DTl3eLK1GwG51xv4sKXJtP8/7/1DQTYt0bVl2fT+R15XrXpNC4M4BrXPzaJ/yNdPG7HdnMRuyRjnI
	G7FBJuVqvYpaqGahFdDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZe1j-0007Fc-Fe; Wed, 19 Dec 2018 15:44:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZe1g-00071o-RW
 for linux-arm-kernel@bombadil.infradead.org; Wed, 19 Dec 2018 15:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/IbJcayV0BHyGU1UIVZJJtZqw1GoeG1VHqqTcm/RVw=; b=ByRE0rSGu5KNG8LtImhunIGI4j
 qyIqZkkwhs5Am/Q/IbS5hZTc1SOoa+UH+yXk9etAgSIGEXe0sGQkPxgsC/mMuCso1IMxezb8cU4z0
 Rt3YkLbQ326+VuNaA4YKbppyI4lfxfKfbT443/VFPBbxBKeJlMKFNVslB7XNf6blePQKa0r/s/XQR
 MdfxaBLzwXmn5MmoaYJGUO72lV+ACN6e3rBxO9J/27faE4cdAQYwMtD6BpD2m3d2T4DD7F6uwgpZK
 qvgoaEvnLk+GAu+31OhJ28aJ13UArPiL/0qeKpeGSDdiypT/QBZYRoneFsupFIFX0QOsuh0aLofnF
 ubSH4CSg==;
Received: from mail.nic.cz ([217.31.204.67])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdmI-0001yR-8Y
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:28:56 +0000
Received: from dellmb.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
 by mail.nic.cz (Postfix) with ESMTPS id 80D21631CE;
 Wed, 19 Dec 2018 16:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545233320; bh=BDt8vj+FzsQ9c3tr9yFRMKJVFQFALAU9dKG6n/qJGdo=;
 h=Date:From:To;
 b=yJC2B/5fC9N8Ip7vWaPjItQWJo59MSDnTxwFoXhLlKsdmn0FpEJaJXLPORB7evGVN
 D/5mbRX2u3OBujfP93pbe1wz9LKuvkBfmfXbBwWQ8jAr72X4Czv8hDdaSfKczgvym9
 GA5SefnBUoHmHumklm2hHiMPxzRcqKvDE5zgFH6s=
Date: Wed, 19 Dec 2018 16:28:35 +0100
From: Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181219162835.5ff9c33c@dellmb.labs.office.nic.cz>
In-Reply-To: <20181218144130.3f1a75de@xps13>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <20181217223430.182d01d8@nic.cz>
 <20181218091817.4a8a5d42@xps13> <20181218092314.725af970@xps13>
 <20181218140920.6935db39@nic.cz> <20181218144130.3f1a75de@xps13>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_152854_400334_24438D93 
X-CRM114-Status: GOOD (  20.33  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbmUgdGhpbmcgZm9yIHdoaWNoIEkgd291bGQgbGlrZSB0byBiZSBhYmxlIHRvIGRpc2Fi
bGUgY29tcGh5IGlzIHRoYXQKZWFjaCBjb25zdW1lcyBhYm91dCAxMDBtVyBvZiBwb3dlci4gT24g
VHVycmlzIE1veCB3ZSBjb25maWd1cmUgdGhlCmNvbXBoeXMgdG8gU0dNSUkxLCBQQ0llIGFuZCBV
U0IzIG1vZGVzLiBJZiB0aGVyZSBpcyBubyBVU0IgZGV2aWNlCnBsdWdnZWQsIHRoZSBVU0IzIHBo
eSBjYW4gYmUgZGlzYWJsZWQsIGFuZCBzYXZlIDEwMG1XIG9mIHBvd2VyLiBJZiB0aGUKUENJZSBl
eHRlbnNpb24gbW9kdWxlIGlzIG5vdCBwcmVzZW50LCB0aGUgUENJZSBjYW4gdG9vIGJlIGRpc2Fi
bGVkLCBhbmQKaWYgdGhlcmUgaXMgbm8gc3dpdGNoIG5vciBTRlAgbW9kdWxlIHByZXNlbnQsIHNv
IGNhbiBTR01JSTEuCgpUaGUgb3RoZXIgcmVhc29uIGlzIHRoaXM6IGlmIHRoZSBTR01JSSBwaHkg
aXMgc2V0IHRvIDFHIG1vZGUsIGFuZCB0aGVuCnBvd2VyZWQgb24gc2Vjb25kIHRpbWUgaW4gMi41
RyBtb2RlLCB3aWxsIGl0IHdvcms/IEkgd291bGQgbGlrZSB0bwpwYXRjaCBtdm5ldGEgZHJpdmVy
IHRvIHBvd2VyIG9uL29mZiB0aGUgY29tcGh5LCBpZiB0aGUgZGV2aWNlIG5vZGUgaXMKcHJlc2Vu
dCBpbiBkZXZpY2UgdHJlZS4gQnV0IHRoZW4gdGhlIHN5c3RlbSBjYW4gcmVxdWVzdCBzdWNoIGEg
Y2hhbmdlCihTR01JSSB0byAyNTAwQkFTRS1YIG9yIGJhY2spLgoKTWFyZWsKCk9uIFR1ZSwgMTgg
RGVjIDIwMTggMTQ6NDE6MzAgKzAxMDAKTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290
bGluLmNvbT4gd3JvdGU6Cgo+IEhpIE1hcmVrLAo+IAo+IE1hcmVrIEJlaHVuIDxtYXJlay5iZWh1
bkBuaWMuY3o+IHdyb3RlIG9uIFR1ZSwgMTggRGVjIDIwMTggMTQ6MDk6MjAKPiArMDEwMDoKPiAK
PiA+ID4gWzJdCj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9BUk0tc29mdHdhcmUvYXJtLXRydXN0
ZWQtZmlybXdhcmUvYmxvYi9tYXN0ZXIvZHJpdmVycy9tYXJ2ZWxsL2NvbXBoeS9waHktY29tcGh5
LTM3MDAuYyAgICAKPiA+IAo+ID4gWWVzLCBJIHVzZWQgbWFpbmxpbmUgYXRmIChpdCBkaWQgbm90
IHdvcmsgb3V0IG9mIHRoZSBib3ggd2l0aCAxOC4wOQo+ID4gYXRmLW1hcnZlbGwgb2YgY291cnNl
KS4gQnV0IHRoZXJlIGlzIG5vIF9wb3dlcl9vZmYgZnVuY3Rpb24gZm9yCj4gPiBTR01JSSwgbm9y
IGEgZGlnaXRhbF9yZXNldCBmdW5jdGlvbiBsaWtlIGluIGNwMTEwIGltcGxlbWVudGF0aW9uLiAg
Cj4gCj4gSW5kZWVkLCBidXQgd2h5IHdvdWxkIHlvdSBuZWVkIG9uZT8gSnVzdCB1c2UgdGhlIGhl
bHBlcnMgZnJvbSB0aGUgY29yZQo+IGFuZCBpZiB0aGVyZSBpcyBubyBpbXBsZW1lbnRhdGlvbiwg
bm90aGluZyBzaG91bGQgaGFwcGVuIGFuZCB0aGUKPiBoZWxwZXIgc2hvdWxkIGV4aXQgd2l0aG91
dCBlcnJvci4gSnVzdCBjYWxsCj4gcGh5X3NldF9tb2RlKCkvcGh5X3Bvd2VyX29uKCkgYW4geW91
IHNob3VsZCBiZSBnb29kLgo+IAo+IAo+IFRoYW5rcywKPiBNaXF1w6hsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
