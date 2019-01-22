Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC31FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78F1218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qZOV9q5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78F1218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q+1YLr1k5Ly7eU3j1ZOd0iIiHW1e6kCqWHlNgtShHvU=; b=qZOV9q5MYoHuka
	e7VlxGe8M0sj9NW5MaxEJCQ4SBnvaUYAYA0WpD0spz/qk0WtfuykP9TvGhMEkq2twU+3nmTIhKsXF
	BsDBIFFPi2vbF4dZUBf8+g1i1HJvEmNke3wHiJh74+mDtOWwqexkMk6MzCL+GastXrBfl8atsCAPj
	rjVBE+E6RX4x2/FJwlSitoI2K0S/OMj0/Pkv/mYjULxltvxDPMCN7Dw/cK0pKOLQJXjJeKsUbfdBf
	RFHNThXFVPstTW4pd29YvjyTVOXrCIsFGE9bfoJUe+iSopOBWwXHSXeZcnKKv0obuVbI0p4V49Iy6
	Ts7PGO3dh8hXT8fbqMOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsW2-0001bN-MS; Tue, 22 Jan 2019 09:38:42 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsVi-0001JL-3J; Tue, 22 Jan 2019 09:38:23 +0000
X-UUID: 9f7f1a0ac4b048928e001846670ac6e5-20190122
X-UUID: 9f7f1a0ac4b048928e001846670ac6e5-20190122
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1709628259; Tue, 22 Jan 2019 01:37:59 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 01:37:57 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 17:37:56 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 17:37:54 +0800
Message-ID: <1548149874.27796.3.camel@mszsdaap41>
Subject: Re: [PATCH V2] pwm: Add MediaTek MT8183 display PWM driver support
From: Jitao Shi <jitao.shi@mediatek.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Tue, 22 Jan 2019 17:37:54 +0800
In-Reply-To: <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
References: <20190122090243.27304-1-jitao.shi@mediatek.com>
 <20190122091603.ic46eyf47lu5f6pi@pengutronix.de>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_013822_139388_A2308168 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, stonea168@163.com,
 dri-devel@lists.freedesktop.org, Ajay
 Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>,
 cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Thierry Reding <treding@nvidia.com>, Sean
 Paul <seanpaul@chromium.org>, linux-pwm@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 yingjoe.chen@mediatek.com, Matthias
 Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org, Rahul
 Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, Andy Yan <andy.yan@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMDE5LTAxLTIyIGF0IDEwOjE2ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToKPiBPbiBUdWUsIEphbiAyMiwgMjAxOSBhdCAwNTowMjo0M1BNICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gPiBVc2UgdGhlIG10a19wd21fZGF0YSBzdHJ1Y3Rpb24gdG8gZGVmaW5lIGRpZmZl
cmVudCByZWdpc3RlcnMKPiA+IGFuZCBhZGQgTVQ4MTgzIHNwZWNpZmljIHJlZ2lzdGVyIG9wZXJh
dGlvbnMsIHN1Y2ggYXMgTVQ4MTgzCj4gPiBkb2Vzbid0IGhhdmUgY29tbWl0IHJlZ2lzdGVyLCBu
ZWVkcyB0byBkaXNhYmxlIGRvdWJsZSBidWZmZXIKPiA+IGJlZm9yZSB3cml0aW5nIHJlZ2lzdGVy
LCBhbmQgbmVlZHMgdG8gc2VsZWN0IGNvbW1pdCBtb2RlCj4gPiBhbmQgdXNlIFBXTV9QRVJJT0Qv
UFdNX0hJR0hfV0lEVEguCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8u
c2hpQG1lZGlhdGVrLmNvbT4KPiAKPiBUaGVyZSBpcyBubyBkaWZmZXJlbmNlIGNvbXBhcmVkIHRv
IChpbXBsaWNpdCkgdjEgc2VudCBhIGZldyBtaW51dGVzCj4gZWFybGllciwgcmlnaHQ/IFRoZXJl
IHdhcyBhbm90aGVyIHBhdGNoIHNlbnQgd2l0aCB0aGUgc2FtZSBTdWJqZWN0IGxhc3QKPiB3ZWVr
LCBzbyBJIGFzc3VtZSB0aGUgbWFpbCBmcm9tIHRvZGF5IHdpdGhvdXQgInYyIiBpbiB0aGUgU3Vi
amVjdCB3YXMgYQo+IG1pc3Rha2U/Cj4gCj4gPiAtLS0KPiBBZGRpbmcgYSBwYXJhZ3JhcGggYmVs
b3cgdGhlIHRyaXBwbGUgZGFzaCB0aGF0IHBvaW50cyBvdXQgd2hhdCB3YXMKPiBjaGFuZ2VkIGNv
bXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzdWJtaXNzaW9uIGlzIGEgZ29vZCBpZGVhIHRvIGhlbHAK
PiByZXZpZXdlcnMgdG8gbW9yZSBlYXNpbHkgc2VlIHdoYXQgd2FzIGNoYW5nZWQuIEkgZ3Vlc3Mg
eW91IG9ubHkgYWRhcHRlZAo+IHRoZSBjb21taXQgbG9nIGFzIGEgcmVhY3Rpb24gdG8gTWF0dGhp
YXMgQnVyZ2dlcidzIHJldmlldz8KPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKClllcywgSSBt
aXNzIHRoZSAiVjIiIGFuZCBmaW5lIHR1bmUgdGhlIGNvbW1pdCBtZXNzYWdlLgoKQmVzdCBSZWdh
cmRzCkppdGFvCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
