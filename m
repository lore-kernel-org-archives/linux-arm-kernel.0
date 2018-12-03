Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE79C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D100220848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QTzj1V0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D100220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IUVvgNeya/99ZdCB+m1Y4wfI+rftmGjA1y1Qip4Kq+w=; b=QTzj1V0jJ5+CNvO9tSJfBWV1e
	KmR9TNQT3djnonnMJWzOdSPyAsbKaaoc7WNZDyVcJyo1iZcHtRXboTtFqnkrHFNhtnOYUfXFKaJsm
	Inm3I2SKtVG+oMVNa7MpqgOYui93LksKZV1m4ybz1GYuHyDD1Ygm4mXXaMk3QC1Zm4rzhMMF+46MN
	oPy7YjYoGYWY5szIHfhCTbjqXuUJvCdI6ea7EmRaQTGgkMtDoJcjH8HYnz8dojQj1I+k4eqrFNB9d
	uvptFZc1DlKN+s+3YlUka4WYTKt5bR21EPiJKTzu04Axem2awqtlyIe3nzSX4jsZHTDFT15JwssH4
	n4UPGTKLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTist-0004BA-02; Mon, 03 Dec 2018 07:43:15 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTisp-0004AF-D0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 07:43:13 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 03 Dec 2018 16:42:57 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 3DC5A60062;
 Mon,  3 Dec 2018 16:42:57 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Mon, 3 Dec 2018 16:42:57 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id B222240394;
 Mon,  3 Dec 2018 16:42:56 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 91700120304;
 Mon,  3 Dec 2018 16:42:56 +0900 (JST)
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
 <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
Date: Mon, 3 Dec 2018 16:42:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_234311_711267_DBD2A550 
X-CRM114-Status: GOOD (  24.25  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAyMDE4LzExLzMwIDE3OjE2LCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4gUXVvdGluZyBT
dWdheWEsIFRhaWNoaSAoMjAxOC0xMS0yOSAwNDoyNDo1MSkKPj4gT24gMjAxOC8xMS8yOCAxMTow
MSwgU3RlcGhlbiBCb3lkIHdyb3RlOgo+Pj4gUXVvdGluZyBTdWdheWEgVGFpY2hpICgyMDE4LTEx
LTE4IDE3OjAxOjA3KQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL3NvY2lvbmV4dC9zb2Npb25leHQsbTEwdi50eHQKPj4+Pgo+
Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL3Nv
Y2lvbmV4dC9zb2Npb25leHQsbTEwdi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL3NvY2lvbmV4dC9zb2Npb25leHQsbTEwdi50eHQKPj4+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+Pj4+IGluZGV4IDAwMDAwMDAuLmY1ZDkwNmMKPj4+PiAtLS0gL2Rldi9udWxsCj4+
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9zb2Npb25leHQv
c29jaW9uZXh0LG0xMHYudHh0Cj4+Pj4gQEAgLTAsMCArMSwxMiBAQAo+Pj4+ICtTb2Npb25leHQg
TTEwViBTTVAgdHJhbXBvbGluZSBkcml2ZXIgYmluZGluZwo+Pj4+ICsKPj4+PiArVGhpcyBpcyBh
IGRyaXZlciB0byB3YWl0IGZvciBzdWItY29yZXMgd2hpbGUgYm9vdCBwcm9jZXNzLgo+Pj4+ICsK
Pj4+PiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgInNvY2lvbmV4dCxzbXAtdHJhbXBvbGluZSIK
Pj4+PiArLSByZWc6IHNob3VsZCBiZSA8MHg0QzAwMDEwMCAweDEwMD4KPj4+PiArCj4+Pj4gK0VY
QU1QTEUKPj4+PiArICAgICAgIHRyYW1wb2xpbmU6IHRyYW1wb2xpbmVAMHg0QzAwMDEwMCB7Cj4+
PiBEcm9wIHRoZSAweCBwYXJ0IG9mIHVuaXQgYWRkcmVzc2VzLgo+Pgo+PiBPa2F5Lgo+Pgo+Pgo+
Pj4+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNvY2lvbmV4dCxzbXAtdHJhbXBvbGlu
ZSI7Cj4+Pj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDRDMDAwMTAwIDB4MTAwPjsKPj4+IExv
b2tzIGxpa2UgYSBzb2Z0d2FyZSBjb25zdHJ1Y3QsIHdoaWNoIHdlIHdvdWxkbid0IHdhbnQgdG8g
cHV0IGludG8gRFQKPj4+IHRoaXMgd2F5LiBEVCBkb2Vzbid0IGRlc2NyaWJlIGRyaXZlcnMuCj4+
IFdlIHdvdWxkIGxpa2UgdG8gdXNlIHRoaXMgbm9kZSBvbmx5IGdldHRpbmcgdGhlIGFkZHJlc3Mg
b2YgdGhlCj4+IHRyYW1wb2xpbmUgYXJlYQo+PiBpbiB3aGljaCBzdWItY29yZXMgd2FpdC7CoCAo
VGhleSBoYXZlIGZpbmlzaGVkIHRvIGdvIHRvIHRoaXMgYXJlYSBpbiBwcmV2aW91cwo+PiBib290
bG9hZGVyIHByb2Nlc3MuKQo+IAo+IElzIHRoaXMgYXJlYSBwYXJ0IG9mIG1lbW9yeSwgb3IgYSBz
cGVjaWFsIFNSQU0/IElmIGl0J3MgcGFydCBvZiBtZW1vcnksCj4gSSB3b3VsZCBleHBlY3QgdGhp
cyBub2RlIHRvIGJlIHVuZGVyIHRoZSByZXNlcnZlZC1tZW1vcnkgbm9kZSBhbmQKPiBwb2ludGVk
IHRvIGJ5IHNvbWUgb3RoZXIgbm9kZSB0aGF0IHVzZXMgdGhpcyByZWdpb24uIENvdWxkIGV2ZW4g
YmUgdGhlCj4gQ1BVIG5vZGVzLgoKWWVzLCAweDRDMDAwMTAwIGlzIGEgcGFydCBvZiBtZW1vcnkg
dW5kZXIgdGhlIHJlc2VydmVkLW1lbW9yeSBub2RlLiBTbyAKd2Ugd291bGQgbGlrZSB0byB1c2Ug
dGhlIFNSQU0gKCBhbGxvY2F0ZWQgMHgwMDAwMDAwMCApIGFyZWEgaW5zdGVhZC4KQlRXLCBzb3Jy
eSwgdGhlIHRyYW1wb2xpbmUgYWRkcmVzcyBvZiB0aGlzIGV4YW1wbGUgaXMgc2ltcGx5IHdyb25n
LiAgV2UgCndlcmUgZ29pbmcgdG8gdXNlIGEgcGFydCBvZiB0aGUgU1JBTSBmcm9tIHRoZSBiZWdp
bm5pbmcuCgo+IAo+Pgo+PiBTbyBzaG91bGQgd2UgZW1iZWQgdGhlIGNvbnN0YW50IHZhbHVlIGlu
IHNvdXJjZSBjb2RlcyBpbnN0ZWFkIG9mIGdldHRpbmcKPj4gZnJvbQo+PiBEVCBiZWNhdXNlIHRo
ZSBhZGRyZXNzIGlzIGNvbnN0YW50IGF0IHRoZSBtb21lbnQ/IE9yIGlzIHRoZXJlIG90aGVyCj4+
IGFwcHJvYWNoPwo+Pgo+IAo+IElmIGl0J3MgY29uc3RhbnQgdGhlbiB0aGF0IGFsc28gd29ya3Mu
IFdoeSBkb2VzIGl0IG5lZWQgdG8gY29tZSBmcm9tIERUCj4gYXQgYWxsIHRoZW4/CgpXZSB0aGlu
ayBpdCBpcyBub3QgZ29vZCB0byBlbWJlZCBjb25zdGFudCB2YWx1ZSBpbiBkcml2ZXIgY29kZXMg
YW5kIGRvIApub3QgaGF2ZSBhbm90aGVyIHdheS4uLgpBcmUgdGhlcmUgYmV0dGVyIHdheXM/CgpU
aGFua3MKU3VnYXlhIFRhaWNoaQoKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
