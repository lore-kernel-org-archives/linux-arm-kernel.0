Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB38C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:18:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B152147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F6o+zIYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XN8I9nO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B152147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fiuI4ely8sEYSH+y/hWSaov459NBGQdONXlKXuTZ8ac=; b=F6o+zIYP/MgJcO
	jHyrdUXgslYPXPkE5Tki6nIZqOB0YZzvqpgWJ//J4srqabAXy/9RMxgxevouHzndQe2MF8baSvNnb
	ZmjeCxVOAhi//bXmDPsF/hnuMDBl12Cfq8BZlfgJSmo+94zkn+VwvOpC+l2fMchfe9iohBdZYNL/u
	H17FyiOr4T48Yimay6H9lVk/e8j/CNe1cLoeNeOe+npOeCb1psnDOemxDKYtGlQmjK9nHck+9wAaw
	zLtQPKPqaZpNijskI/zpnyL10IcjLLoTxHf/ynFU2UiFRiJ5cbJABGPr9MMKxmp7rX9h5QHiEPkhB
	aYoDT+KGt97FokYQEeBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPtq-0001Ds-02; Wed, 20 Feb 2019 11:18:50 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPtm-0001Bb-VX
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:18:48 +0000
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; d="scan'208";a="26588681"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 20 Feb 2019 04:18:42 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 20 Feb 2019 04:18:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byvkFcre1KJiKRQ85NLojpGnoJaKGM3lbXgSPnbP1UA=;
 b=XN8I9nO+wRBPcgAzqDeaAf7idLMyYmZ0TFDQYC6vS22BhMXTv3dYOjdXDQ1Cj5+xI443cHHbl7uOKq1OgCyVnNJKSFBxW+RekGYHlUW6DaUs4P2mgk7sbnCFWZPfwn5EMIeRt5DsbL2ZI8/7rByt7hTXfrqOV5+f9oWoCNB+Exo=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:18:40 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 11:18:40 +0000
From: <Nicolas.Ferre@microchip.com>
To: <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Topic: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Index: AQHUyQ4DTxM0lGKi0EWSxBvx5w6KNw==
Date: Wed, 20 Feb 2019 11:18:40 +0000
Message-ID: <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a62901f-6c66-4dfa-8c43-08d697252a82
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1791; 
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNzkxOzIzOko0cFNNQkV6Z3hpSFpEbHZEbmowTEQ2c3p4?=
 =?utf-8?B?YkNrZENhSTJqNkVPYXllRTlVbXNtM1hkT0JOUVhXcjFTMFpkYTFhbmR3RFI1?=
 =?utf-8?B?MEsxeFFVR2RmY29ZV3h2ZUcwL1MvNnhOQ2lvMThhajk2aEhuNk1xZFM4MUZI?=
 =?utf-8?B?ZkxUY0VPcXZWL2RsN0JpMmcyblMvVEt2bnRwUkQ5OHZ1NlVzcEliMmtOS1d3?=
 =?utf-8?B?MktEQ1U4NHg5a1lTbE5ndmxTZXBsU29uSDd2UllWU2NVWUcxbWR5WWRtNkJW?=
 =?utf-8?B?WEh0MGRHWXJySW94MC9wQ3BXTlQ4aW5Nd0w4YWhSSGVCaTlCUWRqTDljcElX?=
 =?utf-8?B?YS9QdVJzNlJvNS9nNjd0TWliTVU2ak5WcEErN3FBblFXNVdJZFNLYm5mSytG?=
 =?utf-8?B?Q1JuYncxelBLZlhlcVFHQ0huazZxTkdXQ2VlbVpQYWZaUXArbC82dHBqa1lF?=
 =?utf-8?B?Qm1qL1g1YTNPV0t4Rmhia0tXRXBvNGZ1MWRyRGJrZGp4Z2dKd0s0anpGeFpo?=
 =?utf-8?B?d0RRTXF3bGZFUkt1aWlPcGc1LzAzRnlBdWlNSTNQZnNXTmVGWCtFT0FoNTRU?=
 =?utf-8?B?TnJDOWZRbHJ6TkZZbTVlN0dlNGNyWmVXdVhLUlJOcFdFVXZpUlZ4YXl1aTRm?=
 =?utf-8?B?QWpZNkhnUEkxTlFuVCtDOG9kbEVXcG5WQ3JTMUdtNmFiN1AyTnkxZWNyV1RP?=
 =?utf-8?B?VVl4blk5a0Y2OUF6M1JBRTFrNlBPc241M2pYOXJUeDd4SldmUG9wa2dEUmRJ?=
 =?utf-8?B?YjR5Z2ZuVzVXOExXekdhVnhpQkEzWWlsZjh3UHQ1UG9malROVXNCSVgxUEJ6?=
 =?utf-8?B?MjRJN2NqN256MzJ4ckx1V2V4VHNEQTRWOVIvQUY0aFZPYzMxMWsyRDlUMGpF?=
 =?utf-8?B?cW5LcnBPVjJoVUdnMk1mWXRreUo3NzR0SWdDNWhzTlRIMjlJRHZpZnRSUFFa?=
 =?utf-8?B?K3YwQU1SZWlLQkRVRkdXK1oxU1NvaFV6TWJHN3c5SFZ2YmNwVTVldnpmbXYx?=
 =?utf-8?B?NGRrQ0x5d3BGN01oYjd4a1RIc1BXdTVEVUVwYnBCNmxBRmg5amo2NEdpS0sr?=
 =?utf-8?B?dGdkL08vNlZqcGJ5a0w4MDh4MzlzYjcraUJmNWp5WUhKdEEzSVJJdFYweCtS?=
 =?utf-8?B?ZVpqRS9qcWhLS2ZiZE84VXl6bkthdmQwc3U4eVBZd29aNUJYSXBLT3hoRTA0?=
 =?utf-8?B?ak9TdGNDR3ZiVzc0THlJNmhyOEFzbzFDVWFmbFNNb0hhT1c1V0xFWnc0NWRo?=
 =?utf-8?B?ME93b2RNbUtzVVROekk2TnRPdmdnMlAwUDhqQ0FnL0ROMStUbzQ1VFNsS1pz?=
 =?utf-8?B?ajIzMmN3Q3BVWVlCMzVFS2o3Q0dVWXRvOERSREZGSWcyNXpYTGVPTktWOVpT?=
 =?utf-8?B?MTBlVVRUR1BrVUZQcUVEWE5BbzMwM0wrK0lSVWEwOFNEVktxdTgvTUZEbEND?=
 =?utf-8?B?S0lhY0Vza2NDNndJaGxwT0JZdEZJYk5rWFpOZVhUajBvMTJSN2lmR3NQM0Ra?=
 =?utf-8?B?QS84ZmNCVXNlUDRjbnF1eERRT0ZOS0hYcHhnVVRjUmczN05QUnM5Z01DdFMr?=
 =?utf-8?B?RVE3K0wzYjZoUGI2V2Q1MzVIaTg5eTA0MWVYTnUyVmtGb1dwaUdvU1gzSnJX?=
 =?utf-8?B?TkNJaFRTaFp5TDlrSVY2QURESUlkeWFwWVpRbG1GNTdXaHorNEloMlpmMzNP?=
 =?utf-8?B?MlFaZUJSZldpdEpTUG5xZEhpaERLbFZKajFKNUs4V2sxd2pnWDZrWFdIS2dU?=
 =?utf-8?B?cm5aakgyZ25VZUFMRm5SUT09?=
x-microsoft-antispam-prvs: <MWHPR11MB1791F8A2BBF85FC644A09C51E07D0@MWHPR11MB1791.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(68736007)(54906003)(305945005)(4326008)(486006)(7736002)(229853002)(478600001)(72206003)(71200400001)(71190400001)(110136005)(2616005)(5660300002)(316002)(25786009)(6486002)(14454004)(476003)(446003)(66066001)(11346002)(6116002)(105586002)(3846002)(6506007)(8676002)(106356001)(6436002)(102836004)(81156014)(8936002)(386003)(53546011)(31686004)(26005)(256004)(52116002)(36756003)(76176011)(6512007)(186003)(86362001)(31696002)(97736004)(99286004)(53936002)(6246003)(2906002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1791;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qNQSH0SV4+Xd/wxC3ixOQbqEuPDIn35XhAQ63XmJzCbzIYFzTFuzHZvytR/xPa8Ad5mDCR43HGH7zNLDEu9uKzSdEJz84plNYMfWUArNugmnZ9woWT0C+30KRxx/LNiX32vooMgxltSqYDstJi0KgAg++OPjSidECqZ6r0N+SbE1ay+tzMdmUoN7vJ9UMcxGwkKflCkAOOBPjPtonnEfXR/oGun0EA3YcJRlL4wxLTMmJsxXUXTvj0CguWXHFG/IvuPKbu0upmWWxDW37vVfxyNvMpTQuasaNAapPQnmU+f6ofcvw9wCfAPb1PE/4RJXIK/Bvr/DcgKmASn4DY+2AcDV8oSKzdUfpw7adztWqfqiVqoTxjLCgvtpMXqoScaBv6cWP8dXXrdWbRbU09D84WqsqEGFVjJZd2k+qxGZi1Q=
Content-ID: <CFF07D1261CF2D439D477F49CC1ADBD1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a62901f-6c66-4dfa-8c43-08d697252a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:18:38.5922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_031847_045809_FD99BAB4 
X-CRM114-Status: GOOD (  17.69  )
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
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19/02/2019 at 17:51, Alexandre Belloni wrote:
> nck() looks at the last id in an array and unfortunately,
> at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
> number of peripheral clocks is 1 instead of a maximum of 31.
> 
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v4.20+

It would be nice to queue it as a fix the soonest, as it impacts 5.0 but 
not 4.20 due to a switch from one DT binding to another (read: a real 
regression)... But I know it's a bit late in the cycle...

Regards,
   Nicolas

> ---
>   drivers/clk/at91/at91sam9x5.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 2fe225a697df..d37e7ed9eb90 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>   		return;
>   
>   	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
> -					   nck(at91sam9x5_systemck),
> -					   nck(at91sam9x35_periphck), 0);
> +					   nck(at91sam9x5_systemck), 31, 0);
>   	if (!at91sam9x5_pmc)
>   		return;
>   
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
