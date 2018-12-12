Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:54:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B554B20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1TbGkZO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qud3ht8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B554B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJEt+d5qzmK/OUVk+P0jnFaMJ41VYIofnqgJ8IM7f6E=; b=N1TbGkZOodzLou
	HboY45Ngdzx+ZnY0KphLipFFd3HjJ+HPjQtk9Zkx3XqtkDMhkcQ3e9oMhLZLO9+5lSbnUfzCrSTou
	FZZS0L7zAmYbD5xdPHXfJrRb5sVbQRvwIi6hdn1OIzxv95XR2KdHC1CMiwmXxJ45P/2OY71H/K4wE
	qmBY+xqtHXRyFJvvE9GFqwkIwjhTepf634B2HzcdpWNVyRLE9AQ3Uhy5GBzyC9bHVNjWIHuVlfh8g
	wXaWN2PHNUoO4MDidSIgyFMRj8ldHDYzs0+pN5k2Jawm20s4UnKR9HsnBxm0IHsbeWtjdhLVAtxj0
	W6LQ/iE+pfy9TaBtj4Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1EE-0005dt-J8; Wed, 12 Dec 2018 09:54:54 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1EC-0005dA-17
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:54:53 +0000
Received: by mail-wr1-x442.google.com with SMTP id u3so17023200wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h/m0FZIWNOV8tUvSeWhhcjoJa1KInlMDOjc+EJLHDAg=;
 b=Qud3ht8FIPf8unU0JCuJwzUwlnecTEGX4LWqTCavLabkLn54yqjP2gAynKby/ikTNJ
 tAWl8qKAuQ190Js5lKn0LWiEmn+8id+kLrGv/uFwcD+bkMU4kLjjvEvqaJXy7FgL+SBj
 Z245HKa5u2Ehy/4vgcDbFzpocU3P2cjNQb0DDN5UoceX9pvFlXyTy4PnOpDXEP07l5gK
 igZlbKVWD1iA2PUl3kj3bEf4SRIdFEJmvj0X6evuLaVmxeaG/NfOJ28OcfFADN9EW9kZ
 CJCh7cdyeqBudp4G3Uy3vKHb/yzGUDYrzihNqyacYOIi7RaqDa/fcFGxxrHJlV5zVU78
 iviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h/m0FZIWNOV8tUvSeWhhcjoJa1KInlMDOjc+EJLHDAg=;
 b=gsJW8naJbEOspqgbc0Oz/R33wXAsgDtCkj3Ev8wRKatpuAk7Wl+qlT+fz2R/VY1XUL
 KW5NIybKyot32PCrP0J57K1ZeWPdrlhJ7A5P9pRUi3hChRTve4589MRhggTh0Pp1G1z1
 NdYgnigl/FyBPd0w2hPPNolOoIu/kuRqYDN6cVhV8dEEn0iCQduO1cAcTzCgxYce5Rqu
 8wUKgl8/0vsRZhi7I//rBOV38/p6N3CxDLTZ8z4Op4pV+DF61uE7CmhAXJZK7lbS6v1s
 Jc8seZGCFSWZc5OVP/Bx58yRRkliIukTxPODhNyBUPBpu9LqABo7jvxP2TM8P1503QMN
 Xy0A==
X-Gm-Message-State: AA+aEWZMgDrR/FrzXOVOQp/Q/1m30lm34uORuc6oRX+uo2dbM6YGWzKs
 KAzJ+KXBIe7ISeNZbiIRetZ466iLCe+DSQ==
X-Google-Smtp-Source: AFSGD/UT1ZZmbZUAczMhriMiWF5qO1+/JsP5IJJFL9aR8cPg4oGDLJ0A73LMY4fab/R01Ys8GZiBXA==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr15865668wrg.325.1544608480497; 
 Wed, 12 Dec 2018 01:54:40 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id h62sm2082935wmf.11.2018.12.12.01.54.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 01:54:39 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
To: Maxime Jourdan <mjourdan@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
References: <20181210090640.4495-1-mjourdan@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <434d1dc0-3c5e-5cb3-cc88-b565bfb74217@baylibre.com>
Date: Wed, 12 Dec 2018 10:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210090640.4495-1-mjourdan@baylibre.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_015452_070653_45FB2542 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On 10/12/2018 10:06, Maxime Jourdan wrote:
> Similar to simple-framebuffer-sunxi, we support different display pipelines
> that the firmware is free to choose from.
> 
> This documents the "amlogic,simple-framebuffer" compatible and the
> "amlogic,pipeline" extension.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> new file mode 100644
> index 000000000000..122a5c005cd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> @@ -0,0 +1,33 @@
> +Meson specific Simple Framebuffer bindings
> +
> +This binding documents meson specific extensions to the simple-framebuffer
> +bindings. The meson simplefb u-boot code relies on the devicetree containing
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node based
> +on which pipeline is being used. As such they are solely intended for
> +firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "amlogic,simple-framebuffer"
> +- amlogic,pipeline, one of:
> +  "vpu-cvbs"
> +  "vpu-hdmi"
> +
> +Example:
> +
> +chosen {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;
> +
> +	framebuffer@0 {
> +		compatible = "amlogic,simple-framebuffer",
> +			     "simple-framebuffer";
> +		amlogic,pipeline = "vpu-hdmi";
> +		clocks = <&clkc CLKID_HDMI_PCLK>,
> +			 <&clkc CLKID_CLK81>,
> +			 <&clkc CLKID_GCLK_VENCI_INT0>;
> +		power-domains = <&pwrc_vpu>;
> +	};
> +};
> 

You should add a cover-letter for this patchset !

Neil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
