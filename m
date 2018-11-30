Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F03C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D952E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BS3nUuEk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPpvutzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QGZjFUxDtYtGrJ/ThNWuSzqFgjXASgkhXLOYcsuKoSA=; b=BS3nUuEkQLxP8t
	dJNOef5OtWlMGBTy9GMZAuPglKBYhw9vRweqmT5RYde+3Qi3YZVlnXqY7XiZyxaRnSRAWAF90x7z1
	C7H9VNqmamSgabgPoufly5bl1EVwjU73GbQsO5GjAUl2uYHPfF56nwYY8ebuF3C8lp/zz47lFoRJp
	HDBBYAa1mXgyd4UeTpVF/MedTdTTk+E0emK+UJLOv97e4/w01hNM/4G304/C7L9wNsrWPZjXpuknw
	hfQ+VCzi2R4uWobLszAWXgqDtUoSyR1gy+tJkA8ZXYFjxvxjiI/MLVyQPvY2HNN5GeVxzVmdVZiND
	0pu+ZSrdBdiUFbSAHn7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdyq-0001UC-S6; Fri, 30 Nov 2018 08:16:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdyi-0001Ds-N8
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:16:50 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19E51206B7;
 Fri, 30 Nov 2018 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543565798;
 bh=TO0T4SzivIpQeoHDCzPgm4w+v6PSc+ghOTE5fXmyclY=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=fPpvutzv6AwMQy1Lou+YmR74oqGJbrhqB9cNpbEJn8kLBzdKp7QLzC+Md5CaubC4h
 v6fkO1ysqfP3Nh8fndksxbVi9bfe1b0ybSyHkVqaqe8kBjAglW6Zu3fizBslVRN00s
 rpLuoLbqDESVckWFCMyu7DMOaSexMjuF9yku1Dik=
MIME-Version: 1.0
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Message-ID: <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
Date: Fri, 30 Nov 2018 00:16:37 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_001648_972571_37917B5A 
X-CRM114-Status: GOOD (  17.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UXVvdGluZyBTdWdheWEsIFRhaWNoaSAoMjAxOC0xMS0yOSAwNDoyNDo1MSkKPiBPbiAyMDE4LzEx
LzI4IDExOjAxLCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4gPiBRdW90aW5nIFN1Z2F5YSBUYWljaGkg
KDIwMTgtMTEtMTggMTc6MDE6MDcpCj4gPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9zb2Npb25leHQvc29jaW9uZXh0LG0xMHYudHh0
Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9zb2Npb25leHQvc29jaW9uZXh0LG0xMHYudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9zb2Npb25leHQvc29jaW9uZXh0LG0xMHYudHh0Cj4gPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPiA+PiBpbmRleCAwMDAwMDAwLi5mNWQ5MDZjCj4gPj4gLS0tIC9kZXYv
bnVsbAo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mvc29j
aW9uZXh0L3NvY2lvbmV4dCxtMTB2LnR4dAo+ID4+IEBAIC0wLDAgKzEsMTIgQEAKPiA+PiArU29j
aW9uZXh0IE0xMFYgU01QIHRyYW1wb2xpbmUgZHJpdmVyIGJpbmRpbmcKPiA+PiArCj4gPj4gK1Ro
aXMgaXMgYSBkcml2ZXIgdG8gd2FpdCBmb3Igc3ViLWNvcmVzIHdoaWxlIGJvb3QgcHJvY2Vzcy4K
PiA+PiArCj4gPj4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJzb2Npb25leHQsc21wLXRyYW1w
b2xpbmUiCj4gPj4gKy0gcmVnOiBzaG91bGQgYmUgPDB4NEMwMDAxMDAgMHgxMDA+Cj4gPj4gKwo+
ID4+ICtFWEFNUExFCj4gPj4gKyAgICAgICB0cmFtcG9saW5lOiB0cmFtcG9saW5lQDB4NEMwMDAx
MDAgewo+ID4gRHJvcCB0aGUgMHggcGFydCBvZiB1bml0IGFkZHJlc3Nlcy4KPiAKPiBPa2F5Lgo+
IAo+IAo+ID4+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNvY2lvbmV4dCxzbXAtdHJh
bXBvbGluZSI7Cj4gPj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDRDMDAwMTAwIDB4MTAwPjsK
PiA+IExvb2tzIGxpa2UgYSBzb2Z0d2FyZSBjb25zdHJ1Y3QsIHdoaWNoIHdlIHdvdWxkbid0IHdh
bnQgdG8gcHV0IGludG8gRFQKPiA+IHRoaXMgd2F5LiBEVCBkb2Vzbid0IGRlc2NyaWJlIGRyaXZl
cnMuCj4gV2Ugd291bGQgbGlrZSB0byB1c2UgdGhpcyBub2RlIG9ubHkgZ2V0dGluZyB0aGUgYWRk
cmVzcyBvZiB0aGUgCj4gdHJhbXBvbGluZSBhcmVhCj4gaW4gd2hpY2ggc3ViLWNvcmVzIHdhaXQu
wqAgKFRoZXkgaGF2ZSBmaW5pc2hlZCB0byBnbyB0byB0aGlzIGFyZWEgaW4gcHJldmlvdXMKPiBi
b290bG9hZGVyIHByb2Nlc3MuKQoKSXMgdGhpcyBhcmVhIHBhcnQgb2YgbWVtb3J5LCBvciBhIHNw
ZWNpYWwgU1JBTT8gSWYgaXQncyBwYXJ0IG9mIG1lbW9yeSwKSSB3b3VsZCBleHBlY3QgdGhpcyBu
b2RlIHRvIGJlIHVuZGVyIHRoZSByZXNlcnZlZC1tZW1vcnkgbm9kZSBhbmQKcG9pbnRlZCB0byBi
eSBzb21lIG90aGVyIG5vZGUgdGhhdCB1c2VzIHRoaXMgcmVnaW9uLiBDb3VsZCBldmVuIGJlIHRo
ZQpDUFUgbm9kZXMuCgo+IAo+IFNvIHNob3VsZCB3ZSBlbWJlZCB0aGUgY29uc3RhbnQgdmFsdWUg
aW4gc291cmNlIGNvZGVzIGluc3RlYWQgb2YgZ2V0dGluZyAKPiBmcm9tCj4gRFQgYmVjYXVzZSB0
aGUgYWRkcmVzcyBpcyBjb25zdGFudCBhdCB0aGUgbW9tZW50PyBPciBpcyB0aGVyZSBvdGhlciAK
PiBhcHByb2FjaD8KPiAKCklmIGl0J3MgY29uc3RhbnQgdGhlbiB0aGF0IGFsc28gd29ya3MuIFdo
eSBkb2VzIGl0IG5lZWQgdG8gY29tZSBmcm9tIERUCmF0IGFsbCB0aGVuPwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
