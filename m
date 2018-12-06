Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A630A20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kD6WTozF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aNKtgha8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DzQGuP/hXwBr0UNbOqI0OXpa7kF13OtGTuFxbIzRNNc=; b=kD6WTozFNBQKH7
	MKe7HltoMlWN75oBGfPtH8rB7wTYb/vT8w7WSC7o3yYCKLoQczOy1pxzkzbZj19kyFeGVveLD5KmI
	ZC7cnIeekveYyN5EWJHhJ57vUsH36FgzKUkr4KnbB5XSdfFuGmMm5ZiGRWwv/2j0Z/0RZtmv+hoDw
	HPCCGnpVMQBZYzb/LBJUNLzXgv+RQSzLbQK3qzq0BdSasJAZbFtVTLVP7ICqFECf0gsCq1O1siap+
	CcFtQSEl2HmQ43nRYtMThotEYRWMnxTLYT+E20+r26eSQNYqTp0A6lxKmNBiFCz4BFTDdWsdJi2Fp
	E9MiGRTMn356Mi0mwQqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV08E-00044T-Gx; Thu, 06 Dec 2018 20:20:22 +0000
Received: from mail-co1nam03on0721.outbound.protection.outlook.com
 ([2a01:111:f400:fe48::721]
 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV08B-00036y-Id
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:20:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9eliro8QS7lXIM0GF4ySg+5dSdoikSEeyYZXNc70fY=;
 b=aNKtgha8aNH1bCQo8pigplhSR/wCrnRBBxC7PXho9VMNwOl6ldtJefUqZ9L1Tt5fAQZQAhm7M3lPzoR56W9HZ2Te53VIofF+0lY1s8/L0fFe6evofLEDUcG7G5QX5+As/WQBJzIQS+DeMlQtAnjCUP8snqUzTxsFO4hW1d6aasM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3625.namprd06.prod.outlook.com (10.167.236.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 20:20:01 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 20:20:01 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Thread-Topic: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Thread-Index: AQHUjTfBbQvVAJ6kdke01R/lWmbrWaVxgowAgAClJAA=
Date: Thu, 6 Dec 2018 20:20:01 +0000
Message-ID: <1544127600.18519.175.camel@impinj.com>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
In-Reply-To: <1544092136.3709.57.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3625;
 6:TD5+BQkZ66rTM/cVfgiYSuHCZr/vB9NjH4uUnlLWQtDM8+KYlJjBDl79frbdE0voFyZuZRi6khrRjsan0AefIqo61UsY4t4V74/zEHYLVXAMEwRABprsIndoojyV7HX3fbNw955YOqgSBEctspTJLK2HnkM7mNsDyGEHmqPiLWlAiIWCGxtPp1v13wc6bBAZim+8jqWcAUtOInr92lgbsznuq+tLo9bmF3lbeQ/2D4a63d4cqvyn90RDktzQypb8j8aJUYpaE8W7uMwBD8HiIqUrwUETh0cDG6pZYSv/OR8Sclwg8TPyvojwc3F9+LKBEc1lfnidPkgqL0GuRwVp1CjQMFzwog+5OzT+gFQxq3v/3vdM6y2NIikvop/MdEdkmAqqKWl7OmdpkFUbRanXut+T3p+RVEFsRY/LSWAx/+Q8Wlq0YRyELxY2lhSTLQ/uiOE+Tzs/1+bnqy7CA3pq7Q==;
 5:izPJUL8Bpd1pJYyOkY0+e1lWkaL4JMyR6Ihk+oEq+N7E/kjLvqn62+8C+AE6MM+edeCbp7Pp1bSSkqFJ8bby5j23OeqUugue15vJeAEr+zg6oHLJpx8QzjMFx/IGPxw6+uhM1bmCj6J74y/3qXRr40oJC21TXt3y1SdT5gO6sJM=;
 7:hQSjBUaUI/031Ad//vlpX8yPA6+EJ7oP+NoWD8WkAmMte2O4loC2Auo8ZVB4raGhZoEcNubpA2AnZ3sSrHcnlcBN18XOTW1OVkmZ4rKL+eYRbComRLyIt+38OcWubeduSFSel3PRBCsKei+w38QD9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b7f2a6c-bad8-44b6-bc25-08d65bb8338a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3625; 
x-ms-traffictypediagnostic: MWHPR0601MB3625:
x-microsoft-antispam-prvs: <MWHPR0601MB36259BCF7E262A97852893AAD3A90@MWHPR0601MB3625.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR0601MB3625; BCL:0; PCL:0; RULEID:; SRVR:MWHPR0601MB3625; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(39850400004)(396003)(346002)(136003)(376002)(189003)(199004)(2616005)(11346002)(446003)(966005)(476003)(14454004)(66066001)(76176011)(7416002)(4326008)(8936002)(105586002)(486006)(2501003)(478600001)(6486002)(6436002)(6116002)(39060400002)(5660300001)(3846002)(71200400001)(71190400001)(305945005)(5024004)(99286004)(68736007)(2906002)(229853002)(316002)(103116003)(6512007)(86362001)(256004)(106356001)(53936002)(186003)(2201001)(54906003)(6246003)(8676002)(97736004)(81156014)(6306002)(26005)(7736002)(81166006)(25786009)(110136005)(102836004)(6506007)(36756003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3625;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xjzv7B7aprDrA0GrybGQgk/Ahxda41amJNmDK5I11dPRgdK8r4efXSnUeR/5dy57wn420rr16qsWXm2xi3DiTmck6rp8+r0cO2cY/NdVciCsLwC32ZryPv4d+4rgyKDgoO0aGuiyqsuAr1nhy3EWKjcfThqrwIDED2W0OPs2QOOfsyV7sz9pxeIJVh+GJrbEGPqmiP3eShfYYS0riKedp09jBV+oQfQB4PO65yd2aIZj9B2QgYlkLtIdbF5KECQbBU+JKQ+fWN7MlNvh6gnr9l2xFUPEvXs7bmu0C3YvgLpeDZQH8DrTwIuS8aLgIf2dKPtL1FjvxjvH0aBfSBKg2nLRYqo+OPk1OaFWOv+whwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3B4DF0C2968DBE4793149EDF8E3E488F@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f2a6c-bad8-44b6-bc25-08d65bb8338a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 20:20:01.5233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3625
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_122019_675129_11A58A9E 
X-CRM114-Status: GOOD (  16.85  )
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
Cc: "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cphealy@gmail.com" <cphealy@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2018-12-06 at 11:28 +0100, Lucas Stach wrote:
> Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> > Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> > produces a system where built-in PCIE bridge (16c3:abcd) isn't
> > bound
> > to pcieport driver. This, in turn, results in a PCIE bus that is
> > capable of enumerating attached PCIE device, but lacks functional
> > interrupt support.
> 
> This is odd. AFAIK PCI port services are a totally optional thing and
> them being absent should not lead to a non-functional PCI bus. So I
> would really like to see some deeper analysis what is going on here.

I noticed this previously, 
https://www.spinics.net/lists/linux-pci/msg77840.html

What happened was that PCIEPORTBUS *was* selected by all the platform
dwc drivers and those selections were removed in:

commit f3fdfc4ac3a26865e84627a7fe08a906081e5abc
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri May 18 15:08:36 2018 -0500

    PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS
    
    Host bridge drivers do not use the portdrv interfaces (struct pcie_device,
    struct pcie_port_service_driver, pcie_port_service_register(), etc), and
    they should not select CONFIG_PCIEPORTBUS.

I encountered this when a kernel defconfig that previously turned on
PCIEPORTBUS stopped turning in on, resulting in the situation that
Andrey describes:  no errors, device present, but no MSI interrupts.

The in kernel defconfigs (mine not being one of those) for all the dwc
pcie users should probably be refreshed to enable pcieportbus.

It seems appropriate that the port services are optional and it's
unfortunate that the kernel defconfig system resolves in the change in
this manner, vs keeping pcieportbus on by default.  I do know why it is
this way and I don't think there is any great solution there.

It has never been clear to me why pcieportbus was necessary for MSI.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
