Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA0C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E9621736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4CDKA6O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ArvH6x9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5hibOiuflMB2E36D//Be1epD6nLJIu0GL3BqgtiZm8Q=; b=l4CDKA6OqTCeC4
	hWPrElP/2UhVU/Ts7pNVE20mQHuZnSm6Lbjb8cA2JtcANYBXibDpITr0q2O85xG883rR5t9bPJ1i9
	7xiBfvSZjPI1Jbt1sC1e6k6Ve7pGeVENqkL+2TA7BIT+NwLL/R72nPQdgdrCv4t+3Os8tWfi5SyNn
	KQ06d+AzS3dk4cV7HZepRNMt3medKiVCj6yqu/nkkHb/34kYjpSkAetqw5b3y7R5lrdoLKIuZgSg3
	vKwWzy/Vy9bsjezsmMaWSSJY+L8tTGXSirAUYEmtM+pJobrMyF0wCieajPGjy8znjGB8wtR4tclaK
	DpvsOO0T83nupList0LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go3Yo-0007tC-36; Mon, 28 Jan 2019 09:50:34 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go3Yj-0007qv-HU
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:50:31 +0000
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; d="scan'208";a="26000825"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 28 Jan 2019 02:50:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 28 Jan 2019 02:50:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCNGsme7gBtFuFuB905T1siPVp34hXJnbrx1Od0T23w=;
 b=ArvH6x9Xxbzf54otwBKYdpbjiVb5D8qZhhz8dccVDQ/27S0GI7MR30aqUT1imMN6PXabo2thfLJAycYYiJRm3wmTfu4LmbTLdvgqLeWA4L4+e+uPIyqAPHw9HO9Lunf4WWsXT5VluO64Z+ozEfYXYeCpmhb3ixtWqj889Rwa224=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2013.namprd11.prod.outlook.com (10.169.234.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 09:50:23 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 09:50:23 +0000
From: <Claudiu.Beznea@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
 <pavel@ucw.cz>, <len.brown@intel.com>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
Thread-Topic: [PATCH v2 0/3] add support for power off check in suspend
Thread-Index: AQHUp0DMK00T01NVNECI4VrUGS1926XEjziA
Date: Mon, 28 Jan 2019 09:50:23 +0000
Message-ID: <5f0cf9d1-9a6a-4c97-8f56-6c5ae8af1564@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0026.eurprd05.prod.outlook.com
 (2603:10a6:803:1::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190128115013432
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB2013;
 6:/cekhKRKPs4m0V/5yuUdfwcieKK4LvnwWq09JdQO/fqWOznaCSpz0cM++20eXe54SXriTTimN3hJQYI50JX2/UOB9OwlOnb+2Zauff7uVODV+pyGEkd9G6tGI67svDCEOC+3BGorIyJi+WQ9mOOQMcy6jxWSZ8vLxXaqAsvf90WxrlrqsQEaCGG+HJy5IvGuJNjhMD4PeC5J4SasVqcAlIqJ80bDulyCNTy12Zkj2bZjY/RFKLi3mDUTv4ogQlEEVHEq8SGM9nAjefWUxsMf8iab10ZWZ92j53F2AqMeKvQVoe9veAvdXXY3dtdPNUhJrVq3r0VuMFQz0nOeSATDpAwxrtZBbuxrutRDOth+sRaglhNt7RQFrRKcANQX6+4QkvueWI5i06Le67WdKrlqrBHjCnoy8kFuY72pt6h7tsoqDM3M2QM7dXhmTBaReEabzlx3Ko4uB4PEFA/NEdYZAA==;
 5:0gUwW5K3H6DF0+tBsDpabcO6QFi/nYuFRVXtdPdPc8fPxA6PABlua1JJNXu2n9lcj5AXbDZ/U1pp5ep4mY5F1u1OhyuRkc8lAitX7iWWjcmcL5FS6Zq1Ln5Wq/0jdqH266SOhkdeI1UG1pS4EBnIDY6trbrXRsPmOWbJ7SQZLOZbCa4wBDQg0W9aQrifi6iXblW0hkF0Zmoid1S6sgPM4g==;
 7:zcHMR+hNMeTJscQzLmtrll05adpHLaLjYsC/lKrAoJwwwUlQyA7lswOLrZ+UcfJisg5TP2OcquT3o1G1soBZ6I7n3MxOOTQn6j+0/l3c8YH+AjfSt7nc2NV6KSLGaGWc1XFGJUKAOWHirRUb40omKQ==
x-ms-office365-filtering-correlation-id: 7a0050bb-adaa-4354-3c08-08d6850605d8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2013; 
x-ms-traffictypediagnostic: MWHPR11MB2013:
x-microsoft-antispam-prvs: <MWHPR11MB20130D769F0D788CAC77C2DF87960@MWHPR11MB2013.namprd11.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(105586002)(316002)(14444005)(966005)(72206003)(31686004)(14454004)(478600001)(66066001)(97736004)(110136005)(2906002)(15650500001)(256004)(54906003)(81156014)(71190400001)(8676002)(106356001)(81166006)(71200400001)(7416002)(8936002)(229853002)(486006)(446003)(476003)(2616005)(11346002)(386003)(6506007)(53546011)(102836004)(76176011)(52116002)(26005)(39060400002)(99286004)(6246003)(6306002)(6486002)(6436002)(3846002)(6116002)(36756003)(6512007)(53936002)(305945005)(31696002)(86362001)(68736007)(25786009)(186003)(2201001)(2501003)(7736002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2013;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sYmOLev/DEFnBmwkhsfHny3S6ssGDk30dAitod+jWDkzoU50qCzwjetKVBe3aiXa+vRsIEDk9U8ASf4+naBthzVX7crgRWL7T5dlJCG2jA0pKNA8tTohZMQUGc1SvcHMOpbzOtFMnSVjhxMTocGmScKQ9N13fXISqobkoZ9DDCDkFbZzZApQ6ck1NKaXeJhef8ubqngkde+YNhir2QUIAXkbaQ9XKXZeDYnMrAoGo7Hso0PxmB3eFf6DG354+5CwGgFOdlKfBC38Yw0tajM881P7kV6eD24zCWiHbLUuQ9t5Py9IHwXgd/EHpaAiEIiWaxvkzBv4C2ovqT52j6pIIVJp3XU6ZXc5BZUmzJkh6sk17GqLVbk8bT8ZNEiuAe9aPgQtBkAGNJrbzkn18S9xbt22SRvrUJMKw345vEnh9QM=
Content-ID: <5F04E4E280C7C1419279A256779218F9@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0050bb-adaa-4354-3c08-08d6850605d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 09:50:19.2845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2013
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_015029_748508_217C8B0A 
X-CRM114-Status: GOOD (  23.50  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Pavel, Rafael,

Do you have some other hints I could follow in order to solve the
scenario I tried to cover with these patches, if these are not
a proper fit for the current code?

Thank you,
Claudiu Beznea

On 08.01.2019 12:56, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> AT91 platforms support a power saving mode where SoC's power is cut off (we call
> it backup mode). The resume is done with the help of bootloaders. To be able to
> suspend/resume Linux to/from this mode all the drivers suspend/resume callbacks
> should save/restore the content of all the active registers. We have 2 problems
> we are trying to solve:
> - some of these drivers are shared with other non Microchip SoCs (e.g. macb
>   driver) and we don't want to disturbe other users of corresponding IPs with
>   all the register save/restore operations;
> - the suspend/resume time for the rest of the power saving mode we are using
>   could be improved if we would know in drivers the suspend mode the platform
>   is switched to.
> 
> A solution that would have been solve our problems was proposed in [1] but in
> the end it wasn't accepted. It ended up with the introduction of
> pm_suspend_target_state variable that could be used along with the changes in
> this series.
> 
> While the discussion of [1] progressed it has been proposed (in [2]) to
> implement a function that would tell if the platform's power would be cut off
> at the end of the suspend procedure.
> 
> The patches in this series does as follows:
> 1/3 - add a new member to platform_suspend_ops that will tell if platform's
>       power will be cut off at the end of the suspend procedure; drivers could
>       use it via platform_off_in_suspend()
> 2/3 - add a new function to regulator's core that could be used to check if a
>       proper regulator has been configured (via DT) to be powered off in
>       suspend. This is used on this series to check the CPU's regulator is
>       properly configured in DT to be turned off in suspend.
> 3/3 - fill .off_in_suspend member of at91_pm_ops; the functionality in patch 2/3
>       is used to double check CPU's regulator would be turned off in suspend.
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://lkml.org/lkml/2017/6/22/938
> [2] https://lkml.org/lkml/2017/7/16/457
> 
> Changes in v2:
> - remove !! instruction in regulator_is_disabled_in_suspend() and
>   at91_pm_state_allowed()
> - s/weather/wether in patch 1/1
> 
> Claudiu Beznea (3):
>   PM / Suspend: Add support to check if platform's power is off in
>     suspend
>   regulator: core: add helper to check if regulator is disabled in
>     suspend
>   ARM: at91: pm: add support for .off_in_suspend
> 
>  arch/arm/mach-at91/pm.c            | 61 +++++++++++++++++++++++++++++++++++---
>  drivers/regulator/core.c           | 17 +++++++++++
>  include/linux/regulator/consumer.h |  7 +++++
>  include/linux/suspend.h            |  6 ++++
>  kernel/power/suspend.c             | 13 ++++++++
>  5 files changed, 100 insertions(+), 4 deletions(-)
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
