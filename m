Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CBC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB47B2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BsFmLWsS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LqqWYsgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB47B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SFaAf48y+9wX5y346uQ1Na0aNwvxCJQzlwmf4dLmKFM=; b=BsFmLWsSS5FeP2
	E7qbqxIqwnJBp/uu0tDqU5u+lfyma+I0FxBX2rivD4JLMtsSzjYgq+tE6lSgdbh9YKBJzrfrO1zYO
	SCdo+xgnr7RhCY45I5Dd9+QUgtuNAP3C1ynLtSSWKvgAbjwfKvC3cjj1iTVyS2SHEXJXr3tO8Tg+X
	uIHOedSY+hMHiZV4NUtMmve6A6xr3hp95iiGJQI8NPVP8LcFCw9/DP3+jFgH1wFETQMAU7fOkqCpV
	jtWf5cnUTQchdhgMQfEU6ytRly56MshOP7UnpQGUIDTanRC1wSRndeSjJ28QOIN0OfcFn4XZILTrQ
	pMrD/aeH1Ct0tmmX5q4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYsa-0004az-SY; Wed, 05 Dec 2018 15:14:24 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYsS-0004LI-1L
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:14:20 +0000
Received: by mail-wm1-x336.google.com with SMTP id m22so13314656wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ljcqs7yAxvm9zxsr/4+UyGQapn8ojy0roh1D/FlDWug=;
 b=LqqWYsgHqGRtGOvehHRFCdsdiEhWdbUbZFkkR/BdTeq0kjsRqxjXIW41tulTOM1XVZ
 xa1Y2DKZ85huH4+d2447jQskpbGQlMvatZXy623FfCMgjcoYOdnwLRBu5Rp1aDmGc48n
 G1D5fhbeQNCkqP9RR3Em8GuyaPuBN4mwVme46nqF3HQmv1blzHGCeAjwnyp9aArf1MCt
 7eN45TCe7CAFMdpUUAQDu8ORTkCTFqlpUkDoftCBPLMA3dmmQDwBzh0x84Mgr7++9QQz
 zvgQW5PWj/jcbC19vCSHMank29AR2pPb6WmgUG6VuKg/PN1cJC+lnUuYxs2XD9cFviaU
 V4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Ljcqs7yAxvm9zxsr/4+UyGQapn8ojy0roh1D/FlDWug=;
 b=WsjwYV2rZwIQNoMUccMLn4u2qmsrzya1A9/DXRJyYnQMQMeyio97GHA/EnWzlozUlT
 ftOtvhhJgE/BxEz9uy/2WJhn+YD4k2EKx8SPUwHPabq1Q5TE2CvOil3Qah1YLQkB5e00
 sEOcWhkc26eiB8dfTcnwHU8oZepUkzPdmJaVtTRwfWGQpJRpZufKXE9WY09z81/M9zkS
 dNlFRJIEisXyvZSBltUD2ASydH2Rk4btKKqSI0iBTFX5jUxqqB33+/a5i+1lfTvUdfMZ
 s/7dXaZwe8wugnB31tdfXl7XovUZ/kzQO8rMhEZrSYTQ/RGxz6FCTwFu2LV+Z+hTMaH3
 Vz+Q==
X-Gm-Message-State: AA+aEWaaXEYDaOHAxLaXWYDbhb095aZ6hz8oYZggocZqm2rlc+0lqq+n
 3vUUZb8gooMEV10BQQ+g+Qp8xw==
X-Google-Smtp-Source: AFSGD/UGpF13B/emPTA1Pv4G+e1hc6mtrTKLsokTdmHyd1sEfJk2160WMDlPjRcKOwX2IK2iL+sUqA==
X-Received: by 2002:a1c:1d4f:: with SMTP id d76mr15963476wmd.98.1544022843683; 
 Wed, 05 Dec 2018 07:14:03 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67?
 ([2a01:cb1d:4ce:ea00:819f:4d34:9af9:e67])
 by smtp.gmail.com with ESMTPSA id r3sm20593148wrs.78.2018.12.05.07.14.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 07:14:03 -0800 (PST)
Subject: Re: Moving ARM dts files
To: Rob Herring <robh@kernel.org>, arm@kernel.org
References: <20181204183649.GA5716@bogus>
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
Message-ID: <a2178561-ca34-438b-89c3-278b26e194d9@baylibre.com>
Date: Wed, 5 Dec 2018 16:14:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204183649.GA5716@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_071416_363803_8AEE159E 
X-CRM114-Status: GOOD (  25.40  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/12/2018 19:36, Rob Herring wrote:
> Olof, Arnd,
> 
> I've put together a script to move the dts files and update the 
> makefiles. It doesn't handle files not following a common prefix which 
> isn't many and some includes within the dts files will need some fixups 
> by hand.
> 
> MAINTAINERS will also need updating.
> 
> A few questions:
> 
> Do we want to move absolutely everything to subdirs? There's quite a 
> few platforms with only 1-2 platforms. I haven't added these to the 
> list yet, but can.
> 
> Do any vendors need another level of directories? davinci, omap, nspire, 
> etc. for TI for example.
> 
> What to do with armv7m.dtsi? I guess it should remain and we just fixup 
> the include. There may be a few other cross vendor things.
> 
> 
> Sub-arch maintainers, 
> 'vendor_map' below is the mapping of file prefix to new subdirectory 
> (the SoC vendor prefix). Please comment if there are any issues.
> 
> Rob
> 
> 8<-----------------------------------------------------------
> #!/usr/bin/env python3
> 
> import os
> import re
> from git import Git
> import glob
> 
> vendor_map = {
>     'imx': 'fsl',
>     'ls': 'fsl',
>     'vf': 'fsl',
>     'qcom': 'qcom',
>     'am3' : 'ti',
>     'am4' : 'ti',
>     'am5' : 'ti',
>     'da' : 'ti',
>     'dm' : 'ti',
>     'dra' : 'ti',
>     'keystone' : 'ti',
>     'omap' : 'ti',
>     'nspire' : 'ti',
>     'armada' : 'marvell',
>     'berlin' : 'marvell',
>     'dove' : 'marvell',
>     'kirkwood' : 'marvell',
>     'orion' : 'marvell',
>     'pxa' : 'marvell',
>     'mvebu' : 'marvell',
>     'mmp2' : 'marvell',
>     'arm-' : 'arm',
>     'integ' : 'arm',
>     've' : 'arm',
>     'aspeed' : 'aspeed',
>     'at91' : 'atmel',
>     'sama' : 'atmel',
>     'bcm' : 'brcm',
>     'exynos' : 'samsung',
>     's3c' : 'samsung',
>     's5p' : 'samsung',
>     'gemini' : 'cortina',
>     'hi3' : 'hisilicon',
>     'hip' : 'hisilicon',
>     'hisi' : 'hisilicon',
>     'mt' : 'mediatek',
>     'meson' : 'amlogic',
>     'owl' : 'actions',
>     'r7' : 'renesas',
>     'r8' : 'renesas',
>     'r9' : 'renesas',
>     'rk' : 'rockchip',
>     'socfpga' : 'altera',
>     'st' : 'st',
>     'spear' : 'st',
>     'sun' : 'allwinner',
>     'tegra' : 'nvidia',
>     'zynq' : 'xilinx',
>     'wm' : 'wm',
>     'uniph' : 'socionext',
>     'zx' : 'zte',
      'ox8' : 'oxsemi',


I volunteer as a tribute !

This is a low-priority platform, you can move them in a separate directory if you want.

Neil


> }
> 
> if __name__ == "__main__":
>     g = Git('.')
> 
>     g.checkout("HEAD", "arch/arm/boot/dts/Makefile")
>     dts_make = open("arch/arm/boot/dts/Makefile", "r").read()
> 
>     # make entries 1 line
>     make2 = re.sub(r'\\\n', '', dts_make)
> 
>     for k,v in vendor_map.items():
>         for f in glob.iglob("arch/arm/boot/dts/" + k + "*.*"):
>             new_dir = "arch/arm/boot/dts/" + v + "/"
>             base = os.path.splitext(os.path.basename(f))[0]
> 
>             os.makedirs(new_dir, exist_ok=True)
>             g.mv(f, new_dir)
> 
>             # Remove the file from the makefile
>             dts_make = re.sub('.*' + base + r'\.dtb.*\\\n', '', dts_make)
>             dts_make = re.sub('.*' + base + r'\.dtb', '', dts_make)
> 
>             # extract the matching makefile entry
>             reg = re.search(r'.*' + base + r'.*', make2)
>             if not reg:
>                 continue
> 
>             entry = reg.group(0)
>             make2 = re.sub(r'.*' + base + r'.*', '', make2)
>             if entry:
>                 makefile = open(new_dir + 'Makefile', 'a+')
>                 print(entry, file=makefile)
>                 makefile.close()
> 
> 
>     for d in sorted(glob.iglob("arch/arm/boot/dts/*/")):
>         dts_make += 'subdir-y += ' + d.split(os.path.sep)[-2] + '\n'
> 
>         # Add license and sort entries of sub-dir makefile
>         vendor_make = '# SPDX-License-Identifier: GPL-2.0\n'
>         make_lines = open(d + 'Makefile', 'r').readlines()
>         for l in sorted(make_lines):
>             vendor_make += l
> 
>         vendor_make = re.sub(r'\t', r'\\\n\t', vendor_make)
> 
>         f = open(d + 'Makefile', 'w')
>         f.write(vendor_make)
>         f.close()
>         g.add(d + 'Makefile')
> 
>     # Remove entries with no dtbs left
>     dts_make = re.sub(r'.*\+= \\\n\n', '', dts_make)
> 
>     open("arch/arm/boot/dts/Makefile", "w").write(dts_make)
>     g.add("arch/arm/boot/dts/Makefile")
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
