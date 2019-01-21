Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D53C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:59:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA8420861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AlCPb6DM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3tBWZtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA8420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pQXVf+fFHbB70IiW3U3ApphzujyXUQ9jx68xfEdHnmU=; b=AlCPb6DMY6470a
	J8uPL6N5mhOVAwzi65oUgt30qvePirZW0Epx4ngMx2BAtIinais2Rv1HY6eUKI4OZSAZCJx1y/JIH
	ffhs7ZAYH/YWYKYUtMEEOOhqnic0W519Bto9cO77zIzKh/uXf0AbLCWHID2wIXJ5Pr4WWoM4xzdLe
	I0hXDyypTSY+XVEj8FXoQywfLZmC2gBdjsD+e+w1nvu9vOiTc0xFRhuJRNhHTWcyamwJr3ggrD7PZ
	mbUvGRXIuHa6Qlr0eggrTQFCNOpW5zRylBfoM5kJ9fn7UrGKj31Ccw7Uwb2LH3LxWppMrUmHyiF+O
	ixN/RXd8rgukL72FWb3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glRge-0007Su-3r; Mon, 21 Jan 2019 04:59:52 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRgb-0007SR-4q; Mon, 21 Jan 2019 04:59:50 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so9500405wmt.0;
 Sun, 20 Jan 2019 20:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHmZlpGkaJE6w/hQwSfShovBKLR79NPwWYj1kjwDPAw=;
 b=J3tBWZtuX1GoZO4gp5EAKpDKJvwtSaW/g5vZEpA9xlYFAGyxiONT0ubwv2ukRUiXs1
 WU1qOMxoLaXbk7HzUxKmPa8Y43uqv8Kf3jzA1fe24G0M6o+g6e5yd9jrxok9ywHjHIwK
 /Rfd50Yh+BVX9vrTOhgXQDw4Rkjv5JmQTxoJEZ2fsN0x9bC5MScEuWVGmJv9OIQD92B+
 fz6GQrHdsIzYKbghHXAQtCnI7fP6vHCDOgwOZ28EotjEbNZLQi+N31BPoVWPOdChT7Ee
 QFuk1/fPUvJJUMb1ZgZw9wj7wuuGTDSdB8k/5cJMovn8bIjiyVTUcRMIN2xR/m3tTIIB
 A8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHmZlpGkaJE6w/hQwSfShovBKLR79NPwWYj1kjwDPAw=;
 b=nDChxw/kPUr2zb1ZML4RyuMcnBA5q1bgHqyKKnmNlAmE/pW8rxRrtzg4JnvPYJk8C4
 IkrZlAcVtcPWuKDqfbspPl2T0ltfYvWp20rSplUbynHtV5dR1Ey4WXGTiVqdn1xXs/jT
 mwz8tLRAtChgFLSrPfenSuwddb5uUzfkGuRn4I4V2U7sR3f/mNUVNKkZWOD20NX4c/h2
 BdJl5dW633cbvNfzsjoFqu6K9oiKbqbrugitTBGca/Sdj+qwx8f9252HmqOW17HTxVsn
 73boih//+DU87IxAaijtVW5Adn8Xux0ne/2t5uPprzC4QtFO8aW18zD602WCm4uvJjfw
 pLwQ==
X-Gm-Message-State: AJcUukeCebwBXqbfgfoNq8yeNx11f/98vC+2fpSnuz5F5bsj/hL5aOIC
 wrRcSgeDwplQwGYHimRvKj/3lI+olZjCJz1fNVw=
X-Google-Smtp-Source: ALg8bN4eQZPFUSgI+VyJCNxzj3Ab8WTrR/rR1dvxDySi9o8vJfo0gs0KZuIyZ++0Dp98UO93Sowa6F9vro6eEsY33mU=
X-Received: by 2002:a1c:30b:: with SMTP id 11mr23108036wmd.110.1548046786057; 
 Sun, 20 Jan 2019 20:59:46 -0800 (PST)
MIME-Version: 1.0
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
 <1547297008-2740-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1547297008-2740-2-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Jan 2019 04:59:34 +0000
Message-ID: <CALeDE9PAog8B_+19XRRxhgHZ2Jk=9PEn2fV9xHTo+5rpQ6L2kQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: dts: bcm283x: Fix DTC warning for memory node
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_205949_216938_4A246F09 
X-CRM114-Status: GOOD (  16.53  )
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
 Gottfried Haider <gottfried.haider@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 12:44 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Compiling the bcm283x DTS with W=1 leads to the following warning:
>
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property,
> but no unit name
>
> Fix this by adding the unit address.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested building RPi bcm283[67] dtb with W=1

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi         | 2 +-
>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index c6e2b23..e490f2a 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -1,7 +1,7 @@
>  #include <dt-bindings/power/raspberrypi-power.h>
>
>  / {
> -       memory {
> +       memory@0 {
>                 device_type = "memory";
>                 reg = <0 0x10000000>;
>         };
> diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> index ac4408b..871fc4a 100644
> --- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> +++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> @@ -9,7 +9,7 @@
>         compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
>         model = "Raspberry Pi 2 Model B";
>
> -       memory {
> +       memory@0 {
>                 reg = <0 0x40000000>;
>         };
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> index e9fadd3..7f4437a 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> @@ -13,7 +13,7 @@
>                 stdout-path = "serial1:115200n8";
>         };
>
> -       memory {
> +       memory@0 {
>                 reg = <0 0x20000000>;
>         };
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> index 42bb090..7d65013 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> @@ -14,7 +14,7 @@
>                 stdout-path = "serial1:115200n8";
>         };
>
> -       memory {
> +       memory@0 {
>                 reg = <0 0x40000000>;
>         };
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 0c155dd..9abb9c5 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -14,7 +14,7 @@
>                 stdout-path = "serial1:115200n8";
>         };
>
> -       memory {
> +       memory@0 {
>                 reg = <0 0x40000000>;
>         };
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
> index 4a89a18..81399b2 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
> +++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
> @@ -4,7 +4,7 @@
>  #include "bcm2836-rpi.dtsi"
>
>  / {
> -       memory {
> +       memory@0 {
>                 reg = <0 0x40000000>;
>         };
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
