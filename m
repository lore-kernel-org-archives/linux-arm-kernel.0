Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F5FC2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B2D20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D5hkUZ+Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nuoIMUcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B2D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2PppCbGGWcoX9v0IW9S83/iGiHI5jivTDnmRUzwRthM=; b=D5hkUZ+Z3rkeYl
	kPcS5IZd6/VLe3Ql4Tji0BpteBiRZpuo/jyc0lDP2QB1XG84EtT0xSIKw1fPLbnfrnrt6e5dTbJUr
	zXBBEIfJvZv9G5O0KGfObKLZJwEpP8cOUGGiPkQgrGS8sNJLjtnTsp5i34lwPLXM7iC1zP+8PFzle
	FzxBrDf+BQqylz8JeZgHYqYVnVro197Dc08h6yYdxy2BNc/x4QqqTn2zRCp02Pfl+6P4GFNa/FdMr
	qhUVVfYr8OhMrxdhLw4VvtcnJTsRn0dSfyqube0pZGfUodKF2xA48zFdJntECF6XI8jIZV59Xb80g
	mvzJIPocxhgQCAmkG7xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glaKD-00045j-2o; Mon, 21 Jan 2019 14:13:17 +0000
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glaK8-00044w-HQ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFeHY2jxq8m45nQ57iEwwiuqX6LwOcEwzyNZJxQAFEU=;
 b=nuoIMUcfN9p7SCUqRZ9RGMrya83lciFbCrxSRJhrzu6+82IQ5PvkMuCo1xAVuHTjfbvsAo9ePWWtrmJ4gSkwIer1uJjuESGkZzc2YKznNrzu2aMtsNGc7thsWNu/jSLg+bB3iWOUdyDyxOAU50hDJS6bqdC4Z2/LMd8+UXBuQyY=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB3117.eurprd04.prod.outlook.com (10.170.229.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 14:13:06 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293%5]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 14:13:06 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Angelo Dureghello <angelo@sysam.it>
Subject: Re: [PATCH] dmaengine: fsl-edma: dma map slave device address
Thread-Topic: [PATCH] dmaengine: fsl-edma: dma map slave device address
Thread-Index: AQHUrxWNOp/8EJuxn0OkxQdQoh5L0KW1kW0AgAQ3QoA=
Date: Mon, 21 Jan 2019 14:13:05 +0000
Message-ID: <b304acf8-f48f-6ab1-060f-3b210f7e3e74@nxp.com>
References: <20190118100623.13271-1-laurentiu.tudor@nxp.com>
 <20190118215015.GA6677@jerusalem>
In-Reply-To: <20190118215015.GA6677@jerusalem>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB3117;
 6:FoXnt4D7bzj+MOjvoTz2+qIV+QkId/5YFG1iyywADsvohdMpDau8uPGte8Q9ZO0531gCzvi5LQigLm0qyIPiojFbVdgBfT4cLl7fFhF9Q15EeuEGmlbr7A0n+hxzDXVEiEfsc+tn53M7NmGOjnKTqCIK/SsoACFVEknf7mfWVSJoMWxcbIQM6GJczaFoO+qQfcrXI5+f2xD3SKkjUog10LWUJwNFZmzWawGk9xeV1RkGO3EjMtHW8hQo8x9cMuP1vVX8DxuV/VRhpane/Kl3hkMTofQ6Zqn6ZXn8CxP7UsRlFNi9uwRggM4AzS5gIsl+7cZtBscnTzFrH0DEeKzfV69auBYq4sGkKUejqvrbLNF+fSHYgFPRKVlv3FOZNcUZUpb5cpXXFnLzMG8AtzBVMmNQCXHAKDWDw7Y3Epc7torlz7hgL2LklHL/98wO95Q8shEWrvYi2tk6AqiwMS7UPA==;
 5:o240MrS3febq87rc8M3CHWXqxFqOwqoORMznEGwkl/5EEbc9u03yC53qQC3aJNJuLDjt+P9GC3ODRQ+1SyFkw7vyFwVTYmHh0c0x1jFviOhIV6wFDDJOhGcdC5Rc8SA8JonBl2lVHImyVMaT7uDMrK/IVR9AtqdrsoZqyewDCrA1tiOV1mUdt3g30Bsv/KGwRUWBNdcmLHIfrfTMOOY/gQ==;
 7:MgeFaku/zHGAOxNRg+jrF+Q+Vlw80S32BM2JMOU4N5GKZ9YaFdVq0ufMeUJyAAJtP2P00NKJJ+leIvGeK0dpt4t5UUo8noduzc0TaGLyB+H1Fa+V/+fiOhPW1fZs9jEr0ZzP0xsYYytjCLg6so29cQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1c3925e3-8bc7-432e-a942-08d67faa903d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB3117; 
x-ms-traffictypediagnostic: VI1PR04MB3117:
x-microsoft-antispam-prvs: <VI1PR04MB3117C8B34BEB2AE6388399BBEC9F0@VI1PR04MB3117.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(478600001)(31696002)(76176011)(54906003)(53936002)(6306002)(6916009)(6246003)(229853002)(446003)(8936002)(316002)(11346002)(106356001)(6512007)(45080400002)(14454004)(86362001)(68736007)(31686004)(966005)(71190400001)(71200400001)(186003)(26005)(66066001)(7736002)(3846002)(6116002)(99286004)(4326008)(97736004)(81166006)(102836004)(2906002)(81156014)(36756003)(256004)(8676002)(14444005)(25786009)(6486002)(305945005)(105586002)(476003)(44832011)(486006)(6436002)(2616005)(53546011)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB3117;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: olUHDu/xBY76x1XdoNfmrDSIKowUhEGZC0EG+HDVfV+xVhc7kYSzYNmluHhMp8hkCQHmlFFLopMgqT30GylLVQn8ylt6nnuWuhhtyPR/FkTq+zpa7/+Sh0qglwc6aX0+sDr8T4XJ9kHjIiEvGQaMzqv/mGk3UJj+cAa4kmIs+W6gtBrf+4H0r2ZoV/iB3O3QLYoyNe2on6o7gsTq9mK8FcjfHjx1L8fRq78036ItjwR6kB9Qk742dj3BNWz+2NnvullF4kBzGq/kJQQHvINjwKFakyDqW5NPpS+P3ybcsiNNRm9INsbd+Ituapf8pvB+k4sEWgZhdL6ehseM4YzdlW2QAf8c55WAHZbt+G5ylig7yfV6BUKTyCxVYabM/EZabJHVLJ+FaT3Z//6X2TYEdATwIDu17WABC3igQUSkkXY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <112649FD385C91408DED87BC7418DD06@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3925e3-8bc7-432e-a942-08d67faa903d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 14:13:05.9631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_061313_096476_11907877 
X-CRM114-Status: GOOD (  21.48  )
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
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Angelo,

On 18.01.2019 23:50, Angelo Dureghello wrote:
> Hi Laurentiu,
> 
> On Fri, Jan 18, 2019 at 12:06:23PM +0200, Laurentiu Tudor wrote:
>> This mapping needs to be created in order for slave dma transfers
>> to work on systems with SMMU. The implementation mostly mimics the
>> one in pl330 dma driver, authored by Robin Murphy.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>> Original approach was to add the missing mappings in the i2c client driver,
>> see here for discussion: https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F1026013%2F&amp;data=02%7C01%7Claurentiu.tudor%40nxp.com%7C7861dfe95dfb4fceeb8208d67d907488%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C636834456718898365&amp;sdata=XM5shQdcIRgFLtCmuRuFtViR6ttPDWI%2BNHXoPi68Xs8%3D&amp;reserved=0
>>
>>   drivers/dma/fsl-edma-common.c | 66 ++++++++++++++++++++++++++++++++---
>>   drivers/dma/fsl-edma-common.h |  4 +++
>>   drivers/dma/fsl-edma.c        |  1 +
>>   drivers/dma/mcf-edma.c        |  1 +
>>   4 files changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> index 8876c4c1bb2c..0e95ee24b6d4 100644
>> --- a/drivers/dma/fsl-edma-common.c
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/dmapool.h>
>>   #include <linux/module.h>
>>   #include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>>   
>>   #include "fsl-edma-common.h"
>>   
>> @@ -173,12 +174,62 @@ int fsl_edma_resume(struct dma_chan *chan)
>>   }
>>   EXPORT_SYMBOL_GPL(fsl_edma_resume);
>>   
>> +static void fsl_edma_unprep_slave_dma(struct fsl_edma_chan *fsl_chan)
>> +{
>> +	if (fsl_chan->dma_dir != DMA_NONE)
>> +		dma_unmap_resource(fsl_chan->vchan.chan.device->dev,
>> +				   fsl_chan->dma_dev_addr,
>> +				   fsl_chan->dma_dev_size,
>> +				   fsl_chan->dma_dir, 0);
>> +	fsl_chan->dma_dir = DMA_NONE;
>> +}
>> +
>> +static bool fsl_edma_prep_slave_dma(struct fsl_edma_chan *fsl_chan,
>> +				    enum dma_transfer_direction dir)
>> +{
>> +	struct device *dev = fsl_chan->vchan.chan.device->dev;
>> +	enum dma_data_direction dma_dir;
>> +	phys_addr_t addr = 0;
>> +	u32 size = 0;
>> +
>> +	switch (dir) {
>> +	case DMA_MEM_TO_DEV:
>> +		dma_dir = DMA_FROM_DEVICE;
>> +		addr = fsl_chan->cfg.dst_addr;
>> +		size = fsl_chan->cfg.dst_maxburst;
>> +		break;
>> +	case DMA_DEV_TO_MEM:
>> +		dma_dir = DMA_TO_DEVICE;
>> +		addr = fsl_chan->cfg.src_addr;
>> +		size = fsl_chan->cfg.src_maxburst;
>> +		break;
>> +	default:
>> +		dma_dir = DMA_NONE;
>> +		break;
>> +	}
>> +
>> +	/* Already mapped for this config? */
>> +	if (fsl_chan->dma_dir == dma_dir)
>> +		return true;
>> +
>> +	fsl_edma_unprep_slave_dma(fsl_chan);
>> +
>> +	fsl_chan->dma_dev_addr = dma_map_resource(dev, addr, size, dma_dir, 0);
>> +	if (dma_mapping_error(dev, fsl_chan->dma_dev_addr))
>> +		return false;
>> +	fsl_chan->dma_dev_size = size;
>> +	fsl_chan->dma_dir = dma_dir;
>> +
>> +	return true;
>> +}
>> +
>>   int fsl_edma_slave_config(struct dma_chan *chan,
>>   				 struct dma_slave_config *cfg)
>>   {
>>   	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>>   
>>   	memcpy(&fsl_chan->cfg, cfg, sizeof(*cfg));
>> +	fsl_edma_unprep_slave_dma(fsl_chan);
>>   
>>   	return 0;
>>   }
>> @@ -378,6 +429,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>>   	if (!is_slave_direction(direction))
>>   		return NULL;
>>   
>> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
>> +		return NULL;
>> +
>>   	sg_len = buf_len / period_len;
>>   	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
>>   	if (!fsl_desc)
>> @@ -409,11 +463,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>>   
>>   		if (direction == DMA_MEM_TO_DEV) {
>>   			src_addr = dma_buf_next;
>> -			dst_addr = fsl_chan->cfg.dst_addr;
>> +			dst_addr = fsl_chan->dma_dev_addr;
>>   			soff = fsl_chan->cfg.dst_addr_width;
>>   			doff = 0;
>>   		} else {
>> -			src_addr = fsl_chan->cfg.src_addr;
>> +			src_addr = fsl_chan->dma_dev_addr;
>>   			dst_addr = dma_buf_next;
>>   			soff = 0;
>>   			doff = fsl_chan->cfg.src_addr_width;
>> @@ -444,6 +498,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>>   	if (!is_slave_direction(direction))
>>   		return NULL;
>>   
>> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
>> +		return NULL;
>> +
>>   	fsl_desc = fsl_edma_alloc_desc(fsl_chan, sg_len);
>>   	if (!fsl_desc)
>>   		return NULL;
>> @@ -468,11 +525,11 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>>   
>>   		if (direction == DMA_MEM_TO_DEV) {
>>   			src_addr = sg_dma_address(sg);
>> -			dst_addr = fsl_chan->cfg.dst_addr;
>> +			dst_addr = fsl_chan->dma_dev_addr;
>>   			soff = fsl_chan->cfg.dst_addr_width;
>>   			doff = 0;
>>   		} else {
>> -			src_addr = fsl_chan->cfg.src_addr;
>> +			src_addr = fsl_chan->dma_dev_addr;
>>   			dst_addr = sg_dma_address(sg);
>>   			soff = 0;
>>   			doff = fsl_chan->cfg.src_addr_width;
>> @@ -555,6 +612,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>>   	fsl_edma_chan_mux(fsl_chan, 0, false);
>>   	fsl_chan->edesc = NULL;
>>   	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
>> +	fsl_edma_unprep_slave_dma(fsl_chan);
>>   	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>>   
>>   	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
>> index 8917e8865959..b435d8e1e3a1 100644
>> --- a/drivers/dma/fsl-edma-common.h
>> +++ b/drivers/dma/fsl-edma-common.h
>> @@ -6,6 +6,7 @@
>>   #ifndef _FSL_EDMA_COMMON_H_
>>   #define _FSL_EDMA_COMMON_H_
>>   
>> +#include <linux/dma-direction.h>
>>   #include "virt-dma.h"
>>   
>>   #define EDMA_CR_EDBG		BIT(1)
>> @@ -120,6 +121,9 @@ struct fsl_edma_chan {
>>   	struct dma_slave_config		cfg;
>>   	u32				attr;
>>   	struct dma_pool			*tcd_pool;
>> +	dma_addr_t			dma_dev_addr;
>> +	u32				dma_dev_size;
>> +	enum dma_data_direction		dma_dir;
>>   };
>>   
>>   struct fsl_edma_desc {
>> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
>> index 34d70112fcc9..75e8a7ba3a22 100644
>> --- a/drivers/dma/fsl-edma.c
>> +++ b/drivers/dma/fsl-edma.c
>> @@ -254,6 +254,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>>   		fsl_chan->pm_state = RUNNING;
>>   		fsl_chan->slave_id = 0;
>>   		fsl_chan->idle = true;
>> +		fsl_chan->dma_dir = DMA_NONE;
>>   		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
>>   		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
>>   
>> diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
>> index 5de1b07eddff..7de54b2fafdb 100644
>> --- a/drivers/dma/mcf-edma.c
>> +++ b/drivers/dma/mcf-edma.c
>> @@ -214,6 +214,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
>>   		mcf_chan->edma = mcf_edma;
>>   		mcf_chan->slave_id = i;
>>   		mcf_chan->idle = true;
>> +		mcf_chan->dma_dir = DMA_NONE;
>>   		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
>>   		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
>>   		iowrite32(0x0, &regs->tcd[i].csr);
>> -- 
>> 2.17.1
>>
> 
> I tested this patch on:
> 
> - Vybrid VF50N (Toradex Colibri VF50)
> - ColdFire mcf54415 (Sysam stmark2 board)
> 
> and dma still works properly.
> 
> Tested-by: Angelo Dureghello <angelo@sysam.it>
> 

Thanks a lot for testing!

---
Best Regards, Laurentiu
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
