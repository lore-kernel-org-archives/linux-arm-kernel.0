Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87429C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:14:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E773214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OksnyHrt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sJdI6kxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E773214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e9XtwtaAuRQa0Z2kvkvzcckHnqbTkCmxqlR8xSJ9tnM=; b=OksnyHrtGG50Df
	8UOcnAD1Gk2OvWf2dOeALcxVyh0RvAwcKppyTkZ96dRVP469L7VP5NBDKYbNlRGVvJW/c+v96Aj8H
	Lst4GaCL2CUV1S85PWW5gdJtrjfyBW/2M0LvY31DpyVYUvWVWhdMrHznEkLy0Bqvllyyn0QHDEY62
	LD6gP5DuVpbmWXok3OB1/BsdLgng/QRUj3NO1U5T48M3pd5pG9TgXHdx9h7dtDqkNMFGzymZSsKXT
	goH49e5mZhd17YgdXCVVcNESha03c+lF50xuhRhsEvdpV3ZItl4ocJ77FP5bnUdOSNYk6FPX4h3XS
	oV/BvgKQVWwhy/Tof3ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghb5t-0000Rj-Eh; Thu, 10 Jan 2019 14:14:01 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghb5q-0000QD-96
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:13:59 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0AEDqCG040226;
 Thu, 10 Jan 2019 08:13:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547129632;
 bh=HCtyGIf1iBr5A99mAfEpZkXBqU8fRmJdmkPA4jZIUvY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=sJdI6kxINiobAiHuxcyBDp6cK/lhMvaHLjZ0C5HZODJ6f5qwaFerO7jpxiu/niIbi
 vm02w+30s1wHc32U5uVfZ/Ds3vjbvF5IPJ/uzf/aoBvoorPiBT64J8pI4wMQduqYSN
 Pm0eBQ0RQGhSlmCj0w9GtLuoUww4mb+H1wR8TbiU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0AEDqP4105708
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 08:13:52 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 08:13:51 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 08:13:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0AEDmnR012760;
 Thu, 10 Jan 2019 08:13:48 -0600
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
References: <20190108091539.16674-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
Date: Thu, 10 Jan 2019 19:43:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_061358_397248_3B56E7E3 
X-CRM114-Status: GOOD (  19.68  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bartosz,

On 08/01/19 2:45 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Hi Sekhar,
> 
> now that all dependencies are in and v5.0-rc1 is tagged, please consider
> picking up the second batch of davinci-specific changes into your tree.
> Once that's done, please provide me with an immutable branch for me to
> apply the last patch to my at24 tree.

You can use branch v5.1/eeprom-for-bartosz in my tree for this (commit
e430685f4969).

> 
> This is the second part of the effort to modernize the at24 driver and
> remove the legacy platform data structure in favor of device properties.
> It required getting rid of the at24 setup callback in favor of nvmem
> lookups.
> 
> Re-tested with da850-evm and dm365-evm.

Applied patches 1-11 for v5.1

Thanks,
Sekhar

> 
> Bartosz Golaszewski (12):
>   ARM: davinci: da850-evm: remove dead MTD code
>   ARM: davinci: mityomapl138: don't read the MAC address from machine
>     code
>   ARM: davinci: dm365-evm: use device properties for at24 eeprom
>   ARM: davinci: da830-evm: use device properties for at24 eeprom
>   ARM: davinci: dm644x-evm: use device properties for at24 eeprom
>   ARM: davinci: dm646x-evm: use device properties for at24 eeprom
>   ARM: davinci: sffsdr: fix the at24 eeprom device name
>   ARM: davinci: sffsdr: use device properties for at24 eeprom
>   ARM: davinci: remove dead code related to MAC address reading
>   ARM: davinci: mityomapl138: use nvmem notifiers
>   ARM: davinci: mityomapl138: use device properties for at24 eeprom
>   eeprom: at24: remove at24_platform_data
> 
>  MAINTAINERS                                |   1 -
>  arch/arm/mach-davinci/board-da830-evm.c    |  13 +-
>  arch/arm/mach-davinci/board-da850-evm.c    |  28 ----
>  arch/arm/mach-davinci/board-dm365-evm.c    |  13 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c   |  13 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c   |  13 +-
>  arch/arm/mach-davinci/board-mityomapl138.c |  38 ++---
>  arch/arm/mach-davinci/board-sffsdr.c       |  13 +-
>  arch/arm/mach-davinci/common.c             |  15 --
>  drivers/misc/eeprom/at24.c                 | 162 ++++++++++-----------
>  include/linux/davinci_emac.h               |   1 -
>  include/linux/platform_data/at24.h         |  60 --------
>  12 files changed, 122 insertions(+), 248 deletions(-)
>  delete mode 100644 include/linux/platform_data/at24.h
> 
> -- 
> 2.19.1
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
