Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AADC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C3621916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UkiXYOY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C3621916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=urJ8u+ov05UCCVS5aZLhcthFam1v3gIYFQr6PIuLrz8=; b=UkiXYOY7hl5CcU
	O1V2X7ej7Xgu3QT1Pj8QIjj7mbS8cjCVzjABvxTKqGugcacaMhENEPYJB36hp2LGPVx6hEpUNa4F9
	gV5Djmfr1Ci+H9vfTa7WQ95FuLs67NzdpKyBNROF1BziJ7t9EjW1m4zi7SNTuX5vB/cSoWPEybhG4
	ovLrEp400R441XavJ4ED00E+R4YvR8Pt2We/qlrIGUByStNaoGUkVx9Gg4f8x8BYzMAzcaMvbcrX1
	+2FNiveWSUVJsi3c0CMKYSf3/bSOKSOHzC/1ODJ/QfWrbtv9CmrL96Vm61M8XcTH8htE+cvcALa2f
	XqybFZH/MOtuSmOw/r9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWQS-0002if-5K; Fri, 01 Feb 2019 10:52:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWQO-0002i0-Dz
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 10:51:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6B280D;
 Fri,  1 Feb 2019 02:51:54 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A82B3F71E;
 Fri,  1 Feb 2019 02:51:53 -0800 (PST)
Date: Fri, 1 Feb 2019 10:51:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Message-ID: <20190201105144.GA27140@fuggles.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
 <cb7544e2-bd85-df4c-1f48-0afeedefc962@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A3090AC@G01JPEXMBKW03>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_025156_485549_D319F079 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'James Morse' <james.morse@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDU6NTM6NTBBTSArMDAwMCwgWmhhbmcsIExlaSB3cm90
ZToKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBsaW51eC1hcm0ta2Vy
bmVsCj4gPiBbbWFpbHRvOmxpbnV4LWFybS1rZXJuZWwtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQu
b3JnXSBPbiBCZWhhbGYgT2YKPiA+IEphbWVzIE1vcnNlCj4gPiBTZW50OiBUaHVyc2RheSwgSmFu
dWFyeSAzMSwgMjAxOSAxMjowMCBBTQo+ID4gVG86IFpoYW5nLCBMZWkv5by1IOmbtwo+ID4gQ2M6
ICdNYXJrIFJ1dGxhbmQnOyAnQ2F0YWxpbiBNYXJpbmFzJzsgJ3dpbGwuZGVhY29uQGFybS5jb20n
Owo+ID4gJ2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcnOwo+ID4gJ2xpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZycKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8xXSBh
cm02NDogQWRkIHdvcmthcm91bmQgZm9yIEZ1aml0c3UgQTY0RlgKPiA+IGVycmF0dW0gMDEwMDAx
Cj4gPiAKPiA+IAo+ID4gZTAzZTYxYzMxNzNjICgiYXJtNjQ6IGthc2xyOiBTZXQgVENSX0VMMS5O
RkQxIHdoZW4KPiA+IENPTkZJR19SQU5ET01JWkVfQkFTRT15IikgPwo+ID4gCj4gPiBTbyB5b3Un
ZCBuZXZlciBzZWUgaXQgaWYgeW91IGRpc2FibGVkIENPTkZJR19SQU5ET01JWkVfQkFTRT8KPiBG
b3Igc2VjdXJpdHksIGl0IGlzIG5lY2Vzc2FyeSB0byBzZXQgQ09ORklHX1JBTkRPTUlaRV9CQVNF
PXkuCgpTbyBJIGd1ZXNzIHdlIHNob3VsZCBib290IHdpdGggTkZEMSBjbGVhciwgYW5kIHRoZW4g
c2V0IGl0IG9ubHkgd2hlbiB3ZQpyZWFsaXNlIHdlJ3JlIG5vdCBvbiBhbiBBNjRGWD8KCldpbGwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
