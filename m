Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F2C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:54:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC2C2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMKZGWXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW2ZpxtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC2C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lQqMJNRa2lxAuREU83qmxY7j4nSJFJt2jI7a6sV4Id8=; b=XMKZGWXJlYSF9b
	RVOHhXVqgBG0Ulm8cmRskpvHjA2kUwSj18eTcGBTknKDV6q+SPt/c2tLQ6bs3om42LxbaFpZxjfZc
	VVPZEgzTxqoifu4WrR36npQuhYrC1/4UjUPUxsjglz4KfcG9TivJTRi6QBlH3I+mL8JQMr/R84INR
	vbgsnQejMJZ7WY7JvmknER+8HkV3m+H63tCdsBzT3xs+hMlXDRUJ6ZDmBmfz4ASGRvy5km52QvQjM
	6zLct07etGjxfgzii867+AR0xh1ocrOMZo8EMYCoxFtLfpg3GLCIghRGTiDDIJdVCOfniPYBbcGTA
	j+MDlaI57kj+deaBqljw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqCc6-00023y-4V; Sun, 03 Feb 2019 07:54:50 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqCc3-00023d-F0
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 07:54:49 +0000
Received: by mail-qt1-x844.google.com with SMTP id t33so12422843qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc:content-transfer-encoding;
 bh=BSnmeNvE3EBhH2SfbdbcYylaib6DqHpMf3vu6r4CZqc=;
 b=eW2ZpxtXpeL0dNqBqV7T9P3rj0Jr0ySMM8IyBtnRNfCAmV0FHPBXmJKiVUhRr6c7Ek
 5FLvIRS1mPrUFGNUJudBTkWCAb2BNyPBqY1Z3bqNYECtv/uYnrbpEwe+egAy//YLW+89
 1iAdSv3L0cw+C740nL0PqHJWpzKVyrjH3GRfFVPCKnMP4NiqdQtoxDksMaBNPv9Xk6OS
 amoO3Jbh2w2YPueGnRJa2EQYtW4Sb2eCsuRToDzixFcgrEXqnC9936Ud+Ev7admKd+c+
 VHk24NLymfTLr5tTwZEIk71wGZXhzcCr9EokcMcuzF0wdKGnhRhogrLsbLttm8RJrBu/
 dlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=BSnmeNvE3EBhH2SfbdbcYylaib6DqHpMf3vu6r4CZqc=;
 b=frF85dnc+uvh3/PDfJym583gKhaETFRY24YRWnQ3rnACghFZE9+UyrqjSpMQ89WYY+
 mh9trazR0vrpLUgXvGDSzSnWrx7Qia6cpsO3lqAmlDI6WPM1WFfT6gIKK3IrXtOFflz2
 gvpwYsg8NDdqnxamsokysMsYOW03qYEt7tMc3cI8GE2QIjoPSwisHQkz1PEfatWihvQQ
 8ua2lt5F/11rkaPdDUeJBEWEbSsQY5yGUPKvvG2DjGaGNmNz7CcMWzy5PCZOnY5/MehA
 LXr4EuzrGIyuQJoEm50rEUZZUnS1E22tnR2Y1/qUSIXYJTZSrGgxYpGf5TJoydtVA+mT
 ZOFA==
X-Gm-Message-State: AJcUukdxpKPoEwe/GFyPC/1JBjDOAiGoUy2n5SUhQwEitzhTxYV3XVHq
 ZR8pLvbbyeQAsaOMNnFinYQpHh/O+SGApr0AEUQ=
X-Google-Smtp-Source: ALg8bN6TGRGK9yUSn/KtlbJaLCxO8NxFh6bnJMO0CSftNvbm5YZSkYi/73xup7Ku8vai1TkQ9hzA+bISKdSoMOpKTUE=
X-Received: by 2002:ac8:1617:: with SMTP id p23mr45983910qtj.239.1549180485631; 
 Sat, 02 Feb 2019 23:54:45 -0800 (PST)
MIME-Version: 1.0
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
 <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
In-Reply-To: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
From: Chanwoo Choi <cwchoi00@gmail.com>
Date: Sun, 3 Feb 2019 16:54:09 +0900
Message-ID: <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_235447_504756_91284DBD 
X-CRM114-Status: GOOD (  24.81  )
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
Reply-To: cwchoi00@gmail.com
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVrYXN6LAoKMjAxOeuFhCAy7JuUIDHsnbwgKOq4iCkg7Jik7ZuEIDExOjIyLCBMdWthc3og
THViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+64uY7J20IOyekeyEsToKCj4KPiBIaSBD
aGFud29vLAo+Cj4gT24gMi8xLzE5IDk6NDQgQU0sIENoYW53b28gQ2hvaSB3cm90ZToKPiA+IEhp
LAo+ID4KPiA+IE9uIDE5LiAxLiAzMS4g7Jik7ZuEIDU6NDksIEx1a2FzeiBMdWJhIHdyb3RlOgo+
ID4+IEFkZCBuZXcgdGFibGUgcmF0ZSBmb3IgQlBMTCBmb3IgRXh5bm9zNTQyMiBTb0Mgc3VwcG9y
dGluZyBEeW5hbWljIE1lbW9yeQo+ID4+IENvbnRyb2xsZXIgZnJlcXVlbmNpZXMgZm9yIGRyaXZl
cidzIERSQU0gdGltaW5ncy4KPiA+Pgo+ID4+IENDOiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3
cm9ja2lAc2Ftc3VuZy5jb20+Cj4gPj4gQ0M6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1
bmcuY29tPgo+ID4+IENDOiBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b20+Cj4gPj4gQ0M6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4KPiA+PiBDQzogS3Vr
amluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4KPiA+PiBDQzogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPgo+ID4+IENDOiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5v
cmcKPiA+PiBDQzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZwo+ID4+IENDOiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+PiBDQzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZwo+ID4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5z
YW1zdW5nLmNvbT4KPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5v
czU0MjAuYyB8IDE1ICsrKysrKysrKysrKysrLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDIwLmMgYi9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1l
eHlub3M1NDIwLmMKPiA+PiBpbmRleCAzZTg3NDIxLi44YmY5NTc5IDEwMDY0NAo+ID4+IC0tLSBh
L2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+ID4+ICsrKyBiL2RyaXZlcnMv
Y2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MjAuYwo+ID4+IEBAIC0xMzI1LDYgKzEzMjUsMTkgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBzYW1zdW5nX3BsbF9yYXRlX3RhYmxlIGV4eW5vczU0MjBfcGxs
MjU1MHhfMjRtaHpfdGJsW10gX19pbmkKPiA+PiAgICAgIFBMTF8zNVhYX1JBVEUoMjQgKiBNSFos
IDIwMDAwMDAwMCwgIDIwMCwgMywgMyksCj4gPj4gICB9Owo+ID4+Cj4gPj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgc2Ftc3VuZ19wbGxfcmF0ZV90YWJsZSBleHlub3M1NDIyX2JwbGxfcmF0ZV90YWJs
ZVtdID0gewo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgOTMzMDAwMDAwLCAzMTEs
IDQsIDEpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgODI1MDAwMDAwLCAyNzUs
IDQsIDEpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNzI4MDAwMDAwLCAxODIs
IDMsIDEpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNjMzMDAwMDAwLCAyMTEs
IDQsIDEpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNTQzMDAwMDAwLCAxODEs
IDIsIDIpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgNDEzMDAwMDAwLCA0MTMs
IDYsIDIpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMjc1MDAwMDAwLCAyNzUs
IDMsIDMpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMjA2MDAwMDAwLCAyMDYs
IDMsIDMpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMTY1MDAwMDAwLCAxMTAs
IDIsIDMpLAo+ID4+ICsgICAgUExMXzM1WFhfUkFURSgyNCAqIE1IWiwgMTM4MDAwMDAwLCAxODQs
IDIsIDQpLAo+ID4KPiA+IEV4Y2VwdCBmb3IgODI1TWh6LCBJIGNhbid0IGZpbmQgdGhlIHRhcmdl
dCBmcmVxdWVuY3kKPiA+IG9uIEV4eW5vczU0MjIgVFJNIGRvY3VtZW50LiBVc3VhbGx5LCBFeHlu
b3MgVFJNIHNwZWNpZmllZAo+ID4gdGhlIHN1cHBvcnRlZCBzdGFibGUgY2xvY2tzLiBJdCBtZWFu
cyB0aGF0IHVuZGVmaW5lZCBjbG9ja3MKPiA+IGFyZSBub3Qgc3RhYmxlIGFzIEkga25ldy4gV2hl
cmUgZG8geW91IGZpbmQgdGhlbT8KPiA+Cj4gPiBXaGVuIEkgY2FsY3VsYXRlZCB0aGUgUExMIGZy
ZXF1ZW5jeSB3aXRoIFBNUyB2YWx1ZSwgaXQgaXMgY29ycmVjdC4KPiA+IEJ1dCwganVzdCB3ZSBu
ZWVkIHRvIGNoZWNrIHRoZSByZWZlcmVuY2Ugb2YgdW5kZWZpbmVkIGNsb2NrcyBvbiBUUk0KPiA+
IGluIG9yZGVyIHRvIGd1YXJhbnRlZSB0aGUgc3RhYmxlIG9wZXJhdGlvbi4KPiBUaGV5IHZhbHVl
cyBsaXZlIGluIHZlbmRvciBjb2RlIGZvciBBbmRyb2lkLgo+IEkgaGF2ZSB0ZXN0ZWQgdGhlIERN
QyAmIEREUiB3aXRoIHRoZXNlIHJhdGlvcyBpbiBzdHJlc3Mgc2NlbmFyaW9zCj4gZm9yIGEgZmV3
IGRheXMgYW5kIGl0IHdhcyBzdGFibGUuCgpJZiBwb3NzaWJsZSwgcGxlYXNlIHNoYXJlIHRoZSB1
cmwgb2Ygb3JpZ2luYWwgdmVuZG9yIGNvZGUuCgo+Cj4gPgo+ID4gUmVtb3ZlIDkzMy8xMzhNaHog
YmVjYXVzZSBleHlub3M1NDMzLWRtYy5jIGRvZXNuJ3QgdXNlIDkzM01oeiBhbmQgMTM4TWh6Cj4g
PiBhbmQgYWxzbyBFeHlub3M1NDIyIFRSTSBkb2Vzbid0IGRlZmluZSA5MzMvMTM4TWh6IG9uIHBs
bCB0YWJsZS4KPiBPSywgSSB3aWxsIHJlbW92ZSB0aGVtLgo+ID4KPiA+PiArfTsKPiA+PiArCj4g
Pj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHNhbXN1bmdfcGxsX3JhdGVfdGFibGUgZXh5bm9zNTQy
MF9lcGxsXzI0bWh6X3RibFtdID0gewo+ID4+ICAgICAgUExMXzM2WFhfUkFURSgyNCAqIE1IWiwg
NjAwMDAwMDAwVSwgMTAwLCAyLCAxLCAwKSwKPiA+PiAgICAgIFBMTF8zNlhYX1JBVEUoMjQgKiBN
SFosIDQwMDAwMDAwMFUsIDIwMCwgMywgMiwgMCksCj4gPj4gQEAgLTE0NjcsNyArMTQ4MCw3IEBA
IHN0YXRpYyB2b2lkIF9faW5pdCBleHlub3M1eF9jbGtfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wLAo+ID4+ICAgICAgICAgICAgICBleHlub3M1eF9wbGxzW2FwbGxdLnJhdGVfdGFibGUgPSBl
eHlub3M1NDIwX3BsbDI1NTB4XzI0bWh6X3RibDsKPiA+PiAgICAgICAgICAgICAgZXh5bm9zNXhf
cGxsc1tlcGxsXS5yYXRlX3RhYmxlID0gZXh5bm9zNTQyMF9lcGxsXzI0bWh6X3RibDsKPiA+PiAg
ICAgICAgICAgICAgZXh5bm9zNXhfcGxsc1trcGxsXS5yYXRlX3RhYmxlID0gZXh5bm9zNTQyMF9w
bGwyNTUweF8yNG1oel90Ymw7Cj4gPj4gLSAgICAgICAgICAgIGV4eW5vczV4X3BsbHNbYnBsbF0u
cmF0ZV90YWJsZSA9IGV4eW5vczU0MjBfcGxsMjU1MHhfMjRtaHpfdGJsOwo+ID4+ICsgICAgICAg
ICAgICBleHlub3M1eF9wbGxzW2JwbGxdLnJhdGVfdGFibGUgPSBleHlub3M1NDIyX2JwbGxfcmF0
ZV90YWJsZTsKPiA+Cj4gPiBFeHlub3M1NDIyIHVzZWQgdGhlIHNhbWUgUExMIHRhYmxlIGZvciBh
cGxsLCBrcGxsLCBicGxsIGFuZCBzbyBvbi4KPiA+IFlvdSBkb24ndCBuZWVkIHRvIG1ha2UgdGhl
IHNlcGFyYXRlIHBsbCB0YWJsZS4gSnVzdCBhZGQgbmV3IGVudHJpZXMKPiA+IHRvIGV4eW5vczU0
MjBfcGxsMjU1MHhfMjRtaHpfdGJsIHRhYmxlLgo+IE9LLCBJIHdpbGwgZXh0ZW5kIHRoZSBleHlu
b3M1NDIwX3BsbDI1NTB4XzI0bWh6X3RibCB0YWJsZS4KPgo+IEluIHY0IHBhdGNoIHNldCwgaXQg
d2lsbCBiZSBmaXhlZC4KPgo+IFJlZ2FyZHMsCj4gTHVrYXN6Cj4gPgo+ID4+ICAgICAgfQo+ID4+
Cj4gPj4gICAgICBzYW1zdW5nX2Nsa19yZWdpc3Rlcl9wbGwoY3R4LCBleHlub3M1eF9wbGxzLCBB
UlJBWV9TSVpFKGV4eW5vczV4X3BsbHMpLAo+ID4+Cj4gPgoKCgotLQpCZXN0IFJlZ2FyZHMsCkNo
YW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
