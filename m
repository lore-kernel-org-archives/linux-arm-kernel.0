Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CCDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF4920645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p8BYvyWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF4920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GLOvsUJtmM0L54yEYndUIlxxhDVhGz4wUDzJ8tbwtQs=; b=p8BYvyWypFSyon
	5Ykk34o0/ghQGuWHuDR1fcT3URPxuX+z/PJNgsHJFR6y9RSPxnaS7ZcMN7vFK3UMfMFNWzzi68P43
	bu8WOY1F4RIABOlt/9ZtiSOcbV1L2YTmZQ8ymjqokO+BBqG7smM2bRsJl0/i8vBnDtQsS9grc/COg
	yJhMpleN77iFEkfxxY20Xm7zs9+zBklkjFWY/9tYk8DTvnL2OHEyZaKOcQR6pKT0lyqkqPvzgAaxO
	ViuNEqTd37s2aZPgWbTOL3lbcPtj1D2MRJ15EoooQ0zeAe859T+PFNcHJyEO9xR6keg7RxKpUBSiI
	Tehv32alrkhj/FvDqWfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRyE-0004Xc-2V; Tue, 15 Jan 2019 16:53:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRy5-0004UA-GQ; Tue, 15 Jan 2019 16:53:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 46C5B2078F; Tue, 15 Jan 2019 17:53:36 +0100 (CET)
Received: from xps13 (unknown [77.136.203.173])
 by mail.bootlin.com (Postfix) with ESMTPSA id C426E207A3;
 Tue, 15 Jan 2019 17:53:24 +0100 (CET)
Date: Tue, 15 Jan 2019 17:53:22 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v9 0/2]  mtd: rawnand: meson: add Amlogic NAND driver
 support
Message-ID: <20190115175322.4aa4b5db@xps13>
In-Reply-To: <20190115175232.3d82d4a9@xps13>
References: <1547566684-57472-1-git-send-email-jianxin.pan@amlogic.com>
 <20190115175232.3d82d4a9@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_085337_865003_CE170E24 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+IHdyb3RlIG9uIFR1ZSwg
MTUgSmFuIDIwMTkKMTc6NTI6MzIgKzAxMDA6Cgo+IEhpIEppYW54aW4sCj4gCj4gSmlhbnhpbiBQ
YW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPiB3cm90ZSBvbiBUdWUsIDE1IEphbiAyMDE5Cj4g
MjM6Mzg6MDIgKzA4MDA6Cj4gCj4gPiBUaGVzZSB0d28gcGF0Y2hlcyB0cnkgdG8gYWRkIGluaXRp
YWwgTkFORCBkcml2ZXIgc3VwcG9ydCBmb3IgQW1sb2dpYyBNZXNvbgo+ID4gU29DcywgY3VycmVu
dCBpdCBoYXMgYmVlbiB0ZXN0ZWQgb24gR1hMKHAyMTIpIGFuZCBBWEcoczQwMCkgcGxhdGZvcm0u
Cj4gPiAKPiA+IENoYW5nZXMgc2luY2UgVjggYXQgWzldCj4gPiAgLSBmaXggYnVpbGQgZmFpbHJl
IGF0IG9iamVjdF9pc19vbl9zdGFjawo+ID4gIC0gdXBkYXRlIEtjb25maWcgYXMgTWFydGluJ3Mg
c3VnZ2VzdGVkCj4gCj4gVGhhbmtzIGZvciB0aGlzIGxhc3QgdmVyc2lvbiwgbG9va3MgZ29vZCB0
byBtZS4gQ291bGQgeW91IHBsZWFzZSBzZW5kIGEKPiBwYXRjaCB0byBhZGQgYSBNQUlOVEFJTkVS
UyBlbnRyeT8KCkp1c3QgdG8gYmUgY2xlYXIsIG5vIG5lZWQgdG8gcmVzZW5kIHRoZSBzZXJpZXMu
CgpUaGFua3MsCk1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
