Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED3C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:44:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93E7218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgyEb8eN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ebxOY1FL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93E7218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=az+SxbN/fgjlKC3PTTPxk9t6m3noSO65LgkOYRr8EqM=; b=pgyEb8eNcwHf6u
	xf/kpf/rDrm/vEcq6IVTAY3+VbaxSU7RjXN+Y39sSfiey63/Kt1ESdzQcBqKk6riHF0cOnOJOGcxt
	PExqtpLeYreTWY2R/uMc9zCeibuQzGLaQXSnZe+dDz30OWx3NdtPXkvxOj7v6G/td06PZ6tb5qsuE
	z6+ORjWv89XcyUTx436uSNmvuKVaFa309crNeL48Jw8GQvoPl+MislM9IpEoS0F5Em+Hqkdi9+/h9
	TGxpR5m3G9SKFEe0TkS4IUhkDz/5Jt5LsnISNiy6RFbEC1voNBzbJyrrzzcbDJgOyztxPa9UIVEMF
	3SmqF450t82kacI+aKXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpdnw-0006Lt-Hb; Fri, 01 Feb 2019 18:44:44 +0000
Received: from mail-by2nam03on062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe4a::62b]
 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpdnt-0006LJ-5o
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 18:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZPsEzV89MSjR+VTWriG9XU0pf0YtNNcJd8IPHgd0+I=;
 b=ebxOY1FL1noftYGS21yivw7NbIt3qu/YczQNUvdNA3pVp+apFXQT0M75Yxs9v3fyxGes7jJALq09el+29ryhIa+u9/1j08ErI1wXHMQQ/8m8mo7Q5e50vUDjH7g77OzTKc+tk1N13qX6Hlw0/xN+fZ6oXxJUnnmvaQiTSbl9g2c=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4951.namprd02.prod.outlook.com (52.135.234.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 18:44:36 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 18:44:36 +0000
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Topic: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Index: AQHUuBKpstebeIDlnU+HyCPR79whuqXHmH8AgAIlFZCAASG2gIAAahHA
Date: Fri, 1 Feb 2019 18:44:36 +0000
Message-ID: <BYAPR02MB5992A4D0347DF535569DBC4EB8920@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
 <20190130101236.GA27201@e107155-lin>
 <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20190201121445.GD10042@e107155-lin>
In-Reply-To: <20190201121445.GD10042@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR02MB4951;
 6:KLOSuhPVsCDj4UkUBnsJYz3GoJICnYBSBX8jbrKbp/7d3BPn+pi6uZOVT5sY1knEgi6DdWazx+Lh/+6BjHkNdDhbzU9Of2hLWTvUj2Tng3sxbNyNSMFQfrgXGAqBPbtcIvWPVP9M93EH9gRC8oOmR5y4NE+KmF3ulLiU/vQozhdZ+T5uyYCenbhTCsSSB0j+rO5gmc5XbIsVOcP3RLc1+yhBh33SnYCNKFiwGGWPHe8PJMtKlS+3CD93NOTmLh85DDpyBO5ArhYYeU6hRfITYxbycvhOA8QFjiJ6O2M2ShCygIWbPyTl71iG0epK4ESKcGpZSQ8vTjAPjQLvdPxevu7Y4tOJ1+iKrmM3ZbF9aLadQMuWnpNyGOuvaG/4FWUDZN/czj+Q7i03sLHvNZcLZMer/YZFQ4GsJbEsxfHc4RXrF6n5gPp59B15lym7/uWNSKncZkBgibF24qV0ZES0Iw==;
 5:Nfcbfjbsh1NpAn47CV37SM2tOguYSBWa+lwpTge+gCO4ctkbjBRyPPWmkb7cSIgbCjSHVkphXJDIT/gduSz1KHSlXsPTosPjEazFbbS2DRHxUpiyLsjxsDatuZId1RUzvsT3trPtge/A3x8T2sOPbE+ux2Sg/g1/VbZf/bOhKWj2d0/al2msIfmXNmIHl7KXKsZxsoTt7YnZuzZDXYlI9A==;
 7:QXT59/8M2EAP+b7xm7Tb9p80lSbJcxIOll8NF/FMrXEF5KFFwLS89COOtfsuve1UPATsU7S0TmO+CN6yjpo5++Jm6HNfsM8WgVY+E33qth7gGpR3hX2OXefuM4ByoVXbSkIzOB7vilFIlF2QWsfNTw==
x-ms-office365-filtering-correlation-id: ecac2f8b-18b9-4672-c8db-08d6887550ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR02MB4951; 
x-ms-traffictypediagnostic: BYAPR02MB4951:
x-microsoft-antispam-prvs: <BYAPR02MB4951CAED4823AFA468FB48CAB8920@BYAPR02MB4951.namprd02.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(13464003)(199004)(189003)(478600001)(72206003)(53936002)(102836004)(53546011)(6506007)(71190400001)(33656002)(7416002)(71200400001)(11346002)(446003)(6116002)(6246003)(9686003)(229853002)(14454004)(3846002)(55016002)(86362001)(6436002)(39060400002)(66066001)(105586002)(4326008)(316002)(74316002)(99286004)(26005)(25786009)(7696005)(2906002)(54906003)(305945005)(7736002)(6916009)(97736004)(8936002)(476003)(14444005)(81156014)(81166006)(8676002)(68736007)(256004)(486006)(186003)(76176011)(93886005)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4951;
 H:BYAPR02MB5992.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dfdfNkgMlKFUPRs+FXwE29OxxhauDh8caE6gzs9sxNfegqwKDdr4jmlmw7rUcfVgIzywYAxs4Semgjne4tUaS4d+xfsrjcr97l1fzHKjFAZR7VRVqzBBMXOynjEZAxlZ12HJrDVZsuhWLNQGfMrGETVTGl27DfoJvzfejPS+fgWOBUQqXIwALK/VWA9HoqQeUR4UmVm4RNKgDAcuW912MpPMCPPvTKZCVw5F8dy+KJ9wZY8qdrAGTRUQWnwu89voCHY9P+CjI6bjq9B+6LoRqUd1FyJmwj8vBADE/ePcjkFwlUExAtyraW3qvXsHhd1dJpin01q3opBVUEmYqn6Fq1ml7Rnq/t9UlKAPa0dcsN5Wd8cZPv+Kgadkw3UvIYIHay6MyPzQr4GvT+sHc18dqiIJpjCAd9t5/2WZeGMgt4E=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecac2f8b-18b9-4672-c8db-08d6887550ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 18:44:36.3981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4951
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_104441_260820_0DE20E13 
X-CRM114-Status: GOOD (  12.03  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "andy.gross@linaro.org" <andy.gross@linaro.org>,
 Rajan Vaja <RAJANV@xilinx.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Michal Simek <michals@xilinx.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Friday, February 01, 2019 4:15 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com; Rajan
> Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
> 
> On Thu, Jan 31, 2019 at 07:01:05PM +0000, Jolly Shah wrote:
> > >
> > > NACK, if this is for system suspend/reset ? You can just use exiting
> > > sysfs, no need to create Xilinx specific new ones. Moreover you need to
> > > use PSCI to make sure higher ELs can do orderly suspend/shutdown.
> > >
> >
> > We have power off suspend mode which is not supported by existing sysfs and
> > hence new one is needed. Suspend is handled through PSCI interface only.
> >
> 
> I see only 2 cases supported SUSPEND_SYSTEM_SHUTDOWN and
> SUSPEND_POWER_REQUEST. Both are already support so my NACK still stands.

The 2 cases(SUSPEND_SYSTEM_SHUTDOWN and  SUSPEND_POWER_REQUEST )in isr is for remote suspend.  Sysfs is for self suspend and it supports PM_SUSPEND_MODE_STD and PM_SUSPEND_MODE_POWER_OFF(power off suspend).

Thanks,
Jolly Shah

> 
> --
> Regards,
> Sudeep
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
