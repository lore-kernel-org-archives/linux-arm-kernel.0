Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C49C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2A7217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNDTMUZc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BXC5GFwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2A7217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8LT/1wSmB8DzY139/b9ov163RL/TO8Af9tur3Hyblo=; b=kNDTMUZcZ3dvIF
	t91sz5jladixEpOIrVcM7aDD0vr4INb9J8fDzHSK75xYxYglFDkcExKn0EASKOn+WDPxzpXCNWfBX
	PiOOPi5goCmdDJAu4UcW7nakrp7ResdhlhLLo7vG/tuVebsq0/hpmOwsmmaHkZtduOoEuvXGbEtWn
	f8Jv2ynSCTo0idrb7lSfmrqniUXmEKKZEVFsHfGO8oIxwB1LfGYmGrDHJoQeKfepB6t7R5kZwOp/L
	5V8lTCC/4FtSJyjeB1SA2jsFg6NXdykxguyHPi9hjlJT86yn6BaVeARj4MYDVgBPh4oj0UQNa/mh5
	B9v3YYLf47g62WJvGWNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLaU-0001RH-BN; Wed, 23 Jan 2019 16:41:14 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLaQ-0001QD-Q2
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:41:12 +0000
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; d="scan'208";a="26793349"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 23 Jan 2019 09:41:06 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 23 Jan 2019 09:41:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MTR2WYTFYsBPfcjchEwMOVrEzXMuntxUh0hA599uck=;
 b=BXC5GFwCNY9OlasKPqN0gVFzRd6eczSSIoOg1BQEJph5rTPcqiRyMajwFEk/xvXyd2cvJc4mHi1IO4u09BFqhKn+fLlhPrFT9qw/nkrhu9w3NK6vdJfTIhnDFR5LDbm6wuCl9u6ckgHN/5O1TKvRvKBQ2KpK2OnlI5xovF1NeMs=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.173.16.10) by
 CY4PR11MB1367.namprd11.prod.outlook.com (10.173.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 16:41:05 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::2cb0:2ec7:14d7:c503%10]) with mapi id 15.20.1537.031; Wed, 23 Jan
 2019 16:41:05 +0000
From: <Codrin.Ciubotariu@microchip.com>
To: <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>
Subject: Re: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Thread-Topic: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a
 channel as in use
Thread-Index: AQHUszlq09QahfETH0Of1PoFTE5waKW9DnmA
Date: Wed, 23 Jan 2019 16:41:05 +0000
Message-ID: <42d281c0-e44e-0b59-825d-3fcca8f523d5@microchip.com>
References: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:2d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR11MB1367;
 6:lkgQ+dM21Z6kCZkVSoKGpZAqW1jySwnSQPwiFZ2u7Qu7lPIvGMwI0LYCqv7XX/Y+hsL66y7MAFiRM25fiq2/6GSWLnlRl4m+UjwY4l/Kx+h8xEEWlkJ1Gu6MichnwXISAp7dQeM/7WiUsmYOvUwZ+QgYxpOvNOa+7uUtdWUjepsK1LjSM2JmPFt0peOMd/I9/OE7JyTubXdlKmnBigN5+//qpb4JUE8xRASdfdj02Eh7HfBBhNg7yEge+Ld53QdJqD6Dc0ksl+0KOZjKMBuWFm8YyJni/j8ku+Xf8rv6IKhVblzGqWVKudj5pl5C9TEyff9Btqa7EVp0msL/xi0C1jhBi+MZT3gdTWm/lHk4g8H66lPv9y6inSXEWV7go4ynzicZ6s+QttODZy4VQyrqUvQl8HrUWSJhyswBGO3wg9EAdKU5O1/A4nJwcy6oj4SvwKLgjTPrrFKr3tbxOiIReA==;
 5:5qS4V9/PInYff9YF8yKyTByFXfJjnNepfn6YG8g5zMDIbgTghPj2Ns6htOPW1qHlM/chsBqFpDxTtTHsvQsifoYT2vpxNvBJ3PFeLznmlLcF5/vGaLNJDw48UbM0GeToMWHolRLyNsRMrSkrcjJbUOeLMcVSHKLHRLZo1iJ1O05gEbM04TkxXtj7rO7DZeC367JjwdHuGWgrttehl5LGvw==;
 7:CTGcQZPk77tUQaoNIjcaODo59RwwISqO8wd1FgMCxJfb3hwfyx1LIzBZAk9fPHy6dQta4c7PBt8FxUMR/Fd/kKTBTXnpnhWNNA0bq2ohqgyudg6YPkombYMH3xB4PD0yAVJqDWXk9c/govyd40/TYw==
x-ms-office365-filtering-correlation-id: 5ac1f5d3-0d8c-48e6-ea38-08d681519175
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1367; 
x-ms-traffictypediagnostic: CY4PR11MB1367:
x-microsoft-antispam-prvs: <CY4PR11MB136793861931BAC998A535E5E7990@CY4PR11MB1367.namprd11.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(199004)(478600001)(2616005)(256004)(52116002)(486006)(99286004)(31686004)(106356001)(105586002)(81156014)(4326008)(25786009)(2501003)(72206003)(476003)(76176011)(14444005)(26005)(6436002)(8676002)(81166006)(186003)(386003)(66066001)(102836004)(53546011)(6506007)(229853002)(6486002)(316002)(446003)(110136005)(11346002)(54906003)(68736007)(6512007)(8936002)(71190400001)(7736002)(2906002)(97736004)(305945005)(71200400001)(6246003)(3846002)(36756003)(6116002)(86362001)(53936002)(31696002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1367;
 H:CY4PR11MB1256.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rLUJF4v9vOdN18RAH0rqmvh+W1MwQQxtlY7KH/sRi+Qpz6KAOyIzPOzakF8xAfOcC5ewl0CSX02yZKs83Iln0CPjCpwjtaeC1l+MyZbdR41Y6yxaBCwzeQp0/D+SHcU+nu2KNE4JrMTHyWYzYpja+iVJtOLZSmEaDgfB+8dQpBHppiavm7LIZ7v+OTl5TpEPdLZY6NxFfEFhQYfcBIWzAXyM+a/jSRgbYBjvyN3vwTfCW3/2ipn449ZyuxMsUmf0yvNb2CEBY9K/yLS3DAKklRdorPv8ECIOYpni/Uc5wZ3KHncpGl+7Fazbt6qWSV+X2jXsVMmeJv77VCq+Tlx17FPZLzI7UG8nEsvX5V5aG9kAeIA6Z5ISBJ/ygJ8xNV0Zx/tKgLrs0hrFkh9bocw3tntm+GHSPxMxgZCernE5y14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4C8B610914F9D145A1ECA19267A84FF4@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac1f5d3-0d8c-48e6-ea38-08d681519175
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 16:41:04.0301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1367
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_084110_982911_482DECCE 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23.01.2019 18:33, Codrin Ciubotariu - M19940 wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> atchan->status variable is used to store two different information:
>   - pass channel interrupts status from interrupt handler to tasklet;
>   - channel information like whether it is cyclic or paused;
> 
> This causes a bug when device_terminate_all() is called,
> (AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End
> of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of
> atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when
> a new descriptor for a cyclic transfer is created, the driver reports
> the channel as in use:
> 
> if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
> 	dev_err(chan2dev(chan), "channel currently used\n");
> 	return NULL;
> }
> 
> This patch fixes the bug by adding a different struct member to keep
> the interrupts status separated from the channel status bits.
> 
> Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---

Forgot to add:

Changes in v2:
  - changed commit message;

If you need v3 for this let me know.

Best regards,
Codrin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
