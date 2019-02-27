Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB58C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:41:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B1020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VEfseaeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B1020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kg6D7wNfwiUI6mhuvY1CuUWDKeUcqoOmvuha6A1PUhI=; b=VEfseaeOiH1jf6
	NYZ9qTYTsP6bKhydjcyCy3bK9fPo/kGieCo9jr8PlVdVAIOjp+BbSuJf1oZuLyB+mvkQKvWFIkT/e
	GoIlTkLeU2r448OdMuhGIT7XWQp6iBD22rIW27/t7Qn6nrjVvC+r9xOjN9V58QRzPhVgKn6dVT7hk
	LJg/tGfi60NxkK8R6SroarQSN7m4OHy3bG771L0QphCMlMa94yER2WDmswUz7FGe4SDOCPqEi88NG
	Ewhi4UNRteMwxGs3dyKX5/pVxY+pKdca7rcaBfHlErBvOIsZB7I0jeMZ8kCZhoOA6A78A+rxFM1p+
	TPZOPWzErXr7JrgJzfzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvi4-0008DB-Vu; Wed, 27 Feb 2019 09:41:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvi2-00084m-Cn
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:41:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9081596;
 Wed, 27 Feb 2019 01:41:00 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7FC3F575;
 Wed, 27 Feb 2019 01:41:00 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
 id 6386D6800FA; Wed, 27 Feb 2019 09:40:58 +0000 (GMT)
Date: Wed, 27 Feb 2019 09:40:58 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] drm: hdlcd: Stop failing atomic disable check
Message-ID: <20190227094058.GI25147@e110455-lin.cambridge.arm.com>
References: <57a68c52732f1b463b036168d2d53737821d1087.1550862776.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57a68c52732f1b463b036168d2d53737821d1087.1550862776.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_014102_444591_5FD3EAEB 
X-CRM114-Status: GOOD (  24.23  )
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
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iaW4sCgpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIHJldmlld2luZyB0aGlzIHBhdGNoLCBJ
IGFtIGRyb3duaW5nIGEgYml0IHRoaXMKd2VlayBpbiBtZWV0aW5ncyA6KQoKT24gTW9uLCBGZWIg
MjUsIDIwMTkgYXQgMDI6Mzk6MTNQTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IFdoZW4g
X19kcm1fYXRvbWljX2hlbHBlcl9kaXNhYmxlX2FsbCgpIHRyaWVzIHRvIGNvbW1pdCB0aGUgZGlz
YWJsZWQKPiBzdGF0ZSwgd2UgZW5kIHVwIGluIGhkbGNkX2NydGNfYXRvbWljX2NoZWNrKCkgd2l0
aCBhIG1vZGUgY2xvY2sgcmF0ZQo+IG9mIDAuIElmIHRoZSBpbnB1dCBjbG9jayBoYXMgYSBub256
ZXJvIG1pbmltdW0gcmF0ZSwgdGhpcyBmYWlscyB0aGUKPiBjbGtfcm91bmRfcmF0ZSgpIGNoZWNr
IGFuZCBwcmV2ZW50cyB0aGUgQ1JUQyBiZWluZyB0b3JuIGRvd24gY2xlYW5seS4KPiAKPiBJZiB3
ZSdyZSBkaXNhYmxpbmcgdGhlIG91dHB1dCwgdGhvdWdoLCB0aGVuIHRoZSBjbG9jayByYXRlIHNo
b3VsZCBiZQo+IHByZXR0eSBtdWNoIGlycmVsZXZhbnQsIHNvIHNraXAgaXQgaW4gdGhhdCBjYXNl
LiBUaGUga2VybmVsZG9jIHNlZW1zCj4gdG8gaW1wbHkgdGhhdCB3ZSBwcm9iYWJseSBzaG91bGRu
J3QgYmUgbG9va2luZyBhdCB0aGUgcmVzdCBvZiB0aGUKPiBzdGF0ZSBhbnl3YXkgaWYgZW5hYmxl
PWZhbHNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+CgpBY2tlZC1ieTogTGl2aXUgRHVkYXUgPGxpdml1LmR1ZGF1QGFybS5jb20+CgoKSSds
bCBwdWxsIHlvdXIgcGF0Y2ggaW50byBteSB0cmVlIGJ1dCBpdCB3aWxsIGJlIGFmdGVyIHY1LjEt
cmMxIHRoYXQKSSdsbCBzZW5kIGZpeGVzIHRvIGFpcmxpZWQuCgo+IC0tLQo+IAo+IEknbSBzdGls
bCBvY2Nhc2lvbmFsbHkgdHJ5aW5nIHRvIGdldCB0byB0aGUgYm90dG9tIG9mIHdoeSB0aGUgSERM
Q0Qgb24KPiBKdW5vIGRvZXNuJ3Qgd29yayBwcm9wZXJseSB3aXRoIHJlY2VudCB1cHN0cmVhbSBF
REsyICh0aGUgTGludXggZHJpdmVyCj4gdGhpbmtzIGl0J3MgaW5pdGlhbGlzZWQgYW5kIHRha2Vu
IG92ZXIsIGJ1dCB0aGUgaGFyZHdhcmUgc3RheXMgc3R1Y2sKPiBkaXNwbGF5aW5nIHRoZSBsYXN0
IGNvbnRlbnRzIG9mIHRoZSBFRkkgZnJhbWVidWZmZXIpLiBJIHdhcyBob3BpbmcgdGhhdAo+IGp1
c3QgdW5iaW5kaW5nIGFuZCByZXByb2JpbmcgdGhlIEhETENEL1REQTk5OHggZHJpdmVycyBtaWdo
dCBoZWxwIHJlc2V0Cj4gdGhpbmdzIGhhcmQgZW5vdWdoIHRvIHN0YXJ0IHdvcmtpbmcgYWdhaW4s
IGJ1dCBzYWRseSBuby4uLgoKSSB0aGluayBib3RoIEhETENEIGFuZCBNYWxpIERQIGRyaXZlcnMg
bWlzYmVoYXZlIHdoZW4gdGhlIGJvb3Rsb2FkZXIKZW5hYmxlcyB0aGUgZGV2aWNlIGJlZm9yZSB0
aGUgTGludXggZHJpdmVyIHByb2Jlcy4gSSdtIGludGVyZXN0ZWQgaW4Kc29ydGluZyB0aGlzIG9u
ZSBvdXQgYW5kIGl0IGludm9sdmVzIHRhbGtpbmcgdG8gdGhlIFNNTVUgYXMgd2VsbCwgc28KSSds
bCBnZXQgaW4gdG91Y2ggd2l0aCB5b3Ugb3V0c2lkZSB0aGlzIHRocmVhZCB0byBzZWUgaG93IEkg
Y2FuCnJlcHJvZHVjZSB5b3VyIEVESzIgZW52aXJvbm1lbnQuCgpCZXN0IHJlZ2FyZHMsCkxpdml1
CgoKPiAKPiBSb2Jpbi4KPiAKPiAgZHJpdmVycy9ncHUvZHJtL2FybS9oZGxjZF9jcnRjLmMgfCAz
ICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hcm0vaGRsY2RfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2FybS9o
ZGxjZF9jcnRjLmMKPiBpbmRleCBlNGQ2N2I3MDI0NGQuLjMwYTBkOTU3MGI1NyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2hkbGNkX2NydGMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hcm0vaGRsY2RfY3J0Yy5jCj4gQEAgLTE5Myw2ICsxOTMsOSBAQCBzdGF0aWMgaW50IGhk
bGNkX2NydGNfYXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKPiAgCXN0cnVjdCBk
cm1fZGlzcGxheV9tb2RlICptb2RlID0gJnN0YXRlLT5hZGp1c3RlZF9tb2RlOwo+ICAJbG9uZyBy
YXRlLCBjbGtfcmF0ZSA9IG1vZGUtPmNsb2NrICogMTAwMDsKPiAgCj4gKwlpZiAoIXN0YXRlLT5l
bmFibGUpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICAJcmF0ZSA9IGNsa19yb3VuZF9yYXRlKGhkbGNk
LT5jbGssIGNsa19yYXRlKTsKPiAgCWlmIChyYXRlICE9IGNsa19yYXRlKSB7Cj4gIAkJLyogY2xv
Y2sgcmVxdWlyZWQgYnkgbW9kZSBub3Qgc3VwcG9ydGVkIGJ5IGhhcmR3YXJlICovCj4gLS0gCj4g
Mi4yMC4xLmRpcnR5Cj4gCgotLSAKPT09PT09PT09PT09PT09PT09PT0KfCBJIHdvdWxkIGxpa2Ug
dG8gfAp8IGZpeCB0aGUgd29ybGQsICB8CnwgYnV0IHRoZXkncmUgbm90IHwKfCBnaXZpbmcgbWUg
dGhlICAgfAogXCBzb3VyY2UgY29kZSEgIC8KICAtLS0tLS0tLS0tLS0tLS0KICAgIMKvXF8o44OE
KV8vwq8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
