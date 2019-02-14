Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFEB222DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WiSFf07/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFEB222DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WvwUndYdRKeyjZE828/XjCzO93w6dv++nMlHJ2Rl8nc=; b=WiSFf07/j7IPTD
	7aaOE4LGsBQRxGL1DCQTJ0voJYmvU0OdxRlY3aeCXa8HbM4HSjP9/6LuhDiECJ8FHTNqEwORaOaFR
	Ythi8AwsyIcYIs7vFaCdnAbqa+D2758y5Rf3ZozGJX8nTXdcGylhktmHxKqu4+FvUOSgRryOk9E7t
	sItzikhJIgLhb3diU2niBvao5SK+zVud5Vc+y00J/q7wWI/gBDK3lG7J0U6TS+ns00JKc9WzwwPzw
	LFuF7oim2HhRAHrN6rTOkw877sARNr+ggcTtDEtts4Jnuky2hbquzJj2sWd8krgQi2RSS83bWwFz8
	SfIUgIABGmuKsS4pgyhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJHh-00047C-Sa; Thu, 14 Feb 2019 15:50:45 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJHe-00046S-58
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:50:43 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guJHR-00048B-AM; Thu, 14 Feb 2019 16:50:29 +0100
Message-ID: <1550159428.2546.40.camel@pengutronix.de>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike
 Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie
 <angus.ainslie@puri.sm>, Anson Huang <anson.huang@nxp.com>
Date: Thu, 14 Feb 2019 16:50:28 +0100
In-Reply-To: <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075042_354516_8BA8999C 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQWJlbAoKQW0gTWl0dHdvY2gsIGRlbiAxMy4wMi4yMDE5LCAxOTowNSArMDAwMCBzY2hyaWVi
IEFiZWwgVmVzYToKPiBBZGQgdGhlIG9wcCB0YWJsZSBjb250YWluaW5nIG9ubHkgbm9uIG92ZXIg
ZHJpdmUgb3Bwcy4KPiBBbHNvIGFkZCB0aGUgY3B1LXN1cHBseSBub2RlcyBmb3IgdGhlIEE1MyBj
b3JlcyBpbiB0aGUgRVZLIGJvYXJkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFiZWwgVmVzYSA8YWJl
bC52ZXNhQG54cC5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXEtZXZrLmR0cyB8IDE3ICsrKysrKysrKysrKysrKysrCj4gwqBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzacKgwqDCoMKgfCAyMyArKysrKysrKysrKysrKysrKysr
KysrKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzCj4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtZXZrLmR0cwo+IGluZGV4IDU0NzM3YmYu
LjExNDM1OWUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1xLWV2ay5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEt
ZXZrLmR0cwo+IEBAIC0zMSw2ICszMSwyMyBAQAo+IMKgCQlncGlvID0gPCZncGlvMiAxOSBHUElP
X0FDVElWRV9ISUdIPjsKPiDCoAkJZW5hYmxlLWFjdGl2ZS1oaWdoOwo+IMKgCX07Cj4gKwo+ICt9
Owo+ICsKPiArJkE1M18wIHsKPiArCWNwdS1zdXBwbHkgPSA8JnN3MWFfcmVnPjsKPiArfTsKPiAr
Cj4gKyZBNTNfMSB7Cj4gKwljcHUtc3VwcGx5ID0gPCZzdzFhX3JlZz47Cj4gK307Cj4gKwo+ICsm
QTUzXzIgewo+ICsJY3B1LXN1cHBseSA9IDwmc3cxYV9yZWc+Owo+ICt9Owo+ICsKPiArJkE1M18z
IHsKPiArCWNwdS1zdXBwbHkgPSA8JnN3MWFfcmVnPjsKPiDCoH07CgpUaGlzIHNob3VsZCBiZSBh
IHNlcGFyYXRlIHBhdGNoLgoKQW5kIEFGQUlDUyB0aGlzIGlzIHdyb25nLCBzdzFhIG9uIHRoZSBN
WDhNLUVWSyBpcyB0aGUgR1BVIHN1cHBseSwgdGhlCkNQVSBpcyBzdXBwbGllZCBieSBhIGRlZGlj
YXRlZCBzd2l0Y2hlciB0aGF0IGlzIGNvbnRyb2xsZWQgdmlhIGEgR1BJTy4KClJlZ2FyZHMsCkx1
Y2FzCgo+IMKgJmZlYzEgewo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEuZHRzaQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1x
LmR0c2kKPiBpbmRleCAxYTg5MDYyLi44OWIyZDVmIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBAQCAtOTEsNiArOTEsNyBAQAo+IMKgCQkJY2xvY2tz
ID0gPCZjbGsgSU1YOE1RX0NMS19BUk0+Owo+IMKgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsK
PiDCoAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkE1M19MMj47Cj4gKwkJCW9wZXJhdGluZy1wb2lu
dHMtdjIgPSA8JmE1M18wX29wcF90YWJsZT47Cj4gwqAJCX07Cj4gwqAKPiDCoAkJQTUzXzE6IGNw
dUAxIHsKPiBAQCAtMTAxLDYgKzEwMiw3IEBACj4gwqAJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFf
Q0xLX0FSTT47Cj4gwqAJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOwo+IMKgCQkJbmV4dC1sZXZl
bC1jYWNoZSA9IDwmQTUzX0wyPjsKPiArCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmYTUzXzBf
b3BwX3RhYmxlPjsKPiDCoAkJfTsKPiDCoAo+IMKgCQlBNTNfMjogY3B1QDIgewo+IEBAIC0xMTEs
NiArMTEzLDcgQEAKPiDCoAkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfQVJNPjsKPiDCoAkJ
CWVuYWJsZS1tZXRob2QgPSAicHNjaSI7Cj4gwqAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZBNTNf
TDI+Owo+ICsJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZhNTNfMF9vcHBfdGFibGU+Owo+IMKg
CQl9Owo+IMKgCj4gwqAJCUE1M18zOiBjcHVAMyB7Cj4gQEAgLTEyMSw2ICsxMjQsNyBAQAo+IMKg
CQkJY2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19BUk0+Owo+IMKgCQkJZW5hYmxlLW1ldGhvZCA9
ICJwc2NpIjsKPiDCoAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkE1M19MMj47Cj4gKwkJCW9wZXJh
dGluZy1wb2ludHMtdjIgPSA8JmE1M18wX29wcF90YWJsZT47Cj4gwqAJCX07Cj4gwqAKPiDCoAkJ
QTUzX0wyOiBsMi1jYWNoZTAgewo+IEBAIC02NjYsNiArNjcwLDI1IEBACj4gwqAJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOwo+IMKgCQl9Owo+IMKgCj4gKwo+ICsJCWE1M18wX29wcF90YWJsZTogb3Bw
LXRhYmxlIHsKPiArCQkJY29tcGF0aWJsZSA9ICJvcGVyYXRpbmctcG9pbnRzLXYyIjsKPiArCQkJ
b3BwLXNoYXJlZDsKPiArCj4gKwkJCW9wcC04MDAwMDAwMDAgewo+ICsJCQkJb3BwLWh6ID0gL2Jp
dHMvIDY0IDw4MDAwMDAwMDA+Owo+ICsJCQkJb3BwLW1pY3Jvdm9sdCA9IDw5MDAwMDA+Owo+ICsJ
CQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Owo+ICsJCQl9Owo+ICsKPiArCQkJb3BwLTEw
MDAwMDAwMDAgewo+ICsJCQkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMDAwMDAwMDAwPjsKPiArCQkJ
CW9wcC1taWNyb3ZvbHQgPSA8OTAwMDAwPjsKPiArCQkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUw
MDAwPjsKPiArCQkJCW9wcC1zdXNwZW5kOwo+ICsJCQl9Owo+ICsJCX07Cj4gKwo+IMKgCQlnaWM6
IGludGVycnVwdC1jb250cm9sbGVyQDM4ODAwMDAwIHsKPiDCoAkJCWNvbXBhdGlibGUgPSAiYXJt
LGdpYy12MyI7Cj4gwqAJCQlyZWcgPSA8MHgzODgwMDAwMCAweDEwMDAwPiwJLyogR0lDCj4gRGlz
dCAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
