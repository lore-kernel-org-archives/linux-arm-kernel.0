Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:53:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DBE20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TA6dNVhL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MHjzkQ5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DBE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lvuvQuQnXpbzALWtQUoGpR/jpT+LYMUsmx+Ebubcy5A=; b=TA6dNVhLkbOCL5
	xu0nUZLlYIRCGfBsFDnNarpyj2GGehOPmTUpkMfLKl1oke2DzNLbhZWys41oJrVDjCjlZDOK/j5nN
	YSIKz0CE5lNP0bz2W0oGEcDzYv5+PXZe6dYFPXqvxEhsT3dYG9h+NW7sHRvEmy1LWZQFGn//YMkin
	VVdkiqWkZyM64ujt79KYQRaoU6qJeomtrzswV4rrqqjVv8a7I9QpPRlIuLoWyTGjJu/1zlzA/SmPD
	85899pPu46KVIAOOQL/B/AA0+Y1s1B8FKk5z1YUoVcMHf4Y5XDdeinE/vGIzkL3VZE/jfEuQW6ac3
	2bV/NpaQaezIwBUSSuiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsPO-0007Di-T1; Mon, 03 Dec 2018 17:53:26 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsPL-0007Ce-9V
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:53:25 +0000
Received: by mail-it1-x141.google.com with SMTP id a6so9899514itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jrZm1EVRc3lEWmoL1Qrzl/u0xfvJ16xasMcx5rZfWPM=;
 b=MHjzkQ5D55rQRC09jOgOH9wq3Rk8bQbipn5cgUcx8cJ2yq/xkBw6vmZ4xp9wVcrYXH
 LsOTTGFCmVLohXxqhbWUEE8ABkEMr2Kt+MklKzDjtf6svGiVDoQMzrJ8YbAr2WfpJUFa
 TaljyRsAWVWbpXiRRY7aj1xRG0BRLCKfbOz7yluoANdSIJ9z8L3FDaJ25unZYv9jfk/g
 nX951/4yFCd8XqjUsxHXA05AG85dxUhRNTl3viQtVepsk+lx4ph4UV5ianzUTj0O0sDl
 bSCfyWM11/7T/mavxDwIc6sNxyJ/bGQMtO5SWu956TQFsNEH4MoA33xisPFyrP+oxLYy
 rB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jrZm1EVRc3lEWmoL1Qrzl/u0xfvJ16xasMcx5rZfWPM=;
 b=JNbYVHt3pJTGFTtlSGzQKvRigtUp+EcPXf2R9AFwaGaDis6pvdqSYWoExXwMRxW+TV
 hB10UTzr0VoGBeSgVK8YZSOAx6HDo0idsGTxVk1bE4GLsT4Q92Vsh2U89U7qsuQtERaM
 v1SOq0Wk+DDhyIITPOetb2z3wp8MNnHg3/hx2+bWDy3D3Eakd8DL1N/mRe+nVlXI2CO/
 QRRDGAD0N0eQ1LpmUKiOOUb9fc5FUWzxIiAEdo6bYOT6VwYuM1Xn4lNz/QlQWKPQ7yP1
 Llg9c5t/xwpXw/8JMMipzzyP3aTXyxcLjXdlkhAk7pMHQw6o1pE23xRbeb/F6iF2kZdo
 tX5w==
X-Gm-Message-State: AA+aEWZruRgwYVAJwIb+nV5hvWWenIaiMKiR6cb0pCAHXiDSUYhj+ago
 /1OI7p/9Obcg3VAPYsS/lDDHJD7+R/F6nCdy1SLavg==
X-Google-Smtp-Source: AFSGD/U3dYAM8cLPdIisk0V1q1bwKif+eSHDkiHenUVaNNbJIsqarq0U51ofWMatd8hPL+qciP6UMdEiKInK5xMqsWI=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr8519661itg.136.1543859591740; 
 Mon, 03 Dec 2018 09:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
 <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
 <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
In-Reply-To: <CAL_JsqLZY_5rZ35YSGeH7wmEZoLP1TjG+0n4BWGiUBwOFSq-Vw@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Mon, 3 Dec 2018 09:53:00 -0800
Message-ID: <CAOesGMi=qFB0jTTAzTYxBduYf_7RVwOZkKNjckpqg6tbd3sPow@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT
 board
To: Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_095323_336852_88A9581E 
X-CRM114-Status: GOOD (  21.17  )
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
Cc: DTML <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LinusW <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 overseas.sales@unisoc.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMywgMjAxOCBhdCA5OjIxIEFNIFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBEZWMgMywgMjAxOCBhdCAxMToxMSBBTSBPbG9mIEpv
aGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgRGVjIDMsIDIw
MTggYXQgNzo1NCBBTSBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPiB3cm90ZToKPiA+
ID4KPiA+ID4gT24gVHVlLCBOb3YgMjAsIDIwMTggYXQgOTozOCBQTSBNYW5pdmFubmFuIFNhZGhh
c2l2YW0KPiA+ID4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPiB3cm90ZToKPiA+
ID4gPgo+ID4gPiA+IEFkZCBpbml0aWFsIGRldmljZXRyZWUgc3VwcG9ydCBmb3IgT3JhbmdlUGkg
MkcgSW9UIGJvYXJkIGZyb20gWHVubG9uZy4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3Jn
Pgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgfCAgMiArCj4gPiA+ID4gIC4uLi9ib290L2R0cy9yZGE4ODEwcGwtb3Jhbmdl
cGktMmctaW90LmR0cyAgICB8IDQwICsrKysrKysrKysrKysrKysrKysKPiA+ID4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL2FybS9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cwo+ID4gPiA+Cj4g
PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvTWFrZWZpbGUKPiA+ID4gPiBpbmRleCBiMGU5NjZkNjI1YjkuLmEwZmRhZDhmMTBk
ZCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQo+ID4gPiA+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlCj4gPiA+ID4gQEAgLTgwNiw2ICs4MDYs
OCBAQCBkdGItJChDT05GSUdfQVJDSF9RQ09NKSArPSBcCj4gPiA+ID4gICAgICAgICBxY29tLW1z
bTg5NzQtc29ueS14cGVyaWEtY2FzdG9yLmR0YiBcCj4gPiA+ID4gICAgICAgICBxY29tLW1zbTg5
NzQtc29ueS14cGVyaWEtaG9uYW1pLmR0YiBcCj4gPiA+ID4gICAgICAgICBxY29tLW1kbTk2MTUt
d3A4NTQ4LW1hbmdvaC1ncmVlbi5kdGIKPiA+ID4gPiArZHRiLSQoQ09ORklHX0FSQ0hfUkRBKSAr
PSBcCj4gPiA+ID4gKyAgICAgICByZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0Ygo+ID4gPiA+
ICBkdGItJChDT05GSUdfQVJDSF9SRUFMVklFVykgKz0gXAo+ID4gPgo+ID4gPiBRdWVzdGlvbiBm
b3IgQXJuZC9PbG9mOiBjYW4gd2UgKnBsZWFzZSogc3RhcnQgcHV0dGluZyBuZXcgU29DIGZhbWls
aWVzCj4gPiA+IGluIHN1Yi1kaXJzPwo+ID4KPiA+IEkgdGhpbmsgd2UncmUgYXQgYSBwb2ludCB3
aGVyZSBpdCdzIGJlY29taW5nIHF1aXRlIGF3a3dhcmQgdG8ga2VlcCBpdAo+ID4gaW4gYSBmbGF0
IGRpcmVjdG9yeSwgeWVzLgo+ID4KPiA+IEJlc3Qgd2F5IHRvIGhhbmRsZSB0aGlzIGlzIHVzdWFs
bHkgcmlnaHQgYmVmb3JlIHRoZSBjbG9zaW5nIG9mIGEgbWVyZ2UKPiA+IHdpbmRvdywgc28gbGV0
J3MgZG8gaXQgdGhlbi4gSXQnbGwgYmUgYSBjb25mbGljdC1yaWRkZW4gbWVzcyBpZiB3ZSB0cnkK
PiA+IHRvIHN0YWdlIHNvbWV0aGluZyBpbiAtbmV4dCwgc28gSSdkIHJhdGhlciBqdXN0IGRvIGl0
IGRpcmVjdGx5IGluIG91cgo+ID4gdHJlZSBhcyBhIG9uZS1zaG90IHRoaW5nLgo+Cj4gV2hpbGUg
SSdkIGxpa2UgdG8gc2VlIHRoZSB3aG9sZSB0aGluZyBjb252ZXJ0ZWQsIEkgd2FzIG9ubHkgYXNr
aW5nCj4gYWJvdXQgdGhpcyBvbmUgcGxhdGZvcm0uIFRoYXQgc2hvdWxkIGJlIGRvYWJsZSBub3cs
IHJpZ2h0PwoKSSdkIHJhdGhlciBhcHBseSB0aGlzIHRvIGN1cnJlbnQgc2NoZW1lIGFuZCB0aGVu
IG1vdmUgZXZlcnl0aGluZyBvbmNlLAppbnN0ZWFkIG9mIGhhdmluZyBtYWludGFpbmVycyBnbyAi
T2gsIEkgZ3Vlc3MgSSBuZWVkIHRvIG1vdmUgbWluZSIgYW5kCndlIGVuZCB1cCB3aXRoIGFuIG9u
c2xhdWdodCBvZiBjb25mbGljdGluZyBwdWxsIHJlcXVlc3RzIHRvIG1vdmUKdGhpbmdzIGFwYXJ0
LgoKCi1PbG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
