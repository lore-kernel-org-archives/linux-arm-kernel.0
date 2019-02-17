Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9522FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:31:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A69E222E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AW/6Kbwh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjBgLXrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A69E222E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Y+QKbWu84AAC+9SP4UBW6VHYutYXl/bH5uzE0nUoIs=; b=AW/6KbwhxLfq7B
	LfURscl3gT+zpRUj6Jxvn1vIfmhFpvMjp1kPzgGr7IVi+7dWmLLOFv5RvQcB6+r80+t7g62wpOpLy
	K3tUqRUbF/qRf5tL3MFeoKK5iKZBDJVbwY0AdwBwJQKEyVnk5KZ+4DG7mhpPO79piZGRUJFrwDcSS
	vWKHyzNHy4QAN2V/W2nFwill0JGusl9m1G3S0d3QA3AKRbxWozodyxfOZKXuNNAjfhctoSZ5/JdEA
	+bsSllP+LJkyKQxJEAkdkBiVf0PeU8k/+6yjSuI49xqm6VNj4W5gBWAh9dlhmCCPaRcnhIAyEH3A4
	kYutOaYAZ4oQilfxe3pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvMXa-00061r-AO; Sun, 17 Feb 2019 13:31:30 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvMXV-000610-Jz; Sun, 17 Feb 2019 13:31:27 +0000
Received: by mail-ot1-x344.google.com with SMTP id m1so24055259otf.5;
 Sun, 17 Feb 2019 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p1e1tbWPjQMr5uvvzqE25yFfTW+JFEiVgbebOUmzsuQ=;
 b=OjBgLXrDO+HYZilxGtzPwZtPFszx2W/+mYJkqAh+zZiLu9bZ1ZN2bU/w+FHL8nNp+1
 Rupmg0SvR/qN3uRcnQEdCuOXP1AhJO0E/qphFAtZKVBexxMDt7DNXi0vfWdMU2mh7x4A
 A03+j4lZnrDq+9Si6fD7xFiKC6Rk+LJFn7jyp8iU1RF8nehMcnidXv4xEbIOI4HORBzT
 Er40o+zvqFCyjekWIcFQKZ5kF6Nzahqwd+zQi7BXC8ldAY+8jx3iEQAcVnGE4QQdRRVC
 yJxn3a0WCZjVe/28Bkat69yLr3sOB4kvWhSCoCcGi2bNIU07XV2IsIbsv51H967fkBk8
 463w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p1e1tbWPjQMr5uvvzqE25yFfTW+JFEiVgbebOUmzsuQ=;
 b=AtRldK/Xa4vUubj3Ta13LKCn9+b7PRylO+QA1xvCgdfVA8ryk6cr2V44PQib46vQ9/
 V2X0H5bfXr1DzgmVz0mo2QoLWWWoIHc5yhbBG5w8UI3XrhHHsaeluf0i6KkD78Q833gt
 +XSSMLnLZma0cWw24Ar+eYmLgB1AMlq9QIhRAxracJvGUlrX/SRZhQCyvU6Ei66uGt3n
 QqhzT1mAnUmJDJlBP92+uIOhDZKtAvzF9gDF2KcV5/gwpCEdwb4o7EGMA58f8sn6ABZY
 gAAZvmVPcpqpOhxUzcxnJW71I3mIE01rtWp4RETWAO8wCjfBICByoeck2c7SloXSXamI
 KokQ==
X-Gm-Message-State: AHQUAubNppXpHMCa1rCO8iLLuNf6fKuvEkPZhkLVODWCllbvqIyl88NN
 Z6QmBUsQea4Mr0mW88XD7BTYd/RE7UjfZR84gLU=
X-Google-Smtp-Source: AHgI3IZPP0TPh3wSGA+7S6Qrs/JWKPpJIU0g3oW1dF6/kHEAFpGDkmfYKj7DcG6L7rPw9duXstbd/lpOZHqoo0YMNJk=
X-Received: by 2002:aca:4d3:: with SMTP id 202mr11141605oie.31.1550410284015; 
 Sun, 17 Feb 2019 05:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
In-Reply-To: <20190217121513.22965-4-beagleboard@davidjohnsummers.uk>
From: Tony McKahan <tonymckahan@gmail.com>
Date: Sun, 17 Feb 2019 08:31:11 -0500
Message-ID: <CAERgok=0v=voM1ExSvA3Upo-a9woi0OJQ1J2k_xxbWHbV-bd=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: rk3288 Tinker Board (S) add bluetooth
To: David Summers <beagleboard@davidjohnsummers.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_053125_680039_1FC480DD 
X-CRM114-Status: GOOD (  27.20  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Dave,

For the Bluetooth I can confirm _RTS is required, quite a lot of work
went into creating a userspace
solution for the Tinker Board bluetooth for Armbian by myself and by
Miouyouyou for a more
generic mainline patchset. Without RTS the rtk_hciattach handshake fails.

On Sun, Feb 17, 2019 at 7:17 AM David Summers
<beagleboard@davidjohnsummers.uk> wrote:
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
>         status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
> +
> +       bluetooth {
> +               clocks = <&rk808 RK808_CLKOUT1>;
> +               reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
> +               device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +               host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +               vcc-18-supply = <&vcc_18>;
> +               vcc-io-supply = <&vcc_io>;
> +       };
>  };
>
>  &uart1 {
> --
> beagleboard@davidjohnsummers.uk
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip



-- 
--------------
Thomas McKahan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
