Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805CD20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ilRIBk/S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXu3fhSj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="JaU/f3jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805CD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnVsyjIAk+BSsVY+/pRpsPJtH5MpVcd+ERxG+t4F4iE=; b=ilRIBk/StBVaZJ
	ZCQbBmhdYooZKiPp3qT8o9E5H3L4KO+VkcsfzsocryNWWpNlwmXEr9uI8IK1GxeT2It6ZYJU2LTfs
	CKJO3+jgfVCQ1kQoEf3U0V/gsSOqcOoRmJUnhhL3ulSSt09CiGdEsa6EYsZYh9XYVP1R+93RdUMbs
	AbuS+gJQCTDi2KdyM3ldbFnes2rYVpubRA5308guqzg20MOBSMsMzabuWIqmMu32GP6nBgM6IyYkB
	MRr9p1IVqMsRb0CzQ3AlH/xJ3dcL01phGbHPxPQH9NhRpbqov5n8Djw+yieJ+3mmZhroX3wVqF+18
	ZERnkmA1ybhhcr/zMvzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSshI-0004dz-Jl; Fri, 30 Nov 2018 23:59:48 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfC-0002mR-NW
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 23:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/LIti5JaXiYk9eZnUZP/hQ4JEfLycWoveHkxZsjO7ag=; b=FXu3fhSjWgB8AXZpVG31HX7XP
 5MaD39a0sqHBZmHOp2y+zh1H/7hTLEUva4c/8AQFSBih82v/0NftJlCx7slA4w+vSS2xDPw9cVsrI
 YMAkawKzlzoZXYVfCyK/iV7ozkfvxv+zu64MsAWOrYgjKkQnf6JbK5bYRj9To1nCvi4aiUwOoT8H5
 6eeVQSdbBJ5+LueipxKqjXWGAIX1dMsYME/zWoDWGFfpts5ycPTFprkTJqo+qpmDCccUOBwcqwRca
 1ldfnzT/Ck5TSuOMEaXI0udjeuHxjz5YGFaly9/cPjU/vDAbCpcGw6v3noDZwlpMTk3qrYTP4bf9Z
 bV2U/jssA==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfA-00089x-CK
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:37 +0000
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so6500688ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/LIti5JaXiYk9eZnUZP/hQ4JEfLycWoveHkxZsjO7ag=;
 b=JaU/f3jT+b9LAHM/0bXdVoEkZzcNDsPt7ZjdDCVXadi0T4cdrlycK3EmvtJs8fixZ/
 0EeAYcW8JEILPnAUCMQNpiJHXB0BiTo2rZn5NOIAIXWCtbab30hYutlqn4AxGRbBPDyU
 repkHpMyAPs/W8kX/ZNvbHqJnoHf6Mh3Fs8DDWzvilFWvoBOSBl4oiHMiY8rY5cfHErY
 dDbUtzehApXzPbKO98R9YPA4I49TAMTzFMswqzntuJRi+USbzr2QphiLChocHgxPj6he
 hVMXgRzBkHOIuNuE2qtssxZ+Y0jKH5TTo03H2EbgeOZqNTP7RsO84CljQZtPOBt1RK7s
 AxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/LIti5JaXiYk9eZnUZP/hQ4JEfLycWoveHkxZsjO7ag=;
 b=FfIXNDRsHt2FGZgagWjvcUFG7++zY3WDwKy31/bVn+jGV6dHz/doJs23wxwNcgwo0m
 4WqmOj8yN9AqcByrkRlp2NrTgAkVko9bsWvR2ldlOfVWuySKUBZCO6CSAmKDW18t4/WO
 HFzZrbkmftX7Qr8qi6YGvv+5F9IlkIsATaseF5gZ92t3jS+QjHOVhnzgdo/DW9vsuD8V
 S7MaNdbG8Y/pei+ilJNL6gJHWzJwk7/krNtFoxRL8lrBlX7u2k3VvEdDk+2N0VdKhgEo
 a4AO2BSCzQ9ifz2P0O0oEd2IIGFh2Q2KrBxJMG48UYea8vQVKvIGyAukIIrU4JMSTsyj
 7hbQ==
X-Gm-Message-State: AA+aEWZRyg9tJPmzTgb20A+o+fJ8yFJOjhSjHHnvgOjPiFMFyh4QdDsR
 cPOzwASDTktal++pWTge8MHLCw==
X-Google-Smtp-Source: AFSGD/X5AjmSzvJOS/CvRAeGcAhb9B4vhXj8/Gn0Xw+ZsPVu3ILE0jSZZJ5OUSXSAsdUBijaOf68Ow==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr4902095ljg.87.1543622243918; 
 Fri, 30 Nov 2018 15:57:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x16sm1041889lff.26.2018.11.30.15.57.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:22 -0800 (PST)
Date: Fri, 30 Nov 2018 15:46:52 -0800
From: Olof Johansson <olof@lixom.net>
To: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [GIT PULL] arm64: dts: hisilicon dts updates for v4.21
Message-ID: <20181130234652.dfv5onq3s4faweut@localhost>
References: <5C000B15.8010400@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5C000B15.8010400@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_185736_463920_7206EF31 
X-CRM114-Status: GOOD (  20.90  )
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
Cc: Tangkunshan <tangkunshan@huawei.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "arm@kernel.org" <arm@kernel.org>, Daode Huang <huangdaode@hisilicon.com>,
 "Chenxin \(Charles\)" <charles.chenxin@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Zhangyi ac <zhangyi.ac@huawei.com>, jinying@hisilicon.com,
 Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Salil Mehta <salil.mehta@huawei.com>, Guodong Xu <guodong.xu@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Leo Yan <leo.yan@linaro.org>, "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 Shiju Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 03:51:49PM +0000, Wei Xu wrote:
> Hi ARM-SoC team,
> 
> Please consider to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.21
> 
> for you to fetch changes up to 6ad5506ed191eefec7d205245edabb8b5f7e950f:
> 
>   ARM64: dts: hisilicon: Add all CPUs in cooling maps (2018-11-29 10:11:21 +0000)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoCs DT updates for 4.21
> 
> * Hi3660 SoC and related boards:
>   - Standardize LED labels and triggers for the hikey960 board
>   - Add the missing cooling-cells property for the cpu nodes
>   - Add all cpus into the cooling maps
> 
> * Hi3670 SoC and related boards:
>   - Add clock nodes and update the uart clock
>   - Add Pinctrl, GPIO and uart nodes
>   - Enable uart and add GPIO line names for the hikey970 board
> 
> * Hi3798 SoC and related boards:
>   - Standardize LED labels and triggers for the poplar board
> 
> * Hi6220 SoC and related boards:
>   - Standardize LED labels and triggers for the hikey board
>   - Add all cpus into the cooling maps

Merged, thanks.

> ----------------------------------------------------------------
> Manivannan Sadhasivam (10):
>       arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>       arm64: dts: hisilicon: Source SoC clock for UART6
>       arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
>       arm64: dts: hisilicon: hi3670: Add GPIO controller support
>       arm64: dts: hisilicon: hi3670: Add UART nodes
>       arm64: dts: hisilicon: hikey970: Enable on-board UARTs
>       arm64: dts: hisilicon: hikey970: Add GPIO line names
>       arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
>       arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
>       arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
> 
> Viresh Kumar (2):
>       arm64: dts: hi3660: Add missing cooling device properties for CPUs
>       ARM64: dts: hisilicon: Add all CPUs in cooling maps

Nit: Please use the common arm64: and ARM: patch prefixes.


Thanks,

-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
