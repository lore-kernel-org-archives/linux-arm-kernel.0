Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C26C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:06:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40582087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tO4W9LuG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ee4GxWg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40582087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1GYJsLuHTJ675Xh6pprY1HOA6DwaxQTLfc99q4xSbrY=; b=tO4W9LuGxBxO5E
	Om6o8skEpgLdWHM8Gd0UJc3VSHfou5O7fniXrzKg/zevafDlyE62GfMQQ7eCKoFMAVrJODoXFGerF
	WJ/nLjQetSFKfH/kaS5+am3HpUq/B5cm72QLwzL6hojXmB5JqK2LlBw/OUAJQcaRpBUGAujEqtP2C
	oJcyeeA+aHw6oYA1Twoou1meEs2b0YfJIBHn8bQyVjl7WivA9mQGpivbB/yyqMiRbxLAKw/7wsDGV
	uzvZoUncqEcAfwyEkvclDPr56eGXLQSCyCf8SP8o0Cz2PBfZdrfTFXntdQaiMNJSfc8foxuQB46nl
	+Qolzc3O5IhLucQMsBlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqetF-0002Uc-84; Mon, 04 Feb 2019 14:06:25 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqetB-0002UC-2X; Mon, 04 Feb 2019 14:06:23 +0000
Received: by mail-ot1-x342.google.com with SMTP id w25so13033930otm.13;
 Mon, 04 Feb 2019 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7eXCvavNyr+z3sjClqPoC4UBbPrNuSYAmlMVe12+VB4=;
 b=ee4GxWg4L5EPkH0KYc9kX0nyL4DP5Kfh9VaCAv1FXE9r/2uhkuQ/f6eWBltVS292xF
 Gm2JRPMeoJBc+m/3KnSyt2iiDv3xJLsB83CjlfMY0PyOT0UmEePAAOznpepe+acyaOdH
 o9Zj6JB/z+DDlYLyEPDV5Yc6bNB5J491VqRGV5Syo5sKmH7wSR69Xc6Ue2e0S0DvE/cm
 IEJcg7MwVBrQp0vj8NIMOiqyo4qU5pGH/0KQeI2nOjW+kJ82dBBLUNTgRC+20UQj/SSz
 pkezVG8svowQjNCvlKvrNyS0iMAPUQ9gEmaVzDyYE0XrDfL5GIPdjGNlq9iucChx67pC
 aI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7eXCvavNyr+z3sjClqPoC4UBbPrNuSYAmlMVe12+VB4=;
 b=FLLrtSUeOOzwKOYS2q5jBoEBQD59l/SenPaAVjb2s1YDWshwfAhUFHmebkK6OQ7mcA
 1rFvbCrri3V3LtlnLD4xBt4dudmrF2D8siMJLFF9TnvUlTf4zL8CFZHYZqDAsxVdx0/A
 LIx3vslcYHCvvSR1Bz4BDAJCgVmK9401s7/q+BpA6TlShacKjIlzJCeZ/8A9BgTL32Du
 sqn8oIYpko8K5qpF9sRM2qWIzxWNb4VlgB5UYJuGKjFvttaNy+bFhLpicGS8ZF4Nzmi9
 0z7Upv+0FyfwCmCEtPyhMvwG1CyRX7wW13T26ZN1IF2sMoyx03UzPaRX+uuR2pWq8H1v
 U5qw==
X-Gm-Message-State: AJcUukctNlluFfL+dpzxqd1Ce15SrluC1IEr+SsZJvbwLX3TfBuPAMaw
 ZUkWZtV2kWvGc01EKFPWcAE+g42S7FUIvHlfZMw=
X-Google-Smtp-Source: ALg8bN6rL4OEDCcKYe1Fl5HNC77pvrZI+DPTzmrj7W4yLvb6zIHLyjRo+VfIT5I5qy6mVKSaAiPEje1rC10vWL57mqY=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr20264855oib.41.1549289179849; 
 Mon, 04 Feb 2019 06:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com>
 <20190129102521.4141-3-linux.amoon@gmail.com>
In-Reply-To: <20190129102521.4141-3-linux.amoon@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 15:06:09 +0100
Message-ID: <CAFBinCDRTeO9FWoJ-=BUc8uizN5_mhJE9EBYv0X6pse7Rxsxew@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy
 regulator power failed warning
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_060621_135110_9D478B8D 
X-CRM114-Status: GOOD (  10.65  )
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
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Override the dr_mode from "host" to "otg" for USB_HOST controller (usb0)
> changes help usb_phy0->usb0 initialization of OTG bus port.
>
> Changes fix the below warning.
>
> [    1.183681] dwc2 c9000000.usb: c9000000.usb supply vusb_d not found, using dummy regulator
> [    1.190627] dwc2 c9000000.usb: Linked as a consumer to regulator.0
> [    1.196696] dwc2 c9000000.usb: c9000000.usb supply vusb_a not found, using dummy regulator
> [    1.206094] phy phy-c0000000.phy.0: USB ID detect failed!
> [    1.210243] phy phy-c0000000.phy.0: phy poweron failed --> -22
I wonder if the warning below are a side-effect of "phy poweron failed"...

> [    1.216072] WARNING: CPU: 0 PID: 78 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> [    1.225147] Modules linked in:
> [    1.228169] CPU: 0 PID: 78 Comm: kworker/0:1 Not tainted 5.0.0-rc4-xc2ml #1
> [    1.235066] Hardware name: Hardkernel ODROID-C2 (DT)
> [    1.239987] Workqueue: events deferred_probe_work_func
> [    1.245072] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.249816] pc : _regulator_put.part.11+0xf0/0xf8
> [    1.254473] lr : regulator_put+0x34/0x48
> [    1.258353] sp : ffff0000117b3b00
> [    1.261630] x29: ffff0000117b3b00 x28: 0000000000000000
> [    1.266891] x27: ffff80007ec1a7b8 x26: ffff000010eec280
> [    1.272153] x25: 0000000000000000 x24: 0000000000000009
> [    1.277414] x23: ffff0000117b3bc8 x22: ffff80007ecd3c00
> [    1.282675] x21: ffff0000111ad6c8 x20: ffff80007ecd3e00
> [    1.287936] x19: ffff80007ecd3e00 x18: 0000000000000124
> [    1.293198] x17: 0000000000000000 x16: 0000000000000000
> [    1.298459] x15: 0000000000000400 x14: 0000000000000400
> [    1.303720] x13: ff00000000000000 x12: ffffffffffffffff
> [    1.308981] x11: 0000000000000038 x10: 0000000000000040
> [    1.314243] x9 : ffff0000111c58b0 x8 : ffff0000111c58a8
> [    1.319504] x7 : ffff80006b055200 x6 : ffff80007edd2880
> [    1.324765] x5 : ffff80007f400248 x4 : ffff80007fb92b00
> [    1.330026] x3 : ffff0000112c9d58 x2 : ffff80007edd2880
> [    1.335288] x1 : 0000000000000000 x0 : 0000000000000001
> [    1.340549] Call trace:
> [    1.342966]  _regulator_put.part.11+0xf0/0xf8
> [    1.347278]  regulator_put+0x34/0x48
> [    1.350814]  regulator_bulk_free+0x30/0x50
> [    1.354868]  devm_regulator_bulk_release+0x18/0x20
> [    1.359612]  release_nodes+0x1b0/0x220
> [    1.363320]  devres_release_all+0x34/0x50
> [    1.367288]  really_probe+0xec/0x290
> [    1.370824]  driver_probe_device+0x54/0xe8
> [    1.374878]  __device_attach_driver+0xb8/0xe8
> [    1.379190]  bus_for_each_drv+0x78/0xc8
> [    1.382985]  __device_attach+0xd4/0x130
> [    1.386780]  device_initial_probe+0x10/0x18
> [    1.390920]  bus_probe_device+0x90/0x98
> [    1.394715]  deferred_probe_work_func+0x6c/0xa0
> [    1.399203]  process_one_work+0x1e0/0x318
> [    1.403168]  worker_thread+0x228/0x428
> [    1.406877]  kthread+0x124/0x128
> [    1.410070]  ret_from_fork+0x10/0x18
> [    1.413603] ---[ end trace 498aca4cb07e5377 ]---
phy_power_on fails above with -EINVAL and then something else breaks
(it seems like you're hitting the WARN_ON in drivers/regulator/core.c
below the comment which states: "Docs say you must disable before
calling regulator_put()")
so this looks like a bug in either the dwc2 driver or the PHY
framework. can you please report that to the dwc2 and PHY maintainers
so it can be fixed independently?


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
