Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E590C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:54:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D296720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cGapcfKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YTXgGsHIUy1xeXxCNFw7BI423DFu+zvhFl3essagjZg=; b=cGapcfKPM9HRnc
	AKyAFzEz0DG30Sy8miOelX6yQKqJ5FTW2hQ0eTUBpKkoF5TADqkuI2KkOneYRI9JL0Hx0YPcMRs3m
	r2K5tLOmuzLHOm31mtryUy9DZp3uS/PO27XR2bdlezLL/fd7ptPsbZEKrotFwe7BVry5TOj+hIAKe
	gpjT6dl2InHz3R45qsTCXZm42dQA2XeO5k/dbd+mQVf+bTFs5fHOohBhLPQ3S6xiHecquyKOBraix
	VWcLclFY1gRP1Gv8lfxlLIclIdIssszSNgBa0L80rt05J968RHe2TohHGL1QWvt8vW3IOFtpMQWc0
	K2huRK/7LsRl1HFZX09g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnrZ-0000qo-Je; Thu, 21 Feb 2019 12:54:05 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnrW-0000qK-6q; Thu, 21 Feb 2019 12:54:03 +0000
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id C5E7620001A;
 Thu, 21 Feb 2019 12:53:48 +0000 (UTC)
Date: Thu, 21 Feb 2019 13:53:47 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 09/27] mtd: nand: ecc: Turn the software BCH
 implementation generic
Message-ID: <20190221135347.4726f14e@xps13>
In-Reply-To: <20190221132652.417f0c5d@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-10-miquel.raynal@bootlin.com>
 <20190221132652.417f0c5d@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045402_397241_68D7988C 
X-CRM114-Status: GOOD (  12.78  )
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

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxMzoyNjo1MiArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMTowMTo1OCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+IAo+ID4gIC8qKgo+ID4gLSAqIG5hbmRfYmNoX2NvcnJlY3RfZGF0YSAt
IFtOQU5EIEludGVyZmFjZV0gRGV0ZWN0IGFuZCBjb3JyZWN0IGJpdCBlcnJvcihzKQo+ID4gLSAq
IEBjaGlwOglOQU5EIGNoaXAgb2JqZWN0Cj4gPiAtICogQGJ1ZjoJcmF3IGRhdGEgcmVhZCBmcm9t
IHRoZSBjaGlwCj4gPiAtICogQHJlYWRfZWNjOglFQ0MgZnJvbSB0aGUgY2hpcAo+ID4gLSAqIEBj
YWxjX2VjYzoJdGhlIEVDQyBjYWxjdWxhdGVkIGZyb20gcmF3IGRhdGEKPiA+ICsgKiBlY2Nfc3df
YmNoX2NvcnJlY3QgLSBEZXRlY3QsIGNvcnJlY3QgYW5kIHJlcG9ydCBiaXQgZXJyb3IocykKPiA+
ICAgKgo+ID4gLSAqIERldGVjdCBhbmQgY29ycmVjdCBiaXQgZXJyb3JzIGZvciBhIGRhdGEgYnl0
ZSBibG9jawo+ID4gKyAqIEBuYW5kOiBOQU5EIGRldmljZQo+ID4gKyAqIEBidWY6IFJhdyBkYXRh
IHJlYWQgZnJvbSB0aGUgY2hpcAo+ID4gKyAqIEByZWFkX2VjYzogRUNDIGJ5dGVzIGZyb20gdGhl
IGNoaXAKPiA+ICsgKiBAY2FsY19lY2M6IEVDQyBjYWxjdWxhdGVkIGZyb20gdGhlIHJhdyBkYXRh
Cj4gPiArICoKPiA+ICsgKiBEZXRlY3QgYW5kIGNvcnJlY3QgYml0IGVycm9ycyBmb3IgYSBkYXRh
IGJsb2NrLgo+ID4gICAqLwo+ID4gLWludCBuYW5kX2JjaF9jb3JyZWN0X2RhdGEoc3RydWN0IG5h
bmRfY2hpcCAqY2hpcCwgdW5zaWduZWQgY2hhciAqYnVmLAo+ID4gLQkJCSAgdW5zaWduZWQgY2hh
ciAqcmVhZF9lY2MsIHVuc2lnbmVkIGNoYXIgKmNhbGNfZWNjKQo+ID4gK2ludCBlY2Nfc3dfYmNo
X2NvcnJlY3Qoc3RydWN0IG5hbmRfZGV2aWNlICpuYW5kLCB1bnNpZ25lZCBjaGFyICpidWYsCj4g
PiArCQkgICAgICAgdW5zaWduZWQgY2hhciAqcmVhZF9lY2MsIHVuc2lnbmVkIGNoYXIgKmNhbGNf
ZWNjKSAgCj4gCj4gSSdkIGtlZXAgdGhlIG5hbmRfIHByZWZpeCwgYXMgRUNDIGlzIGVtcGxveWVk
IGluIG90aGVyIHBsYWNlcyBpbiB0aGUKPiBrZXJuZWwgYW5kIGhlcmUgdGhlIEFQSSBpcyBjbGVh
cmx5IHRpZWQgdG8gdGhlIG5hbmRfZGV2aWNlIG9iamVjdC4KCkkgaGFkIGEgbG9vb25nIGludGVy
bmFsIGNvbmZsaWN0IGFib3V0IGl0LiBJdCdzIGxvbmdlciB3aXRoIG5hbmRfIGJ1dAp5b3UgYXJl
IHJpZ2h0IGl0IGlzIHRpZWQgdG8gdGhlIE5BTkQgY29yZSwgc28gSSdsbCBkbyB0aGUgY2hhbmdl
LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
