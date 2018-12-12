Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:55:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9DD20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bqUDr3d6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mx0joKnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9DD20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P2HVwpEJogBbelm2k0davpHxLLNQdrBUO77gDlflYoo=; b=bqUDr3d64CxMBI
	4ygFCrbK3xjqplIgJR3cjBHNzr1anA6dyqCHsUG/r01YlMbytaf9n731gdmxuXD2qIeDkGcNY4+6y
	vjFUIIB5bIrcQlK3TCGRX4FXFB4K6DLW9AhJytRN2N/EXBCu+SL4Em91l6ttKOoXUOQEgNMS/PXhl
	b1UUMzSvyu+KHzCDdVPl6oURakvBzq47AFDJzuJt+9qoo6xcXRYevnOCuza2pejDBFNCYPl4xTGWE
	mn1ZabBew7MEYh/vD8Us1bxsdFAKpT/FAwfKB0Dv4gky4sFpPTMbD/yK+IXyC21IK14K/WVzy+2oW
	eqdWTaFMLXlUCWqVKH4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1F8-0007Bf-MM; Wed, 12 Dec 2018 09:55:50 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1F4-0007AI-Kt
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:55:48 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so16949845wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yz4APOAv/5rPDI+5AhAgwhPWaSULeQZqxdonoNl29f4=;
 b=Mx0joKndQwtDwDEfAuHS2RtHTWDa7j6fKOMAM5OEdHU5ZmqBj21u+3f7yswkeIrjMe
 XvyXDSXNjeT/sqQ5EiOEESHllu9b+E9HZ4PD/AJB7JASnPcosDtgphh0nTdK+pxVyK1k
 HwRsI9RbNJmnSoHzRXduOA6BkQ6yEeh0FApdnHsPkz2Qm2n54L643pjDyOX5h/NHl664
 WptP43ACLPo4BFazlIBJCxDE4SpwQSoHmpf6zFlkL2fIoK+0wwSXbA9PIP4/3yYYv+9J
 XQrEQRvMRne60Cn8w2Gfc21st9ZQ4AOdTi4jLxsyTHaYDiFiis4ICNTjH/92d89S3HYX
 P8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yz4APOAv/5rPDI+5AhAgwhPWaSULeQZqxdonoNl29f4=;
 b=bOjbGTByHNA6EdT0euFr48ctSH9raFwnPkB0UWOJ7qbm4oLJpnKEfh9FopSCbU5L3P
 OwVAlq/hTkX7QDHdxVnxSP46k9lWPysOPm2UX5aAtXhxScLYzh7WPhq21/L1LsdKzjYX
 SKCwylHSVjr2FF/0/xSyPmpX+pkP3moQUSW6/5Ci58LujBB6h2zcPKPg+n2AgiBTRHtk
 KqOIUq5IBMIrGkEnORveV/yMnU8XkXTS0lez+k3XsrPscw7u84bzjaGtJ87XP3wJLESj
 g9dXNagLoNXILxhtZGZQSFpb/xjjxWR3nnj52dO4DTKLOUt5rlJhAZZibpGrC1u1i3Wg
 cjGQ==
X-Gm-Message-State: AA+aEWbV52kH1Z3ymFupySsYS39bO13nSrXIPJT/OGX+Fx4uAJyWXKgr
 jtYasX78LGHXpS8Qo+KTiUlicg==
X-Google-Smtp-Source: AFSGD/XEWHyYKdLFjz+oxQxXo0j3xPeuZ5eN+nnEDGi8J5+uEQU80CYw5w0bhRokd7YMhfM3dAlKDg==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr17191261wrc.168.1544608535035; 
 Wed, 12 Dec 2018 01:55:35 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id d4sm1718525wmb.25.2018.12.12.01.55.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 01:55:34 -0800 (PST)
Subject: Re: [PATCH RESEND] drm/meson: remove firmware framebuffers
To: Maxime Jourdan <mjourdan@baylibre.com>
References: <20181210092853.13050-1-mjourdan@baylibre.com>
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
Message-ID: <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
Date: Wed, 12 Dec 2018 10:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210092853.13050-1-mjourdan@baylibre.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_015546_686450_F7A19DCC 
X-CRM114-Status: GOOD (  19.10  )
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
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On 10/12/2018 10:28, Maxime Jourdan wrote:
> In case we are using simplefb or another conflicting framebuffer, make
> the call to drm_fb_helper_remove_conflicting_framebuffers()
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index d3443125e661..afbb3d707d15 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
>  	writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>  }
>  
> +static void meson_remove_framebuffers(void)
> +{
> +	struct apertures_struct *ap;
> +
> +	ap = alloc_apertures(1);
> +	if (!ap)
> +		return;
> +
> +	/* The framebuffer can be located anywhere in RAM */
> +	ap->ranges[0].base = 0;
> +	ap->ranges[0].size = ~0;
> +
> +	drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
> +						      false);

I always wondered, where does the "meson-drm-fb" comes from ???

Neil

> +	kfree(ap);
> +}
> +
>  static int meson_drv_bind_master(struct device *dev, bool has_components)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -242,6 +259,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	if (ret)
>  		goto free_drm;
>  
> +	/* Remove early framebuffers (ie. simplefb) */
> +	meson_remove_framebuffers();
> +
>  	drm_mode_config_init(drm);
>  	drm->mode_config.max_width = 3840;
>  	drm->mode_config.max_height = 2160;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
