Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE5DC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:07:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B812175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CuwXQQr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B812175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O66v6uRbchG3OCCjXr/O2df+Ca983RtFXGvCdhE1RyU=; b=CuwXQQr6TuzXdV
	fm+w/vylOUHuI/VEmrCW+9GTIuirFLrP+C4+zTgddI5uyCko77y+d3r3+3bitq0rnLDPtb2ABsdrV
	eHKOM4pnvecf+Trv3u4sybfj112YYJWUqsxQ4kecfzUSCyoCtUJ0Brb7uY/Zm9Cw3+YAlWpxBySw7
	uujizwjbpjG/nvqWhGjJrGds+R9+mnYYIVcTPLulMK7fZQI0s0OwTfjo4T8EoJ9BjrV/gj96e+A8V
	eskpHdrOM7GFcqDpLCJ/RSG0sTazp1Ht6s4ALd2RYMaAO4MIaHzxcOwCIs/Y9cyUXAq0+7PRWV1Y6
	O7vaJ+X3TGOnwOYVRmvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr649-0001PZ-Nw; Tue, 05 Feb 2019 19:07:29 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr63Y-0000vi-Tv; Tue, 05 Feb 2019 19:07:24 +0000
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1FA64240009;
 Tue,  5 Feb 2019 19:06:42 +0000 (UTC)
Date: Tue, 5 Feb 2019 20:06:41 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: meson: Fix linking error on 32-bit platforms
Message-ID: <20190205200641.1c97f9fe@xps13>
In-Reply-To: <20190129214657.5877-1-natechancellor@gmail.com>
References: <20190129214657.5877-1-natechancellor@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_110653_430271_42F52BAE 
X-CRM114-Status: UNSURE (   7.83  )
X-CRM114-Notice: Please train this message.
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
Cc: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Liang Yang <liang.yang@amlogic.com>, linux-mtd@lists.infradead.org,
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTmF0aGFuLAoKTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4g
d3JvdGUgb24gVHVlLCAyOSBKYW4gMjAxOQoxNDo0Njo1NyAtMDcwMDoKCj4gT24gYXJtIGxpdHRs
ZSBlbmRpYW4gYWxseWVzY29uZmlnOgo+IAo+ICAgbGQubGxkOiBlcnJvcjogdW5kZWZpbmVkIHN5
bWJvbDogX19hZWFiaV91bGRpdm1vZAo+ICAgPj4+IHJlZmVyZW5jZWQgYnkgbWVzb25fbmFuZC5j
Cj4gICA+Pj4gbXRkL25hbmQvcmF3L21lc29uX25hbmQubzoobWVzb25fbmZjX3NldHVwX2RhdGFf
aW50ZXJmYWNlKSBpbiBhcmNoaXZlIGRyaXZlcnMvYnVpbHQtaW4uYSAgCj4gCj4gVGhlIGRpdmlk
ZW5kIHRCRVJTX21heCBpcyB1NjQsIG1lYW5pbmcgd2UgbmVlZCB0byB1c2UgRElWX1JPVU5EX1VQ
X1VMTAo+ICh3aGljaCB3cmFwcyBkb19kaXYpIHRvIHByZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20g
ZW1pdHRpbmcKPiBfX2FlYmlfdWxkaXZtb2QuCj4gCj4gRml4ZXM6IDJkNTcwYjM0YjQxYSAoIm10
ZDogcmF3bmFuZDogbWVzb246IGFkZCBzdXBwb3J0IGZvciBBbWxvZ2ljIE5BTkQgZmxhc2ggY29u
dHJvbGxlciIpCj4gU2lnbmVkLW9mZi1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2Vs
bG9yQGdtYWlsLmNvbT4KPiAtLS0KCk1lcmdlZCBpbiBuYW5kL25leHQgd2l0aCB0aGUgb3JpZ2lu
YWwgY29tbWl0LgoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
