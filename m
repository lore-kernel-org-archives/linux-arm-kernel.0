Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B30C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B6C20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j9osQiMw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ylk+KSgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B6C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fw9ha3Zfe5rvfN7SMN26kZKNiirKjfe5mb/uKJPyLZs=; b=j9osQiMwoLLJ/M
	zh4VM0IU/846p1Wmdpa4CZVgf+FL7g/7NMeJx1Fj1BzIofc9fV/UqN3PSAVi9YmyfLIDMtV/XopIS
	/kfCExwuBE3A7FQG/+2qX0dVQF9pVuM+rIVCyWJg5HzP/vxjhur4+/lmkSJZ0lkM8iHqS7QzD+6SF
	a9ZdcshK5HnhZcPHRCM22ikL/LdOUPd2XQ1bOI7VZDnFoXi0cL3Gfk8tawhi9s/GNhHRkYRnR8YST
	IjC7rJkzyw1mwuRknkpdrabQ+5glVyLRSkzQOwSSAP8CPiamDBRXl8l5LIAo96UD1Q8c/6qmgkQcf
	VJF8IJMLWZ1kmIsQAhNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5YJ-00059G-Br; Fri, 08 Feb 2019 12:46:43 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5YG-00058u-35
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:46:41 +0000
Received: by mail-ot1-x341.google.com with SMTP id s5so5567249oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oacHkyZc6vgry81ANwoeRHGP9onV0XPaiJsq8X42m0Y=;
 b=Ylk+KSgpWUJV4Sx7KwKWC/N1SV23sMnxSLJfj87lGJkusrKjTL5kr9T0tBWszq8qSE
 cKStBIFiPW2V5OpUnxk92uEj5hCmaOY6me52rbbcFcZhud4t3Fg/qYqObRvFyFVezqwr
 1oe5B0ivAxEPRbP0Xr2IQrQ1uoBg8NnSoQH0W86jcHlHfpPWdu7G2QAK9ZVgXaMlRTZO
 J9gnKD0XA1PJueFdzsuz5aFWp3fJgtYSYTcUnoLR96fgZgCfdRtPv79HRy53eA3R5vOn
 +me+q9ttp4rdt05lGFEpFJXdbWcF23qPMbzC9r3UU/AlsEIjlgr+pvWa/cbAd/STQaHB
 pXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oacHkyZc6vgry81ANwoeRHGP9onV0XPaiJsq8X42m0Y=;
 b=o6V4veePL1OpnnCumOGUqFKE+XFCFjOESk+xTS7sPQXPXD6VmvW10OQKQYmBnrs7sM
 +0ItrX0r/UJ17TcTXy5HJJBjAvEVzKOSnLU0xzrOGoZ0qRDoqnG/swssu2BqRnYNV1M4
 6t5ifgP7VyYQkto81xaPe9Hhm8K1tKVOkJBVv167s+ryTlKQn0iHR7sVDQciCo8R7m6z
 fgPlQxeeAeedT0BPQEPZ12OLb7v6030H5bH0a42OMU4U7ae5owcJ3yIP0DcKJp0jsoMl
 k4JzB7BDwBQ+iXdzAgzEQnQT2OjN4QlZfqYYEeWW9KG2topvYfvS6JslSGVxYBXfjWCE
 l3Iw==
X-Gm-Message-State: AHQUAuaT7BAtIx/Ojvk3W96h5NXerLOYsVyHm1o4/vmoSixu5LK5iaVj
 TbUKIS2pwUGt0JyhZhiZwMvmNYlqQCloWXXNiPLKQQ==
X-Google-Smtp-Source: AHgI3Ia0RexaYBngZUDdyze/3SoScszyVi8pGd+DHoKd1jJ4G0BWeHyKNjYY+FDqxTUsOP8ToOcaZ9NMLeGvL6sEi+4=
X-Received: by 2002:a05:6830:10c1:: with SMTP id
 z1mr6036003oto.252.1549629999170; 
 Fri, 08 Feb 2019 04:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-7-brgl@bgdev.pl>
 <3e80e485-10f0-1bf6-72eb-69d69a571cb6@ti.com>
In-Reply-To: <3e80e485-10f0-1bf6-72eb-69d69a571cb6@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 8 Feb 2019 13:46:28 +0100
Message-ID: <CAMpxmJUutUx5z0rdCziLbseZ6hmceJ0FZazJ0mYMu3pwAKuxRw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] ARM: davinci: da830: switch to using the
 clocksource driver
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_044640_130147_E176EF48 
X-CRM114-Status: GOOD (  11.12  )
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

cHQuLCA4IGx1dCAyMDE5IG8gMTM6MjMgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBp
c2HFgihhKToKPgo+IE9uIDA0LzAyLzE5IDEwOjQ3IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+ID4gLS8qCj4gPiAtICogVDBfQk9UOiBUaW1lciAwLCBib3R0b20gICAgICAgICAgIDog
VXNlZCBmb3IgY2xvY2tfZXZlbnQgJiBjbG9ja3NvdXJjZQo+ID4gLSAqIFQwX1RPUDogVGltZXIg
MCwgdG9wICAgICAgICAgICAgICAgICAgICAgIDogVXNlZCBieSBEU1AKPiA+IC0gKiBUMV9CT1Qs
IFQxX1RPUDogVGltZXIgMSwgYm90dG9tICYgdG9wOiBVc2VkIGZvciB3YXRjaGRvZyB0aW1lcgo+
Cj4gQXJlbid0IHdlIGNoYW5naW5nIHRoaXMgdXNhZ2UgbW9kZWwgZm9yIERBODMwIG5vdywgbGVh
dmluZyBubyBjbG9jayBmb3IKPiB1c2UgYnkgRFNQPyBJdCBzZWVtcyB0byBtZSB0aGF0IGFmdGVy
IHRoZXNlIHBhdGNoZXMgY2xvY2tldmVudCBpcyBhbHdheXMKPiBUMF9CT1QgYW5kIGNsb2Nrc291
cmNlIGlzIGFsd2F5cyBUMF9UT1AuCj4KPiBUaGFua3MsCj4gU2VraGFyCgpObyBpdCdzIHN0aWxs
IHRoZSBzYW1lLiBJIGFkZGVkIHNvbWUgY29tbWVudHMgdG8gdGhlIGRyaXZlcidzIGhlYWRlciBp
biB2Mi4KCkJhcnQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
