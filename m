Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A290C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:57:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6437120838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cUhDoFdn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LulrTZFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6437120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cf5Z7T/5gya4U5ENAeNjIfZtutDcpF6xFXuoHFW5e4E=; b=cUhDoFdnuXNB36
	zpGO848xt1T9MclXKF59V0eAF3066vVrF/iyW2JxxA1ZI6rm0osjrW4rmbysGAm2NQcZgRW23/5Sq
	23BDCOot6DoHB4Hf23oCfYuh10wt3Jt5EkV0UdvU7GFPpO2jelH5lk27kEb0ZfvJ3DCRKpI+rRmIY
	2bt9nQ8EB7Nu11und+30Q7AKIEo3PoKjoVW50x9qLpKzP2dOCnkmcR8w+a/j2H04kM/H4BuRharBh
	4ZkVel7vMjhhqW0ZxI6iBQ904gr+tXU6yL566kgLfSEmnQ7d5lBFrWgrGoo1QZvxQYKcVVMHLW5Mb
	4E59aQx7buKFl6RGhMsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwyK-00087M-49; Thu, 06 Dec 2018 16:57:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwyF-00086L-0C
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:57:54 +0000
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1AC621479
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544115460;
 bh=rfBdWn/p/zHVMIdFmrdRmXGAjmzlIUKvAj6+q6ohAPk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LulrTZFPkG2EZdNZxG6GTbc5T0KmNmqokWu3stkBcXFdm39ZIYKlTPx7fm4Kha0UN
 VKZXNUeu+CSh80uKYnCnEEd/dXN94fseBGH5OsXPxIB8jNdNUvUiq07q7wRfPR5xYO
 Ox+6v/HjAu8vKALPINxzdGZ2SuTXj+NGofn8ZIOI=
Received: by mail-qk1-f173.google.com with SMTP id a132so737278qkg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:57:39 -0800 (PST)
X-Gm-Message-State: AA+aEWZkSTH5Z0bClvh93CD5aqlagxf+byKAx6bmI7IcGBdSO3leF5Nb
 EjdbLx/AqWRnQLn8Oy7QZY0PdKvS+JX73waAwA==
X-Google-Smtp-Source: AFSGD/U4QUg7ZlOfsQQ9KG7a4OST6rF/SNomfJAUTpUAt6DEP5o5PjNOhqrRfCPae40iN94fH50hISc+BI0UJU1DF9E=
X-Received: by 2002:a37:b646:: with SMTP id g67mr27014845qkf.326.1544115459023; 
 Thu, 06 Dec 2018 08:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
 <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
 <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
 <20181206140531.GX8952@piout.net>
 <CACRpkdbzyZD23JapAxEKc24jSwmZws5LqWS8O2Y4-VA3smgYyQ@mail.gmail.com>
In-Reply-To: <CACRpkdbzyZD23JapAxEKc24jSwmZws5LqWS8O2Y4-VA3smgYyQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 10:57:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7Rnb5Tt5ZAm9TDqgcenkkMEzM6STfwKXMDMKkkxqQvg@mail.gmail.com>
Message-ID: <CAL_JsqL7Rnb5Tt5ZAm9TDqgcenkkMEzM6STfwKXMDMKkkxqQvg@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_085751_079187_DF4D353A 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCA4OjMwIEFNIExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDM6MDUgUE0g
QWxleGFuZHJlIEJlbGxvbmkKPiA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+IHdyb3Rl
Ogo+ID4gT24gMDYvMTIvMjAxOCAwNzo1ODoyNC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiA+
ID4gT24gVGh1LCBEZWMgNiwgMjAxOCBhdCA3OjM5IEFNIFV3ZSBLbGVpbmUtS8O2bmlnCj4gPiA+
IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4g
SGVsbG8sCj4gPiA+ID4KPiA+ID4gPiBPbiBXZWQsIERlYyAwNSwgMjAxOCBhdCAwOTowMTo1OUFN
IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiA+ID4gPiA+IGkuTVgyMyBpcyBhIFNpZ21hdGVs
IGNoaXAgU1RNUD8/Cj4gPiA+ID4KPiA+ID4gPiBJIHRoaW5rIHRoZSBGcmVlc2NhbGUgaS5NWDIz
IGRpZG4ndCBleGlzdCBhdCBTaWdtYXRlbCBiYWNrIHRoZW4uIEFGQUlLCj4gPiA+ID4gdGhpcyBp
cyBhIG5ldyBkZXNpZ24gdXNpbmcgSVAgZnJvbSBTaWdtYXRlbCBhZnRlciB0aGUgYXF1aXNpdGlv
bi4KPiA+ID4KPiA+ID4gSXQgaXMgbm90LiBJIHdhcyBpbiB0aGUgaS5NWCBncm91cCB3aGljaCBT
aWdtYXRlbCB3YXMgbWVyZ2VkIGludG8gYXQKPiA+ID4gdGhlIHRpbWUuIFB1cmVseSBtYXJrZXRp
bmcgcmVicmFuZGluZy4KPiA+ID4KPiA+Cj4gPiBXb3VsZG4ndCBpdCBiZSBlYXNpZXIgdG8gbmFt
ZSB0aGUgZGlyZWN0b3J5IHRvIHRoZSBjb3JyZXNwb25kaW5nIG1hY2gtKgo+ID4gZW50cnk/Cj4g
Pgo+ID4gU28sIGlteDIzIGFuZCBpbXgyOCB3b3VsZCBnbyB0byBteHMvLCBvdGhlciBpbXggaW4g
aW14Ly4gQW5kIHRoaXMgYWxzbwo+ID4gc29sdmVzIHRoZSBNYXJ2ZWxsIG1lc3Mgd2l0aCB0aGUg
U3luYXB0aWNzIFNvY3MgZ29pbmcgaW4gYmVybGluLyBhbmQgdGhlCj4gPiBvdGhlciBvbmVzIGlu
IG12ZWJ1Ly4KPgo+IEkgbGlrZSB0aGlzIGlkZWEuCgpGaW5lIGJ5IG1lIHRob3VnaCBJIHRoaW5r
IG1hcnZlbGwgZ2V0cyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gdGhhdC4KSSdsbCB0cnkgYSBwYXNz
IGF0IHRoYXQgYXQgbGVhc3QgZm9yIHRoZSBjYXNlcyB3aXRoIGEgbWl4dHVyZSBvZgpmYW1pbGll
cy4KCj4gV2UgZGlzY3Vzc2VkIG1lcmdpbmcgYWxsIEFSTSByZWZlcmVuY2UgZGVzaWduIG1hY2gt
KiB0byBvbmUgZGlyCj4gaWYgSSBqdXN0IG5hbWUgdGhhdCBtYWNoLWFybSB0aGVuIHdlIGdldCBh
IGNvbnZlcmdlbmNlIHRvIHRoZQo+IHZlbmRvciBuYW1lIGluIHNvbWUgb3JnYW5pYyB3YXkuCgpU
QkMsIHlvdSB3YW50IC4uLi9ib290L2R0cy9hcm0vKiBmb3IgYWxsIHRoZSBBUk0sIEx0ZCBib2Fy
ZHM/IEp1c3QKbWFraW5nIHN1cmUgYXMgeW91IHdlcmUgYXJndWluZyBhZ2FpbnN0IHZlbmRvciBu
YW1lcy4gOikKClJvYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
