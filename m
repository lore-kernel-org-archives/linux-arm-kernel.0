Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2707218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bqe7K1u2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="oVGtEs/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2707218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=97w4ElgtaF+4iKqQbPoIhHOg3KCcrH+f8V0moqOgB0o=; b=Bqe7K1u2ju52Pi
	XkfE9M/sMl3xGLiLti3HBrFYhJB5wFL+On6StX6gqy07rvpryNac6QkjJcL+ZRyyA/dN+xFz308zC
	gdBYv1OF1bO1boFmsx+Q/0vZ3rQtD59VwLqKaGHqUlyecYo5l01YkiHvLxmy2GlAwt20OUMHgkCeh
	3cNds+bpcuaiBgnOQ6WNeiXmWAoP7Q4aWEHRtlvCi5DMKgGZRJzK90rrmAK2EwwN87wIW1AqlDEf4
	bM5e3SQciO6W6Fogq8vOLM1sdtGarVl6ksGHcdw+cTI4z7W58wmedV7TV/qf+pvm3XOX9v14HSs8+
	qgUwbYxY73nXJTULw1Mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaH7o-0001vC-SL; Fri, 21 Dec 2018 09:29:44 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaH7k-0001uT-T8
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:29:42 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 4FB6D402C1;
 Fri, 21 Dec 2018 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1545384539; bh=/S6BxI+GAK5WS0/EhA92uvgr6Ez3wigOIyqi8T73vGk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oVGtEs/m2CLPOHpTekkyGPumMYiDSiQtTkwPBM+r82cOV7b8AkVbgkKKpZM9AzQB5
 9Y0DQt5Bc4awqotarB2BkL6HrZKNQKmW8U5o+Xvcy7MzxEIlxC9m16huRToHwIjYSi
 vVsAWyTO1MUhPODserRHrJoWHCY6kS+/lEEyaqta/i9TjI0yKa0+/pnZgIecy3kcOM
 2OCMTKlHa4Bv2VMq19w1tyOJNFxaQ8cOQQuurgK4rXw4XaebmCdASVOPuBVBm5V0Ja
 dhQ7yOyz9vTl7LLeskUX1sfop04pNjVPVmhOCzrqlnPpm7vx3ku7j/54UNP7iAE3wS
 YeD0FRQiJfPzw==
Date: Fri, 21 Dec 2018 09:28:58 +0000
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
 <20181221092658.GB13248@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221092658.GB13248@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_012941_223904_1FC9F5D2 
X-CRM114-Status: GOOD (  24.12  )
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

T24gRnJpLCBEZWMgMjEsIDIwMTggYXQgMDk6MjY6NThBTSArMDAwMCwgTGVlIEpvbmVzIHdyb3Rl
Ogo+IE9uIEZyaSwgMjEgRGVjIDIwMTgsIFByaWl0IExhZXMgd3JvdGU6Cj4gCj4gPiBPbiBGcmks
IERlYyAyMSwgMjAxOCBhdCAwODozOToyN0FNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+
IE9uIFR1ZSwgMTEgRGVjIDIwMTgsIFByaWl0IExhZXMgd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IEZy
b206IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBzY2hpbmFnbC5ubD4KPiA+ID4gPiAKPiA+ID4g
PiBUaGUgY3VycmVudCBheHAyMHggbmFtZXMgdGhlIHJhbXBpbmcgcmVnaXN0ZXIgJ3NjYWwnIHdo
aWNoIHByb2JhYmx5Cj4gPiA+ID4gbWVhbnMgc2NhbGluZy4gU2luY2UgdGhlIHJlZ2lzdGVyIHJl
YWxseSBoYXMgbm90aGluZyB0byBkbyB3aXRoCj4gPiA+ID4gc2NhbGluZywgYnV0IHJlYWxseSBp
cyB0aGUgdm9sdGFnZSByYW1wIHdlIHJlbmFtZSBpdCBhcHByb3ByaWF0ZWx5Lgo+ID4gPiA+IAo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sbGl2ZXIgU2NoaW5hZ2wgPG9saXZlckBzY2hpbmFnbC5u
bD4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlpdCBMYWVzIDxwbGFlc0BwbGFlcy5vcmc+Cj4g
PiA+ID4gQWNrZWQtZm9yLU1GRC1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4K
PiA+ID4gPiAtLS0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmggfCA0ICsrLS0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
PiA+ID4gCj4gPiA+IEkndmUgbG9zdCB0cmFjayBvZiB3aGF0J3MgaGFwcGVuaW5nIHdpdGggdGhp
cyBzZXQgbm93Lgo+ID4gPiAKPiA+ID4gTWFyaywKPiA+ID4gCj4gPiA+IERpZCB5b3UgdGFrZSB0
aGlzIHBhdGNoIGluIHRoZSBlbmQ/Cj4gPiAKPiA+IFllcywgdGhpcyBpcyBpbiBsaW51eC1uZXh0
Lgo+IAo+IEkgaGF2ZSBubyBpZGVhIHdoeSBNYXJrJ3MgdHJhY2tlciBpc24ndCBtYWlsaW5nIG1l
ICh0aGlzIGlzIG5vdCB0aGUKPiBmaXJzdCB0aW1lIHRoaXMgaGFzIGhhcHBlbmVkKS4KPiAKPiBD
b3VsZCB5b3UgcGxlYXNlIHJlYmFzZSB0aGlzIHNldCBhbmQgcmVzdWJtaXQgYWxsIG9mIHRoZSBw
YXRjaGVzIHdoaWNoCj4gaGF2ZSBub3QgeWV0IGJlZW4gYXBwbGllZD8KCldob2xlIHNlcmllIGhh
cyBiZWVuIGFwcGxpZWQuCgo+IFRoYW5rIHlvdS4KPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tZmQvYXhwMjB4LmggYi9pbmNsdWRlL2xpbnV4L21mZC9heHAyMHguaAo+ID4g
PiA+IGluZGV4IDIzMDJiNjIuLmEzNTNjZDIgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9tZmQvYXhwMjB4LmgKPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21mZC9heHAyMHgu
aAo+ID4gPiA+IEBAIC0zNSw3ICszNSw3IEBAIGVudW0gYXhwMjB4X3ZhcmlhbnRzIHsKPiA+ID4g
PiAgI2RlZmluZSBBWFAxNTJfQUxET19PUF9NT0RFCQkweDEzCj4gPiA+ID4gICNkZWZpbmUgQVhQ
MTUyX0xETzBfQ1RSTAkJMHgxNQo+ID4gPiA+ICAjZGVmaW5lIEFYUDE1Ml9EQ0RDMl9WX09VVAkJ
MHgyMwo+ID4gPiA+IC0jZGVmaW5lIEFYUDE1Ml9EQ0RDMl9WX1NDQUwJCTB4MjUKPiA+ID4gPiAr
I2RlZmluZSBBWFAxNTJfRENEQzJfVl9SQU1QCQkweDI1Cj4gPiA+ID4gICNkZWZpbmUgQVhQMTUy
X0RDREMxX1ZfT1VUCQkweDI2Cj4gPiA+ID4gICNkZWZpbmUgQVhQMTUyX0RDREMzX1ZfT1VUCQkw
eDI3Cj4gPiA+ID4gICNkZWZpbmUgQVhQMTUyX0FMRE8xMl9WX09VVAkJMHgyOAo+ID4gPiA+IEBA
IC01Myw3ICs1Myw3IEBAIGVudW0gYXhwMjB4X3ZhcmlhbnRzIHsKPiA+ID4gPiAgI2RlZmluZSBB
WFAyMFhfVVNCX09UR19TVEFUVVMJCTB4MDIKPiA+ID4gPiAgI2RlZmluZSBBWFAyMFhfUFdSX09V
VF9DVFJMCQkweDEyCj4gPiA+ID4gICNkZWZpbmUgQVhQMjBYX0RDREMyX1ZfT1VUCQkweDIzCj4g
PiA+ID4gLSNkZWZpbmUgQVhQMjBYX0RDREMyX0xETzNfVl9TQ0FMCTB4MjUKPiA+ID4gPiArI2Rl
ZmluZSBBWFAyMFhfRENEQzJfTERPM19WX1JBTVAJMHgyNQo+ID4gPiA+ICAjZGVmaW5lIEFYUDIw
WF9EQ0RDM19WX09VVAkJMHgyNwo+ID4gPiA+ICAjZGVmaW5lIEFYUDIwWF9MRE8yNF9WX09VVAkJ
MHgyOAo+ID4gPiA+ICAjZGVmaW5lIEFYUDIwWF9MRE8zX1ZfT1VUCQkweDI5Cj4gPiA+IAo+IAo+
IC0tIAo+IExlZSBKb25lcyBb5p2O55C85pavXQo+IExpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwg
TGVhZAo+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+
IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKPiAKPiAtLSAKPiBZb3Ug
cmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UgeW91IGFyZSBzdWJzY3JpYmVkIHRvIHRoZSBH
b29nbGUgR3JvdXBzICJsaW51eC1zdW54aSIgZ3JvdXAuCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0
aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbiBlbWFp
bCB0byBsaW51eC1zdW54aSt1bnN1YnNjcmliZUBnb29nbGVncm91cHMuY29tLgo+IEZvciBtb3Jl
IG9wdGlvbnMsIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9vcHRvdXQuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
