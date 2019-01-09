Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:50:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063E2206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qa5+Q1Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063E2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j6UowEpnldoQ2Bw05zFN+MrPos5xHNvJ2ojL89d1fqc=; b=Qa5+Q1VjWocWq5
	rJ1UEfyi91FmYDp7Yp9rgzD0BfZjEn3EgCvFvLFrCfwV3ykDCa3ZhjVHlFyvmVpot9bOPjQBaMS2P
	GR6dCkHUSJfvDxvsStB+Hp1rONH5f5KSjX6i0PtRNBwwFoSAfEgdH8TXlnpa5ymcHco6ZgaM6j1QI
	t5AKIjsKE4tNlJgTIikQMgoRWiZMNH862bFiqjdeIIpJN5y1WjzOcZYUNw9/UyLg6gqzDk2QG+ERi
	ZJdKPOs/fDI295NiyRzR8Fg9TGRJ13zJT6pXT6Nag4UgU+/7Db/XxjzKjHo8tReZRQzQU8jfvDqX0
	e5uzLe9iyZc1KwoydhRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghH3T-0003Xz-5Z; Wed, 09 Jan 2019 16:50:11 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghH3Q-0003Ny-3u
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:50:09 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 5984F80C5;
 Wed,  9 Jan 2019 16:50:13 +0000 (UTC)
Date: Wed, 9 Jan 2019 08:50:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109165004.GQ5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
 <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_085008_205253_23B46511 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiBbMTkwMTA5IDE2
OjQ4XToKPiBPbiBXZWQsIDkgSmFuIDIwMTkgYXQgMTc6MjgsIFRvbnkgTGluZGdyZW4gPHRvbnlA
YXRvbWlkZS5jb20+IHdyb3RlOgo+ID4KPiA+ICogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBr
ZXJuZWwub3JnPiBbMTkwMTA5IDA5OjQ0XToKPiA+ID4gT24gV2VkLCBKYW4gOSwgMjAxOSBhdCAy
OjUxIEFNIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4g
PiA+ID4gKiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiBbMTkw
MTA5IDAxOjQyXToKPiA+ID4gPiA+IExlIFR1ZXNkYXkgMDggSmFuIDIwMTkgw6AgMTM6Mzc6NDMg
KC0wODAwKSwgVG9ueSBMaW5kZ3JlbiBhIMOpY3JpdCA6Cj4gPiA+ID4gPiA+IExvd2VyaW5nIHRo
ZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3b3JrIGFnYWlu
Lgo+ID4gPiA+ID4gPiBBbnl0aGluZyBoaWdoZXIgdGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVo
b3cgdGltZSBvdXQgaW1tZWRpYXRlbHkKPiA+ID4gPiA+ID4gbm93IDopCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhpcyBpcyBxdWl0ZSBjbG9zZSB0byB0aGUgbWF4IG5zIG9mIGFuIGludCBvbiBhcm0g
MzJiaXRzCj4gPiA+ID4gPgo+ID4gPiA+ID4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cg
Pwo+ID4gPiA+Cj4gPiA+ID4gWXVwIGdyZWF0IHRoYW5rcywgdGhhdCdzIGl0Ogo+ID4gPiA+Cj4g
PiA+ID4gVGVzdGVkLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgo+ID4gPgo+
ID4gPiBDb29sLiAgVGhhbmtzIGZvciBnZXR0aW5nIHRvIHRoZSBib3R0b20gb2YgdGhpcyEKPiA+
Cj4gPiBObyBwcm9ibGVtLgo+ID4KPiA+IE9uZSBtb3JlIHRoaW5nIEkgbm90aWNlZDogVGhlIDI1
JSBzbGFjayBjYW4gZ2V0IG5vdGljZWFibGUKPiA+IGZvciBsYXJnZXIgdmFsdWVzLiBGb3IgdGhp
bmdzIGxpa2UgYSAzIHNlY29uZCB1YXJ0IGNvbnNvbGUKPiA+IHRpbWVvdXQgc2xhY2sgb2YgNzUw
IG1zIGlzIHF1aXRlIGxhcmdlIHZhcmlhdGlvbi4KPiA+Cj4gPiBTaG91bGQgd2UgaGF2ZSBhIGxp
bWl0IG9mIG1heCAxMDAgbXMgZm9yIHRoZSBzbGFjaz8KPiAKPiBLZWVwIGluIG1pbmQgdGhhdCB3
aGVuIGppZmZpZXMgd2VyZSB1c2VkLCBleHBpcmVzIHdhcyByb3VuZGVkIHRvIGEKPiBmdWxsIHNl
Y29uZCB3aGVuIGRlbGF5IHdhcyBncmVhdGVyIHRoYW4gYSBzZWNvbmQuIFNvIHlvdSBjb3VsZCBh
bHJlYWR5Cj4gaGF2ZSBkaWZmZXJlbmNlIG9mIHVwIDk5MG1zIG9uIGFybSBiZWZvcmUgdGhpcyBw
YXRjaAo+IEFuZCBpIGRvbid0IHRha2UgaW50byBhY2NvdW50IHRoZSByZXdvcmsgb2YgdGltZXIg
aW5mcmEgd2hpY2ggYWRkCj4gYW5vdGhlciBsZXZlbCBvZiB2YXJpYXRpb24sIHNvbWV0aGluZyBs
aWtlIHVwIHRvIDY0MCBtcyBtb3JlIHdoZW4gdGhlCj4gdGltZXIgaXMgZ3JlYXRlciB0aGFuIDI4
ODAgbXMgZm9yIGFybSBJSVJDCgpJIHRoaW5rIGl0IHdhcyByb3VuZGVkIHVwIGVhcmxpZXIuCgpE
b24ndCB3ZSBnZXQgcm91bmRlZCBkb3duIG5vdyBhbHNvPwoKUmVnYXJkcywKClRvbnkKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
