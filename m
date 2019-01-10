Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72805C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:07:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427F0214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ThW3OGEe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeJdjmNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427F0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OdnGizO4u4v43tLR6pAdgEMvM4YgSiotx7VBBA+WvWY=; b=ThW3OGEe2MCFs2
	Afv70yVz70gyoeTsKjWOe+8GeSOabN12WufczW4brIui/IgXJNQfEWnggyBMkWh8RKso76u7KIsx/
	3/sTMCoDE3YKWUGx8Un2U/YDwjwapjT/bhzXQECD7joN6hFHhAD1FFAtOiO/2ZMga8rAyEdt2zQ3n
	TUJfi/cgS69QKeM8Ok7fHq0yosRBGCwNeEhV5SPb+fo+zAlUzSvix3tXfFAozZPYsaS/c8fbfNkhF
	rsWvTukCcBg0tP9WWIqk4+cZO2U9BTauzCap2j7Uc+THZafHJSiCZDcljn6N79alyolnw4W8Yjyrv
	JDk8RrL5oIXQaWTSZr1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWIm-0003TH-7L; Thu, 10 Jan 2019 09:07:00 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWId-0003L8-0w; Thu, 10 Jan 2019 09:06:54 +0000
Received: by mail-qk1-x743.google.com with SMTP id g125so6171308qke.4;
 Thu, 10 Jan 2019 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jfs+rzTidtMyumH+OS/GBx8nnTMoGUK7aMVU9LHarpA=;
 b=LeJdjmNa6q+yoc0QT3O2fniRN9nWkd/9+xhSmEBOu5Y2ySK8t4iXdOsWNnyohJD2lO
 HqvLsbyiU7RTf5pgjyiJD84xBsJk8p0/t0vCdJtPg5/SfMCeZCjgWHQtX4yWSqSajSZu
 WjPlXYTCwcF41Eync8xqwS1vuCNIKyyjNY4g7cmMM48kRJFT/KnXZh4f4adlvPFjteb7
 6vUy8BLn0fqDqR4pIQ/gHHcmDug6z7rUgynPGnCugrZ6oW/A3uwUnrajt+z/8sT6Lnz2
 0Msswb6wtVG1tN2Znwyv4tNNjxGazcl/u45k12iESJFhRn9cH+yLG0gMNTmv/snXydhE
 x/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jfs+rzTidtMyumH+OS/GBx8nnTMoGUK7aMVU9LHarpA=;
 b=i2DVF+tom7TNt0ZR+49pn9N67TbaYsDr61Gl/ZhykaYANsMNlIhA44n7DrVzewzrXq
 EzlsZfmCNyV6uEK4Rp5GRRK1lnwz97ftrCwL4uwFVcNHHuVy4Xp9AfA67zkfTDcaE7p0
 Mrv5BlshBuAIoMS/kasyDUk0SNcPmLpdJM7LFRRuTP9TZgVwsESXbzwDfq5/NgVEu9Yk
 xSUTzWHb05D9Hjgdb+xjgocKSHROaP4NLMh33mESNt3XoigFvOoM5t9YDdTTeLtD4Vw3
 xvvZBWkAEOf7BUfn+nYzwlOKB6red233IZwqLd9EzIWrKZJ/tljtxIgBYQfmmtOWce6z
 m4zA==
X-Gm-Message-State: AJcUukd+CQuy9Hk3Pb5cjkCoi7cV2URNnHujEvO2m2/fe+oBkbdDFyrS
 zY2cPn2mPdcp7+u9WQBzxYiQ/Wi8SOxIwAxShiM=
X-Google-Smtp-Source: ALg8bN4wPzkGRJo/RPu6BUHRdkfm08vznK2rgdxrrMbEOrPG6TEdVwGUkMs1koW5LyVy/quhuxTBHgrxIpJ7WAqyRJs=
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr8282533qkl.160.1547111209372; 
 Thu, 10 Jan 2019 01:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <20180815095934.11205-5-enric.balletbo@collabora.com>
 <20180815222604.GB8193@rob-hp-laptop>
In-Reply-To: <20180815222604.GB8193@rob-hp-laptop>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 10 Jan 2019 10:06:38 +0100
Message-ID: <CAFqH_538JF7gmpQzgyShw-8nhUEtkVrGQ6vjkdc5neJd8JCAOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new
 rockchip,force-bvalid property.
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_010651_331190_2443D7B4 
X-CRM114-Status: GOOD (  21.68  )
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
 Alexandru Stan <amstan@chromium.org>, Guenter Roeck <groeck@google.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, kieran.bingham@ideasonboard.com,
 Kishon Vijay Abraham I <kishon@ti.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 Benson Leung <bleung@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKTWlzc2F0Z2UgZGUgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4gZGVsIGRp
YSBkai4sIDE2IGTigJlhZy4gMjAxOCBhIGxlcyAwOjI2Ogo+Cj4gT24gV2VkLCBBdWcgMTUsIDIw
MTggYXQgMTE6NTk6MzRBTSArMDIwMCwgRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYSB3cm90ZToKPiA+
IFRoaXMgcHJvcGVydHkgaXMgdXNlZCB3aGVuIHRoZSBvdGctaWQgcGluIGlzIG5vdCBjb25uZWN0
ZWQuIFdoZW4gdGhpcwo+ID4gcHJvcGVydHkgaXMgc2V0IGl0IGZvcmNlcyB0byBzZXQgdGhlIEIt
RGV2aWNlIFNlc3Npb24gVmFsaWQgYml0IHdoZW4gdGhlCj4gPiBwb3J0IHdvcmtzIGFzIGRldmlj
ZSBhbmQgY2xlYXJzIHRoYXQgYml0IHdoZW4gdGhlIHBvcnQgd29ya3MgYXMgaG9zdC4KPiA+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBFbnJpYyBCYWxsZXRibyBpIFNlcnJhIDxlbnJpYy5iYWxsZXRib0Bj
b2xsYWJvcmEuY29tPgo+ID4gLS0tCj4gPgo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9waHktcm9ja2NoaXAtaW5uby11c2IyLnR4dCAgICAgICB8IDUgKysrKysKPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LXJvY2tjaGlwLWlubm8tdXNiMi50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1yb2NrY2hpcC1pbm5vLXVz
YjIudHh0Cj4gPiBpbmRleCAyZDQ4MDhkMzkyMGIuLjU1NzYxZjQ2NmM0MSAxMDA2NDQKPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LXJvY2tjaGlwLWlu
bm8tdXNiMi50eHQKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LXJvY2tjaGlwLWlubm8tdXNiMi50eHQKPiA+IEBAIC00OCw2ICs0OCwxMSBAQCBPcHRp
b25hbCBwcm9wZXJ0aWVzOgo+ID4gICAgICAgICAgICAgICBTZWUgLi9waHktYmluZGluZ3MudHh0
IGZvciBkZXRhaWxzLgo+ID4gICAtIHJvY2tjaGlwLHV0bWktYXZhbGlkIDogYm9vbGVhbiwgdXNl
IHRoZSBhdmFsaWQgcmVnaXN0ZXIgdG8gZ2V0IHZidXMgc3RhdHVzLgo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgT3RoZXJ3aXNlLCB1c2UgdGhlIGJ2YWxpZCByZWdpc3Rlci4KPiA+ICsgLSBy
b2NrY2hpcCxmb3JjZS1idmFsaWQgOiBib29sZWFuLCBzZXQgdGhpcyB0byBmb3JjZSB0aGUgQi1E
ZXZpY2UgU2Vzc2lvbgo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgVmFsaWQgYml0IHdoZW4g
dGhlIHVzYiBwb3J0IGlzIGluIGRldmljZSBtb2RlLiBUaGlzCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBpcyB1c2VkIHdoZW4gdGhlIG90Zy1pZCBwaW4gaXMgbm90IGNvbm5lY3RlZC4KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIE9ubHkgc3VwcG9ydGVkIGluIGNhc2Ugb2YgY29tcGF0
aWJsZSBiZWluZzoKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICogInJvY2tjaGlwLHJrMzM5
OS11c2IycGh5Igo+Cj4gU2hvdWxkbid0IHlvdSBkZXNjcmliZSB0aGUgcHJvcGVydHkgb2YgdGhl
IGgvdyB0aGF0IElEIHBpbiBpcyBub3QKPiBjb25uZWN0ZWQsIHJhdGhlciB0aGFuIHdoYXQgeW91
IGRvIHdpdGggdGhhdCBpbmZvcm1hdGlvbi4KPgoKV2hhdCBhYm91dCAicm9ja2NoaXAsIG90Zy1p
ZC1ub3QtY29ubmVjdGVkIj8KCj4gSXMgdGhlIHBpbiBub3QgY29ubmVjdGVkIGJlY2F1c2UgaXQn
cyBhIGNvbm5lY3RvciB3aXRob3V0IElEIHBpbj8gSWYgc28sCj4gdGhhdCBzaG91bGQgYmUgYSBw
cm9wZXJ0eSBvZiB0aGUgY29ubmVjdG9yIChvciBpbmZlcnJlZCBmcm9tIHRoZQo+IGNvbm5lY3Rv
ciBjb21wYXRpYmxlIHN0cmluZykuCj4KCk5vLCBpdCdzIG5vdCB0aGUgY29ubmVjdG9yLiBpdCBp
cyBub3Qgd2lyZWQgb24gdGhlIHBoeSBhbmQgdGhlIGNhYmxlCmRldGVjdGlvbiBpcyBkb25lIHZp
YSBhbiBleHRjb24uCgpUaGFua3MsCiBFbnJpYwoKPiBSb2IKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtcm9ja2NoaXAgbWFpbGluZyBs
aXN0Cj4gTGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
