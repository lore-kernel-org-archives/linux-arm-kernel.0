Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC722C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE5E21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vlpm5w2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE5E21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AEMxd96BrfqkVglnPJBqjVMWzx1yPJ2N+VjmZNLRaM0=; b=Vlpm5w2U8THg8r
	Ry4Sn2SElHLtqTlzJnOoivUHfJxA0J8B9+Tg+SKzShyKZVebKMQBAQeO5iO21qpkrJaIo/xuVz7nA
	ujEuDBj8Lz4FOp2OgNIDhkymNV3cfT0C66lkqy6tzhx1fT1TEUgC8ePJ0uhrmDcrZzdZk0PrjvG1x
	05ClL9CHQx1i3YAESPTYHD/ogxAfft4muVrScVw09q4KhagRk1NWAOEPdL1T2So7IWvO7sArHg2yR
	JnLeu8wzRXjQcMyequVdopGRnJ3rkChB6KBhxOk2s9Ndsyti7YZ/z0uPqAZ+BLkwY7MXqUSAKfgBn
	ifa4bIdVTl0ZsVSX8pOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guj1y-0000eT-VG; Fri, 15 Feb 2019 19:20:14 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guj1v-0000FN-An; Fri, 15 Feb 2019 19:20:12 +0000
Received: by mail-qt1-f194.google.com with SMTP id p48so12199866qtk.2;
 Fri, 15 Feb 2019 11:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fY5V1ZOnjn5yJlmWyUYeHJkYJ00V+PIatpO6G+Gkb7o=;
 b=Vvv7skI0XMKXvwwydrtMmK+sYtFfMziZAq/owq3QUBMV4MNkn7kBkUD3e69icZEt+b
 3OFFAJUBQ6d0OvoNQmf5l6WJjnIAjRDtlrzVWpNRaw8bLoNDpw2X2IdUmh5/2XnYX4ix
 KDsc5CbTgFvEETJFuDk1SIfKUH0V5UONnimgGNCnVRr3fxvVpwYxJcGU5EqCgtONXptA
 mkKexh6KwMUGh/6bH6PqeT2fB1hFKHlbV7q2MrtUjHsh09WDy8Gjuo0t3ra5t69LKqi4
 u+i3ITx2Q+wTS4G3daDURCn2GHhkOHMx5S/LY3RaXG2qZPcyH1pTx78GS/nOgv8dl1rY
 W5jQ==
X-Gm-Message-State: AHQUAub5+Du6ecfKGO40WQ3e2XyXCKi0U6SlLWDhrOj36VBaQ1V8MVIT
 cOgTi9Q0yeDOmWmYT5dM4RdVYN7GLlQ8pckCi/y3vw==
X-Google-Smtp-Source: AHgI3IbH7d2ez3RKASnq++9b+6+8Q1VPxJqveanvSz88H9C31dXz8dAnN1vThdW3T0qXRKK6fNawUFmmjLdCNndsYaU=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr8943854qta.152.1550258407186; 
 Fri, 15 Feb 2019 11:20:07 -0800 (PST)
MIME-Version: 1.0
References: <7484850.KS8GUYnfXV@phil> <23121360.LiWTZRSn6P@phil>
 <CAK8P3a0Oa4B_r3mAu6udmJPyKBnOwswTwOGsOuX0ruhfexqbxg@mail.gmail.com>
 <1707879.5psMmg8Cs2@diego>
In-Reply-To: <1707879.5psMmg8Cs2@diego>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 20:19:50 +0100
Message-ID: <CAK8P3a3+6RuTEo=C0jkdiBswHrrKCSoxvYi3r60j45Sn6rhL3g@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 5.0
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112011_373419_88DAB200 
X-CRM114-Status: GOOD (  11.20  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgNzozOCBQTSBIZWlrbyBTdMO8Ym5lciA8aGVpa29Ac250
ZWNoLmRlPiB3cm90ZToKPgo+IEFtIEZyZWl0YWcsIDE1LiBGZWJydWFyIDIwMTksIDEzOjQyOjQ4
IENFVCBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4gPiBPbiBGcmksIEZlYiAxLCAyMDE5IGF0IDEy
OjE0IFBNIEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+IHdyb3RlOgo+ID4gPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPiA+IEZpeCBmb3IgbmV3IGR0YyBncmFwaCB3YXJuaW5ncyBhbmQgYSByZWd1bGF0b3Ig
Zml4IGZvciByb2NrNjQuCj4gPiA+Cj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4KPiA+ID4gRG1pdHJ5IFZv
eXRpayAoMSk6Cj4gPiA+ICAgICAgIGFybTY0OiBkdHM6IHJvY2tjaGlwOiBlbmFibGUgdXNiLWhv
c3QgcmVndWxhdG9ycyBhdCBib290IG9uCj4gPiA+ICAgICAgIHJrMzMyOC1yb2NrNjQKPiA+Cj4g
PiBQdWxsZWQgaW50byBhcm0vZml4ZXMsIHRoYW5rcyEKPiA+Cj4gPiBOb3RlOiBzaW5jZSB3ZSBh
bHdheXMgaGF2ZSBvbmx5IGEgc2luZ2xlIGZpeGVzIGJyYW5jaCwgc2VuZGluZyB0aGUKPiA+IDMy
LWJpdCBhbmQgNjQtYml0IGZpeGVzIHRvZ2V0aGVyIHdvdWxkIGJlIHNsaWdodGx5IGVhc2llci4K
Pgo+IE5vIHByb2JsZW0sIEknbGwga2VlcCAzMis2NGJpdCBmaXhlcyB0b2dldGhlciBpbiB0aGUg
ZnV0dXJlLgo+IEkgZ3Vlc3MgcmVndWxhciBjaGFuZ2VzIGZvciB0aGUgbWVyZ2Utd2luZG93IHNo
b3VsZCBjb250aW51ZQo+IGJlaW5nIHNlcGFyYXRlZCwgcmlnaHQ/CgpZZXMsIHVubGVzcyB0aGV5
IGFyZSBsb2dpY2FsbHkgY29ubmVjdGVkLiBZb3UgY2FuIGFsc28gaGF2ZQptb3JlIHRoYW4gdHdv
IERUIHB1bGwgcmVxdWVzdHMgaWYgdGhhdCBtYWtlcyBhIGJldHRlciBzcGxpdC4KU29tZSBTb0Nz
IGhhdmUgc2VwYXJhdGUgZHQtYmluZGluZ3MgcHVsbCByZXF1ZXN0cyAoc2hhcmVkCndpdGggZHJp
dmVycyksIG9yIHNwbGl0IG91dCBzdHVmZiBieSBTb0Mgc3ViZmFtaWx5IGlmIGl0IGdldHMgdG9v
CmJpZyAocHJvYmFibHkgbm90IG5lY2Vzc2FyeSBmb3Igcm9ja2NoaXBzLCB3aGljaCBzZWVtIG1v
cmUKdW5pZm9ybSkuCgogICAgICAgQXJuZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
