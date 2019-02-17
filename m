Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91363218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ooqMdPHw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuEpMvIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91363218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ov4EUFvz7O5uGfbZaWPvUfjYUOzbHR+CTDiNicv1hUI=; b=ooqMdPHwjryWyd
	WFfdijcC3VKLRrwEG4g7pY1XR8wd27ZuKIv1kjYbwYTlGx+S206HJdBc+kZ7gRhoVTJwHJVPEfkEz
	bNLk4Q2J6mpk++/C+2TTtSvdxH7RcdqZVOMeCqaA7GhQXdg+YxgpBTtI3eO6v6V6Wop2wmscGapQi
	MOaVro22uWgih5EJhmkrAGJ4OnlQsfiJuhdfbmWk7VmrxC9fSHPtzgYPKeLYoLK3AXJNoKIo8Addf
	BR5kA7oxUHj1Q38y/iUVXQ6+ghl1qIb4Ery+nlzpRmBGwLG5XfXT/r8tvNRml5z9tKmE4eqohIRLn
	M92YIVBBOj8vnaOQJA2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvTD8-0000co-Vj; Sun, 17 Feb 2019 20:38:51 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvTD4-0000bV-Er; Sun, 17 Feb 2019 20:38:48 +0000
Received: by mail-qt1-x842.google.com with SMTP id w4so17153160qtc.1;
 Sun, 17 Feb 2019 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8NH2pOdkehstcvqJYaDe1Ufk9vUWZdsIpYEk5ecaQcA=;
 b=LuEpMvIVduCJmyhjCB9niToJqhjS9JJ9Prwu5uBf2cNcg2gA+ZA4JsuTMGptaf2Nf7
 niYyvuptb6q8ogzJJgl0Lfv1L6BvCMssOoadxvzfKeUjhn/OPXG725UStO6bhBvQVqIk
 OogvVzazD9aw8FPdl9n4Ee0y2TO0z2SUgeB+RHkq/gvQ8GnURRaEr+XlYmc7ZQru++/F
 RPQk7jmCVsgdIXINbz64ixLZydEWdVfbF/fKLYuFeIuXmfRHZRaPMJETXA49xo2F0sJ8
 UKx6P2GExhgFb1NozTveTgzeq0gxLhXuFc9EtCEwU4NHDzOczroQtC5jXTPJ6Gv093wK
 BNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8NH2pOdkehstcvqJYaDe1Ufk9vUWZdsIpYEk5ecaQcA=;
 b=EMKDnGUML6Tcs9bCJdQsL7EysPYEDDdD66P2ES1Z2k0plHizL+EMy5F1Ygp9kz4GeP
 6JuwFO5h+NbXKp9tgn957T/JZ90IvEm9AEbDrzMNlyhuX25JervIAeDvCoq19MSv+YAZ
 b6j6bG5hmzjx00P8adiK7HqZNuUGBmrpBoxaw1JK1gTShz3tkMGMhQxJDoC04wMiTLZc
 KTYac3sN4beN3Ak5PlARpY2lQQfkZQ7dXUU9PUlX/iSKEjhM3I9eJu92wKlV1UTw/+T4
 XFq1yXkDwkupL7kKdSkk6eT3itzmJZ7pYPOET650wmiIpw/TBjm0Whqy64labZrNCTOf
 a2AA==
X-Gm-Message-State: AHQUAuZP3ssUM6FxO41u2ISmTs5myaJ61l32rs8PakgGxcbPGnxomuie
 hl8MDgqdwQXMGzUsq3QkMGYdBNYUPH9hUcHgOYQ=
X-Google-Smtp-Source: AHgI3IbnlIHrgzKp9v+TFG/nPCbt/kEAUx+mvBUVqpGQiFNEtsy6LkUaMa49FCQLbxegblIkl1uAbg5MDRDKzWqI9Ew=
X-Received: by 2002:ac8:34eb:: with SMTP id x40mr15606664qtb.389.1550435923397; 
 Sun, 17 Feb 2019 12:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20190215115150.32299-1-enric.balletbo@collabora.com>
 <22158501.cNvkU8jGDh@diego>
 <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
 <2105716.Hge0YL7z4n@phil>
In-Reply-To: <2105716.Hge0YL7z4n@phil>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Sun, 17 Feb 2019 21:38:32 +0100
Message-ID: <CAFqH_50ydkQWYbgRZX=nYMb-Goe5mT30yUbKNisqmQcj=-tOSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_123846_499335_FB4B07EC 
X-CRM114-Status: GOOD (  18.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandru M Stan <amstan@chromium.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCk1pc3NhdGdlIGRlIEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+IGRlbCBkaWEg
ZHMuLCAxNiBkZSBmZWJyLgoyMDE5IGEgbGVzIDIxOjI4Ogo+Cj4gQW0gU2Ftc3RhZywgMTYuIEZl
YnJ1YXIgMjAxOSwgMDI6MTM6MjUgQ0VUIHNjaHJpZWIgQWxleGFuZHJ1IE0gU3RhbjoKPiA+IE9u
IEZyaSwgRmViIDE1LCAyMDE5IGF0IDM6MDkgUE0gSGVpa28gU3TDvGJuZXIgPGhlaWtvQHNudGVj
aC5kZT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEhpIEVucmljLAo+ID4gPgo+ID4gPiBBbSBGcmVpdGFn
LCAxNS4gRmVicnVhciAyMDE5LCAxMjo1MTo1MCBDRVQgc2NocmllYiBFbnJpYyBCYWxsZXRibyBp
IFNlcnJhOgo+ID4gPiA+IEluIG9yZGVyIHRvIHVzZSBlYXJseWNvbiwgdGhlIHN0ZG91dC1wYXRo
IHByb3BlcnR5IG5lZWRzIHRvIGJlIHNldAo+ID4gPiA+IGluIHRoZSBjaG9zZW4gbm9kZS4KPiA+
ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmlj
LmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4gPiA+Cj4gPiA+IFdoYXQncyB0aGUgcmVhc29uIGZv
ciBhZGRpbmcgdGhpcyBvbmx5IGZvciB0aGUgQ2hyb21lYm9vayB2YXJpYW50cz8KPiA+ID4gVWFy
dDIgaXMgcHJldHR5IG11Y2ggdGhlIHN0YW5kYXJkIG91dHB1dCBmb3IgYWxsIGRldmljZXMsIHNv
IEknZCBhc3N1bWUKPiA+ID4gYXQgbGVhc3QgYWxsIHZleXJvbiBib2FyZHMgc2hvdWxkIHVzZSB1
YXJ0MiBhcyB3ZWxsLCBtYWtpbmcgdGhpcyBpZGVhbGx5Cj4gPiA+IGxpdmUgaW4gdGhlIHJrMzI4
OC12ZXlyb24uZHRzaSBpbnN0ZWFkPwo+ID4KPiA+IFllcCwgYWxsIHZleXJpYW50cyB1c2UgdWFy
dCAyLCBldmVuIHdoZW4gdGhleSdyZSBub3QgY2hyb21lYm9va3MuCj4gPiBGZWVsIGZyZWUgdG8g
cHV0IGl0IGluIHRoZSBvdGhlciBmaWxlIGluc3RlYWQuCj4gPgo+ID4gT3RoZXJ3aXNlIGl0J2xs
IG1ha2UgdGhpbmdzIGxpa2UgdGhlIEFzdXMgQ2hyb21lYml0IChtaWNrZXkpLCBBT3Blbgo+ID4g
Q2hyb21lYm94IG1pbmkgKGZpZXZlbCksIGFuZCBBT3BlbiBDaHJvbWViYXNlICh0aWdlcikgdW5o
YXBweQo+ID4gd2hpbGUgZGVidWdnaW5nLgo+ID4KPiA+IFRoZSByazMyODgtdmV5cm9uLWNocm9t
ZWJvb2suZHRzaSBmaWxlIGlzIG1vcmUgZm9yIHRoaW5ncyB0aGF0IG1ha2UKPiA+IGEgY2hyb21l
Ym9vayBwb3J0YWJsZS4gRXg6IGJ1aWx0IGluIGRpc3BsYXksIGxpZCBzd2l0Y2gsIGNyb3MtZWMu
Cj4gPgo+ID4gTm90ZSBob3cgd2UgaGF2ZSBubyB1YXJ0MiByZWZlcmVuY2VzIGVpdGhlciBpbiBv
dXIgdHJlZSBpbiB0aGUKPiA+IGNocm9tZWJvb2sgc3BlY2lmaWMgZHRzaToKPiA+IGh0dHBzOi8v
Y2hyb21pdW0uZ29vZ2xlc291cmNlLmNvbS9jaHJvbWl1bW9zL3RoaXJkX3BhcnR5L2tlcm5lbC8r
L2Nocm9tZW9zLTMuMTQvYXJjaC9hcm0vYm9vdC9kdHMvcmszMjg4LXZleXJvbi1jaHJvbWVib29r
LmR0c2kKPgo+IHRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbiA6LSkgLgo+Cj4gSSd2ZSBtb3Zl
ZCB0aGUgY2hvb3NlbiBub2RlIG92ZXIgdG8gdmV5cm9uLmR0c2kgYW5kIGFwcGxpZWQgdGhlIHJl
c3VsdAo+IGZvciA1LjEKPgoKUGVyZmVjdCB0aGFua3MsIEkgd2FzIHVuc3VyZSBhYm91dCB0aGUg
bm9uLWNocm9tZWJvb2tzIGRldmljZXMuCgoKPiBUaGFua3MKPiBIZWlrbwo+Cj4KPgo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtcm9ja2No
aXAgbWFpbGluZyBsaXN0Cj4gTGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
