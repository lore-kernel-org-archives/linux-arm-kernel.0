Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:43:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD9521906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dux7q39n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SneUCw3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD9521906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h2bo8Egx1MFeqGMPPGjq4mEWiGuPgn6GcMmuWWCpad4=; b=dux7q39nK+yZK3
	5NAwNyP+OodlnEfXX8P5E4qmSPXPxa2AcbADncNmYKhLV4+bdhVnzfYYTl8L2RVY74rEaFuwmgqI6
	+B0kYvvRmkrkle9vuJ22DiD4O+xhV9zONFsfxn6z5nUb4F3IVzsjbK2lqKmDOxeYZOsQMdzsISd6J
	op6Y3ZuN8XaldWV2DPRNAnlqBnUCody43U+9WsIjzDquSfrRTx+VapO5Y3Gv2Xe+y3MGDmszbdf5e
	SOJwraMDPF6i8O+oe7jYaV7NsN5kz20PRzgnsrIgU3H8aw6nuocyecHF8Aoxrn8KPBOi2rno8mW7L
	s9L+eaXVoaLEb23sisXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGP8-0007f1-H9; Fri, 21 Dec 2018 08:43:34 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGP5-0007eT-9p
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 08:43:33 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 92006408E1;
 Fri, 21 Dec 2018 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1545381767; bh=KWZrrP4uMqfRM50npT9IhegpzIgzKYjVpYc0tfDfs2M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SneUCw3fpzvNz1MJvoH/kCWpbgbO2x51C+F494u7tpuH4s050o8fxbfXtVx79wRic
 m96OwGq/Twibk1KgnvcSEoro2ZXph5cA11fXzgQWiCYXZNihr0OmzgRSbKXCFzJsJ9
 ISvolHIIRDX0IcovSougid+7RaqbHWzTbqvQGfURWfm7w7i07m7GJlS58DrOm6GKI/
 hNvl5See9HscInF+VYY777qWzLhpZFhP1BJc83YCV1m336TWKQ6zmY/avvBDTNFLq3
 PAAiy9BPW0M4j0/1gObyyVGg9cwTDF1LQEeXfgEzr3cK8i48duaaPMwCLcoVJ33BK0
 s8Iq0n4u0QMYg==
Date: Fri, 21 Dec 2018 08:42:46 +0000
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221084246.myrtv6n4jrv6lajl@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221083927.GQ4497@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_004331_547959_6C90CC4E 
X-CRM114-Status: GOOD (  20.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMjEsIDIwMTggYXQgMDg6Mzk6MjdBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIFR1ZSwgMTEgRGVjIDIwMTgsIFByaWl0IExhZXMgd3JvdGU6Cj4gCj4gPiBGcm9tOiBP
bGxpdmVyIFNjaGluYWdsIDxvbGl2ZXJAc2NoaW5hZ2wubmw+Cj4gPiAKPiA+IFRoZSBjdXJyZW50
IGF4cDIweCBuYW1lcyB0aGUgcmFtcGluZyByZWdpc3RlciAnc2NhbCcgd2hpY2ggcHJvYmFibHkK
PiA+IG1lYW5zIHNjYWxpbmcuIFNpbmNlIHRoZSByZWdpc3RlciByZWFsbHkgaGFzIG5vdGhpbmcg
dG8gZG8gd2l0aAo+ID4gc2NhbGluZywgYnV0IHJlYWxseSBpcyB0aGUgdm9sdGFnZSByYW1wIHdl
IHJlbmFtZSBpdCBhcHByb3ByaWF0ZWx5Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBPbGxpdmVy
IFNjaGluYWdsIDxvbGl2ZXJAc2NoaW5hZ2wubmw+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlpdCBM
YWVzIDxwbGFlc0BwbGFlcy5vcmc+Cj4gPiBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxl
ZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4
LmggfCA0ICsrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+IAo+IEkndmUgbG9zdCB0cmFjayBvZiB3aGF0J3MgaGFwcGVuaW5nIHdpdGggdGhp
cyBzZXQgbm93Lgo+IAo+IE1hcmssCj4gCj4gRGlkIHlvdSB0YWtlIHRoaXMgcGF0Y2ggaW4gdGhl
IGVuZD8KClllcywgdGhpcyBpcyBpbiBsaW51eC1uZXh0Lgo+IAo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbWZkL2F4cDIweC5oIGIvaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmgKPiA+
IGluZGV4IDIzMDJiNjIuLmEzNTNjZDIgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21m
ZC9heHAyMHguaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmgKPiA+IEBAIC0z
NSw3ICszNSw3IEBAIGVudW0gYXhwMjB4X3ZhcmlhbnRzIHsKPiA+ICAjZGVmaW5lIEFYUDE1Ml9B
TERPX09QX01PREUJCTB4MTMKPiA+ICAjZGVmaW5lIEFYUDE1Ml9MRE8wX0NUUkwJCTB4MTUKPiA+
ICAjZGVmaW5lIEFYUDE1Ml9EQ0RDMl9WX09VVAkJMHgyMwo+ID4gLSNkZWZpbmUgQVhQMTUyX0RD
REMyX1ZfU0NBTAkJMHgyNQo+ID4gKyNkZWZpbmUgQVhQMTUyX0RDREMyX1ZfUkFNUAkJMHgyNQo+
ID4gICNkZWZpbmUgQVhQMTUyX0RDREMxX1ZfT1VUCQkweDI2Cj4gPiAgI2RlZmluZSBBWFAxNTJf
RENEQzNfVl9PVVQJCTB4MjcKPiA+ICAjZGVmaW5lIEFYUDE1Ml9BTERPMTJfVl9PVVQJCTB4MjgK
PiA+IEBAIC01Myw3ICs1Myw3IEBAIGVudW0gYXhwMjB4X3ZhcmlhbnRzIHsKPiA+ICAjZGVmaW5l
IEFYUDIwWF9VU0JfT1RHX1NUQVRVUwkJMHgwMgo+ID4gICNkZWZpbmUgQVhQMjBYX1BXUl9PVVRf
Q1RSTAkJMHgxMgo+ID4gICNkZWZpbmUgQVhQMjBYX0RDREMyX1ZfT1VUCQkweDIzCj4gPiAtI2Rl
ZmluZSBBWFAyMFhfRENEQzJfTERPM19WX1NDQUwJMHgyNQo+ID4gKyNkZWZpbmUgQVhQMjBYX0RD
REMyX0xETzNfVl9SQU1QCTB4MjUKPiA+ICAjZGVmaW5lIEFYUDIwWF9EQ0RDM19WX09VVAkJMHgy
Nwo+ID4gICNkZWZpbmUgQVhQMjBYX0xETzI0X1ZfT1VUCQkweDI4Cj4gPiAgI2RlZmluZSBBWFAy
MFhfTERPM19WX09VVAkJMHgyOQo+IAo+IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pavXQo+IExp
bmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZAo+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRl
ciB8IEJsb2cKPiAKPiAtLSAKPiBZb3UgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UgeW91
IGFyZSBzdWJzY3JpYmVkIHRvIHRoZSBHb29nbGUgR3JvdXBzICJsaW51eC1zdW54aSIgZ3JvdXAu
Cj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFp
bHMgZnJvbSBpdCwgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1zdW54aSt1bnN1YnNjcmliZUBnb29n
bGVncm91cHMuY29tLgo+IEZvciBtb3JlIG9wdGlvbnMsIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdv
b2dsZS5jb20vZC9vcHRvdXQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
