Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8434C2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0MbVP4X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yuDYj6zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8434C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7krtdeYU17Ij95N0Mc+fX5eGGuYjJClENob94fsnKDY=; b=B0MbVP4XD5W14K
	sdpm55YOfnZpiW7+PyFqoLof3cD4iFRsq4TZamIN2aCKs9VM8+82eJDIWAYYvgQ6MrcPHIpThP2U9
	hcdp9CGuqog1ohWhRBA/1Ul8GcuWZUEAMM00rUCLJ/crMwl4S3omlmvoibbjnSM+XmxH8KjmwlxG1
	CLVOxmAvPES9PO9uhULaiNMXs0OQ3D0hMwuv6FV9sWLENv/r9jLlwotq0aHgJUn4awqPrst5V0wu1
	aDroBJd0cCrkNzoGCBIL0rfauTUAXzSAheQ0knQuYGUqTbMBJMT73o+5PngNe+raw1tevZoNXI1JB
	2DJvbArkfld+EtaMfH7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtXI-0004m4-PC; Mon, 17 Dec 2018 14:06:20 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtXF-0004l9-4C
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:06:19 +0000
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; d="scan'208";a="25348364"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Dec 2018 07:06:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 17 Dec 2018 07:06:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+r9aTRB8U3MEznm8j5LxuS/dV+IQ9TM+YxgbJ4Xdyk=;
 b=yuDYj6zt6Qh2yBOaLHEitOLPLRq3BAkVvz4OkhIY2QvZdaDZ2HzdyAzSPKyW9EwxSrTv6t1WjT92Z5ARIyHb3b1y1nzRuJay4KFnTiZAhTh77YiZOtiK2AN86BY5eO0mcEzbR6k7YGp1HLzTIdzvvnjJgdWtJeJEQxc5nNyFaeU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0646.namprd11.prod.outlook.com (10.163.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 14:06:03 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:06:03 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
Subject: Re: [PATCH v6 0/9] extend PWM framework to support PWM modes
Thread-Topic: [PATCH v6 0/9] extend PWM framework to support PWM modes
Thread-Index: AQHUlhE8HNT3QU0iq0yzJwofK9n4eaWC9x6A
Date: Mon, 17 Dec 2018 14:06:03 +0000
Message-ID: <e82d397f-81d4-31e3-a1e0-7c31c362b10d@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0012.eurprd05.prod.outlook.com
 (2603:10a6:800:92::22) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0646;
 6:Tf9fL7+tshgHFa+xRkQp2Z2pqzeE599QWq0JrUjMG54LtHtp5Anf3OgZqb6Jb0xfJ0xHzxrfcu0OQZwTgS3GnAcnGF9nxJNooiaQFYU4hbbhuV9oClrME/kY2Q11iKp8Fg+56m3u21+sRm+57XAno/K/HTmtFwEVVuyyPRrJRomlv3yo+WkzGKMXtpnxT9Pvmuhe8eKhd8R4X182c577wj1a8W2T2QtQpJBqfhw5+Pdosaw6rL4NOAUtfoMjF8F425QsUR8B/XaQDbLYk1mvH3U8yGEZFk2eqItqt9dGD3xsPxqqI1YOXdWBEQBX/LUDiNBbBYyl0DdPOmKZTV3TJyvaE/bzjQzWniT7pZKnnvi+Zv4bmmhz70ituy5cGRwbCw6t/s/PuiN9GYIXv3Q6d3uLlM/HBvJEjHiWTL5Ju7VlTv7ZgxflW66O+J3Zlwg+PJzRsXHBRlYufV7ZAFm0Pw==;
 5:PUfhyAkeWz5RPsAeLkXEJ3bYqWazqOMakFw9eQ6XPEqFCoJ+ZNVo0ds4ONe1qCuMX6SPfPR8QB1TquUUNRiTqVgmiBLRmuqkyBuz7XyF634KJPE6tGHnzHSz8D2iifV/x+v4Ja6Ylb0tC8KClyELX50/YwirTOCBrhj0V0PoLFQ=;
 7:YwJBtlcL0f0yjSxhitL1CaZ883syC02/aHsXOAoTtfvLLZ4SxtiIgV9KHWhDSG6QsLMt71lc/c0JnjLG1igU4/joENNIFVxKgA+D6Bb2DX9xmpHRP3FB/to+DyeuTQlUJuiUN6MnUdIEvVvde8Hcdw==
x-ms-office365-filtering-correlation-id: 8c9b4c8e-54ba-4cd6-f6ff-08d66428c77d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0646; 
x-ms-traffictypediagnostic: BY2PR11MB0646:
x-microsoft-antispam-prvs: <BY2PR11MB064629EE40E452756CC5855A87BC0@BY2PR11MB0646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(4982022)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0646; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0646; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(6436002)(102836004)(26005)(81156014)(53546011)(386003)(6506007)(31686004)(66066001)(106356001)(25786009)(6512007)(486006)(229853002)(105586002)(86362001)(6306002)(6486002)(5660300001)(52116002)(76176011)(99286004)(31696002)(2906002)(446003)(3846002)(6116002)(11346002)(2616005)(8936002)(256004)(36756003)(72206003)(966005)(478600001)(53936002)(39060400002)(8676002)(4326008)(97736004)(7736002)(305945005)(71190400001)(71200400001)(186003)(476003)(316002)(68736007)(14454004)(81166006)(54906003)(110136005)(6246003)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0646;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aoeFQQ0OHIqwu+s+88pNC3tREpcDXGhn8fJcciuLZfU1C1waHH3EJVaoDV7d3XzwPdM7xvoyn3sM1+iXWiOFd/lBHeLmnXoZil1YrZ8Txdf90ospKm9cxGah0yxSJFYkruyPsSBwUYNV3c1lASmX75PjiYgGxAlo9rjWIXLDCLEjQzWkQuNHgcmxDeyU/ePTRwtsP4FliwbcXt1ZuwhpoakKzKSDuAaigUgiWlHHWOdQZssMvuXEJ1MufqKNbMxRJFuDBah5CVLf2qHdnSssIpHVU4IBtRB9rMx4AyYIJToIHlZLv28dDM5W+wMSaIih
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <07AD13D2CC617C46949C739C67A1FED7@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9b4c8e-54ba-4cd6-f6ff-08d66428c77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:06:03.0406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0646
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060617_344124_20D24E9B 
X-CRM114-Status: GOOD (  25.07  )
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
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Please ignore this one, the number of patches in cover letter is wrong: 0/9
should be 0/6.

Thank you,
Claudiu Beznea

On 17.12.2018 16:03, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> This series extends PWM framework with PWM modes.
> 
> The current patch series add the following PWM modes:
> - PWM mode normal
> - PWM mode complementary
> - PWM mode push-pull
> 
> In the following description PWMx_y refers to output y of PWM with ID x.
> 
> Normal mode - for PWM channels with one output; output waveforms looks like
> this:
>               __      __      __      __                                         
>     PWMx   __|  |____|  |____|  |____|  |__                                      
>              ^       ^       ^       ^                                           
> 
>     Where '^' specifies the beginning of a period.
> 
> Since PWMs with more than one output per channel could be used as one
> output PWM the normal mode is the default mode for all PWMs (if not specified
> otherwise).
> 
> Complementary mode - for PWM channels with two outputs; output waveforms
> for a PWM channel in complementary mode looks line this:
>               __      __      __      __                                         
>     PWMx_0 __|  |____|  |____|  |____|  |__                                      
>            __    ____    ____    ____    __                                      
>     PWMx_1   |__|    |__|    |__|    |__|                                        
>              ^       ^       ^       ^                                           
> 
>     Where '^' specifies the beginning of a period.
> 
> Push-pull mode - for PWM channels with two outputs; output waveforms for a
> PWM channel in push-pull mode with normal polarity looks like this:
>               __              __                                                  
>     PWMx_0 __|  |____________|  |__________                                       
>                       __              __                                          
>     PWMx_1 __________|  |____________|  |__                                       
>              ^       ^       ^       ^                                            
> 
>     If polarity is inversed:
>            __    ____________    __________                                       
>     PWMx_0   |__|            |__|                                                 
>            __________    ____________    __                                       
>     PWMx_1           |__|            |__|                                         
>              ^       ^       ^       ^                                            
> 
>     Where '^' specifies the beginning of a period.
>  
> The PWM working modes are per PWM channel registered as PWM's capabilities.
> The driver registers itself to PWM core a get_caps() function, in
> struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
> If this function is not registered in driver's probe, a default function
> will be used to retrieve PWM capabilities. Currently, the default
> capabilities includes only PWM normal mode.
> 
> PWM state has been updated to keep PWM mode. PWM mode could be configured
> via sysfs. pwm_apply_state() will do the preliminary validation for PWM mode
> to be applied.
> 
> In sysfs, user could get PWM modes by reading mode file of PWM device:
> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
> total 0
> -r--r--r-- 1 root root 4096 Oct 11 18:08 capture
> -rw-r--r-- 1 root root 4096 Oct 11 18:14 duty_cycle
> -rw-r--r-- 1 root root 4096 Oct 11 18:11 enable
> -rw-r--r-- 1 root root 4096 Oct 11 18:14 mode
> -rw-r--r-- 1 root root 4096 Oct 11 18:09 period
> -rw-r--r-- 1 root root 4096 Oct 11 18:14 polarity
> drwxr-xr-x 2 root root    0 Oct 11 18:08 power
> -rw-r--r-- 1 root root 4096 Oct 11 18:08 uevent
> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
> normal complementary [push-pull]
> 
> The mode enclosed in bracket is the currently active mode.
> 
> The mode could be set, via sysfs, by writing to mode file one of the modes
> displayed at read:
> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
> root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
> [normal] complementary push-pull 
> 
> The PWM push-pull mode could be usefull in applications like half bridge
> converters (see [1], page 2126).
> 
> This series also add PWM modes support for Atmel/Microchip SoCs.
> 
> Thank you,
> Claudiu Beznea
> 
> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> 
> Changes in v6:
> - get rid of DT changes;
> - get rid of get_default_caps member of struct pwm_chip;
> - remove struct pwm_chip argument of pwm_get_caps(); caps are retrieved
>   in the context of a PWM device and at this moment the chip should be valid;
>   also, get rid of chip->ops check in pwm_get_caps();
> - rename pwm_mode_get_valid() function to pwm_get_default_modebit();
> - rename mode member of struct pwm_caps to modes_msk;
> - rename pwm_mode_valid() function to pwm_supports_mode() and rename
>   its mode argument to modebit to emphasize what should be passed to it;
> - rename pwm_mode_desc() to pwm_get_mode_name() and avoid returning "invalid"
>   string; pwm_get_mode_name() is called only with a valid modebit;
> - rename mode member of struct pwm_state to modebit to emphasize that it stores
>   a bitmask;
> - use const arguments for pwm_get_default_modebit(), pwm_get_caps(),
>   pwm_supports_mode() and get_caps() member of struct pwm_ops;
> - change return type of pwm_ops::get_caps() to int;
> - rename PWMC_MODE() macro to PWM_MODE_BIT();
> - rename PWMC_MODE_<mode-name>_BIT enum members to PWM_MODE_<mode-name>;
> - remove patches 2/9, 3/9, 4/9 from previous version since they were related
>   to DT changes;
> - use PWMx_y naming in documentation to emphasize it is talked about output
>   y of PWM x;
> - use 1/3 duty factor in waveforms from documentation patches;
> - use '^' to emphasize the beginning of a new period in documentation patches.
> 
> Changes in v5:
> - solved kbuild errors by removing dummy functions for case where
>   CONFIG_PWM is not defined; adopted this approach since the removed
>   function are used only when CONFIG_PWM is defined (in PWM core
>   and few drivers from drivers/pwm/ directory)
> 
> Changes in v4:
> - removed changes related to pwm_config() as per maintainer proposals
> - added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
>   instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
>   pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
>   (patches 2, 3, 4 from this series)
> - renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
>   pwm-sun4i.c driver ('C' stands for capability)
> - removed pwm_caps_valid() function
> - renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
>   PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL
> 
> Changes in v3:
> - removed changes related to only one of_xlate function for all PWM drivers
> - switch to PWM capabilities per PWM channel nor per PWM chip
> - squash documentation and bindings patches as requeted by reviewer
> - introduced PWM_MODE(name) macro and used a bit enum for pwm modes
> - related to DT bindings, used flags cell also for PWM modes
> - updated of_xlate specific functions with "state->mode = mode;"
>   instructions to avoid pwm_apply_state() failures
> - use available modes for PWM channel in pwm_config() by first calling
>   pwm_get_caps() to get caps.modes
> - use loops through available modes in mode_store()/mode_show() and also in
>   of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
>   the addition of a new mode is independent of this code sections
> - use DTLI=1, DTHI=0 register settings to obtain push-pull mode waveforms
>   for Atmel/Microchip PWM controller.
> 
> Changes in v2:
> - remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
>   inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this will
>   make easy the addition of PWM mode support from DT
> - add PWM mode normal
> - register PWM modes as capabilities of PWM chips at driver probe and, in case
>   driver doesn't provide these capabilities use default ones
> - change the way PWM mode is pharsed via DT by using a new input for pwms
>   binding property
> 
> 
> Claudiu Beznea (9):
>   pwm: extend PWM framework with PWM modes
>   pwm: clps711x: populate PWM mode in of_xlate function
>   pwm: cros-ec: populate PWM mode in of_xlate function
>   pwm: pxa: populate PWM mode in of_xlate function
>   pwm: add PWM modes
>   pwm: atmel: add pwm capabilities
>   pwm: add push-pull mode support
>   pwm: add documentation for pwm push-pull mode
>   pwm: atmel: add push-pull mode support
> 
>  Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
>  Documentation/pwm.txt                         |  42 ++++++++-
>  drivers/pwm/core.c                            | 125 +++++++++++++++++++++++++-
>  drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-------
>  drivers/pwm/pwm-clps711x.c                    |  10 ++-
>  drivers/pwm/pwm-cros-ec.c                     |   1 +
>  drivers/pwm/pwm-pxa.c                         |   1 +
>  drivers/pwm/sysfs.c                           |  61 +++++++++++++
>  include/dt-bindings/pwm/pwm.h                 |   2 +
>  include/linux/pwm.h                           |  64 +++++++++++++
>  10 files changed, 395 insertions(+), 40 deletions(-)
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
