Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE04C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:28:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D6720882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sAnBXUA2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVNfEsNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D6720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5hO8il27OqNBPnXtY4TUPgT6J9pB3XeWc3qNazMQ3C0=; b=sAnBXUA2XyGr0M
	71xggpgPLIMN/jedz+0Z2Oa2D/4duEst15SHZrzWKIQfKF/3h7VXoPr1wvAIlqYPU8QbnOxRni0Za
	fhgPmuJ76KDt7jc4dRBV/8TnxgEhas8jEWLBW63wAi14zPHYF2J+1SoUaSWHo657NaZ0vsuJzTWLg
	po7m2/u24zx6p4E9m+BC4NCK8PIIkz/C3ZdASCys/VNYeVvwS7nounKNo8m7d9HSE3EFtRQ/Ln/4I
	yyDe+Wp0drvd0dVDKesEgKpgVpKwbCao/OfEFrawDTecBm59dYEuVJi1djORTOTBxzXzyG5XrSGyb
	igwYeHcNpnfjI+r2hL3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVAYg-0006qZ-1P; Fri, 07 Dec 2018 07:28:22 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVAYc-0006pp-BH
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 07:28:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id u3so2829381wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 23:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=srjPKbSPKggzrsNGf9ISRFoRZ63KrUzTnpJqPuUhlKU=;
 b=GVNfEsNMI0Q2Erb9Vbq9CVc3UkJyg3mKunhaxSonrrjFqk76xUxQCuxGow/ONdBdn/
 ASCmAhCf5mZJyG6XWFR0WUdM+fB7a3oDnN5BaDi7sEeUdyPiggT7a/JclicWVZunvXYK
 zTEDIHKd1o9p+G/isyjGEvjero0VNiQDkH2fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=srjPKbSPKggzrsNGf9ISRFoRZ63KrUzTnpJqPuUhlKU=;
 b=ePHMqRQf8y3MeGsdIT/BJFh9hhajQvvYfTQQVH8hyO+F6CMPhxO7p3SknMkAbIpdl4
 +1gnXqhpztuW73NXKHwDuPxINLkuV/9c6ZjMpyTC3F70mZmWwtplKfwXCIAcn6MUEsgH
 P8AQ9zrSfHahdEj/miNAYPWmEKnVzk5Q2FslK9ZJQEGd19vlQ1jgTbqYDO4RIkI2Noev
 wkDcjO1vzfw4eG8eJ45c0TCBoKrriL8+vy2jCY0icWrg5xTQKcTURrkBMmHJg+/SI5bD
 /87P80V1OPcqZ1901THuQoRwSTnfJBBEi+kl3vTgZ5KawCbqtLyNdQbx3ThmkzeT+aaK
 qIfg==
X-Gm-Message-State: AA+aEWbAOb4UFwN/hIdS5wdmdsqy8oT5r5CbX7Fxv8brFoR9YAmV5xms
 0s0yHLLNHz8oX3gHvHHdNe5Q0A==
X-Google-Smtp-Source: AFSGD/Vpp+3ayca6Et7r/FU71XkZexIumBc0GYA2adaeDSlFQaf4ChXH0NXIXXp/dGfPejFTKmkhPQ==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr853777wre.13.1544167686296;
 Thu, 06 Dec 2018 23:28:06 -0800 (PST)
Received: from dell ([2.31.167.218])
 by smtp.gmail.com with ESMTPSA id e19sm5545816wrc.25.2018.12.06.23.28.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 23:28:05 -0800 (PST)
Date: Fri, 7 Dec 2018 07:28:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
Message-ID: <20181207072803.GG26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
 <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205180042.fr5npvtwuvt2c6q3@earth.universe>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_232818_388541_79ED4181 
X-CRM114-Status: GOOD (  23.16  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, oskari@lemmela.net,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAwNSBEZWMgMjAxOCwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6Cgo+IEhpLAo+IAo+
IE9uIEZyaSwgTm92IDMwLCAyMDE4IGF0IDA0OjMxOjI4UE0gKzA4MDAsIENoZW4tWXUgVHNhaSB3
cm90ZToKPiA+IE9uIFdlZCwgTm92IDIxLCAyMDE4IGF0IDE6NTIgQU0gT3NrYXJpIExlbW1lbGEg
PG9za2FyaUBsZW1tZWxhLm5ldD4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEFYUDgxMyBBQyBwb3dlciBz
dXBwbHkgc3VwcG9ydCB3aXRoIGlucHV0IGN1cnJlbnQgYW5kCj4gPiA+IHZvbHRhZ2UgbGltaXRp
bmcgc3VwcG9ydC4KPiA+ID4KPiA+ID4gQVhQODAzIEFDIGFuZCBiYXR0ZXJ5IHBvd2VyIHN1cHBs
eSBzdXBwb3J0Lgo+ID4gPgo+ID4gPiBDaGFuZ2VzIGluIHY2Ogo+ID4gPiAqIENvbGxlY3RlZCB0
YWdzCj4gPiA+ICogUmViYXNlIHRvIG1hc3Rlcgo+ID4gPiAqIERyb3BwZWQgQVhQODAzIGNvbXBh
dGlibGUgcGF0Y2hlcwo+ID4gPgo+ID4gPiBDaGFuZ2VzIGluIHY1Ogo+ID4gPiAqIFJldHVybiBj
b3JyZWN0IGlucHV0IGN1cnJlbnQgbGltaXQgZm9yIHZhbHVlcyAweDYgYW5kIDB4Nwo+ID4gPiAq
IEFkZCBzcGVjaWZpYyBjb21wYXRpYmxlcyBmb3IgQVhQODAzCj4gPiA+ICogQ2hhbmdlIGNvbW1p
dCBtZXNzYWdlcwo+ID4gPiAqIEFkZCBWYXNpbHkgS2hvcnV6aGljayBQaW5lYm9vayBEVFMgcGF0
Y2gKPiA+ID4KPiA+ID4gQ2hhbmdlcyBpbiB2NDoKPiA+ID4gKiBDaGFuZ2Ugb3JkZXIgb2YgYXhw
MjB4LWdwaW8gaW4gYXhwMjB4LmMKPiA+ID4gKiBGaXggaW5kZW50YXRpb24gYW5kIHNwYWNlcyB0
byB0YWJzIGluIGF4cDIweC5jCj4gPiA+Cj4gPiA+IENoYW5nZXMgaW4gdjM6Cj4gPiA+ICogUmVv
cmRlciBhY19wb3dlcl9zdXBwbHkgRFQgbm9kZQo+ID4gPiAqIFJlbmFtZSBheHAyMHhfYWNfcG93
ZXJfc2V0X3Byb3BlcnR5IGZ1bmN0aW9uCj4gPiA+ICogU3BsaXQgbWZkIGNvbW1pdAo+ID4gPgo+
ID4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gPiAqIFJldXNlIGF4cDgxMyBjb21wYXRpYmxlcyBmb3Ig
YXhwODAzCj4gPiA+ICogUmVmYWN0b3IgYXhwMjB4X2FjX3Bvd2VyLmMKPiA+ID4KPiA+ID4KPiA+
ID4gT3NrYXJpIExlbW1lbGEgKDcpOgo+ID4gPiAgIGR0LWJpbmRpbmdzOiBwb3dlcjogc3VwcGx5
OiBheHAyMHg6IGFkZCBBWFA4MTMgQUMgcG93ZXIgRFQgYmluZGluZwo+ID4gPiAgIEFSTTogZHRz
OiBheHA4MXg6IGFkZCBBQyBwb3dlciBzdXBwbHkgc3Vibm9kZQo+ID4gPiAgIGFybTY0OiBkdHM6
IGFsbHdpbm5lcjogYXhwODAzOiBhZGQgQUMgYW5kIGJhdHRlcnkgcG93ZXIgc3VwcGxpZXMKPiA+
ID4gICBhcm02NDogZHRzOiBhbGx3aW5uZXI6IGE2NDogc29waW5lLWJhc2Vib2FyZDogZW5hYmxl
IHBvd2VyIHN1cHBsaWVzCj4gPiA+ICAgcG93ZXI6IHN1cHBseTogYWRkIEFDIHBvd2VyIHN1cHBs
eSBkcml2ZXIgZm9yIEFYUDgxMwo+ID4gPiAgIG1mZDogYXhwMjB4OiBBZGQgQUMgcG93ZXIgc3Vw
cGx5IGNlbGwgZm9yIEFYUDgxMwo+ID4gPiAgIG1mZDogYXhwMjB4OiBBZGQgc3VwcG9ydGVkIGNl
bGxzIGZvciBBWFA4MDMKPiA+ID4KPiA+ID4gVmFzaWx5IEtob3J1emhpY2sgKDEpOgo+ID4gPiAg
IGFybTY0OiBkdHM6IGFsbHdpbm5lcjogYTY0OiBwaW5lYm9vazogZW5hYmxlIHBvd2VyIHN1cHBs
aWVzCj4gPiAKPiA+IFNpbmNlIHRoaXMgc2VyaWVzIGhhcyBiZWVuIGZ1bGx5IHJldmlld2VkLCBh
bmQgdGhlIGRldmljZXMgaXQKPiA+IGFkZHMvZW5hYmxlcyBhcmVuJ3QgY3JpdGljYWwsIGkuZS4g
d29uJ3QgY2F1c2UgdGhlIHN5c3RlbSB0byBmYWlsCj4gPiBpZiB0aGUgZHJpdmVycyBhcmUgbWlz
c2luZywgSSd2ZSBtZXJnZWQgdGhlIGR0cyBwYXRjaGVzIGZvciA0LjIxLgo+ID4gCj4gPiBIb3Bl
ZnVsbHkgU2ViYXN0aWFuIGFuZCBMZWUgd2lsbCBnZXQgYXJvdW5kIHRvIG1lcmdpbmcgdGhlIGRy
aXZlcgo+ID4gcGF0Y2hlcy4KPiAKPiBJIHF1ZXVlZCB0aGUgcG93ZXItc3VwcGx5IGRyaXZlciBj
aGFuZ2VzIGFuZCBwcmVwYXJlZCBhIHNpZ25lZAo+IGltbXV0YWJsZSB0YWcgZm9yIExlZToKPiAK
PiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDY1MTAyMjM4MmM3ZjhkYTQ2Y2I0
ODcyYTU0NWVlMWRhNmQwOTdkMmE6Cj4gCj4gICBMaW51eCA0LjIwLXJjMSAoMjAxOC0xMS0wNCAx
NTozNzo1MiAtMDgwMCkKPiAKPiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoKPiAKPiAgIHNzaDovL2dpdEBnaXRvbGl0ZS5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9zcmUvbGludXgtcG93ZXItc3VwcGx5LmdpdCB0YWdzL3BzeS1tZmQtYXhwODEzLWlt
bXV0YWJsZS1mb3ItdjQuMjEtc2lnbmVkCj4gCj4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIDc2OTNiNTY0M2ZkMmQ2ODJkZTkwNzMzYjY3ZmM4MDMyYjk2NDY5MTE6Cj4gCj4gICBwb3dl
cjogc3VwcGx5OiBhZGQgQUMgcG93ZXIgc3VwcGx5IGRyaXZlciBmb3IgQVhQODEzICgyMDE4LTEy
LTA1IDE4OjQ5OjMyICswMTAwKQo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBJbW11dGFibGUgYnJhbmNoIGJldHdl
ZW4gbWZkIGFuZCBwb3dlci1zdXBwbHkgZm9yIGRyaXZlcgo+IGNoYW5nZXMgcmVsYXRlZCB0byBh
eHA4MTMuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIFJlaWNoZWwgPHNlYmFzdGlhbi5y
ZWljaGVsQGNvbGxhYm9yYS5jb20+Cj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IE9za2FyaSBMZW1tZWxhICgyKToK
PiAgICAgICBkdC1iaW5kaW5nczogcG93ZXI6IHN1cHBseTogYXhwMjB4OiBhZGQgQVhQODEzIEFD
IHBvd2VyIERUIGJpbmRpbmcKPiAgICAgICBwb3dlcjogc3VwcGx5OiBhZGQgQUMgcG93ZXIgc3Vw
cGx5IGRyaXZlciBmb3IgQVhQODEzCj4gCj4gIC4uLi9iaW5kaW5ncy9wb3dlci9zdXBwbHkvYXhw
MjB4X2FjX3Bvd2VyLnR4dCAgICAgIHwgIDMgKwo+ICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9heHAy
MHhfYWNfcG93ZXIuYyAgICAgICAgICAgICB8IDk0ICsrKysrKysrKysrKysrKysrKysrKysKPiAg
aW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQoKV2hhdCBwYXRjaGVzIGFyZSBs
ZWZ0IG5vdz8gIEp1c3QgNyBhbmQgOD8KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJv
IFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9n
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
