Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF53206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fux46iRF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD9aAYc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF53206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9auoHwnfZGjYNWkba04dZP7Y52tqxj5n4gXtO8epEck=; b=fux46iRFAYpZ5+
	4wUPmIk4Dv6RFRMMta6dqy5XL8CLrdJ5Y7JMk2xOTiv1noG9u1zccHgfc+8Nrrufnns1bWgkAAQDE
	UqWaPZ9AqRgX1kq8e+i5b9BCUqGZRvsZnR/owr5q6hfrB3h1TmrMvujvYsLEL7BGjke+pTY8UCf5U
	JtQkwzuR47GYIdoHaOFKIuJ1A3a1FTnpj1PN2H7rJltpQASNVbcNTdcBV+Qxne2vKcJ6WaE2Siztg
	uaASFD7H4AMQNHaz6GDvURk36R4CAVjhSrFuPP5SfRuSElX0DI76LlN8q6W3MsS7poz5cGWL4IZy0
	4b4x0fmfcMKz/LYCF0zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjqaR-00030d-1u; Wed, 16 Jan 2019 19:10:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjqaM-0002zd-Ar; Wed, 16 Jan 2019 19:10:47 +0000
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 82F8920868;
 Wed, 16 Jan 2019 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547665845;
 bh=Ly8oTXf+wW25XTLQh/4VVi0iiDCrw9QU0sqGmXLQHck=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TD9aAYc6ndoChArx2GQZ1BfbOk7c9nRrThJ4AM3D27XL/MQyHI9D/5mOmQqT15ql+
 cIuVG1M9GbsRrrwHssI/bpIVkYnUrdIVN95Z6hdtkcCysl5mD+tqLPSVtLtX0agYfX
 4qdCNlLcHww/8NveIyhmp+9rVeGqyQmSJzcTNYRw=
Received: by mail-qk1-f181.google.com with SMTP id z18so4458658qkj.10;
 Wed, 16 Jan 2019 11:10:45 -0800 (PST)
X-Gm-Message-State: AJcUukdNE5E6Uyb6jGHyXEUdz9I1SZNczRCVKzZ6WD06PK4RG/Qs8bcv
 ih8WJcVIkhZBBrHGNXXRHf5YOLQ4f+9Uy0rAHg==
X-Google-Smtp-Source: ALg8bN4tamKw2hTyuVvxfODr8h3Fkesx6ZuaHOjSxfO2ri6dQ2EN6wh7YDA+jwFGDI4SWaopa4/Plj2nkrHn0C01W30=
X-Received: by 2002:a37:5686:: with SMTP id k128mr7465693qkb.29.1547665844734; 
 Wed, 16 Jan 2019 11:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20190116103632.17754-1-jbrunet@baylibre.com>
In-Reply-To: <20190116103632.17754-1-jbrunet@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 16 Jan 2019 13:10:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJx5_K=HtfE6pjirffFJ8kU8aEq+Etjxip2gFUpFSpCBw@mail.gmail.com>
Message-ID: <CAL_JsqJx5_K=HtfE6pjirffFJ8kU8aEq+Etjxip2gFUpFSpCBw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: reset: meson-axg: fix SPDX license id
To: Jerome Brunet <jbrunet@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_111046_398009_CB39AE3A 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 4:36 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> As reported, the SPDX license id is not placed correctly and the variant
> of the BSD License used should be specified.
>
> Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
>  Sorry for the delay Thomas.
>
>  Regards
>  Jerome
>
>  include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
