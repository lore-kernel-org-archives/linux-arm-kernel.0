Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:42:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9538520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CXQHPOr8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv1mBpTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9538520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCDE1TebdyYgs2E+oo8oboBXdhaQguJYnSJ6Nj+b7a8=; b=CXQHPOr8i4uBRN
	5r43NApz3dWQYbBLSFzmTeNG1STCyXQPh8QcokesCBpGvOjImMQZQLFyBt4pNLppACS80mglm0qOU
	5BfaPcYg48DXtchoosgbYe0gI1Fd61096GE9VPQ5IF2WWtYNqT94bLmGqz+wwCb68pY15HXkZDuaU
	twPejBQiBgPimlIUuqLPU6MSnozhZvaCJ9zNLPOnU1boLpqAkA51+IeOYmjm79IUqjdw8/P0xDaxk
	3SCLX3VeNDamtJQlcA6Umnjiqpavro5eq9VSc/n6O2c+yNSzncGngl1QX/dNohDzzMLQyXZrEPplr
	ZnumA3gTfrMEwJWy521g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwobu-0002xX-DT; Thu, 21 Feb 2019 13:41:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwobq-0002wO-W8; Thu, 21 Feb 2019 13:41:56 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 421332084F;
 Thu, 21 Feb 2019 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550756514;
 bh=vZgkCpselDW32+mjrNyIebsSKewu4CyyI0QOWUlG/uc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Gv1mBpTyhpZJjGw4E1Djot8Urb7X2TsrIXfTujGP2O/VuAOsI5aa11XlTyMYxzrxL
 TBRD0DhOx6AvxaLigW6BQL4j3cHr3qWFFgXtNH/ZooX76pgDfhgtKVKTmOeJhz9UOq
 DBolMPB/kSFEI+QHhczut7MYwrSTcsdilfAZFL70=
Date: Thu, 21 Feb 2019 14:41:48 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 17/27] mtd: nand: ecc: Let the software Hamming ECC
 engine be unselected
Message-ID: <20190221144148.6313d2ba@kernel.org>
In-Reply-To: <20190221143539.65035bfa@xps13>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-5-miquel.raynal@bootlin.com>
 <20190221142002.5a160f87@kernel.org>
 <20190221143539.65035bfa@xps13>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_054155_067724_ECE5F899 
X-CRM114-Status: GOOD (  25.02  )
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

T24gVGh1LCAyMSBGZWIgMjAxOSAxNDozNTozOSArMDEwMApNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwu
cmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gSGkgQm9yaXMsCj4gCj4gQm9yaXMgQnJlemls
bG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+IHdyb3RlIG9uIFRodSwgMjEgRmViIDIwMTkKPiAx
NDoyMDowMiArMDEwMDoKPiAKPiA+IE9uIFRodSwgMjEgRmViIDIwMTkgMTM6NTc6NTYgKzAxMDAK
PiA+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlOgo+ID4g
ICAKPiA+ID4gVGhlcmUgaXMgbm8gcmVhc29uIHRvIGFsd2F5cyBlbWJlZCB0aGUgc29mdHdhcmUg
SGFtbWluZyBFQ0MgZW5naW5lCj4gPiA+IGltcGxlbWVudGF0aW9uLiBCeSBkZWZhdWx0IGl0IGlz
LCBidXQgd2UgY2FuIGxldCB0aGUgdXNlciBkZWNpZGUuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgo+ID4gPiAtLS0K
PiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvZWNjL0tjb25maWcgICAgICAgICAgICAgICB8IDEwICsr
KysrLQo+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAgICAgICAgICAgICAgIHwg
IDIgKy0KPiA+ID4gIGluY2x1ZGUvbGludXgvbXRkL25hbmQtc3ctaGFtbWluZy1lbmdpbmUuaCB8
IDM4ICsrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNDggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9uYW5kL2VjYy9LY29uZmlnIGIvZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZwo+
ID4gPiBpbmRleCBlMDEwNmIzYTdlYzEuLmZmMjBlNjIxZmZlZiAxMDA2NDQKPiA+ID4gLS0tIGEv
ZHJpdmVycy9tdGQvbmFuZC9lY2MvS2NvbmZpZwo+ID4gPiArKysgYi9kcml2ZXJzL210ZC9uYW5k
L2VjYy9LY29uZmlnCj4gPiA+IEBAIC0xLDcgKzEsMTUgQEAKPiA+ID4gIG1lbnUgIkVDQyBlbmdp
bmUgc3VwcG9ydCIKPiA+ID4gIAo+ID4gPiAgY29uZmlnIE1URF9OQU5EX0VDQ19TV19IQU1NSU5H
Cj4gPiA+IC0JdHJpc3RhdGUKPiA+ID4gKwl0cmlzdGF0ZSAiU29mdHdhcmUgSGFtbWluZyBFQ0Mg
ZW5naW5lIgo+ID4gPiArCWRlZmF1bHQgeSAgICAKPiA+IAo+ID4gU2FtZSBhcyBmb3IgdGhlIE5B
TkRfQ09SRSBzdHVmZiwgbGV0IHVzZXJzIHRoaXMgb3B0aW9uIHdoZW4gdGhleSBuZWVkCj4gPiBp
dCBpbnN0ZWFkIG9mIGhhdmluZyBhICJkZWZhdWx0IHkiLiBIYXZlbid0IG1hZGUgbXkgbWluZCB5
ZXQgb24gd2hldGhlcgo+ID4gdGhpcyBvcHRpb24gc2hvdWxkIGJlIHZpc2libGUgdG8gdXNlcnMg
b3Igbm90LiBJIGd1ZXNzIGl0IGNvdWxkIGJlIHdpdGgKPiA+IHRoZSBuZXcgaW5mcmFzdHJ1Y3R1
cmUsIGJ1dCBpdCdzIHByb2JhYmx5IHRvbyBlYXJseSBpbiB0aGUgcGF0Y2ggc2VyaWVzCj4gPiB0
byBjaGFuZ2UgdGhhdC4gIAo+IAo+IFRoaXMgb25lIGlzIGRpZmZlcmVudC4KPiAKPiBCZWZvcmUg
dGhlIHNlcmllczogdGhlIHNvZnR3YXJlIEhhbW1pbmcgRUNDIGFsZ29yaXRobSBpcyBwYXJ0IG9m
IHRoZQo+ICdOQU5EIHBhY2thZ2UnLiBUaGVyZSBpcyBubyB3YXkgdG8gaWdub3JlIGl0LCBpdCAq
d2lsbCogYmUgcGFydCBvZiB5b3VyCj4gYmluYXJ5IChvciBtb2R1bGUpLgo+IAo+IEFmdGVyIHRo
ZSBzZXJpZXM6IEkganVzdCBnaXZlIHRoZSB1c2VyIHRoZSBwb3NzaWJpbGl0eSB0byBkZXNlbGVj
dAo+IHRoaXMgb3B0aW9uLiBCdXQgaGF2aW5nICdkZWZhdWx0IHknIGlzIG1hbmRhdG9yeSBoZXJl
IHRvIGF2b2lkIGJyZWFraW5nCj4gY3VycmVudCBkZWZjb25maWdzLgoKT2theSwgdGhlbiBtYXli
ZQoKCWRlZmF1bHQgeSBpZiBNVERfUkFXX05BTkQKCkFuZCBJIHRoaW5rIHlvdSBzaG91bGQgc2Vs
ZWN0IHRoZSBvcHRpb24gaW4gTVREX05BTkRfTkRGQyBpbnN0ZWFkIG9mCmFkZGluZyBhIGRlcGVu
ZHMgb24uIAoKPiAKPiA+ICAgCj4gPiA+ICsJaGVscAo+ID4gPiArCSAgVGhpcyBlbmFibGVzIHN1
cHBvcnQgZm9yIHNvZnR3YXJlIEhhbW1pbmcgZXJyb3IKPiA+ID4gKwkgIGNvcnJlY3Rpb24uIFRo
aXMgY29ycmVjdGlvbiBjYW4gY29ycmVjdCB1cCB0byAxIGJpdCBlcnJvcgo+ID4gPiArCSAgcGVy
IGNodW5rIGFuZCBkZXRlY3QgdXAgdG8gMiBiaXQgZXJyb3JzLiBXaGlsZSBpdCB1c2VkIHRvIGJl
Cj4gPiA+ICsJICB3aWRlbHkgdXNlZCB3aXRoIG9sZCBwYXJ0cywgbmV3ZXIgTkFORCBjaGlwcyB1
c3VhbGx5IHJlcXVpcmUKPiA+ID4gKwkgIG1vcmUgc3RyZW5ndGggY29ycmVjdGlvbiBhbmQgaW4g
dGhpcyBjYXNlIEJDSCBvciBSUyB3aWxsIGJlCj4gPiA+ICsJICBwcmVmZXJyZWQuCj4gPiA+ICAg
ICAgCj4gCj4gCj4gVGhhbmtzLAo+IE1pcXXDqGwKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
