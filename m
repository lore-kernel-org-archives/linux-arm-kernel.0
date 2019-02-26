Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B50FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF162173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpVC2/QQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eAhXRzYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF162173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ppEFuaY8iVYT+69Ig5w3k3hCRV4Pc3138FlP7J+oKQ=; b=mpVC2/QQ/Ie3bu
	CuKP3OVco2jGdexgjC0/SrQOkzqg+Wf8bUpmaRD++R+yERtBNqsXbIHZ0fiVTjYsE/A5rKV44Chuj
	Ufq6lPbRf0/ZfRw4ubQLgFSer+tpu5sESLx+JpXhU2fUeqFGM8bTF9743RK9nPwbKIW/03/evqAIU
	8iN3eEqDatopuAXMmir7OOCQOnEwet0cLFT2XMRVBsSlw1ABZ9GoHhM0Y1LmfzadNL4WglFESGrYg
	djZHeFO+FIYYHt36XJLDx0DodQQO5DPjB5Uai2yrEjFdN0qQy20CaQtHs7nJ1CWkFkJbbnb4QVHbi
	aLo+dCO5/dM62Qz3hhGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycsv-0005R2-1u; Tue, 26 Feb 2019 13:35:01 +0000
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycsr-0005JI-Dm
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:34:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35JsWmNZIqCxAq1srSOTy5QDMK6YLUaqaHqWfWJwALk=;
 b=eAhXRzYGBKQlcB/oWTn/ic4MFTfGjU1n5aMg9EsRx025bAjNObEt/awU3FEzUCVZAvAzPF5p/qCPlvZ++oiGUFuSmKwr0Pw84+HWYf4zgOoH/Ie7vP3Yy6t/OiKDk4v+wZ6swIq7izo7NY3CZzeQ99Rosru162DuMffRaURE24w=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4381.eurprd04.prod.outlook.com (20.177.55.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 13:34:52 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 13:34:52 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUzcGB6LodUxnT8UyD0+K7eGuy3qXyFIYA
Date: Tue, 26 Feb 2019 13:34:52 +0000
Message-ID: <dff8a3aa9dd6501280300654f085f07c87d4cd23.camel@nxp.com>
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a36cbff-6105-4c40-2e68-08d69bef2ff1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4381; 
x-ms-traffictypediagnostic: VI1PR04MB4381:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MzgxOzIzOitVWkU1OGVXY0ZyZWhBelkxd2x3QkdzWVpw?=
 =?utf-8?B?TVF2R2pJSXJITGlTQTM1UVpzOVVXazliZHB2cDdNc1piTFovdEw5M2J3d0Vq?=
 =?utf-8?B?eE1FWUxGRTZxbS85MUhYaXBnVWNQK2RzOFBGT2dTV3dwb2FjVWtlbkJBSFFY?=
 =?utf-8?B?a0tHcTlmVDBPQ3lLa280VVBTeE9adjJWVkladnN6RXJYT1NqUTNSeHo4MFNp?=
 =?utf-8?B?WWlMUWQwM0FqS3Ryc09zRzFoRTBYdmZUOTVrR09STXIwdE5jS0ViNVZzdCtv?=
 =?utf-8?B?aGFkTHY2d2cyR2tUZDA4L0J3UnZGTXJUQUV2ZjVFbVRZcXJTRGpaYjFzMVBO?=
 =?utf-8?B?Wk1yaThmNU5DRC9KeEluajZwc0hIWURacmQ3MXNIaVRGdDl0d0ZWRHNVRGQ2?=
 =?utf-8?B?b2lCMzhaUitKc3VpNkl0SGErVHE2MDdXejV0Tk1zVEdqckUrbXhEMjlVUWdS?=
 =?utf-8?B?RHNBcEtZVXA3cVZ1endTbVN2QWpXRzlxL3ZGNHd4UnRWQi9waW1EM292Y2x0?=
 =?utf-8?B?eW5DNGt5alQ2ZlFMRTBlb3E5K3NXeG8rRUc1bEd2N0VKeUFsemlkUWlJM0cy?=
 =?utf-8?B?YVlwcTFyTGJhWWl5VGkxMVBTY2x0QnNUaSt4L1lQK0ZOU3V0MERuNit6Z1Rm?=
 =?utf-8?B?ai9tK1JlOUV6RTB2RWh5TEIrbFRSYWJxd3dzaEVaalAvZ0g2MGI4WWRjdFZJ?=
 =?utf-8?B?a1VoSUtVeFppcVpLTDhUdHJlSzZRU3E1Znoxa0tFTUhQN2R6TFE3cG5VNjZR?=
 =?utf-8?B?Uk04Wk5XSjNPZHFpSm03Qkw4YTY4bEZ6Z0NxTmhKbW5naFFSb29KcGNCTHNS?=
 =?utf-8?B?MVRYNU5ERExPa3k1VDRXYVllbE1tNzhxSU9IQ3MzZWFLYVRYSWtMejU2bzdH?=
 =?utf-8?B?eFBIQTRDUzBxYkYwVjhtVjU0L2t0aEk1OE1sOWNkaDUzRjlPYVRaeC9odHJi?=
 =?utf-8?B?N3ZWWDZmajE4bVNtSTBuSHcrWXhTclFNQ1J5SjgvZ0I4dUc5dkdNMmRKcEpl?=
 =?utf-8?B?TVh2UzM5ZzY2N21yN3V0eXRMNDBpeWlIMjcrUWZ1MXhXckZ2NzFBNk1wY05i?=
 =?utf-8?B?V2ZMQUJlNzVESmJsajZyWnlyMzErc2ZKZk83Nmo5TEFRQTNSNFltSmoxYzVS?=
 =?utf-8?B?enhpWHl2WTdObWF6TzJ5aVVlcUMyMGVBSlNYQ1UvYVFkT3VPaFhYS2Fzam1B?=
 =?utf-8?B?NUswM3I4aXpKNzJFV1RTWll1cXlIVkRkclR2UlFpQ3BaTStLWHl2YUk2eDJO?=
 =?utf-8?B?SE8rMVhIYVdtWUFNRjZSWCtxUTNhK1hYQ3JNa2NVWnZXQ0lGbldZbFIwb096?=
 =?utf-8?B?S0ZyK29tRzZtTjJ3anI3SWQyYXdZYXFlYS9hUTlPQnZwM01SQUFkUVl6YnQ0?=
 =?utf-8?B?NzcrQXBaaUt3YzMxQlZGZzIzNGp6cHAzRXpNdXlIT2l1bEN6TFlQVEowUklX?=
 =?utf-8?B?VUg2UERWU0ZaT3ZhRW5CbFlIaldOOUsxOTZEVDYyR1l1cW5zNk9yQkgxaHZk?=
 =?utf-8?B?Q3ZJMG9PMisrZkNnNUJRSmxWbmpqVXFQNVh5TnVXSGY2amR4L2Y4MHExMzFy?=
 =?utf-8?B?VEh5MjNkeEhmWCtLMmRWUmJOR25Ja1hqWFZZc25tcFJTVEtNb0tXMG81My8z?=
 =?utf-8?B?SkNvSklvdTBVcURhQnBSa0dXMTlKSTZiU2x5UFNSN09oV1VGWEl3NE9JNXFE?=
 =?utf-8?B?elVVZXMyQVkwL3FScHQxeFhSK3BCMEVFcmZlVHB1eTJxNmJpRmxuZGY0bmo2?=
 =?utf-8?Q?7sqO0768h9jGignnd8XdRHDHrW0UX9SMcilZw=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB43814CB3DD1A709B89E073A2EE7B0@VI1PR04MB4381.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(2501003)(8936002)(50226002)(186003)(486006)(305945005)(7736002)(81166006)(478600001)(102836004)(53936002)(76176011)(446003)(44832011)(118296001)(26005)(66066001)(11346002)(81156014)(8676002)(476003)(2616005)(106356001)(14454004)(105586002)(6506007)(97736004)(68736007)(36756003)(25786009)(6512007)(256004)(86362001)(6116002)(6636002)(99286004)(6486002)(4326008)(229853002)(316002)(2906002)(5660300002)(6246003)(6436002)(71190400001)(71200400001)(3846002)(54906003)(110136005)(99106002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4381;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OB0LZZnf31dlZqn88uoEjE6/DcILqsme+KV5v7M0eI/9JvNd1qHG6nFykOZ1NR6nCc1ztoVi7wQI7zWb65uc+qJxFz9QkevbJDT2FL9xzHY/zbCSSSF+XDTFq870fCBDrG1mQ7h3PjycOaNNi2hxNdFpS+Rk2UmI0nq/mRu7fIg7+Qfn2Py1mzQ18Heqdjws0qbJZwJwzuFAMFJYdAR9wkViFCmGldy4LFNbnUPO30AeLKk2x2CGB23kR9xh3NhL3GCaFnBj8TmVWa4OgW7FTjzpmF7B5sf41PUIah/Q4Ww3x5UFnDNIuNR82KzhchnMEB+9vkIyK06pTLcaccwBy6qvxXk0OKcAnWx06WfEaJSEF5BvMqcwnQL1YV8xYBCT1z8fhxTSwWC+ysF2jhYtyTuEmScqkuUfOW00B1hxIRE=
Content-ID: <7637D2E33C5F6348BE2132B33F3242D6@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a36cbff-6105-4c40-2e68-08d69bef2ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 13:34:52.2187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_053457_470542_638C1A55 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: "robh@kernel.org" <robh@kernel.org>, Anson Huang <anson.huang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "abelvesa@linux.com" <abelvesa@linux.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "spencercw@gmail.com" <spencercw@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-26 at 10:53 +0000, Abel Vesa wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
> revision it will print 'unknown'.
> 
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> +	if (!np)
> +		goto out;
> +
> +	ocotp_base = of_iomap(np, 0);
> +	WARN_ON(!ocotp_base);
> +
> +	magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> +	if (magic == IMX8MQ_SW_MAGIC_B1)
> +		rev = REV_B1;

Turns out that imx8mq version determination is uniquely messy. I think
we should try to print the revision number even for older chips so that
we know how old they are, but this code can be enhanced in later
patches.

In the vendor tree we handle this with a SIP call to ATF, it's not
clear why we shouldn't just upstream that (in both ATF and Linux).

Also, there are some imx soc revision declarations in
include/soc/imx/revision.h. Those are implemented in arch/arm/mach-imx
for older chips, would it make sense for soc-imx8 to define
imx_get_soc_revision?

--
Regards,
Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
