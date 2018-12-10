Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18711C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0CE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHqLHOpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0CE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YeLxypZUb3BWCsNtaXDLhaeeyCUWYMFLW8hbd/Ed/Zo=; b=IHqLHOpNrT9vkK
	H2/9ZP+9i3uQXhW54kU+SoZzhIHpSSXDKhUL8lg/N7KZ/Np+Zk8dPzzDNq5qVHeN/f/8COyuzC8gK
	+PHCSRC7IKNsYFCLAQ5hRFnopmYRuoguwl2gNjhgUFHFI4TRtgcVZFuTg84E3Qf978kBtwa88DRrk
	jHxj98fBaguSETWYdBZBrLJIWb0ybE6U4Vous4FEKXURpyZ1YHyHMIS16IjvPz2nZ7EhCO3sj8Le6
	hZbo/RuLhbj6FWTYoUNKoPZJzwLQ38BeZSf6o2UL5X0EmMI55/KQe+lH1kvsj4bQIzaKE0XeRZEcM
	ua4FYHhe72zU8ZVltoig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJaS-0006w3-0o; Mon, 10 Dec 2018 11:18:56 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJaO-0006vM-Hx; Mon, 10 Dec 2018 11:18:54 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBABIamf104994;
 Mon, 10 Dec 2018 05:18:36 -0600
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBABIaW7007476
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 05:18:36 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 05:18:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 05:18:36 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBABIWup012385;
 Mon, 10 Dec 2018 05:18:33 -0600
Subject: Re: [PATCH 3/3] mtd: spi-nor: cadence-quadspi: Add support for Octal
 SPI controller
To: Boris Brezillon <boris.brezillon@bootlin.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-4-vigneshr@ti.com> <20181210094513.6282d55e@bbrezillon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <f6c3a649-f580-513d-644d-5010b3b5cf0b@ti.com>
Date: Mon, 10 Dec 2018 16:49:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210094513.6282d55e@bbrezillon>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_031852_674915_E455623E 
X-CRM114-Status: GOOD (  20.07  )
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
Cc: devicetree@vger.kernel.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/18 2:15 PM, Boris Brezillon wrote:
> On Wed, 3 Oct 2018 22:26:03 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
>> It also has an integrated PHY. IP register layout is very
>> similar to existing QSPI IP except for additional bits to support Octal
>> and Octal DDR mode. Therefore, extend current driver to support Octal
>> mode.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index e24db817154e..48b00e75a879 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -101,6 +101,7 @@ struct cqspi_st {
>>  #define CQSPI_INST_TYPE_SINGLE			0
>>  #define CQSPI_INST_TYPE_DUAL			1
>>  #define CQSPI_INST_TYPE_QUAD			2
>> +#define CQSPI_INST_TYPE_OCTAL			3
>>  
>>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>>  #define CQSPI_DUMMY_BYTES_MAX			4
>> @@ -898,6 +899,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>>  		case SNOR_PROTO_1_1_4:
>>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>>  			break;
>> +		case SNOR_PROTO_1_1_8:
>> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
>> +			break;
>>  		default:
>>  			return -EINVAL;
>>  		}
>> @@ -1205,6 +1209,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>  			SNOR_HWCAPS_READ_FAST |
>>  			SNOR_HWCAPS_READ_1_1_2 |
>>  			SNOR_HWCAPS_READ_1_1_4 |
>> +			SNOR_HWCAPS_READ_1_1_8 |
> 
> Is this really supported on qspi versions of this IP? I guess not given
> the description in the commit message and the name of the new
> compatible (ospi instead of qspi).

No, qspi version does not support Octal mode. I guess you are pointing
out its logically wrong for driver with "*-qspi" compatible to declare
SNOR_HWCAPS_READ_1_1_8 capability.
Will update patch to declare SNOR_HWCAPS_READ_1_1_8 based on compatible.

> 
>>  			SNOR_HWCAPS_PP,
>>  	};
>>  	struct platform_device *pdev = cqspi->pdev;
>> @@ -1456,6 +1461,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>>  		.compatible = "ti,k2g-qspi",
>>  		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>>  	},
>> +	{
>> +		.compatible = "ti,am654-ospi",
>> +		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>> +	},
>>  	{ /* end of table */ }
>>  };
>>  
> 

-- 
Regards
Vignesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
