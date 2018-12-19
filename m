Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8705EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF7E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwHdJtP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF7E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vp6rAdhWD/2/zTvIIfAtYJnUfJY9qsj19mC70cjJT0Q=; b=AwHdJtP+M9Kow4
	sebjl3xOMd5yYbPIPCpN5KsLC2tzlQFkFURBTKgFm9lxknL+nMLBqqTqlYYCsr6F7eC25Qsn4KMSo
	gaNyXtV58KlZYXHD/K7uMg7P9XaErSUJzKqFgZlZ9IgztLCKRt3sNXK/ctgsvDxjzyiz02D3iR78A
	N+Ex3f2ITjOOz0HChYBlrui6XqIHfKKrkQDhuonle2/QlNNiD6Z8k19gdEhkKJZo1eGnZf1jkWV8i
	oKP0lmEquqjwIyr6tunTifqoiujsQ+5PUobO3n+HZ60dHuHNlDtepXdAueEeGtiWzKIaBUi2SjP+R
	VIEHX1MNJmTXwfTJBFYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZe9C-0003LQ-Eh; Wed, 19 Dec 2018 15:52:34 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZe98-0003KD-4X
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:52:32 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gZe8q-0006dU-M4; Wed, 19 Dec 2018 16:52:12 +0100
Message-ID: <1545234725.5874.38.camel@pengutronix.de>
Subject: Re: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>
Date: Wed, 19 Dec 2018 16:52:05 +0100
In-Reply-To: <20181219141241.GB12763@google.com>
References: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
 <20181219141241.GB12763@google.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_075230_336669_963A765B 
X-CRM114-Status: GOOD (  17.95  )
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
Cc: Sven Van Asbroeck <thesven73@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Niklas Cassel <niklas.cassel@axis.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAxOS4xMi4yMDE4LCAwODoxMiAtMDYwMCBzY2hyaWViIEJqb3JuIEhl
bGdhYXM6Cj4gWytjYyBTdmVuLCBUcmVudCwgZXQgYWwgZnJvbSByZWxhdGVkIHJlcG9ydDoKPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAxODEyMTgyMTA0NDQuNTk1MC0xLVRo
ZVN2ZW43M0Bnb29nbGVtYWlsLmNvbV0KPiAKPiBPbiBGcmksIERlYyAxNCwgMjAxOCBhdCAwNjo0
NDoxNUFNICswMDAwLCBSaWNoYXJkIFpodSB3cm90ZToKPiA+IEFzc2VydGlvbiBvZiB0aGUgTVNJ
IEVuYWJsZSBiaXQgb2YgUkMncyBNU0kgQ0FQIGlzIG1hbmRhdG9yeSByZXF1aXJlZCB0bwo+ID4g
dHJpZ2dlciBNU0kgb24gaS5NWDYgUENJZS4KPiA+IFRoaXMgYml0IHdvdWxkIGJlIGFzc2VydGVk
IHdoZW4gQ09ORklHX1BDSUVQT1JUQlVTPXkuCj4gPiBUaHVzLCB0aGUgTVNJIHdvcmtzIGZpbmUg
b24gaS5NWDYgUENJZSBiZWZvcmUgdGhlIGNvbW1pdCAiZjNmZGZjNCIuCj4gPiAKPiA+IEFzc2Vy
dCBpdCB1bmNvbmRpdGlvbmFsbHkgd2hlbiBNU0kgaXMgZW5hYmxlZC4KPiA+IE90aGVyd2lzZSwg
dGhlIE1TSSB3b3VsZG4ndCBiZSB0cmlnZ2VyZWQgYWx0aG91Z2ggdGhlIEVQIGlzIHByZXNlbnQg
YW5kCj4gPiB0aGUgTVNJcyBhcmUgYXNzaWduZWQuCj4gCj4gT0ssIEkgdGhpbmsgSSBmaW5hbGx5
IHVuZGVyc3RhbmQgbW9zdCBvZiB3aGF0J3MgZ29pbmcgb24uwqDCoFBsZWFzZQo+IGNoZWNrIHRo
ZSBmb2xsb3dpbmcgcG9zc2libGUgY2hhbmdlbG9nIHRleHQ6Cj4gCj4gwqAgVGhlIE1TSSBFbmFi
bGUgYml0IGluIHRoZSBNU0kgQ2FwYWJpbGl0eSAoUENJZSByNC4wLCBzZWMgNy43LjEuMikKPiDC
oCBjb250cm9scyB3aGV0aGVyIGEgRnVuY3Rpb24gY2FuIHJlcXVlc3Qgc2VydmljZSB1c2luZyBN
U0kuCj4gCj4gwqAgaS5NWDYgUm9vdCBQb3J0cyBpbXBsZW1lbnQgdGhlIE1TSSBDYXBhYmlsaXR5
IGFuZCBtYXkgdXNlIE1TSSB0bwo+IMKgIHJlcXVlc3Qgc2VydmljZSBmb3IgZXZlbnRzIGxpa2Ug
UE1FLCBob3RwbHVnLCBBRVIsIGV0Yy7CoMKgSW4KPiDCoCBhZGRpdGlvbiwgb24gaS5NWDYsIHRo
ZSBNU0kgRW5hYmxlIGJpdCBjb250cm9scyBkZWxpdmVyeSBvZiBNU0kKPiDCoCBpbnRlcnJ1cHRz
IGZyb20gY29tcG9uZW50cyBiZWxvdyB0aGUgUm9vdCBQb3J0Lgo+IAo+IMKgIFByaW9yIHRvIGYz
ZmRmYzRhYzNhMiAoIlBDSTogUmVtb3ZlIGhvc3QgZHJpdmVyIEtjb25maWcgc2VsZWN0aW9uIG9m
Cj4gwqAgQ09ORklHX1BDSUVQT1JUQlVTIiksIGVuYWJsaW5nIENPTkZJR19QQ0lfSU1YNiBhdXRv
bWF0aWNhbGx5IGFsc28KPiDCoCBlbmFibGVkIENPTkZJR19QQ0lFUE9SVEJVUywgYW5kIHdoZW4g
cG9ydGRydiBjbGFpbWVkIHRoZSBSb290IFBvcnRzLAo+IMKgIGl0IHNldCB0aGUgTVNJIEVuYWJs
ZSBiaXQgc28gaXQgY291bGQgdXNlIFBNRSwgaG90cGx1ZywgQUVSLCBldGMuCj4gwqAgQXMgYSBz
aWRlIGVmZmVjdCwgdGhhdCBhbHNvIGVuYWJsZWQgZGVsaXZlcnkgb2YgTVNJIGludGVycnVwdHMg
ZnJvbQo+IMKgIGRvd25zdHJlYW0gY29tcG9uZW50cy4KPiAKPiDCoCBBZnRlciBmM2ZkZmM0YWMz
YTIsIHRoZSBpbXg2cS1wY2llIGRyaXZlciBjYW4gb3BlcmF0ZSB3aXRob3V0Cj4gwqAgcG9ydGRy
diwgYnV0IHRoYXQgbWVhbnMgaW14NnEtcGNpZSBtdXN0IHNldCB0aGUgTVNJIEVuYWJsZSBiaXQK
PiDCoCBpdHNlbGYgaWYgZG93bnN0cmVhbSBjb21wb25lbnRzIHVzZSBNU0kuCj4gCj4gwqAgRml4
ZXM6IGYzZmRmYzRhYzNhMiAoIlBDSTogUmVtb3ZlIGhvc3QgZHJpdmVyIEtjb25maWcgc2VsZWN0
aW9uIG9mIENPTkZJR19QQ0lFUE9SVEJVUyIpCj4gCj4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5k
IGV4YWN0bHkgKmhvdyogTVNJIEVuYWJsZSBhZmZlY3RzIE1TSSBmcm9tCj4gZG93bnN0cmVhbSBj
b21wb25lbnRzLCBzaW5jZSB0aGUgZG93bnN0cmVhbSBjb21wb25lbnQganVzdCBkb2VzIGEgRE1B
Cj4gd3JpdGUsIGFuZCB0aGUgUm9vdCBQb3J0IGNhbid0IHRlbGwgd2hldGhlciB0aGUgd3JpdGUg
aXMgdG8gbWVtb3J5IG9yCj4gaW50ZXJydXB0IGNvbnRyb2xsZXIgdW5sZXNzIHRoZSBSb290IFBv
cnQga25vd3Mgd2hlcmUgdGhlIE1TSSB0YXJnZXRzCj4gYXJlLCBlLmcuLCBpZiB0aGUgaW50ZXJy
dXB0IGNvbnRyb2xsZXIgaXMgYWN0dWFsbHkgcGFydCBvZiB0aGUgUkMuCgpUaGUgY29udHJvbGxl
ciB0ZXJtaW5hdGluZyB0aGUgTVNJIHdyaXRlIGlzIHBhcnQgb2YgdGhlIERXQyBQQ0llIGhvc3QK
Y29udHJvbGxlciBvbiBpLk1YNiwgd2hpY2ggaXMgcXVlc3Rpb25hYmxlIGF0IGxlYXN0IHdoZW4g
eW91IHRoaW5rCmFib3V0IGhvdyBhIE1TSSBzaG91bGQgYmUgc2VsZi1zeW5jaHJvbml6aW5nIHRv
IG1lbW9yeSB3cml0ZXMsIGJ1dAp0aGF0J3MgcmVhbGl0eS4uLgoKQXMgdG8gd2h5IHRoZSBjb250
cm9sbGVyIG5lZWRzIHRoZSBNU0kgRW5hYmxlIGJpdCBzZXQsIEkgaGF2ZSBubyBpZGVhLgpCdXQg
dGhlbiB0aGUgRFdDIGNvbnRyb2xsZXIgaXMga25vd24gdG8gaGF2ZSBzb21lIGZ1bmt5IGRlc2ln
bgpsaW1pdGF0aW9ucyByZWdhcmRpbmcgTVNJLCBsaWtlIG5vdCBmb3J3YXJkaW5nIGxlZ2FjeSBQ
Q0kgaW50ZXJydXB0cwphbnltb3JlIHdoZW4gTVNJIGlzIGVuYWJsZWQsIHNvIGl0J3Mgbm90IHRv
dGFsbHkgc3VycHJpc2luZyB0aGF0IHdlCm5lZWQgc29tZSBxdWlya3kgc2V0dXAgaGVyZS4KClJl
Z2FyZHMsCkx1Y2FzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
