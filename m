Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F91C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:01:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2D7217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V33sGn3O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2tK5aifd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2D7217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0v4HN43nUi1auZ4E9n8v4cfs6K4qrN60oiPEiQ+T60U=; b=V33sGn3Ody/kAu
	LkoQ5dnz31AqCR25/iTZKbyOgBGVTr16oNeSsqLwuS1+AuCy6Agw+gqTBdeHQsDLnYAZRnHVCgJd0
	xLsb0kX+mn3GgYuZvMZRc38XMulKvSFIFIa8XG9IJIA4FbZtfyA9qwQrBqnPWrfWKYB2H8sVeMFm1
	xLptc+ESnmN3544pOAvfJ1/Pp0fVXcS8zxxyEYgHahQ92s7cAxw29y7u+18TjGNfg4jitfs44oIJh
	oa64NZHquMNuystmSFG5z3ZJD7ZLzQ88epDJhQl7lmR/0By1rt5Ir1y3MaYhHQ6fifBKIBC/EG8im
	EGC6RzTeE4Jc8GeSL0Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvggJ-000667-KJ; Mon, 18 Feb 2019 11:01:51 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvggG-00065g-Fq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:01:49 +0000
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; d="scan'208";a="24028652"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 18 Feb 2019 04:01:47 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 04:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Ex/ux9ucCNTnVpiRf+sIeftwCc+r0cZAaWUZq4y9c=;
 b=2tK5aifdHINQOX7DT2g5VQD8mH5CcxI3ueGJBrFZ3s9kvHSnD3VqrLG3aCOLDiWbk+sljssfMRHi6BJ+Um/jjq9fexAHsRLS10Sd578zDWdsEmSc6eKhsGycBACxdHtEK1H2pr3aAjMFSAk2fTro7ePUQlDAXOsl/0SzibUfStk=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1279.namprd11.prod.outlook.com (10.169.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 11:01:45 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 11:01:45 +0000
From: <Nicolas.Ferre@microchip.com>
To: <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUx3lWirob8lh2MUWvI8JBjCQ6WQ==
Date: Mon, 18 Feb 2019 11:01:45 +0000
Message-ID: <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::28) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9adb09a7-7fbd-4e85-948c-08d6959078ca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1279; 
x-ms-traffictypediagnostic: MWHPR11MB1279:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxMjc5OzIzOlR4Qi8yMzZZTG5ZUSsvNTV1RGR0eVA5NXNX?=
 =?utf-8?B?OXNRaDBLN2owTEF6Zy9qcm9zc3RpNnFaMFluVjhqYTlmZVpDMmFURzBVdG56?=
 =?utf-8?B?WE9ndUFLSXRla05PNkp2YmZ2SDU5Z0V4SEN3dUxqWGhEejVuN05MbEs2djA1?=
 =?utf-8?B?dkVFRExWbmtzdWhpdkdDM0p3dUt0N2JGVFl3YlRsTnlRSHBlQVV2RkRwZU1D?=
 =?utf-8?B?S2lwUXZHc2RFY2Nhb0VHczNtSVBxTzBZOFRvOXcrSjFxMmN3bWJ0NlRwK2Z3?=
 =?utf-8?B?RHQ3U1NnVlo4QVB4MkhYSENhRktpNm8vSmNBaTNDQ28rYTZiZ2pLRUZ3Lyty?=
 =?utf-8?B?SHBqMHU1QUxYVlpMWWJoeC9rS2xVMGFCZjJha0tXTWduckFFVFNueEtKZ3dM?=
 =?utf-8?B?SGVYOXFnYlBVL0EwSncwQmluejhQcWtLaHkvZTNaa3kwK3UvTHk2dU9ROWZv?=
 =?utf-8?B?eFNCYmZxbjlqYXBieDNlN0VQVWFrN2QyT1VBZmZDdUFEbUdIbnJueTVxd2lY?=
 =?utf-8?B?ZkZwemI0WjNOMldKR252eklwTHVkOGM1NVp6citESjFLTlZDZ1JZendhMS9E?=
 =?utf-8?B?Z25RV1NpMy9zd1RMQUZwV1dQcWtoYWxnMTdkdmRmdHNaL0VPUzZwdXJnOVo0?=
 =?utf-8?B?UGRla3piUXFBKzNoazBqYjNYM0hMSEkvZFFQUGo1Z0FvVFJzRXhJZng5SDJm?=
 =?utf-8?B?STZZNDJxak9mZS9vbVlKSDZsRnM4SlpvM0w2aVViQlJJUXNXWnluRG1hTzNw?=
 =?utf-8?B?UUdsa1U5WTZMMkNTT0JjTklKWXJKOFl6UCttTjJNWnhYZjhaaU1BZEVmaG82?=
 =?utf-8?B?NWVXeENCNHhFNlZuREdvdE5vLzZUbG9zVnpLSlhmT0YzZzZEVi8vbmdsK2xx?=
 =?utf-8?B?a1Q1QVFIOVhNT2R4WUFvRlRGUDBxUUVVVmlvMjNmdVc4V0hucDd1RFhmR0xC?=
 =?utf-8?B?bXdFY3J6K0cvQzhqMUlqcGdOd3lmT0tQQmpIU1MwRjJmQTdVSjd4RDNjZkNw?=
 =?utf-8?B?Rjk4MnNtbW02T0xFK0lIR29OQkNYMU1GNEtkVFliaEhPb2t6dGZqTnZienhW?=
 =?utf-8?B?Mmw5M1hZOG8xVFJXVHBySUZpOGorNnlDM3RMUk1US0MvRUlLbm5hSXVOZytD?=
 =?utf-8?B?WitaenFSekFZMUFybG1ZMDZ4ODk3c3NPUldwR2lNMm9CQjM3Y2lzNGJvV0pO?=
 =?utf-8?B?dFhtL1pTNlp4NlFveFZ6eEl6WUZ4REpyd0l4WklmZS9BdUJQbEhCM3dvNXpX?=
 =?utf-8?B?YUFSd05mV1psdlV4dUlzNm8yb21NRlVpOW5IRXdvVXNkbnlSd3F4QjVnU3Zn?=
 =?utf-8?B?ZWpiNHdwRXZGTGV3UmhaZkYwU1dnSWpCT2Q3MzZmRmhuRjVuZXNTRnpIamEz?=
 =?utf-8?B?bUlraUdXR2lNaHBlRnd5bzRTWitmM1J6TENIYVZ0UHR2NVpwekVYZnQrVHFU?=
 =?utf-8?B?Q0VRMHcxaXY4bHcyWml2OElteCs3Zm1JTVdNdlBpclB2N1pyT01xMU5NUldj?=
 =?utf-8?B?WVVTWVJHVklha3R2dVZ3ODFOcmwwaFhMY3IzRDQwUytXNXVNd1pIQmhEUDdT?=
 =?utf-8?B?M1JXZjVDd21YSU9aeFNvaDFvbjA2dnVwbnN0elBvcVFuQ1NaTURkSEpiNDRN?=
 =?utf-8?B?UFhFNldWSFhabDUwNDFVenY1Q2xGMXJKeGNlTzdhYUxseXdEZ0wxQnlqMXow?=
 =?utf-8?B?UlhrM20xS0ZUQUNpTWw5WVcxd25yTzByYVlCdGRiVWZRYVYwdlZVd3pwVi9K?=
 =?utf-8?B?ajROTTM2UmlienBwcjZNeVRPR0xJWjJLWlNDbTlkMjM0MENDdlJjWnlqQ2R3?=
 =?utf-8?Q?zA9AjR5kckB0a?=
x-microsoft-antispam-prvs: <MWHPR11MB1279675979B2977415E5D67AE0630@MWHPR11MB1279.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(14454004)(229853002)(6436002)(6486002)(186003)(478600001)(26005)(8936002)(81156014)(486006)(8676002)(72206003)(446003)(476003)(36756003)(2616005)(71190400001)(305945005)(5660300002)(81166006)(71200400001)(66066001)(256004)(4326008)(7736002)(11346002)(6246003)(25786009)(14444005)(3846002)(6116002)(2906002)(52116002)(99286004)(76176011)(97736004)(102836004)(316002)(53546011)(386003)(6506007)(53936002)(54906003)(68736007)(2501003)(105586002)(110136005)(6512007)(106356001)(86362001)(31696002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1279;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mu0fJezj0Scqyi6ajany7+65lRvfsy/VplNpjSpRH4dBnaPVkinAdgrRJpVkpLw2cZn5NpsZHSVY4/P/t5YRel8oD8eCguwCwwerWobnqxqMPHAIWpjVRvnxFRLdU8AhZTkg0fea9SSl6o1795bp8PKBgC/d1enGBa8geGLARnJzM3gOjTKLTa5S6iW7FSoH54e/++xSe3fsmCkLCw7Ou7SvfyfkthTSvituyucVjo4oXHhAY1s3eAFih9ZewvB1sKmhdNX+tFc9v63zMi+9v1qm9X8zBlPphfCuuFDO19zY0nqPgq/8LTV2dMDXAeE2VXwIn4d+/LzCIANRPEDU5vM4efQAONfLNnrHzjVGt+NwAwKEcFfzkhuRpqi2AsFSD7DsxeIDImL0Z1RlGz0kIrcxqQ+c7CnnXx71Ov1aq+w=
Content-ID: <9FB745B54B46AC43AE8FC8B39A8C0EB2@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adb09a7-7fbd-4e85-948c-08d6959078ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 11:01:43.0616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1279
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_030148_562264_E6B2DCFB 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 at 12:24, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for SAM9X60 shutdown controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 14f319f694b7..9711052c5800 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
>   1) shdwc node
>   
>   required properties:
> -- compatible: should be "atmel,sama5d2-shdwc".
> +- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
>   - reg: should contain registers location and length
>   - clocks: phandle to input clock.
>   - #address-cells: should be one. The cell is the wake-up input index.
> @@ -95,6 +95,10 @@ optional properties:
>     microseconds. It's usually a board-related property.
>   - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>   
> +optional properties for microchip,sam9x60-shdwc:

is it for sam9x60 only or is the optional property "debounce-delay-us" 
applicable to this SoC?

> +- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
> +- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.

Well, I would make clear that the only additional optional property is 
"atmel,wakeup-rtt-timer" while the 2 other optional properties still 
apply...


>   The node contains child nodes for each wake-up input that the platform uses.
>   
>   2) input nodes
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
