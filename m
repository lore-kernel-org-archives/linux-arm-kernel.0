Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34FFC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:25:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24B42086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbL+wKf+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OPq4lPKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24B42086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tu6Wb1IK/NsjoI/2BYMm85mAvnNQt/WZgBsOY0C0OP8=; b=pbL+wKf+tO46vo
	fmlNJhAp1W8Ym4k9f9taMkGtNygoFkvXJkjQxZxEXmxcI9xFtXbMBCnU2Fg1WQqe5vdGQgUvUL7kz
	pHGu0nydK5ZB0K2VnZSrzuNeBDU6eHVUysupnzBrhrMMAnwl4OuDjC/j3UT+oRj1Wod5+FFVtrK6w
	OJGhj5RRCUQKNBdrvwPh9L5yX83FHXjTEQfYkuF7dhcPC2aqNXI5L0zScYuFX8hHFJs1aa+AMugrK
	rEMp/JSh9m1i/ky4nP4HBRCF+7b/24GiGNOXQKExBIVB8Kukp44q24/hegtTOa+VRTRGDSuRaBYTM
	4+yxUk9PMF82d8VanoTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoD7-000855-Bl; Mon, 17 Dec 2018 08:25:09 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoD3-0006pg-LY
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:25:07 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBH8Omar015191;
 Mon, 17 Dec 2018 02:24:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545035088;
 bh=vx04N3C4JziSTM0yycYesCRexANe0gUKYVrkn3GpAK0=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=OPq4lPKvNtfRqf8sYRKMnhW6xQBt3skk8g2sG3m1q+LwkWy50jlvr6mSKebypwDdU
 IRh/xMlBCW3qMiCBf1AXCs2kfavQvdDrKFNd0Y4fGigFz2B7u7isVtmc9N3EadacTo
 3NCNmkVD9vFAddymBRUXLX/RNzemrVAc7Nu+0zcg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBH8Omng024423
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Dec 2018 02:24:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 02:24:48 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 02:24:48 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBH8OiWU019543;
 Mon, 17 Dec 2018 02:24:45 -0600
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
To: Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
References: <20181210183507.9617-1-faiz_abbas@ti.com>
 <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
Date: Mon, 17 Dec 2018 13:54:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_002505_789584_E7E11258 
X-CRM114-Status: GOOD (  18.72  )
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
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
 kishon@ti.com, robh+dt@kernel.org, michal.simek@xilinx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/12/18 1:45 PM, Faiz Abbas wrote:
> Hi,
> 
> On 11/12/18 12:05 AM, Faiz Abbas wrote:
>> The following patches add driver support for MMCSD on TI's AM654
>> platforms.
>>
>> Previously I had added the support to sdhci-of-arasan driver with
>> a separate phy driver[1]. Since then it has turned out that tuning
>> operation (for HS200, HS400 and SDR104 speed modes) will require
>> configuration of phy registers. This completely breaks the model of
>> the sdhci-of-arasan driver which relies on a separate driver to
>> configure the phy register space.
>>
>> Because of this, I am creating a new driver with both the sdhci and
>> phy register spaces. This helps me use the phy registers in a future
>> patch that adds tuning support.
>>
>> DT patches will be posted in a separate series.
>>
>> Changes in v3:
>>  1. Removed reference to clk_ahb as its not being used.
>>  2. Added comment for pm_runtime being used for enabling
>>     clocks.
>>
>> Changes in v2:
>>  1. Reset OTAP delay back to default value in init.
>>  2. Improved patch description for patch 2.
>>  3. Minor style fixes.
>>
>> [1] driver and phy patches posted before
>>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
>>
>> Faiz Abbas (3):
>>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>>     controllers on TI's AM654 SOCs
>>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
>>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
>>
>>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
>>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
>>  drivers/mmc/host/Kconfig                      |  12 +
>>  drivers/mmc/host/Makefile                     |   1 +
>>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
>>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
>>  6 files changed, 428 insertions(+), 46 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> 
> 
> Gentle ping.

I see these in linux-next. 

aff88ff23512 (Faiz Abbas) 6 days ago  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
7f6e4cc6727d (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
351b766ef2c7 (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
