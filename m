Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C865C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031FE2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JDm70JYq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kD7FUO42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mQF9IZ+gywgxjlBeDR8fDwgMa1oQRVSIGVWmrUke/MU=; b=JDm70JYqMQU7X9
	GsfzOnmiMcFyZ0SV3uR9JqvxLBt+LU0Lo61Wy1arMrkkQqXjOEZdXfLpWWGwCWBGmXUErZDCaOj9r
	gljuqcfQgMnVfr+kMdw7vfwYETzrDFEuVYZ6x/wmmYguFuNdm4yPj9JUKlGOgf4tPSjPQ+0kbqUTF
	5WiuVfhMTO50DTWE8+2WhnTNCeIwivNmdo1eismUTKiD63A8DKTTfXapkg5enRnFrUw1W09lGgqv2
	J2StUPMAofD8VanaSeZAPY74aqbwA4mbwanDab9nu6kAt1nJYSjwst4TpFe+Z64qxqlya+xv5HTIQ
	DC+/xu+jdBZ5sUazXUwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTzTg-0007vu-Va; Tue, 04 Dec 2018 01:26:20 +0000
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTzTc-0007vO-Tk
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 01:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LwgS3d53RZQPIszofY3ftzED+ZeNcrnUS+wCTsw4Q4=;
 b=kD7FUO42Lhe5imcL+L7866ieFJzIJtiC4y+uo73X0UA/qmERPewpL1H4dWh4F5CEiIH4TBskwzuXHV3rYWRMztOquzUVVvGuIk36GLIKxXm5aCcq8PK9jhedv0YlpC7HI1Tb7shIKVcxBX/rJDkxj7Hn2Asgw7ff3NwdUDHx20A=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4210.eurprd04.prod.outlook.com (52.134.126.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 01:26:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:26:01 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V8 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V8 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUgaQ57574XhcTGkWdT/7YvWkhRqVtaiMAgABvc/A=
Date: Tue, 4 Dec 2018 01:26:01 +0000
Message-ID: <AM0PR04MB4211FE93C147DB95181E8CBE80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-3-git-send-email-aisheng.dong@nxp.com>
 <154386202048.88331.5253991483966563852@swboyd.mtv.corp.google.com>
In-Reply-To: <154386202048.88331.5253991483966563852@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4210;
 6:GQxcQUuEfdf1stLWzNGJY2pHvnTG8jsqSKLz1lykZs1XggnkCGBIlOvLXqZ0hm8VltcV6u8l30N1haSnSca7TymA3SBtV0mGNB/LeKKUN/mG+EtsxLTJeh90ElFi0pAHqC53vHZ4JYwMuhYugg3RgF4Gl7o79Wo/eKJ5zJ18v0XgKkujhxKTMhe24EJJquni5xKWJRvpYfgI3xCQ+d91N7E4qxSEpFjECSBdSzijZA1mBj1kmnBbWqFD8kUE84ZudHUEJ3L7Q1iUi1SBm49q/AP9YDHfO51I/xFW/RyvD4bPjq3or4cb0RRlIz+4SmLAdGOj3UHPICUZPhPg6vDYcZwbu9Vv5sku4NfeWkHUlU7pVykDcup8pTWLnVvSYYZqQRq3GX7g2eM83H5vCaHpVls4gc7KMs3wwn+e4KZDuMURiIYbw/SIPIEttavb1cxPB0NgoNw3eD5D/QUJLCRTLA==;
 5:CONCB3J+aEAY9lByRxUQMQcW9w7irKQIUM7SMiqbX4TE5NCV3RsKDJmzDOkeh1u9dHYn7qKKIQfPP5OIXyYbkKoTlOZG/lZIzT0IhoEyTg6fx2i16MB0nCiA7O2KtAt9G272nM3UVaY+4petQLeUk9bIFunZMAfyFW+e/aOnb58=;
 7:el9YP/8+tNPYNgTlSRjEB5RnXdrAaxOi0QMpMF0spSjNF9HPwsR3+drs92/cS+xDxL9/2YBssrdoeq3G5Vn8e5XZkWXoNpBI1mxAXyzvKY8O4O/2Tj4qLlpk64LMKSCS5OR6lCLQsjPYRanNj4zXOA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 18ae52b4-1160-43b2-8e93-08d6598773b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4210; 
x-ms-traffictypediagnostic: AM0PR04MB4210:
x-microsoft-antispam-prvs: <AM0PR04MB4210E724534CE24664F2470080AF0@AM0PR04MB4210.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4210; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4210; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(13464003)(71200400001)(229853002)(14444005)(14454004)(110136005)(256004)(54906003)(86362001)(71190400001)(6436002)(81166006)(6246003)(53936002)(2501003)(4326008)(5660300001)(55016002)(8936002)(81156014)(8676002)(99286004)(76176011)(53546011)(6506007)(102836004)(26005)(74316002)(7736002)(7696005)(478600001)(66066001)(68736007)(186003)(25786009)(476003)(11346002)(33656002)(486006)(4001150100001)(6116002)(97736004)(3846002)(105586002)(2906002)(305945005)(106356001)(4744004)(446003)(316002)(9686003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4210;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D8/XCkKb+yZa8L7tajLvS5oE3xzj9/LXZIkfteOjp9hgNoZ2wLktmE8KTA3w2YpIyhC920TToO2AGn59mRsx1h+DdwiyT5zcQyfM+tqAnNP/e9/MvkzjXucLsjMUyVKYBAMPKTFMnPHj73vh54RIlMW8RzPV7x3r91XkLDrqYg/X0MQb91FDNVx2Jxj4ucbXuA4MwvhZInHFbQ1mtuuo1gjwimGQiSla1Ngm2v3OkHKmHfBzAEwQaKs43SKhnQ8HHSpered1gEKed/V7avKKy/GipFgYJTLUUD2kY1SdBaH4J0UKU/c7PcOuy3VLnehRrBWNN3T67XUBwnf2l1F4xl2a01smATJTE99+aqfR3Gs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae52b4-1160-43b2-8e93-08d6598773b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:26:01.5246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_172617_526624_4D11CCC7 
X-CRM114-Status: GOOD (  27.37  )
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
> Sent: Tuesday, December 4, 2018 2:34 AM
> To: linux-clk@vger.kernel.org; Aisheng DONG <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> shawnguo@kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> <linux-imx@nxp.com>; kernel@pengutronix.de; Aisheng DONG
> <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V8 2/7] clk: imx: add scu clock common part
> 
> Quoting Aisheng DONG (2018-11-21 06:12:23)
> > Add scu clock common part which will be used by client clock drivers.
> > SCU clocks are totally different from the legacy clocks (No much
> > legacy things can be reused). So a new configuration option
> > CONFIG_MXC_CLK_SCU is added.
> 
> Why are they different? Can you add more details on what has changed here? I
> hope to see something like "it's a firmware interface now".
> 

Good suggestion.
I will add it in commit message.

> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com> diff --git
> > a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c new file mode
> > 100644 index 0000000..5f9c1f6
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-scu.c
> > @@ -0,0 +1,267 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 NXP
> > + *   Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/err.h>
> > +#include <linux/slab.h>
> > +
> > +#include "clk-scu.h"
> > +
> > +struct imx_sc_ipc *ccm_ipc_handle;
> > +
> > +/*
> > + * struct clk_scu - Description of one SCU clock
> > + * @hw: the common clk_hw
> > + * @rsrc_id: resource ID of this SCU clock
> > + * @clk_type: type of this clock resource
> > + *
> > + * This structure describes one SCU clock
> 
> Drop this sentence, it duplicates the first line of this kernel-doc.
> 

Got it

> > + */
> > +struct clk_scu {
> > +       struct clk_hw hw;
> > +       u32 rsrc_id;
> > +       u8 clk_type;
> > +};
> > +
> > +/*
> > + * struct imx_sc_msg_req_set_clock_rate - clock set rate protocol
> > + * @hdr: SCU protocol header
> > + * @rate: rate to set
> > + * @resource: clock resource to set rate
> > + * @clk: clk type of this resource
> > + *
> > + * This structure describes the SCU protocol of clock rate set  */
> > +struct imx_sc_msg_req_set_clock_rate {
> > +       struct imx_sc_rpc_msg hdr;
> > +       u32 rate;
> > +       u16 resource;
> 
> These should be __le32 and __le16 presumably because the firmware interface
> we're talking to is little endian?
> 

Yes, I think we can do it.

> > +       u8 clk;
> > +} __packed;
> > +
> > +struct req_get_clock_rate {
> > +       u16 resource;
> 
> Same.
> 
> > +       u8 clk;
> > +} __packed;
> > +
> > +struct resp_get_clock_rate {
> > +       u32 rate;
> 
> Same.
> 
> > +};
> > +
> > +/*
> > + * struct imx_sc_msg_get_clock_rate - clock get rate protocol
> > + * @hdr: SCU protocol header
> > + * @req: get rate request protocol
> > + * @resp: get rate response protocol
> > + *
> > + * This structure describes the SCU protocol of clock rate get  */
> > +struct imx_sc_msg_get_clock_rate {
> > +       struct imx_sc_rpc_msg hdr;
> > +       union {
> > +               struct req_get_clock_rate req;
> > +               struct resp_get_clock_rate resp;
> > +       } data;
> > +} __packed;
> 
> Does this need __packed? struct imx_sc_rpc_msg is naturally aligned so I think
> we don't need this.
> 

I think this is more safe way. But struct imx_sc_rpc_msg is unlikely to change.
So I guess it's safe to remove it.

> > +
> > +/*
> > + * struct imx_sc_msg_req_clock_enable - clock gate protocol
> > + * @hdr: SCU protocol header
> > + * @resource: clock resource to gate
> > + * @clk: clk type of this resource
> > + * @enable: whether gate off the clock
> > + * @autog: HW auto gate enable
> > + *
> > + * This structure describes the SCU protocol of clock gate  */ struct
> > +imx_sc_msg_req_clock_enable {
> > +       struct imx_sc_rpc_msg hdr;
> > +       u16 resource;
> > +       u8 clk;
> > +       u8 enable;
> > +       u8 autog;
> > +} __packed;
> > +
> > +static inline struct clk_scu *to_clk_scu(struct clk_hw *hw) {
> > +       return container_of(hw, struct clk_scu, hw); }
> > +
> > +/*
> > + * clk_scu_recalc_rate - Get clock rate for a SCU clock
> > + * @hw: clock to get rate for
> > + * @parent_rate: parent rate provided by common clock framework, not
> used
> > + *
> > + * Gets the current clock rate of a SCU clock. Returns the current
> > + * clock rate, or zero in failure.
> > + */
> > +static unsigned long clk_scu_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       struct clk_scu *clk = to_clk_scu(hw);
> > +       struct imx_sc_msg_get_clock_rate msg;
> 
> I really hope msg isn't DMAed to the firmware, because the response is
> in there!

No, not DMAed.
It's sent over MU messages.

> 
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +       int ret;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = IMX_SC_RPC_SVC_PM;
> > +       hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_RATE;
> > +       hdr->size = 2;
> > +
> > +       msg.data.req.resource = clk->rsrc_id;
> > +       msg.data.req.clk = clk->clk_type;
> > +
> > +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > +       if (ret) {
> > +               pr_err("%s: failed to get clock rate %d\n",
> > +                      clk_hw_get_name(hw), ret);
> > +               return 0;
> > +       }
> > +
> > +       return msg.data.resp.rate;
> > +}
> > +
> > +/*
> > + * clk_scu_round_rate - Round clock rate for a SCU clock
> > + * @hw: clock to round rate for
> > + * @rate: rate to round
> > + * @parent_rate: parent rate provided by common clock framework, not
> used
> > + *
> > + * Returns the current clock rate, or zero in failure.
> > + */
> > +static long clk_scu_round_rate(struct clk_hw *hw, unsigned long rate,
> > +                              unsigned long *parent_rate)
> > +{
> > +       /*
> > +        * Assume we support all the requested rate and let the SCU
> firmware
> > +        * to handle the left work
> > +        */
> > +       return rate;
> > +}
> > +
> > +/*
> > + * clk_scu_set_rate - Set rate for a SCU clock
> > + * @hw: clock to change rate for
> > + * @rate: target rate for the clock
> > + * @parent_rate: rate of the clock parent, not used for SCU clocks
> > + *
> > + * Sets a clock frequency for a SCU clock. Returns the SCU
> > + * protocol status.
> > + */
> > +static int clk_scu_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                           unsigned long parent_rate)
> > +{
> > +       struct clk_scu *clk = to_clk_scu(hw);
> > +       struct imx_sc_msg_req_set_clock_rate msg;
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = IMX_SC_RPC_SVC_PM;
> > +       hdr->func = IMX_SC_PM_FUNC_SET_CLOCK_RATE;
> > +       hdr->size = 3;
> > +
> > +       msg.rate = rate;
> > +       msg.resource = clk->rsrc_id;
> > +       msg.clk = clk->clk_type;
> > +
> > +       return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> 
> This function returns normal error codes? Or some firmware special error
> code? Please make sure we return normal linux errno values from this
> driver.

The error code returned by imx_scu_call_rpc is internally converted to Linux
Errno. So the caller don't have to care about it.

> 
> > +}
> > +
> > +static int sc_pm_clock_enable(struct imx_sc_ipc *ipc, u32 resource,
> > +                             u8 clk, bool enable, bool autog)
> > +{
> > +       struct imx_sc_msg_req_clock_enable msg;
> > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +
> > +       hdr->ver = IMX_SC_RPC_VERSION;
> > +       hdr->svc = IMX_SC_RPC_SVC_PM;
> > +       hdr->func = IMX_SC_PM_FUNC_CLOCK_ENABLE;
> > +       hdr->size = 3;
> > +
> > +       msg.resource = resource;
> > +       msg.clk = clk;
> > +       msg.enable = enable;
> > +       msg.autog = autog;
> > +
> > +       return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> > +}
> > +
> > +/*
> > + * clk_scu_prepare - Enable a SCU clock
> > + * @hw: clock to enable
> > + *
> > + * Enable the clock at the DSC slice level
> > + */
> > +static int clk_scu_prepare(struct clk_hw *hw)
> > +{
> > +       struct clk_scu *clk = to_clk_scu(hw);
> > +
> > +       return sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
> > +                                 clk->clk_type, true, false);
> > +}
> > +
> > +/*
> > + * clk_scu_unprepare - Disable a SCU clock
> > + * @hw: clock to enable
> > + *
> > + * Disable the clock at the DSC slice level
> > + */
> > +static void clk_scu_unprepare(struct clk_hw *hw)
> > +{
> > +       struct clk_scu *clk = to_clk_scu(hw);
> > +       int ret;
> > +
> > +       ret = sc_pm_clock_enable(ccm_ipc_handle, clk->rsrc_id,
> > +                                clk->clk_type, false, false);
> > +       if (ret)
> > +               pr_warn("%s: clk unprepare failed %d\n",
> clk_hw_get_name(hw),
> > +                       ret);
> > +}
> > +
> > +static const struct clk_ops clk_scu_ops = {
> > +       .recalc_rate = clk_scu_recalc_rate,
> > +       .round_rate = clk_scu_round_rate,
> > +       .set_rate = clk_scu_set_rate,
> > +       .prepare = clk_scu_prepare,
> > +       .unprepare = clk_scu_unprepare,
> > +};
> > +
> > +struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
> > +{
> > +       struct clk_init_data init;
> > +       struct clk_scu *clk;
> > +       struct clk_hw *hw;
> > +       int ret;
> > +
> > +       clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> > +       if (!clk)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       clk->rsrc_id = rsrc_id;
> > +       clk->clk_type = clk_type;
> > +
> > +       init.name = name;
> > +       init.ops = &clk_scu_ops;
> > +       init.num_parents = 0;
> > +       /*
> > +        * Note on MX8, the clocks are tightly coupled with power domain
> > +        * that once the power domain is off, the clock status may be
> > +        * lost. So we make it NOCACHE to let user to retrieve the real
> > +        * clock status from HW instead of using the possible invalid
> > +        * cached rate.
> > +        */
> > +       init.flags = CLK_GET_RATE_NOCACHE;
> > +       clk->hw.init = &init;
> > +
> > +       hw = &clk->hw;
> > +       ret = clk_hw_register(NULL, hw);
> > +       if (ret) {
> > +               kfree(clk);
> > +               hw = ERR_PTR(ret);
> > +       }
> > +
> > +       return hw;
> > +}
> > diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
> > new file mode 100644
> > index 0000000..09f381b
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-scu.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2018 NXP
> > + *   Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#ifndef __IMX_CLK_SCU_H
> > +#define __IMX_CLK_SCU_H
> > +
> > +#include <linux/firmware/imx/sci.h>
> > +
> > +extern struct imx_sc_ipc *ccm_ipc_handle;
> > +
> > +static inline int imx_clk_scu_init(void)
> 
> Is this supposed to return EPROBE_DEFER or something? Who calls this?
> 

The SCU clock client driver will call it. E.g. MX8QXP or MX8QM clock drivers.
It might return EPROBE_DEFER or normal Linux errno by imx_scu_get_handle().

Regards
Dong Aisheng

> > +{
> > +       return imx_scu_get_handle(&ccm_ipc_handle);
> > +}
> > +
> > +struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
> > +
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
