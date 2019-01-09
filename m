Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA493C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40E4206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ec/cH5Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40E4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ttX6pwwPHO338dVoDbSCRtW63+TkJb1XHtjtOD+xxVU=; b=Ec/cH5Cdj6lDOp
	xtZBwYfaxXYnEl+6df+p9OD1Mf1VoIbgm4heUESvaaG1t9jPdapP/jBNBmcRfoRL5NeeYFRBnN1Bg
	wl0PDn2fl1z8nASXb9y9pTsofM2e+Kyz74fAH5eRCF/KgBmRdKZjlVmP9VGn5QlKOi5DmDCldZOH3
	S8l2j7s5RpxISxHT7hZDzbx95+LmMQwiQhdhDA25kRF2KX37XVSN8bUj1KVCCWMuLAwxPU+u7Gdvd
	FP/titgoO4R90Q0ExHKjf7fvGd0zmZCTNHM9wM+KhBFAlzT+PfQlRvQ4UcInHtbq0+uIas1g8S+3a
	C+O4UIMIzYvdNmfrFSag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHF7-0000SO-Di; Wed, 09 Jan 2019 17:02:13 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHF4-0000Rn-5x
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 17:02:12 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 605A580C5;
 Wed,  9 Jan 2019 17:02:15 +0000 (UTC)
Date: Wed, 9 Jan 2019 09:02:06 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109170206.GS5544@atomide.com>
References: <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
 <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
 <20190109165004.GQ5544@atomide.com>
 <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_090210_257097_B946E4BE 
X-CRM114-Status: GOOD (  16.18  )
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
OjU2XToKPiBPbiBXZWQsIDkgSmFuIDIwMTkgYXQgMTc6NTAsIFRvbnkgTGluZGdyZW4gPHRvbnlA
YXRvbWlkZS5jb20+IHdyb3RlOgo+ID4KPiA+ICogVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1
aXR0b3RAbGluYXJvLm9yZz4gWzE5MDEwOSAxNjo0OF06Cj4gPiA+IE9uIFdlZCwgOSBKYW4gMjAx
OSBhdCAxNzoyOCwgVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4gd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiAqIFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4gWzE5MDEw
OSAwOTo0NF06Cj4gPiA+ID4gPiBPbiBXZWQsIEphbiA5LCAyMDE5IGF0IDI6NTEgQU0gVG9ueSBM
aW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ICogVmluY2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4gWzE5MDEwOSAw
MTo0Ml06Cj4gPiA+ID4gPiA+ID4gTGUgVHVlc2RheSAwOCBKYW4gMjAxOSDDoCAxMzozNzo0MyAo
LTA4MDApLCBUb255IExpbmRncmVuIGEgw6ljcml0IDoKPiA+ID4gPiA+ID4gPiA+IExvd2VyaW5n
IHRoZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3b3JrIGFn
YWluLgo+ID4gPiA+ID4gPiA+ID4gQW55dGhpbmcgaGlnaGVyIHRoYW4gMjIwMCBtcyBzZWVtcyB0
byBzb21laG93IHRpbWUgb3V0IGltbWVkaWF0ZWx5Cj4gPiA+ID4gPiA+ID4gPiBub3cgOikKPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoaXMgaXMgcXVpdGUgY2xvc2UgdG8gdGhlIG1heCBu
cyBvZiBhbiBpbnQgb24gYXJtIDMyYml0cwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQ291
bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBZdXAg
Z3JlYXQgdGhhbmtzLCB0aGF0J3MgaXQ6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRlc3RlZC1i
eTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBD
b29sLiAgVGhhbmtzIGZvciBnZXR0aW5nIHRvIHRoZSBib3R0b20gb2YgdGhpcyEKPiA+ID4gPgo+
ID4gPiA+IE5vIHByb2JsZW0uCj4gPiA+ID4KPiA+ID4gPiBPbmUgbW9yZSB0aGluZyBJIG5vdGlj
ZWQ6IFRoZSAyNSUgc2xhY2sgY2FuIGdldCBub3RpY2VhYmxlCj4gPiA+ID4gZm9yIGxhcmdlciB2
YWx1ZXMuIEZvciB0aGluZ3MgbGlrZSBhIDMgc2Vjb25kIHVhcnQgY29uc29sZQo+ID4gPiA+IHRp
bWVvdXQgc2xhY2sgb2YgNzUwIG1zIGlzIHF1aXRlIGxhcmdlIHZhcmlhdGlvbi4KPiA+ID4gPgo+
ID4gPiA+IFNob3VsZCB3ZSBoYXZlIGEgbGltaXQgb2YgbWF4IDEwMCBtcyBmb3IgdGhlIHNsYWNr
Pwo+ID4gPgo+ID4gPiBLZWVwIGluIG1pbmQgdGhhdCB3aGVuIGppZmZpZXMgd2VyZSB1c2VkLCBl
eHBpcmVzIHdhcyByb3VuZGVkIHRvIGEKPiA+ID4gZnVsbCBzZWNvbmQgd2hlbiBkZWxheSB3YXMg
Z3JlYXRlciB0aGFuIGEgc2Vjb25kLiBTbyB5b3UgY291bGQgYWxyZWFkeQo+ID4gPiBoYXZlIGRp
ZmZlcmVuY2Ugb2YgdXAgOTkwbXMgb24gYXJtIGJlZm9yZSB0aGlzIHBhdGNoCj4gPiA+IEFuZCBp
IGRvbid0IHRha2UgaW50byBhY2NvdW50IHRoZSByZXdvcmsgb2YgdGltZXIgaW5mcmEgd2hpY2gg
YWRkCj4gPiA+IGFub3RoZXIgbGV2ZWwgb2YgdmFyaWF0aW9uLCBzb21ldGhpbmcgbGlrZSB1cCB0
byA2NDAgbXMgbW9yZSB3aGVuIHRoZQo+ID4gPiB0aW1lciBpcyBncmVhdGVyIHRoYW4gMjg4MCBt
cyBmb3IgYXJtIElJUkMKPiA+Cj4gPiBJIHRoaW5rIGl0IHdhcyByb3VuZGVkIHVwIGVhcmxpZXIu
Cj4gPgo+ID4gRG9uJ3Qgd2UgZ2V0IHJvdW5kZWQgZG93biBub3cgYWxzbz8KPiAKPiBXZSBzdGls
bCByb3VuZCB1cC4gSW4gaHJ0aW1lciB3ZSBoYXZlIDoKPiB0aW1lci0+X3NvZnRleHBpcmVzID0g
dGltZTsKPiB0aW1lci0+bm9kZS5leHBpcmVzID0ga3RpbWVfYWRkX3NhZmUodGltZSwgZGVsdGEp
Owo+IHNvIHRoZSBocnRpbWVyIHdpbGwgZXhwaXJlIGJldHdlZW4gInRpbWUiIGFuZCAidGltZStk
ZWx0YSIKCk9LIHRoYW5rcyBmb3IgY2hlY2tpbmcgaXQuIEluIHRoYXQgY2FzZSB3ZSBzaG91bGQg
YmUgZ29vZCB0byBnbyA6KQoKVG9ueQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
