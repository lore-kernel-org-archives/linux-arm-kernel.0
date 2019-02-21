Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FAC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021BB2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZTlTrhWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021BB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acn-group.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xzyV1fhmhpoMjgZv4xXriw/s1HptV4P/4rXo0R82TVc=; b=ZTlTrhWjTrbrZlDu7uItpVZkO
	oVtaBdHlvFHBf2zSzt2+wCEUTeRcQKqKQkRz3HQBgbhy0piER7lky5LUPITSd/Jr8JFPPDPQifgGu
	XGf3D4ZBuQwb5cRvcxgFxY+F8NyXvnl6oYDekvqLeNQKdjog+639QUg7qtjYm10pRBj18V88AWnJp
	VNKYIp1iMy2muuOm4XmzIdK0yT4uKP7cIK7J32+n5pYHt5A+blCBzOeXfZqaxehflR6Ue21Dq0FA/
	hf6WkbcswRGHNm7RBoQPvTieZStYk+kNCcDtwnA7oekGWHiTX9vjGkHB5Z4kF7zidyIIWDZm2fcr+
	DKw4vCe6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwjFy-00047r-Sl; Thu, 21 Feb 2019 07:58:58 +0000
Received: from mail.dns-net.ch ([195.160.190.3] helo=111.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwjFs-00047U-VA
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:58:55 +0000
Received: from [172.16.145.102] (unknown [213.193.93.78])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by 111.com (Postfix) with ESMTPSA id 2F15EACE4C6;
 Thu, 21 Feb 2019 08:50:41 +0100 (CET)
Subject: Re: da850 dt cpufreq support
To: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
 <20190220154658.GP15711@atomide.com>
 <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
From: Christophe Aeschlimann <c.aeschlimann@acn-group.ch>
Message-ID: <18bf329c-b5e3-2d9f-8a7a-065720d187eb@acn-group.ch>
Date: Thu, 21 Feb 2019 08:50:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_235853_170329_E6109E48 
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
 David Lechner <david@lechnology.com>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgMjAuMDIuMjAxOSDDoCAxNjo1OCwgQWRhbSBGb3JkIGEgw6ljcml0wqA6Cj4gT24gV2VkLCBG
ZWIgMjAsIDIwMTkgYXQgOTo0NyBBTSBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPiB3
cm90ZToKPj4KPj4gSGksCj4+Cj4+IEFkZGluZyBCYXJ0b3N6LCBEYXZpZCBhbmQgU2VraGFyIHRv
IENjLgo+Pgo+PiAqIENocmlzdG9waGUgQWVzY2hsaW1hbm4gPGMuYWVzY2hsaW1hbm5AYWNuLWdy
b3VwLmNoPiBbMTkwMjIwIDE1OjM0XToKPj4+IEhpLAo+Pj4KPj4+IEkgdW5kZXJzdGFuZCB0aGF0
IHRvZGF5IHRoZSBkYTg1MC1ldm0gaXMgc3VwcG9ydGVkIGluIHR3byB3YXlzIGluIHRoZQo+Pj4g
S2VybmVsLCB1c2luZyBib2FyZCBmaWxlLCBha2EgImxlZ2FjeSIgYW5kIGRldmljZS10cmVlLgo+
Pj4KPj4+IEFtIEkgcmlnaHQgdG8gc2F5IHRoYXQgd2hlbiB1c2luZyB0aGUgZGV2aWNlLXRyZWUg
dGhlcmUgaXMgbm8gc3VwcG9ydCBmb3IKPj4+IGNwdWZyZXEgYXZhaWxhYmxlID8KPj4+Cj4+PiBU
aGUgInRpLWNwdWZyZXEiIGRyaXZlciBkb2Vzbid0IHRhcmdldCB0aGUgZGE4NTAgU29DIGFuZCB0
aGUKPj4+ICJkYXZpbmNpLWNwdWZyZXEiIGRyaXZlciBkb2Vzbid0IG1ha2UgdXNlIG9mIHRoZSBk
ZXZpY2UtdHJlZSBiaW5kaW5ncy4KPj4+Cj4+PiBDb3VsZCB0aGUgZ2VuZXJpYyAiY3B1ZnJlcS1k
dCIgZHJpdmVyIGJlIHVzZWQgPwo+IAo+IEEgd2hpbGUgYWdvLCBEYXZpZCBMIHBvc3RlZCBhIG1l
c3NhZ2Ugb24gdGhlIG1haWxpbmcgbGlzdCBwb2ludGluZyB0bwo+IGEgZ2l0IHJlcG8gdGhhdCBo
YXQgc29tZSBwYXRjaGVzIHRoYXQgd2VyZW4ndCBtYWlubGluZWQuCj4gCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2RsZWNoL2xpbnV4L3RyZWUvZGE4NTAtZHQtY3B1ZnJlcQo+IAo+IEkgd2FzIGdvaW5n
IHRvIHRyeSBhbmQgdGVzdCB0aGVtLCBidXQgSSBuZXZlciBnb3QgYXJvdW5kIHRvIGl0IGR1ZSB0
bwo+IG90aGVyIHdvcmsgcHJvamVjdHMuCgpUaGFua3MgZm9yIHRoZSBwb2ludGVyLgoKQ2hyaXN0
b3BoZQoKPiAKPiBhZGFtCj4+Pgo+Pj4gQmVzdCByZWdhcmRzLAo+Pj4KPj4+IENocmlzdG9waGUK
Pj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPiAKCgotLSAKQ2hyaXN0b3BoZSBBZXNjaGxpbWFubgoK
RW1iZWRkZWQgU29mdHdhcmUgRW5naW5lZXIgJiBJVCBNYW5hZ2VyCkFDTiBBZHZhbmNlZCBDb21t
dW5pY2F0aW9ucyBOZXR3b3JrcyBTLkEuCjIwMDAgLSBOZXVjaMOidGVsLCBTd2l0emVybGFuZApU
ZWwuICs0MSAzMiA3MjQgNzQgMzEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
