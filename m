Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48310C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:46:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F5C214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sdJ0GklR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pcvuZwoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F5C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vopN3yCMXOVQ8WHf67QyZw1cgSRxAotaHoDGdeOK6Us=; b=sdJ0GklRKJUA/J
	ZNUun2HJ25jJi7kT8n6zE+u5L+B2Hucdg83bXcmKQX5vL35B8y+FCzPi3ZyyTHOoSj1z1f0h401AP
	D/7mulhpnyEffKBuhQvTo0GkHqHX69lx9ByBi5CD3+w796I6TNna+6LdSp38DQiB8l4VX4W5De4i3
	67khal33Wf4QvKdKylHictjvg0nrOHZc0iK/yRkPcVQO5OmNXisD/GtYZMLeVcADz+eQNEe4yBp4l
	Rcl6YJPmsT7L/JSR0Ei2UumiOXexVMrb3ZsRGNshxpJOb4m4xlogJJDclqZ0jTbFillPWfChzcHOL
	M47u+ANLidh56Ff9OcPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcF83-00040F-Pe; Wed, 26 Dec 2018 19:46:07 +0000
Received: from mail-eopbgr820108.outbound.protection.outlook.com
 ([40.107.82.108] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcF7z-0003yv-QP
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 19:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug5ndkpkhhUCDSt/gN9KmVoybbEQhZ4UMKvv6mKeCjA=;
 b=pcvuZwoQVaaWqmaOVhNg0kDwY7n1xAEb5lLa99EOl7wqQHZh/gBmBUmwhWKgseH7ieACXHHc6rgs5y+V7cFnCHTWmpX45+TC4OJce2I+Wba3XhZZTYH8aFhO+UulPRC7feD3dEzQ9nacu6+VVvAttpPxyYo4LeCzzD6IQduqz+c=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3723.namprd06.prod.outlook.com (10.167.236.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 19:45:47 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd%7]) with mapi id 15.20.1471.019; Wed, 26 Dec 2018
 19:45:47 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>, 
 "TheSven73@googlemail.com" <TheSven73@googlemail.com>
Subject: Re: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUmOZXutAsHiyvt06v7QdQeB+h1KWRdWMA
Date: Wed, 26 Dec 2018 19:45:47 +0000
Message-ID: <1545853546.7501.10.camel@impinj.com>
References: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3723;
 6:w1sCqZFwsDsnJ1RCP90JgzWYIqMicwW0stKM4lby+qSHSKvzkiL/Neb0r3fNpqXWXZRSVo/9xOF597T9QGvozH9lZo+Oh09TV0CXId019R/eHyR+l1IhEKlFf7ai2GRf9jvSmkIcE0JWOCvRlsZv3seleFB0G50eCVzVK4OgCV/m/39E5UUcZbF09V+/sB9wfaagEFH2QzYxwS+R1ycB1Pbnm1JqcoixxZXOi1nrWT6ohuCy9oFYdVp+qK1sDZk+YP5nKG/qRvCFx3MhR34GDOgeKgCHcRuJGur3UsOfE4S+qMk4yEd0ee5BQN9jXVN+l6+7Z2gpfgdfN4D8xi9E0KhF8WYBLZpbJQlvUQenBAEmR8/PSm7A0EZAZDSIzzVq1ZcAdu14fuS+E9V9L01xzQQWsyi5WMWv4y3xaUBz0ltVs2Zxog2QTLFd/jVl4leAnLnWurv7w9fhom/IjCP0Uw==;
 5:o6W2gT8nsC7FKOdOokGjbecj7wUftZObY9XXokfvHmOMxA0l3SlSAf+W1mbvA9CAgS2U+T0bJxba5t0yD5JxLLrfBioaKQH9fpzcjDp0JzQR4+ecwMAjkBxtRHGPUyO+ksn1lAFaNT7MfI5ptdUmULdOdUtRsyTJIk0tr/yGWd0=;
 7:HjBtMIJIyHbgrT3r3IVvJZEI9lM9Gc6cFhDrZPsa9ZQX31zSnFZTTc/VEntt7G7UtX0P9oa79Y66wQJZxCqmej4PbUPCjyJ6k7zKeM4SinStxbL/LOWqSCK1n67xJy/j6ztoMnze1Z+UQbNWtSgncA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 204c7f3d-c64b-4ebf-47a2-08d66b6abb6a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3723; 
x-ms-traffictypediagnostic: MWHPR0601MB3723:
x-microsoft-antispam-prvs: <MWHPR0601MB372347DE702A693FF2850AB1D3B50@MWHPR0601MB3723.namprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR0601MB3723; BCL:0; PCL:0; RULEID:; SRVR:MWHPR0601MB3723; 
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(396003)(39840400004)(136003)(189003)(199004)(229853002)(6436002)(6486002)(14454004)(71200400001)(71190400001)(478600001)(5660300001)(25786009)(2501003)(97736004)(316002)(4001150100001)(103116003)(36756003)(54906003)(2906002)(68736007)(110136005)(106356001)(105586002)(66066001)(6116002)(3846002)(4326008)(53936002)(305945005)(26005)(99286004)(6506007)(2201001)(102836004)(76176011)(39060400002)(446003)(81156014)(81166006)(186003)(86362001)(486006)(7736002)(11346002)(476003)(6246003)(8936002)(2616005)(14444005)(8676002)(256004)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3723;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQj2r1nOdy3x2RanTgdJXzakp8M3y6K1iEaUXMpK0tSgxMd/EnceUeesmGcb+ajuIkn/jB522eG3e/gup9BeQEpP5xka3exRHYHf9fCLeLobNEjnmR8IdYu3Loy+wCo098nZajiOKsl1ADg3ftT4mgxutUODHD1jkwJukVq/HLP0U0fDkEoU7I89Zr+1ZtijL/syEjXZyBBEjrSu2vbRTuwZqUdKM2FKT8XDijHlVf3uDYhF+1zpHCnTidMRa5YJJGpTt6osXxzjBV7GvIL70JCyOPuOZwB4tu6tolrOHWVYVVTYA7Cv4EM9ILhUboTa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <F7F13E18FCF7F94FBBF8E40D22AA66A1@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c7f3d-c64b-4ebf-47a2-08d66b6abb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 19:45:47.2402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3723
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_114603_885559_4641D6A4 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-21 at 04:33 +0000, Richard Zhu wrote:
> The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
> controls whether a Function can request service using MSI.
> 
> i.MX6 Root Ports implement the MSI Capability and may use MSI to
> request service for events like PME, hotplug, AER, etc.  In
> addition, on i.MX6, the MSI Enable bit controls delivery of MSI
> interrupts from components below the Root Port.
> 
> Prior to commit f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig
> selection
> of CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
> enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
> it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
> As a side effect, that also enabled delivery of MSI interrupts from
> downstream components.
> 
> After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
> portdrv, but that means imx6q-pcie must set the MSI Enable bit
> itself if downstream components use MSI.
> 
> Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of
> CONFIG_PCIEPORTBUS")
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Tested on IMX7d, allows MSI to work without enabling PCIEPORTBUS, which
fails without this patch.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
