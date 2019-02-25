Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:46:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB90E213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DlXGi2Kn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez+MQFHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB90E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iaNNr9FWo56VI92W1s+KsU6URnPXlnVSgOSPz98LrdU=; b=DlXGi2KnMthsXN
	O5JmNMHpjXaU+P46e0IkUZylwUicvmmYBQiDL44EgU0ccXeXs4vl18QGFEiM+ull1dWeNvsfJzySh
	zwgYoEjBNBwNrlx/bZYmZVv0k6IdNf8ChTzbYoCQtt/XnqUebisrvIrN3VMXedhDaa4adGAUDZjJU
	ONK6x4BzLjRt01AZFfFSemwfZ2bAuJ87XKl8CfoaKkcBR1MEYsNX2ce0fVv5Kvc27JjO8BvWLd/6j
	15qwf+raPpeqK9bXVIc4MG7WwiOzrkHW/LTGpF4DGhUdVMmEj9IDv7vnaivwFQL0izc5kk3E1xvq4
	XMNjwyoklKf5F9zKv4kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyFdq-0006An-Sz; Mon, 25 Feb 2019 12:45:54 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyFdm-0005oi-54
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 12:45:52 +0000
Received: by mail-it1-x144.google.com with SMTP id z131so12516257itf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4KXQ9HO//j0UqoHOiUcn4d+1Ubg3RJ4gXZuCK74ZFi0=;
 b=ez+MQFHHdYLTFUFrLTc5VI4BsgQC/CMQ+tIUisrIup3Uz1r2u4pq/t6FiyqlUsCmI7
 VO+PAC+vUZoSOgD6lnwn1glp25OBgcBkAOhLh1UtEhQcEjDi8uwdsLU96b+ds50qLsNU
 qa3iJrvu/lYcZI9aDVoJ9fjWCFPSnXGyhE/+aBCzbg37UFi+aN0ztTcWVV8aE05VbXTC
 Gi3ZspMaGd7cZxOF7LNloSlkI3wpk1rSkMm2zc+aV+z7vepSjJm2mMVsOEVJwT7UPPtR
 WRVd3fbMnjILfZoEHJDI2Y0Kj/D+vGKDGaaW2c2T/xOl9/Am8td5ikYEHYmmscXdsveR
 vwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4KXQ9HO//j0UqoHOiUcn4d+1Ubg3RJ4gXZuCK74ZFi0=;
 b=iQH+9Uez1IPGZK7bVfW+lmEceGSo2mquvLWbi0yRElDuEvgpAjfMdelx7BF848J4vu
 uA1935O1oJ3a7alyi2JF2X2AZZWjkSE8RwStIH4Ozml44cFRFGXykXyX2cVrEl/GWOKF
 nMl5sKC0tnJqruU0Vuz3cnaEDPgz5T3xu3oMG/5cA3/NhyPrZ+H+YWAFZbjws2mj46HK
 n9SmWVM3U1NOpt2S/Z0jWPc7ehC+wRPfPjZKU8RlyB4PkB6GCGy9rLi/pIS4qxs+wH3A
 s8/+mRaDLduqJJkZjIEHT0ua1jsco+/l9uPp/1LRm/vbaDJcmw4DmUaIOTiGFJFkQIgp
 XIng==
X-Gm-Message-State: AHQUAuaIzikW0iNMLetokIdQtRwzFgcrCQM4p0tG586mTZx0c4b484dw
 roWY6ic6smiWkk5gKnoWX2ex9hMVBuXjVRwGSnjRQw==
X-Google-Smtp-Source: AHgI3IYQ730YhGSZ7pIqyrTvnx4t566FdShll61m+zSktM4mDid7OWIt1bh4kHxKJTj+eu94nYnwtgpT2yTsyNwJRqQ=
X-Received: by 2002:a02:3342:: with SMTP id k2mr8974724jak.62.1551098747400;
 Mon, 25 Feb 2019 04:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20190224140426.3267-1-marc.zyngier@arm.com>
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 25 Feb 2019 13:45:35 +0100
Message-ID: <CAKv+Gu9OOzOxx0rTAZqM8r4q_hRmOp3b=KP7fwgNeiu67FCApA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_044550_347320_D9A7F272 
X-CRM114-Status: GOOD (  24.29  )
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

On Sun, 24 Feb 2019 at 15:08, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> For quite some time, I wondered why the PCI mwifiex device built in my
> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> were working fine, I never really bothered investigating. I finally had a
> look, and the result isn't very pretty.
>
> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> such:
>
> &pci_rootport {
>         mvl_wifi: wifi@0,0 {
>                 compatible = "pci1b4b,2b42";
>                 reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>                        0x83010000 0x0 0x00100000 0x0 0x00100000>;
>                 interrupt-parent = <&gpio0>;
>                 interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&wlan_host_wake_l>;
>                 wakeup-source;
>         };
> };
>
> Note how the interrupt is part of the properties directly attached to the
> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> altogether (Yay for the broken design!). This is in total violation of the
> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> specifiers describe the PCI device interrupts, and must obey the
> INT-{A,B,C,D} mapping. Oops!
>

The mapping of legacy PCIe INTx interrupts onto wired system
interrupts is a property of the PCIe host controller, not of a
particular PCIe device. So I would argue that the code is broken here
as well: it should never attempt to interpret 'interrupt' properties
at the PCI device level as having any bearing on how legacy interrupts
are routed.

> The net effect of the above is that Linux tries to do something vaguely
> sensible, and uses the same interrupt for both the wake-up widget and the
> PCI device. This doesn't work for two reasons: (1) the wake-up widget grabs
> the interrupt in exclusive mode, and (2) the PCI interrupt is still routed
> to the RC, leading to a screaming interrupt. This simply cannot work.
>
> To sort out this mess, we need to lift the confusion between the two
> interrupts. This is done by extending the DT binding to allow the wake-up
> interrupt to be described in a 'wake-up' subnode, sidestepping the issue
> completely. On my Chromebook, it now looks like this:
>
> &pci_rootport {
>         mvl_wifi: wifi@0,0 {
>                 compatible = "pci1b4b,2b42";
>                 reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>                        0x83010000 0x0 0x00100000 0x0 0x00100000>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&wlan_host_wake_l>;
>                 wake-up {
>                         interrupt-parent = <&gpio0>;
>                         interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>                         wakeup-source;
>                 };
>         };
> };
>
> The driver is then updated to look for this subnode first, and fallback to
> the original, broken behaviour (spitting out a warning in the offending
> configuration).
>
> For good measure, there are two additional patches:
>
> - The wake-up interrupt requesting is horribly racy, and could lead to
>   unpredictable behaviours. Let's fix that properly.
>
> - A final patch implementing the above transformation for the whole
>   RK3399-based Chromebook range, which all use the same broken
>   configuration.
>
> With all that, I finally have PCI legacy interrupts working with the mwifiex
> driver on my Chromebook.
>
> [1] http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>
> Marc Zyngier (4):
>   dt-bindings/marvell-8xxx: Allow wake-up interrupt to be placed in a
>     separate node
>   mwifiex: Fetch wake-up interrupt from 'wake-up' subnode when it exists
>   mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN rather than disabling
>     it too late
>   arm64: dts: rockchip: gru: Move wifi wake-up interrupt into its own
>     subnode
>
>  .../bindings/net/wireless/marvell-8xxx.txt    | 23 ++++++++++++++++++-
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  8 ++++---
>  drivers/net/wireless/marvell/mwifiex/main.c   | 13 +++++++++--
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
