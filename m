Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14456C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:56:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAE1214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ONL0Bw0O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VcT41kpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAE1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GKFJmEGdnHfdsM0KwN49yYyTJc1Gra0heS4Pqurqru4=; b=ONL0Bw0O1QwEAZ
	MXTDtEt8UHFHvHdGZ+lEQAuZWNUL2kkGonflaqOcjfydA8ibqv0VApiO3n5ZcZ02BU5Ck4741YhQ3
	P6f+7jqeHU/wajxgUE30nAjQud3C53W6si+qvLrZe+DLKXQRzJyZ4bWyWywhCeFaGM9BZfSEw/e6a
	VQAx7TdVhNvwXAI/hBr7USNdZzxPiBRtol4XszAxnpAu45Xcn7N+lBHD54EJg1iTHkDJycxcJ9fWX
	Hk+gA2qKyvWfz09Vz9c/0+piOhBaXnBkiAKhauUJ3njAlxB616MtV39bOvVB/MhfOavPdtEI3Rqyy
	5AEioxNql20FRnx9BjSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsmme-0008Fx-IE; Sun, 10 Feb 2019 10:56:24 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsmmZ-0008Ed-5S
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 10:56:22 +0000
Received: by mail-wm1-x342.google.com with SMTP id x10so6054506wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:cc:subject
 :references:in-reply-to:content-transfer-encoding;
 bh=7oY8y/5KEU9g0VhG2/ILsB0AuA8IxVBBUO9nvWk0KyM=;
 b=VcT41kpltmh5cgM3qum9dSbkysM0qJsdFOwCRuuKdUShepKgJe8A8QFyc7xeBlu2QM
 I/StkV7SJBB9I8d0J26JJhxt2/g9Nv5Se3SUBDE8i5W6ABe9B+5ry/23TMOGCpA5SxiS
 gAAuGinKXCOhGxzVMfPlEoMfA6si3s/+ZynSkfejcsdyXNP6e9dvRXaK64rsWWWrupjl
 FuuHUjaPIEEjwEzq1S5n9MRVX5Q3bpTHxuxT3JFgFckyMJgV4nA0RCQ2Lku/DFdHYqJ3
 4IRPUhUOVedSZCYYgE5IRMAHZOBlLKogD4B5/rKeHOidihoVFo9sFBI9QalAhdh59P61
 quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :cc:subject:references:in-reply-to:content-transfer-encoding;
 bh=7oY8y/5KEU9g0VhG2/ILsB0AuA8IxVBBUO9nvWk0KyM=;
 b=kv0u2bHmsDxJuo9YVxOoHG1rG42v5LDDDHUDz8ucwElrBUjJD7ELUrg4+3/y6CdXqC
 ge2zo/v/oluNWiDR02tpGVjCkOwvecn1kMQuzKWH0XUPTTjz8bspPhb3M7+qp9TRGRUb
 gh/50Z2i1FoZcb9Cl/rxVBOj1nzVLN7e4UcEOwSVQV5vZ92E3WoBCIXP7xJdxIeA47qu
 CYV7ifCOBaGVrEtEzNNDXSJYdg3TedCDQ9qdpAZItkg+BHhlb5GJezvicgOdcTE/TQ4F
 0ZQ0uv5MZE1NA1+VFCW4IlFpDyfI0P0kc7AumSxNSc+ChuKkqrFkHrjSYlmB3HKfIDkA
 Ya/A==
X-Gm-Message-State: AHQUAubqeSq6rpLfgDeKBPQAH7jbeVWvREs4W+7HBcEubopWzqzeR6/I
 1KE4Ukxxmhaxi44/VK5KtagO4Q==
X-Google-Smtp-Source: AHgI3Ia1Q1G98suQPYDhp2Vh6c9gUzIZxf6fP47l91UticAb0del3vUR4PibMIt43379ARmIXmSYjQ==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr5954495wmf.32.1549796175600; 
 Sun, 10 Feb 2019 02:56:15 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local (176-150-251-154.abo.bbox.fr.
 [176.150.251.154])
 by smtp.gmail.com with ESMTPSA id q21sm11054636wmc.14.2019.02.10.02.56.14
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 10 Feb 2019 02:56:15 -0800 (PST)
Message-ID: <5C60034E.5030706@baylibre.com>
Date: Sun, 10 Feb 2019 11:56:14 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Stijn Tintel <stijn@linux-ipv6.be>, khilman@baylibre.com
Subject: Re: [PATCH] arm64: dts: meson-gxbb-odroidc2: enable I2C bus B
References: <20190209155005.18458-1-stijn@linux-ipv6.be>
In-Reply-To: <20190209155005.18458-1-stijn@linux-ipv6.be>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_025619_275581_7759A862 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Le 09/02/2019 16:50, Stijn Tintel a =E9crit :
> The ODROID C2 has 2 I2C buses, so enable both of them.

Thanks for the change, but this I2C bus is on the 40-pin header,
until we have a way to add support for HATs/CAPEs/<whatever hooks on the he=
ader>
upstream, we prefer not enabling any functions on these pins by default.

You can, if you want add support for most functions, but "disabled" with a
proper description of pins used by these functions.

You can also maintain a set of overlay files like it's done for the
libretech-cc boards https://github.com/libre-computer-project/libretech-ove=
rlays/tree/for-4.13.y/overlays
and use them with the Armbian mainline based latest image for example.

Neil

> =

> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/a=
rm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 1cc9dc68ef00..ee666471a580 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -180,6 +180,12 @@
>  	pinctrl-names =3D "default";
>  };
>  =

> +&i2c_B {
> +	status =3D "okay";
> +	pinctrl-0 =3D <&i2c_b_pins>;
> +	pinctrl-names =3D "default";
> +};
> +
>  &ir {
>  	status =3D "okay";
>  	pinctrl-0 =3D <&remote_input_ao_pins>;
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
