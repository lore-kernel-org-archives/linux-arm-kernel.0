Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF362184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b2vWTxU7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ndu29BT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF362184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MqOc1K3ztMFo7/ulph/y5SvZ18ZPjppKcpdfZzumL+4=; b=b2vWTxU708D03J
	tPofXLSzDrH6nvgHBQGUd943X9+PMujZvDiBPhd2BShu7xkGk/Mj0l/MiGwg0007Lz7sjy0WIHDhI
	9cPT07fHj+hPCSHviZI+LU/JzJSioLid87pi8/tICcJcH9ApyOew1VheC0Xu8pS8UTms4wr6ugZxx
	I+feg2hiIc77NZYZvMSBe5j7p/mk7xpsSDprfZKg5Ctxwar3XNeglCBQzpkbIzePQD4ZB9l/suupw
	9pjcLnL0VgvF9syIgrFS7CQTHg05MXQge6t6fkzJpxvOEpGdJhvHFpV4X0WeyeIeAnZjXuGU3ymfc
	CSVesYkVgdNyF7xgDn7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyfUb-0000D4-8v; Tue, 26 Feb 2019 16:22:05 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyfUX-0000Bw-AG
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 16:22:02 +0000
Received: by mail-it1-x144.google.com with SMTP id w18so4667346itj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NKqd0gJ+FjQE644QZeYOhYWnNjhb8KLh1cAPylR2kwQ=;
 b=Ndu29BT6k9PQGhWxmPMQNCVP+xixHK40OdQ/K/6V0FJjVz8dUP9LTbIx7042K3fsja
 SCp5fPWur+gvQnber+IjktUjU+K4SE9+yR8/oUZSyHbS/qHTkVnk57eaUH/p+NkrtFDe
 kgsj4GePNS90fzkV9U6ytKZbzDDLo4yiCqBvWEC636mukyIA/T0s9p9QOYB0PqaLGoBA
 POmXqxrmufNJbWwA40rIPPN5eF0tA3VjPQIzatjTNv5hjPYCcUZgJyzirOw26EQlEO4E
 RHpCT4dOPvXEU6Al2hCnednhfUoKbsSvQFuLY1YS9P8jsR6dOcB0KOww5OBn6J9fjwS3
 AoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NKqd0gJ+FjQE644QZeYOhYWnNjhb8KLh1cAPylR2kwQ=;
 b=hK7lb0CZUX5eMsZc5pA1hpvY034jX5yk9yfEkJq+FHszdPn5SzZPSKebxUdspZQNRo
 LFtZ21xxUyLJC1JyxjYDPOAv/6awErJlMJBnWVvycuShXc+JRXlLw7aXui3dcqOiJ83D
 wU0gmpu14qUPsfZ204rVsLyPzJ/7RwJBtozHgl2oYpp1FvxicJqQDE14FrRdBbpBqluq
 n2HElqgy9b3qLl41wcXDkftDEjDM6+8e2l66SwmhZ8XWx76lMF6eAE9/XJJcDZTK6yUr
 yprIzCFfnAnD20ZytViDj+TZ8kqLWGG/FVty3CfI6QdiFGa9j2U1qj+erWIsaCTkL+mv
 uzGA==
X-Gm-Message-State: AHQUAubgc8xiJ09mIuWRGrJaJqnzJjDNDC+BLpujcl7RXWfKWEUCChzB
 97sCv/Y+NynQthmqw1nmVsO+vmSx1ZUL2a94vgtt4A==
X-Google-Smtp-Source: AHgI3IYn0kUmFJAD5WGV84GxKV2IOkWMSNAfMfEWhXCCWBFMIfTvKwzdFFwOkNF99jXeOgRb5gyf2lj5tO8/02t+rm0=
X-Received: by 2002:a02:568a:: with SMTP id u10mr13543781jad.130.1551198119627; 
 Tue, 26 Feb 2019 08:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <CAKv+Gu9OOzOxx0rTAZqM8r4q_hRmOp3b=KP7fwgNeiu67FCApA@mail.gmail.com>
 <5310b73b-4821-6dff-b9c0-34c59fb7fd72@arm.com>
In-Reply-To: <5310b73b-4821-6dff-b9c0-34c59fb7fd72@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Feb 2019 17:21:48 +0100
Message-ID: <CAKv+Gu_=bQyVZqgUnJm9moCcaCcpDrag6NWGEpaR65=pMiTFJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_082201_359578_1A773149 
X-CRM114-Status: GOOD (  24.35  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 Devicetree List <devicetree@vger.kernel.org>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 25 Feb 2019 at 15:53, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Ard,
>
> On 25/02/2019 12:45, Ard Biesheuvel wrote:
> > On Sun, 24 Feb 2019 at 15:08, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>
> >> For quite some time, I wondered why the PCI mwifiex device built in my
> >> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> >> were working fine, I never really bothered investigating. I finally had a
> >> look, and the result isn't very pretty.
> >>
> >> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> >> such:
> >>
> >> &pci_rootport {
> >>         mvl_wifi: wifi@0,0 {
> >>                 compatible = "pci1b4b,2b42";
> >>                 reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> >>                        0x83010000 0x0 0x00100000 0x0 0x00100000>;
> >>                 interrupt-parent = <&gpio0>;
> >>                 interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> >>                 pinctrl-names = "default";
> >>                 pinctrl-0 = <&wlan_host_wake_l>;
> >>                 wakeup-source;
> >>         };
> >> };
> >>
> >> Note how the interrupt is part of the properties directly attached to the
> >> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> >> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> >> altogether (Yay for the broken design!). This is in total violation of the
> >> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> >> specifiers describe the PCI device interrupts, and must obey the
> >> INT-{A,B,C,D} mapping. Oops!
> >>
> >
> > The mapping of legacy PCIe INTx interrupts onto wired system
> > interrupts is a property of the PCIe host controller, not of a
> > particular PCIe device. So I would argue that the code is broken here
> > as well: it should never attempt to interpret 'interrupt' properties
> > at the PCI device level as having any bearing on how legacy interrupts
> > are routed.
>
> OpenFirmware says that this node contains the interrupt number of the
> device (4.1.1. Open Firmware-defined Properties for Child Nodes). The
> trick is that this property is generated *from* the device, and not set
> in stone.
>
> DT, on the other hand, takes whatever is described there and uses it as
> the gospel to configure the OS, no matter how the PCI device is actually
> configured. If the two don't match (like in this case), things break.
> This is the "DT describes the HW" mantra, for (sometimes) better or
> (more generally) worse.
>
> What the DT code does is to interpret the whole interrupt specifier,
> *including the interrupt-parent*. And that feels wrong. It should always
> be in the context of the host controller. But on the other side, the DT
> code is not in the business of validating the DT either...
>
> It outlines one thing: If you have to interpret per-device PCI
> properties from DT, you're in for serious trouble. I should get some
> better HW.
>

Yeah, it obviously makes no sense at all for the interrupt parent of a
PCI device to deviate from the host bridge's interrupt parent, and
it's quite unfortunate that we can't simply ban it now that the cat is
out of the bag already.

Arguably, the wake up widget is not part of the PCI device, but I have
no opinion as to whether it is better modeling it as a sub device as
you are proposing or as an entirely separate device referenced via a
phandle.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
