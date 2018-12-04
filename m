Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF323C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:46:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9017E208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lFyIKNEi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pXARlNot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l1/dDcfbrJEUYkUY6LtmiEapp5HOQipqJh3NtfhsvUI=; b=lFyIKNEi3BResa
	aS3uayt0YJY/p3PpwcQ2l0xadWxpDTbC76ei8fgb+AbcIM5LodsoRyt2RfLb5AHd41wEbfxUglwlZ
	bRxD0Td7O3+ydX4ricanmiXFWkVE7YzJmeXvTWls7wLX0HMeYOPTD2wt7P4KVRCpF2Sp3BZnna4Zs
	eNJn6cu1G6jzx0nii/kgHb2+ixDQkjES/12VTOGAFy+paOUbb7OCqBgSQqMFdlI7EoI/Y2S6d6qQZ
	dJSgryoOigAx2sL8mrX2yhHiCq3XtwZ8yUPRZ5kUH+EHZTBcxSPeOAIx0Na8Y6jmDqRsVPmy8czqs
	eF1gRIcqi16888B2F5tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTzmm-0000vM-A1; Tue, 04 Dec 2018 01:46:04 +0000
Received: from mail-eopbgr140041.outbound.protection.outlook.com
 ([40.107.14.41] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzmi-0000uw-Pm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:46:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5do3wNffRhBdqeMxopR+pdB0WeJj/8+/G1+S5Pmtcs=;
 b=pXARlNot8dCV8+ipvpyZZU2fALmMxdbAJ7qc8bR38KP+lDMrHtwqll9wdnRd7P+3cWio2AalraVDErKs6ykmDcNnPHdmwCtxggLFvAZ7bj0RFgegn1TTKOarbKiwmMfqChstWwbnxUomOxY/2zaRuLSSh7HmNjjeMpqXyk6Q6jQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5793.eurprd04.prod.outlook.com (20.178.202.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 01:45:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:45:46 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V8 6/7] clk: imx: add lpcg clock support
Thread-Topic: [PATCH V8 6/7] clk: imx: add lpcg clock support
Thread-Index: AQHUgaRCQQJmVj/lpEGe6LAmNSfItqVtfgEAgABgiGA=
Date: Tue, 4 Dec 2018 01:45:46 +0000
Message-ID: <AM0PR04MB421164275DE2C2B6617E3AA080AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-7-git-send-email-aisheng.dong@nxp.com>
 <154386628648.88331.6049034476912976846@swboyd.mtv.corp.google.com>
In-Reply-To: <154386628648.88331.6049034476912976846@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5793;
 6:P/On7RQPD+a7R13Kb/8Ix6jun9EnvAONpjXoslrJMWAHXmY21T52fEK+ky9esCFXSUuFoQpiVWEp+aPUt6id4pII6oQw5o7ocHx2QbT3xDV9NRgt+mm2Rk75N/F+tjA+prRXo+w3rx9k2x95+MOIm/+vj+TGsA+xJak9IrARo2dHeRTYyIGsEk1V0upAZs4oyVIy9OoqKZKl4NbdQUJMoNspdiKeRagEJnQNs9boie8/c8J9p5KMVdR06/iYSqcB0GM4pQQENSMrhhv2VaWvNh5eL9jwNy0Hh1FgwEPZ3GwwwELQTdYoM5WeuhZRw1cdZ4w34NRHSYgqdNOzMieYuuopO3rS3P1tBqHsBkPW2eYZV/atsSefcEetz74rGy70eJKd8F9YPiN5iaeOLjqUniatVmD4WEK2V5n8IkvrIVJPq7p178ggjmSV6st/8HwuKNZcgdQcQggijxyIksf6Jw==;
 5:wddvbvs3oSbubnrP0G8QJA6gd3eIS5L1b0PakufiWSmKwg+k/q47si8YlEMeO6gk2qm7cERalQhpweQgpUaugZAvfi6Q3wuLG3mIB98U2FFByoAYqSr7elrEllHDEUFAo7jxWmseWF2PqYMKLIf4WcrEpBg4+60R8YPD0fMjQ4U=;
 7:VR4KFpMhdf6tVHETMf3JVCez1OLAehehtlOeu7S3Jm6/tVPHdZmwkoqfcGsKF7/PQGdwChF+slg07pNihBAI33QX7Wj+eyKbs9BE7HtNsUm/3KvFdvRC/vZpFtXrNjUUEpsxvvlvH0LVnnAJgIwNfw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf156e22-a284-4a54-7e18-08d6598a35eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5793; 
x-ms-traffictypediagnostic: AM0PR04MB5793:
x-microsoft-antispam-prvs: <AM0PR04MB579317D4351ECF6F922B75DC80AF0@AM0PR04MB5793.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5793; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5793; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(13464003)(189003)(199004)(7736002)(5660300001)(8676002)(6436002)(14444005)(76176011)(53546011)(186003)(256004)(26005)(55016002)(6506007)(2501003)(9686003)(229853002)(8936002)(105586002)(7696005)(14454004)(53936002)(33656002)(99286004)(81166006)(81156014)(2906002)(476003)(446003)(486006)(71190400001)(6246003)(3846002)(71200400001)(316002)(54906003)(478600001)(6116002)(102836004)(68736007)(4326008)(110136005)(106356001)(11346002)(74316002)(25786009)(66066001)(4001150100001)(86362001)(305945005)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5793;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vWJHEifwgH56bwOuitfi6twYAp7ErRR3y1XWK7V3x135fGBVUd8vYJRja71Tfjd2ERuxE9IqRqnwUXDXjKxnoAuOVjkZR3fScsuWtsnrub0g8Sc+wilEMyjH3fAy1ni7sgFrdnidFYzfN+BWNoqo7tCEmfCUmiM2/B0rG0eGoB6eyNnLhKdu2CQcol09FXF+PaQp5HkamQAyeLfFjdjkKWpJZ/3+sdPGRaOmQ7wlXRhjgfw/RNfVB5HF9KUcgr0XnCoizSOHMP4oOeVAjTedXiKSdVWIKeYBd/k5krvOLl6ASwszC3Fdm2HsjQFxF/Y0KDw6vULD1QAndDt5bLkvw6ntelUsc5rF3De6FKKgQjA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf156e22-a284-4a54-7e18-08d6598a35eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:45:46.3137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5793
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_174600_843230_2928B7ED 
X-CRM114-Status: GOOD (  18.85  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, December 4, 2018 3:45 AM
> To: linux-clk@vger.kernel.org; Aisheng DONG <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng DONG
> <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V8 6/7] clk: imx: add lpcg clock support
> 
> Quoting Aisheng DONG (2018-11-21 06:12:38)
> > diff --git a/drivers/clk/imx/clk-lpcg-scu.c
> > b/drivers/clk/imx/clk-lpcg-scu.c new file mode 100644 index
> > 0000000..15b7d94
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-lpcg-scu.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 NXP
> > + *     Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +
> > +static DEFINE_SPINLOCK(imx_lpcg_scu_lock);
> > +
> > +#define CLK_GATE_SCU_LPCG_MASK         0x3
> > +#define CLK_GATE_SCU_LPCG_HW_SEL       BIT(0)
> > +#define CLK_GATE_SCU_LPCG_SW_SEL       BIT(1)
> > +
> > +/*
> > + * struct clk_lpcg_scu - Description of LPCG clock
> > + *
> > + * @hw: clk_hw of this LPCG
> > + * @reg: register of this LPCG clock
> > + * @bit_idx: bit index of this LPCG clock
> > + * @hw_gate: HW auto gate enable
> > + *
> > + * This structure describes one LPCG clock  */ struct clk_lpcg_scu {
> > +       struct clk_hw hw;
> > +       void __iomem *reg;
> > +       u8 bit_idx;
> > +       bool hw_gate;
> > +};
> > +
> > +#define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu,
> > +hw)
> > +
> > +static int clk_lpcg_scu_enable(struct clk_hw *hw) {
> > +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> > +       unsigned long flags;
> > +       u32 reg;
> > +
> > +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> > +
> > +       reg = readl(clk->reg);
> 
> Use readl_relaxed() here?
> 

Yes, we can do it.

> > +       reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> > +       if (clk->hw_gate)
> > +               reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
> > +                       CLK_GATE_SCU_LPCG_SW_SEL) << clk->bit_idx;
> > +       else
> > +               reg |= (CLK_GATE_SCU_LPCG_SW_SEL << clk->bit_idx);
> 
> Write this as:
> 
> 	u32 val;
> 
> 	val = CLK_GATE_SCU_LPCG_SW_SEL;
> 	if (...)
> 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
> 	reg |= val << clk->bit_idx;
> 

Yes, a smarter way.

> > +       writel(reg, clk->reg);
> 
> This can stay "stronger", so no writel_relaxed().
> 

Got it.

> > +
> > +       spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +static void clk_lpcg_scu_disable(struct clk_hw *hw) {
> > +       struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> > +       unsigned long flags;
> > +       u32 reg;
> > +
> > +       spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
> > +
> > +       reg = readl(clk->reg);
> 
> readl_relaxed()?

Got it.

Regards
Dong Aisheng

> 
> > +       reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
