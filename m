Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3B3214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bDrDn/3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3B3214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DrW+NC3ZqQASmr6QmLDehX/Vz2SmsPL5oOAQIl4Dro=; b=bDrDn/3wWcczPx
	Mb05abzGDHDvaHtxve/hbCfNXiD1JZboEDoiBmvZFSSJTj1LQkDMjfME9vw0Zed7rWQBJjcYzYlrc
	DZDnDHYPvNwJcYRrCGD9P/plag2a1x5QKArPmg/qCHfGQFijZdT8BZo/rVnx40YvO1GbaMRQ1lQA6
	zZubueWnm75PiO+e7QiJoh9waGeMHdlpjSJgqZBdjTd2WQL7lUV5sq9IV2Zezqtf145OCc1wU7J1a
	28PDG0umub5vpaeZZ7dHG2DYBnWu1vu64tI4u0AzOdxx5FOhdMAyqOKGQSgawi5P6Z5XV9mzf6CvY
	9UP022mTjtX7blouvYGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghGis-00021H-VT; Wed, 09 Jan 2019 16:28:54 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghGip-00020t-GT
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 16:28:52 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id CB48080C5;
 Wed,  9 Jan 2019 16:28:55 +0000 (UTC)
Date: Wed, 9 Jan 2019 08:28:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109162846.GP5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_082851_590789_6B4D9E37 
X-CRM114-Status: UNSURE (   8.60  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+IFsxOTAxMDkgMDk6NDRdOgo+
IE9uIFdlZCwgSmFuIDksIDIwMTkgYXQgMjo1MSBBTSBUb255IExpbmRncmVuIDx0b255QGF0b21p
ZGUuY29tPiB3cm90ZToKPiA+Cj4gPiAqIFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90
QGxpbmFyby5vcmc+IFsxOTAxMDkgMDE6NDJdOgo+ID4gPiBMZSBUdWVzZGF5IDA4IEphbiAyMDE5
IMOgIDEzOjM3OjQzICgtMDgwMCksIFRvbnkgTGluZGdyZW4gYSDDqWNyaXQgOgo+ID4gPiA+IExv
d2VyaW5nIHRoZSBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byAyMTAwIG1zIG1ha2VzIHRoaW5ncyB3
b3JrIGFnYWluLgo+ID4gPiA+IEFueXRoaW5nIGhpZ2hlciB0aGFuIDIyMDAgbXMgc2VlbXMgdG8g
c29tZWhvdyB0aW1lIG91dCBpbW1lZGlhdGVseQo+ID4gPiA+IG5vdyA6KQo+ID4gPgo+ID4gPiBU
aGlzIGlzIHF1aXRlIGNsb3NlIHRvIHRoZSBtYXggbnMgb2YgYW4gaW50IG9uIGFybSAzMmJpdHMK
PiA+ID4KPiA+ID4gQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVsb3cgPwo+ID4KPiA+IFl1cCBn
cmVhdCB0aGFua3MsIHRoYXQncyBpdDoKPiA+Cj4gPiBUZXN0ZWQtYnk6IFRvbnkgTGluZGdyZW4g
PHRvbnlAYXRvbWlkZS5jb20+Cj4gCj4gQ29vbC4gIFRoYW5rcyBmb3IgZ2V0dGluZyB0byB0aGUg
Ym90dG9tIG9mIHRoaXMhCgpObyBwcm9ibGVtLgoKT25lIG1vcmUgdGhpbmcgSSBub3RpY2VkOiBU
aGUgMjUlIHNsYWNrIGNhbiBnZXQgbm90aWNlYWJsZQpmb3IgbGFyZ2VyIHZhbHVlcy4gRm9yIHRo
aW5ncyBsaWtlIGEgMyBzZWNvbmQgdWFydCBjb25zb2xlCnRpbWVvdXQgc2xhY2sgb2YgNzUwIG1z
IGlzIHF1aXRlIGxhcmdlIHZhcmlhdGlvbi4KClNob3VsZCB3ZSBoYXZlIGEgbGltaXQgb2YgbWF4
IDEwMCBtcyBmb3IgdGhlIHNsYWNrPwoKUmVnYXJkcywKClRvbnkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
