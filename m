Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8744C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69A320849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmik93YN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MgyC5aat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69A320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cLOkhoXPNBkcMosvYUuK7ctj/ldXAzqkmZbwGWl/PXI=; b=cmik93YNzgHlsk
	FXCONNtPY9SwQcoTgAPoEIfWpvj2v8D1ZRJ02Gg+d9Cqls8RFuWpVQILbBxnqWW9tTZb+vsngQOd/
	o5GqK2tLD92fKC6zffcvj4V1dLl86x8SBVrg4QqFWsvf/h+pDwtB2d9PFcJ5g5CM44ZjWif29F6tu
	rIyELKpgLfHQcSFQ5pqP1wFeJ7K9E/e/R3SLh+cYl3x+NhP6hDiutthD0+Fi/cf/HJfwRdhCmS7ck
	h/gLBzkRyPoTAsDHpy2D33xH1L6kdjIbreMJ8OcIv9X/Xcve6BuMUg4oa2p3D+1L+vyXRZd633NKG
	lC4yNszExftVAyCMgkww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0Zz-0001Xf-C7; Wed, 12 Dec 2018 09:13:19 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0Zv-0001Um-Vv
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:13:17 +0000
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; d="scan'208";a="22174918"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 02:13:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 12 Dec 2018 02:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+edqSbu+dMOh6QCwOK+gZSGJC4EO10P11AJs/G3ZPY=;
 b=MgyC5aatH/GROuCOOMjjKa6JIjYustBdeflCfgLp56zz5moMyX48XNt5v+i/WO9/RFePtUGBGi/LtnG1Zft0q4Xr1u12t9bj8hUygrVnqp+hyJartn5GFKTkV25IExaon9SPUKT9nJlSuB83pKVMYQcxefbsnkHgPnheepxOKxs=
Received: from BLUPR11MB0740.namprd11.prod.outlook.com (10.163.216.18) by
 BLUPR11MB0657.namprd11.prod.outlook.com (10.163.118.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 09:12:59 +0000
Received: from BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::39b0:53ba:f0d2:91ba]) by BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::39b0:53ba:f0d2:91ba%4]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 09:12:59 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh@kernel.org>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Topic: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUhkhcc/FQ+O4mvUqVP1+3dl3KuKV6MOYAgAC4PgA=
Date: Wed, 12 Dec 2018 09:12:58 +0000
Message-ID: <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus>
In-Reply-To: <20181211221324.GA14658@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0225.eurprd07.prod.outlook.com
 (2603:10a6:802:58::28) To BLUPR11MB0740.namprd11.prod.outlook.com
 (2a01:111:e400:594c::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BLUPR11MB0657;
 6:GJjiEhZj1p5915hbIYs8dyYE/aX6nlGzRD8gItIVXX7OnFMlg6ba6QbYJ0DGTxwWhYorgmBGIGasy8d0mLT5iWxQ4Bp0Wmx+mU1iUpVA5SK72pptTsO3IA8agOzujlQPZGuWySIzXoRj0dVT20TYCadY07rqHS6cIv1ZJAXsEvdMDs0D1TGqGIb3h2vHHpwmvfG/tdFMQr20zh/RZKfw63pR6KYg+UolSI8dJ4EkX/jCyp+hGY4zpTAKyqgmzPRl3u5ovwCmGn8FA8WiiWUg2fp9TIPuF5o5zBxRTvH4aVhushVXsTff+wu6jp66K594L0Z1anYGJ1B/pmVI687b2ZN5AFTEevXL3fFmWiJIezWtWb3+TGv9VwVyl7s5BV5qXy27J56kdzpllmLqZNldZ9orZiI0r6/p6cbVIdqRAQXoQlCH+KHhGzvXEuWVycqKEeqAP1d4mg42B1SiaRZdVQ==;
 5:sqtEqV3JMKGbTp88Goupt2MgbAaubm1nrQAWZPoJOaVk7LTomhQgOoKYqdQG5p1qU+DgSg1c9jkePonWw7tX/EJq4dowrkYXS27c3VpofiMZJgD1EIHhOz7P5JwYkESPUFuPFBBfUeY94WZe0uwbAlGWqHR7nem7UZVYAORrBK4=;
 7:g+HZu+yNc51nRNRBrc+jV2QOiowErKUkwntMbH5fkjvAmcZcQd0EDm3oKT11Hbbphmbrkp/iDNgrWhi66+AfplaOes+3MSspucAk0NnaMWbfD5EeZ3dXorwpHeNQMw84fJ2Pz4E9n0rsjyP9RnxXhA==
x-ms-office365-filtering-correlation-id: ee73f532-21a7-4e45-2f2b-08d66012025b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BLUPR11MB0657; 
x-ms-traffictypediagnostic: BLUPR11MB0657:
x-microsoft-antispam-prvs: <BLUPR11MB0657BF3E3BEE69EC1F549E7287A70@BLUPR11MB0657.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BLUPR11MB0657; BCL:0; PCL:0; RULEID:; SRVR:BLUPR11MB0657; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(8936002)(2906002)(5660300001)(316002)(3846002)(229853002)(14454004)(486006)(81156014)(8676002)(81166006)(99286004)(446003)(256004)(11346002)(6916009)(6486002)(14444005)(476003)(15650500001)(6436002)(2616005)(36756003)(72206003)(186003)(6246003)(53936002)(31696002)(105586002)(6512007)(7736002)(86362001)(97736004)(102836004)(25786009)(386003)(6506007)(4326008)(106356001)(53546011)(26005)(68736007)(478600001)(31686004)(6116002)(71190400001)(71200400001)(39060400002)(66066001)(305945005)(76176011)(54906003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BLUPR11MB0657;
 H:BLUPR11MB0740.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DTGtX45Nj2F/Y1IYqjxucncNUZ05VI53OI2u3NbTSjibCnUMltjEGoJZAj8/xOE1Ewm1nYvf5KQELDOqom3zYJQshT2pU6NVjxnCmCoxTT1vuKEZtz/m2KdC8DBs5mJW2pXBj1bsKklx4pFCMkXUXPOCX7RCpiMdrYogClV0ApRWRwrf91Y3TVF7q1IXh5nrdo47b67ZYCM5GRVrVN/r7HJKewOl+agnjJMeC9RTo8sjVdLHtaXvetbzix7cMZGQvEPyr4YrlvHfq7YIMOHnt1VjDjuXJ0rMShQ2YVWfMXx1neRhephcS/BlFyyirusL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <DE533817C65E354FB65DEFCEAD0647DE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee73f532-21a7-4e45-2f2b-08d66012025b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:12:58.8144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0657
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_011316_079185_237D7CC7 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12.12.2018 00:13, Rob Herring wrote:
> On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add documentation for regulator modes and suspend states.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>> index ac955dea00d1..4017527619ab 100644
>> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>> @@ -15,11 +15,17 @@ Optional input supply properties:
>>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
>>  
>>  Any standard regulator properties can be used to configure the single regulator.
>> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
>> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
>> +file.
>>  
>>  The valid names for regulators are:
>>  	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
>>  
>>  Example:
>> +
>> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
> 
> This file belongs in this patch.

I'm using the defines in this file also in driver. I was thinking that if I
would include this file in this patch the driver compilation would fail if
the patches would be accepted via different trees.

Would you like me to have different defines in driver and this new header
or could happen that these patches to be included in the main tree via the
same tree (e.g. regulator tree)?

Please, let me know what do you think.

Thank you,
Claudiu Beznea

> 
>> +
>>  	pmic@5b {
>>  		compatible = "active-semi,act8945a";
>>  		reg = <0x5b>;
>> @@ -32,6 +38,18 @@ Example:
>>  				regulator-min-microvolt = <1350000>;
>>  				regulator-max-microvolt = <1350000>;
>>  				regulator-always-on;
>> +
>> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
>> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
>> +
>> +				regulator-state-mem {
>> +					regulator-on-in-suspend;
>> +					regulator-suspend-min-microvolt=<1400000>;
>> +					regulator-suspend-max-microvolt=<1400000>;
>> +					regulator-changeable-in-suspend;
>> +					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
>> +				};
>>  			};
>>  
>>  			vdd_1v2_reg: REG_DCDC2 {
>> @@ -39,6 +57,14 @@ Example:
>>  				regulator-min-microvolt = <1100000>;
>>  				regulator-max-microvolt = <1300000>;
>>  				regulator-always-on;
>> +
>> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
>> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>>  			};
>>  
>>  			vdd_3v3_reg: REG_DCDC3 {
>> @@ -53,6 +79,14 @@ Example:
>>  				regulator-min-microvolt = <2500000>;
>>  				regulator-max-microvolt = <2500000>;
>>  				regulator-always-on;
>> +
>> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
>> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
>> +
>> +				regulator-state-mem {
>> +					regulator-off-in-suspend;
>> +				};
>>  			};
>>  
>>  			vdd_3v3_lp_reg: REG_LDO2 {
>> -- 
>> 2.7.4
>>
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
