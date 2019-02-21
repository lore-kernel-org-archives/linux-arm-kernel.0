Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F91C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:25:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193D62147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2Kbd/wi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDhjk7i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193D62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AYqiBgtjManPpAaXjVG1DfwiLc7TxiNi7OjgSR6Hgu0=; b=q2Kbd/wickgXTF
	K0s52c6vITutW7tofSAByJ0ntPSob8QxeT/kTNkF9SafNCK3s7UUlFXOroHIYgsarSMAFrjl9nXPH
	8YD7MkDWF5XxD1e0J55jPb+Bm1CKXbCWmatCiM+bAP3pG+ZyRTmxL2t/F2sAiFbmKPfoYDpSUJwC5
	mJHjh31oj0d2AsPf6n3xPgAAOybLdksLFTK6ey4LTcx1LsKGFhDiVYh5VXx50zUaZ4/suDfrfiGlb
	4dcQ+/Xs/g/yrWghCWq/e8ATgLSOVd3bAiIcBsuhtn1j7TgacAhjNNLD+bTRr0mNLE+CB80C31ZCF
	aTNlxyzae8h6ShQj0MOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmU7-0000NB-Ck; Thu, 21 Feb 2019 11:25:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmU4-0000MQ-KE; Thu, 21 Feb 2019 11:25:46 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF2942084F;
 Thu, 21 Feb 2019 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550748344;
 bh=kds1rV8j7IXcOqn/OYulUikOuVxCR6va1Q/Ev0NHbe0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bDhjk7i3uzdLhw6nx9kb7WrLJU8IkxRwBNy8UPDCkaNj7INAghtefpacDHqt1J89b
 Qv9yF0vE7gwXAR4dbEwm1u4ZZEU5Xi8ZQGB3Ic11iRXHJIwAiyMzzQL89kZHN5sBM/
 Ybwv7TP/za38E4tCB8QItrAiCsTuLOlr/whCRyio=
Date: Thu, 21 Feb 2019 12:25:38 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 08/27] mtd: nand: ecc: Use SPDX license identifier
 for the software BCH code
Message-ID: <20190221122538.414750f7@kernel.org>
In-Reply-To: <20190221100216.25255-9-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-9-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_032544_682241_F1B8A0E7 
X-CRM114-Status: GOOD (  19.43  )
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

T24gVGh1LCAyMSBGZWIgMjAxOSAxMTowMTo1NyArMDEwMApNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gUmVtb3ZlIHRoZSBsZWdhY3kgbGljZW5zZSB0
ZXh0LCBhbHNvIHVwZGF0ZSB0aGUgTU9EVUxFX0xJQ0VOU0UgbWFjcm8KPiBpbiBhY2NvcmRhbmNl
IHdpdGggdGhlIHRleHQgYXQgdGhlIHRvcCBvZiB0aGUgZmlsZSAoR1BMIHYyIG9yCj4gaGlnaGVy
KS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPgo+IC0tLQo+ICBkcml2ZXJzL210ZC9uYW5kL2VjYy9zdy1iY2gtZW5naW5lLmMgICB8
IDE3ICsrLS0tLS0tLS0tLS0tLS0tCj4gIGluY2x1ZGUvbGludXgvbXRkL25hbmQtc3ctYmNoLWVu
Z2luZS5oIHwgIDUgKy0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL2VjYy9zdy1i
Y2gtZW5naW5lLmMgYi9kcml2ZXJzL210ZC9uYW5kL2VjYy9zdy1iY2gtZW5naW5lLmMKPiBpbmRl
eCAzN2RjMGYwMDYxZDMuLjg3MWM0ZGQ5ZjcxZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL210ZC9u
YW5kL2VjYy9zdy1iY2gtZW5naW5lLmMKPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL2VjYy9zdy1i
Y2gtZW5naW5lLmMKPiBAQCAtMSwyMiArMSw5IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wKwo+ICAvKgo+ICAgKiBUaGlzIGZpbGUgcHJvdmlkZXMgRUNDIGNvcnJlY3Rp
b24gZm9yIG1vcmUgdGhhbiAxIGJpdCBwZXIgYmxvY2sgb2YgZGF0YSwKPiAgICogdXNpbmcgYmlu
YXJ5IEJDSCBjb2Rlcy4gSXQgcmVsaWVzIG9uIHRoZSBnZW5lcmljIEJDSCBsaWJyYXJ5IGxpYi9i
Y2guYy4KPiAgICoKPiAgICogQ29weXJpZ2h0IMKpIDIwMTEgSXZhbiBEamVsaWMgPGl2YW4uZGpl
bGljQHBhcnJvdC5jb20+Cj4gLSAqCj4gLSAqIFRoaXMgZmlsZSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0Cj4gLSAqIHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRo
ZQo+IC0gKiBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb3IgKGF0
IHlvdXIgb3B0aW9uKSBhbnkKPiAtICogbGF0ZXIgdmVyc2lvbi4KPiAtICoKPiAtICogVGhpcyBm
aWxlIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1
dCBXSVRIT1VUCj4gLSAqIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSBvcgo+IC0gKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VM
QVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKPiAtICogZm9y
IG1vcmUgZGV0YWlscy4KPiAtICoKPiAtICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKPiAtICogd2l0aCB0aGlz
IGZpbGU7IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5j
LiwKPiAtICogNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMw
NyBVU0EuCj4gICAqLwo+ICAKPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+Cj4gQEAgLTIyNyw2
ICsyMTQsNiBAQCB2b2lkIG5hbmRfYmNoX2ZyZWUoc3RydWN0IG5hbmRfYmNoX2NvbnRyb2wgKm5i
YykKPiAgfQo+ICBFWFBPUlRfU1lNQk9MKG5hbmRfYmNoX2ZyZWUpOwo+ICAKPiAtTU9EVUxFX0xJ
Q0VOU0UoIkdQTCIpOwo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7CgpHUEwgd2FzIGNvcnJl
Y3QgaGVyZSwgc2VlIFsxXQoKWzFdaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUu
MC1yYzcvc291cmNlL2luY2x1ZGUvbGludXgvbW9kdWxlLmgjTDE3NQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
