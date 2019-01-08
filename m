Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B096FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:07:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741A0206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WM6NdJx9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Kvwi95Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A0206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LdIfZ3lE6ka/1R4qCMlP98jke78b+Ra057KJRyYzkuY=; b=WM6NdJx9qhoSA6
	qyVHJDKVchFcWBOtsnkAouC7UrZdSTuI5c5YfFOJftV2XS7HVcgaLcn3F6d0kyf7Ji0CD6HpOln27
	4qXQp3oLL/B/cno9nOe+94EPB/8Du5oZtZEY7FRGkdk41BegVWAgu8qq6lGW2oAimUmRZxGWg8K2w
	HSa7tQAsWuhrxmxGDqVyuckCNyrygn3I4e8xor4ldi7AKaKsCbvL47K5GQzQ2pPGr0iic1Gr8sSMC
	cNAH+dl2oo6+7YtgY9YER4brr8d+qYRB9yen0LefsbtK+H5Jp4HzQnVlToew3WloO+g6ShffeflIF
	T5g6NM7Ij2ah8652AFRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs2p-0006km-CL; Tue, 08 Jan 2019 14:07:51 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs2l-0006jO-Hi
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:07:49 +0000
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; d="scan'208";a="25057062"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 08 Jan 2019 07:07:43 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 8 Jan 2019 07:07:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skzF4QF0/3HriWd90RlrEVTek3ke+hpiqhZbrbbnVAU=;
 b=Kvwi95Sf0OR2ZuDP+1W53RiJUEu7mSvK4kJOdM58zKTOU8yD3t2lrrNnXfMfXg3K7jzmO+xoo+5p12gTSuy0O7uq5rRGu9FwJfvh37UynvgRgNft6yhALxODot8OkTxJTDCdMtLo1mLIyTi5RE2z9/0JSwsc26GmoSDUr0PSKGA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1520.namprd11.prod.outlook.com (10.172.54.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 14:07:35 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 14:07:35 +0000
From: <Claudiu.Beznea@microchip.com>
To: <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
Thread-Topic: [PATCH v2 0/3] add support for power off check in suspend
Thread-Index: AQHUp0DMK00T01NVNECI4VrUGS1926WlQQqAgAAnaoA=
Date: Tue, 8 Jan 2019 14:07:35 +0000
Message-ID: <c749ad04-1f95-1f8d-7fd8-93b228ace10c@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1520;
 6:62bc7W7NFwbeXDWy7ug+zpYNwyFQClqosW/PcXfk17zBOJXtvqAjdzKN5i953lTZQxRpZImCLYbLVxiYI7v0l8RsVPYivPUucXRmfZV99esYh6qweJuXveIqbDQHmK6QBQ54jj85g4g8XKJrYh4HN+Gcpsd146lHkaxO+peJp+xSgw1hRByxM800TzNonATQaz4KeqffvcXMLiaBClbazZGLKw6uwlrmHyyBduBEFIOQU4Irj1vEigKNniExGt/r5J2V9vB4RtWj7unGKcKKO1vT3fiJIUPnxo3Z+R+mjAr9CYSn5iOPUQkmadBJ6KjQnXzsArx2eIweywFw4YneDDQE8NzSIAawWOCxw0hEC6nWi0Gk/LGxK+1F55MczyNzWRR+1xZg4dciQoSBn0ORHBo/ouyo9aepdEkc5MO+zN7S/nlZGSsaoVLk2umuVKqQ3u/wABzWSjZ+ct66HpgdBA==;
 5:eTFmgVLBTSD2TosuzwojJCyopak1fYM/dNkn+NjswjxiTFqyuXyWe2MuGDJdhUJ7IhEkq7BN4+mykJixTDFZFY5WnG2ifuKYwDULTtTG8LbVgFSLkTY+hQwmc9OjleX4EJB2XRXLHn9JXsS83pFPFhirA/Mj3uL9HMvMtwuP5CweBcott5LrW+M+HnZ5UKiNwwPiqsVZi6RDART5DdhYBQ==;
 7:i5YArOSGZEak7++NJFlVZcy+axcH3dSikZ0+CUTFZ9YiUOy72lqu75FQQGouyZM0C1Vg/SUdhEU3aZOTs5Hd1YIcwAzVufzUIBTVYpUFUj6OVVRczgLSjWImABxX2vNvrKNzJIc921R6infLgElcZg==
x-ms-office365-filtering-correlation-id: 2bea0500-a0b3-41a8-3253-08d67572a3cb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1520; 
x-ms-traffictypediagnostic: MWHPR11MB1520:
x-microsoft-antispam-prvs: <MWHPR11MB15200B5AFD24090641B87B55878A0@MWHPR11MB1520.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(305945005)(186003)(316002)(7736002)(7416002)(105586002)(99286004)(106356001)(26005)(229853002)(6306002)(36756003)(86362001)(31686004)(6916009)(53936002)(102836004)(66066001)(31696002)(54906003)(6512007)(8936002)(2420400007)(15650500001)(97736004)(14444005)(256004)(966005)(39060400002)(25786009)(6116002)(8676002)(3846002)(72206003)(386003)(6506007)(53546011)(476003)(2616005)(478600001)(11346002)(2906002)(10710500007)(6246003)(14454004)(52116002)(4326008)(76176011)(71190400001)(71200400001)(68736007)(446003)(6486002)(5660300001)(81156014)(81166006)(6436002)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1520;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RFaFT7/7i0GrTF1N81/v+npyrm48zP4tRhaOjG56cXA8MCeiHjoFLjSlQ7smuxg5iy6F7CjbORonO9KTrALYfw/QdoBoWxodRwGxr3dQF+7i3QKNtJWEmDoxhS1lnSaD6XAc5xCi16XEXvFOjt6sG7YuBgOWbzX9FC/k2ckztg0gyTddQ03oJg36mX5SrupqzA+Wc16LVwl40q01WY6v3skx/8JOLwuUhsz+NCixUNYs2Izlbct9/5TgVvvLHJ9DhCvChWey8GnCipfjd7JXUKHPGxrplviJ1wDh4/aXGf50gefQhv+kUJDCmdvTljoB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <AABC9D277420DB4F8F8565D6707197FD@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea0500-a0b3-41a8-3253-08d67572a3cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 14:07:35.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1520
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060747_678386_F709D1AE 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: len.brown@intel.com, alexandre.belloni@bootlin.com,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 broonie@kernel.org, pavel@ucw.cz, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 08.01.2019 13:46, Rafael J. Wysocki wrote:
> On Tue, Jan 8, 2019 at 11:56 AM <Claudiu.Beznea@microchip.com> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Hi,
>>
>> AT91 platforms support a power saving mode where SoC's power is cut off (we call
>> it backup mode). The resume is done with the help of bootloaders.
> 
> But still the contents of RAM are preserved?

Yes, the RAM is kept alive, in self-refresh (forgot to mention).
Besides this, there is the so called backup area which contains RTC
shutdown controller, RC oscillator which remains powered. The rest is off.

> 
> That would require at least the memory controller to be under power AFAICS.

Yes, this is powered by a different regulator.

> 
>> To be able to
>> suspend/resume Linux to/from this mode all the drivers suspend/resume callbacks
>> should save/restore the content of all the active registers. We have 2 problems
>> we are trying to solve:
>> - some of these drivers are shared with other non Microchip SoCs (e.g. macb
>>   driver) and we don't want to disturbe other users of corresponding IPs with
>>   all the register save/restore operations;
>> - the suspend/resume time for the rest of the power saving mode we are using
>>   could be improved if we would know in drivers the suspend mode the platform
>>   is switched to.
>>
>> A solution that would have been solve our problems was proposed in [1] but in
>> the end it wasn't accepted. It ended up with the introduction of
>> pm_suspend_target_state variable that could be used along with the changes in
>> this series.
>>
>> While the discussion of [1] progressed it has been proposed (in [2]) to
>> implement a function that would tell if the platform's power would be cut off
>> at the end of the suspend procedure.
>>
>> The patches in this series does as follows:
>> 1/3 - add a new member to platform_suspend_ops that will tell if platform's
>>       power will be cut off at the end of the suspend procedure; drivers could
>>       use it via platform_off_in_suspend()
> 
> I would rather avoid doing this if possible.

Having this mechanism as part of platform_suspend_ops? Or this mechanism at
all?
Could you give me some hints on how would you prefer to do it, if any?

Thank you,
Claudiu Beznea

> 
> Thanks,
> Rafael
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
