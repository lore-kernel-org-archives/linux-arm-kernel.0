Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324B5206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGL/IzZZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Q6LMjt/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324B5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Rsgm3XnABO55++IGuGD+l8Af57atStIELV2rsH9L08=; b=VGL/IzZZHJcsqp
	Yoi1YA/GjbQWCvHiMKe9pc+4TeH6/RDViufNydBL7QNbkjx70YyGwitVAcKYpuU3ctVC9nm0Gm1ht
	fV008ce3lML7BoJ0DycBvlmbVrfHJysIyPg9cGlhwYYFbkFA+bAp4ugH7bZwSe4iWyDmOKayTmXs0
	05ag8RmWgb8hTaRRVzRnTwnGaKfUwgdgOki/38sWymi705DQe2YNTrSd1ejuP7WsW1BUZzD58/TGD
	GLKFjSZ46ITHfqq/+EpD3UcamG2W5OXDC3zLG8pANC2potzDJhp46H44PvH4f7iXeCd90RR/61zUe
	6u7hNwQ/zpRjgsNaHUcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghF5x-0001Np-O3; Wed, 09 Jan 2019 14:44:37 +0000
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122] helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghF5t-0001NI-Ev
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com; 
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD0RrPLvPWybY3jumgXwBdcbiT3xo3040FSqoBj8iY4=;
 b=Q6LMjt/lMOGs2KD/XOJ1QpVHQJsRJDDN12iprnWEF883LYMMKV4Xmd0vu/T9cyW9lCEjMO3tv6gXG++FF0Ra/KLwQiKw0Jtzb8F2ZEIsOqgS/gdUmoscdgj3pwJQmmrLKsUpGWXoRavACvSqFDSRhjp4LNxzbG+oQDz2ALgCzV4=
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com (52.133.24.160) by
 AM6PR0702MB3831.eurprd07.prod.outlook.com (52.133.25.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10; Wed, 9 Jan 2019 14:44:27 +0000
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b]) by AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b%5]) with mapi id 15.20.1537.005; Wed, 9 Jan 2019
 14:44:26 +0000
From: "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To: James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Thread-Topic: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Thread-Index: AdSCPskxr2Sna9MEQ4KkOAtgpIpvmglAAIIAAA80LwAAJtCNsA==
Date: Wed, 9 Jan 2019 14:44:26 +0000
Message-ID: <AM6PR0702MB37997C0FA1670DD1AF4C25C7FA8B0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
In-Reply-To: <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0702MB3831;
 6:RF0rV9E3oqxDjbtfeFtQcczme1mEijxyGx9eJzaq0SECDgeq72n1jvSYL4vOoWdP4Vr5/0+0efy++Zv/rZcLyLZTSK00T5RwsWynWBJAfMiQfcUrx6i8GLw+SgBVgAawdGdy+Tnz5mI4hKEMC+jARXXPFrSyU2AA/YoAca67/LHsHtxUO7+s5/mrsNkRKgxCf2h/e6TUEmgFQKb0p6yI1aLhQOSeY25PZULoXgCZqzE7kMKVpSwqnTnnkUg/N0KNlmoPeosgAouYxaHx3m9x4slaGgfCKKDVU2vEUu2ifjuGiMTRGqyqwUH1fnesxKHMKFweE3GjO4k9z7us2cWSJTbVcOZMJbZJPN0JbMMd09wKay+cgFakJ1FhzbAn0fRNHOeU9iyFsD7mrdrmkspFhNwfgNywFVWBk2vAmO8LUdwlpBIxK1NJGZRU9ZRJL73FgsdiwZtvGWyV6VtxbhZSng==;
 5:eHA6vq30k1LbfONIU+g+IE+Nv1j7ANM6Hy/Uyp0xzFDuURPD5pnKTT7X44U6Y3LUzhonxDulJITvKYtDq13Kb7Df1/sxbmUEXH7H56xne9CK1C3xNfsnfVDbhxuD41WvMGMePPiLAtm3xaENPn+eLOJGRdMWY+r2E8+UbQGWT1M3ABu7auHC2XsgVy7IYQbV/7Hj/jdk2YYwQdY5zoY4lQ==;
 7:4zl9toNCm8i23Secj1z2q9dn1LzAs0WhjV8AZOofVMsBPEnxS0jGi7Ll+/RaFlSVih3ARdm8T83i2AofCEoAvtkw8wG62m/tDV53UmsgPRjYEOuLutmFRC7tr+mE7X6yAewf9ejszjw3FTlj7V+iOg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(13464003)(189003)(199004)(33656002)(486006)(66066001)(76176011)(7696005)(106356001)(99286004)(105586002)(26005)(102836004)(74316002)(186003)(6506007)(53546011)(14454004)(5660300001)(7416002)(305945005)(316002)(7736002)(11346002)(478600001)(53936002)(110136005)(476003)(2906002)(9686003)(6246003)(107886003)(25786009)(3846002)(6116002)(256004)(14444005)(4326008)(68736007)(446003)(71200400001)(71190400001)(229853002)(97736004)(55016002)(8936002)(81156014)(81166006)(8676002)(54906003)(86362001)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR0702MB3831;
 H:AM6PR0702MB3799.eurprd07.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-office365-filtering-correlation-id: 8a33aa06-9605-442a-849b-08d67640f43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM6PR0702MB3831; 
x-ms-traffictypediagnostic: AM6PR0702MB3831:
x-microsoft-antispam-prvs: <AM6PR0702MB38319A0384B919C2181B8C9BFA8B0@AM6PR0702MB3831.eurprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(806100)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0702MB3831; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0702MB3831; 
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JRyQYSEsu4GuHwGcdTO1Jl8frQMzSkdzsh9KLc2Qzu1wYty9ENgOrDNiXHorsMTngOvrxdk0l7zknC9ECGVLJl8fNLRi9co9lnx//uD9dTEzbW/0kbCL/0nnlDeMIF/M7cDaoa1xv3O6nRuDIJoexSH+SgpQoUBhv8Ya8mlojHuVUkVGX3zKIGIlyjdkbl4uOoPH3aGOBQLlepJUTcpAeaIIco5zmD7HHX9n/8S9+8uw4A68j95x5peSJsumRJwTUFv/Okim6vKiCj3KwN67F+WeQCjMlD4Tf2nQ4jBVl8O0EJjBnIuGN+3hb0s7ELu8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a33aa06-9605-442a-849b-08d67640f43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:44:26.6183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_064433_696462_5E9CDE68 
X-CRM114-Status: GOOD (  37.17  )
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
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Wiebe,
 Wladislav \(Nokia - DE/Ulm\)" <wladislav.wiebe@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

first of all thanks a lot for the constructive and fast feedback!

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Tuesday, January 08, 2019 6:57 PM
> 
> Hi Boris, Wladislav,
> 
> On 08/01/2019 10:42, Borislav Petkov wrote:
> > + James and leaving in the rest for reference.
> 
> (thanks!)
> 
> > So the first thing to figure out here is how generic is this and if
> > so, to make it a cortex_a15_edac.c driver which contains all the RAS
> > functionality for A15. Definitely not an EDAC driver per functional
> > unit but rather per vendor or even ARM core.
> 
> This is implementation-defined/specific-to-A15 and is documented in the
> TRM [0].
> (On the 'all the RAS functionality for A15' front: there are two more registers:
> L2MERRSR and CPUMERRSR. These are both accessible from the normal-
> world, and don't appear to need enabling.)
> 
> 
> But we have the usual pre-v8.2 problems, and in addition cluster-interrupts,
> as this signal might be per-cluster, or it might be combined.
> 
> Wladislav, I'm afraid we've had a few attempts at pre-8.2 EDAC drivers, the
> below list of problems is what we've learnt along the way. The upshot is that
> before the architected RAS extensions, the expectation is firmware will
> handle all this, as its difficult for the OS to deal with.
> 
> 
> My first question is how useful is a 'something bad happened' edac event?

We experienced sometimes random user-space crashes where we didn't 
expect a bug in the application code. If there would be a notification 
by such edac event, we would at least know that something bad happened before.

> Before the v8.2 extensions with its classification of errors, we don't know
> anything more.
> 
> The usual suspects are, (partly taken from the thread at [1]):
> * A15 exists in big/little configurations. We need to know which CPUs are
> A15.
> * We need to know we aren't running under a hypervisor, (a hypervisor can
> trap
>   accesses to these imp-def register, KVM does).
> * Nothing else should be clearing these bits, e.g. secure-world software, or
>   another CPU.
> * Secure-world needs to enable write-access to L2ECTLR, and we need to
>   know its done it. This needs doing on every CPU, and needs to not 'go
> missing'
>   over cpu-hotplug or cpu-idle.
> 
> These are things that don't naturally live in the DT.
> 
> 
> The new-one is these cluster-interrupts: How do we know which set of CPUs
> each interrupt goes with? What happens if user-space tries to rebalance
> them?

Valid question - so far, I didn't consider this case.
 
> Another SoC with A15 may combine all the cluster-interrupts into a single
> 'something bad happened' interrupt. Done like this, we would need to cross-
> call to the other CPUs when we take an interrupt - which is not something we
> can do.
> 
> Is this a level or edge interrupt? Is it necessary to clear that bit in the register
> to lower the interrupt line?
> The TRM talks about 'pending L2 internal asynchronous error', pending
> makes me suspect this is at least possible. If it is, a level-interrupt to one
> CPU, that can only be cleared by another leads to deadlock.
> 
> 
> Thanks,
> 
> James
> 
> > On Tue, Jan 08, 2019 at 08:10:45AM +0000, Wiebe, Wladislav (Nokia -
> DE/Ulm) wrote:
> >> This driver adds support for L2 internal asynchronous error detection
> >> caused by L2 RAM double-bit ECC error or illegal writes to the
> >> Interrupt Controller memory-map region on the Cortex A15.
> 
> >> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c
> >> b/drivers/edac/cortex_a15_l2_async_edac.c
> >> new file mode 100644
> >> index 000000000000..26252568e961
> >> --- /dev/null
> >> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
> >> @@ -0,0 +1,134 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2018 Nokia Corporation
> 
> (boiler plate not needed with the SPDX header)
> 
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/of.h>
> >> +
> >> +#include "edac_module.h"
> >> +
> >> +#define DRIVER_NAME "cortex_a15_l2_async_edac"
> >> +
> >> +#define L2ECTLR_L2_ASYNC_ERR BIT(30)
> >> +
> >> +static irqreturn_t cortex_a15_l2_async_edac_err_handler(int irq,
> >> +void *dev_id) {
> >> +	struct edac_device_ctl_info *dci = dev_id;
> >> +	u32 status = 0;
> >> +
> >> +	/*
> >> +	 * Read and clear L2ECTLR L2 ASYNC error bit caused by INTERRIRQ.
> >> +	 * Reason could be a L2 RAM double-bit ECC error or illegal writes
> >> +	 * to the Interrupt Controller memory-map region.
> >> +	 */
> >> +	asm("mrc p15, 1, %0, c9, c0, 3" : "=r" (status));
> 
> "L2 internal asynchronous error caused by L2 RAM double-bit ECC error"
> doesn't tell us if a CPU consumed the error, or if the error has caused a write
> to go missing. Without the classification, this means 'something bad
> happened'.
> 
> I'd prefer to panic() when we see one of these. I'd like it even more if
> firmware rebooted for us.

The EDAC subsystem allows to configure a panic() from userspace/sysfs.
So we can be flexible at this point I think.

> 
> >> +	if (status & L2ECTLR_L2_ASYNC_ERR) {
> >> +		status &= ~L2ECTLR_L2_ASYNC_ERR;
> >> +		asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));
> 
> 4.3.49 "L2 Extended Control Register" of the A15 TRM says this field can be
> read-only/write-ignored for the normal world if NSACR.NS_L2ERR is 0.
> 
> How do we know if firmware has set this bit on all CPUs? We can't clear the
> error otherwise.

Valid point!
 
> 
> >> +		edac_printk(KERN_EMERG, DRIVER_NAME,
> >> +			    "L2 internal asynchronous error occurred!\n");
> >> +		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
> 
> >> +
> >> +		return IRQ_HANDLED;
> >> +	}
> >> +
> >> +	return IRQ_NONE;
> >> +}
> >> +
> >> +static int cortex_a15_l2_async_edac_probe(struct platform_device
> >> +*pdev) {
> >> +	struct edac_device_ctl_info *dci;
> >> +	struct device_node *np = pdev->dev.of_node;
> >> +	char *ctl_name = (char *)np->name;
> >> +	int i = 0, ret = 0, err_irq = 0, irq_count = 0;
> >> +
> >> +	/* We can have multiple CPU clusters with one INTERRIRQ per cluster
> >> +*/
> 
> Surely this an integration choice?
> 
> You're accessing the cluster through a cpu register in the handler, what
> happens if the interrupt is delivered to the wrong cluster?
> How do we know which interrupt maps to which cluster?
> How do we stop user-space 'balancing' the interrupts?

You are right, based on all your inputs I think we can stop using this driver
as generic A15 solution (at least I would need more time to do
the refactoring considering all points you stated and experienced already).

Thanks a lot!

- Wladislav

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
