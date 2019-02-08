Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7062177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIISN4qx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3XOjLvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7062177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iMQ0yGyn93oa5i5KkxxzI6qPntfnoPVtDiBrCet3mhs=; b=MIISN4qxIeIuYF
	Gs8/r3G4GAJTNnUh5f2tz7coF6cm8hsPR8OuvNQH4UOTVKG8xm0PGCCvXtBt9kKWo7c+Zctw0Vt9c
	cRxEpRcFCEV14Ol7UiuF8tIDTrDnxme3yesARXJjrjD8WfuG6NTrKt/LHZ4/g89YpWlMW/Vo7TLyQ
	9GpfeNQepk9VnkNc8+sAOKcdhOrZEuyuMu4PFxM0KCPy107wI6BhChzVJH2U7IeKNs3QA76aVWQwP
	S/bXlK5I7I2vKb81I+DLDAjTudWTNy16IR1HzskcJEzIg1OMtArPtSCSQqMh6zrQ30rs6Bd5RdY/I
	j81hDyUr+GBjEKLwwYiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Pr-0007ak-NK; Fri, 08 Feb 2019 12:37:59 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Po-0007aP-1v
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:37:58 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CbeXh083437;
 Fri, 8 Feb 2019 06:37:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549629460;
 bh=J5H1/KGfmAvzG6oKJoJn4IseVaJm3ElBp7a+t8K9gsE=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=a3XOjLvUjHcNWSxpXvzmhVOupotH+rhFYbK6Z9klTrooPXtgJWDSq7HZZP/tiMp/0
 XhNJ2CW1oFQ1iG6N68wJu3/vCrGZxl/bAgPGfBHfiymQ711npsmLmqT0mV12VEKcSZ
 U364Nh2HSJd0LrMGqbJnLdZyKLHAgTWfnZK97Fwg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CbeKR055428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 06:37:40 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:37:39 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:37:39 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18Cbaf0004092;
 Fri, 8 Feb 2019 06:37:36 -0600
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com>
 <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
Date: Fri, 8 Feb 2019 18:07:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043756_417028_7467589A 
X-CRM114-Status: GOOD (  14.74  )
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
 linux-devicetree <devicetree@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDgvMDIvMTkgNjowNCBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBwdC4sIDgg
bHV0IDIwMTkgbyAxMzowNiBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5hcGlzYcWCKGEp
Ogo+Pgo+PiBPbiAwNC8wMi8xOSAxMDo0NyBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToK
Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRhdmluY2lfdGltZXJfY2ZnIGRhODUwX3RpbWVyX2Nm
ZyA9IHsKPj4+ICsgICAgIC5yZWcgPSB7Cj4+PiArICAgICAgICAgICAgIC5zdGFydCAgICAgICAg
ICA9IERBOFhYX1RJTUVSNjRQMF9CQVNFLAo+Pj4gKyAgICAgICAgICAgICAuZW5kICAgICAgICAg
ICAgPSBEQThYWF9USU1FUjY0UDBfQkFTRSArIFNaXzRLLAo+Pgo+PiBTWl80SyAtIDEKPj4KPj4g
VGhpcyBzaG91bGQgaGF2ZSBwcmV2ZW50ZWQgd2F0Y2hkb2cgdGltZXIgZnJvbSBnZXR0aW5nIHJl
Z2lzdGVyZWQuCj4+Cj4+IFRoYW5rcywKPj4gU2VraGFyCj4gCj4gTXkgY2xvY2tzb3VyY2UgZHJp
dmVyIGRvZXNuJ3QgY2FsbCByZXF1ZXN0X3JlZ2lvbigpIHNvIGEgc3Vic2VxdWVudAo+IGRldm1f
aW9yZW1hcF9yZXNvdXJjZSgpIGluIHRoZSB3YXRjaGRvZyBkcml2ZXIgd291bGQgc3RpbGwgc3Vj
Y2VlZC4gSQo+IG5vdyBmaXhlZCBib3RoIHRoZSBtaXNzaW5nIGNhbGwgYW5kIHRoZSB2YWx1ZSBo
ZXJlLgoKQWgsIGdvdCBpdC4gUGVyaGFwcyBhIGNhbGwgdG8gcmVxdWVzdF9yZWdpb24oKSBzaG91
bGQgYmUgYWRkZWQgdG8gY2F0Y2gKaXNzdWVzPwoKVGhhbmtzLApTZWtoYXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
