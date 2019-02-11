Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58834C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F86217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8I2hJsA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pjQpaM7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F86217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SK+vjabbTIr9bsFSstcVsUcuCDWuk3l3s9hRtbIlh4=; b=b8I2hJsAwxva5F
	bcl3N3Z/9p+P4avkO8XlXft2VsOpCS52mJL2Bs416fB0+3hj98wA71H+lKs+7UifLMODmmxNplohH
	WQ5C02NfCOn9VMUtwj0IcZyKjmWCv6zm6w3ax5yuV48C4mqsQfbewycQ7r6n+iKHSWwrnCDTyVcdF
	vA8SL8Nlv8HuOSRsEOnK92EejsvsX3GJfy0hJ6zGUCrZ4MCn5kJk7byLSZgYqNg/x7ax/BmLXtApt
	nClWEgVV5QT7YyUmc94oLdBD29KQnBZQPQwEsGvXTlrd9A3yamkHKUabCwK2XaxbIU4tLHr0f1kEy
	MaHiyRjb/uJHzauOEpfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHyD-0004n1-6A; Mon, 11 Feb 2019 20:14:25 +0000
Received: from mail-eopbgr710096.outbound.protection.outlook.com
 ([40.107.71.96] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHy9-0004mK-4s
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAEEoVkWHdQgY1VQuIsvnL88i3Nn/XcgMpUgUU8uMqE=;
 b=pjQpaM7sCB6GhG8byMTg57Ek4ZZN5vIbn3HB2L4YgazzJKQHUo8YfcTCATPUD+gPk3xJxfTeQ+6/9/oa9MwN2HvKii2OC1dKsq9XvOxts7zcXx77TstrWC468MoYQKnqAKfjrqiEXm1sQ7ryYrzLcAyyKBu/fjrhIKOmaiasRKM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 20:14:17 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:14:17 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAA==
Date: Mon, 11 Feb 2019 20:14:16 +0000
Message-ID: <1549916056.3075.102.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
In-Reply-To: <20190211012305.GA21496@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 235fccf4-02a4-4a0c-f4ca-08d6905d7fed
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3771; 
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3771;
 20:HeoXgP7yPyS4GOoOaDPtZLulNiq/NIr8wPrt1FyE1pmrYd4oFuxSqFpcgi0CzeAVdt53jeqtKh2gLpV4mlRbehwJxvnAqxVmQgW8VEwsbhv3fhFEwYr/5DKrxHTGbsgsSSQ7BfsKydMr8V1Abab+wR0aUn8uclYjQ1RnqWeGRrg=
x-microsoft-antispam-prvs: <MWHPR0601MB3771D144FDAEB46D47295D92D3640@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(39850400004)(346002)(376002)(189003)(199004)(316002)(6246003)(102836004)(53936002)(66066001)(6486002)(229853002)(86362001)(7416002)(6116002)(2351001)(25786009)(26005)(6506007)(97736004)(7736002)(5640700003)(305945005)(3846002)(103116003)(106356001)(105586002)(6436002)(6512007)(4326008)(11346002)(446003)(2501003)(14454004)(8676002)(2906002)(2616005)(476003)(99286004)(6916009)(256004)(1730700003)(71200400001)(81156014)(36756003)(54906003)(68736007)(486006)(8936002)(478600001)(76176011)(186003)(93886005)(81166006)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3771;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MQnxeZU/m+YrtG81ZoffGKfGXEJ7pXRtyB4sdcaM+lDDYHiXRY1M4/vRkHVOqSecYBo/WMv1yXGh/0/cZhyblbeRkL/gCqdPJo5vxpo8gEszJUI9JxsEHUBi2dsawesvTOXyPsMdtnDGKRDOjWd0qTeOXLmnX3cUeAxd6vxxwXSfIBU5h5/recEIv2YY/QhyvvHU1XCH0jG6Syl0tdVEVOyYEkuVpieAbFqe88kcfffU33PlkECTTLTMTxG1O4o+X7woVnqll0uEAt16iAYbfTj05ycjDK4nO/HnNt7G/q5rzdlD+9SEOsdVkiQFMp2lZmSoh4bCKLkWa3TLv4Sck9n/1IzFTSSiHNKPGbXUcDDmQBGbv8jbZkcC9PRZukc5FP/nhrRBPZ0udi4gQgNR0c49Tgp30bD6szkaeswDP0M=
Content-ID: <C8C20BCD9316084191ED9ADADA43B63E@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235fccf4-02a4-4a0c-f4ca-08d6905d7fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:14:17.0422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_121421_237018_23E5438D 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-11 at 09:23 +0800, Shawn Guo wrote:
> On Thu, Feb 07, 2019 at 09:00:44PM +0000, Trent Piepho wrote:
> > On Mon, 2019-01-07 at 14:22 +0100, Stefan Agner wrote:
> > > Allow to use DMA for SPI by adding the appropriate DMA properites
> > > to the ecspi nodes.
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > 
> > There's an interesting thing that happens when DMA is used.  The SPI
> > clock changes.  Instead of cycling continuously for the entire
> > transfer, it instead clocks out 8 bits, then pauses for 4 bit times,
> > then the next byte, etc.  So it's a net of about 50% slower.  The pause
> > between bytes scales with spi frequency to always be about 4 bits.
> > 
> > I think DMA on imx not be ready for prime time yet.
> 
> I dropped both patches from my tree.
> 

I've had more time to test.

Without DMA, I can reload my FPGA hundreds of times and get days of
uptime using linux-next.

With DMA, loading is unreliable.  The higher the SPI speed, the less
reliable it is.  Unfortunately, it's hard to duplicate the problem with
a small amount of data, and with a large amount of data I can't examine
it in depth enough to determine if the problem is related to SPI bus
timing or IMX sDMA sending the wrong bytes to the spi controller.

Using DMA with SPI causes kernel panics.  Not always immediately, but
after using DMA it's a smaller of minutes before something crashes. 
The backtraces are all over the place and don't usually point back into
SPI.  It does seem like they usually hit something has allocated or is
allocating DMA memory.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
