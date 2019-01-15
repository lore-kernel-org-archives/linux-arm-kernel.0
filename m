Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:49:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A07920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J9Jt03Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A07920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a6zhFMQAvym6MKXd3ibQA+tb+m3y6xxuCPtwsKOHqDE=; b=J9Jt03Pzyxr4yq
	04oGQZO8ZSBUSolDNNNEyk+kHG7s5EN5VPIy8iC35A3Kg4izDCRPVNB5wEHOX0NhtOjtwji0aBobF
	yxn2BrdRjYugdf/DqATkmKjI6oTCgVPtPojk8mI81CqL0c3x3rBdkulchxOIedILTy89f1r1dC0+i
	hMGw5J/eNOkE1lrZh5ewH/2ujd7mYiWewU/vNFf6aKgAxi1ADerujRMS+616ETyr3Bvfq1KoiS4GQ
	LCEe9PJNsoJoTfiYdL14TspRe7wYaHRX7pPkZ79F45bWidqPyBcHLCQn59AgSWEaBxzN0eUmwXjSf
	RCez1IuCsfFEwxY2u8mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjKPN-0006Aw-IO; Tue, 15 Jan 2019 08:49:17 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjKPJ-0006A6-CG; Tue, 15 Jan 2019 08:49:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9930120898; Tue, 15 Jan 2019 09:49:11 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2159D20728;
 Tue, 15 Jan 2019 09:49:11 +0100 (CET)
Date: Tue, 15 Jan 2019 09:49:11 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v8 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
Message-ID: <20190115094911.75f4edc9@xps13>
In-Reply-To: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
References: <1544973463-59523-1-git-send-email-jianxin.pan@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_004913_550484_DBD84819 
X-CRM114-Status: GOOD (  11.60  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlhbnhpbiwKCkppYW54aW4gUGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gd3JvdGUg
b24gU3VuLCAxNiBEZWMgMjAxOAoyMzoxNzo0MSArMDgwMDoKCj4gVGhlc2UgdHdvIHBhdGNoZXMg
dHJ5IHRvIGFkZCBpbml0aWFsIE5BTkQgZHJpdmVyIHN1cHBvcnQgZm9yIEFtbG9naWMgTWVzb24K
PiBTb0NzLCBjdXJyZW50IGl0IGhhcyBiZWVuIHRlc3RlZCBvbiBHWEwocDIxMikgYW5kIEFYRyhz
NDAwKSBwbGF0Zm9ybS4KPiAKPiBDaGFuZ2VzIHNpbmNlIFY2IGF0IFs4XQo+ICAtIGZpeCBiaXRm
bGlwcyBjaGVja2luZyBmb3IgYmxhbmsgcGFnZXMKPiAgLSB0cmFjZSB0aGUgbGF0ZXN0IGNvbW1p
dCB3aXRoIG5hbmQvbmV4dCBicmFuY2gKPiAgLSBjaGVja2luZyB0aGUgcmV0dXJuIG9mIG1lc29u
X25hbmRfb3BfZ2V0X2RtYV9zYWZlXyppbnB1dC9vdXRwdXQqX2J1Zgo+ICAtIGFkZCAuZGV0YWNo
X2NoaXAgZm9yIGZyZWUgbWVzb25fbmFuZC5kYXRhX2J1Zi9pbmZvX2J1Zgo+IAoKQ2FuIHlvdSBz
ZW5kIGEgdjkgd2l0aCB0aGUgYnVpbGQgZmFpbHJlIChvYmplY3RfaXNfb25fc3RhY2sgcGIpIGZp
eGVkCmFuZCB0aGUgS2NvbmZpZyBlbnRyeSB1cGRhdGVkICh0aGUgTWVzb24gY29tbW9uIGNsb2Nr
IHRoaW5nKSBhcwpzdWdnZXN0ZWQgYnkgTWFydGluPwoKClRoYW5rcywKTWlxdcOobAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
