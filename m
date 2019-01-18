Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A657C1B0FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7EB2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmKfjNYc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oNJTYYuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7EB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dKzaZ9wrxTZHVY3jggTM+FcbGYnNXhD1JT9QD5qHyDc=; b=GmKfjNYcjTLW53
	adMIB3hUFeKnFU1Yp0mKYPWYfxM8zgCgvaWLKx5QqzBfl10PU5mDVfjItarJHge6ze7k00pC5E8C1
	7b9ZU7DQd6QjA7XvDq4ABVbWkI6KCblOnzlQTtlERuATYCkS6b4vM8kcANPHIcfKklttz96WMgNGZ
	fr5Xx4d1UknVjiWeL8iKJhzCGeSiNMLZCJ86rkmKwHp3wXipkhbzFdllvr0OVe/I76LhElfW1JICC
	/jvwHE8iqSSNgoZJSyniX6djOV4jDYPZQp0RdNAUQQfZLc6m2NZI4GulSHucmGt929C8uKa3akgNV
	VYHqRRZa9DJSwLRmShJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkcHs-0001c2-86; Fri, 18 Jan 2019 22:06:52 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkcHo-0001bL-Bg; Fri, 18 Jan 2019 22:06:50 +0000
Received: by mail-ot1-x342.google.com with SMTP id t5so10729815otk.1;
 Fri, 18 Jan 2019 14:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LUSvv6gyP/U0jb8swx6kbJOKJ75Cx8i7+Ck6/NBHcX0=;
 b=oNJTYYuO/R2XMxoEYLVk3BuofcbSO2Jal56gIgxesN3nRoMwa8kQQeoALeU/jcioAY
 0BMPTGKc0jxuJfvJiBGXy4FEh6QOa1vNE4KfNVWxsjr/OuF0lw7BOPhf/Tjh1939Hesr
 R7bO1MgW1JlIatvJsLhiYDd0HRb7GXE2SVUDiS+lpkAM/2ZGbLZSVPXQe79lFwJsd43Y
 1gjHPxFRAsvqbYyVis5tnL0yFoQwyl6X5di/X0GfxZXh3YpaNjiMZSiqYiL8M/vpmJYb
 EaPDBANJvfwULOAitQgiNU6/ViUEoOaksobKoQgUi3BbeOchsHJrlDyBA/z0SMchOtIE
 jS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUSvv6gyP/U0jb8swx6kbJOKJ75Cx8i7+Ck6/NBHcX0=;
 b=UNhrJFUyTsfKT6FlvxTTj9XsltbpsbD+6E6YfmV6cZ5x3LiHbhket7G6GaNF+j6P+W
 dhvsyG+2IM/jERxTQnRr8zYQwCTAN6U90R4SSYF4QMN0jsGFcSkgHHXT3ikFpRifGIuE
 JdkPQKSuvTqVP7GwYK0q9NSzTgiL7T2ROmsLu61+Lldk0YxV2be/a9rMZr82xfkEnPKt
 0H5UlPMwJubrn/fJ/D5S4HaX9kBMbsnCG1KBwjbJJ94ZUS7u55/+8JegSXweo3ExoaQe
 8LdE+m/LhAGACS/2nA9PrGBCIeh3lzCZui6UgfuWUkJs+NT6/5oBxr1TKmMVFiOarThc
 p33A==
X-Gm-Message-State: AJcUukeLf31MSen6OhE/AGq8Uuf/c/Bbv6M+sD0WElGyB+xURLnvTeiq
 2qlETA7sy/nIHwJfPaqxunuRAnfHwRXoT1HywDbfaMks
X-Google-Smtp-Source: ALg8bN7xKjfGKRIT4sZ8SnCLXx+7BK9Umi6LGxI5bTxrXMe+VPJ0gK6OA0ZF+r82cglIYKY8bNcJWselXYRCDrFlTFw=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr12918180otg.308.1547849207355; 
 Fri, 18 Jan 2019 14:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com>
 <20190113181808.5768-2-linux.amoon@gmail.com>
In-Reply-To: <20190113181808.5768-2-linux.amoon@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 18 Jan 2019 23:06:36 +0100
Message-ID: <CAFBinCCNpW=m4P=dqkn4eKeDPJyi_RML07ZhPKQeFH5j7mXkkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: meson8b: odroidc1: Fix usb phy regulator
 power failed warning
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_140648_412189_0AB7A38D 
X-CRM114-Status: GOOD (  18.39  )
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
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Emiliano Ingrassia <ingrassia@epigenesys.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Override the dr_mode from "host" to "peripheral" for dwc2
> usb_phy0->usb0 initialization of OTG Micro-B type.
> Changes fix the below warning for phy poweron failed --> -22
>
> This fix the initialization of c9040000.usb phy.
>
> [    1.639706] phy phy-c1108800.phy.0: USB ID detect failed!
> [    1.643850] phy phy-c1108800.phy.0: phy poweron failed --> -22
> [    1.649706] ------------[ cut here ]------------
> [    1.654273] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
> [    1.663400] Modules linked in:
> [    1.666439] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.20.0-xc1ml #11
> [    1.673192] Hardware name: Amlogic Meson platform
> [    1.677894] Workqueue: events deferred_probe_work_func
> [    1.683027] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
> [    1.690746] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
> [    1.697953] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
> [    1.705418] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
> [    1.713579] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
> [    1.722437] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
> [    1.730859] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
> [    1.739112] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
> [    1.747537] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
> [    1.755350] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
> [    1.763599] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
> [    1.772110] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
> [    1.780359] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
> [    1.788522] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
> [    1.797470] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
> [    1.806585] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
> [    1.814748] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
> [    1.822128] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    1.829331] Exception stack(0xee0ebfb0 to 0xee0ebff8)
> [    1.834369] bfa0:                                     00000000 00000000 00000000 00000000
> [    1.842534] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.850695] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.857311] ---[ end trace e28bbc26874282a4 ]---
> [    1.861984] ------------[ cut here ]------------
> [    1.866524] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
> [    1.875629] Modules linked in:
> [    1.878658] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: GW         4.20.0-xc1ml #11
> [    1.886817] Hardware name: Amlogic Meson platform
> [    1.891513] Workqueue: events deferred_probe_work_func
> [    1.896641] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
> [    1.904366] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
> [    1.911573] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
> [    1.919041] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
> [    1.927203] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
> [    1.936060] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
> [    1.944483] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
> [    1.952734] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
> [    1.961159] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
> [    1.968974] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
> [    1.977224] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
> [    1.985734] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
> [    1.993984] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
> [    2.002147] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
> [    2.011092] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
> [    2.020209] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
> [    2.028371] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
> [    2.035752] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> [    2.042955] Exception stack(0xee0ebfb0 to 0xee0ebff8)
> [    2.047993] bfa0:                                     00000000 00000000 00000000 00000000
> [    2.056158] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.064320] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.070934] ---[ end trace e28bbc26874282a5 ]---
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Rebased on Kevin's amlogic/v5.0/fixes branch
> Note the warning is not getting produced on the latest kernel.
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index a49a8509b288..9d7f725cfe35 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -318,6 +318,7 @@
>
>  &usb0 {
>         status = "okay";
> +       dr_mode = "peripheral";
>  };
with this change I get the following message during boot:
  dwc2 c9040000.usb: Configuration mismatch. dr_mode forced to host

as far as I understand your original problem is the following error
from the USB2 PHY driver:
  phy phy-c1108800.phy.0: USB ID detect failed!
  phy phy-c1108800.phy.0: phy poweron failed --> -22
maybe we should fix that instead?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
