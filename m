Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCDCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4959E20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QgyvT0my";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vvfOqsW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4959E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QK4ygnZN09ZPsEtY/jZ7biNr04F6DGQvtpClLFdyRc0=; b=QgyvT0myz6WE22
	lXfDaHj0N8/dqYz6TigUZh+cRJvTmRrkMjAZ09Ath32hL8Jl18bCEgc8z4qxTR1N4ldQA+1yynrtA
	j7Fxvqw5k+TFk+DEQAhiBb2YYuHcbSabtmqmsxKswxuGJYle/aA+Gc4GKrQFunOm1TvKeOZ77gr66
	SgVWvkAn26WgOHRPVp44bfgmSSv9cab2ItkFosQKgXA0XVhO7n1fIR9dELEoKveoYQ+cZk2YaNklE
	t+dA4W0ZxY3EcKWbxSSRVzyzExOeiNP452BlIafWmpnlqGZaAcx/L8ZKXUotcaw+GWSbb5tmOxkDB
	J6dzWIEwghhpxcKsTgMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhoE-0006Cy-4I; Thu, 10 Jan 2019 21:24:14 +0000
Received: from mail-vi1eur04on072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::72a]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhoA-0006CW-AF
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TD4LGJ/dfugD2myBCJZqQf9LuECulpvIz4/7bwRZok=;
 b=vvfOqsW0GA3zDWknq356HXG71ADAyLYqCCHEkadhQ1gGCt70uOSzgjl4uA5xQhMCUI1xLtcgROmoY4KJkQMYdZAhYZlFFC/RFFd4w5x6w2l69hf+XcG62NQSTTUFTL3JsoX+CC6M8JTc92jf0pfNvwphMPAI2SGHrYX9ESeAoik=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4391.eurprd02.prod.outlook.com (20.177.190.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 21:24:02 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 21:24:02 +0000
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKWoxn6AgAA9LwA=
Date: Thu, 10 Jan 2019 21:24:02 +0000
Message-ID: <dae0e92e-e91f-6208-987b-a214583b45a1@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::23)
 To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB4391;
 6:lQ1Jj99WFLrDaKum4h2WrWEw8JuyjneHWsldb2tpZ3xH5g/dGCerwxlilRIricIqoYF54Xn2KUracQMPQGjhUUsl6FhPtyrtiN5NlmyKnhZ5VcrU+tgeAU7adIJKqL7pAapxw6NapnLvXYi+PTD7t2hk5SIgOolv7nJ0nywbHV6FHaRXBkA6ECW03nua3D9+GrPFJXUeinff3aiwHeITeFKNC7hFElbiLIOuWtvuRYAPqipJslrf5DkJ8TZvWoDXwgHDdu1NVpbXh4EXHfyHMn5g2/mydFchPkh0uFP1Zkec4waNhTVm6S2Iv61LPRu/ZX6d3g63kpxdk7HTxCxNFjvgdY48ZXh47qxUUdhL5hs9j1O20FmBbelKZ2O37fRBfnpf6exHCK3ZVY5JwpbczNllnYxlb9x+Fz6q0vyvqGcryF0WEhred/cxiK8CbxYM3FtiZBYlblLBZhQxqEcCnw==;
 5:dKJaeUddhad43t/CKFZcfc5Mlu+BconkhNumzM7k79YaWoyo7uJ8SGYmp/elaDtbIfqc3Y0VkKR8QymtnB/mroCW0BAqlyFLp4ZpL7Qr66+OQ8OCxOC5xVfvAKml7uYHwRqqsKcSEhv/53V3ca/n3DowNql4uP/zraAfsu4kopSrQoU+wVZsN69MrnRoRxw902fUv/IvcAW4abOowmav9g==;
 7:qD4Tbh1QSOvl6rJh5ctsSnNmrsrphwyfzIxPGPY/uTOtjlDb8jGlCpZ8CJ2izsh+8wcrwbQv8pjo9Dql2wxdt/Sj7d7KCmqApC5o4OdxnNyxFMEbsAF8VRqtHn3nEmQOg/GhKDCqxQEEz8jdtTidYQ==
x-ms-office365-filtering-correlation-id: 1a0953b5-9d22-4f02-c8a9-08d67741f15c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4391; 
x-ms-traffictypediagnostic: AM6PR02MB4391:
x-microsoft-antispam-prvs: <AM6PR02MB439197C935C22413A7BFB6ADBC840@AM6PR02MB4391.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4391; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4391; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(39830400003)(346002)(52314003)(189003)(199004)(53546011)(6506007)(68736007)(66066001)(65826007)(99286004)(229853002)(81166006)(5660300001)(26005)(8676002)(386003)(186003)(65956001)(106356001)(7736002)(102836004)(305945005)(476003)(446003)(11346002)(2616005)(2906002)(76176011)(486006)(316002)(105586002)(65806001)(58126008)(81156014)(8936002)(31686004)(54906003)(52116002)(4326008)(6116002)(25786009)(6436002)(3846002)(6512007)(64126003)(6246003)(6916009)(86362001)(74482002)(31696002)(71190400001)(256004)(36756003)(71200400001)(14454004)(508600001)(6486002)(97736004)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4391;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TivzDkEmEM8nIfsh84NULAIgrgSFjdP25uF0G+06bLBsIRPVbMVvrgH6JHclYkqAzsitimAbmS2nBXUzFt8hs2zYEfBgwOo+7Y4bS6LvACl5UxfxmaWc+tQWqEkzr3j90qOOleB89JDgPr/qzcsa2GxtbMKUDIlCHb2hnfU7esjeDI4jBE44Ri+5bXI8PPq3mP+CpsdR8qWWWgu7LOkRodUHUF1KDiNZg1VIwCizrPPvdSxkWVxT97LLVBX5V2hEY/l6ECmBStD2NHmXC/AxSbefrasvde5UgZf7Zq4AXOk3S0aePrPNezpecNZyGiuW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <8C616B4FE4CACD448F68AA381DF5801D@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0953b5-9d22-4f02-c8a9-08d67741f15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 21:24:02.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4391
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_132410_562412_EE536899 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-10 18:45, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 15:10:28 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> I found an unfortunate issue while recoding plane handling to use
>> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
>> which is not correct. I simply fixed it (patch 1/4), but maybe that
>> will cause regressions for unsuspecting users who simply assumed
>> that the clockwise rotation was correct? I don't know what to do
>> about that? Adding an option to get the old broken behavior seems
>> useless, wouldn't it be just as easy to just fix whatever app to
>> rotate the other way instead of adding an option somewhere?
> 
> Hm, rotation support has been added before the standard rotation
> property was created, and at that time I assumed rotation was clockwise
> (which apparently was an unwise choice). Anyway, I don't have a
> solution for this problem, so I'll let Nicolas decide if it's
> acceptable to change the rotation behavior.

Speaking of unwise, fbcon rotation is clockwise and drm rotation
is counterclockwise. 'nuff said.

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
