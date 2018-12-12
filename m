Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD7C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C20720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvWb3Tpa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="l1/GrgHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C20720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=035KLjnWtu83mDq8WZwypGpuIhSj/kMlDk0/Ld8BKzc=; b=FvWb3TpaDzZ8i7
	vMgwdtXMzPY18eNhATRMuXn4UB96fzAn8194GUztjunwmmFYuLhuXKJoqHmWvbdoHGtDsKO9L+AvE
	yvenq8kmmJp7sAFaTYsfLHkAyLmpXH8irBOQkVa6BnOiNiswIkmAmg2RXRjjbiyZze5wA9kNPMyiz
	W+TlGlxlT27BhWUkGlbMb4iQ8ZmOryd/WWidHJDKocKHkthbRIb0liPiiikDAPVEN0SvVY98IkBjO
	NkLIUlrSoDTRpzwg2qh/DJ0wPR4MeDXJF54ZC2iISVra3j+yIBkwYJSwGfc2O1LdDqOJuxUxLn2H+
	iMPjH8kUnrDFSVF7w5sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWwdi-0002GO-TM; Wed, 12 Dec 2018 05:00:54 +0000
Received: from mail-eopbgr790105.outbound.protection.outlook.com
 ([40.107.79.105] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWwdc-0002F1-1n
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 05:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sjw4YjTs2taLH5q8X0JZenXZmAa4BJU0cHDMSMpKVQ=;
 b=l1/GrgHYyobl3S9FABX0i85ZH238dFId2e1GiAzaE8T167AL+JOMfLYxduUYYR7L3ccjV4wS0cApoOG+Td7rOWytJEICCxCle5KDZdPd/AzJoJD7vC99MvGqALNjugoZqWVc8c2NYiiInlOHQPYA7hOx8J341wRYYkRe6422rBQ=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.1; Wed, 12 Dec 2018 05:00:32 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 05:00:32 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: Marc Zyngier <marc.zyngier@arm.com>, KY Srinivasan <kys@microsoft.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@armm.com"
 <catalin.marinas@armm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Stephen Hemminger <sthemmin@microsoft.com>, vkuznets
 <vkuznets@redhat.com>
Subject: RE: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
Thread-Topic: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUghEnmAHBKrXmHkmtduFUzC9VJqVzciwAgAb8qWA=
Date: Wed, 12 Dec 2018 05:00:32 +0000
Message-ID: <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
In-Reply-To: <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-12T05:00:28.7833500Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR21MB0854;
 6:u0Y9GrpRPoWf5J77AkO3GDoz496vqzO9Rh7NOEoA060vrAGjxpnac9JO/mwJ3pKeNZkBCnTg2zuKkLh0glKzRv44q/p6o1nL1glS1b0e7qvOlQlJ+fikG6y7+ZTLjWYFJtS52VlR4smRSKFWgFWVPb3UQnKobYa89MmIEcxntd8rZuaZbQ2EX9rGu60ipQvqwC0wEmoA/xzWitwRtRKjG+9aGsnowm9BSxZZbjYpnG9g6Lm7OLEN9Q+Jwh57sGiJUxO5RtM83jInBmNoK9oCidSl/QR99k4D9wMK3hhZJ6wzDVYQxQBTKwu7wuQluU2XSWyOkhO1ahOVXfgLcbaew2E4i3FGzvQG+UUdwAXtwOEvDVfxv5fTjfglZW4Vyg3zUnoORuAqhyceleDXulH1q/AOHDb5ujmtYG8thu0p+ROpmHaL19kOhX7pDt2JiaBKhg2Zi+L/n8eab8NwuUApqA==;
 5:03TO9FczqKJLCKpXRkVzpKRRCGWRl6ZdcV7DXieGHKdSTL6MzVzcpyaAwSgHJRadvwwz+OCmWaT2TIp/Vgnftw85ulmAv9ceBA5ItK+8i7v2ZqONnajkJ61VKWhukOU0oiuGYLrml38xPfUQ+/ZtOIfq5tBaBP/xsCy6+KV5qqU=;
 7:AUvalDZrUQQ0y4BT5e2w0UKDHZJLHbHp8IE+Nk/yQ1YzcnZuUlH+Th5unV/wkbcbpPbS4xmr8YGX5JCCMzaPlhLxwkZjgpffjPSns3us6x+5phPuWL6VUYoFWlLxQa6odrMc4QaQHZmJy4lRY16CTA==
x-ms-office365-filtering-correlation-id: c809f9d9-a500-4deb-ab79-08d65feebe78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);
 SRVR:CY4PR21MB0854; 
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB085484E10BAA1A21AB84DB4BD7A70@CY4PR21MB0854.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231472)(944501520)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:CY4PR21MB0854; BCL:0; PCL:0; RULEID:; SRVR:CY4PR21MB0854; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(51914003)(199004)(81166006)(7736002)(81156014)(8676002)(33656002)(6116002)(53936002)(53946003)(102836004)(55016002)(6246003)(9686003)(74316002)(110136005)(186003)(305945005)(97736004)(26005)(7696005)(11346002)(8936002)(2501003)(6436002)(99286004)(105586002)(93886005)(446003)(229853002)(316002)(5660300001)(256004)(6506007)(71190400001)(76176011)(106356001)(486006)(86362001)(7416002)(476003)(86612001)(10090500001)(478600001)(66066001)(575784001)(14444005)(71200400001)(10290500003)(1511001)(2906002)(14454004)(2201001)(25786009)(3846002)(8990500004)(68736007)(22452003)(4744004)(2004002)(921003)(1121003)(559001)(569006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0854;
 H:CY4PR21MB0773.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lry51bchD4hHZPaMjdsZRUQIm5BpIyVgMnFWGchXGkohFYrMu/0dafBWtkq88A95nib3XHW6zHW/eQULOLALMw1Akb+NygOrWh+4+rDLoLuvwweW/zA/2d33D2/TFy4iP4JnlV8i6ItNAx3S8OwF4jcA+7I55D93HmcW0UIkVQowBxUE7qTVA8AWZteY6B9dkuM73F+tEGLEqogth5aTQeQrqYGWbDyGtiyRvwCujAtlhjEJXS5/esSvRLdz2X/chbkVox2rUIAyU8d41e6YhzESCbRtEmMLvKZqeuNp7lJ1d393uf4NB5uRUSfEWnwr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c809f9d9-a500-4deb-ab79-08d65feebe78
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:00:32.0547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_210048_219185_6702D609 
X-CRM114-Status: GOOD (  28.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>  Sent: Friday, December 7, 2018 6:43 AM

> > Add ARM64-specific code to enable Hyper-V. This code includes:
> > * Detecting Hyper-V and initializing the guest/Hyper-V interface
> > * Setting up Hyper-V's synthetic clocks
> > * Making hypercalls using the HVC instruction
> > * Setting up VMbus and stimer0 interrupts
> > * Setting up kexec and crash handlers
> 
> This commit message is a clear indication that this should be split in
> at least 5 different patches.

OK, I'll work on separating into multiple layered patches in the next
version.

> 
> > This code is architecture dependent code and is mostly driven by
> > architecture independent code in the VMbus driver in drivers/hv/hv.c
> > and drivers/hv/vmbus_drv.c.
> >
> > This code is built only when CONFIG_HYPERV is enabled.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  MAINTAINERS                  |   1 +
> >  arch/arm64/Makefile          |   1 +
> >  arch/arm64/hyperv/Makefile   |   2 +
> >  arch/arm64/hyperv/hv_hvc.S   |  54 +++++
> >  arch/arm64/hyperv/hv_init.c  | 441 +++++++++++++++++++++++++++++++++++
> >  arch/arm64/hyperv/mshyperv.c | 178 ++++++++++++++
> >  6 files changed, 677 insertions(+)
> >  create mode 100644 arch/arm64/hyperv/Makefile
> >  create mode 100644 arch/arm64/hyperv/hv_hvc.S
> >  create mode 100644 arch/arm64/hyperv/hv_init.c
> >  create mode 100644 arch/arm64/hyperv/mshyperv.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 72f19cef4c48..326eeb32a0cd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6837,6 +6837,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
> >  F:	arch/x86/hyperv
> >  F:	arch/arm64/include/asm/hyperv-tlfs.h
> >  F:	arch/arm64/include/asm/mshyperv.h
> > +F:	arch/arm64/hyperv
> >  F:	drivers/hid/hid-hyperv.c
> >  F:	drivers/hv/
> >  F:	drivers/input/serio/hyperv-keyboard.c
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 6cb9fc7e9382..ad9ec0579553 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -106,6 +106,7 @@ core-y		+= arch/arm64/kernel/ arch/arm64/mm/
> >  core-$(CONFIG_NET) += arch/arm64/net/
> >  core-$(CONFIG_KVM) += arch/arm64/kvm/
> >  core-$(CONFIG_XEN) += arch/arm64/xen/
> > +core-$(CONFIG_HYPERV) += arch/arm64/hyperv/
> >  core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
> >  libs-y		:= arch/arm64/lib/ $(libs-y)
> >  core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> > diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> > new file mode 100644
> > index 000000000000..988eda55330c
> > --- /dev/null
> > +++ b/arch/arm64/hyperv/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-y		:= hv_init.o hv_hvc.o mshyperv.o
> > diff --git a/arch/arm64/hyperv/hv_hvc.S b/arch/arm64/hyperv/hv_hvc.S
> > new file mode 100644
> > index 000000000000..82636969b4f2
> > --- /dev/null
> > +++ b/arch/arm64/hyperv/hv_hvc.S
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Microsoft Hyper-V hypervisor invocation routines
> > + *
> > + * Copyright (C) 2018, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> > + * NON INFRINGEMENT.  See the GNU General Public License for more
> > + * details.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +
> > +	.text
> > +/*
> > + * Do the HVC instruction.  For Hyper-V the argument is always 1.
> > + * x0 contains the hypercall control value, while additional registers
> > + * vary depending on the hypercall, and whether the hypercall arguments
> > + * are in memory or in registers (a "fast" hypercall per the Hyper-V
> > + * TLFS).  When the arguments are in memory x1 is the guest physical
> > + * address of the input arguments, and x2 is the guest physical
> > + * address of the output arguments.  When the arguments are in
> > + * registers, the register values depends on the hypercall.  Note
> > + * that this version cannot return any values in registers.
> > + */
> > +ENTRY(hv_do_hvc)
> > +	hvc #1
> > +	ret
> > +ENDPROC(hv_do_hvc)
> > +
> > +/*
> > + * This variant of HVC invocation is for hv_get_vpreg and
> > + * hv_get_vpreg_128. The input parameters are passed in registers
> > + * along with a pointer in x4 to where the output result should
> > + * be stored. The output is returned in x15 and x16.  x18 is used as
> > + * scratch space to avoid buildng a stack frame, as Hyper-V does
> > + * not preserve registers x0-x17.
> > + */
> > +ENTRY(hv_do_hvc_fast_get)
> > +	mov x18, x4
> > +	hvc #1
> > +	str x15,[x18]
> > +	str x16,[x18,#8]
> > +	ret
> > +ENDPROC(hv_do_hvc_fast_get)
> 
> As Will said, this isn't a viable option. Please follow SMCCC 1.1.

I'll have to start a conversation with the Hyper-V team about this.
I don't know why they chose to use HVC #1 or this register scheme
for output values.  It may be tough to change at this point because
there are Windows guests on Hyper-V for ARM64 that are already
using this approach.

> 
> > diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
> > new file mode 100644
> > index 000000000000..aa1a8c09d989
> > --- /dev/null
> > +++ b/arch/arm64/hyperv/hv_init.c
> > @@ -0,0 +1,441 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Initialization of the interface with Microsoft's Hyper-V hypervisor,
> > + * and various low level utility routines for interacting with Hyper-V.
> > + *
> > + * Copyright (C) 2018, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> > + * NON INFRINGEMENT.  See the GNU General Public License for more
> > + * details.
> > + */
> > +
> > +
> > +#include <linux/types.h>
> > +#include <linux/version.h>
> > +#include <linux/export.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> > +#include <linux/clocksource.h>
> > +#include <linux/sched_clock.h>
> > +#include <linux/acpi.h>
> > +#include <linux/module.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/slab.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/psci.h>
> > +#include <asm-generic/bug.h>
> > +#include <asm/hypervisor.h>
> > +#include <asm/hyperv-tlfs.h>
> > +#include <asm/mshyperv.h>
> > +#include <asm/sysreg.h>
> > +#include <clocksource/arm_arch_timer.h>
> > +
> > +static bool	hyperv_initialized;
> > +struct		ms_hyperv_info ms_hyperv;
> > +EXPORT_SYMBOL_GPL(ms_hyperv);
> 
> Who are the users of this structure? Should they go via accessors instead?

The structure is an aggregation of several flags fields that describe a myriad
of features and hints that may or may not be present on any particular version
of Hyper-V, plus the max virtual processor ID values.  Everything is read-only
after initialization.   Most of the references are to test one of the flags.  It's
a judgment call, but there are a lot of different flags with long names, and
writing accessors for each one doesn't seem to me to add any clarity.

> 
> > +
> > +static struct ms_hyperv_tsc_page *tsc_pg;
> > +
> > +struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> > +{
> > +	return tsc_pg;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_get_tsc_page);
> > +
> > +static u64 read_hv_sched_clock_tsc(void)
> > +{
> > +	u64 current_tick = hv_read_tsc_page(tsc_pg);
> > +
> > +	if (current_tick == U64_MAX)
> > +		current_tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
> > +
> > +	return current_tick;
> > +}
> > +
> > +static u64 read_hv_clock_tsc(struct clocksource *arg)
> > +{
> > +	u64 current_tick = hv_read_tsc_page(tsc_pg);
> > +
> > +	if (current_tick == U64_MAX)
> > +		current_tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
> > +
> > +	return current_tick;
> > +}
> 
> Can't you define one function in terms of the other?

Yes, it looks like that works.  I'll change it in the next version of the
patch.

> 
> > +
> > +static struct clocksource hyperv_cs_tsc = {
> > +		.name		= "hyperv_clocksource_tsc_page",
> > +		.rating		= 400,
> > +		.read		= read_hv_clock_tsc,
> > +		.mask		= CLOCKSOURCE_MASK(64),
> > +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +static u64 read_hv_sched_clock_msr(void)
> > +{
> > +	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
> > +}
> > +
> > +static u64 read_hv_clock_msr(struct clocksource *arg)
> > +{
> > +	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
> > +}
> > +
> > +static struct clocksource hyperv_cs_msr = {
> > +	.name		= "hyperv_clocksource_msr",
> > +	.rating		= 400,
> > +	.read		= read_hv_clock_msr,
> > +	.mask		= CLOCKSOURCE_MASK(64),
> > +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> > +struct clocksource *hyperv_cs;
> > +EXPORT_SYMBOL_GPL(hyperv_cs);
> 
> Why? Who needs to poke this?

It's referenced in the architecture independent driver code
for the Hyper-V clocksource in drivers/hv/hv.c, and in the
code to sync the time with the Hyper-V host in
drivers/hv/hv_util.c.

> 
> > +
> > +u32 *hv_vp_index;
> > +EXPORT_SYMBOL_GPL(hv_vp_index);
> > +
> > +u32 hv_max_vp_index;
> 
> Same thing.

Agreed -- this one doesn't seem to be needed.  The variable
is not used outside of the architecture dependent Hyper-V code.

> 
> > +
> > +static int hv_cpu_init(unsigned int cpu)
> > +{
> > +	u64 msr_vp_index;
> > +
> > +	hv_get_vp_index(msr_vp_index);
> > +
> > +	hv_vp_index[smp_processor_id()] = msr_vp_index;
> > +
> > +	if (msr_vp_index > hv_max_vp_index)
> > +		hv_max_vp_index = msr_vp_index;
> > +
> > +	return 0;
> > +}
> 
> Is that some new way to describe a CPU topology? If so, why isn't that
> exposed via the ACPI tables that the kernel already parses?

Hyper-V's hypercall interface uses vCPU identifiers that are not
guaranteed to be consecutive integers or to match what ACPI shows.
No topology information is implied -- it's just unique identifiers.  The 
hv_vp_index array provides easy mapping from Linux's consecutive
integer IDs for CPUs when needed to construct hypercall arguments.

> 
> > +
> > +/*
> > + * This function is invoked via the ACPI clocksource probe mechanism. We
> > + * don't actually use any values from the ACPI GTDT table, but we set up
> 
> This doesn't feel like a good idea at all. Piggy-backing on an existing
> mechanism and use it for something completely different is not exactly
> future-proof.
> 
> Also, if this is supposed to be a clocksource, why isn't that a
> clocksource driver on its own right?

I agree this is not the right long term solution.  Is there a better place to
hang the initialization code?  Or should I just make an explicit call to
initialize Hyper-V at the right place?  On the x86 side, there's an
explicit framework for hypervisor-specific initialization routines to plug
into.  Maybe it's time for a basic version of such a framework on the
ARM64 side.  Thoughts on the best approach, both in the short-term and
the longer-term? If we put a framework in place, does that need to
happen before adding Hyper-V code, or afterwards as a cleanup?

And yes, Hyper-V does effectively have its own clocksource.  The
main code is in drivers/hv/hv.c, but it's not broken out as a separate
driver in drivers/clocksource, probably due to some history on the
x86 side that pre-dates me.  I'll have to research.

> 
> > + * the Hyper-V synthetic clocksource and do other initialization for
> > + * interacting with Hyper-V the first time.  Using early_initcall to invoke
> > + * this function is too late because interrupts are already enabled at that
> > + * point, and sched_clock_register must run before interrupts are enabled.
> > + *
> > + * 1. Setup the guest ID.
> > + * 2. Get features and hints info from Hyper-V
> > + * 3. Setup per-cpu VP indices.
> > + * 4. Register Hyper-V specific clocksource.
> > + * 5. Register the scheduler clock.
> > + */
> > +
> > +static int __init hyperv_init(struct acpi_table_header *table)
> > +{
> > +	struct hv_get_vp_register_output result;
> > +	u32	a, b, c, d;
> > +	u64	guest_id;
> > +	int	i;
> > +
> > +	/*
> > +	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> > +	 * have the string "MsHyperV".
> > +	 */
> > +	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> > +		return 1;
> > +
> > +	/* Setup the guest ID */
> > +	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> > +	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
> > +
> > +	/* Get the features and hints from Hyper-V */
> > +	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES, &result);
> > +	ms_hyperv.features = lower_32_bits(result.registervaluelow);
> > +	ms_hyperv.misc_features = upper_32_bits(result.registervaluehigh);
> > +
> > +	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
> > +	ms_hyperv.hints = lower_32_bits(result.registervaluelow);
> > +
> > +	pr_info("Hyper-V: Features 0x%x, hints 0x%x\n",
> > +		ms_hyperv.features, ms_hyperv.hints);
> > +
> > +	/*
> > +	 * Direct mode is the only option for STIMERs provided Hyper-V
> > +	 * on ARM64, so Hyper-V doesn't actually set the flag.  But add the
> > +	 * flag so the architecture independent code in drivers/hv/hv.c
> > +	 * will correctly use that mode.
> > +	 */
> > +	ms_hyperv.misc_features |= HV_STIMER_DIRECT_MODE_AVAILABLE;
> > +
> > +	/*
> > +	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
> > +	 * that tells architecture independent code not to use this
> > +	 * feature.
> > +	 */
> > +	ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
> > +
> > +	/* Get information about the Hyper-V host version */
> > +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> > +	a = lower_32_bits(result.registervaluelow);
> > +	b = upper_32_bits(result.registervaluelow);
> > +	c = lower_32_bits(result.registervaluehigh);
> > +	d = upper_32_bits(result.registervaluehigh);
> > +	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> > +		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
> > +
> > +	/* Allocate percpu VP index */
> > +	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
> > +				    GFP_KERNEL);
> 
> Why isn't this a percpu variable?

In current code in the architecture independent Hyper-V drivers (as well
as some future Hyper-V enlightenments that aren't yet implemented
for ARM64), the running CPU needs to get the VP index values for any CPUs
in the hv_vp_index array.  Some of the code is performance sensitive, and
accessing a global array is faster than accessing other CPUs' per-cpu data.

> 
> > +	if (!hv_vp_index)
> > +		return 1;
> > +
> > +	for (i = 0; i < num_possible_cpus(); i++)
> > +		hv_vp_index[i] = VP_INVAL;
> > +
> > +	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
> > +			      hv_cpu_init, NULL) < 0)
> > +		goto free_vp_index;
> > +
> > +	/*
> > +	 * Try to set up what Hyper-V calls the "TSC reference page", which
> > +	 * uses the ARM Generic Timer virtual counter with some scaling
> > +	 * information to provide a fast and stable guest VM clocksource.
> > +	 * If the TSC reference page can't be set up, fall back to reading
> > +	 * the guest clock provided by Hyper-V's synthetic reference time
> > +	 * register.
> > +	 */
> > +	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
> > +
> > +		u64		tsc_msr;
> > +		phys_addr_t	phys_addr;
> > +
> > +		tsc_pg = __vmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> 
> And why not vmalloc?

Looks like it could be just vmalloc().  I'll change it in the next version.

> 
> > +		if (tsc_pg) {
> > +			phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
> > +			tsc_msr = hv_get_vpreg(HV_REGISTER_REFERENCE_TSC);
> > +			tsc_msr &= GENMASK_ULL(11, 0);
> 
> Magic.

Per Section 12.6.1 of the Hyper-V TLFS, bits 11 thru 1 must be preserved, and
the line below sets bit 0.  I'll add some comments. :-)

> 
> > +			tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
> > +			hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > +			hyperv_cs = &hyperv_cs_tsc;
> > +			sched_clock_register(read_hv_sched_clock_tsc,
> > +						64, HV_CLOCK_HZ);
> > +		}
> > +	}
> > +
> > +	if (!hyperv_cs &&
> > +	    (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)) {
> > +		hyperv_cs = &hyperv_cs_msr;
> > +		sched_clock_register(read_hv_sched_clock_msr,
> > +						64, HV_CLOCK_HZ);
> > +	}
> > +
> > +	if (hyperv_cs) {
> > +		hyperv_cs->archdata.vdso_direct = false;
> > +		clocksource_register_hz(hyperv_cs, HV_CLOCK_HZ);
> > +	}
> > +
> > +	hyperv_initialized = true;
> > +	return 0;
> > +
> > +free_vp_index:
> > +	kfree(hv_vp_index);
> > +	hv_vp_index = NULL;
> > +	return 1;
> 
> ????

The return value is there because this function is implemented as a timer
initialization function, and that's what the function signature requires.
But maybe I'm not understanding your question.

> 
> > +}
> > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
> > +
> > +/*
> > + * This routine is called before kexec/kdump, it does the required cleanup.
> > + */
> > +void hyperv_cleanup(void)
> > +{
> > +	/* Reset our OS id */
> > +	hv_set_vpreg(HV_REGISTER_GUEST_OSID, 0);
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_cleanup);
> > +
> > +/*
> > + * hv_do_hypercall- Invoke the specified hypercall
> > + */
> > +u64 hv_do_hypercall(u64 control, void *input, void *output)
> > +{
> > +	u64 input_address;
> > +	u64 output_address;
> > +
> > +	input_address = input ? virt_to_phys(input) : 0;
> > +	output_address = output ? virt_to_phys(output) : 0;
> > +	return hv_do_hvc(control, input_address, output_address);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_do_hypercall);
> > +
> > +/*
> > + * hv_do_fast_hypercall8 -- Invoke the specified hypercall
> > + * with arguments in registers instead of physical memory.
> > + * Avoids the overhead of virt_to_phys for simple hypercalls.
> > + */
> > +
> > +u64 hv_do_fast_hypercall8(u16 code, u64 input)
> > +{
> > +	u64 control;
> > +
> > +	control = (u64)code | HV_HYPERCALL_FAST_BIT;
> > +	return hv_do_hvc(control, input);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
> > +
> > +
> > +/*
> > + * Set a single VP register to a 64-bit value.
> > + */
> > +void hv_set_vpreg(u32 msr, u64 value)
> > +{
> > +	union hv_hypercall_status status;
> > +
> > +	status.as_uint64 = hv_do_hvc(
> > +		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> > +			HV_HYPERCALL_REP_COUNT_1,
> > +		HV_PARTITION_ID_SELF,
> > +		HV_VP_INDEX_SELF,
> > +		msr,
> > +		0,
> > +		value,
> > +		0);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * setting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON(status.status != HV_STATUS_SUCCESS);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_set_vpreg);
> > +
> > +
> > +/*
> > + * Get the value of a single VP register, and only the low order 64 bits.
> > + */
> > +u64 hv_get_vpreg(u32 msr)
> > +{
> > +	union hv_hypercall_status status;
> > +	struct hv_get_vp_register_output output;
> > +
> > +	status.as_uint64 = hv_do_hvc_fast_get(
> > +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> > +			HV_HYPERCALL_REP_COUNT_1,
> > +		HV_PARTITION_ID_SELF,
> > +		HV_VP_INDEX_SELF,
> > +		msr,
> > +		&output);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * getting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON(status.status != HV_STATUS_SUCCESS);
> > +
> > +	return output.registervaluelow;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_get_vpreg);
> > +
> > +/*
> > + * Get the value of a single VP register that is 128 bits in size.  This is a
> > + * separate call in order to avoid complicating the calling sequence for
> > + * the much more frequently used 64-bit version.
> > + */
> > +void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *result)
> > +{
> > +	union hv_hypercall_status status;
> > +
> > +	status.as_uint64 = hv_do_hvc_fast_get(
> > +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
> > +			HV_HYPERCALL_REP_COUNT_1,
> > +		HV_PARTITION_ID_SELF,
> > +		HV_VP_INDEX_SELF,
> > +		msr,
> > +		result);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * getting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON(status.status != HV_STATUS_SUCCESS);
> > +
> > +	return;
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
> > +
> > +void hyperv_report_panic(struct pt_regs *regs, long err)
> > +{
> > +	static bool panic_reported;
> > +	u64 guest_id;
> > +
> > +	/*
> > +	 * We prefer to report panic on 'die' chain as we have proper
> > +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> > +	 * to report it on 'panic'.
> > +	 */
> > +	if (panic_reported)
> > +		return;
> > +	panic_reported = true;
> > +
> > +	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
> > +
> > +	/*
> > +	 * Hyper-V provides the ability to store only 5 values.
> > +	 * Pick the passed in error value, the guest_id, and the PC.
> > +	 * The first two general registers are added arbitrarily.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> > +
> > +/*
> > + * hyperv_report_panic_msg - report panic message to Hyper-V
> > + * @pa: physical address of the panic page containing the message
> > + * @size: size of the message in the page
> > + */
> > +void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
> > +{
> > +	/*
> > +	 * P3 to contain the physical address of the panic page & P4 to
> > +	 * contain the size of the panic data in that page. Rest of the
> > +	 * registers are no-op when the NOTIFY_MSG flag is set.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available along with
> > +	 * the panic message.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
> > +	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
> > +
> > +bool hv_is_hyperv_initialized(void)
> > +{
> > +	return hyperv_initialized;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> > new file mode 100644
> > index 000000000000..3ef055599412
> > --- /dev/null
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Core routines for interacting with Microsoft's Hyper-V hypervisor,
> > + * including setting up VMbus and STIMER interrupts, and handling
> > + * crashes and kexecs. These interactions are through a set of
> > + * static "handler" variables set by the architecture independent
> > + * VMbus and STIMER drivers.  This design is used to meet x86/x64
> > + * requirements for avoiding direct linkages and allowing the VMbus
> > + * and STIMER drivers to be unloaded and reloaded.
> > + *
> > + * Copyright (C) 2018, Microsoft, Inc.
> > + *
> > + * Author : Michael Kelley <mikelley@microsoft.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published
> > + * by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> > + * NON INFRINGEMENT.  See the GNU General Public License for more
> > + * details.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kexec.h>
> > +#include <linux/acpi.h>
> > +#include <linux/ptrace.h>
> > +#include <asm/hyperv-tlfs.h>
> > +#include <asm/mshyperv.h>
> > +
> > +static void (*vmbus_handler)(void);
> > +static void (*hv_stimer0_handler)(void);
> > +static void (*hv_kexec_handler)(void);
> > +static void (*hv_crash_handler)(struct pt_regs *regs);
> > +
> > +static int vmbus_irq;
> > +static long __percpu *vmbus_evt;
> > +static long __percpu *stimer0_evt;
> > +
> > +irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
> > +{
> > +	if (vmbus_handler)
> > +		vmbus_handler();
> 
> In which circumstances can this be NULL?

Perhaps none.  This may be a leftover from the equivalent
x86 code.  I'll check and probably remove it.

> 
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/* Must be done just once */
> > +void hv_setup_vmbus_irq(void (*handler)(void))
> > +{
> > +	int result;
> > +
> > +	vmbus_handler = handler;
> 
> If thismust only be done once, maybe you could check that it hasn't been
> done already?

OK.

> 
> > +	vmbus_irq = acpi_register_gsi(NULL, HYPERVISOR_CALLBACK_VECTOR,
> > +				 ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> > +	if (vmbus_irq <= 0) {
> > +		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
> > +			vmbus_irq);
> > +		vmbus_irq = 0;
> > +		return;
> > +	}
> > +	vmbus_evt = alloc_percpu(long);
> > +	result = request_percpu_irq(vmbus_irq, hyperv_vector_handler,
> > +			"Hyper-V VMbus", vmbus_evt);
> 
> If this is a per-cpu interrupt, why isn't it signalled as a PPI, in an
> architecture compliant way?

Except for the code in this module, the interrupt handler for VMbus
interrupts is architecture independent.  But there's no support for
per-process interrupts on the x86, so the hypervisor interrupt vectors
are hard coded in the same IDT entry across all processors, and the
normal IRQ allocation mechanism is bypassed.  The above approach
assigns an ARM64 PPI (HYPERVISOR_CALLBACK_VECTOR is 16) in a
way that works with the arch independent interrupt handler.

Or maybe I'm missing your point.  If so, please set me straight.

> 
> > +	if (result) {
> > +		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
> > +			vmbus_irq, result);
> > +		free_percpu(vmbus_evt);
> > +		acpi_unregister_gsi(vmbus_irq);
> > +		vmbus_irq = 0;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
> > +
> > +/* Must be done just once */
> > +void hv_remove_vmbus_irq(void)
> > +{
> > +	if (vmbus_irq) {
> > +		free_percpu_irq(vmbus_irq, vmbus_evt);
> > +		free_percpu(vmbus_evt);
> > +		acpi_unregister_gsi(vmbus_irq);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
> > +
> > +/* Must be done by each CPU */
> > +void hv_enable_vmbus_irq(void)
> > +{
> > +	enable_percpu_irq(vmbus_irq, 0);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
> > +
> > +/* Must be done by each CPU */
> > +void hv_disable_vmbus_irq(void)
> > +{
> > +	disable_percpu_irq(vmbus_irq);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
> > +
> > +/* Routines to do per-architecture handling of STIMER0 when in Direct Mode */
> > +
> > +static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
> > +{
> > +	if (hv_stimer0_handler)
> > +		hv_stimer0_handler();
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
> > +{
> > +	int localirq;
> > +	int result;
> > +
> > +	localirq = acpi_register_gsi(NULL, HV_STIMER0_IRQNR,
> > +			ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> > +	if (localirq <= 0) {
> > +		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
> > +			localirq);
> > +		*irq = 0;
> > +		return -1;
> > +	}
> > +	stimer0_evt = alloc_percpu(long);
> > +	result = request_percpu_irq(localirq, hv_stimer0_vector_handler,
> > +					 "Hyper-V stimer0", stimer0_evt);
> > +	if (result) {
> > +		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
> > +			localirq, result);
> > +		free_percpu(stimer0_evt);
> > +		acpi_unregister_gsi(localirq);
> > +		*irq = 0;
> > +		return -1;
> > +	}
> > +
> > +	hv_stimer0_handler = handler;
> > +	*vector = HV_STIMER0_IRQNR;
> > +	*irq = localirq;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
> > +
> > +void hv_remove_stimer0_irq(int irq)
> > +{
> > +	hv_stimer0_handler = NULL;
> > +	if (irq) {
> > +		free_percpu_irq(irq, stimer0_evt);
> > +		free_percpu(stimer0_evt);
> > +		acpi_unregister_gsi(irq);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
> > +
> > +void hv_setup_kexec_handler(void (*handler)(void))
> > +{
> > +	hv_kexec_handler = handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	hv_kexec_handler = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > +
> > +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> > +{
> > +	hv_crash_handler = handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> > +
> > +void hv_remove_crash_handler(void)
> > +{
> > +	hv_crash_handler = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> >
> 
> Overall, this patch needs a massive split up, clean up, and a good dose
> of documentation so that we can understand what you are trying to achieve.

Thanks for the feedback.  I'll start work on a new version for the
changes that are clear, and await additional discussion on
a few issues where I need some further input.

Michael

> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
