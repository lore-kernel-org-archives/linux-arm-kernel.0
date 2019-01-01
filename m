Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:21:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A55221871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 12:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fJPjZrji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A55221871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XOUXu7sRjYn1BeOngiRHeTXvVUuWVfMd4fDTjOhiJk4=; b=fJPjZrjiHFQigo
	ODQWH2BQlaLk0QnVT9kJDKXbcLNc+rQsJPn/UOr3tagACviK34yJ2iazRYf9ZXIdfL5nBX2Ob1+E+
	IjlAFZfwBSb1T3CrPh6NkBYep8ySVjG6ufLEUBkFGNfQ/hvM+VgHO+bvz7rRr4Hm6lTUC0IkcPoxk
	bdfyD7oN63viFLZjKLC30vdwyKQmH81nEYRFWx8VUZqTRHhsCe/Pkw6+zoBd6/bxhClB9u84GurPm
	HyNcd1OuFlAEeCLE0tGHZdR9KLr+FHXs8oM+RMpuDICJ/Vev+CdhFdmfDIIJ4pTjrXlIJIP7MOags
	lUc5IlwbRXM+/EkVXdTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geJ2W-00086F-GU; Tue, 01 Jan 2019 12:20:56 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geJ2T-00085m-3q; Tue, 01 Jan 2019 12:20:55 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1geJ24-0002ZI-9H; Tue, 01 Jan 2019 13:20:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: klaus.goger@theobroma-systems.com
Subject: Re: [PATCH] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Date: Tue, 01 Jan 2019 13:20:26 +0100
Message-ID: <5662913.pS8bTmJHpa@phil>
In-Reply-To: <6B09C29B-CACB-4F71-A812-BE538AE6D996@theobroma-systems.com>
References: <Pragnesh_Patel@mentor.com>
 <20190101080848.5697-1-Pragnesh_Patel@mentor.com>
 <6B09C29B-CACB-4F71-A812-BE538AE6D996@theobroma-systems.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_042053_305531_8EADB4F6 
X-CRM114-Status: GOOD (  18.47  )
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
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 Akash Gajjar <Akash_Gajjar@mentor.com>, linux-kernel@vger.kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rob Herring <robh+dt@kernel.org>, Pragnesh_Patel@mentor.com,
 Oskari Lemmela <oskari@lemmela.net>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Olof Johansson <olof@lixom.net>, linux-rockchip@lists.infradead.org,
 Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Pragnesh, Klaus,

Am Dienstag, 1. Januar 2019, 10:54:55 CET schrieb klaus.goger@theobroma-systems.com:
> > On 01.01.2019, at 09:08, <Pragnesh_Patel@mentor.com> <Pragnesh_Patel@mentor.com> wrote:
> > 
> > From: Akash Gajjar <Akash_Gajjar@mentor.com>
> > 
> > ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> > DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> > POE, WIFI (for Model B only), PCIE M.2 support on board.
> > 
> > This patch enables
> > - HDMI Display
> > - Console
> > - MMC, EMMC
> > - USB 2.0, USB-3.0
> > - Ethernet
> > 
> > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> > Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>

> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index de0c406c20cc..3fab0a3e4eeb 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> > dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
> 
> sort(1) would put it before roc-pc

I'd keep it were it is right now, aka after roc- and before roc960.
Otherwise we would need to resort the whole list to keep it consistent ;-)

And I really want to minimize resorts, so just keep it were it is now
and looks sorted :-D

[...]

> > +	usb2 {
> > +		vcc5v0_host_en: vcc5v0-host-en {
> > +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> 
> Maybe use the GPIO bank macros here?
> 1 = RK_GPIO1, 2 = RK_GPIO2 and so forth.

Actually the other way around please :-)
Aka just use numbers for the gpio bank in new files
and the pin defines RK_PD1 for the pins.

The RK_GPIO1 -> 1, etc... defines don't really bring additional
usefulnes, so I encourage not using them in new boards.


> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
> 
> RK_PA7 for consistency.

yep, here the mapping iomux 4*8 pins <-> gpio controllers (32 pins)
is non intuitive and makes it more difficult, so the defines actually help
in following schematics.


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
