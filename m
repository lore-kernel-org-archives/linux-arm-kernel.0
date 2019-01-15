Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B996820651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bxvQaQGB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pRtGyIda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B996820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yyX578869n0dAonDG3jxj6jxQZaza6dVMDwZXxrx6ag=; b=bxvQaQGB79y9R7
	jSKwryX8P+W+B4J/AGevgEvmE8YgLuGx6kUk1bHjsWITc/aU0k/E1DW9Mjvd79YBJ8p6y1zlta86B
	Wua2aJo/ssIf17kpw7uPjfzUQoMBXUgAngkDMJJRcQw+gHcUcviz9X+2UMvNh/6Es9ohsYMb2p/gM
	0SabHkbn38oZaM5wrc56IvchOP6u7nCFKtCe04rVh/QXCw1C24P0mtR8jGmbrmmTqovopWGbK2UUH
	TU4D5sl4mGbkZ3YVOEKQt1L2+hCSfmU5TuoyesWwyK2OWg+wmt5a7e+woBYcz024uwvzwj0Ct6a13
	QlTE7HwxsM708G1SGHvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPC3-0003Xm-Ai; Tue, 15 Jan 2019 13:55:51 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPBz-0003XR-Is
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:55:49 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FDtUgR096889;
 Tue, 15 Jan 2019 07:55:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547560530;
 bh=M4E9szcMy2s/1G1NcDsPyh7e/Ea7sPKwxtbQVHhwljQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pRtGyIdaRglXIN7p6XoRFmsBFfVsG5AQvr0cYrZxdQusWrTu7n/iTsIszAOSsbo6r
 y+tH8HFY2sy/49gUoBffBaYNFVyyk3RC9hLpz175dHEzxDCN0ZGvqHPyC8BvcSk6VJ
 pUkOA+Q/SXsR+Ecnz0SuLSHf28dVmVAvvztcPiT0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FDtU8R119636
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 07:55:30 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 07:55:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 07:55:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FDtTtW025526;
 Tue, 15 Jan 2019 07:55:29 -0600
Date: Tue, 15 Jan 2019 07:54:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH v4 13/13] soc: ti: am6: Enable interrupt controller
 drivers
Message-ID: <20190115135457.2x6huvgtth2yjhhq@kahuna>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-13-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181227061313.5451-13-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_055547_741613_60E4FB69 
X-CRM114-Status: GOOD (  18.55  )
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11:43-20181227, Lokesh Vutla wrote:
> Select all the TISCI dependent interrupt controller drivers
> for AM6 SoC.
> 
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/soc/ti/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7640490c2a6a..145b701a3d96 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -5,6 +5,11 @@ if ARCH_K3
>  
>  config ARCH_K3_AM6_SOC
>  	bool "K3 AM6 SoC"
> +	select MAILBOX
> +	select TI_MESSAGE_MANAGER
> +	select TI_SCI_PROTOCOL
> +	select TI_SCI_INTR_IRQCHIP
> +	select TI_SCI_INTA_IRQCHIP

Sorry for joining the party late.. but just 2 cents for thought..

Is'nt imply better than select here? for a very tiny kernel, it is
possible to boot kernel up and TISCI and mailbox could be modules as
well.. I know it is a theoretical concept, but it may be helpful (esp
during pre-silicon time frame, at least during start, I usually start
with almost everything other than the CPU cores and PSCI disabled).
there is not much you can do with it ofcourse, but it helps me with a
clean start.


>  	help
>  	  Enable support for TI's AM6 SoC Family support
>  
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
