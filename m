Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BF2205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZTHPkB2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BF2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTIjl4w56JgBMedOFRl9ZvU0lJPJ5FuoJ+E/UbevAFg=; b=ZTHPkB2TjnEQq6
	jC7DOHLIJLZe2Q7pF5DW5ltiCZh+gCVQSLeC0a+L8xSU9IuxwHWICKH8ANhlgWFX5I3ouvnlMPw71
	RpGlKIWq8DUYF5TWuD9FuYI0YIhVO0boS+K4ExYuFKolZ6kZU5cOjT+S1Bqo0ZH52BgchR8Z7VPQ2
	zyilj2zlkGKZvvaswpvEXsmmjOfq8QhUL4VNqNVRZMQov5dees4PC/TQ/N5HviSC6y0TBbOvHP5eG
	TP1+FlYHnzJnFx0QWw+RdHmH8xNcrQiKfjZuV8Oexm7G89lqKq+gB1iGmxmmb42Tlu4lS5QajZmW8
	5zOaNjTNVguy0Y3MYuhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAUT-0003uf-8q; Tue, 18 Dec 2018 08:12:33 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAUP-0003tL-CF
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:12:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2EB2820AB1; Tue, 18 Dec 2018 09:12:16 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id BBEF920834;
 Tue, 18 Dec 2018 09:12:05 +0100 (CET)
Date: Tue, 18 Dec 2018 09:12:05 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181218091205.04588033@xps13>
In-Reply-To: <87zht480v5.fsf@tkos.co.il>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
 <20181212102142.16053-4-miquel.raynal@bootlin.com>
 <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz>
 <20181217170724.58421a29@xps13> <87zht480v5.fsf@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_001229_746652_7EA9233A 
X-CRM114-Status: GOOD (  15.59  )
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
 Marek Behun <marek.behun@nic.cz>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydWNoLAoKQmFydWNoIFNpYWNoIDxiYXJ1Y2hAdGtvcy5jby5pbD4gd3JvdGUgb24gTW9u
LCAxNyBEZWMgMjAxOCAyMDoyNzo0MgorMDIwMDoKCj4gSGkgTWlxdWVsLAo+IAo+IE1pcXVlbCBS
YXluYWwgd3JpdGVzOgo+ID4gTWFyZWsgQmVodW4gPG1hcmVrLmJlaHVuQG5pYy5jej4gd3JvdGUg
b24gRnJpLCAxNCBEZWMgMjAxOCAwMTo1NzoxMgo+ID4gKzAxMDA6Cj4gPiAgCj4gPj4gT24gRnJp
LCAxNCBEZWMgMjAxOCAwMTo0NzowMSArMDEwMAo+ID4+IE1hcmVrIEJlaHVuIDxtYXJlay5iZWh1
bkBuaWMuY3o+IHdyb3RlOgo+ID4+ICAgCj4gPj4gPiBhcmUgdGhlcmUgYWxyZWFkeSBwYXRjaGVz
IGZvciB0aGUgQTM3eHggY29tcGh5IGRyaXZlcj8gICAgCj4gPgo+ID4gUGxlYXNlIHRyeSB0aGUg
bGF0ZXN0IHBhdGNoZXMgb24gdG9wIG9mIHBoeSAtbmV4dCAod2l0aCBQSFkgaW50ZXJmYWNlCj4g
PiBtb2RlKSwgYXZhaWxhYmxlIHRoZXJlIFsxXS4gWW91IGNhbiBwaWNrIG9ubHkgdGhlIENPTVBI
WSBwYXRjaGVzLCBidXQKPiA+IGtlZXAgdGhlbSBvdmVyIHRoZSBwaHkgLW5leHQgYnJhbmNoLgo+
ID4KPiA+IFBsZWFzZSBub3RlIHRoYXQgZm9yIHRoZSBTTUMgY2FsbHMgdG8gc3VjY2VlZCB5b3Ug
bXVzdCB1c2UgYSByZWNlbnQKPiA+IEFURi4gUGVyc29uYWxseSBJIHVzZWQgdG8gd29yayB3aXRo
IHRoZSAnYXRmLXYxLjUtZGV2ZWwnIGJyYW5jaCBvZgo+ID4gTWFydmVsbCdzIG1pc2wtYXRmIHJl
cG9zaXRvcnkgYnV0IGl0IGlzIG5vdCBhdmFpbGFibGUgYW55bW9yZS4gSWYgeW91Cj4gPiBhbHJl
YWR5IGhhdmUgYSBjbG9uZSwgdGhlbiB5b3UgYXJlIGdvb2QgdG8gZ28sIG90aGVyd2lzZSBpdCBt
aWdodCBiZQo+ID4gZ3JlYXQgaWYgc29tZW9uZSBmcm9tIE1hcnZlbGwgY291bGQgc2hhcmUgYSBw
dWJsaWMgR2l0aHViIGxpbms/ICAKPiAKPiBUaGUgbGF0ZXN0IEFURiBmcm9tIE1hcnZlbGwgaXMg
YXQgdGhlICdhdGYtdjEuNS1hcm1hZGEtMTguMDknIGJyYW5jaCBhdAo+IAo+ICAgaHR0cHM6Ly9n
aXRodWIuY29tL01hcnZlbGxFbWJlZGRlZFByb2Nlc3NvcnMvYXRmLW1hcnZlbGwKCkluZGVlZCwg
YnV0IEkgZG9uJ3Qgc2VlIEEzNzAwIENPTVBIWSBzdXBwb3J0IHRoZXJlIChvbmx5IENQMTEwJ3Mp
LCBJCnRoaW5rIGl0IHdpbGwgYmUgbWVyZ2VkIGludG8gMTguMTIgcmVsZWFzZSAod2lsbCBoYXBw
ZW4gdGhpcyBtb250aCkuCgoKVGhhbmtzLApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
