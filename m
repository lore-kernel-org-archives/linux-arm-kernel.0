Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03323C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2484206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYIG9cCC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YgSytZb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2484206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=78pDw5HWmFbkvpwBMegNVVpQPyh8Q61tXBfEA79kf9Y=; b=XYIG9cCCdTayS6
	JoHAua7dj9lXH7nzMo7Bk2pFp1zM+i5SqEC9iOwl/dIzA40prM/PK5ttLPaAE8sUm8om5C7lHp3Ol
	y/EVIsuIYQ81N4U/dV5JENKH631fD8YTFfZ4WAta5l7FEbZwHr2sa/oReL6P74KyiMj4MU6WFsCOp
	eqFJ46QxfE3H5WJuZVXGBt+rSwajqgl2v6UnkFmkCMS4rDwwt50heHD7XOMbqiltMqK5Vo8U1kEUs
	CCPP4PDHcd1mF+rxvxHV/eHdWhFD7wxpRmNVW4RRAXdP0l4IexirR+q0kmXcMf7dtlg8unz/d54nz
	KM48R2tdACWlYDPM2oJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDIp-0004E6-Nc; Wed, 09 Jan 2019 12:49:47 +0000
Received: from mail-eopbgr710062.outbound.protection.outlook.com
 ([40.107.71.62] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDIb-0003zK-92
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njhheSGyZeWo0HGDdVNkytxO42E9YqT5KBwaKloUzxQ=;
 b=YgSytZb7ZCtl0Z3MCKG5e3dppGCoGZnpMH25G9Yrgg4Z6DqsahxX6uCkgFGWTEQX6MLJQhHJcmQWnSIC2wDKj3/No38V/hp0PfzYiwdHNBs387uVi7y5Pe6GW61T9j1GeE0JCaCsZq4kjGA8Nfk1+1PM/IL1Ti71xNsDZ8+bY5U=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3531.namprd02.prod.outlook.com (10.167.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 12:49:29 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::d493:42:780e:8d08]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::d493:42:780e:8d08%3]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 12:49:27 +0000
From: Radhey Shyam Pandey <radheys@xilinx.com>
To: YueHaibing <yuehaibing@huawei.com>, Vinod Koul <vkoul@kernel.org>, Dan
 Williams <dan.j.williams@intel.com>, Michal Simek <michals@xilinx.com>,
 Andrea Merello <andrea.merello@gmail.com>, Appana Durga Kedareswara Rao
 <appanad@xilinx.com>
Subject: RE: [PATCH -next] dmaengine: xilinx_dma: remove set but not used
 variable 'tail_segment'
Thread-Topic: [PATCH -next] dmaengine: xilinx_dma: remove set but not used
 variable 'tail_segment'
Thread-Index: AQHUqBN24V/NdvLqB0Kq1h2ulYqcsaWm4aqQ
Date: Wed, 9 Jan 2019 12:49:27 +0000
Message-ID: <MWHPR0201MB3628A0C417F4E28E03EFC422C78B0@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1547035837-87800-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1547035837-87800-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0201MB3531;
 6:Xx0NguFQqCvRHLk/6woqEiNkQJWxrDBnDUB3jaqyxvLC30obhuF2fjn48LJ87jjohMUJWnrHjTUswk6tjwku2ZYwpywMXlg7uJeZvFisOcReTGcJhO13wBRcKVGgPJBgxnK7By36ekHDVFy3ykqOkaqEHJD321OTOofP+ovSMCXdkaswwDDCnE9VFIgJzTYvSnb/7MLWoHL4dCaUNq4csDe5cxPVZHdQ3ziGzSR2Z+DlEkU53XAOGfUe4oeNPAIJ6hSrjbNYKc3WQKnb5Bdy8boXdKZyHsWzB/1kUuAeJ9bLXlqfKl1aSw9fnfwiLPeanaNwX26TguEERsrO8ZPHXyZu15U6EcBBxPdP1Sv1Lujk3DznTKbU1PY7yMsMlcyKW8fMOIXw8pnvne5cCaJjEd9j/KosjlS+WAmjUs29tLhI/KOdYhIyB+BRbzEUD1KpQCMHKCaf8znD27+zELAkLw==;
 5:GWusjlSJHccH9o6LkkoR2yMtswdjVr7sIQhKvHka5kKhXMq5TF9W0ZxOTc4HmeNEZeO/4UgH0Z7uUH/vA4yy1ej35aKCT7bTFmrzXGv1oPu6fkBxzAWP1VOVrA6rogwkd1vdJC9ECQRnoogsRO8mTaRxmG9Ro08RcOuGNneHILQPcOYMt/OnVFTfV09PwnTKEaCgb5wy+xNLiaxo+9LPew==;
 7:Ih/mZxzK07NsObdWvyq6qc84weY1gG0gWBA4Kxcw32JVHQBtAvZ5sdtrLsKhbmWKNjOXihFGoMbz048T1l8cEbPUZbAPLwS9OQq4zDVpaOo+oXMuVDmAVQUUyKfSMdltXhDrwYhwTUgvBAbHa2cbzA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(51914003)(199004)(189003)(13464003)(9686003)(33656002)(5660300001)(6506007)(7736002)(53546011)(71200400001)(71190400001)(305945005)(7696005)(105586002)(106356001)(6246003)(99286004)(478600001)(14454004)(39060400002)(4326008)(25786009)(53936002)(6116002)(3846002)(6636002)(76176011)(14444005)(74316002)(256004)(110136005)(26005)(8936002)(54906003)(186003)(86362001)(6436002)(81166006)(81156014)(8676002)(476003)(2906002)(486006)(97736004)(102836004)(66066001)(316002)(446003)(68736007)(229853002)(55016002)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR0201MB3531;
 H:MWHPR0201MB3628.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: d2822652-30de-4416-ab03-08d67630e425
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0201MB3531; 
x-ms-traffictypediagnostic: MWHPR0201MB3531:
x-microsoft-antispam-prvs: <MWHPR0201MB3531C5D16536A72B51CBF4C1C78B0@MWHPR0201MB3531.namprd02.prod.outlook.com>
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a+80teVmgahYh6MSvuUQOdEDnmm7fUpO1MuJYsd/ZBIGKyPn7f9uTJGIupoRXJ4qRMk/eFfHQDHCbkiLeEb5InUXIcvYH91MkpJp4dGj7vxqYWXUZax9n/tPPBeUMvD9lrpidjJ1O+pmZYFUKnN0JvtNIAkR7iuuoeMGSvQRsOpqtCe7J9VqIFt7t7fKK1SmvnKyJITBAh7pT8sHNAMc8Y8Muw9DhCQ/PM0jOIVU8Myy2uHE3UtHdNBBJInwGM8c0dCeD4H/SdNPj8bWMljp4/KZigKKcCeRJAvLNSiphfvppZeKFgGHXQeIzNCOPMtV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2822652-30de-4416-ab03-08d67630e425
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 12:49:27.5764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3531
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_044933_652218_75D85237 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Wednesday, January 9, 2019 5:41 PM
> To: Vinod Koul <vkoul@kernel.org>; Dan Williams
> <dan.j.williams@intel.com>; Michal Simek <michals@xilinx.com>; Radhey
> Shyam Pandey <radheys@xilinx.com>; Andrea Merello
> <andrea.merello@gmail.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>
> Cc: YueHaibing <yuehaibing@huawei.com>; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH -next] dmaengine: xilinx_dma: remove set but not used
> variable 'tail_segment'
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/dma/xilinx/xilinx_dma.c: In function 'xilinx_vdma_start_transfer':
> drivers/dma/xilinx/xilinx_dma.c:1104:33: warning:
>  variable 'tail_segment' set but not used [-Wunused-but-set-variable]
> 
> It not used since commit b8349172b400 ("dmaengine: xilinx_dma: Drop SG
> support
> for VDMA IP")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Thanks for the patch.
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

> ---
>  drivers/dma/xilinx/xilinx_dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index d9431af..c8acd34 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1101,7 +1101,6 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
>  	struct xilinx_vdma_config *config = &chan->config;
>  	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
>  	u32 reg, j;
> -	struct xilinx_vdma_tx_segment *tail_segment;
>  	struct xilinx_vdma_tx_segment *segment, *last = NULL;
>  	int i = 0;
> 
> @@ -1120,9 +1119,6 @@ static void xilinx_vdma_start_transfer(struct
> xilinx_dma_chan *chan)
>  	tail_desc = list_last_entry(&chan->pending_list,
>  				    struct xilinx_dma_tx_descriptor, node);
> 
> -	tail_segment = list_last_entry(&tail_desc->segments,
> -				       struct xilinx_vdma_tx_segment, node);
> -
>  	/* Configure the hardware using info in the config structure */
>  	if (chan->has_vflip) {
>  		reg = dma_read(chan,
> XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
