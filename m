Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA56C31D63
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6748D217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8rGsu4H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obrAQxw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjEK/haVf+sPAGbbvrukXTpaTbUn8lpU8iM+UkDRClI=; b=G8rGsu4HQ07BQ4
	Eq/vVMZgHwc5J2/t1p9Bmj0uFpld1Fzg4mkHRdeEyhQ6IPk65LiEp2+8ANUiG+ahh/vnUvFJAiNcW
	6mbmS8/PM0TfGmewpfiLTOZX2J7uID3VE80ZrA4WTFsJ1qApqZ7qj6gyiKZMsT86jF9/XjEBTs3Im
	u01FiOrbqVU/RF8rjS6xhluFpk3lqqkx/haaUsSPH+nYPPKkg3G1JCwzdE3pJfkJkBxZudTBZaDsG
	USoEiIamE9Ahpin0zz4ZXHx3bsSbepLzsaKNCW8ufJ8JjDrSEWMvv3M8m9OLYuGHD5wx3Y8Hgil9n
	5Vxv6x47DDaAtyRIh/KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glRZo-0005lD-TB; Mon, 21 Jan 2019 04:52:48 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRZh-0005c1-N1; Mon, 21 Jan 2019 04:52:46 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so21616963wrt.13;
 Sun, 20 Jan 2019 20:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ifV6qRD+BfML9e9yBRlXMcsiNht/UBMmDXk01DtXIfo=;
 b=obrAQxw4i4WvJjUn9MRnpThU+GhzJ+Kh8Mn1yRqfYVZ+DN+QNKEzcWW3oU/Vm5OxH8
 QCi8nTMwjDIXQDfGRhiCVQUhURKzZTftdmhCy01ewrIgzjwaIXCABNb7/D34NxKi/DWt
 nZbndtlDXPX9l9FavivPv6pXCO81sdzhhbp7eFHwLDRITrFWUPMZ6+NJRuSHg4/fGgLa
 jHlNkR35G5I9qKGUm7id9gxB0voW/6Aq8R+PTadRnGTusmAlNMfGMmMsl9w/HFEy7EcH
 0s/XKY4ZeehKYb41saAf63JyRuMgWWwagqslIObU0ytXN3tvWrAnBTUMTNNMmR9Zxh3e
 RsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ifV6qRD+BfML9e9yBRlXMcsiNht/UBMmDXk01DtXIfo=;
 b=bOmmr7F3kaSO/91oa95aGuhVQdcWWYugsr+CE8xm+k5yqa6rD3tWSnVSL4aTaJ3s4l
 w7htbptawxTUk2w0UDe5+PXqtqqWgHBQocVNe/NPPsIKEGT8/IvOro8y4Y7Qee21rSMC
 EVUF0164s1bYOhRW5fviFgQZS0zWfujfRpXQMF3p4N1buOOKN8BJx2nfodCAhUdSaXfY
 n/s/92FEjkRHjECei66nsjqiQmvIjXrJ9jpiaBlN+L6yAJOspFZMjkiazsdtAXZgsAm+
 4cBhaiFSMKt6eHFwaOFWd7VRwQvkwzlkxPW6alszzUTsgegqV0fac3oK+/UBKiVKbhsZ
 xtYg==
X-Gm-Message-State: AJcUukeU+N3z6X4b8ytem/ftbBYuaYBFJAdo1d+0B7NpPhLlVkk58rnn
 cJFJ949yc9GUVdoPjBWIUFHB9uOx72caMGnPouI=
X-Google-Smtp-Source: ALg8bN6roek0t37jI0sSfhfrDay1zr3XjNEU+zFuZNg/XtGa0kqhQBsQng/vV3Jv2bS6hVy3NgOHT/NGQlI5ip2z3dI=
X-Received: by 2002:adf:9d85:: with SMTP id p5mr24912152wre.41.1548046358464; 
 Sun, 20 Jan 2019 20:52:38 -0800 (PST)
MIME-Version: 1.0
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
 <1547297008-2740-7-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1547297008-2740-7-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Jan 2019 04:52:26 +0000
Message-ID: <CALeDE9OPnjGrg0QmLsVuOwQk-jzkggz=zaLTnrQGaJof_6Z8NA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: bcm283x: Add missing GPIO line names
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_205242_046069_8480A767 
X-CRM114-Status: GOOD (  19.59  )
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
> The GPIO sysfs is deprecated and disabled in the defconfig files.
> So in order to motivate the usage of the new GPIO character device API
> add the missing GPIO line names for Raspberry Pi 2 and 3. In the lack
> of full schematics i would leave all undocumented pins as unnamed.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on RPi2/3/3B+ using lsgpio

> ---
>  arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 66 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 70 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 70 ++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> index 871fc4a..7b4e651 100644
> --- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> +++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
> @@ -28,6 +28,72 @@
>  };
>
>  &gpio {
> +       /*
> +        * Taken from rpi_SCH_2b_1p2_reduced.pdf and
> +        * the official GPU firmware DT blob.
> +        *
> +        * Legend:
> +        * "NC" = not connected (no rail from the SoC)
> +        * "FOO" = GPIO line named "FOO" on the schematic
> +        * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +        */
> +       gpio-line-names = "ID_SDA",
> +                         "ID_SCL",
> +                         "SDA1",
> +                         "SCL1",
> +                         "GPIO_GCLK",
> +                         "GPIO5",
> +                         "GPIO6",
> +                         "SPI_CE1_N",
> +                         "SPI_CE0_N",
> +                         "SPI_MISO",
> +                         "SPI_MOSI",
> +                         "SPI_SCLK",
> +                         "GPIO12",
> +                         "GPIO13",
> +                         /* Serial port */
> +                         "TXD0",
> +                         "RXD0",
> +                         "GPIO16",
> +                         "GPIO17",
> +                         "GPIO18",
> +                         "GPIO19",
> +                         "GPIO20",
> +                         "GPIO21",
> +                         "GPIO22",
> +                         "GPIO23",
> +                         "GPIO24",
> +                         "GPIO25",
> +                         "GPIO26",
> +                         "GPIO27",
> +                         "SDA0",
> +                         "SCL0",
> +                         "", /* GPIO30 */
> +                         "LAN_RUN",
> +                         "CAM_GPIO1",
> +                         "", /* GPIO33 */
> +                         "", /* GPIO34 */
> +                         "PWR_LOW_N",
> +                         "", /* GPIO36 */
> +                         "", /* GPIO37 */
> +                         "USB_LIMIT",
> +                         "", /* GPIO39 */
> +                         "PWM0_OUT",
> +                         "CAM_GPIO0",
> +                         "SMPS_SCL",
> +                         "SMPS_SDA",
> +                         "ETHCLK",
> +                         "PWM1_OUT",
> +                         "HDMI_HPD_N",
> +                         "STATUS_LED",
> +                         /* Used by SD Card */
> +                         "SD_CLK_R",
> +                         "SD_CMD_R",
> +                         "SD_DATA0_R",
> +                         "SD_DATA1_R",
> +                         "SD_DATA2_R",
> +                         "SD_DATA3_R";
> +
>         pinctrl-0 = <&gpioout &alt0 &i2s_alt0>;
>
>         /* I2S interface */
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> index d3ec6cd..c6fa34c 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
> @@ -52,6 +52,76 @@
>         };
>  };
>
> +&gpio {
> +       /*
> +        * Taken from rpi_SCH_3bplus_1p0_reduced.pdf and
> +        * the official GPU firmware DT blob.
> +        *
> +        * Legend:
> +        * "NC" = not connected (no rail from the SoC)
> +        * "FOO" = GPIO line named "FOO" on the schematic
> +        * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +        */
> +       gpio-line-names = "ID_SDA",
> +                         "ID_SCL",
> +                         "SDA1",
> +                         "SCL1",
> +                         "GPIO_GCLK",
> +                         "GPIO5",
> +                         "GPIO6",
> +                         "SPI_CE1_N",
> +                         "SPI_CE0_N",
> +                         "SPI_MISO",
> +                         "SPI_MOSI",
> +                         "SPI_SCLK",
> +                         "GPIO12",
> +                         "GPIO13",
> +                         /* Serial port */
> +                         "TXD1",
> +                         "RXD1",
> +                         "GPIO16",
> +                         "GPIO17",
> +                         "GPIO18",
> +                         "GPIO19",
> +                         "GPIO20",
> +                         "GPIO21",
> +                         "GPIO22",
> +                         "GPIO23",
> +                         "GPIO24",
> +                         "GPIO25",
> +                         "GPIO26",
> +                         "GPIO27",
> +                         "HDMI_HPD_N",
> +                         "STATUS_LED_G",
> +                         /* Used by BT module */
> +                         "CTS0",
> +                         "RTS0",
> +                         "TXD0",
> +                         "RXD0",
> +                         /* Used by Wifi */
> +                         "SD1_CLK",
> +                         "SD1_CMD",
> +                         "SD1_DATA0",
> +                         "SD1_DATA1",
> +                         "SD1_DATA2",
> +                         "SD1_DATA3",
> +                         "PWM0_OUT",
> +                         "PWM1_OUT",
> +                         "ETHCLK",
> +                         "WIFI_CLK",
> +                         "SDA0",
> +                         "SCL0",
> +                         "SMPS_SCL",
> +                         "SMPS_SDA",
> +                         /* Used by SD Card */
> +                         "SD_CLK_R",
> +                         "SD_CMD_R",
> +                         "SD_DATA0_R",
> +                         "SD_DATA1_R",
> +                         "SD_DATA2_R",
> +                         "SD_DATA3_R";
> +};
> +
>  &hdmi {
>         hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
>  };
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 31b1c03..ce71f57 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -47,6 +47,76 @@
>         };
>  };
>
> +&gpio {
> +       /*
> +        * Taken from rpi_SCH_3b_1p2_reduced.pdf and
> +        * the official GPU firmware DT blob.
> +        *
> +        * Legend:
> +        * "NC" = not connected (no rail from the SoC)
> +        * "FOO" = GPIO line named "FOO" on the schematic
> +        * "FOO_N" = GPIO line named "FOO" on schematic, active low
> +        */
> +       gpio-line-names = "ID_SDA",
> +                         "ID_SCL",
> +                         "SDA1",
> +                         "SCL1",
> +                         "GPIO_GCLK",
> +                         "GPIO5",
> +                         "GPIO6",
> +                         "SPI_CE1_N",
> +                         "SPI_CE0_N",
> +                         "SPI_MISO",
> +                         "SPI_MOSI",
> +                         "SPI_SCLK",
> +                         "GPIO12",
> +                         "GPIO13",
> +                         /* Serial port */
> +                         "TXD1",
> +                         "RXD1",
> +                         "GPIO16",
> +                         "GPIO17",
> +                         "GPIO18",
> +                         "GPIO19",
> +                         "GPIO20",
> +                         "GPIO21",
> +                         "GPIO22",
> +                         "GPIO23",
> +                         "GPIO24",
> +                         "GPIO25",
> +                         "GPIO26",
> +                         "GPIO27",
> +                         "", /* GPIO 28 */
> +                         "LAN_RUN_BOOT",
> +                         /* Used by BT module */
> +                         "CTS0",
> +                         "RTS0",
> +                         "TXD0",
> +                         "RXD0",
> +                         /* Used by Wifi */
> +                         "SD1_CLK",
> +                         "SD1_CMD",
> +                         "SD1_DATA0",
> +                         "SD1_DATA1",
> +                         "SD1_DATA2",
> +                         "SD1_DATA3",
> +                         "PWM0_OUT",
> +                         "PWM1_OUT",
> +                         "ETHCLK",
> +                         "WIFI_CLK",
> +                         "SDA0",
> +                         "SCL0",
> +                         "SMPS_SCL",
> +                         "SMPS_SDA",
> +                         /* Used by SD Card */
> +                         "SD_CLK_R",
> +                         "SD_CMD_R",
> +                         "SD_DATA0_R",
> +                         "SD_DATA1_R",
> +                         "SD_DATA2_R",
> +                         "SD_DATA3_R";
> +};
> +
>  &pwm {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
