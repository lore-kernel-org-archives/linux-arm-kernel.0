Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9603C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866B02087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Piv1aJdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866B02087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkL00VFiOmeexY9pYaof6PQp0olHQUzKldoe3MsuEKQ=; b=Piv1aJdww4ZIr5
	4UmkBu36d6LtVtSJTwFYKUO038BgK1b00ju/etP0oyEUbN/s4KtObntNufEaZgH4X3zQ3QpggARl2
	ixFxD5hA/KQGedCeCIHgOAwiJ7160POC5vKoqcdyeK7mIgrrwQhCVv2k05wk5Yy1kU+BwYaQFGozE
	uXKCsm42tPuRhusU5AcJhMwuYdn/N6PsRonIVEFggcHHWf+yRAe2LTUuRhaYPp7/ll6sDpKoSU+Gl
	yuriUfZ1EraHL/ZDt0cntyUjAbTmBMsJu41xLkW7p6kG96OxQKFjRV8ogb7cZA+z9+GiMdoc3P+d9
	5aG+UtwYrDfnjcuFJ0cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSr8-0008W9-7V; Tue, 29 Jan 2019 12:51:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSr4-0008Vm-OF
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:51:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45BF1EBD;
 Tue, 29 Jan 2019 04:51:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B67B3F59C;
 Tue, 29 Jan 2019 04:51:04 -0800 (PST)
Date: Tue, 29 Jan 2019 12:51:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Kernel boot regression with PAuth and aarch64-softmmu -cpu max
 and el2 enabled
Message-ID: <20190129125101.GC25983@lakrids.cambridge.arm.com>
References: <87va27n2l8.fsf@linaro.org>
 <20190129114609.GA25983@lakrids.cambridge.arm.com>
 <CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_045106_795362_7DEE9F19 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "open list:ARM" <qemu-arm@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMjksIDIwMTkgYXQgMTE6NTQ6MTNBTSArMDAwMCwgUGV0ZXIgTWF5ZGVsbCB3
cm90ZToKPiBPbiBUdWUsIDI5IEphbiAyMDE5IGF0IDExOjQ2LCBNYXJrIFJ1dGxhbmQgPG1hcmsu
cnV0bGFuZEBhcm0uY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDExOjA4
OjE5QU0gKzAwMDAsIEFsZXggQmVubsOpZSB3cm90ZToKPiA+ID4gVGhlIC1jcHUgbWF4IGVuYWJs
ZWQgYSBjb3J0ZXgtYTU3ICsgd2hhdGV2ZXIgZXh0cmEgZmVhdHVyZXMgd2UndmUKPiA+ID4gZW5h
YmxlZCBpbiBRRU1VIHNvIGZhci4gSXQgd29uJ3QgbWF0Y2ggYW55ICJyZWFsIiBDUFUgYnV0IGl0
IHNob3VsZCBiZQo+ID4gPiBhcmNoaXRlY3R1cmFsbHkgY29ycmVjdCBpbiBzbyBmYXIgd2UgaW1w
bGVtZW50IHByZXJlcXVpc2l0ZSBmZWF0dXJlcyBmb3IKPiA+ID4gYW55IGdpdmVuIGZlYXR1cmUu
IFRoZSBjcHVpZCBmZWF0dXJlIGJpdHMgc2hvdWxkIGFsc28gYmUgY29ycmVjdCBhcyB3ZQo+ID4g
PiB0ZXN0IHRoZW0gaW50ZXJuYWxseSBpbiBRRU1VIHRvIGVuYWJsZSBmZWF0dXJlcy4KPiA+Cj4g
PiBKdXN0IHRvIGNoZWNrLCBkb2VzIHRoaXMgZW5hYmxlIFZIRT8KPiAKPiBJdCBkb2VzIG5vdC4g
KFdlIGhhdmUgbm8gaW1wbGVtZW50YXRpb24gb2YgVkhFIHlldCAtLSBhcyBhbmQgd2hlbgo+IHdl
IGRvIGltcGxlbWVudCB0aGF0ICItY3B1IG1heCIgd2lsbCB0dXJuIGl0IG9uLCBidXQgdG9kYXkg
aXQgZG9lc24ndC4pCgpPay4gSW4gdGhhdCBjYXNlLCB0aGUga2VybmVsIHNob3VsZCBkcm9wIHRv
IEVMMU4gYW5kIHN0YXkgdGhlcmUgYWZ0ZXIgaXQKY29uZmlndXJlcyBFTDIuCgpUaGVyZSBhcmUg
bm8gcG9pbnRlciBhdXRoZW50aWNhdGlvbiB0cmFwcyB0YWtlbiB0byBFTDFOLCBzbyBpZiBzb21l
dGhpbmcKaXMgZ29pbmcgd3JvbmcsIEkgc3VzcGVjdCBlaXRoZXI6CgoqIGEgdHJhcCBpcyB0YWtl
biB0byBFTDIsIGFuZCB3ZSBoeXBfcGFuaWMoKQoqIGFuIFVOREVGIGlzIGJlaW5nIHRha2VuIHRv
IEVMMU4KClRoYW5rcywKTWFyay4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
