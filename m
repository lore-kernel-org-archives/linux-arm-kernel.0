Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99EAC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3C820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="feU7Y3wU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eritikvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3C820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wwTNX0DtHwx+HpsXnRX9x3dkNVSMauZu7s9vWboP86w=; b=feU7Y3wUDBs5qx
	MWKlEyCkUOKWNR7jsXOsirSq2QghIxJg5phJzyBQrtvi1xtlFzNTkNYL5JSV8OfSaFP6yxp0zuHzs
	2LOkE34VhiZTImLi+VW9vY6idVNryxfQoHatoAEdgGanMcKxg5pPcsM07ypmRnxzWRm08u1kiNy+m
	UXhg8BBuUzjg1Xbjn/abmuBfKYxkEYz/39DzY2h0pICnEJ8zWslXCbNKlXUmA6AQ543K5+VIOxvGh
	CUNXXTbmZK6MVPtJGwvF/jFWS4gz/A5madIB9NU9u/467REol3KbgVirznqOD+W0SjlaYAiMf6/zJ
	+w0T+T9IfOxxWHRVoUsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrux-0008P9-1j; Mon, 03 Dec 2018 17:21:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTruu-0008Np-2E
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:21:57 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16613214D9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543857702;
 bh=X2qZ6GwYNv4eMDTPMV9pGs6q3gtKZ2GyEOUTmTFUdV8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EritikvdcDwV9trSJfXmbUUvVuOgvKK5qseCpNVsy9to3BwvGPI74QFaSjIWhc8ih
 3zEp8NJU9IgNYTznalf4TosXFE008ov6c9M72AHkLV4buIf9HpehxBMswV8IVu9Rs+
 E9WfO5Ht99saleVn58rxn/lUoLODkMFwo34VKfx8=
Received: by mail-qt1-f169.google.com with SMTP id n32so14636580qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:21:42 -0800 (PST)
X-Gm-Message-State: AA+aEWZ3WHxlCqcs9nxL2aol9gTr57Jvcr1xmI1Ex5CHynyHpXp8nRjf
 DDRBSySsNzIkSJvuuk4yytreq84iy/EeeqlUPA==
X-Google-Smtp-Source: AFSGD/WlvvOwuJswDIQCvhO/1MzKZzl4YBK4cAgaWDxIMek2YNT/JUKXLWljCdM7S7BtjEXAGT568LVpUoTItv1KRZg=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr16474996qts.144.1543857701208; 
 Mon, 03 Dec 2018 09:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
 <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
In-Reply-To: <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 3 Dec 2018 11:21:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Message-ID: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT
 board
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_092156_146002_D7352D3D 
X-CRM114-Status: GOOD (  21.27  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 overseas.sales@unisoc.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMywgMjAxOCBhdCAxMToxMSBBTSBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhv
bS5uZXQ+IHdyb3RlOgo+Cj4gT24gTW9uLCBEZWMgMywgMjAxOCBhdCA3OjU0IEFNIFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgTm92IDIwLCAy
MDE4IGF0IDk6MzggUE0gTWFuaXZhbm5hbiBTYWRoYXNpdmFtCj4gPiA8bWFuaXZhbm5hbi5zYWRo
YXNpdmFtQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBBZGQgaW5pdGlhbCBkZXZpY2V0
cmVlIHN1cHBvcnQgZm9yIE9yYW5nZVBpIDJHIElvVCBib2FyZCBmcm9tIFh1bmxvbmcuCj4gPiA+
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZz4KPiA+ID4gLS0tCj4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgMiArCj4gPiA+ICAuLi4vYm9vdC9kdHMvcmRh
ODgxMHBsLW9yYW5nZXBpLTJnLWlvdC5kdHMgICAgfCA0MCArKysrKysrKysrKysrKysrKysrCj4g
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKPiA+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cwo+
ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZQo+ID4gPiBpbmRleCBiMGU5NjZkNjI1YjkuLmEwZmRhZDhm
MTBkZCAxMDA2NDQKPiA+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKPiA+ID4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKPiA+ID4gQEAgLTgwNiw2ICs4MDYsOCBA
QCBkdGItJChDT05GSUdfQVJDSF9RQ09NKSArPSBcCj4gPiA+ICAgICAgICAgcWNvbS1tc204OTc0
LXNvbnkteHBlcmlhLWNhc3Rvci5kdGIgXAo+ID4gPiAgICAgICAgIHFjb20tbXNtODk3NC1zb255
LXhwZXJpYS1ob25hbWkuZHRiIFwKPiA+ID4gICAgICAgICBxY29tLW1kbTk2MTUtd3A4NTQ4LW1h
bmdvaC1ncmVlbi5kdGIKPiA+ID4gK2R0Yi0kKENPTkZJR19BUkNIX1JEQSkgKz0gXAo+ID4gPiAr
ICAgICAgIHJkYTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRiCj4gPiA+ICBkdGItJChDT05GSUdf
QVJDSF9SRUFMVklFVykgKz0gXAo+ID4KPiA+IFF1ZXN0aW9uIGZvciBBcm5kL09sb2Y6IGNhbiB3
ZSAqcGxlYXNlKiBzdGFydCBwdXR0aW5nIG5ldyBTb0MgZmFtaWxpZXMKPiA+IGluIHN1Yi1kaXJz
Pwo+Cj4gSSB0aGluayB3ZSdyZSBhdCBhIHBvaW50IHdoZXJlIGl0J3MgYmVjb21pbmcgcXVpdGUg
YXdrd2FyZCB0byBrZWVwIGl0Cj4gaW4gYSBmbGF0IGRpcmVjdG9yeSwgeWVzLgo+Cj4gQmVzdCB3
YXkgdG8gaGFuZGxlIHRoaXMgaXMgdXN1YWxseSByaWdodCBiZWZvcmUgdGhlIGNsb3Npbmcgb2Yg
YSBtZXJnZQo+IHdpbmRvdywgc28gbGV0J3MgZG8gaXQgdGhlbi4gSXQnbGwgYmUgYSBjb25mbGlj
dC1yaWRkZW4gbWVzcyBpZiB3ZSB0cnkKPiB0byBzdGFnZSBzb21ldGhpbmcgaW4gLW5leHQsIHNv
IEknZCByYXRoZXIganVzdCBkbyBpdCBkaXJlY3RseSBpbiBvdXIKPiB0cmVlIGFzIGEgb25lLXNo
b3QgdGhpbmcuCgpXaGlsZSBJJ2QgbGlrZSB0byBzZWUgdGhlIHdob2xlIHRoaW5nIGNvbnZlcnRl
ZCwgSSB3YXMgb25seSBhc2tpbmcKYWJvdXQgdGhpcyBvbmUgcGxhdGZvcm0uIFRoYXQgc2hvdWxk
IGJlIGRvYWJsZSBub3csIHJpZ2h0PwoKUm9iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
