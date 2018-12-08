Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E329C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9832082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nAAroExh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKnZPsqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9832082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bHxlX2doH/03A1e64OFRnBik5ZLXEorDb3mKHQAkto4=; b=nAAroExh9mznqP
	MNJVBZQ69y2r7h6aoInKuQIxenWw2/eqXu2bvYkQriLR0ITtyGxoK99HIJyExQEaA1M6qIzEkieps
	wQ1qqEtkrvcu9N0+Qbydgsb5ZRkmRYq2mzqtck5rMtlftHn1DBsLOeTjmo1qoBQaHSZB8wr4Kgqzx
	EoUR6m2iQVs2uehLc3IkCccDGmauFMK7LOwSATjHtST3aD/1YDqR1MdLhys+KyMR6MmmhD0+jgsSp
	gYnDciAFL+jLUdMzC8IhGJfhZjSsMVM6V/V/cLCwBc/xZ0TK7zMc4giJNvgkK91iCDki+mlBwsO/p
	0Z++Hpg5jw80G28KfkBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVf2b-0000OM-0G; Sat, 08 Dec 2018 16:01:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVf1X-0007SK-0Z
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 16:00:13 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D50F2082D;
 Sat,  8 Dec 2018 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544284800;
 bh=7u4sLAcIWoqgO7FbIzSNvTN1AnfiCF39+hfHMIcL2FQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KKnZPsqCsYCCC41LjUO3AeE1Q/OLp2HAWLkUfhwMVvwHVVlKAimVDpSb6QYofofcz
 H1SF6QxcaAJQzRfgSSbNSHlBl94nU0vaBZC5DjuHac9hqhVKaqzneOmyfLLJ0gVJy7
 EoiUGw8hl7rDTnpmZrhlrLie3bju9+yWnmIL9PS4=
Date: Sat, 8 Dec 2018 15:59:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: exynos-adc: Add support for S5PV210
Message-ID: <20181208155953.6e31ba04@archlinux>
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_080011_207210_B3F34B9D 
X-CRM114-Status: GOOD (  12.15  )
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

T24gRnJpLCAgNyBEZWMgMjAxOCAyMDoxMTozMyArMDEwMApQYXdlxYIgQ2htaWVsIDxwYXdlbC5t
aWtvbGFqLmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgoKPiBUaGlzIHBhdGNoc2V0IGFkZHMgc3Vw
cG9ydCBmb3IgUzVQVjIxMCBhZGMgdmFyaWFudCB0byBleHlub3MtYWRjIGRyaXZlci4KClRoaXMg
bG9va3MgZmluZSB0byBtZSwgYnV0IEknZCBsaWtlIHRvIGxldCBpdCBzaXQgb24gdGhlIGxpc3Rz
CmZvciBhIGZldyBkYXlzIHRvIGxldCBwZW9wbGUgbW9yZSBmYW1pbGlhciB3aXRoIHRoZSBwbGF0
Zm9ybSBoYXZlCnRpbWUgdG8gcmV2aWV3LgoKR2l2ZSBtZSBhIHBva2UgaWYgSSBzZWVtIHRvIGhh
dmUgZm9yZ290dGVuIGl0IGluIGEgd2VlayBvciBzby4KClRoYW5rcywKCkpvbmF0aGFuCgo+IAo+
IEpvbmF0aGFuIEJha2tlciAoMyk6Cj4gICBpaW86IGFkYzogZXh5bm9zLWFkYzogQWRkIFM1UFYy
MTAgdmFyaWFudAo+ICAgaWlvOiBhZGM6IEFsbG93IHNlbGVjdGlvbiBvZiBFeHlub3MgQURDIG9u
IFM1UFYyMTAKPiAgIGR0LWJpbmRpbmdzOiBpaW86IGFkYzogZXh5bm9zLWFkYzogQWRkIFM1UFYy
MTAgdmFyaWFudAo+IAo+ICAuLi4vYmluZGluZ3MvaWlvL2FkYy9zYW1zdW5nLGV4eW5vcy1hZGMu
dHh0ICAgICAgICB8ICA0ICsrKy0KPiAgZHJpdmVycy9paW8vYWRjL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2lpby9hZGMvZXh5bm9zX2FkYy5j
ICAgICAgICAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
