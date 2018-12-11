Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:22:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086032081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xwfx5Co8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v3ovfyFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086032081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1yERoP+l4s/4cGmvqadRKOOTdUoc+7V7bnX/8BvA2Fc=; b=Xwfx5Co8zrFz4H
	dLexOUCEnKTHktJRcm5+1tHHsoP9Ux63Azgh4o4DuCZD6M/ZdAoBg1wTGYyFjYbKR1myeAUaN2DvA
	3barqI6Y94mToIilz59DPlU6GQ9VpBWXwSq2oT4klc8kVG33XoG4BemFKZuAgYnVql8gHxmV7SiFr
	3xc43aoH7pwegw4f/WjKCdrzxDEOid7UHlRU/dLj1DgJqUd/81VP5LHYFKlGq08HErtL7Yqj5qmpX
	9mvGbNkJ0kEiW+Cp9Az5VoFNs80hGUtUxzo5BFSQN/J8g3HD1ENozimwqy3wLSdjZzyGnBqTza0uK
	COxh5hRZRHcdQwZXW8FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeEo-0000AE-OQ; Tue, 11 Dec 2018 09:21:58 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeEl-00008x-5e
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 09:21:57 +0000
Received: by mail-wr1-x443.google.com with SMTP id z5so13235459wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 01:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=878CJNjtv0XVmAZsWgH1V3l3wUno7klI+xSj/SBjgHY=;
 b=v3ovfyFUz3FfFDO/IzWSfU28RFe03amkM0cfwbzKnbxqX0LRE8iooCUm1hXu27fFDO
 XplwcPhxQnKOuY9sh5fjOgIS8cc93nNisjiSV9MjbJwSCF8l4SZSWveEdm4u6abTSg/E
 26QHURbYnBGaygtXxlfzpO3yJFsw/apExq27Opd/AHj3laa5DmBvPV9yjgCa1H/SjKt2
 qvFh47V2u1uwFT+jLycbKjkIppaiUKmyaxf9ZzWe5Kez943OIxAF7sSE++Gf/qmfZtgB
 t+zVR8vvn3fDgLUvNhHcSDPP++kXBMJVVtXv1o4Rc9iw7qQGfSO2CkwNXmnINFt2YLw1
 kTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=878CJNjtv0XVmAZsWgH1V3l3wUno7klI+xSj/SBjgHY=;
 b=nQBJLz/1GOs9YGF+6YnfCLPxr9CGWs+gEoLDb16Cs8bEbAx3wViXDGXTJqRS0WnEgl
 bTNM4LlcqFNoyk7D77fQUcYG1Bhd2TTvzNai7uIccLsblnUEMUczqhK3hJ1m5yFmmQQR
 Si19P8TeUPH2I+DEUkJgg5U1sEPfoCcN54ZhzAf1aK28k0wPrN2yO9YM8BIqjN4vzo4P
 kXd+ZzWHRCxMhS2b0qEfKgj8YRwmV3tsOrAkxjZVJZtNDff50t6K58oGVp8F63IqYZrK
 1uAuRm0wUwyt4Bm5LeiA1UI/8suw46spilRw/Uk33uArYOOzpTupjJ5de0waTc6ZLeff
 sFrA==
X-Gm-Message-State: AA+aEWYcg79kkXvK7Ex0Lp6hHel02teiRI+XVOqeU2ZdBHX+A2FMM61V
 HprdUECGP6FnasAEB7Gya+Rp7A==
X-Google-Smtp-Source: AFSGD/WStqXt2Biz3FtAo56pLJW3fTPsd9tYzzWmPMiQ1lBu5ySPUIe8hOcn42/yLkIVOCgD7l/7oQ==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr12055066wrt.209.1544520102202; 
 Tue, 11 Dec 2018 01:21:42 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157?
 ([2a01:cb1d:4ce:ea00:a5f8:3197:dbfa:c157])
 by smtp.gmail.com with ESMTPSA id n127sm1323150wmd.20.2018.12.11.01.21.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 01:21:41 -0800 (PST)
Subject: Re: [PATCH 3/5] clk: meson: meson8b: add the GPU clock tree
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jbrunet@baylibre.com, khilman@baylibre.com, robh+dt@kernel.org
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
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
Message-ID: <7345cb90-b63d-5461-d97c-89ef563dc421@baylibre.com>
Date: Tue, 11 Dec 2018 10:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208171247.22238-4-martin.blumenstingl@googlemail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_012155_239596_D2F66420 
X-CRM114-Status: GOOD (  24.36  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/12/2018 18:12, Martin Blumenstingl wrote:
> Add the GPU clock tree on Meson8, Meson8b and Meson8m2.
> 
> The GPU clock tree on Meson8b and Meson8m2 is almost identical to the
> one one GXBB:
> - there's a glitch-free mux at HHI_MALI_CLK_CNTL[31]
> - there are two identical parents for this mux: mali_0 and mali_1, each
>   with a gate, divider and mux
> - the parents of mali_0_sel and mali_1_sel are identical to GXBB except
>   there's no GP0_PLL on these 32-bit SoCs
> 
> Meson8 is different because it does not have the glitch-free mux.
> Instead if only has the mali_0 clock tree. The parents of mali_0_sel are
> identical to the ones on Meson8b and Meson8m2.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 146 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/meson8b.h |   9 ++-
>  2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 0b9353d8d4fd..748552c5f6c8 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -1573,6 +1573,135 @@ static struct clk_regmap meson8b_hdmi_sys = {
>  	},
>  };
>  
> +/*
> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
> + * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
> + * has mali_0 and no glitch-free mux.
> + */
> +static const char * const meson8b_mali_0_1_parent_names[] = {
> +	"xtal", "mpll2", "mpll1", "fclk_div7", "fclk_div4", "fclk_div3",
> +	"fclk_div5"
> +};
> +
> +static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
> +
> +static struct clk_regmap meson8b_mali_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.table = meson8b_mali_0_1_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = meson8b_mali_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> +		/*
> +		 * Don't propagate rate changes up because the only changeable
> +		 * parents are mpll1 and mpll2 but we need those for audio and
> +		 * RGMII (Ethernet). We don't want to change the audio or
> +		 * Ethernet clocks when setting the GPU frequency.
> +		 */
> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "mali_0_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "mali_0_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 25,
> +		.table = meson8b_mali_0_1_mux_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = meson8b_mali_0_1_parent_names,
> +		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_names),
> +		/*
> +		 * Don't propagate rate changes up because the only changeable
> +		 * parents are mpll1 and mpll2 but we need those for audio and
> +		 * RGMII (Ethernet). We don't want to change the audio or
> +		 * Ethernet clocks when setting the GPU frequency.
> +		 */
> +		.flags = 0,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "mali_1_sel" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "mali_1_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap meson8b_mali = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MALI_CLK_CNTL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mali",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "mali_0", "mali_1" },
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  /* Everything Else (EE) domain gates */
>  
>  static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
> @@ -1833,6 +1962,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
>  		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
>  		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
>  		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
> +		[CLKID_MALI]		    = &meson8b_mali_0.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2012,6 +2144,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
>  		[CLKID_HDMI_SYS_SEL]	    = &meson8b_hdmi_sys_sel.hw,
>  		[CLKID_HDMI_SYS_DIV]	    = &meson8b_hdmi_sys_div.hw,
>  		[CLKID_HDMI_SYS]	    = &meson8b_hdmi_sys.hw,
> +		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
> +		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
> +		[CLKID_MALI_0]		    = &meson8b_mali_0.hw,
> +		[CLKID_MALI_1_SEL]	    = &meson8b_mali_1_sel.hw,
> +		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
> +		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
> +		[CLKID_MALI]		    = &meson8b_mali.hw,
>  		[CLK_NR_CLKS]		    = NULL,
>  	},
>  	.num = CLK_NR_CLKS,
> @@ -2167,6 +2306,13 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  	&meson8b_hdmi_sys_sel,
>  	&meson8b_hdmi_sys_div,
>  	&meson8b_hdmi_sys,
> +	&meson8b_mali_0_sel,
> +	&meson8b_mali_0_div,
> +	&meson8b_mali_0,
> +	&meson8b_mali_1_sel,
> +	&meson8b_mali_1_div,
> +	&meson8b_mali_1,
> +	&meson8b_mali,
>  };
>  
>  static const struct meson8b_clk_reset_line {
> diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
> index 87fba739af81..f212e2304ff5 100644
> --- a/drivers/clk/meson/meson8b.h
> +++ b/drivers/clk/meson/meson8b.h
> @@ -33,6 +33,7 @@
>  #define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
>  #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
>  #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
> +#define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
>  #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
>  #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
>  #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
> @@ -139,8 +140,14 @@
>  #define CLKID_HDMI_SYS_SEL	172
>  #define CLKID_HDMI_SYS_DIV	173
>  #define CLKID_HDMI_SYS		174
> +#define CLKID_MALI_0_SEL	175
> +#define CLKID_MALI_0_DIV	176
> +#define CLKID_MALI_0		177
> +#define CLKID_MALI_1_SEL	178
> +#define CLKID_MALI_1_DIV	179
> +#define CLKID_MALI_1		180
>  
> -#define CLK_NR_CLKS		175
> +#define CLK_NR_CLKS		181
>  
>  /*
>   * include the CLKID and RESETID that have
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Changing mali clock for Meson8 will be fun aswell !
How amlogic does that ? the only change the divider ?

Neil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
