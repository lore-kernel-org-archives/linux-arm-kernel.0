Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB211208C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPJXerOA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="w0omfnhz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="JfSp7zD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB211208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DNtDST7PyJbgw2lsybdZ1IEI3heBpdfro1jX8HKMLEY=; b=RPJXerOA9kml0JfQk2OmXJyU5
	oWGEj6UcKy4/guOLuHuPnCsEQyFE5TsOppUhFrqzhl4Ek+8r6EWe9jpYWAIrr8bjoc8DvyKivT6un
	h93bPkV7O+UPV97xPimWEIMXBJI+kH+zNg4IrwIveABnxGvaJgGb8WFSeZzHAQlqYImqtY9yoA9xk
	j/mnVAwkigljkEslD09rDr0TdMPaZo2aEZZBhyshTxDeGU0vL6sdtHH2K/bve88Z1/ZmB/HKBn0x2
	EC8M/2K5UfpHIArPXqJJdX+GAKX5ANFmoFjA4+Qbw8cd7AM4yjnjM7tx1vttkhs8Ye2mXd5xoszir
	ZuajMCGNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvLM-0000Id-0V; Fri, 14 Dec 2018 21:50:00 +0000
Received: from mx07-00252a01.pphosted.com ([62.209.51.214])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvLG-0000H7-0y
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:49:57 +0000
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
 by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBELnZYI015389
 for <linux-arm-kernel@lists.infradead.org>; Fri, 14 Dec 2018 21:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org;
 h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=B/rXrBRnXf2ulmrWYT0PigD+EFjOuhrKz89fW3yU+1M=;
 b=w0omfnhz4eKTqrS5c1XhqRxPyBaIKsNMHN7d8YjzRqOlLszJKs6Ti3zu0EgQhqxvZHOI
 NNQ5Xi0Q6fYaJVUJNePtZzWPkipGpObXF/IATHqoeMYjpu3viQTs+3ijqVFNJ42m1oCc
 TFWRvXLnBlWgDPQdlfZHoKj64zVhTr4ihgsWR+v5lcK+yMxdOWMFFQC5rQzooPyK5Mps
 vGvctEHf3plcsXAFF2aeKfgvnP2gUkCynIg63LsgyrJmQWS6nZ6ymbdtWHs6S5oupXAi
 FjBQHuq5ZWudGm2dj3a05YYw3Wc8Bo0bozEfkCW1PpdOGl8bT/TuVZdORTzeJVZnz4O0 sA== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by mx07-00252a01.pphosted.com with ESMTP id 2p8485b8na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 14 Dec 2018 21:49:36 +0000
Received: by mail-wm1-f69.google.com with SMTP id l73so38244wmb.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 13:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=B/rXrBRnXf2ulmrWYT0PigD+EFjOuhrKz89fW3yU+1M=;
 b=JfSp7zD3DhANgTfmkww3rocksp+5zUggCfN0qjBAV3fDa+u/Ba4gBQ8jmHQtIJOxFd
 WDSvbm1oNhtVbuoeb07kfr8Lxo+KMwyXWtITYe8g9TZWD2jrhdwWWrr7t5R8bVZY5cp/
 5qpI4O5YJz0lXq9tkV/1UDPPdJD/AxgQcrQ9zkM3m8ETLMZjeq21iWRIfnVE8KA1WKwh
 S67r2+tobR8iwl6eUIl9QpjdRsYYcbtFQHLwGqMxFrbYEloQlUs8A+szNeXx3KF3aNpJ
 MSf1ejUWQGXyTAJStVmmuyiu39KdrvvdgVZ2C+9Pst7VheJBIIOibaWtqsYqWdhaAO0l
 D41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=B/rXrBRnXf2ulmrWYT0PigD+EFjOuhrKz89fW3yU+1M=;
 b=O5DmRBnoToEBPlIZFjupnR//zNwwkyCzOWpWhFAOOOQgSbP17Z0sIqJzhGhN98IpkU
 rnXEZEJ0bsMLQ7RWBVJaQbnR95vSID/cjUwkTpyY/fcyRddd8ufx2aL9NNnisVvpxUuK
 GFHZjboUo+88d/7/chVQ9CDfrsWxa/L+fMai1EWDz4J7h+JWbtavtSlYs1/T1Bwh7a+W
 skEXfFv440OOaNBvnrju3ImU1XH7lnmtPGOWK03edqalsIwlCMeL3ROOu5PHz/mmydlq
 x5u1goVUUyM1AatL92bOadiFAW7HLuIry+n/Y1M9Qxt5P2l5fIWMXFsvoVfI6MdMSE7W
 x1qg==
X-Gm-Message-State: AA+aEWZq/XHtg5puDXpEcrQz6ROEvvmS7SU9LxOxL1P6V9+b8+D1mSP9
 9qcL4aE9jrP9bo1DKXXrGqOMyvCGzU0GeNdrLnsVyx5sl9Y3MEtXrR328UYk0Za6tDxWzbNa1Wp
 8flC9WeYrtbr6cueNsG9T+e9B9+ZcCIWtFu4=
X-Received: by 2002:a1c:5746:: with SMTP id l67mr4588248wmb.118.1544824174681; 
 Fri, 14 Dec 2018 13:49:34 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VOROqWiLtfUbo3MmzD0GGcu6qpITWwa8ZegonbALFf5c+jtXRmPe/OgMGYcLvmxFAf/DYDmg==
X-Received: by 2002:a1c:5746:: with SMTP id l67mr4588230wmb.118.1544824174311; 
 Fri, 14 Dec 2018 13:49:34 -0800 (PST)
Received: from PhilsPB.local
 (cpc129774-papw8-2-0-cust832.know.cable.virginm.net. [86.12.207.65])
 by smtp.gmail.com with ESMTPSA id v1sm5184565wrw.90.2018.12.14.13.49.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 13:49:33 -0800 (PST)
Subject: Re: [PATCH V2 2/3] ARM: dts: add Raspberry Pi 3 A+
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
 <1542322805-6211-3-git-send-email-stefan.wahren@i2se.com>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <11816ec8-9824-8825-b9c3-6790b6171261@raspberrypi.org>
Date: Fri, 14 Dec 2018 21:49:31 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542322805-6211-3-git-send-email-stefan.wahren@i2se.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_13:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_134954_390079_04039C10 
X-CRM114-Status: GOOD (  30.64  )
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
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On 15/11/2018 23:00, Stefan Wahren wrote:
> The Raspberry Pi 3 A+ is similar to the Pi 3 B+ but has only 512 MB RAM,
> 1 USB 2.0 port and no Ethernet.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   arch/arm/boot/dts/Makefile                 |   1 +
>   arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 107 +++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+)
>   create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d..15bbd0d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>   	bcm2835-rpi-a-plus.dtb \
>   	bcm2835-rpi-cm1-io1.dtb \
>   	bcm2836-rpi-2-b.dtb \
> +	bcm2837-rpi-3-a-plus.dtb \
>   	bcm2837-rpi-3-b.dtb \
>   	bcm2837-rpi-3-b-plus.dtb \
>   	bcm2837-rpi-cm3-io3.dtb \
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> new file mode 100644
> index 0000000..75785dd
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2837.dtsi"
> +#include "bcm2836-rpi.dtsi"
> +#include "bcm283x-rpi-usb-host.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
> +	model = "Raspberry Pi 3 Model A+";
> +
> +	chosen {
> +		/* 8250 auxiliary UART instead of pl011 */
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0 0x20000000>;
> +	};
> +
> +	leds {
> +		act {
> +			gpios = <&gpio 29 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		pwr {
> +			label = "PWR";
> +			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&firmware {
> +	expgpio: gpio {
> +		compatible = "raspberrypi,firmware-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "BT_ON",
> +				  "WL_ON",
> +				  "STATUS_LED",
> +				  "",
> +				  "",
> +				  "CAM_GPIO0",
> +				  "CAM_GPIO1",
> +				  "";
> +		status = "okay";
> +	};
> +};
> +
> +&hdmi {
> +	hpd-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;
> +};
> +
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio41>;
> +	status = "okay";
> +};
> +
> +/* SDHCI is used to control the SDIO for wireless */
> +&sdhci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_gpio34>;
> +	status = "okay";
> +	bus-width = <4>;
> +	non-removable;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +/* SDHOST is used to drive the SD card */
> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	status = "okay";
> +	bus-width = <4>;
> +};
> +
> +/* uart0 communicates with the BT module */
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ctsrts_gpio30 &uart0_gpio32 &gpclk2_gpio43>;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		max-speed = <2000000>;
> +		shutdown-gpios = <&expgpio 0 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* uart1 is mapped to the pin header */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_gpio14>;
> +	status = "okay";
> +};
> 

Although this DTS originally looked correct to me, I learnt yesterday from
poring over the schematic that, due to routing congestion around the WiFi combo
chip, the 3A+ drives the BT_ON pin from the same source - GPIO1 on the expander -
as the WL_ON pin. GPIO0 on the expander is not connected. This means that the
shutdown-gpios property of the bluetooth node is incorrect.

Furthermore, I've been told that the current production 3B+ is the same in this
regard - a change since the 3B+ schematic with which the firmware support was
developed - so the 3B+ DTS should ideally also be changed, although leaving it
as it stands is likely to make little practical difference.

Phil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
