Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0FFC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7221919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bjZMhcfy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpMQNGLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE7221919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ifz2mZNLmr3ZvfqPm1IopZgUKd/wWRx+Kpj5fLGmmTw=; b=bjZMhcfyIgcTL3
	ECPw7mESuVgB9uYO19tW4OfrjNhg4FM8Tb3Dm2D6ah6AklWJvHAhmNeKR1lPigrajU1b4zTcUqapa
	0eWmzgPuaafyKkBtET2KZjjMLrCLFwDat5Ti0nisMlROHm7FgxAz5umCdYuJVbY1TYKMtOMRmMHAX
	Opgzj6dlSjuX/NYDo9qCvYDvYHC5Ccz7+CpFZXCew4FTcR9R646+4hi2NBfZbin7Yxu9Mj83iO331
	r0ZRPzvleBkQXkKGjDKjzQt8GFSPji+zSedbOFJZZYOo3QbHGtHM4kWb9CEhd9MXocY5oHuv2bG7q
	AK6ser5NDKW/FMpGFsfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3hi-0005RX-Rb; Fri, 08 Feb 2019 10:48:18 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3hf-0005R9-4A
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:48:16 +0000
Received: by mail-ot1-x343.google.com with SMTP id z19so1063730otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iY6KzQSYHZWi3Pt1FKE8lswXW+SOWJSUioS2HOwtGUA=;
 b=hpMQNGLuzk9zP7GYa6ufmem+OEYxA4yMFYGCyS2JYzmiIfYIceOxL3Q6JFEfeIgMOC
 w07Ikx/vSKJtleH43uun82IsK7OOW7AA2BA35QTR/hiZUe/8QIztadkSJOB/+cKhvVQP
 HD0korSXQBxkSKqGTW8u3474LxB6VZSs2RzFJJcisACbbniaaOOoRXQ8Kk13m8arxVdH
 t5dLWPMLatU5GcPRSezk0eNjqwRt+KlxZG6OBhULK80mjZiXqxfzORFcnkYTb55OenE3
 X2YoErUUv3+9wncUkN2P1AxImjBGPLRprm9Ro8gbqqLQFBX72N3SWuKsXxlGORj7R7S3
 /7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iY6KzQSYHZWi3Pt1FKE8lswXW+SOWJSUioS2HOwtGUA=;
 b=gbx7PWaX+gZMB521qt9PgQgGDKep8FTYFDq6mFUQfcbYVHNGDy1MUFZqrT0GpfOU6K
 O2mqYi34q3tCpQAmZGZYgKHB8vohtvLDT3Uqic5YNCAQ+GTOf6S1eAWNpY7OZhE8NuJR
 BAXq7AItKEbcFL6lAGNI+kjouF2VRoy5l4iToHKxeogppCGuXtyy23ytaZbXIdwn7fvK
 xoG3mU2BeN4i5uG186OKnW0kgBcQhQ/OJCqZ13RiQe4fXaA3V0TCroqyw2KOm2Ic8DVf
 AH5he21cg3EauLTCg+dop4qR0+1JEWbuJpgFJCgSAfovYALXXn8TMmvIr2Dbd8625+GG
 Qm6w==
X-Gm-Message-State: AHQUAuYPhqUPJJerUWgDqWCk3GgDc7EKp6ifq8rnXV+65BbYAq757FPQ
 E8Y4Z+IBELNCKEF/vFNzKSHNfcUAtv+oiRjloQg=
X-Google-Smtp-Source: AHgI3Ia+ApEbUANw2UqtmUV+LEzxEA5G1qzeArYmdagjQWOdd1FT+kMYKbzJefSQdOvGTtMLOfFCULEVrOwSi8Ii9cM=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr13141895otp.225.1549622894081; 
 Fri, 08 Feb 2019 02:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20190205081825.rcoi2wx2bvxsyfjz@pengutronix.de>
 <20190208093306.14316-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190208093306.14316-1-u.kleine-koenig@pengutronix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Feb 2019 08:48:02 -0200
Message-ID: <CAOMZO5AODGe0MXme5+xN6y4cr6NqmM4Gz6=euZN=V7rL1At21g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: Add devicetree for Eckelmann CI4x10
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_024815_195245_9E49DF24 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
Cc: Gavin Schenk <g.schenk@eckelmann.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVXdlLAoKT24gRnJpLCBGZWIgOCwgMjAxOSBhdCA3OjMzIEFNIFV3ZSBLbGVpbmUtS8O2bmln
Cjx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgoKPiArICAgICAgIHJlZ191
c2JfaDFfdmJ1czogcmVndWxhdG9yLXVzYi1oMS12YnVzIHsKPiArICAgICAgICAgICAgICAgcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArICAgICAgICAgICAgICAgcGluY3RybC0wID0gPCZw
aW5jdHJsX3JlZ191c2JfaDFfdmJ1cz47Cj4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
cmVndWxhdG9yLWZpeGVkIjsKPiArICAgICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAidXNi
X2gxX3ZidXMiOwo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1
MDAwMDAwPjsKPiArICAgICAgICAgICAgICAgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8NTAw
MDAwMD47Cj4gKyAgICAgICAgICAgICAgIGdwaW8gPSA8JmdwaW8zIDMxIDA+OwoKUGxlYXNlIHVz
ZSBHUElPX0FDVElWRV9ISUdIIGxhYmVsIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkuCgo+ICsgICAg
ICAgICAgICAgICBlbmFibGUtYWN0aXZlLWhpZ2g7Cj4gKyAgICAgICB9Owo+ICsKPiArICAgICAg
IHNpb3ggewo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImVja2VsbWFubixzaW94LWdw
aW8iOwo+ICsgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ICsgICAg
ICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc2lveD47Cj4gKyAgICAgICAgICAgICAg
IGRpbi1ncGlvcyA9IDwmZ3BpbzYgMTEgMD47Cj4gKyAgICAgICAgICAgICAgIGRvdXQtZ3Bpb3Mg
PSA8JmdwaW82IDggMD47Cj4gKyAgICAgICAgICAgICAgIGRjbGstZ3Bpb3MgPSA8JmdwaW82IDkg
MD47Cj4gKyAgICAgICAgICAgICAgIGRsZC1ncGlvcyA9IDwmZ3BpbzYgMTAgMD47CgpTYW1lIGhl
cmUuCgo+ICsgICAgICAgcGluY3RybF91c2JoMTogdXNiaDFncnAgewo+ICsgICAgICAgICAgICAg
ICBmc2wscGlucyA9IDwKPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZRRExfUEFEX0VJTV9E
MzBfX1VTQl9IMV9PQyAgICAgICAgICAgMHg4MDAwMDAwMAoKTm8gMHg4MDAwMDAwMCBwbGVhc2Uu
IFVzZSB0aGUgcmVhbCBJT01VWCBzZXR0aW5nIGhlcmUgc28gdGhhdCB3ZSBkb24ndApyZWx5IG9u
IHRoZSBib290bG9hZGVyLgoKPiArJnBjaWUgewo+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsKPiArICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llPjsKPiArICAgICAg
IHJlc2V0LWdwaW8gPSA8JmdwaW8xIDIwIEdQSU9fQUNUSVZFX0hJR0g+OwoKSSBndWVzcyB5b3Ug
bWVhbnQgR1BJT19BQ1RJVkVfTE9XIGhlcmUgaW5zdGVhZD8KClRoZSByZXNldC1ncGlvIHBvbGFy
aXR5IGlzIGlnbm9yZWQgYnkgdGhlIGlteDYgUENJIGRyaXZlciBhbmQgYXNzdW1lZAp0byBiZSBh
Y3RpdmUgbG93IHVubGVzcyB0aGUgInJlc2V0LWdwaW8tYWN0aXZlLWhpZ2giIGlzIHByZXNlbnQu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
