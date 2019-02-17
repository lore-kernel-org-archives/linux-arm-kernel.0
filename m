Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:06:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163AC2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIo07lZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163AC2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OoCQK+zoyTYlD2FeIdk2mKWKK+vIXl9aeeGZkOtBdXQ=; b=LIo07lZs5pq5Ac
	v+ZMQPCqxKgrh5jMo1jT2HWUfBU9czpcBFB+uqi4p7EQ4WFWbbAsW3mYzer40cW7YJ+9En391gxyP
	nlZLjH0CgacTVoIGeQWSUY8TIQ2ndEtafkWyR17O8gDwRgnLXqADGjA15C5Lfq29/WH7td810yyyd
	1IB80Vd5Qzf3Dv4IhdQU57HI+BSH9FN6mzqrHwpSEKOr/nRrx7xtq/VhH734symdQru5EhT6drasy
	VkTS88rdHooSBFYxPkHDvCcGCnebtfwGYjoNbbGOs2MRj7JgP8cfZkFq732Xz1Pd9XF1THV0Km7pD
	oir5djSucFZbJowPU7mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvTdS-0001fc-0D; Sun, 17 Feb 2019 21:06:02 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvTdN-0001eT-F6; Sun, 17 Feb 2019 21:05:59 +0000
Received: from oxbaltgw66.schlund.de ([172.19.246.153]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M9ntb-1h0iQP35L3-005m5g; Sun, 17 Feb 2019 22:05:52 +0100
Date: Sun, 17 Feb 2019 22:05:52 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
Message-ID: <2003821439.343814.1550437552156@email.ionos.de>
In-Reply-To: <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
Subject: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:jhe5vUzY2cgfLvaXPUON3/zy1V6KxT+yo8kA6zq8nj7j5klshUZ
 db0c/LoC9orgukkWfP/EoNUV+T+KlILRJ5BlQ75XlHS2EYYn/hw5dRME/vRbD1n3X6l1WH+
 p8ks/NHHEDsAewLrGov3pUiuzuATZPta7JQrcl6BgQ0LLU5lvfnDd0Op1+rOwazGolTq8Nh
 FGURFdb142ghCCTNWZdBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3CLTUbKsbo=:aCFs6bqxApPgGZFmLd8QnA
 FMc65juNhTmv1BMztdxNVzMqVBd/7Jam0jcZvlNoe39UyzrFzAKU7IoBfgH97t3bxhclkl0i/
 u45U+6ZTrqiuFj9S21NHITfW1VfcCL3QDQyFwBZyFXPaZOo1ALXzz5RNSi/vXeUHvbue+JNtO
 TBfNXaEw99WSfAYxKjgAQgexnQxM8iHD5lA76xHL66sJT/h1PdCvBAKeSESb2knyw+2Sf86cZ
 +WkeRCM8jtdvBWprXqSoJYb+JtO3MZQQXHZf2J1d5qtQLMHJcxez+LveZ0s5fLI5e+N95nIul
 VAJYlBtRTLtpq8ADX0g6ZWO0OSYFQc8Q1XDx2+zhZ/Ai1MDgkxTZWS83DyV04h4elpEU8x3Ys
 DK55nljpRCZ+dzOuBM9lpGULDZxrGeHTR7hnTO22rxLeTA9sMxDZGJF0esEX8ro4CfrDPOHOf
 R539fGoQglEzchxrCaAgmARD8Jn/ymDj3DaJ/9EW0A9+V/YqagwlK+INFFNNR3/L7ts2CFHSA
 5ZqgTFbZj8mSAR/KKCw7D6FkklG3LL6fTlWimT+nmBS3D5Jt1mSemqZzHIEJrVnscq2MXhop6
 n1as9ZvloKeN91ouPT/RjVhnrQXVmR3EwSpCM2hELPWt2rltPnJkebNofSwb53jW/SgFCvYHl
 L59kDVbcODGb3RW1H+REB9hJucBPGb3X6VKsgfkDLx226MKNMF8Qg24sqNAEiYyLvUaU+sZQI
 BNbzhVbpg1ttz8RXGjkQpHyddJ9Y9UI2LAhB9nHgSQoeKaQEbqrAFkBO4Hs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_130557_808698_35B84468 
X-CRM114-Status: GOOD (  29.53  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
> 
> 
> This patch is to add Bluetooth to the ASUS Tinker Board (S) device
> tree.
> 
> This patch is more contraversal - so probably view it as a request for
> comments.
> 
> The reason behind this, is this patch does not currently set Bluetooth
> working on the these boards. The problem is that the
> bluetooth/hci_h5.c driver, that is used for Realtek serial devices,
> depends on ACPI. Unfortantly ACPI can not be enabled on armv7 machines
> such as the TB(S). And so the kernel module for the RTL8723BS
> Bluetooth can not be loaded.
> 
> However this patch is believed to be an accurate description of the
> Tinker Board (S) wiring. It is strongly based on the ASUS patch:
> 
> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
> 
> As the Bluetooth is connected via a UART and this is wired into uart0,
> this has been described as a SerDev.
> 
> The ASUS patch mentions the UART_CTS, but not the _RTS. Now as the
> RTL8723BS has both CTS and RTS on the uart, it has been assumed both
> are wired into uart0 on the cpu.

which would be very strange, because we could use H4 instead of H5.

> 
> The Bluetooth connection has several wake up pins both device and host
> and a reset pin. The wiring of these has been described; however how
> the kernel driver will use these isn't clear. E.g. should HOST_WAKE be
> an interupt?
> 
> The main reason for asking for comments, is that when it comes time to
> make the changes to the bluetooth uart code, and add compatible flags,
> robh has indicated that this will only be accepted with a valid
> example. So the code below is that example. So I would like comments
> that this approach is valid, which can be used when the later
> submission comes. 

Asking for comment should be mark with RFC in the patch subject.

> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index e1796f340eef..931b4c652fdc 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -481,6 +481,17 @@
>  
>  &uart0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
> +
> +	bluetooth {
> +		clocks = <&rk808 RK808_CLKOUT1>;

As we already linked the RK808 clock in the sdio pwrseq, we shouldn't do this here again.

> +		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;

reset-gpios isn't compatible to hci_h5, please use my preliminary dt-binding

> +		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;

AFAIK hci_h5 doesn't support host-wake yet. So if you want to keep for the future we should make a comment.

> +		vcc-18-supply = <&vcc_18>;
> +		vcc-io-supply = <&vcc_io>;

Please drop these as the driver doesn't use it and it's already linked in the sdio pwrseq.

Thanks Stefan

> +	};

[1] - https://gist.github.com/lategoodbye/79bac99d4f1158a719a48ea3c45eb7f1#file-0002-dt-bindings-add-support-for-realtek-bluetooth-serial-patch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
