Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:33:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0819520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAdxoo9Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgwZ66WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0819520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eEDHkTkLyLV0dH8ABFLCZoSt6Cv7TPPP0epX/O/qBTE=; b=rAdxoo9YTBzn9q
	IiqmbIqwvwZIdPSpA4UNQt9Wmq+h9zbnVSinrd5xQeHT5yDAF8tW7A9lcHdabzhKxZv+QQiEfPJDL
	LBJ3IEiSdQ2doDwd8brYyJcudUUSXYP4t3jyXXzGmu6MSaeLgMoAZH5CpGsfz6eKv6er6DWAi+iJk
	CN71wn6o5MRdZ1gZEDMF1uLmaICQH5jlwBDLJ4C26v0MhtKywuw369rWwRmnuqihsuN7ukrznQSuZ
	9VEcDs4Uu3Aom0s0/95N0zzHQtgMZwd9WVVWfKRgILh7EZeYPNvfh04d3MxAn5BuNgj3RDlszKBuC
	XsHysriSwY/zAObf8ldQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZrtB-0008KA-Sp; Thu, 20 Dec 2018 06:32:57 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZrsy-0008BF-GD; Thu, 20 Dec 2018 06:32:46 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK6WKfb052050;
 Thu, 20 Dec 2018 00:32:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545287540;
 bh=5lmyEkckv0Aq9P7ICSHxKkDjWSa42rCtOd37oaIZPG4=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=jgwZ66WFVK2oYngECcGjVj+3hqnCfHpIRXs18BMphnVxD1A/nFFMVHE9xrCN1DV7R
 scTfubWCQLTUnh9GnGIBz60L2IQu5M5ZPefSzekq/ZpGniH4sQTqLIsDH+nBuFs1z9
 bEXtUJiyHVHF3WxDiId8UJPVqgIv5yroEYoSnkCg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK6WKiu097046
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 00:32:20 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 00:32:20 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 00:32:20 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK6WFCB021430;
 Thu, 20 Dec 2018 00:32:16 -0600
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
 <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
Date: Thu, 20 Dec 2018 12:03:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_223244_665088_F840F05B 
X-CRM114-Status: GOOD (  17.80  )
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

On 20/12/18 11:02 AM, Yogesh Narayan Gaur wrote:
[...]
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
>> These two patches are already merged and is now part of linux-next[1].
>> Its preferred to send patches based on top of latest linux-next so as to avoid
>> resending patches that have already been picked up by the maintainer.
>>
>> [1]
>> commit 6b03061f882de49b83ccf44beb3a12c920a2da1b
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:06 2018 +0000
>>
>>     spi: add support for octal mode I/O data transfer
>>
>> commit b12a084c8729ef423089bb9a5a143eed39cd94e7
>> Author: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
>> Date:   Mon Dec 3 08:39:12 2018 +0000
>>
>>     spi: spi-mem: add support for octal mode I/O data transfer
>>
>>
> I have checked on repo "git://git.infradead.org/linux-mtd.git" on branch "spi-nor/next" and in that kernel version is 4.20.-rc5.
> In this repo above 2 patches are not present and hence has send the patches by moving to top of this repo.
> 

Those patches are applied to spi tree:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next

> Can you please let me know the repo of linux-next and branch to use.
> 

The linux-next tree is the holding area for patches aimed at
the next kernel merge window. This tree includes spi-nor/next as part of mtd/next
as well as many other subsystem specific -next trees:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git branch: master


Regards
Vignesh

> --
> Regards
> Yogesh Gaur
> 
>> Regards
>> Vignesh
>>
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>> Changes for v6:
>>> - Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
>>> - Rebase on top of v4.20-rc5.
>>> Changes for v5:
>>> - Modified string 'octo' as 'octal' in all patches.
>>> Changes for v4:
>>> - Rebase on top of v4.20-rc2.
>>> - Modify octo entries enum value in spi.h.
>>> Changes for v3:
>>> - Add octo mode support in spi_setup().
>>> - Rename all patches with 'octal' string modified as 'octo'.
>>> Changes for v2:
>>> - Incorporated review comments of Boris and Vignesh.
>>>
>>> Yogesh Gaur (7):
>>>   spi: add support for octal mode I/O data transfer
>>>   spi: spi-mem: add support for octal mode I/O data transfer
>>>   mtd: spi-nor: add opcodes for octal Read/Write commands
>>>   mtd: spi-nor: add octal read flag for flash mt35xu512aba
>>>   mtd: m25p80: add support of octal mode I/O transfer
>>>   spi: nxp-fspi: add octal mode flag bit for octal support
>>>   arm64: dts: lx2160a: update fspi node
>>>
>>>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
>>>  drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
>>>  drivers/mtd/spi-nor/spi-nor.c                     | 19 ++++++++++++++++---
>>>  drivers/spi/spi-mem.c                             |  9 ++++++++-
>>>  drivers/spi/spi-nxp-fspi.c                        |  4 ++--
>>>  drivers/spi/spi.c                                 | 12 ++++++++++--
>>>  include/linux/mtd/spi-nor.h                       | 16 ++++++++++++----
>>>  include/linux/spi/spi.h                           |  4 +++-
>>>  8 files changed, 63 insertions(+), 14 deletions(-)
>>>
>>
>> --
>> Regards
>> Vignesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
