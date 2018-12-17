Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDA920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jI76b40A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b5ZcJ2kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZbAhCzPJZwLTdrnlQrYALeSNFGuwqSoT/naC8tfZOUY=; b=jI76b40A/twZ3P
	xe4OSeKahhYya2BudG1AdP5MxhKlpHgpK6diYwT8Rg5vxAVbjwVQvJ7PTPbMI7JXPoac6xui4S0Wi
	4ecn0/4uAMQMkt3v8rNQqMGeAlE+zGOLR3xInrgPPfZpzNAaIuQ9HzQVw+lAPyG3NaQcHUGH055GO
	4jdti4FGfIDrIHgFBNnbzzbPITr3b+Y7xfg4mVpOmnF27fkg/dVATBFCpyLm6V+hJHa9IBMNrIWn6
	F3eb5ppKFgKSjQT2YSfqYe08LYDoO7v1wlyqVAilP53CglOoUTf4qFuSeUXIwbFdDBA/7dQnYvUjC
	bdm+vkiSuqm82paDKQsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYo1g-0002cn-2U; Mon, 17 Dec 2018 08:13:20 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYo1c-0002cE-06
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:13:17 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBH8CsXW017358;
 Mon, 17 Dec 2018 02:12:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545034374;
 bh=kA3nlrd108oXtUBsINdK5kdNu3J3i+MpG02lnid5R5U=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=b5ZcJ2kDUwFx4qsehDup858pQszB8CcqhvdPUtcl42L4jbS2CgcXX4iEaMdpaTqXf
 7OT0RV7TNLl31AaEzXX6JrLMcr1QT5XaWDO6ajhhwyroaolBoLnKdX7RTf4/RvIJv3
 CGmdAE+e9iTwrV2GhGP3z/oGNIx2nAFFle0r1yOc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBH8Csx9020861
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Dec 2018 02:12:54 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 02:12:54 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 02:12:54 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBH8Cotm006498;
 Mon, 17 Dec 2018 02:12:51 -0600
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20181210183507.9617-1-faiz_abbas@ti.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
Date: Mon, 17 Dec 2018 13:45:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210183507.9617-1-faiz_abbas@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_001316_159191_EEEAF440 
X-CRM114-Status: GOOD (  21.06  )
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

Hi,

On 11/12/18 12:05 AM, Faiz Abbas wrote:
> The following patches add driver support for MMCSD on TI's AM654
> platforms.
> 
> Previously I had added the support to sdhci-of-arasan driver with
> a separate phy driver[1]. Since then it has turned out that tuning
> operation (for HS200, HS400 and SDR104 speed modes) will require
> configuration of phy registers. This completely breaks the model of
> the sdhci-of-arasan driver which relies on a separate driver to
> configure the phy register space.
> 
> Because of this, I am creating a new driver with both the sdhci and
> phy register spaces. This helps me use the phy registers in a future
> patch that adds tuning support.
> 
> DT patches will be posted in a separate series.
> 
> Changes in v3:
>  1. Removed reference to clk_ahb as its not being used.
>  2. Added comment for pm_runtime being used for enabling
>     clocks.
> 
> Changes in v2:
>  1. Reset OTAP delay back to default value in init.
>  2. Improved patch description for patch 2.
>  3. Minor style fixes.
> 
> [1] driver and phy patches posted before
>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
> 
> Faiz Abbas (3):
>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>     controllers on TI's AM654 SOCs
>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
>  drivers/mmc/host/Kconfig                      |  12 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
>  6 files changed, 428 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>  create mode 100644 drivers/mmc/host/sdhci_am654.c


Gentle ping.

Thanks,
Faiz


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
