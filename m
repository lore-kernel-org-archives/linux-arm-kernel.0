Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_DISCARD,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56074C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwZ+GQJq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YKi32Jtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C2C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DsBjh7T8+zojqU6ZvfZQcQlpng60TKgKT9bS4aRdZNI=; b=gwZ+GQJqDt+CSw
	9ZzKkk/THc4XO/0eOMyGv64eg0gezkhdDLqvOM5C6Gw5BYx608Qdi8BXL1xy+ep3tPBkDnvzWA/HS
	qGgd0NmZRhI+WBc2CxZBlvrFQYNIb0kJ8VAAcnyTcHv/mnEauKstIEDgcoj4uxgPLd5IEWnFmszNO
	r9bP+LVDFVa4q7e4CEzy96b9ABH8PmV18CCz5KAbvdowNTt92ltM/Lx7S1koPjteulqPrgscPyNSH
	rPxNbzerpWDJiMEXcQwk6DNlY6rAPX1v6+uMx3NCrhniagHVbVqgjZEfuoiKOqZ7uyYig0/yY7DQn
	nYQz/RzhtKimQGw4HvUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmnU-0005gH-CM; Fri, 14 Dec 2018 12:42:28 +0000
Received: from vps.xff.cz ([195.181.215.36])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmnQ-0005Rb-47
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
 t=1544791329; bh=okS3jNr43q2CRdJZ7mqQmQXOMY7AppBVBNBrFJwFg0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YKi32Jtc/Zo4UWtOubshbFIihFEQLbAZ0bf+7ajXehamZ1K5OEwGR7wfU6phL0ztT
 pJsuCywi1+lxMOqW57gUd45RbmLy/B+o+NdMQ+wbP4cXZumU1QnTI1XU0h1/63Vkw3
 g+pmYmif7dbAAY/IExvY9eANzcoUnpgOEGTnIX0A=
Date: Fri, 14 Dec 2018 13:42:08 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth
 controllers
Message-ID: <20181214124208.e72glckgcgbfyc4f@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Loic Poulain <loic.poulain@gmail.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_044224_316365_36ED5B63 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 15, 2018 at 05:35:48PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v2 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> based SBCs series.
> 
> Changes since v1:
> 
>   - Collected tags
>   - Re-organize dt binding clocks and clock-names properties
>   - Simplify check for deferred probe when getting clocks
>   - Add explanation of Cubietruck's clk_out_a pinmux setting placement
>     to commit message.
>   - Add missing "uart-has-rtscts" property to Cubietruck device tree
>
> [snip]

Hello,

I've tested your patch series on TBS A711 / BCM20702A1 with the following DTS:


 /* There's the BT part of the AP6210 connected to that UART */
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm20702a1";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vbat>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		max-speed = <1500000>;
+	};
 };


And it works. :)

Tested-by: Ondrej Jirman <megous@megous.com>


Thank you and regards,
  o.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
