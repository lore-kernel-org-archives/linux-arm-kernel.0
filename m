Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB9C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE6820880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IVCkmKED";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALgvqkAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE6820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTah6bKDNuwTmqUI9q/YNGqZdQtVKoYGa1IUFxzERFg=; b=IVCkmKEDI11V7F
	on/ssASnCgTRDluZpMp8Wx0eXABlzhajXCkTPWXazpvQy/Z3YkcRhF/qoiKQZJqgvoexLyQtJms3r
	9igVdmaLVALcCDtcLFZy/ejqNa+umdy7ajexltgNPzYEvlmpbvUpWHUXp6PVaQSsuMSP2S/AxSxwJ
	2CzwcXGEv521LJkpSMLb9uD33ib0xQaINCz+I4uLK/IpEYVUc5JikEp8OpnWHXRSjd7fkTETCvcnG
	CtmiB76b6UiFEcn2ZzzyQyt0wXfD7rw5mcltpSa0mOk8LXE3gdcnYEAKEdiSn8PN+KYOS0rJIvV5I
	sqOUb+nfx9GHck4HPAOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnBF-00085L-RU; Thu, 21 Feb 2019 12:10:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnBD-00084c-O9; Thu, 21 Feb 2019 12:10:21 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E1282148D;
 Thu, 21 Feb 2019 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550751019;
 bh=ymmvde7Lfspf5r4/2wtRCFM959qVCtgANhlFAOBdeBA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ALgvqkAdlqyN4YXCSPCRH377snHkD2/hGjCSTnHlZW4NKI28hxMEgWXimU/WEIhr0
 EJpTTzWezeR63FPBrc/0f4ZwrwVPlbFcgU7vyD9Oqm3+KJwKlfyLkFtuNlHDwNFSjM
 o0CpgKVmZgBkS3FOi9PAbcF+n8Uc+knsBakG4in4=
Date: Thu, 21 Feb 2019 13:10:13 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 05/27] mtd: nand: Move standard OOB layouts to the
 NAND core
Message-ID: <20190221131013.0cd8e7ba@kernel.org>
In-Reply-To: <20190221124742.322e38ed@xps13>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-6-miquel.raynal@bootlin.com>
 <20190221121900.19d28477@kernel.org>
 <20190221124742.322e38ed@xps13>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_041019_806854_3C012C49 
X-CRM114-Status: GOOD (  17.52  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMSBGZWIgMjAxOSAxMjo0Nzo0MiArMDEwMApNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gSGkgQm9yaXMsCj4gCj4gQm9yaXMgQnJlemls
bG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+IHdyb3RlIG9uIFRodSwgMjEgRmViIDIwMTkKPiAx
MjoxOTowMCArMDEwMDoKPiAKPiA+IE9uIFRodSwgMjEgRmViIDIwMTkgMTE6MDE6NTQgKzAxMDAK
PiA+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4g
ICAKPiA+ID4gVGhlc2UgT09CIGxheW91dHMgYXJlIGdlbmVyaWMgdG8gYWxsIE5BTkQgY2hpcHMs
IHRoZSBzaG91bGQgbm90IGJlCj4gPiA+IHJlc3RyaWN0ZWQgdG8gYmUgdXNlZCBvbmx5IGJ5IHJh
dyBOQU5EIGNvbnRyb2xsZXIgZHJpdmVycy4gVGhleSBtaWdodAo+ID4gPiBsYXRlciBiZSB1c2Vk
IGJ5IGdlbmVyaWMgRUNDIGVuZ2luZXMgYW5kIFNQSS1OQU5EIGRldmljZXMgYXMgd2VsbC4KPiA+
ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9v
dGxpbi5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9jb3JlLmMgICAgICAg
ICAgICAgfCAxNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKyAgICAKPiA+IAo+ID4gQ2Fu
IHdlIHBsYWNlIHRob3NlIGRlZmluaXRpb25zIGluIGVjYy5jIGluc3RlYWQgb2YgY29yZS5jICAK
PiAKPiBSaWdodCBhZnRlciAoYnV0IEkgY2FuIG1vdmUgdGhpcyBwYXRjaCBpbiB0aGUgc2VyaWVz
IGVhc2lseSkgSSBjcmVhdGUgYQo+IGRyaXZlcnMvbXRkL25hbmQvZWNjLyBkaXJlY3Rvcnkgd2l0
aCBhIGVuZ2luZS5jIGZpbGUuIElmIEkgdW5kZXJzdGFuZAo+IHlvdXIgc3VnZ2VzdGlvbiBjb3Jy
ZWN0bHksIHlvdSB3b3VsZCBwcmVmZXIgdG8gaGF2ZSB0aGUgT09CIGxheW91dHMgaW4KPiB0aGlz
IGZpbGUuCgpZZXAuCgo+IAo+ID4gICAKPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRf
YmFzZS5jICAgIHwgMTYxICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gIGRyaXZl
cnMvbXRkL25hbmQvcmF3L25hbmRfdG9zaGliYS5jIHwgICAyICsKPiA+ID4gIGluY2x1ZGUvbGlu
dXgvbXRkL25hbmQuaCAgICAgICAgICAgIHwgICA0ICsKPiA+ID4gIGluY2x1ZGUvbGludXgvbXRk
L3Jhd25hbmQuaCAgICAgICAgIHwgICAzIC0KPiA+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMTY4IGlu
c2VydGlvbnMoKyksIDE2MyBkZWxldGlvbnMoLSkgICAgCj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
