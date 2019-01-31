Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C28C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:01:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B266E218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lPYiiNnM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pcsf+0IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B266E218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gi2iRL0o/7Uv4KIwgCiwBc0Ik+yXeLRIt7sM21MlcCw=; b=lPYiiNnMBxmNJY
	PdNqFKsbJ8QkG9zXDv1DcvQYm7ywvsQ+oxhlVAXv+HKXxz/OyR2i884hBmLt3UTl9ie+3yZlOKIRz
	gIApDGeqS4HkLS5C/FSNspky8RpFHQ96KiNWb1bwQk+482bW4LJzb0jFfdB0y2uPuxNjmk0MkKRkH
	qmq2gyxA0Kzok+E8nrf4ysRst6qnsTB/rx7mLuANV3FhDk6HjVqhms5tD3a0syS/pGtrhSoU/LjAH
	jqCcHv4AM8MHeN0xySdlyQiK75Am4xv7D1bdCpq3WbDnFKxxk4PodWPPKNnBOR3J5XZZYx3WkPMK1
	CO1IcAMUoNrNuyBGsYRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHaL-0002gt-DM; Thu, 31 Jan 2019 19:01:13 +0000
Received: from mail-eopbgr720081.outbound.protection.outlook.com
 ([40.107.72.81] helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHaG-0002gQ-UI
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 19:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/668wpyunxcMpJ39A9xFIiXM9xtEDzCqD7TbyM8Zk=;
 b=pcsf+0ITxX1jwaOcQ6vyZHX9f6OcQnio96NXdKnD2gDi4csjWiUqGmJ9/WFx1c6VbkqlpnVxszkMWSCvhSz9OlIF3a6BEDkrx47TjSoBKEV4R31ODlmp2qQtk7/Vk/zf5RP+TVchGLMBZYtiCdkHlEXv3mGvBltRn/2rEG3rgJ0=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB4117.namprd02.prod.outlook.com (20.176.249.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 31 Jan 2019 19:01:05 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::44e4:ab90:ef4d:25e1%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 19:01:05 +0000
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Topic: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Thread-Index: AQHUuBKpstebeIDlnU+HyCPR79whuqXHmH8AgAIlFZA=
Date: Thu, 31 Jan 2019 19:01:05 +0000
Message-ID: <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
 <20190130101236.GA27201@e107155-lin>
In-Reply-To: <20190130101236.GA27201@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR02MB4117;
 6:CyCRAyw0muPMUgzC0iDugFoL6/2F18LUu2Q0WsK0TaJxrZtdrjfnZyFRaV4t6UowGBHe564H9NMwlwx6EJ/MmU9Ckps3WGmb2N0uP2PQgE+Dq8+EBOPjeMXbGxIq9Dy2L5lwMSjsN5AE8rwHWkgxCcZZKTQ0MkvmY6mnrYbxHew0fruQVfg+0TcY+kASkLP5bi4xhbkpAOJXSXQAgfzzQF4Uqu5m6/DyffUent+BUHIkdgDAZvHIPNbr14Xx3ar5Gz98beWks0eVu2dPWFFx7cDnfS2dQ0jaCuDsrE9I3wSNP5hqxh7tN6DxkOm2czhC728qQ12Jm5npUkujpk6dy3/8D9b2hQAKjtrT70tLegfnZpowKelcpzRyebX4m4/q6eYs3U1VYiviNXmO/JgxvKMphE96cj4QezRPFd2w4wTwDBLWcx2IJcJGA+HXob2wjkaPIY9zuiSn9iI7JnHc8Q==;
 5:fa9afFSzIImnHik52nD/FKwH08GY22rM+LArObH0DYlir2ODJ+6dFJbtZSCL8Vv1lQ9F8jWAgN8y7n1YwUNW1VHR9DK6VMP43PXzV1pFrzsMrIQNCO3STsMsFN7NVBARlQ+ji2ugZOOeYf9TtxnsViDjo5xGoynTLLjfY6s1jmsjgoofgdg2ZmOywnR7fPvozfsrEozUZg02XtLUpftcBA==;
 7:cWvk/FNspJPH9GJxeRUwG9icg3R7HsxNGwEPteF6yB32nAkwIbiahwAYztl87wLeIQZLC1gzsYEklXKMLBijPSC92bpzL9qwss+/IzPDE26v76+CnpDfenp3iTMW5DDCVcDSQMPL8TTd3pVY5lA0MA==
x-ms-office365-filtering-correlation-id: 10ba9b99-a6d9-4c75-6b19-08d687ae73b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR02MB4117; 
x-ms-traffictypediagnostic: BYAPR02MB4117:
x-microsoft-antispam-prvs: <BYAPR02MB4117344BEEC95A7FB040E8F7B8910@BYAPR02MB4117.namprd02.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(13464003)(199004)(68736007)(3846002)(97736004)(86362001)(81166006)(53936002)(66066001)(7736002)(6246003)(9686003)(107886003)(81156014)(316002)(99286004)(33656002)(72206003)(6116002)(229853002)(6916009)(4326008)(25786009)(39060400002)(8676002)(2906002)(7696005)(6436002)(478600001)(54906003)(55016002)(256004)(186003)(476003)(71190400001)(305945005)(76176011)(71200400001)(26005)(14444005)(14454004)(106356001)(53546011)(8936002)(102836004)(105586002)(486006)(74316002)(11346002)(6506007)(7416002)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4117;
 H:BYAPR02MB5992.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VRM9Fhz6zeHyekwdyHjPnz3B4r/3Pe508eb3H7A1dVlJoT4Io/BsjG6bFEOlNTkT4eUvnn+6ZgOichs2r2BnCtL74fzL98GV1/wY8TIg72I7LH1958z8Sr1bZMyn2mUspBntFWihnjn78O4KzOXkeHDjtxn9VDTEn+hSwbZQMyG42n+izLw8Nn2SX7GLZVEz9kVHuBT9hKYf8SMw8KZvOELcP78mkQXSe3g6QVEDu8luUskaBIH0IP7tVhXKHRXv9ASLuwC15yP7xUGIRNnRJKLfvar8xCmM0cywnBf52vpoTyyQlvN2mP6dJvke4tp5OycshVASg3pIg//EG5nLtFfTrDBONpD0ZfRogzvOp6wedpnZdRwQFMufREIZGRE9vnmDhEgoIBop9qVDY8fmEQYi6LP6GfCeHR0hwJ4G0hg=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba9b99-a6d9-4c75-6b19-08d687ae73b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 19:01:05.3022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4117
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_110109_046826_065E8C70 
X-CRM114-Status: GOOD (  22.69  )
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
> Sent: Wednesday, January 30, 2019 2:13 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com; Rajan
> Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sudeep Holla
> <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
> 
> On Tue, Jan 29, 2019 at 12:38:21PM -0800, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add ZynqMP PM driver. PM driver provides power management
> > support for ZynqMP.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/soc/xilinx/Kconfig        |  11 +++
> >  drivers/soc/xilinx/Makefile       |   1 +
> >  drivers/soc/xilinx/zynqmp_power.c | 178
> ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 190 insertions(+)
> >  create mode 100644 drivers/soc/xilinx/zynqmp_power.c
> >
> > diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> > index 687c8f3..5025e0e 100644
> > --- a/drivers/soc/xilinx/Kconfig
> > +++ b/drivers/soc/xilinx/Kconfig
> > @@ -17,4 +17,15 @@ config XILINX_VCU
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called xlnx_vcu.
> >
> > +config ZYNQMP_POWER
> > +	bool "Enable Xilinx Zynq MPSoC Power Management driver"
> > +	depends on PM && ARCH_ZYNQMP
> > +	default y
> > +	help
> > +	  Say yes to enable power management support for ZyqnMP SoC.
> > +	  This driver uses firmware driver as an interface for power
> > +	  management request to firmware. It registers isr to handle
> > +	  power management callbacks from firmware.
> > +	  If in doubt, say N.
> > +
> >  endmenu
> > diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
> > index dee8fd5..428b9db 100644
> > --- a/drivers/soc/xilinx/Makefile
> > +++ b/drivers/soc/xilinx/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
> > +obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
> > diff --git a/drivers/soc/xilinx/zynqmp_power.c
> b/drivers/soc/xilinx/zynqmp_power.c
> > new file mode 100644
> > index 0000000..771cb59
> > --- /dev/null
> > +++ b/drivers/soc/xilinx/zynqmp_power.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx Zynq MPSoC Power Management
> > + *
> > + *  Copyright (C) 2014-2018 Xilinx, Inc.
> > + *
> > + *  Davorin Mista <davorin.mista@aggios.com>
> > + *  Jolly Shah <jollys@xilinx.com>
> > + *  Rajan Vaja <rajan.vaja@xilinx.com>
> > + */
> > +
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reboot.h>
> > +#include <linux/suspend.h>
> > +
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +enum pm_suspend_mode {
> > +	PM_SUSPEND_MODE_FIRST = 0,
> > +	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
> > +	PM_SUSPEND_MODE_POWER_OFF,
> > +};
> > +
> > +#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
> > +
> > +static const char *const suspend_modes[] = {
> > +	[PM_SUSPEND_MODE_STD] = "standard",
> > +	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
> > +};
> > +
> > +static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
> > +
> > +enum pm_api_cb_id {
> > +	PM_INIT_SUSPEND_CB = 30,
> > +	PM_ACKNOWLEDGE_CB,
> > +	PM_NOTIFY_CB,
> > +};
> > +
> > +static void zynqmp_pm_get_callback_data(u32 *buf)
> > +{
> > +	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> > +}
> > +
> > +static irqreturn_t zynqmp_pm_isr(int irq, void *data)
> > +{
> > +	u32 payload[CB_PAYLOAD_SIZE];
> > +
> > +	zynqmp_pm_get_callback_data(payload);
> > +
> > +	/* First element is callback API ID, others are callback arguments */
> > +	if (payload[0] == PM_INIT_SUSPEND_CB) {
> > +		switch (payload[1]) {
> > +		case SUSPEND_SYSTEM_SHUTDOWN:
> > +			orderly_poweroff(true);
> > +			break;
> > +		case SUSPEND_POWER_REQUEST:
> > +			pm_suspend(PM_SUSPEND_MEM);
> > +			break;
> > +		default:
> > +			pr_err("%s Unsupported InitSuspendCb reason "
> > +				"code %d\n", __func__, payload[1]);
> > +		}
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static ssize_t suspend_mode_show(struct device *dev,
> > +				 struct device_attribute *attr, char *buf)
> > +{
> > +	char *s = buf;
> > +	int md;
> > +
> > +	for (md = PM_SUSPEND_MODE_FIRST; md <
> ARRAY_SIZE(suspend_modes); md++)
> > +		if (suspend_modes[md]) {
> > +			if (md == suspend_mode)
> > +				s += sprintf(s, "[%s] ", suspend_modes[md]);
> > +			else
> > +				s += sprintf(s, "%s ", suspend_modes[md]);
> > +		}
> > +
> > +	/* Convert last space to newline */
> > +	if (s != buf)
> > +		*(s - 1) = '\n';
> > +	return (s - buf);
> > +}
> > +
> > +static ssize_t suspend_mode_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t count)
> > +{
> > +	int md, ret = -EINVAL;
> > +	const struct zynqmp_eemi_ops *eemi_ops =
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (!eemi_ops || !eemi_ops->set_suspend_mode)
> > +		return ret;
> > +
> > +	for (md = PM_SUSPEND_MODE_FIRST; md <
> ARRAY_SIZE(suspend_modes); md++)
> > +		if (suspend_modes[md] &&
> > +		    sysfs_streq(suspend_modes[md], buf)) {
> > +			ret = 0;
> > +			break;
> > +		}
> > +
> > +	if (!ret && md != suspend_mode) {
> > +		ret = eemi_ops->set_suspend_mode(md);
> > +		if (likely(!ret))
> > +			suspend_mode = md;
> > +	}
> > +
> > +	return ret ? ret : count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(suspend_mode);
> > +
> > +static int zynqmp_pm_probe(struct platform_device *pdev)
> > +{
> > +	int ret, irq;
> > +	u32 pm_api_version;
> > +
> > +	const struct zynqmp_eemi_ops *eemi_ops =
> zynqmp_pm_get_eemi_ops();
> > +
> > +	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops-
> >init_finalize)
> > +		return -ENXIO;
> > +
> > +	eemi_ops->init_finalize();
> > +	eemi_ops->get_api_version(&pm_api_version);
> > +
> > +	/* Check PM API version number */
> > +	if (pm_api_version < ZYNQMP_PM_VERSION)
> > +		return -ENODEV;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq <= 0)
> > +		return -ENXIO;
> > +
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> zynqmp_pm_isr,
> > +					IRQF_NO_SUSPEND | IRQF_ONESHOT,
> > +					dev_name(&pdev->dev), &pdev->dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
> > +			"with %d\n", irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = sysfs_create_file(&pdev->dev.kobj,
> &dev_attr_suspend_mode.attr);
> 
> NACK, if this is for system suspend/reset ? You can just use exiting
> sysfs, no need to create Xilinx specific new ones. Moreover you need to
> use PSCI to make sure higher ELs can do orderly suspend/shutdown.
> 

We have power off suspend mode which is not supported by existing sysfs and hence new one is needed. 
Suspend is handled through PSCI interface only.

Thanks,
Jolly Shah

> --
> Regards,
> Sudeep
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
