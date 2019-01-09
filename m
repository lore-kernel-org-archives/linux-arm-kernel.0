Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DD5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A918921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejx8BVdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A918921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCOgbHJEEpp21TO1NbF5GjS2g5oV8BQW5Nbh3VpGMtQ=; b=ejx8BVdIq641an
	1ky5SAFyMIsIzr2CDLXbcBsvNculYxXmbAP+t1trxFrXVY3sD2xuRECupPvBkCHqlb5q4aGmcZxCM
	7a14qeqGdgC/dO1LJ8VaMTEzTyca80kcF0/MTgV5X+UW3XC3zvLmp63xAP+RVqyefaJz2+A53pGnL
	w437G5A4USoDPLSpg/ReSzbBBohHWgWfOCA9s4wgF7MtC8Db6uQQt5GNGU8205iyX77cOT8+WyQ/Q
	siw+7KhNrcS34CTmWNsWwOo4T7wJs0JzjSbEqwvBBUnvJP9tXoQ0JIlnfpbTPGlkmEQUalsmjuMD9
	mE9Dy20RbRHvspsKUaUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh31q-0001E5-N5; Wed, 09 Jan 2019 01:51:34 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh31m-0001D7-Qj
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 01:51:32 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 529638080;
 Wed,  9 Jan 2019 01:51:33 +0000 (UTC)
Date: Tue, 8 Jan 2019 17:51:24 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109015124.GO5544@atomide.com>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109014218.GA8363@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_175130_909821_E87F225D 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

KiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPiBbMTkwMTA5IDAx
OjQyXToKPiBMZSBUdWVzZGF5IDA4IEphbiAyMDE5IMOgIDEzOjM3OjQzICgtMDgwMCksIFRvbnkg
TGluZGdyZW4gYSDDqWNyaXQgOgo+ID4gTG93ZXJpbmcgdGhlIGF1dG9zdXNwZW5kX2RlbGF5X21z
IHRvIDIxMDAgbXMgbWFrZXMgdGhpbmdzIHdvcmsgYWdhaW4uCj4gPiBBbnl0aGluZyBoaWdoZXIg
dGhhbiAyMjAwIG1zIHNlZW1zIHRvIHNvbWVob3cgdGltZSBvdXQgaW1tZWRpYXRlbHkKPiA+IG5v
dyA6KQo+IAo+IFRoaXMgaXMgcXVpdGUgY2xvc2UgdG8gdGhlIG1heCBucyBvZiBhbiBpbnQgb24g
YXJtIDMyYml0cwo+IAo+IENvdWxkIHlvdSB0cnkgdGhlIHBhdGNoIGJlbG93ID8KCll1cCBncmVh
dCB0aGFua3MsIHRoYXQncyBpdDoKClRlc3RlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9t
aWRlLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1lLmMgfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIGIvZHJpdmVycy9iYXNlL3Bvd2Vy
L3J1bnRpbWUuYwo+IGluZGV4IDcwNjI0NjkuLjQ0YzVjNzYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9iYXNlL3Bvd2VyL3J1bnRpbWUuYwo+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9ydW50aW1l
LmMKPiBAQCAtMTQxLDcgKzE0MSw3IEBAIHU2NCBwbV9ydW50aW1lX2F1dG9zdXNwZW5kX2V4cGly
YXRpb24oc3RydWN0IGRldmljZSAqZGV2KQo+ICAKPiAgCWxhc3RfYnVzeSA9IFJFQURfT05DRShk
ZXYtPnBvd2VyLmxhc3RfYnVzeSk7Cj4gIAo+IC0JZXhwaXJlcyA9IGxhc3RfYnVzeSArIGF1dG9z
dXNwZW5kX2RlbGF5ICogTlNFQ19QRVJfTVNFQzsKPiArCWV4cGlyZXMgPSBsYXN0X2J1c3kgKyAo
dTY0KShhdXRvc3VzcGVuZF9kZWxheSkgKiBOU0VDX1BFUl9NU0VDOwo+ICAJaWYgKGV4cGlyZXMg
PD0gbm93KQo+ICAJCWV4cGlyZXMgPSAwOwkvKiBBbHJlYWR5IGV4cGlyZWQuICovCj4gIAo+IC0t
IAo+IDIuNy40Cj4gCj4gCj4gPiAKPiA+IFJlZ2FyZHMsCj4gPiAKPiA+IFRvbnkKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
