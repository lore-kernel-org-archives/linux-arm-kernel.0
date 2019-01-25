Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E541C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56555218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZVy5W9cH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VjZj+YO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56555218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51rdLi6RE0Ln9IvKltdMTjNlI75dkwPle4ifNk96IxA=; b=ZVy5W9cHvFX3Ts
	PYvTCnMHFMYpLhQvk6ISrC3JtXvCIUBsv50ysIUQ0EZIqstFPFXk5yuOA8aXrW13TLxMCVwBo6CsV
	BZ9EVbCuZgOrYQSWD7evCZhw7SReYKIpsufmPpBO7xAxVkLjsfl6xpXbjrgfo75Uq6CuBvWZ9G0Ug
	CJu3NU6Dei+9uNnTZKXQtErjN4mUovherZBdBZMVaJpr/NTddJ1+4GCSDN1KyvbTpsUWfeLHPrToX
	CATdqldMLoS8La/U+Jheq7Zzd11uQ9lT9n4p44WwAN3kZBY74jp1HpxZNlQonDTAbyP9KOl1AdG5T
	9afQXIYH07DIShM4SNQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxbJ-0004H3-6X; Fri, 25 Jan 2019 09:16:37 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxbG-0004Ga-IA
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:16:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,520,1539673200"; d="scan'208";a="26870514"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 25 Jan 2019 02:16:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 25 Jan 2019 02:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WZUCY6Di03hKUMa4tqTUJNblkWiVMkuXsp5A2JfJ1I=;
 b=VjZj+YO5EqFQRYghVfN6IiLLIJjDVqn2A2HrXyc1ycPwRl0nzVUYdxlWhAwTv8qqk0ZRMb2jFKvFfR/2v3YZS3EMXohUD5KDTiZNiCyOm9xZJN0NbHLrM7ywg41VmtRsBXvZflkS6Z901jFEUZnV6fcs25wCRa0plSbR3BJqoUU=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 09:16:30 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 09:16:30 +0000
From: <Nicolas.Ferre@microchip.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Thread-Topic: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Thread-Index: AQHUtI6ooIMeCW+w8ka7mi+cbTeyLA==
Date: Fri, 25 Jan 2019 09:16:30 +0000
Message-ID: <2f8d3a0b-fa06-2157-db4b-fc0d6e8d9016@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
In-Reply-To: <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1791;
 6:neDNziDTvCPXDCDXehdeL0pA7zFyS6SBmxCSL6Oi6v1k/pftUDHCOiZVRz/L3KESTNdIViPU8Mk9Gc06pXq+62f8icluiW2xibmy++aS/1GTS6gCxtcMCkncH8SdynFwBAgjSngXEN12+bH/dLGuoJoG/KhIYxnsozvOcoWJIBjEH/X/buysZDhZEcqUPxPwnDc2lrljV9jY9R0FTaJ+B7s0q1QCR13VTFVDkrd56fP04FPobxp6g20w48LfgsqW5n+YdZSYtQJgwuiLYR/C+LWQWzcJhCZl6nO2P+h/fUIQThcXSnn3orMKLBXLF9J0UySRf+JrE03/++fHtE3ahk6y7DqBfMEkwZfx6L2qLczR7s1BHVz2NfgWbQ4QlZ9Mhkihph0uoy6nKF/hdH3ilwptlPWUZlHTUY7vSlFS8my/pr23KnjF6PoJvrXpu3zfXL6rnRhUQnZp7yEqdW70MQ==;
 5:rpN70vRuxX+L63oQSFemCRbbPjC/0KLCmRGN7ShdZH1bxfcL7/ocXQOIhMleIIU6w3NWmNMLvRIZaRHxcShKzpHcMtUMkYCFT2m5/GOBw4QxKFM8gYYV/u58eJeHcfiVcrDQvCszOKuikbSTZWxzhkpuelbBgNGgJDvQxzI9mKDAqdOeqkFciekUIOsTqISTfQlzvpwfywe9cf1JB5o4iQ==;
 7:TOh+CD1lh25u8BJY66/RslCnpeuZLjIkLzoykv6hpKCo+FIC8H4a7+AIwxPYJ5u/RCuDgLecgT75x9uOR7ezq5/63gPPQJCGJL7oMJ+DH0+I2D22vFjMhbxkSnTw2XBwcN+CrrYvcastCrozbhIRbQ==
x-ms-office365-filtering-correlation-id: 0e8005fe-23ab-4233-359f-08d682a5cac8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1791; 
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-microsoft-antispam-prvs: <MWHPR11MB17914F8A82C3F18E037C4DEEE09B0@MWHPR11MB1791.namprd11.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(7416002)(186003)(2906002)(52116002)(31696002)(105586002)(106356001)(25786009)(486006)(76176011)(11346002)(446003)(97736004)(2616005)(476003)(2501003)(256004)(478600001)(6506007)(53546011)(6512007)(7736002)(6116002)(3846002)(102836004)(305945005)(386003)(8676002)(8936002)(6436002)(72206003)(26005)(6486002)(229853002)(6246003)(66066001)(71190400001)(71200400001)(81166006)(81156014)(53936002)(14454004)(316002)(110136005)(86362001)(54906003)(99286004)(31686004)(68736007)(36756003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1791;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B96gw18J/wncDGPKVpK3DK3p1yoikqaS8WqbUGqNwxAG84ywyuQzMiTQS+cwAQc8NXEIGTBygyvOwyV3CMQltmE5SLsX9Utwu4+D5H+KDBhfBGZpaDdsvtPTZpFD0abVNbKZ0J8j7VN3mUlJtmkXHezQ22JT7vqObbsjODy1CQ2C0BTNp8t+09W7U4GxNNFpLqVhbwGePzxLkjJ5LSjREML8T+WQ1pcM6pEb3xdEoPXfhU+06u0tERjtwK68egVhgs/wImmmRmbRECTze1Zlfs2idelFsXb3nRPZsgU2QFzZNhW3gMvPWmutNc/uuNK9qGNdWscCKv9MQvvWHq28pTZiWT65vzRvDebwZhNlPjskp/Bv7eOHy+BYFec0tYfU/I9lb2Q8EJTcXZ/YfD3dVawYdVYBkzM81RAUjMnTMHk=
Content-ID: <E4A375AA93587C48B64E20C9290C4942@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8005fe-23ab-4233-359f-08d682a5cac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 09:16:27.6118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_011634_768179_29614E6D 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org, stern@rowland.harvard.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

On 16/01/2019 at 10:57, Nicolas Ferre wrote:
> Add a new compatibility string for this product. It's using
> at91sam9260-macb layout but has a newer hardware revision: it's safer
> to use its own string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I'm thinking of pushing this patch with the others of the series through 
arm-soc tree. Can I have your "Acked-by" tag then?

Best regards,
   Nicolas


> ---
>   drivers/net/ethernet/cadence/macb_main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 66cc7927061a..a0889ef107a1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3941,6 +3941,7 @@ static const struct of_device_id macb_dt_ids[] = {
>   	{ .compatible = "cdns,np4-macb", .data = &np4_config },
>   	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
>   	{ .compatible = "cdns,gem", .data = &pc302gem_config },
> +	{ .compatible = "cdns,sam9x60-macb", .data = &at91sam9260_config },
>   	{ .compatible = "atmel,sama5d2-gem", .data = &sama5d2_config },
>   	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
>   	{ .compatible = "atmel,sama5d3-macb", .data = &sama5d3macb_config },
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
