Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D09C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:17:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BFA20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iuyBspvY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Uu3EkhFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BFA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W9c9hS++Li0VWi+ZO338FoCcTV3U5vJoifT/FhzA81w=; b=iuyBspvY5n35pl
	dpQUscv7IZTLdeUJlEx/i8oiycv00I9Rn6S3d6ra4QVrEv6ofMMGJtmkRzcIldeIzqnf4Z+8AEKQp
	YqPi7EroZ2ml/n6U4Hxf4qq5TwSayhkapsvL0nFLa62MDM6/SDr7DtN00WqnQjr6TVbThSqbDoYKo
	p1KFVACnjQhR0zuNuLkh8+5+DCuglj7gzUylSKG0xaeWbDDTUeBPq3LPjAQT1IiqMutj5I/sy5eaV
	5z0FA8oYU1v9okKY99xdnQ7vSeE6WfufJ+WHKGvc4Y2szmHmjrZ1q+n7FzjXymIXhhbh6NEnRrTrC
	arXrZ6H1EaCan0GQe9kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVF4P-0007SQ-Gh; Fri, 07 Dec 2018 12:17:25 +0000
Received: from mail-eopbgr10096.outbound.protection.outlook.com ([40.107.1.96]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVF4L-0007Rh-GE
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPP5tRK+sNJp0eDHA3/FL3mtZZW9I8xTvLfguIg1Les=;
 b=Uu3EkhFjBd4+AMEm0N2oE8J7gi1UW/bm3D/XQ2o3l7CIoJhfLN0dzUYv6NvGOzf3ZyMUwAT55MZmDMVQdq4jGVK6YPE9B8iZ8GmvIWkQ+eHqKSjGZStXQD+ZsgoUr6csbLL70u/Wop1LxnXXt96Tjv8p4FQw89B06PWArCgoz64=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3646.eurprd02.prod.outlook.com (52.134.25.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 12:17:05 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 12:17:05 +0000
From: Peter Rosin <peda@axentia.se>
To: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
 "wsa@the-dreams.de" <wsa@the-dreams.de>
Subject: Re: [2nd RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Topic: [2nd RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Index: AQHUjiAuPcBol/ktREin2XNfhFOg2KVzMUQA
Date: Fri, 7 Dec 2018 12:17:05 +0000
Message-ID: <b70e4721-1cff-eb07-ed8e-8fc39b6e84ed@axentia.se>
References: <20181207112939.15791-1-tudor.ambarus@microchip.com>
 <20181207112939.15791-2-tudor.ambarus@microchip.com>
In-Reply-To: <20181207112939.15791-2-tudor.ambarus@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0180.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::28) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR02MB3646;
 6:EmDeVsmZImRqsqV5ItjzzOk3qm7PGdwnxUgEt5qAnEk4Vym8QbfP/nNenJmGLC81VisDuC4athAaAcC/1b/DQOev+KiyggVtz9Fp/al2pzBHjrl9dGzkarffp50nLgoVtf3GZJblO4RMBTRKj3mhhg33tpkcLogRFpzAjlUxokNfRno3evU7CjkcXuL/aS2I4Y7ekYb1sFlGPzS6ul4tv9y3ekKLKd8afMDiRxU22XQQS8EfCbiW2xZ/oPh7umTu4uySYSdJQec5XzYQdbrJrIxUJIdqu2dP5cADJ6Qy74CvVZy5VZJf2jJGA0dpgu62oJBnJLFr59k7znGaNG9knM4Cc6LXYKK3MbXuyaNQN0QjjG9GTZWKN2SXD0CWc1ia/yQU0pMPI63QXn3Gj/OPJNb5ppvRlMUnSWnyxPeD6UDShWx/lSAM7AM4kuB0iI+aiDkrEGQkF/AFl/N+euuSgQ==;
 5:bk6ABOzjrH6BkzdGdDz0yJ0uMJZm+Q0fVladLrcloftCPzFiJa7aI/xGHG2WtBP2Ci7XKZutrf17fVZBYe13W55anH/zMMje5oG+vR5Du4RaaCFzs7xcK6F1nECTRYtnKbjSYafnE+dlUM1k7Q20HNPvldhq9/gDs6ebgnKQ2KE=;
 7:nL8E7wdfzavXk2A+DDYZxEhDQctBox3VzvH6vI8Vi9gx/gSycOqAhG2rmNd6pnKoCpuHeUAsbiaOkHvLZgu0xCEa2CXGrYWBYB6+ff55mBv8S9eUcBg6YUfH14itQzIHWcyoL8hbXDEVxzaEgNJStA==
x-ms-office365-filtering-correlation-id: 8b91b550-cefc-4511-5116-08d65c3de6c1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR02MB3646; 
x-ms-traffictypediagnostic: VI1PR02MB3646:
x-microsoft-antispam-prvs: <VI1PR02MB364698699CDB47C20E296019BCAA0@VI1PR02MB3646.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR02MB3646; BCL:0; PCL:0; RULEID:; SRVR:VI1PR02MB3646; 
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(305945005)(186003)(52116002)(76176011)(31696002)(26005)(386003)(6506007)(102836004)(53546011)(14454004)(6116002)(229853002)(3846002)(6512007)(6246003)(53936002)(64126003)(217873002)(68736007)(476003)(71190400001)(256004)(71200400001)(81156014)(5660300001)(8936002)(7736002)(446003)(11346002)(486006)(99286004)(65826007)(86362001)(8676002)(14444005)(81166006)(2616005)(316002)(58126008)(54906003)(110136005)(74482002)(97736004)(106356001)(36756003)(508600001)(65806001)(65956001)(2906002)(6486002)(25786009)(6436002)(4326008)(105586002)(66066001)(31686004)(2501003)(42262002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR02MB3646;
 H:VI1PR02MB5119.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VoHI/it1wJA9uIcdOUejaxuQCjQxFObgp3EvIiwlqophs1gyjV6tWk+C7+wEwKnN8mMzX5VUcqMlpaP2ho1yGZg/j0Sirg94/aTp3FqYDo7eHxrUO6DxrqPH5PCrGhieUQmp3AKHg5vmlhqvtfMv4YPHwD+BqQ1GB+Dhlkn2vkTQWIcmsUTHFNRnIN6uO3EKsLr/2UIedoQs4AKCwGKrPy5s7sP4f3XCRl/6H1uKEeiDYgIDU1kC6bl6BfQ62ThIrFxE4y8knDBUlIyLt8Vmg8yI+MdjUo1OI8BMUJr8Xr8m2oIsRaHOU2rUTGrH7/EUgUCleLy34LjUnub7NHmABGEnAmo1oj2Z6nvR/0L+XZU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3D88C2896AA66A499C41B51F6DCF224C@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b91b550-cefc-4511-5116-08d65c3de6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 12:17:05.8006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3646
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_041721_755040_C4493C1C 
X-CRM114-Status: GOOD (  20.77  )
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
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-07 12:29, Tudor.Ambarus@microchip.com wrote:
> From: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
> 
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in the device tree, the buses __usually__ assume it's 100kHZ
> (see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
> clock-frequency, so the default clock frequency varies from bus to bus.
> 
> There are i2c clients that need to know the bus clock frequency in order to
> compute their wake token (see atecc508a i2c client).
> 
> The clock-frequency value has to be propagated to the i2c clients, otherwise,
> if they will not find the i2c bus clock frequency in the device tree, they
> will have to make their own assumption of the clock frequency.
> 
> Spare the i2c clients of making wrong assumptions of the i2c bus clock
> frequency and enable the buses to save their clock frequency in adapter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviwed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

This is not the correct spelling of the tag and probably the reason for
the lack of reaction from Wolfram. The tag has simply not showed up in
patchwork and the patch has thus been postponed. Probably...

Cheers,
Peter

> ---
>  include/linux/i2c.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..f238da204c49 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -677,6 +677,7 @@ struct i2c_adapter {
>  	struct rt_mutex bus_lock;
>  	struct rt_mutex mux_lock;
>  
> +	u32 bus_freq_hz;
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
