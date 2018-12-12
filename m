Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D346C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D000620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rkisU4Xj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="18WiEhMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zo4z3GsJ7J2yrztpgGhAeLrq7RNomTiq4B6nBMNa7LU=; b=rkisU4XjVGfXwm
	49qKDdzgB/CPjr6GvFJvdZt5XgEheUCsc2GhSWku2l0oXsDRJFPboPPf3GczdD9rLfHtEmLI3TkMp
	B5dvwhWzf7gRHvAn5hnoeERPnUSThMK1/qL00K5PESo9Aq3im9H3RnI5+3B3FcBBTkeHm9eQan77+
	/glkILNZlP9y/loDgcY+PcAkXzPHs+PJ+FPactFo5opee0LXbhNarOIyOLMJpQY2ow21RBwRRYA00
	6amkgsWjGtqNT5dPyJ3YPSH84flgvHxOxc7eWFvb0ahj2Qe++qjm3u9EqUwaSVO0Wjc6Qdvh+Ot+1
	ACaujfD4CYJXj/0jhiIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7Jo-0000lu-Tu; Wed, 12 Dec 2018 16:25:04 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7Jk-0000YT-GL
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:25:02 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="24131073"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 12 Dec 2018 09:24:44 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 09:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+px+o3B8B4ZTv1UO4yEPDQex4BGoHopDCClmWAPcbd8=;
 b=18WiEhMtpaGKjenQIDxfJQJlvw9mhqJusL4XDNgekeBgsM/eAsRQzOpm4SdKbQfA9yeZZ4cKHTNwgt9tGPCwmlAauwySri/4LnFSQ5bj964ifG7gj0OtUN0mcsC72AgUHbAhbhJZp1ip33pY4KB1cJkCzpef2zpIlpU4/GM+uf4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0725.namprd11.prod.outlook.com (10.163.112.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.25; Wed, 12 Dec 2018 16:24:41 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:24:41 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh@kernel.org>
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Topic: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Thread-Index: AQHUhkhcc/FQ+O4mvUqVP1+3dl3KuA==
Date: Wed, 12 Dec 2018 16:24:41 +0000
Message-ID: <8500c9f1-bfdf-d1ae-4a14-e42e1ee85585@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
 <20181211221324.GA14658@bogus>
 <442be9e4-621f-c668-c627-264084ef975a@microchip.com>
 <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
In-Reply-To: <CAL_JsqKk99GrQaqVyXSr_ZwQd_nnuMOWnz_0ehS1dHZoEmxDCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0044.eurprd05.prod.outlook.com
 (2603:10a6:800:60::30) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0725;
 6:/q1x1bP2ttW/nPh3mj7BRdLiLm/836Pder+GAZddvnggq7WyZOSpOH52CrxB+1aDIyJLUAbUHY878LkD2DYNkGZIbnLbfXgwlohyFfxUeP5V57RB7qyWpr43yHpmJ3SU6Xbc/7IRDie1WnpvEXfKcg6KNS3QmdXkZlmnCTTt2pVRxBPBf9UJGpJhXqPztnxn+RTcwy/sJjawKfrc2WUGQj317yvrroMjcFnwkKzPAwnoIozLisBQP4y1/4ghlPMxe6uRFe4E0n7yk+9XxiaT2qTFz4jrmpeLI9KlGlFm39200U6D7V1O/lR72+i5GLi5RvsTkEXj+OV1d+asmSfa87SAy7/0iAzIRD8r4NlsdluBM3Th323R2FINeaLXYFo/x5TQiZW88NM7JZm7uqA2vAYcCjEqoBI3FvTVRuzg9r3FKlUdC9iITMlv4V5qD0hd6J0Hx/9Sir0ZFb22u0eDhQ==;
 5:GRw5zPhImrL8bkysqx3w6GwZFpKKrcLqJIRuxqky6uR0gnuIVybbdraeFZ2ivCmquV2TyCynESJdoFUTc7Tota3OYginZXdIJ47Hyb0iQD3OazpU/tGWNRGttvBVBUhx+b7Rc0+qx6+NbdwInUG1geF2/roKGN+YDh3iAVBCWjA=;
 7:kNF/S/kK+45eFW283lu3htk+hCsGNggoGN0VuV0Y9oFqzWejNMfn7c1WXlUvibea2P952sqiggek0Vk1fOBzaZqFJBUaY4lTzvuao5L+QjlSmEt2hqdsmgNhjwlaaMQ6yxEcD+TnJhruHyeVsU9TPQ==
x-ms-office365-filtering-correlation-id: 12dd74cb-9a36-4618-71bb-08d6604e51a5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0725; 
x-ms-traffictypediagnostic: BY2PR11MB0725:
x-microsoft-antispam-prvs: <BY2PR11MB072549E0A0B87AEF64BB250187A70@BY2PR11MB0725.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(4982022)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0725; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0725; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8936002)(2906002)(10710500007)(31686004)(8676002)(2420400007)(6916009)(229853002)(81156014)(81166006)(93886005)(966005)(72206003)(14444005)(256004)(478600001)(71200400001)(71190400001)(476003)(97736004)(68736007)(25786009)(486006)(86362001)(31696002)(14454004)(6306002)(316002)(6116002)(3846002)(54906003)(11346002)(446003)(4326008)(53936002)(6512007)(15650500001)(66066001)(102836004)(106356001)(52116002)(99286004)(6436002)(36756003)(6506007)(53546011)(76176011)(386003)(7736002)(6246003)(6486002)(39060400002)(5660300001)(2616005)(186003)(105586002)(26005)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0725;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZRdAMlvhR1tkm4e4EQ86/LJXCcdII0zog5haHtv+L7oH8zsPvLMfLlyuqMNf7zFoqc20TZa7MUjdaCv46phvlM4774Udbj7IkgDnYwCirjgTn9DNMz9PxoEglQhLvUrY577qads/6TNOiJhUfVMAousiTRzarLDqrQsox/4Gy1pDgl4kNpuDjjKR3SUOZ2i/L5CRArnAtRCFypL6mSQxDPpy6zwbRlayu2wsg44+RiSxZosi4ADUcQfAeIHxee8I/wAT+lXKfGAOQb8ZIhKhbX5cWYWULKvnOfO8QDanFOuIPWzdN6IjmCNR+2MV7gfx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4819D54C0784CB46A0623F3A112B20DA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd74cb-9a36-4618-71bb-08d6604e51a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:24:41.5568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0725
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_082500_581257_1DB0F2DF 
X-CRM114-Status: GOOD (  17.20  )
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



On 12.12.2018 15:32, Rob Herring wrote:
> On Wed, Dec 12, 2018 at 3:13 AM <Claudiu.Beznea@microchip.com> wrote:
>>
>>
>>
>> On 12.12.2018 00:13, Rob Herring wrote:
>>> On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
>>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>>
>>>> Add documentation for regulator modes and suspend states.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
>>>>  1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>>> index ac955dea00d1..4017527619ab 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>>> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>>> @@ -15,11 +15,17 @@ Optional input supply properties:
>>>>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
>>>>
>>>>  Any standard regulator properties can be used to configure the single regulator.
>>>> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
>>>> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
>>>> +file.
>>>>
>>>>  The valid names for regulators are:
>>>>      REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
>>>>
>>>>  Example:
>>>> +
>>>> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
>>>
>>> This file belongs in this patch.
>>
>> I'm using the defines in this file also in driver. I was thinking that if I
>> would include this file in this patch the driver compilation would fail if
>> the patches would be accepted via different trees.
> 
> They won't be.

Thank you! I'll send a new version with the proposed change.

> 
>> Would you like me to have different defines in driver and this new header
>> or could happen that these patches to be included in the main tree via the
>> same tree (e.g. regulator tree)?
> 
> No need for different defines. The subsystem maintainer will take
> everything in this case.
> 
> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
