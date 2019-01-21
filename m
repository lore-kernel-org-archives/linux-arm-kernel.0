Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99251C2F420
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:39:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680972084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GSVh39xI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="V0JbKZy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680972084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j20miGFefDk1njOb27vO5P88eLWASXfLjiruPH8Uvc4=; b=GSVh39xIlrHUyl
	6X2SDBcsjixwb67Jy1FidEqfAPC27A3Xr25glE/D0eUs0aaiLgcSVlgZ33nu34AHYnOl8lV6NAHBO
	fzzPFv7TEFuZV4HCxYJLhfwPgTUQhhOGmW1qm3fMsXL/eH+Nr/abRPAZoEkn4FpoQQVOQ4f6O7cmD
	JkblE1y7Bk7U8jauGfCaE30cIbxwALNxgGs85N7DzajURUKtW3t7VaAlZSOQUBn6LVQYWmi1DVzJd
	l8o86EHRY33pO6GRQm5T3kXIszXUom0wZOZjWZGJa24ooZKUVcl2Dho0RDaeQiuh4T/s/+aQ9OclF
	A6Uzu76aRDu27pmIKsMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glaj5-0005sn-L6; Mon, 21 Jan 2019 14:38:59 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glaj0-0005rk-QD
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 14:38:56 +0000
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; d="scan'208";a="25760302"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2019 07:38:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 21 Jan 2019 07:38:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P5fzxLdAxFCcIQmqkZrgpoN8vDnKPCQuB1hGhe4c74=;
 b=V0JbKZy9jo0xbTNTPJCyrABZ/6Yjm1jwNUG84nPe6fY44AX+thrNYb8KhMMbMGSy0Gf9mXB98lIqVt0QOCHPxHLNYvPHIehvuVsRRypNbzF7YyoY6w0PQHizHNzX9+FPYEXCTpiGq5kxFVezaGe3W4RF0hROIcF5AeOT7FbciHg=
Received: from DM5PR11MB1257.namprd11.prod.outlook.com (10.168.108.11) by
 DM5PR11MB1417.namprd11.prod.outlook.com (10.168.104.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 14:38:47 +0000
Received: from DM5PR11MB1257.namprd11.prod.outlook.com
 ([fe80::3437:d1a8:fda4:a881]) by DM5PR11MB1257.namprd11.prod.outlook.com
 ([fe80::3437:d1a8:fda4:a881%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 14:38:47 +0000
From: <Codrin.Ciubotariu@microchip.com>
To: <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel as
 in use
Thread-Topic: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Thread-Index: AQHUrn8vO/Ym+tRt40+WbUu3tf2aBaW4AseAgAHOTIA=
Date: Mon, 21 Jan 2019 14:38:47 +0000
Message-ID: <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
 <20190120110417.GS4635@vkoul-mobl>
In-Reply-To: <20190120110417.GS4635@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0392.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::20) To DM5PR11MB1257.namprd11.prod.outlook.com
 (2603:10b6:3:14::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR11MB1417;
 6:XCjIrZu/FB0d5vNr9bb+r2fwjNGZWDpxqI2o8BIWRUpdACVriKrUTvS7CX90loP+2AaXSGCvWl6EfMjnPcAtNo0EFYct7CJEel/Z+7JUYx3Bqxb38Wj4RBNAE/MnLs8s3vyfQDlalDyhAnRg54SOBND0Eb8a+nhP5cACRWUyevh93LukSFHHfFgwW2eV7rhlD3QxF5iGmrGHhyxgNYjD1U/I0zj+WB7Df3TiKz9FOO9spkGAzlG+qwJbcdY6x3F18M1OJNj5IVtbwiZCk7Fxb+RzJfcyv/QnggDvbST67NPvgWqCARdWbxS8s+EYETEqKbecjxFnbLynihg2itVklqDq1OCF8xH35bAwaQgRXROD7Ax9gEs0ww8arCa606htgRLTBVV6pTVEnqrG25e5Iw6n2LmiOmh5akHJRgowAz31wkECWIjb2xmU9MpNChiib4R/H9lXCvzbvLf64SsOfA==;
 5:G7MU/lBmUrtbk/wtbYvRbdHGCP/t87MwL564UHSWt9Cm/ci6CcQCQue1Fnn2dT+E/JyrsEAQBTU0y8cS7SEz2eAwpQViMXR110KFpw8I18eDgcFps7os2D/huFtjBJtLREtiKhqX8nriBt1P1AI52e8k9tZlaQETmyTpLgRbcK1eN1SDmC256Thgoei/awCOLow7OL+2+0XGECApi65CJQ==;
 7:Mo4Uq/lSwbLGaJoM+MXPA43cm7img+7FOixCCK0hjv5h8fIELC8UMTbaX3q9owRoSuf5dKX/pYl3a2MrQiupp51ytBPAZ9dzSlwcuOGdFB18jwgCN7VuNPihnZ0BXVoxosPn2j/GyxNYwFLqqO6QgA==
x-ms-office365-filtering-correlation-id: 0f7dd48f-1916-4818-56df-08d67fae26cd
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR11MB1417; 
x-ms-traffictypediagnostic: DM5PR11MB1417:
x-microsoft-antispam-prvs: <DM5PR11MB1417710CFBCD5E577136550FE79F0@DM5PR11MB1417.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(478600001)(81156014)(31686004)(81166006)(105586002)(8936002)(106356001)(2906002)(6116002)(3846002)(8676002)(14454004)(36756003)(229853002)(99286004)(4326008)(72206003)(6916009)(68736007)(6486002)(71190400001)(71200400001)(6436002)(53936002)(6512007)(316002)(52116002)(486006)(6246003)(476003)(7736002)(2616005)(54906003)(6506007)(25786009)(305945005)(97736004)(446003)(11346002)(26005)(53546011)(31696002)(186003)(102836004)(14444005)(256004)(386003)(66066001)(76176011)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR11MB1417;
 H:DM5PR11MB1257.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ALw61F+njE7MRWx9p93yOLngOmD0eEZNjVUNl7K9kzkyY/BCjdPER339cfUVhJEFiNrqsrvmXKOrXV5rHDwHVJV+IbhSdfhD5+Oovhgh/ClIMyuX1D5oV60CgD0/WtaBeGPX6NuFeUu4d43onBBbR/lBYGWxHm+mw2Dmv690cTjiX3LLbw2Y48iKjHV1d64Sx5vRb+xxPdKVGrup9De8Pkx7V+JYLDe6rD9teilyN/cvGGnCrwU+jZwph/Z2ue2g/757TI1NEbjOsDIri3VjwaOhLks5zWxDV4RjDQHPjztXYtql0qZK7IFj+K3qwuXGm7W349W7jmectszRABqeoCfOm5m34QYlL5tVf+1RDwnbGW1Bmho2zsVDc5zxJjtPxq1uV+rhJMMExFzsi/vzifVGtqSbSqSqUHaiZ6yzgZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <CBDC3F9482FDA943AA6B6ADE473DF109@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7dd48f-1916-4818-56df-08d67fae26cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 14:38:45.8407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1417
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_063854_959507_2F45257D 
X-CRM114-Status: GOOD (  22.06  )
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
Cc: dmaengine@vger.kernel.org, Ludovic.Desroches@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20.01.2019 13:04, Vinod Koul wrote:
> Hi Codrin,
> 
> On 17-01-19, 16:10, Codrin.Ciubotariu@microchip.com wrote:
>> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>
>> atchan->status is used for two things:
>>   - pass channel interrupts status from interrupt handler to tasklet;
>>   - channel information like whether it is cyclic or paused;
>>
>> Since these operations have nothing in common, this patch adds a
>> different struct member to keep the interrupts status.
>>
>> Fixes a bug in which a channel is wrongfully reported as in use when
>> trying to obtain a new descriptior for a previously used cyclic channel.
> 
> This looks reasonable but am unable to see how the bug is fixed. Perhaps
> would be great to split the bug part (which can go to fixes) and remove
> the reuse of variable as a subsequent patch..

Hi Vinod,

This patch is the fix, since it moves the operations on atchan->status, 
in which the interrupt status register is saved, to a different member 
(irq_status). The AT_XDMAC_CHAN_IS_CYCLIC and AT_XDMAC_CHAN_IS_PAUSED 
bits have nothing in common with the interrupt status register.

The bug reproduces when a device_terminate_all() is called, 
(AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End 
of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of 
atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when 
a new descriptor for a cyclic transfer is created, the driver reports 
the channel as in use:

if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
	dev_err(chan2dev(chan), "channel currently used\n");
	return NULL;
}

I can send v2 if you consider the commit message misleading.

Best regards,
Codrin

> 
>>
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
>>   drivers/dma/at_xdmac.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
>> index 4e557684f792..fe69dccfa0c0 100644
>> --- a/drivers/dma/at_xdmac.c
>> +++ b/drivers/dma/at_xdmac.c
>> @@ -203,6 +203,7 @@ struct at_xdmac_chan {
>>   	u32				save_cim;
>>   	u32				save_cnda;
>>   	u32				save_cndc;
>> +	u32				irq_status;
>>   	unsigned long			status;
>>   	struct tasklet_struct		tasklet;
>>   	struct dma_slave_config		sconfig;
>> @@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
>>   	struct at_xdmac_desc	*desc;
>>   	u32			error_mask;
>>   
>> -	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
>> -		 __func__, atchan->status);
>> +	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
>> +		__func__, atchan->irq_status);
>>   
>>   	error_mask = AT_XDMAC_CIS_RBEIS
>>   		     | AT_XDMAC_CIS_WBEIS
>> @@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
>>   
>>   	if (at_xdmac_chan_is_cyclic(atchan)) {
>>   		at_xdmac_handle_cyclic(atchan);
>> -	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
>> -		   || (atchan->status & error_mask)) {
>> +	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
>> +		   || (atchan->irq_status & error_mask)) {
>>   		struct dma_async_tx_descriptor  *txd;
>>   
>> -		if (atchan->status & AT_XDMAC_CIS_RBEIS)
>> +		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
>>   			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
>> -		if (atchan->status & AT_XDMAC_CIS_WBEIS)
>> +		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
>>   			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
>> -		if (atchan->status & AT_XDMAC_CIS_ROIS)
>> +		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
>>   			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
>>   
>>   		spin_lock(&atchan->lock);
>> @@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>>   			atchan = &atxdmac->chan[i];
>>   			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
>>   			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
>> -			atchan->status = chan_status & chan_imr;
>> +			atchan->irq_status = chan_status & chan_imr;
>>   			dev_vdbg(atxdmac->dma.dev,
>>   				 "%s: chan%d: imr=0x%x, status=0x%x\n",
>>   				 __func__, i, chan_imr, chan_status);
>> @@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>>   				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
>>   				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
>>   
>> -			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
>> +			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
>>   				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
>>   
>>   			tasklet_schedule(&atchan->tasklet);
>> -- 
>> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
