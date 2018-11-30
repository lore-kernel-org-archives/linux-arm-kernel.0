Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53233C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228FD20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeYnASsV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtRLN4lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228FD20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oeHP9M4df1gJHKVhM7OCa0sw5Pgdr3H/RRrpbO1FTr0=; b=BeYnASsVQyguvM
	q7DZWFuy3WwYnbeUYCGIEEKzuIRGcbS10qSWlYuhXCKrs6Y8+Ag6h0ZGA1nLEFSr6E4pamfuveaXI
	2HqDcDPK49eUEgCWXlUjgSn97qtHxt71Gb4HM30NateXasbQNNtVRd0XROam522NqKcsQbUkJwwLI
	GkpH7/zsD2G9f0HiTrInAQjM9I7haGl4wW1bQ+UbMsS/1ZFGJ4HnFKJxIoVr6mW6J7JlzbJ2loq+G
	sp2ZCBkxEHekNqDLegqwcXJlJNab2VvPwJkD61YOKo8bUIDOPOSeXnDnvpu9quOayLbXIwJS2XRyq
	RiVH20eNiPCu+i4HN/sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSq9g-0008KO-Ti; Fri, 30 Nov 2018 21:16:56 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSq9d-0008HL-Iq
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 21:16:55 +0000
Received: by mail-ot1-x341.google.com with SMTP id 32so6381143ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6WiRvfgRd8T4/rxLZkOLImFaiSwubPUW787UwCMnY3o=;
 b=DtRLN4lumlTAAxw5WI+uCcUwq8rPib8May+YV5ryGtTLD5KJqNdNcK8MeFAHcHN8wG
 uMscpMeu0lWVNA6AvsO4oJ1w/1oBQ0Mn4jAiBMz+PyG9QeOUGgyRThKYxYAFZzNgeNJr
 +Ev1eBo+a8CJOa3OixzMd1ZmedAtJt0GFNYthpD2Mqy2M269caD/XMRX6NfxHcpaF9o2
 di+2Ji/WzYGkweQgb0iOFSgG2J4BRKR6zfHoOZ76g5bKjueJpYMdnKz/nrxRiHCSslxd
 JzX91EhGgysWm/DW2tzW08npx+Fg/sAstjxThJ0VT09+Z1mQhTQH03ehyRXAwFj5jySA
 Xc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6WiRvfgRd8T4/rxLZkOLImFaiSwubPUW787UwCMnY3o=;
 b=uDt8iexE9vRdMj0v7w8YOTZloMOCQmRnU9dCP2Jee3o5P8OTtFw2LNodRiFj+J7fDF
 D++KolHrx21/vutH4y/KUgtPGiDf6W8aec2MGIR8sqn81U+66AhYwP/cfLcP/kuKNgxd
 /JbC/eY5Szh6vz5kGEDRdr5oq4qXU1FLxayXVw/q1ui7sdoVBSHJ3vDClgIJ/EUej1EX
 5kO1ww/CiVuIN7+b5EPxTY+HxWNnkrD8Ilpfv0ze0cbnDnPSy6XVTr1xRTBsuSsm5bx7
 TVgl+53n/bKWiZU4kXswh9jfgcu9a6BTlN/wn7L7mJANxijv41S3JrzXMCcgMHibEExl
 20vQ==
X-Gm-Message-State: AA+aEWYmQYZzhZqq87/9qQ5AdxJLK/3qUoAgnXP9UnnIT4MrlEvHBpBb
 vJ55/r5TrPcww8VEfRoegun0fvkbXC38DK6jsQM=
X-Google-Smtp-Source: AFSGD/VeFUjwsyK2DQ9PgwbaV6twjc7zdxRBKYqOgpy1rp4GNNOoMoRh//eTeva1hwGBPxqMWo522F9PwWOrPg/rQNQ=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr4702737oty.203.1543612601990;
 Fri, 30 Nov 2018 13:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20181130205309.17232-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181130205309.17232-1-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 Nov 2018 19:16:39 -0200
Message-ID: <CAOMZO5AE2Z6+7pYf6CaU0NK8TGBk+WtBBauLHZ-14w-_HLuX1g@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: imx: unify over-current polarity handling
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Matthew Starr <mstarr@hedonline.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_131653_619290_12DF0F3A 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Peter Chen <Peter.Chen@nxp.com>, USB list <linux-usb@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVXdlLAoKW0FkZGluZyBNYXR0XQoKT24gRnJpLCBOb3YgMzAsIDIwMTggYXQgNjo1MyBQTSBV
d2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToK
Pgo+IFRoZSBzdGF0dXMgcXVvIGlzOgo+ICAtIG9uIGkuTVgyNSB0aGUgb3ZlcmN1cnJlbnQgcG9s
YXJpdHkgaXMgYWx3YXlzIGV4cGxpY2l0bHkgY29uZmlndXJlZCBhcwo+ICAgIGFjdGl2ZSBoaWdo
IHdoaWNoIG1hdGNoZXMgdGhlIHJlc2V0IGRlZmF1bHQuCj4gIC0gb24gaS5NWDYgYW5kIGkuTVg3
IHRoZSBvdmVyY3VycmVudCBwb2xhcml0eSBpcyBhY3RpdmUgaGlnaCBhZnRlcgo+ICAgIHJlc2V0
LiB1c2JtaXNjX2lteDZxX2luaXQoKSBhbmQgdXNibWlzY19pbXg3ZF9pbml0KCkga2VlcCB0aGUg
Y3VycmVudAo+ICAgIHN0YXRlIChwcm9iYWJseSBhcyBzZXR1cCBieSB0aGUgYm9vdGxvYWRlciBv
ciBzdGlsbCB0aGUgcmVzZXQKPiAgICBkZWZhdWx0KSB1bmxlc3MgdGhlIHBvbGFyaXR5IGlzIGV4
cGxpY2l0bHkgY29uZmlndXJlZCBhcyBhY3RpdmUgaGlnaAo+ICAgIHdoaWNoIHRoZW4gaXMgY29u
ZmlndXJlZC4gKFNvIGlmIHRoZSBwaW4gaXMgYWN0aXZlIGxvdyBhbmQgdGhlCj4gICAgYm9vdGxv
YWRlciBkaWRuJ3Qgc2V0IHRoaXMgdXAgdGhlIGNvbmZpZ3VyYXRpb24gaXMgd3JvbmcuKQo+Cj4g
VG8gaW1wcm92ZSB0aGUgc2l0dWF0aW9uIGFsd2F5cyBjb25maWd1cmUgdGhlIHJlc2V0IGRlZmF1
bHQgdmFsdWUgdW5sZXNzCj4gdGhlIGRldmljZSB0cmVlIGNvbmZpZ3VyZXMgdGhlIHBvbGFyaXR5
IChhbmQgdGhlbiB1c2UgdGhpcyBvbmUpLgo+Cj4gTm90ZSB0aGF0IGFzIHRoZSByZXNldCBkZWZh
dWx0IGlzIGFjdGl2ZSBoaWdoIG9uIGFsbCBwbGF0Zm9ybXMgdGhlcmUgaXMKPiBubyBuZWVkIHRv
IGNoZWNrIGZvciB0aGUgcHJlc2VuY2Ugb2YgIm92ZXItY3VycmVudC1hY3RpdmUtaGlnaCIuIElu
IHRoZQo+IGFic2VuY2Ugb2YgIm92ZXItY3VycmVudC1hY3RpdmUtbG93IiBpdCBkb2Vzbid0IG1h
dHRlciBpZiBhY3RpdmUgaGlnaCBpcwo+IGNvbmZpZ3VyZWQgYmVjYXVzZSB0aGF0J3MgdGhlIGRl
ZmF1bHQgb3IgYmVjYXVzZSBpdCBpcyBjb25maWd1cmVkCj4gZXhwbGljaXRseS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+CgpJdCBzZWVtcyB0aGF0IE1hdHQgaXMgYWxzbyBpbnRlcmVzdGVkIGluIGFkZGluZyB0aGUK
J292ZXItY3VycmVudC1hY3RpdmUtbG93JyBwcm9wZXJ0eToKaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMDcwMTMxMS8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
