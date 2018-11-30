Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448BC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5TUEe1U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjnx8ABa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448BC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCiraca76xvfASzEKz73cmgDgQwCd+Xxk2Xq2sKthfk=; b=m5TUEe1UZ+OFjg
	HJcPt39L8pfm6127c01pFZM7gKnhbq3jzOJfxb2KcUkLVBu6Ank7l1fMFDdnlR5V8sR4o5jb+T3T1
	Wae5lb901huzoVZOH1MARrB5NSzZOew+jCRcLuQGMsrUARmihHE1HL6j++RejsjF8hXBtMFVx12EL
	NthubVI3Rb/qnt0gStLcNIqM9w7GBPxmGbJm4j49RLrP4QdoyHOu6YDMc+ieiTZVBX/9xuiS225YU
	Rnr6jjBZzh/xaylWdxG4naAkhYopgbZ1xMF73NDb/6e7qFBJhwtLW+G3vUNqvQrUFoXx6jqwktXp4
	KaAz9W6M1WAl3Hozz/kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSds7-0006AX-5S; Fri, 30 Nov 2018 08:09:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdrq-00069Y-SK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:09:44 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 366A4206B7;
 Fri, 30 Nov 2018 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543565371;
 bh=z2MYl/L4IAF4r+79sfPwnl6D6NuGsc2wixsEvrIf0ZA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=Jjnx8ABaORiNLC5WxoUNmp2HalHlHznh5JNFO/IkMo49ydzD3l3yZHlt1s5v7O8E8
 qRgN/dgzGa0cQRVpdFpzRCAiQg3yA/1EpMxcukZkf+Cuxgvp3SI1GJpOJSdiuEdYrw
 8N5C7nzXz3ovQPbHHJxqhZgusO2xhhb5S6pxIOek=
MIME-Version: 1.0
To: Nicholas Mc Guire <der.herr@hofr.at>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130075453.GB2456@osadl.at>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
 <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
 <20181130075453.GB2456@osadl.at>
Message-ID: <154356537055.88331.12823387821854167503@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Date: Fri, 30 Nov 2018 00:09:30 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_000942_943591_9EABB92F 
X-CRM114-Status: GOOD (  17.44  )
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
Cc: Rob Herring <robh@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 Nicholas Mc Guire <hofrat@osadl.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBOaWNob2xhcyBNYyBHdWlyZSAoMjAxOC0xMS0yOSAyMzo1NDo1MykKPiBPbiBUaHUs
IE5vdiAyOSwgMjAxOCBhdCAwMzo0NToyM1BNIC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4g
PiBRdW90aW5nIE5pY2hvbGFzIE1jIEd1aXJlICgyMDE4LTExLTIxIDA0OjI4OjMwKQo+ID4gPiBU
aGUga21hbGxvYyBoZXJlIGlzIHNtYWxsICg8IDE2IGJ5dGVzKSBhbmQgb2NjdXJzIGR1cmluZyBp
bml0aWFsaXphdGlvbgo+ID4gPiBkdXJpbmcgc3lzdGVtIHN0YXJ0dXAgaGVyZSAoY2FuIG5vdCBi
ZSBidWlsdCBhcyBtb2R1bGUpIHRodXMgaWYgdGhpcwo+ID4gPiBrbWFsbG9jIGZhaWxlZCBpdCBp
cyBhbiBpbmRpY2F0aW9uIG9mIHNvbWV0aGluZyBtb3JlIHNlcmlvdXMgZ29pbmcgb24KPiA+ID4g
YW5kIGl0IGlzIGZpbmUgdG8gaGFuZyB0aGUgc3lzdGVtIGhlcmUgcmF0aGVyIHRoYW4gY2F1c2Ug
c29tZSBoYXJkZXIKPiA+ID4gdG8gdW5kZXJzdGFuZCBlcnJvciBieSBkZXJlZmVyZW5jaW5nIE5V
TEwuCj4gPiA+IAo+ID4gPiBFeHBsaWNpdGx5IGNoZWNraW5nIHdvdWxkIG5vdCBtYWtlIHRoYXQg
bXVjaCBzZW5zZSBoZXJlIGFzIHRoZSBvbmx5Cj4gPiA+IHBvc3NpYmxlIHJlYWN0aW9uIHdvdWxk
IGJlIHdvdWxkIEJVRygpIGhlcmUgYW55d2F5Lgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTog
TmljaG9sYXMgTWMgR3VpcmUgPGhvZnJhdEBvc2FkbC5vcmc+Cj4gPiA+IEZpeGVzOiAwZWU1MmIx
NTdiOGUgKCJjbGs6IHp5bnE6IEFkZCBjbG9jayBjb250cm9sbGVyIGRyaXZlciIpCj4gPiA+IEFj
a2VkLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPgo+ID4gPiAtLS0K
PiA+IAo+ID4gTmFrLiBXZSBkb24ndCBoYXZlIGFueSBfX0dGUF9OT0ZBSUwgaW4gZHJpdmVycy9j
bGsgYW5kIEkgZG9uJ3Qgc2VlIGEKPiA+IHJlYXNvbiB3aHkgd2Ugd291bGQgd2FudCBpdCBoZXJl
IGVpdGhlci4gSnVzdCBoYW5kbGUgdGhlIGZhaWx1cmUsIG9yCj4gPiBkb24ndCBjYXJlIGlmIHRo
aXMgaXMgc28gY3JpdGljYWwgdG8gc3lzdGVtIGJvb3QuCj4gPgo+IEl0IHdhcyBub3QgbW90aXZh
dGVkIGJ5IHRoZSBjcml0aWNhbGl0eSBidXQgYnkgdGhlIGxvdyBwcm9iYWJpbGl0eQo+IGFuZCBj
bHV0dGVyaW5nIHRoZSBjb2RlIGZvciB0aGlzIGNhc2UgZGlkIG5vdCBzZWVtIGdvb2QgdG8gbWUu
Cj4gRWZmZWN0aXZlbHkgaGFuZGxpbmcgaXQgaGVyZSBtZWFucyBCVUcoKSAtIHNvIG1vcmUgb3Ig
bGVzcwo+IHRoZSBzYW1lIHJlc3VsdCB0aGF0IGhhbmdpbmcgaXQgb24gX19HRlBfTk9GQUlMIGlm
IGFsbG9jYXRpb24KPiB3YXMgbm90IHBvc3NpYmxlIHdvdWxkIGNhdXNlLgo+IAo+IE5vdCBjbGVh
ciB3aGF0IHRoZSBvYmplY3Rpb24gdG8gX19HRlBfTk9GQUlMIGhlcmUgaXMgLSBteSB1bmRlcnN0
YW5kaW5nCj4gd2FzIHRoYXQgaXQgaXMgaW50ZW5kZWQgcHJlY2lzZWx5IGZvciBjYXNlcyBsaWtl
IHRoaXMgLSBidXQKPiBJwrRsbCBzZW5kIGEgVjIgaGFuZGxpbmcgaXQgd2l0aCBCVUdfT04oIWNs
a19uYW1lKSBpZiB0aGF0IGlzIHByZWZlcmVkLgo+IAoKT3IganVzdCBXQVJOKCkgYW5kIHJldHVy
bi4gTWF5YmUgc29tZXRoaW5nIGVsc2UgY2FuIGdldCBmYXIgZW5vdWdoIHRvIGJlCmhlbHBmdWwu
CgpJIHdvdWxkIGFsc28gYXBwcmVjaWF0ZSBpZiB0aGlzIHNvcnQgb2YgcHJvYmxlbSBjb3VsZCBi
ZSBjYXVnaHQgZWFybGllcgppbiBjb2RlIHJldmlldyBhbmQvb3Igd2l0aCBzb21lIGF1dG9tYXRl
ZCBzY3JpcHRpbmcuIERlYmF0aW5nIEJVR19PTigpCmFuZCBhbGxvY2F0aW9uIGZhaWx1cmVzIGlz
IG5vdCB3aGF0IEkgbG9vayBmb3J3YXJkIHRvIGRvaW5nIHNvIHBsZWFzZQp0cnkgdG8gbWFrZSB0
aGlzIGV4YWN0IHNvcnQgb2YgcGF0Y2ggbmV2ZXIgbWFrZSBpdCB0byB0aGUgbGlzdCBpbiB0aGUK
Zmlyc3QgcGxhY2UuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
