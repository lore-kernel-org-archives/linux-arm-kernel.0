Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F9C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF7921924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kxziai4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF7921924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWrRuccNROh4fEcKt4nPQ7FBL3Enere8ZCRX6zl1rLw=; b=Kxziai4S8BkRku
	k/On8zZnujFIYZ//SYyErF1N4ipYfQ+SwNznxc4o6veGiujBvLbSfolKuJqMMfY1NpkVjjuHZIHQG
	4hwYo8QlsL1Gectse46WmguOwtbjWmPQlqAj572F18PIjMMSe5NDPDuDCcoZ0ZKMuTbkwxjqRLgmc
	6ACJS/mpQb+vzuYx+e2JJ75YuiN8SS3dIOtBcP803oXXSPXeDnxQla7Ji/vz6oT3z7p2YrPO88Z/2
	7tGeHlo9zgd7s/CrjUR1hfZXKhK/e87mIuPpi1fABc4OUj3HsuIFUPdqdlj1sHixihCebCIeTDDGl
	nbKOrrP271LbekIgYa/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gug63-0001uw-Bz; Fri, 15 Feb 2019 16:12:15 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gug5z-0001tH-Rr
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:12:13 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gug5n-0006VR-TY; Fri, 15 Feb 2019 17:11:59 +0100
Message-ID: <1550247118.2546.56.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/3] ARM: dts: stm32: Add Vivante GPU support on
 STM32MP157c
From: Lucas Stach <l.stach@pengutronix.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Date: Fri, 15 Feb 2019 17:11:58 +0100
In-Reply-To: <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_081212_053991_29C43AAF 
X-CRM114-Status: GOOD (  13.95  )
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

SGkgUGllcnJlLVl2ZXMsCgpBbSBGcmVpdGFnLCBkZW4gMTUuMDIuMjAxOSwgMTY6NTggKzAxMDAg
c2NocmllYiBQaWVycmUtWXZlcyBNT1JEUkVUOgo+IEFwcGVuZCBWaXZhbnRlIEdQVSBEVCBjb25m
aWd1cmF0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyZS1ZdmVzIE1PUkRSRVQgPHBpZXJy
ZS15dmVzLm1vcmRyZXRAc3QuY29tPgo+IC0tLQo+IMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJt
cDE1N2MuZHRzaSB8IDEwICsrKysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5kdHNpCj4gaW5kZXggZjhiYmZmZi4u
Mjk1NDBiYyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5kdHNp
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQo+IEBAIC0xMTA2LDYg
KzExMDYsMTYgQEAKPiA+IMKgCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiA+IMKgCQl9Owo+IMKg
Cj4gKwkJZ3B1OiBncHVANTkwMDAwMDAgewo+ICsJCQljb21wYXRpYmxlID0gInZpdmFudGUsZ2Mi
Owo+ICsJCQlyZWcgPSA8MHg1OTAwMDAwMCAweDgwMD47Cj4gKwkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSAxMDkgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gKwkJCWNsb2NrcyA9IDwmcmNjIEdQVT4s
IDwmcmNjIEdQVV9LPjsKPiArCQkJY2xvY2stbmFtZXMgPSAiYnVzIiAsImNvcmUiOwoKSXMgdGhp
cyBhIDJEIG9ubHkgY29yZT8gSWYgaXQgaXMgYWxzbyAzRCBjYXBhYmxlIHRoZSBiaW5kaW5nIHNh
eXMgeW91Cm5lZWQgdG8gc3BlY2lmeSB0aGUgc2hhZGVyIGNsb2NrIChtYXkgYmUgdGhlIHNhbWUg
Y2xvY2sgZmVlZGluZyB0aGUKY29yZSkuCgpSZWdhcmRzLApMdWNhcwoKPiArCQkJcmVzZXRzID0g
PCZyY2MgR1BVX1I+Owo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+ICsJCX07Cj4gKwo+IMKg
CQlkc2k6IGRzaUA1YTAwMDAwMCB7Cj4gwqAJCQljb21wYXRpYmxlID0gInN0LHN0bTMyLWRzaSI7
Cj4gwqAJCQlyZWcgPSA8MHg1YTAwMDAwMCAweDgwMD47CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
