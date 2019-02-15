Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B3121924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZyhX/BAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3121924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wOKEn4bjxPn5p3Mh4iOEyngP/Nrek1qE7pl17UmVLls=; b=ZyhX/BAPUPB3TR
	8mLawiZNVVXOl4jpgMOay99Gq7jTCywLlLJYRKSzC6dLbU8LNSM7V7bg0fsKhFfewFQWtcuYXEGvY
	7ArfWNn4RGUPBsjSgx3q+HuOxzdkQyUW7mai4KECvdgcCBjVK9He5c5jqeTF5nTrS5ckSSH500I7S
	dgXb+lmfRa53RvwRoExi1rlU4KNwmGK2kSFGXpHw+tr7DbMrYsT7U8QC5bUkqROv1xmO2/Wt8U2Uc
	t5Rcmr1+N3a9hsWCweUUKjV7ltHwcJW3pk0Isv1BxHW5jsIMOAZtyPa9XUEefMVvAGfuS2B4ZygIj
	KS4NZ5uPx05WPUuPbiXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gug8O-0002WF-7l; Fri, 15 Feb 2019 16:14:40 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gug8L-0002Vd-Dv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:14:38 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gug8E-0006hP-Jr; Fri, 15 Feb 2019 17:14:30 +0100
Message-ID: <1550247269.2546.58.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-ed1 board
From: Lucas Stach <l.stach@pengutronix.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Date: Fri, 15 Feb 2019 17:14:29 +0100
In-Reply-To: <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_081437_623434_7E45D829 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Philippe Cornu <philippe.cornu@st.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE1LjAyLjIwMTksIDE2OjU4ICswMTAwIHNjaHJpZWIgUGllcnJlLVl2
ZXMgTU9SRFJFVDoKPiBFbmFibGUgVml2YW50ZSBHUFUgZHJpdmVyIGZvciBzdG0zMm1wMTU3Yy1l
ZDEgYm9hcmQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGllcnJlLVl2ZXMgTU9SRFJFVCA8cGllcnJl
LXl2ZXMubW9yZHJldEBzdC5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1w
MTU3Yy1lZDEuZHRzIHwgMTYgKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJt
cDE1N2MtZWQxLmR0cwo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZWQxLmR0cwo+
IGluZGV4IDk4ZWY3YTAuLjc5MmY0MDIgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
c3RtMzJtcDE1N2MtZWQxLmR0cwo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdj
LWVkMS5kdHMKPiBAQCAtMjAsNiArMjAsMTcgQEAKPiDCoAkJcmVnID0gPDB4QzAwMDAwMDAgMHg0
MDAwMDAwMD47Cj4gwqAJfTsKPiDCoAo+ICsJcmVzZXJ2ZWQtbWVtb3J5IHsKPiArCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsKPiArCQlyYW5nZXM7Cj4gKwo+
ICsJCWdwdV9yZXNlcnZlZDogZ3B1QGY4MDAwMDAwIHsKPiArCQkJcmVnID0gPDB4ZjgwMDAwMDAg
MHg4MDAwMDAwPjsKPiArCQkJbm8tbWFwOwo+ICsJCX07Cj4gKwl9Owo+ICsKCkkgZG9uJ3QgdGhp
bmsgeW91IG5lZWQgdGhpcy4gVGhlIEdQVSBkcml2ZXIgdXNlcyB2ZXJ5IGxpdHRsZSBjb250aWcg
ZG1hCm1lbW9yeS4gTW9zdCBvZiB0aGUgR1BVIG1lbW9yeSBpcyBvcmRpbmFyeSBwYWdlZCBtZW1v
cnksIHNvIHNldHRpbmcKYXNpZGUgYSBwcml2YXRlIG1lbW9yeSByZWdpb24gb2YgdGhpcyBzaXpl
IGlzIGEgd2FzdGUgb2YgbWVtb3J5LiBNb3N0Cmxpa2VseSB5b3UgY2FuIGp1c3QgYWxsb3cgdGhl
IEdQVSBkcml2ZXIgdG8gdXNlIHRoZSBzeXN0ZW0gZ2xvYmFsIENNQQpyZWdpb24uCgpSZWdhcmRz
LApMdWNhcwoKCj4gwqAJYWxpYXNlcyB7Cj4gwqAJCXNlcmlhbDAgPSAmdWFydDQ7Cj4gwqAJfTsK
PiBAQCAtNTMsNiArNjQsMTEgQEAKPiDCoAlzdGF0dXMgPSAib2theSI7Cj4gwqB9Owo+IMKgCj4g
KyZncHUgewo+ICsJY29udGlndW91cy1hcmVhID0gPCZncHVfcmVzZXJ2ZWQ+Owo+ICsJc3RhdHVz
ID0gIm9rYXkiOwo+ICt9Owo+ICsKPiDCoCZpMmM0IHsKPiDCoAlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOwo+IMKgCXBpbmN0cmwtMCA9IDwmaTJjNF9waW5zX2E+OwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
