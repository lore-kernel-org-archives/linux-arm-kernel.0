Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176B320883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NM5uN1eB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGyizKUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176B320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7oAVdsBWzkBKXfLwM+N2ezcCqbk5TKKdC1EgefnQMo=; b=NM5uN1eBgBdtbk
	ooi9N5KORY25Px2I5Tq21HWMmReTqlvte89SCNz62p1aBVmQufEQzWXJGYoIF5sxwWyWrnnDAYOfJ
	c9dKdgfLzpPXV8oXYoZ5oZlpvyIYxZDP+C8JjWkHLi0zuueGVI9Fuki3ltFaeYRjTRgCgrbiG/Pjt
	I9bnlPQIm56t0RGRMRUJa02qA7XmA4RtiCjtJbalA+RKtXobOCAB+D5+p4Kt0hJdVmsZ2Rr6qWRBR
	5QbQKfd+R/g0XEqJxunFAcYW1q+wwn87g/OCIPvp4LvzUCsKH+CsUx6HjeFKCA5nQsCQ1Wj9n5X/a
	aWyx9VBoFcAXY9vLMd/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvIB-00060U-Gu; Tue, 08 Jan 2019 17:35:55 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvI6-0005yq-UU; Tue, 08 Jan 2019 17:35:52 +0000
Received: by mail-qt1-x841.google.com with SMTP id p17so5270361qtl.5;
 Tue, 08 Jan 2019 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bQeG/bTYFgG4QFMLKTEBa9/B0VgVbffUqu5K1tWUHxA=;
 b=DGyizKUSlAGBIEaGyznWWbRK8/HqNUwIRS0T2bak4Be9XM8IQ064cxcYUgscyeT1Qb
 41ps8zamyeRo/uaBG1TSR/zioWPWlz8XtfhOwDtuWinWpJdo52hltYwoVdbmVamwWr/5
 M5rYI7G2fp84njHYGwOuAdDN1ffYPrTtR4SMWPJAX3y2k7ZqdfaCuW2pIMptfWUjXBqN
 dVz3EkDUe7nVWRRoVnZCUx7Tcp8J9uwAvyaQq55bYj9oH85ACZGLXaCTDvno9ED7aJ/7
 TwfC3PW2RQHsbKqfL7HuuGAnyHCdTHacToY/PKWEBg0FccYqVQqSsnd5SbLo0FtG7V0I
 MJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bQeG/bTYFgG4QFMLKTEBa9/B0VgVbffUqu5K1tWUHxA=;
 b=GrZSvmyxUsdQSHzB0iYi+lPmMWILJ2L46aZURBd4Xv1wDEAWxmAvW7UL6zCkvbJGam
 L+bkW2jbgTaf21cvNJ6sUrLS1GslG1/WIDd69d3KKQODCuqruKnkZrEDLzJD0tj6h1uF
 RI04vmoO85ZlspwfFTIIvfoVMcEDB2repKLeh8k5jz6UGWTbQu87X154avU28y1xZK+g
 nCPBEt+Km5YnW8wCW3cReKtRzi64bN83JgPILLQkGKrbSNAHadnhVxEr84rVKGPFEYhb
 FhlKR1xBrn8q3uM+i7oWPZXB6ZXkSFIECYWWPJWoWucP4E7SYbIlFRIQxdjKBwXXy6IA
 2VcQ==
X-Gm-Message-State: AJcUukeaxoJ6x/IAcPvvH+irxMBJ5tlcAnCz8Ym58zAUfdc7GgF5FLV8
 aJfBISrLfB6Q8hwsFHfrqs697JnGa+8lQLqqGFo=
X-Google-Smtp-Source: ALg8bN7JU4O1yk7PnwBKHsn3+TgNirmfweumaL0fdDrhp+BfHIBO47/8LYsYSEwvXbdzWIdXH6/0QGQS3WIfc56Oy14=
X-Received: by 2002:a0c:8542:: with SMTP id n60mr2559309qva.205.1546968949355; 
 Tue, 08 Jan 2019 09:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-2-enric.balletbo@collabora.com>
 <2908229.jFki8unlfB@phil>
In-Reply-To: <2908229.jFki8unlfB@phil>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 8 Jan 2019 18:35:38 +0100
Message-ID: <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
Subject: Re: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and
 kernel-doc documentation.
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_093550_977379_2492C01F 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: kernel@collabora.com, Alexandru Stan <amstan@chromium.org>,
 Guenter Roeck <groeck@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 kieran.bingham@ideasonboard.com,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Benson Leung <bleung@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSGVpa28gYW5kIGFsbCwKCk1pc3NhdGdlIGRlIEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRl
Y2guZGU+IGRlbCBkaWEgZGMuLCAxNSBk4oCZYWcuCjIwMTggYSBsZXMgMTI6MzE6Cj4KPiBBbSBN
aXR0d29jaCwgMTUuIEF1Z3VzdCAyMDE4LCAxMTo1OTozMSBDRVNUIHNjaHJpZWIgRW5yaWMgQmFs
bGV0Ym8gaSBTZXJyYToKPiA+IEZpeCB0aGUgdHlwbyBmbGFzZSAtPiBmYWxzZSBhbmQgY2xlYW4g
dXAgdGhlIGtlcm5lbC1kb2MgZG9jdW1lbnRhdGlvbiBpbgo+ID4gcGh5LXJvY2tjaGlwLWlubm8u
dXNiMi5jIGFuZCBmaXggdGhlIGZvbGxvd2luZyB3YXJuaW5ncyB3aGVuIGRvY3VtZW50YXRpb24K
PiA+IGlzIGJ1aWx0Lgo+ID4KPiA+ICAgOjU4OiB3YXJuaW5nOiBtaXNzaW5nIGluaXRpYWwgc2hv
cnQgZGVzY3JpcHRpb24KPiA+ICAgOjY5OiB3YXJuaW5nOiBjYW5ub3QgdW5kZXJzdGFuZCBmdW5j
dGlvbiBwcm90b3R5cGU6ICdlbnVtIHVzYl9jaGdfc3RhdGUgJwo+ID4gICA6OTc6IHdhcm5pbmc6
IG1pc3NpbmcgaW5pdGlhbCBzaG9ydCBkZXNjcmlwdGlvbgo+ID4gICA6MTM2OiB3YXJuaW5nOiBj
YW5ub3QgdW5kZXJzdGFuZCBmdW5jdGlvbiBwcm90b3R5cGU6ICdzdHJ1Y3Qgcm9ja2NoaXBfdXNi
MnBoeV9wb3J0X2NmZyAnCj4gPiAgIDoxNTc6IHdhcm5pbmc6IGNhbm5vdCB1bmRlcnN0YW5kIGZ1
bmN0aW9uIHByb3RvdHlwZTogJ3N0cnVjdCByb2NrY2hpcF91c2IycGh5X2NmZyAnCj4gPiAgIDox
NjM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3BvcnRfY2Zncycgbm90
IGRlc2NyaWJlZCBpbiAncm9ja2NoaXBfdXNiMnBoeV9jZmcnCj4gPiAgIDoxODc6IHdhcm5pbmc6
IGNhbm5vdCB1bmRlcnN0YW5kIGZ1bmN0aW9uIHByb3RvdHlwZTogJ3N0cnVjdCByb2NrY2hpcF91
c2IycGh5X3BvcnQgJwo+ID4gICA6MjA0OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Ig
bWVtYmVyICdwb3J0X2NmZycgbm90IGRlc2NyaWJlZCBpbiAncm9ja2NoaXBfdXNiMnBoeV9wb3J0
Jwo+ID4gICA6MjA3OiB3YXJuaW5nOiBtaXNzaW5nIGluaXRpYWwgc2hvcnQgZGVzY3JpcHRpb24K
PiA+ICAgOjIzNDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZGV2JyBu
b3QgZGVzY3JpYmVkIGluICdyb2NrY2hpcF91c2IycGh5Jwo+ID4gICA6MjM0OiB3YXJuaW5nOiBG
dW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdjbGs0ODBtX2h3JyBub3QgZGVzY3JpYmVkIGlu
ICdyb2NrY2hpcF91c2IycGh5Jwo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJv
IGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4KPiBSZXZpZXdlZC1ieTog
SGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4KPgoKSSBpbmNsdWRlZCB0aGlzIHBhdGNo
IGluIHRoZXNlIHNlcmllcyBiZWNhdXNlIEkgZm91bmQgdGhlIGVycm9ycyB3aGVuCkkgd2FzIHdv
cmtpbmcgb24gdGhpcy4gQnV0IHRoaXMgcGF0Y2ggZG9lc24ndCByZWFsbHkgZGVwZW5kIG9uIHRo
ZQpvdGhlciBwYXRjaGVzIGFuZCBwcm9iYWJseSBJIHNob3VsZCBoYXZlIGhhZCB0byBzZW5kIGlu
ZGVwZW5kZW50bHkuIEkKYW0gcGxhbm5pbmcgdG8gc2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoZXNl
IHNlcmllcyBleGNsdWRpbmcgdGhpcwpwYXRjaC4gSSB0aGluayB0aGF0IHRoZSBwYXRjaCBjYW4g
YmUgYWxyZWFkeSBwaWNrZWQgKHN0aWxsIGFwcGxpZXMKY2xlYW5seSBhbmQgaXMgZmluZSB0byBw
aWNrPykgb3IgZG8geW91IHByZWZlciBJIHJlc2VuZD8KClRoYW5rcywKIEVucmljCgo+Cj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LXJv
Y2tjaGlwIG1haWxpbmcgbGlzdAo+IExpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcK
PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tj
aGlwCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
