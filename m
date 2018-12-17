Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D32C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:32:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149EC206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ca60qCWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149EC206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qmT6TQtb5pfrvypldir+K8oIdJLtUNwkTOTe40//W0c=; b=Ca60qCWF+tHZdj
	76nG/e4a85om/UX+eB7v53QwbLpl0FKqx9gSGK8+GaRjArAKn2ew5p+c4L2jT+G9ut3PEez/t7U/T
	CZnDX/Lg+MV7rt3i81RtDHXdagIh74oFDUrXR+hGmELJGjMBrC5lzHhwkQhFKgDu1Htbyx4tNK1I5
	plSpnwxPYbyu/HPSjiUETX7GLZUlLOwwGBqMTTMfzdZNz3M/IdsJcJPbv7VWPMKIDUuQxMkvMvdJp
	8LiNPOrAbzxRfY1WLqOG31WjJzVJUktQYOfTPo+AbYCwd5OPZzi3pVu3xrsAzzFuERQbsK0phkjZy
	2SNBoDWyOMJIKIAwJVOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtwH-0001OA-74; Mon, 17 Dec 2018 14:32:09 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtwA-0001Mx-DU
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:32:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id ADBEB2074F; Mon, 17 Dec 2018 15:31:50 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 468AD20711;
 Mon, 17 Dec 2018 15:31:40 +0100 (CET)
Date: Mon, 17 Dec 2018 15:31:40 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 10/12] ARM64: dts: marvell: armada-3720-espressobin:
 declare PCIe reset GPIO
Message-ID: <20181217153140.6d51b9f3@xps13>
In-Reply-To: <20181213153619.499aab66@windsurf>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-11-miquel.raynal@bootlin.com>
 <20181213153306.4fc3b511@xps13> <20181213153619.499aab66@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_063202_589014_58936FD2 
X-CRM114-Status: GOOD (  18.57  )
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
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVGhvbWFzLAoKVGhvbWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNv
bT4gd3JvdGUgb24gVGh1LCAxMyBEZWMKMjAxOCAxNTozNjoxOSArMDEwMDoKCj4gSGVsbG8sCj4g
Cj4gT24gVGh1LCAxMyBEZWMgMjAxOCAxNTozMzowNiArMDEwMCwgTWlxdWVsIFJheW5hbCB3cm90
ZToKPiAKPiA+IEkgd2lsbCByZS1zZW5kIGEgc2VyaWVzIHdpdGhvdXQgdGhpcyBwYXRjaC4gSSB0
aGluayBpdCBkb2VzIG5vdCBodXJ0IHRvCj4gPiBrZWVwIHRoZSBwcmV2aW91cyBwYXRjaCBhZGRp
bmcgdGhlIHBpbm11eCBzZXR0aW5nIGluIHRoZQo+ID4gQXJtYWRhLTM3eHguZHRzaSBmaWxlIGV2
ZW4gd2l0aG91dCB1c2luZyBpdCwgc28gSSB3aWxsIGRyb3Agb25seSB0aGlzCj4gPiBwYXRjaC4g
IAo+IAo+IEkgdGVuZCB0byBkaXNhZ3JlZSBoZXJlIChidXQgcGVyaGFwcyB5b3UnbGwgaGF2ZSBv
dGhlciBhcmd1bWVudHMgdG8KPiBjb252aW5jZSBtZSBvdGhlcndpc2UpOiB0aGUgR1BJTyB1c2Vk
IGZvciBQQ0llIHJlc2V0IGlzIGEgY29tcGxldGVseQo+IGJvYXJkLXNwZWNpZmljIHRoaW5nLiBZ
b3UgY2FuIGNob3NlIHdoYXRldmVyIEdQSU8geW91IHdhbnQsIGFuZCBlYWNoCj4gYm9hcmQgY2Fu
IGJlIGRpZmZlcmVudC4gVGhlcmVmb3JlLCB0aGVyZSBpcyBubyByZWFzb24gdG8gaGF2ZSBzdWNo
IGEKPiBwaW5tdXggY29uZmlndXJhdGlvbiBhdCB0aGUgU29DIGxldmVsICguZHRzaSksIGl0IHNo
b3VsZCBiZSB3aXRoaW4gdGhlCj4gcGFydGljdWxhciBib2FyZCB0aGF0IHVzZXMgdGhhdCBwaW5t
dXggY29uZmlndXJhdGlvbi4KPiAKPiBUaGlzIGlzIGEgcnVsZSB0aGF0IHdlIGhhdmUgYXBwbGll
ZCB0byBtdmVidSBwbGF0Zm9ybXMgaW4gZ2VuZXJhbCwgYW5kCj4gd2hpY2ggSSBiZWxpZXZlIGlz
IGZhaXJseSBjb21tb24gaW4gbWFueSBEVHMuCgpBY3R1YWxseSB0aGlzIGlzIGEgcGluIHRoYXQg
bWF5IGJlIGRyaXZlbiBkaXJlY3RseSBieSB0aGUgUENJIElQIGFuZCBpcwpub3QgYm9hcmQtc3Bl
Y2lmaWMgKG5vdGUgdGhhdCB0aGUgcGF0Y2ggaXMgd3JvbmcgYXMgdGhlIGZ1bmN0aW9ucwpzaG91
bGQgYmUgInBjaWUiIGluc3RlYWQgb2YgImdwaW8iKS4gV2hhdCBpcyBib2FyZCBzcGVjaWZpYyBp
cyBpZiB0aGlzCnBpbiBpcyBhY3R1YWxseSB3aXJlZCB0byB0aGUgZW5kcG9pbnQgUENJZSBjYXJk
IG9yIG5vdC4KCkFueXdheSwgYXMgc2VlbiBieSBHcmVnb3J5LCB0aGUgcGluY3RybCBkcml2ZXIg
bXVzdCBiZSBmaXhlZCBhcyB3aGVuCnNlbGVjdGluZyB0aGUgInBjaWUxIiBncm91cCwgdGhlIGRy
aXZlciB3YXMgcG9raW5nIGFub3RoZXIgYXJlYSBtYWtpbmcKdGhlIEVzcHJlc3NvQmluIHN3aXRj
aCB1bnN0YWJsZS4gV2l0aCBhIHF1aWNrIGZpeCBvbiBteSBzaWRlIEkgcmVhbGl6ZWQKdGhlIHJl
c2V0IHdhcyBub3QgYmVoYXZpbmcgYXQgYWxsIGFzIGV4cGVjdGVkLiBBcyBpdCBpcyBub3QgYWN0
dWFsbHkKbmVlZGVkIGZvciBzdXNwZW5kL3Jlc3VtZSBvcGVyYXRpb24gKGF0IGxlYXN0IG9uIG15
IHNldHVwKSBJIHdpbGwgZHJvcAp0aGUgJ3Jlc2V0IHBpbicgcmVsYXRlZCBwYXRjaGVzIGluIHRo
ZSBuZXh0IGl0ZXJhdGlvbiBvZiB0aGUgc2VyaWVzLgoKClRoYW5rcywKTWlxdcOobAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
