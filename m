Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90679C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:47:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF032080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rQPE5usW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mrdfr0XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF032080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cBJ7GWzuQ5gtg9cZQBCB+5HJAae3aO7+Olo1mMGr9eM=; b=rQPE5usWFMXmIn
	dL0fyAd0B4E2mTG+MRv1UspDrd5OuA6yY8RpOd/NU1dxq632Eu5GEwTlaNEjjW3CLQIEdMRbyiZK8
	el3pkv7Vkz5Y2HDEZuWgdjG3foZt5z6HWiokFu2RGACpMdUQ2hSX9U9si58gnnT2RwsSMJVs8lzGg
	wAn/Rn3GDUt94oQUQOxCMe2ICyZNdOMPQKsVFPNWiBITHzyQPsUA9c5Z+Gny7+w5PuMO64vdQZXDI
	d7X2vjR0cJkkcw9338zRrgolAv6nNT5s5FcHHec3QnaIpzGZieVfpi+nkysp3xRdJGf/GDUGEdO3s
	g6wdvDfKO+Nl6oNedd/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbFi-0004D1-2M; Wed, 19 Dec 2018 12:47:06 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbBt-000859-OI; Wed, 19 Dec 2018 12:43:21 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgoY8098519;
 Wed, 19 Dec 2018 06:42:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545223370;
 bh=hOSSW/Fe3UvUR+FrL7a03PALPLMq3eLz4yJsqFMxDoc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=mrdfr0XXm/f5HMraMzJuJQE7P79uLh/2YtX4lv0Z1jl+3bRWN/Um8PdULyHarDG5E
 Dy5yIpCcFLM+W9ihzGe48tHudI5EBvL+puXXzJeT3ejyOt2uwujSNpZL6AHg9dEDY/
 pnBtQuIMXym537Z5o06Z2HnRpbHbZZzYCRqxnKH4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgowT034704
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:42:50 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:50 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:50 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgjlF004104;
 Wed, 19 Dec 2018 06:42:46 -0600
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
Date: Wed, 19 Dec 2018 18:13:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_044310_274919_4F636126 
X-CRM114-Status: GOOD (  18.97  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19/12/18 3:41 PM, Yogesh Narayan Gaur wrote:
> Add support for octal mode IO data transfer.
> Micron flash, mt35xu512aba, supports octal mode data transfer and
> NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).
> 
> Patch series
> * Add support for octal mode flags and parsing of same in spi driver.
> * Add parsing logic for spi-mem framework and m25p80.c device file.
> * Add opcodes for octal I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
>   Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
> * Add mode bit required for octal mode in nxp-fspi driver [2].
> * Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].
> 
> Tested on LX2160ARDB target with nxp-fspi driver, below are
> Read performance number of 1-1-1 and 1-1-8 read protocol.
> 
>  root@lxxx:~# cat /proc/mtd
>  dev:    size   erasesize  name
>  mtd0: 04000000 00001000 "spi0.0"
>  mtd1: 04000000 00001000 "spi0.1"
>  root@lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m2.792s
>  user    0m0.000s
>  sys     0m2.790s
>  root@lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
>  Copied 16777216 bytes from address 0x00000000 in flash to 0read
> 
>  real    0m0.441s
>  user    0m0.000s
>  sys     0m0.440s
>  root@ls1012ardb:~#
> 
> 
>  Flash device MTD0 configured in 1-1-1 protocol.
>  Flash device MTD1 configured in 1-1-8 protocol.
> 
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384&state=*
> [2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=76402
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer


These two patches are already merged and is now part of linux-next[1].
Its preferred to send patches based on top of latest linux-next so as to
avoid resending patches that have already been picked up by the maintainer.

[1]
commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:06 2018 +0000

    spi: add support for octal mode I/O data transfer

commit b12a084c8729ef423089bb9a5a143eed39cd94e7
Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Mon Dec 3 08:39:12 2018 +0000

    spi: spi-mem: add support for octal mode I/O data transfer


Regards
Vignesh

>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
> Changes for v6:
> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
> - Rebase on top of v4.20-rc5.
> Changes for v5:
> - Modified string 'octo' as 'octal' in all patches.
> Changes for v4:
> - Rebase on top of v4.20-rc2.
> - Modify octo entries enum value in spi.h.
> Changes for v3:
> - Add octo mode support in spi_setup().
> - Rename all patches with 'octal' string modified as 'octo'.
> Changes for v2:
> - Incorporated review comments of Boris and Vignesh.
> 
> Yogesh Gaur (7):
>   spi: add support for octal mode I/O data transfer
>   spi: spi-mem: add support for octal mode I/O data transfer
>   mtd: spi-nor: add opcodes for octal Read/Write commands
>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>   mtd: m25p80: add support of octal mode I/O transfer
>   spi: nxp-fspi: add octal mode flag bit for octal support
>   arm64: dts: lx2160a: update fspi node
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>  drivers/spi/spi.c                                 | 12 ++++++++++--
>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>  include/linux/spi/spi.h                           |  4 +++-
>  8 files changed, 63 insertions(+), 14 deletions(-)
> 

-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
