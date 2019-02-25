Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D062087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T4POJwKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D062087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FDr+F10JWqA04fA9D6t7unlnb8TU2NiiTXh9m/iGK8M=; b=T4POJwKe/Te1Yp
	rGVew9G86iwCXlOa/ROz1akhsA9K7hXO4nwRAFfUkUW4gtP/8mIgnPa0Fg6ysLFZAKPadkhsGC1iD
	hndgSENbgRgsOkcGeEvxWcOTfmLxd3suhMgl1yxgL5o2G6m1d0JJMyEhJ0oDZ4MKCIgL6vb3Fw6/a
	sJVKzKPEe9DfoAzigV9ESZlH+6tdaVB8XWEA4kiGuQPfyO4YQv37ljSuTEPClXo20pg49bOZenWkX
	qPnWOMBINhNWc19Bb1egG0+HBBwU0SDRnEJsr3uhb5ORX28mYxqNneQh32sU/tksKvI44RybfUca4
	8Cc0uV1mIwKGBSdFQOKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyBvN-0001GL-Gd; Mon, 25 Feb 2019 08:47:45 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyBvF-0001FJ-Gd
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 08:47:42 +0000
Received: from [IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c]
 ([IPv6:2601:646:8680:2bb1:a106:e287:aa34:4a8c])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1P8l8qU1623112
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 25 Feb 2019 00:47:09 -0800
Date: Mon, 25 Feb 2019 00:47:00 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190223083942.GF32477@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CE650687-ECB3-4A7C-96BA-A061D54AEF40@zytor.com>
 <20190223083942.GF32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Peter Zijlstra <peterz@infradead.org>
From: hpa@zytor.com
Message-ID: <15DE0017-9AE5-4E7A-96CD-E5E9F5B72516@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_004737_552375_0B8E8A88 
X-CRM114-Status: UNSURE (   6.60  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRmVicnVhcnkgMjMsIDIwMTkgMTI6Mzk6NDIgQU0gUFNULCBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+T24gRnJpLCBGZWIgMjIsIDIwMTkgYXQgMDM6Mzk6
NDhQTSAtMDgwMCwgaHBhQHp5dG9yLmNvbSB3cm90ZToKPj4gT2JqdG9vbCBjb3VsZCBhbHNvIGRl
dGVjdCBDTEFDLVNUQUMgb3IgU1RBQy1DTEFDIHNlcXVlbmNlcyB3aXRob3V0Cj4+IG1lbW9yeSBv
cGVyYXRpb25zIGFuZCByZW1vdmUgdGhlbTsgZG9uJ3Qga25vdyBob3cgb2Z0ZW4gdGhhdCBoYXBw
ZW5zLAo+PiBidXQgSSBrbm93IGl0ICpkb2VzKiBoYXBwZW4uCj4KPk9ianRvb2wgZG9lc24ndCBr
bm93IGFib3V0IG1lbW9wczsgdGhhdCdkIGJlIGEgbG90IG9mIHdvcmsuIEFsc28sCj5vYmp0b29s
IGRvZXNuJ3QgYWN0dWFsbHkgcmV3cml0ZSB0aGUgdGV4dCwgYXQgYmVzdCBpdCBjb3VsZCB3YXJu
IGFib3V0Cj5zdWNoIG9jY3VyZW5jZXMuCgpJdCBkb2Vzbid0IGhhdmUgdG8gdW5kZXJzdGFuZCB0
aGUgY29udGVudHMgb2YgdGhlIG1lbW9wLCBidXQgaXQgc2VlbXMgdGhhdCB0aGUgcHJlc2VuY2Ug
b2YgYSBtb2RybSB3aXRoIG1vZGUg4omgIDMgc2hvdWxkIGJlIHBsZW50eS4gSXQgbmVlZHMgdG8g
a25vdyB0aGF0IG11Y2ggaW4gb3JkZXIgdG8ga25vdyB0aGUgbGVuZ3RoIG9mIGluc3RydWN0aW9u
cyBhbnl3YXkuIEZvciBleHRyYSBjcmVkaXQsIGlnbm9yZSBMRUEgb3IgaGludGluZyBpbnN0cnVj
dGlvbnMuCi0tIApTZW50IGZyb20gbXkgQW5kcm9pZCBkZXZpY2Ugd2l0aCBLLTkgTWFpbC4gUGxl
YXNlIGV4Y3VzZSBteSBicmV2aXR5LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
