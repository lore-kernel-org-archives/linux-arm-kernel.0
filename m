Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A20F218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pq7kX/0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20F218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ceqSzhSs2KE4Zn3KqMtcsgZ3LTQs8z3cgbF45QRnkqA=; b=Pq7kX/0LEw0mQf
	lVxqlGLPiHlsbXcnXS8vF9S/tjVsESIgV9ZoJAfIVr2Muog9MRwtg1TBHV8XhitwQ8qf+wWgLpKfJ
	VoFh2l2XOJiuRAe+3tDu632cBvbOCpu6pgvyl+/yT93P+Gck5aIxFg8a1g1ZSmlD1Fn+H9SuwKYyA
	EPquTnhzQgFzRzud/NMKN79opcO6EvlqdIdrlBX8TA3xWZN9DILti5IgHyHYJFht2QMJX+wiymENu
	uacpCpDXPq4r0ndmvY4IsEG/Kt4FxEtl73k6Qt4Tgi2PIBTWM2Z32iDel7buSt8TVAaM3jh/G9niw
	QjU7qCcIUhKzilPetesA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkfU-00030W-54; Thu, 07 Feb 2019 14:28:44 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkfF-0002qW-2S
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:28:41 +0000
Received: by mail-ed1-f68.google.com with SMTP id d12so33936edy.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 06:28:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w9xKQ32ph7UtzCcF4cmYK0+JplXRCzoSm/i8W1X1Cq4=;
 b=qNgPsQ2Z72eNq2x22TmI80KnTkTLUc36vHy5k0qm1ehXIoOMGdGKIA9nP+j9gerfgX
 hH+cQZPUJ4xB7Bhlc20NtVmKVK7eHYv0xfshFaGCFjO/SFOmw5zoLXQllVwdZusp0fnu
 /Q/tcfrlbIDGLelXwvP5dvrt4Zvl5ReOZwCVTVkbNt2hl3NvXlq7NRGbiVqAVIma82Co
 +O96vA8YS6VWOz1kheIOJhh6/ATcwU24oyeX2ljTRU3J9kwcJWUk6T7VQc14jaM+oPaI
 MeMnANqS9sH+wO7b1ghTCO1n6QqJU1+pLTMpGje6GaOGM7n6a204QqLw17S2349jd2HL
 LQaw==
X-Gm-Message-State: AHQUAuZYyGpAmmOcvsmsj2IPmV2iV7FFktOKCj36dJfRGtHnWlhO666r
 /yl3aFgUSTREaR5UyOnmsIGU8H9qyJs=
X-Google-Smtp-Source: AHgI3Iarx3ac6sYxsjLiQNKWidOW29K058EdUzJD6YwgAjsXoqeucPzGmeqoR7L6/ZXutOCoQyehhg==
X-Received: by 2002:a50:ad97:: with SMTP id a23mr12276251edd.128.1549549706314; 
 Thu, 07 Feb 2019 06:28:26 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id l25sm1259502edr.45.2019.02.07.06.28.25
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 06:28:25 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id g67so57552wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 06:28:25 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr7967974wmc.116.1549549705221; 
 Thu, 07 Feb 2019 06:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org> <20190207110247.GE20638@dell>
In-Reply-To: <20190207110247.GE20638@dell>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 7 Feb 2019 22:28:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
Message-ID: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
To: Lee Jones <lee.jones@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_062829_629317_9A6F6AA7 
X-CRM114-Status: GOOD (  17.25  )
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
 devicetree <devicetree@vger.kernel.org>,
 Quentin Schulz <quentin.schulz@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBGZWIgNywgMjAxOSBhdCA3OjAyIFBNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCAwNyBGZWIgMjAxOSwgQ2hlbi1ZdSBUc2FpIHdyb3Rl
Ogo+Cj4gPiBGcm9tOiBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAYm9vdGxpbi5jb20+
Cj4gPgo+ID4gVGhlIEFYUDgxMyBoYXMgYSBWQlVTIHBvd2VyIGlucHV0LiBOb3cgdGhhdCB0aGUg
YXhwMjB4X3VzYl9wb3dlciBkcml2ZXIKPiA+IHN1cHBvcnRzIHRoaXMgdmFyaWFudCwgd2UgY2Fu
IGFkZCBhbiBtZmQgY2VsbCBmb3IgaXQgdG8gdXNlIGl0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6
IFF1ZW50aW4gU2NodWx6IDxxdWVudGluLnNjaHVsekBib290bGluLmNvbT4KPiA+IFt3ZW5zQGNz
aWUub3JnOiBhZGQgY29tbWl0IG1lc3NhZ2VdCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuLVl1IFRz
YWkgPHdlbnNAY3NpZS5vcmc+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL21mZC9heHAyMHguYyB8IDEx
ICsrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXhwMjB4LmMgYi9kcml2ZXJzL21mZC9heHAyMHgu
Ywo+ID4gaW5kZXggM2M5N2YyYzBmZGZlLi4xN2IxMTU4NDU5OTMgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL21mZC9heHAyMHguYwo+ID4gKysrIGIvZHJpdmVycy9tZmQvYXhwMjB4LmMKPiA+IEBA
IC0xOTgsNiArMTk4LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgYXhwMjJ4X3Vz
Yl9wb3dlcl9zdXBwbHlfcmVzb3VyY2VzW10gPSB7Cj4gPiAgICAgICBERUZJTkVfUkVTX0lSUV9O
QU1FRChBWFAyMlhfSVJRX1ZCVVNfUkVNT1ZBTCwgIlZCVVNfUkVNT1ZBTCIpLAo+ID4gIH07Cj4g
Pgo+ID4gKy8qIEFYUDgwMyBhbmQgQVhQODEzL0FYUDgxOCBzaGFyZSB0aGUgc2FtZSBpbnRlcnJ1
cHRzICovCj4gPiArc3RhdGljIHN0cnVjdCByZXNvdXJjZSBheHA4MDNfdXNiX3Bvd2VyX3N1cHBs
eV9yZXNvdXJjZXNbXSA9IHsKPiA+ICsgICAgIERFRklORV9SRVNfSVJRX05BTUVEKEFYUDgwM19J
UlFfVkJVU19QTFVHSU4sICJWQlVTX1BMVUdJTiIpLAo+ID4gKyAgICAgREVGSU5FX1JFU19JUlFf
TkFNRUQoQVhQODAzX0lSUV9WQlVTX1JFTU9WQUwsICJWQlVTX1JFTU9WQUwiKSwKPgo+IE5pdDog
V2h5IDIgc3BhY2VzIGhlcmU/ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKMiBzcGFj
ZXM/IEknbSBvbmx5IHNlZWluZyBvbmUuCgo+IFdpdGggdGhhdCBmaXhlZCwgeW91IGNhbiBhZGQg
bXk6Cj4KPiBGb3IgbXkgb3duIHJlZmVyZW5jZToKPiAgIEFja2VkLWZvci1NRkQtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4KPiAtLQo+IExlZSBKb25lcyBb5p2O55C85pav
XQo+IExpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZAo+IExpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+IEZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
