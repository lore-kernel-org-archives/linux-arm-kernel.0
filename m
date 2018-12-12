Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB9C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:22:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BC520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejiyOeCv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/sdtdF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BC520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y+jmXnXO6HJ1yzIziGnfHCMhMAGnllYvVbTbotpYuXU=; b=ejiyOeCvnmo2PE
	El0CTtK2E+I221sU6yeqXrTtJYk4Jx9KtJopJfxzdIgHaNCzXBYbvdBUN3sK06oDK6jYTSJvigHHv
	Z2SWay9NzAQ9Dbg1Q3L3m3N3zoHBVf4SYysTTk8xFVTYMBawHM+DZ49fZfSLM0a32WkteogK3gt0n
	3sLqTpC4447vofOjqbBXcwtOK8kRSQhid0m4I1IScZpSV5yes4/YAT5CmYnvxUtkxDxPISSticWyb
	UHTWbKbngT1Kq0E7I2vUmkE6eL22DfPC1eWMtQi9bOvJ9OVwHbpORNDxIUz8hPa/JXyIJBhwmx09F
	tNGUsQgnPx10Rp14RQbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8Dk-0005UU-7o; Wed, 12 Dec 2018 17:22:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8Dg-0005TX-HW
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:22:49 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0BE582084E;
 Wed, 12 Dec 2018 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544635358;
 bh=XuK4ExPc8bBFloe/2WoPw14IMFW3BHgc7sK3vLIdSCY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Q/sdtdF46m1GbA7mV5HTba9rfAl/gJHCeHr6JFA9sKJIRhIg1Yq40MPA42M2iBRaP
 lLScO5bAdWMg5uAnuhHx6vhu9KF6LlJNEe1nMy2jWZ2ejrVIY7lfZw+3gjk097HKRG
 ilLMjYVZn14yJQnoAhhmNOn0LnZpxDX9S56KILdY=
Date: Wed, 12 Dec 2018 17:22:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Allow selection of Exynos ADC on S5PV210
Message-ID: <20181212172231.0adaf43b@archlinux>
In-Reply-To: <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_092248_600138_E156CCFD 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: mark.rutland@arm.com, linux-iio@vger.kernel.org, xc-racer2@live.ca,
 pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
 lars@metafoo.de, krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
 kgene@kernel.org, geert@linux-m68k.org, devicetree@vger.kernel.org,
 smohanad@codeaurora.org, vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, baolin.wang@linaro.org,
 rdunlap@infradead.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, knaack.h@gmx.de, eugen.hristev@microchip.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAgNyBEZWMgMjAxOCAyMDoxMTozNSArMDEwMApQYXdlxYIgQ2htaWVsIDxwYXdlbC5t
aWtvbGFqLmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgoKPiBGcm9tOiBKb25hdGhhbiBCYWtrZXIg
PHhjLXJhY2VyMkBsaXZlLmNhPgo+IAo+IE1ha2UgaXQgcG9zc2libGUgdG8gdXNlIEV4eW5vcyBB
REMgZHJpdmVyIG9uIFM1UFYyMTAgYmFzZWQgZGV2aWNlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBK
b25hdGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZlLmNhPgo+IFNpZ25lZC1vZmYtYnk6IFBhd2XF
giBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KQXBwbGllZCB0byB0aGUg
dG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0IGFuZCBwdXNoZWQgb3V0IGFzIHRlc3RpbmcKZm9yIHRo
ZSBhdXRvYnVpbGRlcnMgdG8gcGxheSB3aXRoIGl0LgoKVGhhbmtzLAoKSm9uYXRoYW4KCj4gLS0t
Cj4gIGRyaXZlcnMvaWlvL2FkYy9LY29uZmlnIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
YWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZwo+IGluZGV4IGE1MmZlYTg3NDlh
OS4uMjBlMTI2ZmYwMzBlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnCj4g
KysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcKPiBAQCAtMjc0LDcgKzI3NCw3IEBAIGNvbmZp
ZyBFUDkzWFhfQURDCj4gIAo+ICBjb25maWcgRVhZTk9TX0FEQwo+ICAJdHJpc3RhdGUgIkV4eW5v
cyBBREMgZHJpdmVyIHN1cHBvcnQiCj4gLQlkZXBlbmRzIG9uIEFSQ0hfRVhZTk9TIHx8IEFSQ0hf
UzNDMjRYWCB8fCBBUkNIX1MzQzY0WFggfHwgKE9GICYmIENPTVBJTEVfVEVTVCkKPiArCWRlcGVu
ZHMgb24gQVJDSF9FWFlOT1MgfHwgQVJDSF9TM0MyNFhYIHx8IEFSQ0hfUzNDNjRYWCB8fCBBUkNI
X1M1UFYyMTAgfHwgKE9GICYmIENPTVBJTEVfVEVTVCkKPiAgCWRlcGVuZHMgb24gSEFTX0lPTUVN
Cj4gIAloZWxwCj4gIAkgIENvcmUgc3VwcG9ydCBmb3IgdGhlIEFEQyBibG9jayBmb3VuZCBpbiB0
aGUgU2Ftc3VuZyBFWFlOT1Mgc2VyaWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
