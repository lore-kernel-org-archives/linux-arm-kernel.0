Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497AAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1372B21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JVZXC+Cf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNH8vrxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1372B21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wWJ1ju39T0yFJSCOi2W56Q1c3Ouy2Jtq1PrHbSSKWd4=; b=JVZXC+CfUezemC
	h78EHtz1TrOhdeg3bP+4IdP9/hYgK0Q5iEOtgnt4IQYEVj+7oW0hTfZB9ksmnqr+GXz5ZqcvpEPS8
	wTlZ0MDpQRc42C098+pIum3y3aKZLlRQGMBpKThVPVQss0TRaag86CmfGMBlPUzHkxcpl/Z1q2DZV
	/o5c0UdhmmCgkB55SpJD84i9BL695Be9yyH1MW4kx9Pl713yusdkBow/hZ7i0pBeqqbBqueBKMhkJ
	obOnWaxA+SIsDc51o/sfGiN6yJqQ4fCmNJfeggxlKqg6NVsYKPpVV84OgqQbCOb0DAML/ou+Yyyvb
	Gqtn2kvpjrS2ZiN4ogew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRlR-0002b6-6N; Tue, 29 Jan 2019 11:41:13 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRlN-0002aJ-1N
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:41:10 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so8624938pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 03:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cccfJl9Yc0L0qRnzWua5tXGobqFb6IhHlvnZcdwNS8Q=;
 b=YNH8vrxKsEdG3cLnC8omp/yGB11L5hUGppMe3vbkRwC0QyZ6dTFMJqjAoh62N0+IaF
 9DZbxSdn1NievwE86EQ17W15hvoWYShqXYm/c4dowC1vPFkbAfjhIOtmOn33kWfQUryL
 PM1Zbu5Y08/BbCjKY3Ao0N4aqyVz47xeCq8+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cccfJl9Yc0L0qRnzWua5tXGobqFb6IhHlvnZcdwNS8Q=;
 b=tMN6K+KsUbnN0QcO+EIRwvwH8crSPVr3yzqgQvEWR/hURVYrabtfq7lhBcJA2TSDi0
 qXhv3miGz9b/VKwyvMd1AF/PohEq3YWat8JBXwovD3wskKhHxcCxt0SU62W8x0/wcJQ6
 FdH2VNXVRBN6zF/ivQEqrIfXqb93IjpaibZsJKPbNQnQSl8CQ5j16GqWE2+cXkG/tixz
 4aaVuneSiEPVuH5NwO662qSqt8golrNMis3RP6BI+Ps9sO3FugLTaqTmjlRHybrUV7Cs
 mHBMhjQMm41gtSasJHBkmA47A8Q+5tg9k1ZkcuGTAj2e3WZvQp71S1qupwfzL+tR6M47
 Ujzg==
X-Gm-Message-State: AJcUukdIFx5z7DUzPB6JokRjM+Yat60Ma3qciXkjXU2Qsg4sLoyFBk8q
 gFPN52RCodM+iZX5/PqLaYkf
X-Google-Smtp-Source: ALg8bN5P5JWAwEldIA5r4ho4AS8cyaN+c9fU6WUtGMQZKopp/PSokSBChTRRyw92QfY2G6Zmp0UFJw==
X-Received: by 2002:a63:5621:: with SMTP id k33mr23623408pgb.395.1548762068078; 
 Tue, 29 Jan 2019 03:41:08 -0800 (PST)
Received: from Mani-XPS-13-9360 ([157.50.52.249])
 by smtp.gmail.com with ESMTPSA id x28sm63556576pge.66.2019.01.29.03.41.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 03:41:07 -0800 (PST)
Date: Tue, 29 Jan 2019 17:10:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rock960: Enable HDMI audio devices
Message-ID: <20190129114031.GA17014@Mani-XPS-13-9360>
References: <20190129113324.29440-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129113324.29440-1-ezequiel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_034109_077979_5A17B94D 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 08:33:24AM -0300, Ezequiel Garcia wrote:
> This commit enable the hdmi-sound and i2s2 devices needed
> to have audio over HDMI.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Since this patch affects both Rock960 and Ficus, it should be mentioned
in the description. Other than that,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index f04a31d48ba4..1bbf0b1f9374 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -94,6 +94,10 @@
>  	status = "okay";
>  };
>  
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	clock-frequency = <400000>;
>  	i2c-scl-rising-time-ns = <168>;
> @@ -336,6 +340,10 @@
>  	status = "okay";
>  };
>  
> +&i2s2 {
> +        status = "okay";
> +};
> +
>  &io_domains {
>  	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
>  	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
