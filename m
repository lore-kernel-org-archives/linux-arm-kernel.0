Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:33:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341AB2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CmsuSI1+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aZ/0i7WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341AB2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ch0oHA2B+Vdtk+pA2IDfys4d79QLgYLA0/uWMOAwdKg=; b=CmsuSI1+dXEA8Z
	pBgW+Eq877MHeLf7IIO0frylRPJGWciZuqdB+8UU1P9mwOH9/Q6pPClHARfJnefsp5IFqMuSldx5e
	C639RXiZgAyRw7ckRZnK6KCN9juXmb1ClOjQMlT+SIbAYWA5hE1MjcWR8e+IDcOJm3V2JDZK1Xrxd
	COhXs7zGu4dNfmJBrtz24o71qCeoFfYCDmJDqWGI9bdbWmhdgcuQdBLZFvSye2RC/5z3s32mEP+8U
	RVNhFrOcuPUT/zjIFZA3F7Cxo/OKmMHCtteZijSN0AFwKmLgUN/6SyI30ny25XV+jKUX5rxU206tq
	pRANMObTdRbqVcpEU/YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU68V-00016E-Ka; Tue, 04 Dec 2018 08:32:55 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU67Y-0008V1-DF
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:32:03 +0000
Received: by mail-wm1-x342.google.com with SMTP id a18so8366041wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7ZatcExTkGNvL1QAPOgoPHhFY0vtvF3cG5gZrC9GwTM=;
 b=aZ/0i7WPT1rdSbDqkyeucTFQvSTqk8/y43LW9DDpLnKjY5rvsGn5sFEM+pkZWXq5UG
 8y7NcoIVdx0jmYLvSc4w/LKJboZJJ0XlFwkPP+ioCspIAQ6Kzf9MAwHzg8BJZkGEg0ip
 7eS53efc0Yfe8bO70lrBCafqAD1F693bShLoRLli/ckuywgqhl1CHMqdTb+plSXsnURI
 7iw/kBMKp9XmJwvSwcfpOOiKYgSUKGijphEB9rCuymd2+AKrW6YyMuk6LddYLxPzIpMi
 xkT9vECiKuNiEP9JhqtZrnjIs6ATQoHh5aN5QmuLvEm2GHQ283KG0j0v/70G+VLcxair
 050g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7ZatcExTkGNvL1QAPOgoPHhFY0vtvF3cG5gZrC9GwTM=;
 b=MZWYUGQTx/iWm6USkCsjO/avXkmhvPQn3tMDQ6vNCMYvwaTcVpdzrft3ae18MluVlO
 G/V4gYIz/MbduMZ3V+9kker2sHOwbUdBRB7mrF3rxluIt+pWdUyKYLp44NogNhOujWu5
 0th3aEeNH91gUd6ftpHh1cY5oV7ApGrMsg7k+HH9LtE5O3t4rgm84Z0RSie2YwpJITQg
 IsxhIGGZE1Rk4JEu5YYPLHcLGYMuS8DbeeOTfYws2ArDeBsMzDeuL2U7GQ/HhWFHF+rW
 ZsKW4LdkXKyQzbmMqoXzdS8TRR9iPAbT5IYYFe+6H8KVr+5v6JJ2l5E+gFWOCAGlU/mx
 a+zA==
X-Gm-Message-State: AA+aEWaQFBtApqUXoWhVguEK+G1Zw4jsc1HRBZPBDkRq21DqjiNW9B3r
 yTs1tY6Qw7poNmNvVtkb2h3MpO3Y4ZTswg==
X-Google-Smtp-Source: AFSGD/WB8pXeVn+ad5mtLI5YIVEupd0WL32xw60jaABdOmRQGXZFl+3VaWajL3xhFYNSbYQqv8dtzg==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr11432437wmi.10.1543912303915; 
 Tue, 04 Dec 2018 00:31:43 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id e16sm15192724wrn.72.2018.12.04.00.31.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 00:31:43 -0800 (PST)
Subject: Re: [PATCH v2 13/34] dt-bindings: arm: amlogic: Move 'amlogic,
 meson-gx-ao-secure' binding to its own file
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-14-robh@kernel.org>
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
Message-ID: <cd586e5a-d7c3-5fd9-5eb0-1903d5165806@baylibre.com>
Date: Tue, 4 Dec 2018 09:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203213223.16986-14-robh@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_003156_767960_CA63EABD 
X-CRM114-Status: GOOD (  19.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Kevin Hilman <khilman@baylibre.com>, linuxppc-dev@lists.ozlabs.org,
 Grant Likely <grant.likely@arm.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/12/2018 22:32, Rob Herring wrote:
> It is best practice to have 1 binding per file, so board level bindings
> should be separate for various misc SoC bindings.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/amlogic.txt       | 29 -------------------
>  .../amlogic/amlogic,meson-gx-ao-secure.txt    | 28 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 4498292b833d..f5c8d50a3506 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -107,32 +107,3 @@ Board compatible values (alphabetically, grouped by SoC):
>    - "amlogic,s400" (Meson axg a113d)
>  
>    - "amlogic,u200" (Meson g12a s905d2)
> -
> -Amlogic Meson Firmware registers Interface
> -------------------------------------------
> -
> -The Meson SoCs have a register bank with status and data shared with the
> -secure firmware.
> -
> -Required properties:
> - - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
> -
> -Properties should indentify components of this register interface :
> -
> -Meson GX SoC Information
> -------------------------
> -A firmware register encodes the SoC type, package and revision information on
> -the Meson GX SoCs.
> -If present, the following property should be added :
> -
> -Optional properties:
> -  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
> -
> -Example
> --------
> -
> -ao-secure@140 {
> -	compatible = "amlogic,meson-gx-ao-secure", "syscon";
> -	reg = <0x0 0x140 0x0 0x140>;
> -	amlogic,has-chip-id;
> -};
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> new file mode 100644
> index 000000000000..c67d9f48fb91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.txt
> @@ -0,0 +1,28 @@
> +Amlogic Meson Firmware registers Interface
> +------------------------------------------
> +
> +The Meson SoCs have a register bank with status and data shared with the
> +secure firmware.
> +
> +Required properties:
> + - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
> +
> +Properties should indentify components of this register interface :
> +
> +Meson GX SoC Information
> +------------------------
> +A firmware register encodes the SoC type, package and revision information on
> +the Meson GX SoCs.
> +If present, the following property should be added :
> +
> +Optional properties:
> +  - amlogic,has-chip-id: If present, the interface gives the current SoC version.
> +
> +Example
> +-------
> +
> +ao-secure@140 {
> +	compatible = "amlogic,meson-gx-ao-secure", "syscon";
> +	reg = <0x0 0x140 0x0 0x140>;
> +	amlogic,has-chip-id;
> +};
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
