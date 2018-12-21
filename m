Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:18:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAC5218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PMjECeqz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mMEhpCUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAC5218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qf5k/Y2OAnCnsCT8uRrwZ9J/LkeFfuvn3GBFGc6wkac=; b=PMjECeqzXamvtc
	Y3fO/6q4pNodkDCwUWvRN6jc+eDyuJDos4wvT0iJCRlYQ9y+8WUQNUBexWfFtTgL6QUkdhfp0PftQ
	MwaP/gri6niQ7oYygSgulpItF5YAoUw1hlbUiZ54qBa5PhjU4ZNkmi0jgmgFRQpHaHMwaS+t+kbUl
	oUrUV5PiVnOsd7NKxWUYgJeHDFMcEYfMCIE17fu0+X9bNfOfBruGhuJJA/QJUomTj6IMhitD6ShA/
	PiyFAIyQ9uYJPD4BqXooN3Br9A+Nf21/Oq9Kd52zhp1RcYySfbO8mSK1dDGntSa2YhBtKSZ5EyE6O
	7t4m6zijIZeH7rwI6gxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIop-0003nc-0x; Fri, 21 Dec 2018 11:18:15 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIog-0003gZ-Cd
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:18:08 +0000
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; d="scan'208";a="24670754"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 21 Dec 2018 04:17:53 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 21 Dec 2018 04:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4mHf4dk0HFn93tmLI3qQjKNl7LUo4XHeDUOOUy6kaQ=;
 b=mMEhpCUNrfxS5ut4BZYGW9pM3+yDQ6NUwh3V4appaF4/VV0mqR6Utfb36ktbKmWKijP1QsyWpj6ALtFhmfIyKTIUboHAGvnrYdbzMW3eiVb8Ke3Q9yGv7UJhuJl9NFYF2/0s/+07gZv24WfHrMC3RYKZUa+gy9rhcEv9fYeS7LA=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1406.namprd11.prod.outlook.com (10.169.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Fri, 21 Dec 2018 11:17:50 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 11:17:50 +0000
From: <Nicolas.Ferre@microchip.com>
To: <axel.lin@ingics.com>, <broonie@kernel.org>
Subject: Re: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq
Thread-Topic: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around
 mcp16502_suspend/resume_noirq
Thread-Index: AQHUmR7P+RCUftXxtk+md7qXXbwhgQ==
Date: Fri, 21 Dec 2018 11:17:50 +0000
Message-ID: <3751abc0-1377-2a66-3fa9-7ceee93b7aab@microchip.com>
References: <20181220131413.21922-1-axel.lin@ingics.com>
In-Reply-To: <20181220131413.21922-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::16) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1406;
 6:lOJJyAd+pLtl8gc1EDGGUpzGP5LdHcjxE5WkYbKs+6mpwojNratm3qXtDzoEhcK8VvmPUmslByvm+nlhwm6Doz8a1GcTYy53rmzPKW3gqPaYbAxfCOiI6W57uC9YCPehEAnHwYjQtSSHVrlYnYCd4UpI2JER7RO2+hbLlASKpGK/Hp/5JJ5IH7mGTfFMrVbqXfibMBxDgA1PdZHMWbnwwJjGXy7R8u86OYmWOG0nVNhdGXocOEsyoJdSSWLjSZg96HrPEkUnuxnt0IexkqSuk2RdvB2+33g//yS7zbllNjV0cd5pX29+bAVWvD/ZZIfVwPNCtljxjybLyOx8G6TbKoAhzolXX3NmXrzr68TP9S24FI7P+XN+4VwYqUGKifoHJCFbDI/IH3lUuikafQEBnc5xdLmz7Ms1iJ3EuZKDed5BK+zCNdNc0k27MF0vOwlkscgE2zW/eIcPd+Lv17Z92w==;
 5:6n5LvdY8MrXcQ8qv5CikVhhO/GO5fn90DK3ERlsomzWrqnIqu1Rmz5IaoVDXm+DueqIGLeeEY9AuCIlemSFu39r19/64Jx5RcnIR/5UgbbQOiSN2B+3PZrKGTISp50hk11ylHKCyzaAZ5PK9nrCMpZYNMUNE7hVj97wwEOq42i8=;
 7:OhcO4nBCs4Wg8XhVLb11DqU1tkGYZbquPIXNrrRDEZtMpDJJdX8Cta4W0Q24MSQqzYpbXFvLnzgRwmmZzsROx9nlg6HR5C1uxmF+VUTd6gkzrGlxeBinkWrS8cXEcY63L7RQzG88Z3T596YhUIGKlA==
x-ms-office365-filtering-correlation-id: 09ff3ace-44c8-4268-74ef-08d66735f169
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1406; 
x-ms-traffictypediagnostic: MWHPR11MB1406:
x-microsoft-antispam-prvs: <MWHPR11MB14066CFD3BC3DBAB7D21BF38E0B80@MWHPR11MB1406.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1406; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1406; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(31696002)(305945005)(14454004)(86362001)(25786009)(106356001)(72206003)(6436002)(6246003)(8936002)(81156014)(8676002)(81166006)(478600001)(36756003)(71200400001)(71190400001)(6486002)(97736004)(2906002)(105586002)(6512007)(107886003)(186003)(3846002)(6116002)(53546011)(6506007)(386003)(229853002)(102836004)(76176011)(54906003)(5660300001)(4326008)(446003)(26005)(2616005)(53936002)(11346002)(476003)(486006)(316002)(66066001)(256004)(14444005)(52116002)(99286004)(31686004)(39060400002)(7736002)(68736007)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1406;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCJaI2zlQDv4CBLrbvXlsRZ6Uig+t7WxgRb0IC0pRkKunUd6KYhe/HIqy9Z8LEeYh2/6pcJtYJ86eadqbcjzkbKjI1RCYZHbMEAsLPXLwQB45rvtr11cwJpB7btNiCKamXn37Qac+BbsT5Qbbc+jdz/j6JLjqI24hYCY182r3qUD7q9G30fvuEt5sSFF+B5fUvQwBs4W7h1Z8Nrz5zZwMzjYHsoCkOP7KoSxUlsUPVq4JfJu76n1Nv53dhmQHhidOMkRTRj4bU/wRFDWKvU3c87qhEZZvtC92JJ1C3DOflcCjggtyQOUFao/WsOP2p7B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <28CAA01342A08E48998ED200641EEF62@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff3ace-44c8-4268-74ef-08d66735f169
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 11:17:50.6036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1406
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_031806_534507_55159732 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: Andrei.Stefanescu@microchip.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 20/12/2018 at 14:14, Axel Lin wrote:
> mcp16502_suspend/resume_noirq is only used by SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> when CONFIG_PM_SLEEP is defined.
> So use #ifdef CONFIG_PM_SLEEP instead CONFIG_SUSPEND guard.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I'm not against this patch and don't know the habits about this... one 
remark below...


> ---
> This patch replaces below patch I sent today.
> regulator: mcp16502: Fix build error when !CONFIG_SUSPEND && CONFIG_PM_SLEEP
> Changed the subject line because after commit 308144ce8e51 ("regulator: mcp16502: code cleanup")
> it's not related to build error now.
> 
>   drivers/regulator/mcp16502.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
> index 809a664733a4..cb11fb206899 100644
> --- a/drivers/regulator/mcp16502.c
> +++ b/drivers/regulator/mcp16502.c
> @@ -497,7 +497,7 @@ static int mcp16502_probe(struct i2c_client *client,
>   	return 0;
>   }
>   
> -#ifdef CONFIG_SUSPEND
> +#ifdef CONFIG_PM_SLEEP

Why not use CONFIG_PM just like ...

>   static int mcp16502_suspend_noirq(struct device *dev)
>   {
>   	struct i2c_client *client = to_i2c_client(dev);
> @@ -517,10 +517,7 @@ static int mcp16502_resume_noirq(struct device *dev)
>   
>   	return 0;
>   }
> -#else /* !CONFIG_SUSPEND */
> -#define mcp16502_suspend_noirq NULL
> -#define mcp16502_resume_noirq NULL
> -#endif /* !CONFIG_SUSPEND */
> +#endif
>   
>   #ifdef CONFIG_PM

... here.... or unify both directives to "CONFIG_PM_SLEEP" ?


Otherwise, no problem in adding my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

(as Andrei is not with Microchip anymore).


>   static const struct dev_pm_ops mcp16502_pm_ops = {
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
