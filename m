Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A0EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:21:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3892081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sPIePLBL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h8VQC8eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3892081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QiiGEC9y3CBmfr/1ffp7aU74nFuQF/+VY/1Lxb27zO0=; b=sPIePLBL5CBE+c
	+XwQYx97HiAeNR+IteXpGFDZmvZ35tzlRBj9XvdQxdYhsAZ5bmaykOEWPsvoX+O63JqyljRkXyXpJ
	kJk3yJZiRGj4Ni2mAVMttQ+fc4LwYAmk8MRp/u3FTzqnNnR6jfsCvPzDqeZ8JdjwNGDUcpOa6K/MS
	Glp+XOIOzJOSYAIWC/Ndqwqii38qRFFlPZNbSalNmoI3HPPjhMFiNwkguiPl1OMS7hquEN0ivK++V
	HJ32tf3EhTlywZP14NpegGPCI1isJSX7yU1oNheJ2vFZ0jfQ3YE1zuTuVx1ywly0ZWfi+aSmtedOW
	4EeJMas2rWlq15a/NOjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT74u-00045X-R2; Sat, 01 Dec 2018 15:21:08 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT74r-00044b-Co; Sat, 01 Dec 2018 15:21:06 +0000
Received: by mail-ot1-x343.google.com with SMTP id a11so7830092otr.10;
 Sat, 01 Dec 2018 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VWa1Q5XqnLUhpbZxRkkayyYl2s3zESe84B9sMKGpX/g=;
 b=h8VQC8eCjhiSzziwYo+W75jFWRsalsDy+qFguMzkRav/q5JDLdEawmiyRKtks5VOyd
 cakBI6Xd9l6z6EKsUVZV0juDB66EsKyESkZWIw5dqYgDR93pbL7ga/74SIl15U53NznF
 DrqzUxV4hr7Qfo9HjeXvUmcTULlsmeSsXfEIboawOO4cSdLEQ3Y/SmsP28tAA9KqOoZp
 DmkpL5r9QjppQPwb88Njniit3VaK1KxZiH9ywEfxP01QhovScvnUqLiUpIEa8cEus6ud
 frHCuhqmW9BLYFtAcVQ8fnXIjD4ol4BtE6K9yEKxTxhuDQ6qKV6k3liQZEhOjnW5Jhgm
 bGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VWa1Q5XqnLUhpbZxRkkayyYl2s3zESe84B9sMKGpX/g=;
 b=TSZYD1YQy2JQl0GxHeZQPAwGcUSVHXatj0yO65+J8GinW4W6K788M/9mgmW6MIPHj4
 7e5wUpTLW7PPUNEinnIrtYLp0/nKw4T0I5KL/ADiZOjP/YkhPDL8LQJAM4waMj/mzecH
 oDdKpYz1v5vhxxgyUFrvfxqQTZi2B587KnNViMGNeLE+d529jfiz09c5njTCg0PYapXo
 KG1AybtFb0R7BCUWmqlP0gtklJzhPhI1UvSTB4XghcydTnn2Lj91JMWuhGcydOAEuwxw
 6RwY38S6Drh/X/EbyhoeTjOT1QSIUHyfc5+djD6XvcYZDjTjKu3nDqOuRviLE84EAnay
 GYqQ==
X-Gm-Message-State: AA+aEWY+0N079aq+PMivEwo4v/85zoGaagYYqbFMZCrMr3xFlnbKsEWr
 e0FtWmZmqTNYD7GUN9bA5O0JJkZ1y6atwpWc/DM=
X-Google-Smtp-Source: AFSGD/WhvnqI2EBdt2vFxGkf5grd/Gtnt6NJgHnt/WMv1BYGMLWSssTkSgBsgV5qIntUdqBtuEfiITWra1vXl8JnAJ8=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr6324341otj.148.1543677651690; 
 Sat, 01 Dec 2018 07:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20181201145614.5381-1-ccaione@baylibre.com>
In-Reply-To: <20181201145614.5381-1-ccaione@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 1 Dec 2018 16:20:40 +0100
Message-ID: <CAFBinCDEJK-tJJJCd7wPLJHRCV0DegnSGO21XH3EXU7s7Om=Bw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-axg: Fix and enable GPIO interrupt
 controller
To: ccaione@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_072105_461912_37242A2D 
X-CRM114-Status: GOOD (  15.56  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Sat, Dec 1, 2018 at 3:56 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> The GPIO interrupt controller registers are mapped to the wrong
> offset in the DTSI. Fix the offset in the DTSI and enable the interrupt
> controller in the DTS of the only AXG board enabled.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 ++++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 18778ada7bd3..c3e4aac75782 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -374,6 +374,12 @@
>         status = "okay";
>  };
>
> +&gpio_intc {
> +       compatible = "amlogic,meson-gpio-intc",
> +                    "amlogic,meson-axg-gpio-intc";
multiple compatible strings should be ordered:
- use the most specific compatible (the AXG one) first
- the the less specific ones

also why did you add the AXG compatible string in the s400 board .dts
instead of meson-axg.dtsi (which makes it available for all AXG
boards)?

> +       status = "okay";
> +};
> +
>  &ir {
>         status = "okay";
>         pinctrl-0 = <&remote_input_ao_pins>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index df017dbd2e57..f1affc12e3e6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1415,7 +1415,7 @@
>
>                         gpio_intc: interrupt-controller@f080 {
unit-address should match the reg property: ...@9880

>                                 compatible = "amlogic,meson-gpio-intc";
> -                               reg = <0x0 0xf080 0x0 0x10>;
> +                               reg = <0x0 0x9880 0x0 0x10>;
Amlogic's patched 4.9 buildroot kernel uses 0xf080 - can you add a
short sentence to the description on which board you have tested this
(I assume you used the s400)


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
