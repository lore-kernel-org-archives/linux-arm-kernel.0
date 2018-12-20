Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44658C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126B220869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WA7drMVF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RARId6oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5KMWrr6/LXfvusngQzcAUu9izAhJzWPOJqBmVS6EhYA=; b=WA7drMVF7j/yro
	OqnSQ7xGtyTQSroWfqhj8pg/JsP0kVVdkQoya7ysj5sI1QSrzdUvpnIEN2hKx68ig9SmrSb4WU9iq
	LH4XlPr+F3owEK99Y8sdaS6p9sBQF9Fbkylc2WGsWzXCC3DXX/5As1ijXijypomSos9z3HGJCBpVB
	EKwXGWbDGcNSKfe+fIVoyFoBgbrSg50inigUk2rChim3urZyxW0GLzpbW9pzfaO3/E5ib1ZQdX0AU
	z3dpMCmTYbeaM9bef4kQ99swijjXrHB4a9xAQwfTCBEj6wXYneZ29Q6BnKnCLs6oWb+krgaB+als7
	1mgot7kc8ZTglnHGdGBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZqSr-0003sB-PY; Thu, 20 Dec 2018 05:01:41 +0000
Received: from mail-eopbgr1320120.outbound.protection.outlook.com
 ([40.107.132.120] helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZqSm-0003rb-UU
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 05:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjR9BhIEe007jnYIhDW/JIiO1af7iFLX8uFVFbN7kEE=;
 b=RARId6oaJZeVEQ30oDO2MavK2kIjTzvkindqAX4rdq5e9ErIx3tW4Q6S0q65Yk3Bq0iSRd6STcs11qf3RAXtvybvfGIUN5JmyduTrGKsIAUZp3JDX+IB0CuxmQ+yYFxfvRaQekxKmIvS9eAByrArTvl/Byu9R1I0PnCtPmUERbs=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (20.178.132.147) by
 TY2PR01MB3418.jpnprd01.prod.outlook.com (20.178.142.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 05:01:18 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::c0dd:216f:2766:d8d4]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::c0dd:216f:2766:d8d4%6]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 05:01:16 +0000
From: DUNG NGUYEN <dung.nguyen.aj@renesas.com>
To: Marek Vasut <marek.vasut@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Thread-Topic: [PATCH] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Thread-Index: AQHUjmuFwt0SAYWBzkWdZE6W6yFUDKWHI5qQ
Date: Thu, 20 Dec 2018 05:01:15 +0000
Message-ID: <TY2PR01MB369237F587AA0FF04484E421D5BF0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
In-Reply-To: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dung.nguyen.aj@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; TY2PR01MB3418;
 20:I+U9Cr8OKalZVIOXLFaXwuvxVk7iDgeFaOQz/D+lgD46zzR9sbaCBYyhiNZiPe2FQO0BlD49E9XfrjKbZ5xjG9AP9/AIyOhAP7zf4i3BjXhgM3KRd8XYJcsRJ3dTTCVgByPipb2WlJm1n+rl18DVkPB0Fc32amCPE+GD5COar5g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(5660300001)(305945005)(39060400002)(74316002)(486006)(2501003)(7736002)(229853002)(25786009)(4326008)(6246003)(446003)(6436002)(53346004)(11346002)(476003)(14454004)(478600001)(71190400001)(71200400001)(7696005)(105586002)(26005)(110136005)(68736007)(76176011)(99286004)(102836004)(53936002)(6506007)(9686003)(106356001)(186003)(54906003)(81156014)(8936002)(8676002)(97736004)(33656002)(81166006)(86362001)(3846002)(316002)(55016002)(6116002)(2906002)(66066001)(14444005)(5024004)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY2PR01MB3418;
 H:TY2PR01MB3692.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: bb70d21d-f846-4e96-961d-08d666382bf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:TY2PR01MB3418; 
x-ms-traffictypediagnostic: TY2PR01MB3418:
x-microsoft-antispam-prvs: <TY2PR01MB3418B3B7FA88CBB694B9323AD5BF0@TY2PR01MB3418.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:TY2PR01MB3418; BCL:0; PCL:0; RULEID:; SRVR:TY2PR01MB3418; 
x-forefront-prvs: 0892FA9A88
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bIBetSrxZg98aOnFIRgsn71fmyTdLE8E4ilx7DIiGYRIWAzbsq0rSdXknhcONwDxWLVIIfyes+avZneF4svTy/iD9dpeXqI24QtHr1AcD/IFVOl/YN1Vd+HHUiq2GViDwZJzYqkCSbvtcD6wICtIPrHNHbG0G2bUTwm9Fst7KNCrp8lqVzo5PTqJVeeaCJFBxYHlgGaeXugJVzQoWZk4To1V8tMA5uV2uTXA/RcdS9bgJ4lUsO6Q5fYvmHF+POwzrREbJPeFApl+HuRx3/1GliJXq+BXnJtUZAZhD54m4M+NxKTfX5H8X0xWnGSgLhA4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb70d21d-f846-4e96-961d-08d666382bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 05:01:15.7180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3418
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_210137_032675_7A3BBABF 
X-CRM114-Status: GOOD (  21.77  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> The quirk code currently detects all compatible I2C chips with a shared IRQ line
> on all I2C busses, adds them into a list, and registers a bus notifier. For every
> chip for which the bus notifier triggers, the quirk code performs I2C transfer on
> that I2C bus for all addresses in the list.
> The problem is that this may generate transfers to non-existing chips on
> systems with multiple I2C busses.
> 
> This patch adds a check to verify that the I2C bus to which the chip with shared
> IRQ is attached to matches the I2C bus of the chip which triggered the bus
> notifier and only starts the I2C transfer if they match.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
Hi Mr Marek

Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>

I have tested this patch on H2 Lager with mainline v4.20-rc4 kernel.
Confirmed that the problem is improved by this patch.

Best regards,
Dung

>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> index d4774d8ff997..f78e5348bd4c 100644
> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> @@ -40,6 +40,7 @@
>  struct regulator_quirk {
>  	struct list_head		list;
>  	const struct of_device_id	*id;
> +	struct device_node		*np;
>  	struct of_phandle_args		irq_args;
>  	struct i2c_msg			i2c_msg;
>  	bool				shared;	/* IRQ line is shared */
> @@ -102,6 +103,9 @@ static int regulator_quirk_notify(struct notifier_block
> *nb,
>  		if (!pos->shared)
>  			continue;
> 
> +		if (pos->np->parent != client->dev.parent->of_node)
> +			continue;
> +
>  		dev_info(&client->dev, "clearing %s@0x%02x interrupts\n",
>  			 pos->id->compatible, pos->i2c_msg.addr);
> 
> @@ -167,6 +171,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>  		memcpy(&quirk->i2c_msg, id->data,
> sizeof(quirk->i2c_msg));
> 
>  		quirk->id = id;
> +		quirk->np = np;
>  		quirk->i2c_msg.addr = addr;
> 
>  		ret = of_irq_parse_one(np, 0, argsa);
> --
> 2.18.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
