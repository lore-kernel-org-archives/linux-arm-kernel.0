Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92042C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:46:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593BB20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHKCONX8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMZb/pF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593BB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R1x+4rhOaSAtWOLpRZiLM9gvoOpq+Neol+GxPBttpX8=; b=EHKCONX8b386vL
	1/4axxX7Bx2yhtWJ0/uYhdHcQ/vCQBtATcuIWfSTqJT3T8NZx1yBhbAtfFYF1yiV6rtD21JjcYkN1
	d571Ji46EWI03d0t9/Y/QIa1IT6Nyyuo/DhKOjxkocCkoiGF1LYPEr1WDxfFBNvUUtP+EIm/8X/dA
	MyFezabL5VscLNMH6BJB5oMa4Wuv/eg5jgvSC2W3f9UJGG8SSUoeRCm8JxiQTx2PQUc9+UK/HeE8S
	z2x6f70me1MBu3lsO0CDkyiPxZkmdF5VZixlL9PbxQpEvBVx5Hsc95/b3aqLEaeXYJpWDQEZkv3Fb
	sYnUXm85Z3hUcja+YqlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYqPr-0005mw-Pc; Mon, 17 Dec 2018 10:46:27 +0000
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYqPo-0005lp-JL
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywSyVKzvZmQ1853Jc81+cpkTcp4zUBRtSDXt24DS9mM=;
 b=SMZb/pF+Md9njpmGz8+9FdcJkkpAmthZ5DVm2y7d7fEq8OM8pzXkFqF5K1YmIW3+z1pDt8nRd/0V6oVOSprav6YPOUZDXbaB6MWzoADW5JGj2ScASx3hCzBwenttqYTevInPygPCoXMYzDz0WIf6QqYx9+Y9LJQemG7cdFzttr8=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4400.eurprd04.prod.outlook.com (20.177.55.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 10:46:10 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::116d:6493:b392:f7ca]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::116d:6493:b392:f7ca%5]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:46:10 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [PATCH 0/5] soc: fsl: add device links support for devices on the
 fsl-mc bus
Thread-Topic: [PATCH 0/5] soc: fsl: add device links support for devices on
 the fsl-mc bus
Thread-Index: AQHUkKht9srZH6NoRk2FfJWJEHs4daWCyTSQ
Date: Mon, 17 Dec 2018 10:46:09 +0000
Message-ID: <VI1PR04MB5134CA944F8258091AB40541ECBC0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4400;
 6:miRqneAWyWmq9s5UQmp+/PGZxM6kLGiKiZLi0yoj74uXXlFMBKi4J+5fWxsDrOx6bxHeCKsv+K+PLan+LOjofyzwkQHYMBFgqLJF+i8RuFr4m/yscXIhpaK602fjzdQMlQEwmUxxRojT3YRdsK9xIXVuVwxMArqS0s+S0G8GVtjHqOaJnk+kUI2XyDHUJoay0v+Etf5BErUINRqETzXzVL9Flkkg1MZPmeR1NQaTTJorpAIE+5JFZhQm3RJr6QNNNfdIR6El27eSdEjkSaUgH2fC4VM9RZ0SJ2se1g5dYMO12ntQll8eKFMX0NeS8wFhvq6+MOwh5PE+u7o4nsO+ODLEieu9Wch2vZmZNkmiH6ywQ87h8Z3hV+z9uenMOtGqw9KaGzMC8VxicZWFe5zOnHqIL90wfnByo9EmRW+sgh8mac5qEBa+AsBGqg0YzE9XGju4x+F3Z6kI4DH9UOEtYA==;
 5:hVeeHlxDOtTbroyntHYBViYfcGTkpIjP9JMdHp/ZLWinM2H6YW1tq/7LQk6eET9S7aCM8r+4XGSzOBeSgCCHbAgez7cS5Y+p5N/OasaDa02F2S2W0L6/ZBqE0Z8Omrqc3oYIhPy0yPsOATpG+aYrnesATwYbgrB3TKWZW91CCsY=;
 7:4Q2NClYqCkn/asLbJ15A5aGJablEYRiEe4PpHLnavmxzUvQ3BJnLQqTHwEpENGfnwgr5hw4r9vKaTEkqjAJctAZHF2KmV0B9UVaGWV4R6cm1SwPHM7VNEqHK57J5ju6uK/ILS3dBTJL9MEtih1kq2A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e1c39fcf-f6f5-4726-e560-08d6640cdb43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4400; 
x-ms-traffictypediagnostic: VI1PR04MB4400:
x-microsoft-antispam-prvs: <VI1PR04MB44005D02FB1B95BD32D34038ECBC0@VI1PR04MB4400.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4400; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4400; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(13464003)(199004)(189003)(256004)(33656002)(229853002)(68736007)(476003)(74316002)(7736002)(71190400001)(71200400001)(186003)(106356001)(54906003)(86362001)(4326008)(14444005)(44832011)(2201001)(446003)(14454004)(99286004)(486006)(11346002)(110136005)(305945005)(2906002)(55016002)(97736004)(53936002)(2501003)(6116002)(3846002)(6246003)(316002)(105586002)(102836004)(6436002)(9686003)(7696005)(8676002)(66066001)(478600001)(76176011)(81156014)(81166006)(6506007)(25786009)(26005)(8936002)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4400;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kE9RT67xb4lRwSPRbSY8+CNQjvmzON+MQrMIhELYdTBmO88o4DmmMxlwy33XwUa8cwMpHRBI1jHMqYkWG4cy5hYSKn7KiTttkrEy65fmQnBcABfmOhN8HJ4I9OCFP52GTqtzeiyqcz3rjvPUF+thxxsD5IPUs9odY7q9fLJ4RRGimrwjCPxoNtqmTw5dhXfzpov/RBacpHd1OBeaA1+mBr/j08WVexYCt70PeVA/9y6mvinxXONiQJZ5pc1eEbw51/FXYHeLJ6/e6eL7qkLktYkPVzzNVYLZASvlXgRfqDvmAWxpN2f09axOXWKPu2hj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c39fcf-f6f5-4726-e560-08d6640cdb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:46:09.8827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4400
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_024624_639707_F4F60711 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Ioana Ciornei
> Sent: Monday, December 10, 2018 6:50 PM
> 
> The fsl-mc bus discovers and exports devices dynamically allocated
> by the Management Complex firmware.
> This patch set adds the ability to automatically create a device link
> between a consumer device on the fsl-mc bus and a supplier one.
> For example, a dpni device (a network interface) requests access to a
> dpio device (I/O portal) using the dpaa2_io_service_register function
> which is enhanced to also add the corresponding device link between
> them.
> 
> The first 3 patches set the stage for a proper handling of device
> links while the following 2 are the ones that add the actual links.
> 
> The internal management of the links is not exported to the consumer
> driver, but it's rather included in the functions that actually allocate
> the provider device: fsl_mc_portal_allocate, fsl_mc_object_allocate and
> dpaa2_io_service_register.
> 
> Ioana Ciornei (4):
>   soc: fsl: dpio: keep a per dpio device MC portal
>   soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io
>   soc: fsl: dpio: add a device_link at dpaa2_io_service_register
>   bus: fsl-mc: automatically add a device_link on
>     fsl_mc_[portal,object]_allocate
> 
> Roy Pledge (1):
>   soc: fsl: dpio: perform DPIO Reset on Probe
> 
>  drivers/bus/fsl-mc/fsl-mc-allocator.c            | 11 +++++++++++
>  drivers/bus/fsl-mc/mc-io.c                       | 13 +++++++++++++
>  drivers/crypto/caam/caamalg_qi2.c                |  6 +++---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 +++++----
>  drivers/soc/fsl/dpio/dpio-cmd.h                  |  1 +
>  drivers/soc/fsl/dpio/dpio-driver.c               | 18 +++++++++---------
>  drivers/soc/fsl/dpio/dpio-service.c              | 23
> ++++++++++++++++++++---
>  drivers/soc/fsl/dpio/dpio.c                      | 23
> +++++++++++++++++++++++
>  drivers/soc/fsl/dpio/dpio.h                      |  4 ++++
>  include/linux/fsl/mc.h                           |  1 +
>  include/soc/fsl/dpaa2-io.h                       |  9 ++++++---
>  11 files changed, 96 insertions(+), 22 deletions(-)

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
