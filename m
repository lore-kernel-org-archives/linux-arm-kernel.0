Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EE621906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8C1sRfy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nl3DC+W1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KMJQ9caKuoAA2cFfWQXorXQDMnBy5B5jIv90qeSrgZM=; b=s8C1sRfykj/Epf
	/Zgo0Y8WnnS3dZXU9O7H8YFRMCwc37U+4A8h5cJgg27gpMylxV965tEHPR5HvdDzrNesp/Aeyx3Km
	Sv1Xvzw/RxoToUlZR23RK/OHnFZE0btFGH2cfgqlvrtVDHIud8uDdjk1h5MBF/jd+lPdk5bCzVJsN
	91Ljfs8J9+bTNkfKP534m1Tob8cO2NnB7DZmS+StUsBsovXRVDsZB7xATn6OpJkzkGRtgBsZC3wBQ
	2ohvpAbrNrx1RqoAX0C/qulNj8ArG5OfbgI8JDIRODWRtUhi0SJgrL1u1rWo1GnVGzSBxkufF/T73
	9d4ZoMgkX4jtDnmSCVRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaAfm-0002ua-UX; Fri, 21 Dec 2018 02:36:22 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaAfj-0002sd-Kq
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 02:36:21 +0000
Received: by mail-pf1-x444.google.com with SMTP id c123so1849079pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D0MlURTt1nCvg8EFKNr+8mCnhzAm1tiCZAzywT9Mfr8=;
 b=Nl3DC+W1F5t+2H5wFgXxpJcesI0pR80bQa2En9Sf3PGcPmSOSpVViGSFg8lZmJ4+y7
 81Y2M6eOlq4DEdCyWIFmRx4qRbXfH5EY5cnkSZWOyzfEyA6XCybo7bIaID8AhIgqtIyL
 wp+sh1kRm5NQnlnmXj6QkYmUn/2A0TxdWWUcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D0MlURTt1nCvg8EFKNr+8mCnhzAm1tiCZAzywT9Mfr8=;
 b=g1OoTKh0dLXBcjR72Bxig/XHyy2C6nMhztjBwRyvjJOx5ZlUiaiPuYGGUUuIcCrrTu
 QqjcPmUkzAWNHx3m30MkQcsnmamoiDUME3MTEuk03rfBmEXn0HR/utgUdhHlwSvolXQ4
 hnuIYU6pP6bUY9VyMAhlGis5pazFFxxDPLet99KKKxIq5u1IrLpFn8M9qhlDxsR8Quq4
 jYC2QPbvIO6RDish99vTRgxdqEp0kRoAnnerxYiLMub9kacsDtyiS9Hat8b/XqpZofOv
 f8AzGOGRn7C4a2M+JNrUJJWgjL6ERlczXlqpsHElZ7XsRfXnwNlt/lPDLuujKQk1F1CF
 RGeQ==
X-Gm-Message-State: AA+aEWaJM4qvBkRC6XUkKBNyGJqrUMaRB+neKGlAzZ9P228dwDh6Bcou
 0A3QYeumpxhmkjBAcIae891+
X-Google-Smtp-Source: AFSGD/VdDzzOjEgiDcSVmGChhmKrJxSTOeceVHFlIibvWIzIdF1z0QZEFTFg10NZ5HZ2Cn2IZyWbaw==
X-Received: by 2002:a62:db41:: with SMTP id f62mr677668pfg.123.1545359767807; 
 Thu, 20 Dec 2018 18:36:07 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:810:d868:55e9:25e8:dbda:255b])
 by smtp.gmail.com with ESMTPSA id h82sm41836555pfa.105.2018.12.20.18.36.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 18:36:07 -0800 (PST)
Date: Fri, 21 Dec 2018 08:05:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andy.gross@linaro.org
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
Message-ID: <20181221023554.GB3233@Mani-XPS-13-9360>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181029094245.7886-8-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_183619_702844_7D2FD59C 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: devicetree@vger.kernel.org, daniel.thompson@linaro.org,
 linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-rockchip@lists.infradead.org, koen.kooi@linaro.org,
 linux-leds@vger.kernel.org, nicolas.dechesne@linaro.org,
 linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Oct 29, 2018 at 03:12:45PM +0530, Manivannan Sadhasivam wrote:
> For all 96Boards, the following standard is used for onboard LEDs.
> 
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
> 
> So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> one of the 96Boards CE platform.
>

Hello,

Any update on this patch?

Regards,
Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 46feedf7c989..35f95154316b 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -300,28 +300,28 @@
>  			compatible = "gpio-leds";
>  
>  			led@1 {
> -				label = "apq8016-sbc:green:user1";
> +				label = "green:user1";
>  				gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "heartbeat";
>  				default-state = "off";
>  			};
>  
>  			led@2 {
> -				label = "apq8016-sbc:green:user2";
> +				label = "green:user2";
>  				gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "mmc0";
>  				default-state = "off";
>  			};
>  
>  			led@3 {
> -				label = "apq8016-sbc:green:user3";
> +				label = "green:user3";
>  				gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "mmc1";
>  				default-state = "off";
>  			};
>  
>  			led@4 {
> -				label = "apq8016-sbc:green:user4";
> +				label = "green:user4";
>  				gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "none";
>  				panic-indicator;
> @@ -329,14 +329,14 @@
>  			};
>  
>  			led@5 {
> -				label = "apq8016-sbc:yellow:wlan";
> +				label = "yellow:wlan";
>  				gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "phy0tx";
>  				default-state = "off";
>  			};
>  
>  			led@6 {
> -				label = "apq8016-sbc:blue:bt";
> +				label = "blue:bt";
>  				gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
>  				linux,default-trigger = "bluetooth-power";
>  				default-state = "off";
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
