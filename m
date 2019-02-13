Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF693C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE77621924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pjcf3L56";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kGoDZyDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE77621924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Szk2/0S2rltmFbNCktSwTUsavqua1IVxOFaTKJeyeUM=; b=Pjcf3L56wqYS2Y
	SwbAbinh8en+qtgvrmvZUFWquZGrcLfWEIB1aPMtG3GRci4M5DGsEbXWkRyT7TwMIcjZ3z5Tzw7io
	Sn1UminSXK0Tdb0UPYbZMPOdNZEv6BNVcTZ5j53biC9g07MDR7gDkYT19co9Epfc57FiXtwA/2fmn
	jH0qgBDp10Ld6Bhuv3vU+uLg9NFqileTAScfxYJFtHUkPUvda3OOgz+bwFTQ0HSJ0DbIRNZ5utFpz
	3t5y5Dr3biNZoULwrBiu7vWFbiPa545oxIfUoy5+mkqbd/6CwRJdWbkKfqXYRAyEHhqNXgMVrx+ge
	3MffnMpVpGJOEo/32e8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu3Lm-0007oR-O8; Wed, 13 Feb 2019 22:49:54 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu3Lj-0007nj-Kc
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 22:49:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id h1so1897770pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ZHYGGSpla4tBLzpH0Y4QcBdq3Osj4l3L8zG3EvPTVMc=;
 b=kGoDZyDJyazs+QIzo5XzszueRAdEwVjqm8boq63Evusu8ziGfHe7RjyBKiGE7HGIqB
 H5q4+8NLjc1RdvEFvfxx6cl7VjMPZcD4SPhxGyi1UbUohzdHA0BDKWSjPM3GnF+mxQzB
 UETATjKBHqULZCD8M7SxjyzbqOX7GnMNWD10UgBvIXerWf2PyFMu9Q4pcyWqS00zbf4o
 mSRip3p0dFKZL2vTH8ysV+WrRFchxYqAVMEq0Cpciclv0u1n/CzGImDoGR0b7NmpfQoz
 u7luQXfTEqmdRdbvd5QBPI4Lzccy0ZrQbkHWBxqF0Ok7ex6/cSY/UmKDvmItE8wMK1/V
 ajwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ZHYGGSpla4tBLzpH0Y4QcBdq3Osj4l3L8zG3EvPTVMc=;
 b=FRSV02S2+9ZlNVtXIIhaFtxNimcwkO8bTrIA3HJ3nRNGDMPYmVH6JQ51yym6upY2jg
 C3VdHlXKUVW53N71cfPNdUR/iyJK2D0X/mKb73CmicaAOdvs17dYgqkpmVALnxGwwB9h
 DARsNu7tbojEQeSIGvAMdeg73vhfqzC9rJ7f1E2HMmiK3MkgNwQBulkmGmn04wMebx2G
 hfczgwX5FhcTyMou86wT7iUE4BzG0QsEHBvrediOIUH+UbNyg0f/sC1ig1Zhd1MkJWcj
 sVytBH2UO3zRF1I9lVmwOr4c/5XjrWzF2t8Z1rLncaE2PA/jeXr+Dzwj8XTwl429OrAM
 kShg==
X-Gm-Message-State: AHQUAubiiH/vkueHQ09x0GKq8kgUPtR/YKx4h5kBbTTyaw3UM2B+aYQG
 3S8RwWI2wCOVErnlie1yHJJUEg==
X-Google-Smtp-Source: AHgI3IbR2LTfvgiGExkXUXTo8hYv78YRUa5KtFBV+Qe/YlkmN7Y84BZu9fVDh5e59DEiq5iPSGICzQ==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr562853pfn.91.1550098190715;
 Wed, 13 Feb 2019 14:49:50 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:6503:80f2:745d:51b7:a174?
 ([2600:1010:b069:6503:80f2:745d:51b7:a174])
 by smtp.gmail.com with ESMTPSA id g6sm433348pgq.18.2019.02.13.14.49.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 14:49:49 -0800 (PST)
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190213222146.GC32494@hirez.programming.kicks-ass.net>
Date: Wed, 13 Feb 2019 14:49:47 -0800
Message-Id: <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
References: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_144951_813285_2773693B 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 jpoimboe@redhat.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, luto@kernel.org, hpa@zytor.com, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIEZlYiAxMywgMjAxOSwgYXQgMjoyMSBQTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiAKPiBPbiBXZWQsIEZlYiAxMywgMjAxOSBhdCAxMDo1MToy
NEFNIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+PiBPbiBGZWIgMTMsIDIwMTksIGF0
IDc6NDUgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4g
Cj4+PiBXaGljaCBJIHN1cHBvc2UgbWVhbnMgdGhhdCBHQ0MgZ2VuZXJhdGVzIHRoZSBQVVNIRi9Q
T1BGIHRvIHByZXNlcnZlIHRoZQo+Pj4gRUZMQUdTLCBzaW5jZSB3ZSBtYXJrIHRob3NlIGV4cGxp
Y2l0bHkgY2xvYmJlcmVkLgo+Pj4gCj4+IAo+PiBOb3QgcXVpdGUuICBBIGZsYWdzIGNsb2JiZXIg
ZG9lc27igJl0IHNhdmUgdGhlIGNvbnRyb2wgYml0cyBsaWtlIEFDCj4+IGV4Y2VwdCBvbiBjZXJ0
YWluIHJhdGhlciBidWdneSBsbHZtIGNvbXBpbGVycy4gVGhlIGNoYW5nZSB5b3XigJlyZQo+PiBs
b29raW5nIGZvciBpczoKPj4gCj4+IGh0dHA6Ly9naXQua2VybmVsLm9yZy90aXAvMmM3NTc3YTc1
ODM3NDdjOWI3MWYyNmRjZWQ3ZjY5NmI3MzlkYTc0NQo+IAo+IEluZGVlZCwgZmFpbGVkIHRvIGZp
bmQgdGhhdC4KPiAKPj4+IEZvciBhIGxpdHRsZSBiaXQgb2YgY29udGV4dDsgaXQgdHVybnMgb3V0
IHRoYXQgdXNlcl9hY2Nlc3NfYmVnaW4oKSAvCj4+PiB1c2VyX2FjY2Vzc19lbmQoKSBzZXRzIEVG
TEFHUy5BQyBhbmQgc2NoZWR1bGluZyBpbiBiZXR3ZWVuIHRoZXJlIHdyZWNrcwo+Pj4gdGhhdCBi
ZWNhdXNlIHdlJ3JlIGFwcGFyZW50bHkgbm90IHNhdmluZyB0aGF0IGFueW1vcmUuCj4+IAo+PiBC
dXQgb25seSBleHBsaWNpdCBzY2hlZHVsaW5nIOKAlCBwcmVlbXB0aW9uIGFuZCBzbGVlcHkgcGFn
ZSBmYXVsdHMgYXJlCj4+IGZpbmUgYmVjYXVzZSB0aGUgaW50ZXJydXB0IGZyYW1lIHNhdmVzIGZs
YWdzLgo+IAo+IE5vLCBsaWtlIHBvaW50ZWQgb3V0IGVsc2V3aGVyZSBpbiB0aGlzIHRocmVhZCwg
YW55dGhpbmcgdGhhdCBkb2VzCj4gcHJlZW1wdF9kaXNhYmxlKCkgaXMgdXR0ZXJseSBicm9rZW4g
d2l0aCB0aGlzLgo+IAo+IEJlY2F1c2UgYXQgdGhhdCBwb2ludCB0aGUgSVJRIHJldHVybiBwYXRo
IGRvZXNuJ3QgcmVzY2hlZHVsZSBidXQKPiBwcmVlbXB0X2VuYWJsZSgpIHdpbGwsIGFuZCB0aGF0
IGRvZXNuJ3QgcHJlc2VydmUgRUZMQUdTIGFnYWluLgo+IAo+Pj4gTm93LCBJJ20gdGVtcHRlZCB0
byBhZGQgdGhlIFBVU0hGIC8gUE9QRiByaWdodCBiYWNrIGJlY2F1c2Ugb2YgdGhpcywgYnV0Cj4+
PiBmaXJzdCBJIHN1cHBvc2Ugd2UgbmVlZCB0byBmaWd1cmUgb3V0IGlmIHRoYXQgY2hhbmdlIHdh
cyBvbiBwdXJwb3NlIGFuZAo+Pj4gd2h5IHRoYXQgd2VudCBtaXNzaW5nIGZyb20gdGhlIENoYW5n
ZWxvZy4KPj4gCj4+IFRoYXTigJlzIGNlcnRhaW5seSB0aGUgZWFzeSBzb2x1dGlvbi4gT3Igd2Ug
Y291bGQgdGVhY2ggdGhlIG1pZ2h0X3NsZWVwCj4+IGNoZWNrcyBhYm91dCB0aGlzLCBidXQgdGhh
dCBjb3VsZCBiZSBhIG1lc3MuCj4gCj4gVGhhdCdzIG5vdCBlbm91Z2gsIHdlJ2QgaGF2ZSB0byB0
ZWFjaCBwcmVlbXB0X2Rpc2FibGUoKSwgYnV0IHdvcnNlLAo+IHByZWVtcHRfZGlzYWJsZV9ub3Ry
YWNlKCkuCj4gCj4gQW55dGhpbmcgdGhhdCBsYW5kcyBpbiBmdHJhY2UsIHdoaWNoIF93aWxsXyB1
c2UKPiBwcmVlbXB0X2Rpc2FibGVfbm90cmFjZSgpLCB3aWxsIHNjcmV3IHRoaXMgdGhpbmcgdXAu
CgpVZ2guICBDb25zaWRlciB5b3VyIHBhdGNoIGFja2VkLiAgRG8gd2UgbmVlZCB0byBiYWNrcG9y
dCB0aGlzIHRoaW5nPyAgVGhlIHByb2JsZW0gY2Fu4oCZdCBiZSB0b28gd2lkZXNwcmVhZCBvciB3
ZSB3b3VsZCBoYXZlIGhlYXJkIG9mIGl0IGJlZm9yZS4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
