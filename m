Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C68C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:29:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE25820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WkXeBr2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE25820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6lUksrtnLfg6gn+b1i1+vYTLJo2EEkrcJN8VqNDOyFc=; b=WkXeBr2kkfDDUy
	GVZariv7RTZXUC74fRtXdW41elWMSRaPRQgMYUIJSxwa811zYw22FVPfLLl8XZAfq8Ly0Qi8jSRL8
	WhvZ9cDeLtYWmsuoTRjuiiBZtDDF0a7w3WaVIH9KoLjBTHbBuD3yGE/WROPwPgMx6qFx+EHGTAU33
	1lErNuKtq230GOFt/mm8T09Y7XdzfnJWwVBZTL/EZ9pAOcaqGNdNI9aZa88HuOr8QYkqFvri/hKtC
	GE2yU55cU3BqD6WoaFnL3IWobWBCVQmFXCv481lHmRixKqovlnEBzLpNgYDne2hsLUXFoDikCdA8F
	hh+2Dk231Lt4CZ0h5IQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUquB-0002lp-LD; Thu, 06 Dec 2018 10:29:15 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqu8-0002j1-7w
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:29:13 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUqtt-0007HQ-Hf; Thu, 06 Dec 2018 11:28:57 +0100
Message-ID: <1544092136.3709.57.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org
Date: Thu, 06 Dec 2018 11:28:56 +0100
In-Reply-To: <20181206074555.19579-1-andrew.smirnov@gmail.com>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_022912_438251_1D72032A 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzo0NSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IEJ1aWxkaW5nIGEga2VybmVsIHdpdGggQ09ORklHX1BDSV9JTVg2PXksIGJ1dCBD
T05GSUdfUENJRVBPUlRCVVM9bgo+IHByb2R1Y2VzIGEgc3lzdGVtIHdoZXJlIGJ1aWx0LWluIFBD
SUUgYnJpZGdlICgxNmMzOmFiY2QpIGlzbid0IGJvdW5kCj4gdG8gcGNpZXBvcnQgZHJpdmVyLiBU
aGlzLCBpbiB0dXJuLCByZXN1bHRzIGluIGEgUENJRSBidXMgdGhhdCBpcwo+IGNhcGFibGUgb2Yg
ZW51bWVyYXRpbmcgYXR0YWNoZWQgUENJRSBkZXZpY2UsIGJ1dCBsYWNrcyBmdW5jdGlvbmFsCj4g
aW50ZXJydXB0IHN1cHBvcnQuCgpUaGlzIGlzIG9kZC4gQUZBSUsgUENJIHBvcnQgc2VydmljZXMg
YXJlIGEgdG90YWxseSBvcHRpb25hbCB0aGluZyBhbmQKdGhlbSBiZWluZyBhYnNlbnQgc2hvdWxk
IG5vdCBsZWFkIHRvIGEgbm9uLWZ1bmN0aW9uYWwgUENJIGJ1cy4gU28gSQp3b3VsZCByZWFsbHkg
bGlrZSB0byBzZWUgc29tZSBkZWVwZXIgYW5hbHlzaXMgd2hhdCBpcyBnb2luZyBvbiBoZXJlLgoK
UmVnYXJkcywKTHVjYXMKCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJldy5z
bWlybm92QGdtYWlsLmNvbT4KPiAtLS0KPiAKPiBBc3N1bWluZyB0aGlzIGlzIGEgcmVhc29uYWJs
ZSBkZXBlbmRlbmN5LCBzaG9sZCB0aGlzIGJlIGRvbmUgdG8gbW9yZQo+IHRoYW4ganVzdCBpLk1Y
NiBkcml2ZXI/Cj4gCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnIHwgMSAr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL0tjb25maWcKPiBpbmRleCAyYjEzOWFjY2NmMzIuLjQ0ZWRlZGJlYWI4NSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvS2NvbmZpZwo+IEBAIC05Miw2ICs5Miw3IEBAIGNvbmZpZyBQQ0lf
SU1YNgo+ID4gwqAJYm9vbCAiRnJlZXNjYWxlIGkuTVg2IFBDSWUgY29udHJvbGxlciIKPiA+IMKg
CWRlcGVuZHMgb24gU09DX0lNWDhNUSB8fCBTT0NfSU1YNlEgfHwgKEFSTSAmJiBDT01QSUxFX1RF
U1QpCj4gPiDCoAlkZXBlbmRzIG9uIFBDSV9NU0lfSVJRX0RPTUFJTgo+ID4gKwlkZXBlbmRzIG9u
IFBDSUVQT1JUQlVTCj4gPiDCoAlzZWxlY3QgUENJRV9EV19IT1NUCj4gwqAKPiDCoGNvbmZpZyBQ
Q0lFX1NQRUFSMTNYWAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
